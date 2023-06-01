#!/bin/bash

STM32FLASH="/usr/bin/stm32flash"
FW_FILENAME="/usr/local/bin/mmdvm_hs_dual_hat_fw_152.bin"

# Stop MMDVMHost process to free serial port
sudo killall MMDVMHost >/dev/null 2>&1

io20=20
io21=21

if [[ $(platformDetect.sh) == "Odroid-C4" ]]; then
  io20=491
  io21=490
fi

if [[ $(platformDetect.sh) == "Odroid-C2" ]]; then
  io20=219
  io21=228
fi

/usr/local/sbin/pistar-watchdog.service stop
/usr/local/sbin/mmdvmhost.service stop

echo "Starting ... if boot0 is low!..."

# Upload the firmware
eval sudo $STM32FLASH -v -w $FW_FILENAME -g 0x0 -R -i $io20,-$io21,$io21:-$io20,$io21 /dev/ttyAMA0

