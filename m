Return-Path: <linux-kernel+bounces-21285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E44D1828D0F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC281F26ED7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272243D0B0;
	Tue,  9 Jan 2024 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="H0LC0X38"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0894D3D0A0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e4d1e0e5eso12641885e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704827117; x=1705431917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zhF4jyFgcyCg0O1jhyIaL8gFGwc/DO+6T7JgJQErQjk=;
        b=H0LC0X38aD5Wgjm3DxGq7jYUKpgnEHrdIaB9M9TwLUncqbcDGXV+V9k+5Jhuum2qT9
         o//MwsLZs0US/2IZ9kvCReR2SGLBCc3fDnMMWlJbEnCISOjplhX5t1q8vZzrszqMw80Z
         LqdtKM5ElmpjqYDVtmfqNv7jpVBDabirVgHn4zd7c2LeTHj/0DT6NIlzx+5Dpyec3rHp
         MDNOjT8SNIGq/SXNffXFByWpZdvmrQ0xOBBHDBpjYimV1C7Ga3m/4XwdhRpIaXCgDHBq
         gFLx9GZnerGoJEQlvLUrZsQEAIb3WOCY/USIaTb+Ow1YlxfFLYqfOO85/w8vhY+fD/Vx
         AyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704827117; x=1705431917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhF4jyFgcyCg0O1jhyIaL8gFGwc/DO+6T7JgJQErQjk=;
        b=tSPOARKvKyHRTo6p4hvYuCOZstleyK3VyKY2PNUChz7hw2SQ77/yg5sQyW1QY/Swjd
         BCpMzgZuWai9BQ6ZohQ7l8QQhEp05c/m17fPULQewMkLFy6RUqoxokPmDkB2FhISN2bx
         A1Bornr7ooak2PfiaHzmh0MZEpyz4S+ogjRsxPIxiTHi1462IV/SWBvWlSno8Q21PAva
         eNWuke9rcd/+sx/tRBAZkarwbF9qSiMzMasjkcRTCXj/HDFNWxorJP9GZkQZq2aL+G74
         YO6d5GRlqRHg+j2Ns8L4qhxhE7mJoSCbB+7/1WL0MKZsxjvoVeL7x1F7LXBeW2FioIuM
         yruQ==
X-Gm-Message-State: AOJu0Ywlm4G1BipvvHJd4Kks0mF7jguXaVF5IURlcOlnKul+EDHhmZgh
	22OrdaiW/o0uE07TUU2bw1UyNzKfIBfiiw==
X-Google-Smtp-Source: AGHT+IEgDunyayHEsda9Q6L2F2gmaVkydXdLsBCiekAOHpKhoojijICJ7m5fqvwVosnQTQpczwhTag==
X-Received: by 2002:a05:600c:45ce:b0:40c:2ba6:81e with SMTP id s14-20020a05600c45ce00b0040c2ba6081emr3080290wmo.121.1704827117034;
        Tue, 09 Jan 2024 11:05:17 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f70b:9940:beaa:1728])
        by smtp.gmail.com with ESMTPSA id jb6-20020a05600c54e600b0040e49045e0asm4380919wmb.48.2024.01.09.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 11:05:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: updates for v6.8-rc1
Date: Tue,  9 Jan 2024 20:05:14 +0100
Message-Id: <20240109190514.45830-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Here's the main pull-request for this merge window from the GPIO subsystem.
We have two new drivers, an assortment of updates and cleanups to many others,
and first part of the big rework of the core GPIOLIB that's currently underway.

Add to that some code shrink in the character device module and updates to DT
bindings and that's pretty much it.

There's a pull from Greg's branch for a new device property accessor that's
used by one of the GPIO driver and another from Andy's Intel tree. The pinctrl
commits in this PR have been Acked by Linus Walleij.

Details are in the signed tag.

Please pull,
Bartosz Golaszewski

The following changes since commit 861deac3b092f37b2c5e6871732f3e11486f7082:

  Linux 6.7-rc7 (2023-12-23 16:25:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.8-rc1

for you to fetch changes up to 1979a28075470ef82472a5656ecc969f901e0d3b:

  gpiolib: replace the GPIO device mutex with a read-write semaphore (2024-01-04 10:29:16 +0100)

----------------------------------------------------------------
gpio updates for v6.8

Core GPIOLIB:
- protect the global list of GPIO devices with a read-write semaphore as
  it is rarely modified but can be traversed by multiple readers at once
- remove GPIO devices from the global list when they are *unregistered*
  and not when they are *released* (which only happens when the last
  reference is dropped) as this may lead to a successful lookup of an
  unregistered device
- remove the unnecessary "extra_checks" switch
- rename functions that are called with a lock taken
- remove duplicate includes

Character device handling:
- use locking guards to reduce the code size
- allocate the big linereq structure using the more suitable kvzalloc()
- redulce the size of critical sections
- improve documentation
- move the debounce_period_us field out of struct gpio_desc

New drivers:
- Nuvoton NPCM SGPIO driver for BMC NPCM7xx/NPCM8xx
- Realtek DHC (Digital Home Center) SoC GPIO driver

Driver improvements:
- replace gpiochip_is_requested() with a safer alternative in the form of
  gpiochip_dup_line_label() as the former returns a pointer to a string that
  can be deleted
- implement the dbg_show() callback in gpio-sim
- improve the coding style for local variables by removing unnecessary tabs
- use generic device properties instead of OF variants in gpio-mmio
- use the preferred coding style for __free() in gpio-mockup
- reuse PM ops from the gpio-tangier in gpio-elkhartlake
- rework PM and use cleanup helpers in gpio-tangier
- fix the EIC configuration in gpio-pmic-eic-sprd
- remove the unneeded call to platform_set_drvdata() in gpio-sifive
- use generic GPIO helpers for driver callbacks in gpio-dwapb
- add clock support on certain pins of gpio-ixp4xx
- don't use the core-specific DEBUG_GPIO switch in drivers
- kerneldoc improvements

DT bindings:
- add bindings for the new Realtek and Nuvoton devices
- allow gpio-ranges in gpio-dwapb
- support GPIO hogs in gpio-rockchip
- describe the label property in gpio-zynqmp-modepin

Other:
- header cleanups
- forward declarations cleanups

----------------------------------------------------------------
Andrei Coardos (1):
      gpio: sifive: remove unneeded call to platform_set_drvdata()

Andy Shevchenko (4):
      Merge patch series "Use the standard _PM_OPS() export macro in Intel Tangier GPIO driver"
      device property: Implement device_is_big_endian()
      gpio: mmio: Make use of device properties
      gpio: mmio: Clean up headers

Bartosz Golaszewski (30):
      gpio: mockup: initialize a managed pointer in place
      gpiolib: provide gpio_device_get_label()
      Merge branch 'gpio/device_get_label_for_pinctrl' into gpio/for-next
      gpio: sysfs: fix forward declaration of struct gpio_device
      gpio: sim: fix the email address in MODULE_AUTHOR()
      gpiolib: provide gpiochip_dup_line_label()
      gpio: wm831x: use gpiochip_dup_line_label()
      gpio: wm8994: use gpiochip_dup_line_label()
      gpio: stmpe: use gpiochip_dup_line_label()
      pinctrl: abx500: use gpiochip_dup_line_label()
      pinctrl: nomadik: use gpiochip_dup_line_label()
      pinctrl: baytrail: use gpiochip_dup_line_label()
      pinctrl: sppctl: use gpiochip_dup_line_label()
      gpiolib: use gpiochip_dup_line_label() in for_each helpers
      gpiolib: remove gpiochip_is_requested()
      Merge tag 'gpio-remove-gpiochip_is_requested-for-v6.8-rc1' into gpio/for-next
      gpio: sim: implement the dbg_show() callback
      gpiolib: allocate memory atomically with a spinlock held
      gpio: xilinx: remove excess kernel doc
      gpiolib: rename static functions that are called with the lock taken
      gpiolib: use a mutex to protect the list of GPIO devices
      Merge tag 'device_is_big_endian-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core into gpio/for-next
      Merge tag 'intel-gpio-v6.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-next
      Merge tag 'v6.7-rc7' into gpio/for-next
      gpio: tps65219: don't use CONFIG_DEBUG_GPIO
      gpiolib: remove extra_checks
      gpiolib: drop tabs from local variable declarations
      gpio: sysfs: drop tabs from local variable declarations
      gpiolib: remove the GPIO device from the list when it's unregistered
      gpiolib: replace the GPIO device mutex with a read-write semaphore

Emil Renner Berthing (2):
      dt-bindings: gpio: dwapb: allow gpio-ranges
      gpio: dwapb: Use generic request, free and set_config

Heiko Stuebner (1):
      dt-bindings: gpio: rockchip: add a pattern for gpio hogs

Jim Liu (2):
      dt-bindings: gpio: add NPCM sgpio driver bindings
      gpio: nuvoton: Add Nuvoton NPCM sgpio driver

Kent Gibson (9):
      gpiolib: cdev: relocate debounce_period_us from struct gpio_desc
      gpiolib: remove debounce_period_us from struct gpio_desc
      gpiolib: cdev: fully adopt guard() and scoped_guard()
      gpiolib: cdev: improve documentation of get/set values
      gpiolib: cdev: reduce locking in gpio_desc_to_lineinfo()
      gpiolib: cdev: include overflow.h
      gpiolib: cdev: allocate linereq using kvzalloc()
      gpiolib: cdev: replace locking wrappers for config_mutex with guards
      gpiolib: cdev: replace locking wrappers for gpio_device with guards

Linus Walleij (1):
      gpio: ixp4xx: Handle clock output on pin 14 and 15

Michal Simek (1):
      dt-bindings: gpio: modepin: Describe label property

Raag Jadav (4):
      gpio: tangier: use EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS() helper
      gpio: elkhartlake: reuse pm_ops from Intel Tangier driver
      gpio: tangier: unexport suspend/resume handles
      gpio: tangier: simplify locking using cleanup helpers

Randy Dunlap (1):
      gpio: max730x: don't use kernel-doc marker for regular comment

Rob Herring (1):
      dt-bindings: gpio: brcmstb: drop unneeded quotes

Tzuyi Chang (2):
      dt-bindings: gpio: realtek: Add realtek,rtd-gpio
      gpio: rtd: Add support for Realtek DHC(Digital Home Center) RTD SoCs

Wang Jinchao (1):
      gpiolib: remove duplicate inclusions

Wenhua Lin (1):
      gpio: pmic-eic-sprd: Configure the bit corresponding to the EIC through offset

 .../bindings/gpio/brcm,brcmstb-gpio.yaml           |   2 +-
 .../devicetree/bindings/gpio/nuvoton,sgpio.yaml    |  87 +++
 .../devicetree/bindings/gpio/realtek,rtd-gpio.yaml |  69 +++
 .../bindings/gpio/rockchip,gpio-bank.yaml          |   7 +
 .../devicetree/bindings/gpio/snps,dw-apb-gpio.yaml |   2 +
 .../bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml    |   3 +
 drivers/gpio/Kconfig                               |  20 +
 drivers/gpio/Makefile                              |   2 +
 drivers/gpio/gpio-dwapb.c                          |  13 +-
 drivers/gpio/gpio-elkhartlake.c                    |  14 +-
 drivers/gpio/gpio-ixp4xx.c                         |  51 +-
 drivers/gpio/gpio-max730x.c                        |   2 +-
 drivers/gpio/gpio-mmio.c                           |  53 +-
 drivers/gpio/gpio-mockup.c                         |   3 +-
 drivers/gpio/gpio-npcm-sgpio.c                     | 619 +++++++++++++++++++
 drivers/gpio/gpio-pmic-eic-sprd.c                  |  19 +-
 drivers/gpio/gpio-rtd.c                            | 604 +++++++++++++++++++
 drivers/gpio/gpio-sifive.c                         |   1 -
 drivers/gpio/gpio-sim.c                            |  24 +-
 drivers/gpio/gpio-stmpe.c                          |   6 +-
 drivers/gpio/gpio-tangier.c                        |  63 +-
 drivers/gpio/gpio-tangier.h                        |   4 +-
 drivers/gpio/gpio-tps65219.c                       |  18 +-
 drivers/gpio/gpio-wm831x.c                         |  14 +-
 drivers/gpio/gpio-wm8994.c                         |  13 +-
 drivers/gpio/gpio-xilinx.c                         |   1 -
 drivers/gpio/gpiolib-cdev.c                        | 667 ++++++++++-----------
 drivers/gpio/gpiolib-sysfs.c                       | 110 ++--
 drivers/gpio/gpiolib-sysfs.h                       |  10 +-
 drivers/gpio/gpiolib.c                             | 274 +++++----
 drivers/gpio/gpiolib.h                             |   7 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c           |  11 +-
 drivers/pinctrl/nomadik/pinctrl-abx500.c           |   9 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |   6 +-
 drivers/pinctrl/sunplus/sppctl.c                   |  10 +-
 include/linux/gpio/driver.h                        |  43 +-
 include/linux/property.h                           |  26 +
 37 files changed, 2185 insertions(+), 702 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpio.yaml
 create mode 100644 Documentation/devicetree/bindings/gpio/realtek,rtd-gpio.yaml
 create mode 100644 drivers/gpio/gpio-npcm-sgpio.c
 create mode 100644 drivers/gpio/gpio-rtd.c

