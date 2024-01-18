Return-Path: <linux-kernel+bounces-30463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB916831F02
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6598A2874C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D282D61B;
	Thu, 18 Jan 2024 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjAD8hK9"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888922D607;
	Thu, 18 Jan 2024 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705601783; cv=none; b=WQwD8yX6U7QjKtC7iQr6PsMFpIXXnbxcA9euwJiBiNkSQ2LE27+DcTStJsQ6HZGqcWWw/tGQXVg29o1ht1+uAfdfqwoVlCdmk60pG5zmrc4ZfbWoegcWS2RT5YeKpTLRPC3dIN8MjgNk1xo/n8kXJNFmMDBFpX4HlB/VmIaTL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705601783; c=relaxed/simple;
	bh=75xyrl2Vt3b2PhHiLwfpIiTowVr6nUc6G+SBgiESLiA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=igBNhcCKDUzFPAC5Uu80tdwuAq1J+3kKqdrFy7K6+LFBIPX+lURWN7bLzdxI1zS4w/fmz1JHEXbnpBrKYiLQ3lSQsYacD8b0K5MbJG1MM/qFqmfcxqE10ecNmlAFU6mkdCL96ymCGR/uek36XkxYZfayRvmqjLTCEqSgsVv4ivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjAD8hK9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dbb003be79so469065b3a.0;
        Thu, 18 Jan 2024 10:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705601781; x=1706206581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bcx0IbP5g/OJJK6YtXAX93piFFuqRs0WI847iNZ19Q=;
        b=DjAD8hK9PQzJASjc06Q/tFPAdblbo+MyLyhZfXXeHOz6ak6vzQvdUn8KAFc1GG4/n9
         169ve/+mi1QMAClwhmtBo6psxNoNBrzKkimYIl+V6sJnHjrujSG3IWhAKVR32WkEf8Sy
         TaR6bCWVCHiT0Scqg6WciKN/TI45baKtrTN4VafxkVXatzW8MGGAnDrleJscIMr94lit
         RT7r3nIvOuiij92+Vpy4Tli5k8S/3+7VCTQgz9ojJ1pQNmCNYORAWljHmI0sSD3j5zUy
         oYNNMRlxmsdhfAx9jExtlFMHoOF1vJQjjv5pKCEYbLa/9gTe7JEJerMa7DtigzFFToVg
         n/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705601781; x=1706206581;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Bcx0IbP5g/OJJK6YtXAX93piFFuqRs0WI847iNZ19Q=;
        b=jAQD4IxYd7hu029xb0Juormbo8pJnWvFAzBRr5H90lywBHoHqH/YHW0Sl6rfH5Xyfo
         7lhrJY0WNC3IF9HpSEbFkD0FjmwJbZaELTUbFbypCI/BkdUXCx1MFs7pztWTRVID2q9a
         UaLc1o+3cjXSLWlMcw1lU51EBS6osrllgU5fokTABzPiVbTi+baUjKOeBsVmbiidYNNH
         siLvIGYKC/qAVtciNjf9LnS4uYZwRiQvKnV/DSn9D1l34bmn2trJHwuNPK6rmhfkz2hl
         4FZjtHuvQP69KtZI/ULuKMpeaZ1lASorW7CHMSIoQkRGyAvr+5aF1ukhYddvOApL6BwN
         Xm+w==
X-Gm-Message-State: AOJu0Yx4mz9bz9i/9nWv37W15n9mkV1Rn/qjRATuJg9USYr3dAHgLyuF
	4Xhrq3GDCP/Pf7WWqZZMeonvBNg4O3q5epr5ReWgLFuaPemqVSeVQfrjF7c6
X-Google-Smtp-Source: AGHT+IFabAJ6tpgBiSXr4HWkyvdoeKyIuYKRSweGoSVc2kC/p+oIBaGxjO1hlFqFr/k9dRqVBoXPmQ==
X-Received: by 2002:a17:90b:202:b0:28d:acdd:ad23 with SMTP id fy2-20020a17090b020200b0028dacddad23mr3893322pjb.9.1705601780682;
        Thu, 18 Jan 2024 10:16:20 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:f04f:73f4:b79:a70c])
        by smtp.gmail.com with ESMTPSA id qa17-20020a17090b4fd100b002902e409b77sm1509428pjb.57.2024.01.18.10.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 10:16:20 -0800 (PST)
Date: Thu, 18 Jan 2024 10:16:17 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.8-rc0
Message-ID: <Zalq8fauylyDfoXf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.8-rc0

to receive updates for the input subsystem. You will get:

- a new driver for Adafruit Seesaw gamepad device
- Zforce touchscreen will handle standard device properties for axis
  swap/inversion
- handling of advanced sensitivity settings in Microchip CAP11xx
  capacitive sensor driver
- more drivers have been converted to use newer gpiod API
- support for dedicated wakeup IRQs in gpio-keys dirver
- support for slider gestures and OTP variants in iqs269a driver
- atkbd will report keyboard version as 0xab83 in cases when GET ID
  command was skipped (to deal with problematic firmware on newer
  laptops), restoring the previous behavior
- other assorted cleanups and changes.

Changelog:
---------

Andreas Kemnade (4):
      Input: omap4-keypad - react on keypresses if device is runtime-suspended
      dt-bindings: touchscreen: convert neonode,zforce to json-schema
      dt-bindings: touchscreen: neonode,zforce: Use standard properties
      Input: zforce_ts - accept standard touchscreen properties

Anshul Dalal (4):
      dt-bindings: input: gpio-mouse: Convert to json-schema
      dt-bindings: input: convert drv266x to json-schema
      dt-bindings: input: bindings for Adafruit Seesaw Gamepad
      Input: driver for Adafruit Seesaw Gamepad

Biju Das (3):
      Input: da9063 - simplify obtaining OF match data
      Input: da9063 - drop redundant prints in probe()
      Input: da9063 - use dev_err_probe()

Christophe JAILLET (1):
      Input: xpad - remove usage of the deprecated ida_simple_xx() API

Dmitry Torokhov (2):
      Input: da9063_onkey - avoid using OF-specific APIs
      Input: da9063_onkey - avoid explicitly setting input's parent

Hans de Goede (1):
      Input: atkbd - use ab83 as id when skipping the getid command

Hermes Zhang (1):
      Input: gpio-keys - filter gpio_keys -EPROBE_DEFER error messages

Jeff LaBundy (4):
      dt-bindings: input: iqs269a: Add bindings for slider gestures
      Input: iqs269a - add support for slider gestures
      dt-bindings: input: iqs269a: Add bindings for OTP variants
      Input: iqs269a - add support for OTP variants

Jiri Valek - 2N (3):
      Input: cap11xx - remove unnecessary IRQ parsing
      dt-bindings: input: microchip,cap11xx: add advanced sensitivity settings
      Input: cap11xx - add advanced sensitivity settings

Krzysztof Kozlowski (1):
      dt-bindings: input: samsung,s6sy761: convert to DT schema

Linus Walleij (4):
      Input: navpoint - convert to use GPIO descriptor
      Input: tca6416-keypad - drop unused include
      Input: omap-keypad - drop optional GPIO support
      Input: as5011 - convert to GPIO descriptor

Marcus Folkesson (1):
      Input: pxrc - simplify mutex handling with guard macro

Marek Szyprowski (1):
      Input: max77693-haptic - add device-tree compatible strings

Mark Brown (3):
      Input: cap11xx - cache hardware ID registers
      Input: cap11xx - convert to use maple tree register cache
      Input: qt1050 - convert to use maple tree register cache

Rob Herring (2):
      dt-bindings: input: sprd,sc27xx-vibrator: Drop incomplete example
      dt-bindings: input: mediatek,pmic-keys: Drop incomplete example

Tony Lindgren (2):
      dt-bindings: input: gpio-keys: Allow optional dedicated wakeirq
      Input: gpio-keys - add system suspend support for dedicated wakeirqs

ye xingchen (7):
      Input: use sysfs_emit() instead of scnprintf()
      Input: mouse - use sysfs_emit[_at]() instead of scnprintf()
      Input: touchscreen - use sysfs_emit[_at]() instead of scnprintf()
      Input: synaptics-rmi4 - use sysfs_emit() to instead of scnprintf()
      Input: ims-pcu - use sysfs_emit() instead of scnprintf()
      Input: iqs269a - use sysfs_emit() instead of scnprintf()
      Input: vivaldi - convert to use sysfs_emit_at() API

Diffstat:
--------

 .../bindings/input/adafruit,seesaw-gamepad.yaml    |  63 ++++
 .../devicetree/bindings/input/gpio-keys.yaml       |  41 ++-
 .../devicetree/bindings/input/gpio-mouse.txt       |  32 --
 .../devicetree/bindings/input/gpio-mouse.yaml      |  68 +++++
 .../devicetree/bindings/input/iqs269a.yaml         |  98 +++++-
 .../bindings/input/mediatek,pmic-keys.yaml         |  24 +-
 .../bindings/input/microchip,cap11xx.yaml          |  80 ++++-
 .../bindings/input/sprd,sc27xx-vibrator.yaml       |  19 +-
 .../devicetree/bindings/input/ti,drv2665.txt       |  17 --
 .../devicetree/bindings/input/ti,drv2667.txt       |  17 --
 .../devicetree/bindings/input/ti,drv266x.yaml      |  50 +++
 .../bindings/input/touchscreen/neonode,zforce.yaml |  72 +++++
 .../bindings/input/touchscreen/samsung,s6sy761.txt |  32 --
 .../input/touchscreen/samsung,s6sy761.yaml         |  54 ++++
 .../bindings/input/touchscreen/zforce_ts.txt       |  34 ---
 MAINTAINERS                                        |   7 +
 drivers/input/input.c                              |   8 +-
 drivers/input/joystick/Kconfig                     |  10 +
 drivers/input/joystick/Makefile                    |   1 +
 drivers/input/joystick/adafruit-seesaw.c           | 315 +++++++++++++++++++
 drivers/input/joystick/as5011.c                    |  24 +-
 drivers/input/joystick/pxrc.c                      |  42 ++-
 drivers/input/joystick/xpad.c                      |   6 +-
 drivers/input/keyboard/atkbd.c                     |  12 +-
 drivers/input/keyboard/cap11xx.c                   | 253 ++++++++++++----
 drivers/input/keyboard/gpio_keys.c                 |  75 ++++-
 drivers/input/keyboard/omap-keypad.c               |  19 +-
 drivers/input/keyboard/omap4-keypad.c              |  15 +-
 drivers/input/keyboard/qt1050.c                    |   2 +-
 drivers/input/keyboard/tca6416-keypad.c            |   1 -
 drivers/input/misc/da9063_onkey.c                  |  69 ++---
 drivers/input/misc/ims-pcu.c                       |  10 +-
 drivers/input/misc/iqs269a.c                       | 335 ++++++++++++++++++---
 drivers/input/misc/max77693-haptic.c               |  14 +-
 drivers/input/mouse/cyapa.c                        |  22 +-
 drivers/input/mouse/cyapa_gen3.c                   |   2 +-
 drivers/input/mouse/cyapa_gen5.c                   |   4 +-
 drivers/input/mouse/cyapa_gen6.c                   |  20 +-
 drivers/input/mouse/elan_i2c_core.c                |  18 +-
 drivers/input/mouse/navpoint.c                     |  41 +--
 drivers/input/rmi4/rmi_f01.c                       |  13 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |  21 +-
 drivers/input/touchscreen/edt-ft5x06.c             |   2 +-
 drivers/input/touchscreen/hideep.c                 |   6 +-
 drivers/input/touchscreen/hycon-hy46xx.c           |   2 +-
 drivers/input/touchscreen/ilitek_ts_i2c.c          |  16 +-
 drivers/input/touchscreen/iqs5xx.c                 |  12 +-
 drivers/input/touchscreen/iqs7211.c                |  12 +-
 drivers/input/touchscreen/melfas_mip4.c            |  16 +-
 drivers/input/touchscreen/usbtouchscreen.c         |   4 +-
 drivers/input/touchscreen/wdt87xx_i2c.c            |   6 +-
 drivers/input/touchscreen/zforce_ts.c              |  34 +--
 drivers/input/vivaldi-fmap.c                       |   6 +-
 include/linux/gpio_keys.h                          |   2 +
 include/linux/input/as5011.h                       |   1 -
 include/linux/input/navpoint.h                     |   1 -
 include/linux/platform_data/keypad-omap.h          |   3 -
 57 files changed, 1633 insertions(+), 550 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/gpio-mouse.txt
 create mode 100644 Documentation/devicetree/bindings/input/gpio-mouse.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/ti,drv2665.txt
 delete mode 100644 Documentation/devicetree/bindings/input/ti,drv2667.txt
 create mode 100644 Documentation/devicetree/bindings/input/ti,drv266x.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt
 create mode 100644 drivers/input/joystick/adafruit-seesaw.c

Thanks.


-- 
Dmitry

