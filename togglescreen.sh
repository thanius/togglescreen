#!/bin/bash

echo -e "togglescreen version 1.0\nToggle monitors on and off easily\n"

case $1 in
  -t)
    if [[ $(xrandr|grep -P "$2 connected (primary\s)?[0-9]{4}x[0-9]{4}\+[0-9]{1,4}\+[0.9]{1,4}") && -z "$3" ]]; then
      echo "$2 is enabled, turning off..."
      xrandr --output $2 --off
    else
      echo "Turning on $2..."
      xrandr --output $2 --auto $(if [[ "$3" == "left" || "$3" == "right" ]]; then echo "--$3-of $(xrandr|grep primary|cut -d' ' -f1)"; fi)
    fi
  ;;

  -l)
    echo "Connected monitors:"
    xrandr|grep -P "\sconnected"|cut -d" " -f1
  ;;

  *|"")
    echo -e "USAGE:\n $0 -t [MONITOR] (left|right) - toggle on/off MONITOR (left or right of primary, default mirror)\n $0 -l - List physically connected monitors"
  ;;
esac
