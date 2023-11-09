Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F617E65D1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjKII4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjKII4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:56:49 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF40E18C;
        Thu,  9 Nov 2023 00:56:46 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so517768a12.3;
        Thu, 09 Nov 2023 00:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699520206; x=1700125006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDLgNugE0c+yztBBF8zbtCz4wwlRM6dod3FpN94iGlU=;
        b=FyxIsMD9f0TsKuTsaL4ylX2cJARHXVJRS8hG8Teo89VfxlOYGEbNB68neWPL56dlPQ
         6EZ6urMcD16RxfuCgJGrBloLl7PCD5GdT/UL9XxzuoaQ/7coOAVzcjzYp4pyhUTdV1Gv
         ba+0l/Hw3/tA6PA/4xCQ5iDrKJ415czlxxBahts6GnRzto0gxroy1tk6W9eueO9dVdQ4
         P166utnztjKbtxa7Z9xRg2XEE0SU8ka7xoib/8qDNA+SSV9OukdMec7gsFUaNnxwQJx4
         879RfDdAPpytX6Hl6aRvmWaE5cMIQ1zRy8j0LuHGe+b39ZlNEF3jUsyYf63NvMGg4Dci
         kNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520206; x=1700125006;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDLgNugE0c+yztBBF8zbtCz4wwlRM6dod3FpN94iGlU=;
        b=knpcsWSnS6OyAPKtzsSpEKLxKzdFkSk6Ajw/zQfwzV2PxzUH3YZBs4OuI7DL7yKpfV
         QKD4HjNbZ96LQN4gsH0W0B6qe9rxu0VfHzRfoxNxxzqEv0rcWjLgLuT44x3/jc4MM+vT
         OchYMr28YYa7bCNyOZ0BYIcUSgpoB+C0heroavapbIIr3h6Z3NK5mokfm+JCCeHq8ycU
         VMkY694D57G8tFz8CaH1Yb27QxmF/s4puSMCZtAHVsMekIpHP3nOoq0k7BKbW2h9rT8f
         6uKu6ya5JaNvGRyfb7wKkuvfGaxm2Ua/qE3bvCLcmSv5d3dtop/oXSmr358PY/ymeSWZ
         8f9g==
X-Gm-Message-State: AOJu0YzxOjXJgvA4PF0JK+NduOPfn0zCSVVKBRzVi/Z3BVDsoQLJGNqf
        L5etaFkp6Exe5evSa0CBaRE=
X-Google-Smtp-Source: AGHT+IHcQugFvLtnFl9wt8y75QyVX89mYEcdnJqy7AnJbVNPztfs5rwjKG6DJUGQTx33I1VObs4QBg==
X-Received: by 2002:a17:90a:e7cf:b0:280:1729:b3e6 with SMTP id kb15-20020a17090ae7cf00b002801729b3e6mr1025727pjb.10.1699520206106;
        Thu, 09 Nov 2023 00:56:46 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:c99d:e08e:5968:1b85])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ab88700b00280cd4fbd83sm805627pjr.55.2023.11.09.00.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 00:56:45 -0800 (PST)
Date:   Thu, 9 Nov 2023 00:56:43 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.7-rc0
Message-ID: <ZUyey2l2Cfri8715@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.7-rc0

to receive updates for the input subsystem. You will get:

- a number of input drivers has been converted to use facilities provided
  by the device core to instantiate driver-specific attributes instead of
  using devm_device_add_group() and similar APIs

- platform input devices have been converted to use remove() callback
  returning void

- a fix for use-after-free when tearing down a Synaptics RMI device

- a few flexible arrays in input structures have been annotated with
  __counted_by to help hardening efforts

- handling of vddio supply in cyttsp5 driver

- other miscellaneous fixups

Changelog:
---------

Dan Carpenter (1):
      Input: synaptics-rmi4 - fix use after free in rmi_unregister_function()

Dmitry Torokhov (22):
      Input: cros_ec_keyb - use device core to create driver-specific device attributes
      Input: cyapa - use device core to create driver-specific device attributes
      Input: iqs269a - use device core to create driver-specific device attributes
      Input: kxtj9 - use device core to create driver-specific device attributes
      Input: ad7877 - use device core to create driver-specific device attributes
      Input: ad7879 - use device core to create driver-specific device attributes
      Input: ads7846 - use device core to create driver-specific device attributes
      Input: edt-ft5x06 - use device core to create driver-specific device attributes
      Input: elants_i2c - use device core to create driver-specific device attributes
      Input: exc3000 - use device core to create driver-specific device attributes
      Input: hideep - use device core to create driver-specific device attributes
      Input: hycon-hy46xx - use device core to create driver-specific device attributes
      Input: ili210x - use device core to create driver-specific device attributes
      Input: ilitek_ts_i2c - use device core to create driver-specific device attributes
      Input: iqs5xx - use device core to create driver-specific device attributes
      Input: melfas-mip4 - use device core to create driver-specific device attributes
      Input: raydium_i2c_ts - use device core to create driver-specific device attributes
      Input: rohm_bu21023 - use device core to create driver-specific device attributes
      Input: s6sy761 - use device core to create driver-specific device attributes
      Input: stmfts - use device core to create driver-specific device attributes
      Input: tsc2004/5 - use device core to create driver-specific device attributes
      Input: wdt87xx_i2c - use device core to create driver-specific device attributes

Fabio Estevam (1):
      dt-bindings: input: fsl,scu-key: Document wakeup-source

Justin Stitt (2):
      Input: synaptics-rmi4 - replace deprecated strncpy
      Input: axp20x-pek - avoid needless newline removal

Kees Cook (4):
      Input: evdev - annotate struct evdev_client with __counted_by
      Input: leds - annotate struct input_leds with __counted_by
      Input: mt - annotate struct input_mt with __counted_by
      Input: Annotate struct ff_device with __counted_by

Li Zetao (1):
      Input: walkera0701 - use module_parport_driver macro to simplify the code

Lin, Meng-Bo (2):
      dt-bindings: input: cyttsp5: document vddio-supply
      Input: cyttsp5 - add handling for vddio regulator

Rob Herring (1):
      Input: tegra-kbc - use device_get_match_data()

Uwe Kleine-König (52):
      Input: adp5520-keys - convert to platform remove callback returning void
      Input: cros_ec_keyb - convert to platform remove callback returning void
      Input: ep93xx_keypad - convert to platform remove callback returning void
      Input: iqs62x-keys - convert to platform remove callback returning void
      Input: matrix_keypad - convert to platform remove callback returning void
      Input: omap-keypad - convert to platform remove callback returning void
      Input: omap4-keypad - convert to platform remove callback returning void
      Input: samsung-keypad - convert to platform remove callback returning void
      Input: sh_keysc - convert to platform remove callback returning void
      Input: spear-keyboard - convert to platform remove callback returning void
      Input: stmpe-keypad - convert to platform remove callback returning void
      Input: 88pm80x_onkey - convert to platform remove callback returning void
      Input: da9052_onkey - convert to platform remove callback returning void
      Input: da9055_onkey - convert to platform remove callback returning void
      Input: ideapad_slidebar - convert to platform remove callback returning void
      Input: m68kspkr - convert to platform remove callback returning void
      Input: max8997_haptic - convert to platform remove callback returning void
      Input: mc13783-pwrbutton - convert to platform remove callback returning void
      Input: palmas-pwrbutton - convert to platform remove callback returning void
      Input: pcap_keys - convert to platform remove callback returning void
      Input: pcf50633-input - convert to platform remove callback returning void
      Input: pcspkr - convert to platform remove callback returning void
      Input: pm8941-pwrkey - convert to platform remove callback returning void
      Input: soc_button_array - convert to platform remove callback returning void
      Input: sparcspkr - convert to platform remove callback returning void
      Input: wistron_btns - convert to platform remove callback returning void
      Input: wm831x-on - convert to platform remove callback returning void
      Input: navpoint - convert to platform remove callback returning void
      Input: altera_ps2 - convert to platform remove callback returning void
      Input: ams_delta_serio - convert to platform remove callback returning void
      Input: apbps2 - convert to platform remove callback returning void
      Input: arc_ps2 - convert to platform remove callback returning void
      Input: ct82c710 - convert to platform remove callback returning void
      Input: i8042-sparcio - convert to platform remove callback returning void
      Input: i8042 - convert to platform remove callback returning void
      Input: ioc3kbd - convert to platform remove callback returning void
      Input: maceps2 - convert to platform remove callback returning void
      Input: olpc_apsp - convert to platform remove callback returning void
      Input: ps2-gpio - convert to platform remove callback returning void
      Input: q40kbd - convert to platform remove callback returning void
      Input: rpckbd - convert to platform remove callback returning void
      Input: sun4i-ps2 - convert to platform remove callback returning void
      Input: xilinx_ps2 - convert to platform remove callback returning void
      Input: da9052_tsi - convert to platform remove callback returning void
      Input: mainstone-wm97xx - convert to platform remove callback returning void
      Input: mc13783_ts - convert to platform remove callback returning void
      Input: pcap_ts - convert to platform remove callback returning void
      Input: stmpe-ts - convert to platform remove callback returning void
      Input: sun4i-ts - convert to platform remove callback returning void
      Input: ti_am335x_tsc - convert to platform remove callback returning void
      Input: wm831x-ts - convert to platform remove callback returning void
      Input: wm97xx-core - convert to platform remove callback returning void

Diffstat:
--------

 .../devicetree/bindings/input/fsl,scu-key.yaml     |  2 ++
 .../input/touchscreen/cypress,tt21000.yaml         |  3 +++
 drivers/input/evdev.c                              |  2 +-
 drivers/input/input-leds.c                         |  2 +-
 drivers/input/joystick/walkera0701.c               | 13 +---------
 drivers/input/keyboard/adp5520-keys.c              |  6 ++---
 drivers/input/keyboard/cros_ec_keyb.c              | 16 ++++--------
 drivers/input/keyboard/ep93xx_keypad.c             |  6 ++---
 drivers/input/keyboard/iqs62x-keys.c               |  6 ++---
 drivers/input/keyboard/matrix_keypad.c             |  6 ++---
 drivers/input/keyboard/omap-keypad.c               |  6 ++---
 drivers/input/keyboard/omap4-keypad.c              |  6 ++---
 drivers/input/keyboard/samsung-keypad.c            |  6 ++---
 drivers/input/keyboard/sh_keysc.c                  |  6 ++---
 drivers/input/keyboard/spear-keyboard.c            |  6 ++---
 drivers/input/keyboard/stmpe-keypad.c              |  6 ++---
 drivers/input/keyboard/tegra-kbc.c                 |  7 ++----
 drivers/input/misc/88pm80x_onkey.c                 |  5 ++--
 drivers/input/misc/axp20x-pek.c                    | 11 +-------
 drivers/input/misc/da9052_onkey.c                  |  6 ++---
 drivers/input/misc/da9055_onkey.c                  |  6 ++---
 drivers/input/misc/ideapad_slidebar.c              |  6 ++---
 drivers/input/misc/iqs269a.c                       | 10 ++------
 drivers/input/misc/kxtj9.c                         | 29 +++++++++++++---------
 drivers/input/misc/m68kspkr.c                      |  6 ++---
 drivers/input/misc/max8997_haptic.c                |  6 ++---
 drivers/input/misc/mc13783-pwrbutton.c             |  6 ++---
 drivers/input/misc/palmas-pwrbutton.c              |  6 ++---
 drivers/input/misc/pcap_keys.c                     |  6 ++---
 drivers/input/misc/pcf50633-input.c                |  6 ++---
 drivers/input/misc/pcspkr.c                        |  6 ++---
 drivers/input/misc/pm8941-pwrkey.c                 |  6 ++---
 drivers/input/misc/soc_button_array.c              |  6 ++---
 drivers/input/misc/sparcspkr.c                     | 12 +++------
 drivers/input/misc/wistron_btns.c                  |  6 ++---
 drivers/input/misc/wm831x-on.c                     |  6 ++---
 drivers/input/mouse/cyapa.c                        | 14 +++--------
 drivers/input/mouse/navpoint.c                     |  6 ++---
 drivers/input/rmi4/rmi_bus.c                       |  2 +-
 drivers/input/rmi4/rmi_f34.c                       |  2 +-
 drivers/input/serio/altera_ps2.c                   |  6 ++---
 drivers/input/serio/ams_delta_serio.c              |  6 ++---
 drivers/input/serio/apbps2.c                       |  6 ++---
 drivers/input/serio/arc_ps2.c                      |  6 ++---
 drivers/input/serio/ct82c710.c                     |  6 ++---
 drivers/input/serio/i8042-sparcio.h                |  6 ++---
 drivers/input/serio/i8042.c                        |  6 ++---
 drivers/input/serio/ioc3kbd.c                      |  6 ++---
 drivers/input/serio/maceps2.c                      |  6 ++---
 drivers/input/serio/olpc_apsp.c                    |  6 ++---
 drivers/input/serio/ps2-gpio.c                     |  5 ++--
 drivers/input/serio/q40kbd.c                       |  6 ++---
 drivers/input/serio/rpckbd.c                       |  6 ++---
 drivers/input/serio/sun4i-ps2.c                    |  6 ++---
 drivers/input/serio/xilinx_ps2.c                   |  6 ++---
 drivers/input/touchscreen/ad7877.c                 | 12 ++++-----
 drivers/input/touchscreen/ad7879-i2c.c             |  7 +++---
 drivers/input/touchscreen/ad7879-spi.c             |  7 +++---
 drivers/input/touchscreen/ad7879.c                 | 10 +++++---
 drivers/input/touchscreen/ad7879.h                 |  3 +++
 drivers/input/touchscreen/ads7846.c                | 18 +++++---------
 drivers/input/touchscreen/cyttsp5.c                | 19 ++++++++------
 drivers/input/touchscreen/da9052_tsi.c             |  6 ++---
 drivers/input/touchscreen/edt-ft5x06.c             | 10 ++------
 drivers/input/touchscreen/elants_i2c.c             | 15 +++--------
 drivers/input/touchscreen/exc3000.c                | 12 +++------
 drivers/input/touchscreen/hideep.c                 | 15 +++--------
 drivers/input/touchscreen/hycon-hy46xx.c           | 10 ++------
 drivers/input/touchscreen/ili210x.c                | 15 ++++-------
 drivers/input/touchscreen/ilitek_ts_i2c.c          | 12 ++-------
 drivers/input/touchscreen/iqs5xx.c                 | 10 +++-----
 drivers/input/touchscreen/mainstone-wm97xx.c       |  6 ++---
 drivers/input/touchscreen/mc13783_ts.c             |  6 ++---
 drivers/input/touchscreen/melfas_mip4.c            | 13 ++--------
 drivers/input/touchscreen/pcap_ts.c                |  6 ++---
 drivers/input/touchscreen/raydium_i2c_ts.c         | 16 +++---------
 drivers/input/touchscreen/rohm_bu21023.c           | 12 ++-------
 drivers/input/touchscreen/s6sy761.c                | 10 ++------
 drivers/input/touchscreen/stmfts.c                 | 10 ++------
 drivers/input/touchscreen/stmpe-ts.c               |  6 ++---
 drivers/input/touchscreen/sun4i-ts.c               |  6 ++---
 drivers/input/touchscreen/ti_am335x_tsc.c          |  5 ++--
 drivers/input/touchscreen/tsc2004.c                |  7 +++---
 drivers/input/touchscreen/tsc2005.c                |  7 +++---
 drivers/input/touchscreen/tsc200x-core.c           | 18 ++++++--------
 drivers/input/touchscreen/tsc200x-core.h           |  1 +
 drivers/input/touchscreen/wdt87xx_i2c.c            | 16 +++---------
 drivers/input/touchscreen/wm831x-ts.c              |  6 ++---
 drivers/input/touchscreen/wm97xx-core.c            |  6 ++---
 include/linux/input.h                              |  2 +-
 include/linux/input/mt.h                           |  2 +-
 91 files changed, 240 insertions(+), 471 deletions(-)

Thanks.


-- 
Dmitry
