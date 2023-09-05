Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5949E793047
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbjIEUsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjIEUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:48:07 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C06119B;
        Tue,  5 Sep 2023 13:48:02 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5657add1073so194735a12.0;
        Tue, 05 Sep 2023 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693946881; x=1694551681; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rrVGUcEA6NpuC4fzwxuqTsqb0Vk1kC+uEivkHyrol9g=;
        b=f1cL0kfc1aOXejhIm8rJbUyaeugbd9BN/U4znz+fXTER5TfLb1DWno8NzK6+uprzd5
         rF5jJmsNk7wls2azd/Gjjn19jyqmEC6fM3/3CljxFwEFzZU/5ZooaN7RegUdm8m1bdv+
         PSA3pAaC1vUOEK8AG2yPyTrQ0OlGPo7z5SL1PNVtNzVTDo3bzb5BVkL+JimuKxusUsza
         JIZIY1KCKChG2YE9BkGQifCaUYa9dNtE2rKfycu6qjk3ysr9yPZy9jS7F2BiqdYSazav
         qktrh0kyIPFiJxgZWv9lHsuDm+rSnlZrBIEBW6KQFtBAOq8vZWk/eUdZfmZOCER9Yhfz
         /EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693946881; x=1694551681;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrVGUcEA6NpuC4fzwxuqTsqb0Vk1kC+uEivkHyrol9g=;
        b=CwzbX/+q7QUMJtmjbgdqddzLgVMUk74EBMu9M11TjsiODsvbEIbXSYp7n9eIXznGew
         Mb2qfDI2TDDCIEogfqk/xs/qNZSHF2zkX6u0kR8Ypj5T51zXxh6E+6aQqHK9lBzI0QwK
         wSRqXhy1w/5YPgQPKdYBfgz8KQRk/zfMROzu0nc6csPtWhP3EKB1SuvN58/3fURDei84
         3zpARLk3KgJPF0pf3PLsFK+B4id0EUHAbslSafXgYrH2zUMM8A/0S0/b49JSMJqB8hb6
         Fq5rUd/XkdoUyB6DUFEL5CF2azQAHJDg8SP/MCz6M159JUld4h6LAErEQNmJam6QYKqj
         7Ssw==
X-Gm-Message-State: AOJu0Yyn0wRYBEnKavL8zz0Qzx2p8KYa4Bf+dVAtG7GwowcmXBednxUY
        6pXqH5kezb4Zbe2KqJRhrYel8JRGmZo=
X-Google-Smtp-Source: AGHT+IG2LtnFU5XKZXWx8VrzXUrlUlQ2ee0AtO3kzswkAwJVIelyii0wJSjjfE5vNtJ7ZAdQfSc8Ow==
X-Received: by 2002:a05:6a20:158b:b0:126:8b2d:4462 with SMTP id h11-20020a056a20158b00b001268b2d4462mr16343547pzj.24.1693946881365;
        Tue, 05 Sep 2023 13:48:01 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:86df:1d03:234b:eb80])
        by smtp.gmail.com with ESMTPSA id m185-20020a633fc2000000b005642314f05fsm9778960pga.1.2023.09.05.13.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 13:48:00 -0700 (PDT)
Date:   Tue, 5 Sep 2023 13:47:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.6-rc0
Message-ID: <ZPeTYcsVQ7/M4Bue@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.6-rc0

to receive updates for the input subsystem. You will get:

- a new driver for Azoteq IQS7210A/7211A/E touch controllers
- support for Azoteq IQS7222D variant added to iqs7222 driver
- support for touch keys functionality added to Melfas MMS114 driver
- new hardware IDs added to exc3000 and Goodix drivers
- xpad driver gained support for GameSir T4 Kaleid Controller
- a fix for xpad driver to properly support some third-party
  controllers that need a magic packet to start properly
- a fix for psmouse driver to more reliably switch to RMI4 mode
  on devices that use native RMI4/SMbus protocol
- a quirk for i8042 for TUXEDO Gemini 17 Gen1/Clevo PD70PN laptops

Also a number of drivers have been updated to make use of devm APIs
as well as other newer APIs such as dev_err_probe(),
devm_regulator_get_enable(), and others.


Changelog:
---------

Andreas Helbech Kleist (1):
      Input: exc3000 - add ACPI support for EXC80H60

Artur Weber (2):
      dt-bindings: mms114: Add linux,keycodes property for touch keys
      Input: mms114 - add support for touch keys

Christophe JAILLET (2):
      Input: pinephone-keyboard - use devm_regulator_get_enable()
      Input: adp5588-keys - use devm_regulator_get_enable()

Dmitry Torokhov (9):
      Input: gameport - use IS_REACHABLE() instead of open-coding it
      Input: qt2160 - tweak check for i2c adapter functionality
      Input: qt2160 - switch to using threaded interrupt handler
      Input: qt2160 - do not hard code interrupt trigger
      Input: lm8323 - rely on device core to create kp_disable attribute
      Input: tca6416-keypad - always expect proper IRQ number in i2c client
      Input: tca6416-keypad - rely on I2C core to set up suspend/resume
      Input: tca6416-keypad - fix interrupt enable disbalance
      Input: tca6416-keypad - switch to using input core's polling features

Felix Engelhardt (1):
      Input: goodix - add support for ACPI ID GDX9110

Geert Uytterhoeven (1):
      Input: gpio-keys - convert to dev_err_probe()

Hans de Goede (2):
      Input: novatek-nvt-ts - fix input_register_device() failure error message
      Input: novatek-nvt-ts - add touchscreen model number to description

Jeff LaBundy (7):
      Input: iqs7222 - configure power mode before triggering ATI
      dt-bindings: input: iqs7222: Define units for slider properties
      dt-bindings: input: iqs7222: Add properties for Azoteq IQS7222D
      Input: iqs7222 - add support for Azoteq IQS7222D
      dt-bindings: input: Add bindings for Azoteq IQS7210A/7211A/E
      Input: add support for Azoteq IQS7210A/7211A/E
      Input: iqs7211 - point to match data directly

Jeffery Miller (1):
      Input: psmouse - add delay when deactivating for SMBus mode

Jonathan Frederick (1):
      Input: xpad - add GameSir T4 Kaleid Controller support

Krzysztof Kozlowski (25):
      Input: gpio_keys_polled - simplify with dev_err_probe()
      Input: gpio-vibra - simplify with dev_err_probe()
      Input: pwm-vibra - simplify with dev_err_probe()
      Input: rotary_encoder - simplify with dev_err_probe()
      Input: elan_i2c - simplify with dev_err_probe()
      Input: bu21013_ts - simplify with dev_err_probe()
      Input: bu21029_ts - simplify with dev_err_probe()
      Input: chipone_icn8318 - simplify with dev_err_probe()
      Input: cy8ctma140 - simplify with dev_err_probe()
      Input: edf-ft5x06 - simplify with dev_err_probe()
      Input: ektf2127 - simplify with dev_err_probe()
      Input: elants_i2c - simplify with dev_err_probe()
      Input: goodix - simplify with dev_err_probe()
      Input: melfas_mip4 - simplify with dev_err_probe()
      Input: pixcir_i2c_ts - simplify with dev_err_probe()
      Input: raydium_i2c_ts - simplify with dev_err_probe()
      Input: resistive-adc-touch - simplify with dev_err_probe()
      rInputrrrrrrr - simplify with dev_err_probe()
      Input: sis_i2c - simplify with dev_err_probe()
      Input: surface3_spi - simplify with dev_err_probe()
      Input: sx8643 - simplify with dev_err_probe()
      Input: bcm-keypad - simplify with dev_err_probe()
      Input: bu21013_ts - use local 'client->dev' variable in probe()
      Input: bu21029_ts - use local 'client->dev' variable in probe()
      Input: bcm-keypad - correct dev_err_probe() error

Martin Kaiser (1):
      Input: tegra-kbc - use devm_platform_ioremap_resource

Mike Looijmans (2):
      dt-bindings: input: exc3000: support power supply regulators
      Input: exc3000 - support power supply regulators

Nathan Chancellor (1):
      Input: mcs-touchkey - fix uninitialized use of error in mcs_touchkey_probe()

Niklas Schnelle (1):
      Input: gameport - add ISA and HAS_IOPORT dependencies

Oleksij Rempel (1):
      dt-bindings: input: touchscreen: edt-ft5x06: Add 'threshold' property

Randy Dunlap (1):
      Input: cpcap-pwrbutton - remove initial kernel-doc notation

Rob Herring (1):
      Input: Explicitly include correct DT includes

Roi L (1):
      Input: rotary_encoder - don't double assign input->dev.parent

Ruan Jinjie (1):
      Input: rpckbd - fix the return value handle for platform_get_irq()

Sam Lantinga (1):
      Input: xpad - add GameSir VID for Xbox One controllers

Samuel Holland (1):
      Input: da9063 - add wakeup support

Sebastian Reichel (1):
      Input: cpcap-pwrbutton - replace GPLv2 boilerplate with SPDX

Vicki Pfau (1):
      Input: xpad - fix support for some third-party controllers

Werner Sembach (1):
      Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo PD70PN

Yangtao Li (16):
      Input: bcm-keypad - convert to devm_platform_ioremap_resource()
      Input: lpc32xx-keys - convert to devm_platform_ioremap_resource()
      Input: nspire-keypad - use devm_platform_get_and_ioremap_resource()
      Input: omap4-keyad - convert to devm_platform_ioremap_resource()
      Input: opencores-kbd - convert to devm_platform_ioremap_resource()
      Input: pxa27x_keypad - convert to devm_platform_ioremap_resource()
      Input: sun4i-lradc-keys - convert to devm_platform_ioremap_resource()
      Input: nomadik-ske-keypad - convert to use devm_* api
      Input: lpc32xx_ts - convert to use devm_* api
      Input: lm8333 - convert to use devm_* api
      Input: amikbd - convert to use devm_* api
      Input: mcs-touchkey - convert to use devm_* api
      Input: qt1070 - convert to use devm_* api
      Input: qt2160 - convert to use devm_* api
      Input: lm8323 - convert to use devm_* api
      Input: tca6416-keypad - convert to use devm_* api

Diffstat:
--------

 .../devicetree/bindings/input/azoteq,iqs7222.yaml  |  248 +-
 .../bindings/input/touchscreen/azoteq,iqs7211.yaml |  769 ++++++
 .../bindings/input/touchscreen/edt-ft5x06.yaml     |    6 +
 .../bindings/input/touchscreen/eeti,exc3000.yaml   |    2 +
 .../bindings/input/touchscreen/melfas,mms114.yaml  |    5 +
 drivers/input/gameport/Kconfig                     |    4 +-
 drivers/input/gameport/gameport.c                  |   26 +-
 drivers/input/joystick/xpad.c                      |   25 +
 drivers/input/keyboard/adp5588-keys.c              |   17 +-
 drivers/input/keyboard/amikbd.c                    |   25 +-
 drivers/input/keyboard/bcm-keypad.c                |   24 +-
 drivers/input/keyboard/gpio_keys.c                 |   21 +-
 drivers/input/keyboard/gpio_keys_polled.c          |    8 +-
 drivers/input/keyboard/lm8323.c                    |   95 +-
 drivers/input/keyboard/lm8333.c                    |   44 +-
 drivers/input/keyboard/lpc32xx-keys.c              |    9 +-
 drivers/input/keyboard/mcs_touchkey.c              |   65 +-
 drivers/input/keyboard/nomadik-ske-keypad.c        |  127 +-
 drivers/input/keyboard/nspire-keypad.c             |    3 +-
 drivers/input/keyboard/omap4-keypad.c              |    9 +-
 drivers/input/keyboard/opencores-kbd.c             |    9 +-
 drivers/input/keyboard/pinephone-keyboard.c        |   20 +-
 drivers/input/keyboard/pxa27x_keypad.c             |    9 +-
 drivers/input/keyboard/qt1070.c                    |   46 +-
 drivers/input/keyboard/qt2160.c                    |  130 +-
 drivers/input/keyboard/sun4i-lradc-keys.c          |    6 +-
 drivers/input/keyboard/tca6416-keypad.c            |  141 +-
 drivers/input/keyboard/tegra-kbc.c                 |    2 +-
 drivers/input/keyboard/tm2-touchkey.c              |    1 -
 drivers/input/misc/Kconfig                         |    4 +-
 drivers/input/misc/cpcap-pwrbutton.c               |   12 +-
 drivers/input/misc/da9063_onkey.c                  |    9 +
 drivers/input/misc/gpio-vibra.c                    |   22 +-
 drivers/input/misc/iqs269a.c                       |    2 +-
 drivers/input/misc/iqs626a.c                       |    2 +-
 drivers/input/misc/iqs7222.c                       |  478 +++-
 drivers/input/misc/mma8450.c                       |    2 +-
 drivers/input/misc/pm8941-pwrkey.c                 |    1 -
 drivers/input/misc/pm8xxx-vibrator.c               |    1 -
 drivers/input/misc/pmic8xxx-pwrkey.c               |    1 -
 drivers/input/misc/pwm-beeper.c                    |   19 +-
 drivers/input/misc/pwm-vibra.c                     |   32 +-
 drivers/input/misc/rotary_encoder.c                |    9 +-
 drivers/input/misc/sparcspkr.c                     |    3 +-
 drivers/input/mouse/elan_i2c_core.c                |    9 +-
 drivers/input/mouse/psmouse-smbus.c                |   19 +-
 drivers/input/serio/apbps2.c                       |    2 +-
 drivers/input/serio/i8042-acpipnpio.h              |    7 +
 drivers/input/serio/i8042-sparcio.h                |    4 +-
 drivers/input/serio/rpckbd.c                       |    8 +-
 drivers/input/serio/xilinx_ps2.c                   |    4 +-
 drivers/input/touchscreen/Kconfig                  |   14 +-
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/bu21013_ts.c             |   72 +-
 drivers/input/touchscreen/bu21029_ts.c             |   51 +-
 drivers/input/touchscreen/chipone_icn8318.c        |    8 +-
 drivers/input/touchscreen/cy8ctma140.c             |    8 +-
 drivers/input/touchscreen/cyttsp5.c                |    2 +-
 drivers/input/touchscreen/edt-ft5x06.c             |   10 +-
 drivers/input/touchscreen/ektf2127.c               |    8 +-
 drivers/input/touchscreen/elants_i2c.c             |   22 +-
 drivers/input/touchscreen/exc3000.c                |   17 +
 drivers/input/touchscreen/goodix.c                 |   41 +-
 drivers/input/touchscreen/ili210x.c                |    2 +-
 drivers/input/touchscreen/iqs5xx.c                 |    2 +-
 drivers/input/touchscreen/iqs7211.c                | 2557 ++++++++++++++++++++
 drivers/input/touchscreen/lpc32xx_ts.c             |   98 +-
 drivers/input/touchscreen/melfas_mip4.c            |    9 +-
 drivers/input/touchscreen/mms114.c                 |   89 +-
 drivers/input/touchscreen/novatek-nvt-ts.c         |   10 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c          |   40 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         |   30 +-
 drivers/input/touchscreen/resistive-adc-touch.c    |    8 +-
 drivers/input/touchscreen/silead.c                 |    8 +-
 drivers/input/touchscreen/sis_i2c.c                |   20 +-
 drivers/input/touchscreen/surface3_spi.c           |   13 +-
 drivers/input/touchscreen/sx8654.c                 |   10 +-
 drivers/input/touchscreen/ti_am335x_tsc.c          |    1 -
 include/linux/gameport.h                           |    2 +-
 include/linux/tca6416_keypad.h                     |    1 -
 80 files changed, 4644 insertions(+), 1056 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/azoteq,iqs7211.yaml
 create mode 100644 drivers/input/touchscreen/iqs7211.c

Thanks.

-- 
Dmitry
