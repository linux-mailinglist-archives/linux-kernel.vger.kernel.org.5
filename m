Return-Path: <linux-kernel+bounces-19889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB02827642
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CB91F2297E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9720E5466A;
	Mon,  8 Jan 2024 17:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+rCSrQw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45B54BC1;
	Mon,  8 Jan 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so1751842b3a.2;
        Mon, 08 Jan 2024 09:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704734650; x=1705339450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rGn5g/i0OAEaE/8R8RL/B7/zL2YsQjya1Hphw6b6Sic=;
        b=c+rCSrQwureLbDwdVv+aThIsWCA5XK4xHK0R2LPv+y0QbNBjvyy15nCITCmBvQKkX+
         UceP164rnilZnVsdLqXK49K2pDDa8fE4Cpeg8c2YulSnoZbnqVfHUodFx+zdlqNqVTEp
         gT4Yu6iwldnQ0zb29KrjWXTwmnTxJ7cxFlUyTaIK3d3XxZF2bYLzz7J1Aw+pV3PaknJA
         2K0sx9hjLY4ogx5Qa/DKletUcxFV0WHdjEnenCpf8vW9vfVAirEySiVH2nFl+v5kZRZq
         gOkk4l3PUwcNpxTrySs3J/7Fe1OINH/yJabhYquwiqkJ3bKtCjLjJgnoXVR4KnrLcMwv
         zo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704734650; x=1705339450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGn5g/i0OAEaE/8R8RL/B7/zL2YsQjya1Hphw6b6Sic=;
        b=Oq/O7lZCVS6+tFfNJCrlFYqXviGgmFm7a+94/AEPalpu0C5HTi7OvyExAwKmltaG+D
         N/2MMZxjZwr0odPasXfwiqU8wVQQRczdsj2gwePolPrhET6oapCNw/Gj6rPmE/iHoVL+
         4ZhCs7ZY+NTB/fkvk8/0tBrxIaOTHxTUxvm/xnDbK74eGYaKBx7FdldybRu64k4dNzL5
         Tq4Ckdb1kxLuR0X5jXet5k04/OIqKOwvCSKLUyjpLsD7SMfZgyQLITJYM1lf5BARGm7k
         nbe60wkTPSFDFV64YRgRkP1p3lE2cUKZmVMT6CoDdi/cuVPxapDVJJlHnsOIDT4aMcoq
         uRDw==
X-Gm-Message-State: AOJu0YwhG0os4NTuRNvo/SPlsh1ufk4L8j8xD4dHlRZxqSQVy0HTlo+q
	/ZO26GTLhUVeBwis6yDJbEYDpslB5TI=
X-Google-Smtp-Source: AGHT+IGnMQ4UGMZXE4CQLZlgPglRq2ggVjKs3yWoXqheICzI9foio9C7Ov/UaaFkbLpZKLG8ML0Yag==
X-Received: by 2002:a05:6a21:608:b0:199:9d92:f307 with SMTP id ll8-20020a056a21060800b001999d92f307mr2721973pzb.94.1704734650174;
        Mon, 08 Jan 2024 09:24:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f31-20020a056a000b1f00b006ce95e37a40sm121606pfu.111.2024.01.08.09.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:24:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.8
Date: Mon,  8 Jan 2024 09:24:08 -0800
Message-Id: <20240108172408.2220642-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon updates for Linux v6.8 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.8

Thanks,
Guenter
------

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.8

for you to fetch changes up to 41c71105a845ec1458680f01644d032a5fbbe0d9:

  hwmon: (gigabyte_waterforce) Mark status report as received under a spinlock (2024-01-08 07:27:27 -0800)

----------------------------------------------------------------
hwmon updates for v6.8

- New drivers

  * pmbus: Support for MPS Multi-phase mp2856/mp2857 controller

  * pmbus: Support for MPS Multi-phase mp5990

  * Driver for Gigabyte AORUS Waterforce AIO coolers

0c459759ca97 hwmon: (pmbus) Add ltc4286 driver

- Added support to existing drivers

  * lm75: Support for AMS AS6200 temperature sensor

  * k10temp: Support for AMD Family 19h Model 8h

  * max31827: Support for max31828 and max31829

  * sht3x: Support for sts3x

  * Add support for WMI SMM interface, and various related improvements.
    Add support for Optiplex 7000

  * emc1403: Support for EMC1442

  * npcm750-pwm-fan: Support for NPCM8xx

  * nct6775: Add support for 2 additional fan controls

- Minor improvements and bug fixes

  * gigabyte_waterforce: Mark status report as received under a spinlock

  * aquacomputer_d5next: Remove unneeded CONFIG_DEBUG_FS #ifdef

  * gpio-fan: Convert txt bindings to yaml

  * smsc47m1: Various cleanups / improvements

  * corsair-cpro: use NULL instead of 0

  * hp-wmi-sensors: Fix failure to load on EliteDesk 800 G6

  * tmp513: Various cleanups

  * peci/dimmtemp: Bump timeout

  * pc87360: Bounds check data->innr usage

  * nct6775: Fix fan speed set failure in automatic mode

  * ABI: sysfs-class-hwmon: document various missing attributes

  * lm25066: Use i2c_get_match_data()

  * nct6775: Use i2c_get_match_data(), and related fixes

  * max6650: Use i2c_get_match_data()

  * aspeed-pwm-tacho: Fix -Wstringop-overflow warning in aspeed_create_fan_tach_channel()

----------------------------------------------------------------
Abdel Alkuor (3):
      dt-bindings: hwmon: (lm75) Add AMS AS6200 temperature sensor
      hwmon: (lm75) Add AMS AS6200 temperature sensor
      hwmon: (lm75) Fix tmp112 default config

Aleksa Savic (3):
      hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers
      hwmon: (aquacomputer_d5next) Remove unneeded CONFIG_DEBUG_FS #ifdef
      hwmon: (gigabyte_waterforce) Mark status report as received under a spinlock

Andy Shevchenko (3):
      hwmon: (tmp513) Don't use "proxy" headers
      hwmon: (tmp513) Simplify with dev_err_probe()
      hwmon: (tmp513) Use SI constants from units.h

Antoniu Miclaus (1):
      hwmon: (ltc2991) remove device reference from state

Armin Wolf (9):
      hwmon: (dell-smm) Prepare for multiple SMM calling backends
      hwmon: (dell-smm) Move blacklist handling to module init
      hwmon: (dell-smm) Move whitelist handling to module init
      hwmon: (dell-smm) Move DMI config handling to module init
      hwmon: (dell-smm) Move config entries out of i8k_dmi_table
      hwmon: (dell-smm) Introduce helper function for data init
      hwmon: (dell-smm) Add support for WMI SMM interface
      hwmon: (dell-smm) Document the WMI SMM interface
      hwmon: (dell-smm) Add Optiplex 7000 to fan control whitelist

Daniel Matyas (5):
      hwmon: (max31827) Handle new properties from the devicetree
      hwmon: (max31827) Add support for max31828 and max31829
      hwmon: (max31827) Update bits with shutdown_write()
      hwmon: (max31827) Return closest value in update_interval
      hwmon: (max31827) Add custom attribute for resolution

David Heidelberg (1):
      dt-bindings: hwmon: gpio-fan: Convert txt bindings to yaml

Delphine CC Chiu (3):
      hwmon: (emc1403) Add support for EMC1442
      dt-bindings: hwmon: Add lltc ltc4286 driver bindings
      hwmon: (pmbus) Add ltc4286 driver

Guenter Roeck (1):
      hwmon: (nct6775-core) Explicitly initialize nct6775_device_names indexes

Gustavo A. R. Silva (1):
      hwmon: (aspeed-pwm-tacho) Fix -Wstringop-overflow warning in aspeed_create_fan_tach_channel()

James Seo (1):
      hwmon: (hp-wmi-sensors) Fix failure to load on EliteDesk 800 G6

Jami Kurki (1):
      hwmon: (k10temp) Add support for AMD Family 19h Model 8h

Javier Carrasco (4):
      ABI: sysfs-class-hwmon: rearrange humidity attributes alphabetically
      ABI: sysfs-class-hwmon: document missing humidity attributes
      ABI: sysfs-class-hwmon: fix tempY_crit_alarm access rights
      ABI: sysfs-class-hwmon: document emergency/max/min temperature alarms

Kees Cook (2):
      hwmon: (nct6775-platform) Explicitly initialize nct6775_sio_names indexes
      hwmon: (pc87360) Bounds check data->innr usage

Luca Ceresoli (1):
      hwmon: (lm75) remove now-unused include

Marius Zachmann (1):
      hwmon: (corsair-cpro) use NULL instead of 0

Michal Simek (1):
      dt-bindings: hwmon: Increase max number of io-channels

Patrick Rudolph (1):
      hwmon: (peci/dimmtemp) Bump timeout

Peter Yin (4):
      dt-bindings: hwmon: Add mps mp5990 driver bindings
      hwmon: (pmbus) Add support for MPS Multi-phase mp5990
      dt-bindings: Add MP2856/MP2857 voltage regulator device
      hwmon: (pmbus) Add support for MPS Multi-phase mp2856/mp2857 controller

Rob Herring (3):
      hwmon: (max6650) Use i2c_get_match_data()
      hwmon: (nct6775-i2c) Use i2c_get_match_data()
      hwmon: (lm25066) Use i2c_get_match_data()

Serge Semin (1):
      MAINTAINERS: Add maintainer for Baikal-T1 PVT hwmon driver

Stefan Gloor (1):
      hwmon: (sht3x) add sts3x support

Tomer Maimon (1):
      hwmon: (npcm750-pwm-fan) Add NPCM8xx support

Uwe Kleine-König (4):
      hwmon: (smsc47m1) Mark driver struct with __refdata to prevent section mismatch
      hwmon: (smsc47m1) Convert to platform remove callback returning void
      hwmon: (smsc47m1) Simplify device registration
      hwmon: (smsc47m1) Rename global platform device variable

Xing Tong Wu (2):
      hwmon: (nct6775) Add support for 2 additional fan controls
      hwmon: (nct6775) Fix fan speed set failure in automatic mode

Yang Li (1):
      hwmon: Fix some kernel-doc comments

 Documentation/ABI/testing/sysfs-class-hwmon        | 110 +++-
 .../devicetree/bindings/hwmon/gpio-fan.txt         |  41 --
 .../devicetree/bindings/hwmon/gpio-fan.yaml        |  60 ++
 .../devicetree/bindings/hwmon/iio-hwmon.yaml       |   2 +-
 .../devicetree/bindings/hwmon/lltc,ltc4286.yaml    |  50 ++
 Documentation/devicetree/bindings/hwmon/lm75.yaml  |  33 ++
 .../devicetree/bindings/trivial-devices.yaml       |   6 +
 Documentation/hwmon/dell-smm-hwmon.rst             |  38 +-
 Documentation/hwmon/gigabyte_waterforce.rst        |  47 ++
 Documentation/hwmon/index.rst                      |   4 +
 Documentation/hwmon/lm75.rst                       |  10 +
 Documentation/hwmon/ltc4286.rst                    |  95 ++++
 Documentation/hwmon/max31827.rst                   |  75 ++-
 Documentation/hwmon/mp2856.rst                     |  98 ++++
 Documentation/hwmon/mp5990.rst                     |  84 +++
 Documentation/hwmon/sht3x.rst                      |  29 +-
 MAINTAINERS                                        |  25 +
 drivers/hwmon/Kconfig                              |  11 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/aquacomputer_d5next.c                |  10 -
 drivers/hwmon/aspeed-pwm-tacho.c                   |  26 +-
 drivers/hwmon/corsair-cpro.c                       |   2 +-
 drivers/hwmon/dell-smm-hwmon.c                     | 608 ++++++++++++++-------
 drivers/hwmon/emc1403.c                            |   6 +-
 drivers/hwmon/gigabyte_waterforce.c                | 430 +++++++++++++++
 drivers/hwmon/hp-wmi-sensors.c                     | 125 ++++-
 drivers/hwmon/k10temp.c                            |   1 +
 drivers/hwmon/lm75.c                               | 114 +++-
 drivers/hwmon/ltc2991.c                            |  20 +-
 drivers/hwmon/max31827.c                           | 275 ++++++++--
 drivers/hwmon/max6650.c                            |   8 +-
 drivers/hwmon/nct6775-core.c                       |  41 +-
 drivers/hwmon/nct6775-i2c.c                        |  14 +-
 drivers/hwmon/nct6775-platform.c                   |  26 +-
 drivers/hwmon/nct6775.h                            |   2 +-
 drivers/hwmon/npcm750-pwm-fan.c                    |  30 +-
 drivers/hwmon/pc87360.c                            |   6 +-
 drivers/hwmon/peci/dimmtemp.c                      |   2 +-
 drivers/hwmon/pmbus/Kconfig                        |  28 +
 drivers/hwmon/pmbus/Makefile                       |   3 +
 drivers/hwmon/pmbus/lm25066.c                      |  14 +-
 drivers/hwmon/pmbus/ltc4286.c                      | 175 ++++++
 drivers/hwmon/pmbus/mp2856.c                       | 466 ++++++++++++++++
 drivers/hwmon/pmbus/mp5990.c                       | 179 ++++++
 drivers/hwmon/sht4x.c                              |   3 +-
 drivers/hwmon/smsc47m1.c                           |  67 +--
 drivers/hwmon/tmp513.c                             |  64 ++-
 drivers/platform/x86/wmi.c                         |   1 +
 48 files changed, 3066 insertions(+), 499 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/lltc,ltc4286.yaml
 create mode 100644 Documentation/hwmon/gigabyte_waterforce.rst
 create mode 100644 Documentation/hwmon/ltc4286.rst
 create mode 100644 Documentation/hwmon/mp2856.rst
 create mode 100644 Documentation/hwmon/mp5990.rst
 create mode 100644 drivers/hwmon/gigabyte_waterforce.c
 create mode 100644 drivers/hwmon/pmbus/ltc4286.c
 create mode 100644 drivers/hwmon/pmbus/mp2856.c
 create mode 100644 drivers/hwmon/pmbus/mp5990.c

