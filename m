Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4657DBBDA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjJ3Odr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjJ3Odp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:33:45 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BBBC6;
        Mon, 30 Oct 2023 07:33:42 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-577fff1cae6so3060682a12.1;
        Mon, 30 Oct 2023 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698676422; x=1699281222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IDo3P66UG2s8id9OIvS41l0xuIgkJiiR3b6EgYiK6wQ=;
        b=eVOYBp+2ElyITzeq+hk6qbHRDFdA/xJiogZS65aCjJyuyE5WoMMAJNDSOouTX6xUX7
         p2Pq0c2w5tDJnAJj7iLCg2TCyoXei8d8pAFs+BxokRZ54r7BG1roV9hJu+O0TUdR6fw5
         q8VwXHwCRiszSyefur2oHA7cl8100561Did12IYvfVZppzzdn5NTyr73az9YCwymTWGD
         HJ+5pP5jzgKCiZKREI8akvWOVurat/sLtPPNvZuYxgT5zhtMIsYECye6VPQykg+OqKw7
         XDhIDR48WYc2wcI16NjZzAUk4s4hrsNKtrYL3X2lNDHYcXXPvx3O2DwGmkGQ9WrBHRms
         XfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676422; x=1699281222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDo3P66UG2s8id9OIvS41l0xuIgkJiiR3b6EgYiK6wQ=;
        b=bbwXDlNQT3ow69WQ1co4KpvK6K4r8Mr1eWKW+yEZfxQhhG51PzkPXf4G+aqCwpb3U0
         b8vCdoLuuHOXDiiBfSEoIj6k40/TV+cT/ggIJiCAEpPdseEXBqqlCHUkgnQz8Y5e+6EO
         k0axRLd94HvWNElAqjRRE5Fow6rVChklfG27KhoZlZWW6iHT8NhZivk+Dm7QkNq3Byyr
         cIN0We9DGE9o/4gaS3wzygsjTkCEHQ6q4CKUu41b/otCK9MnmvGtLmA6kN3SRiGtszp4
         +D7H8T/S1FMbj2jiSNgm7gaOh+kICuV1SUs6LSvlcSsWAJ8HK16V1WeJ3N0iPrcnEKfY
         A0qw==
X-Gm-Message-State: AOJu0YzmfdXtNlvR87NC6yee+GFGMTWC3/Dsw8Avw5d9yEtLHpVKz9HZ
        3OYqF6y4SwW8ZeN4TiXdql1ngsxPS44=
X-Google-Smtp-Source: AGHT+IFH5Tjtvai0G+3YP9yWa6hL6WzpuSzZ8GkN7vKXG2XU+rqgchtbWzBlN1hpbxZxBC5kfvY3IA==
X-Received: by 2002:a05:6a21:32aa:b0:17b:2c56:70bc with SMTP id yt42-20020a056a2132aa00b0017b2c5670bcmr12846252pzb.10.1698676422233;
        Mon, 30 Oct 2023 07:33:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k2-20020a637b42000000b0057412d84d25sm4844361pgn.4.2023.10.30.07.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:33:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.7
Date:   Mon, 30 Oct 2023 07:33:40 -0700
Message-Id: <20231030143340.2251301-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v6.7 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.7

Thanks,
Guenter
------

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.7

for you to fetch changes up to 0f564130e5c76f1e5cf0008924f6a6cd138929d9:

  hwmon: (aquacomputer_d5next) Check if temp sensors of legacy devices are connected (2023-10-29 22:22:48 -0700)

----------------------------------------------------------------
hwmon updates for v6.7-rc1

* New drivers

- Driver for LTC2991

- Driver for POWER-Z

* Added chip / system support to existing drivers

- The ina238 driver now also supports INA237

- The asus-ec-sensors driver now supports ROG Crosshair X670E Gene

- The aquacomputer_d5next now supports Aquacomputer High Flow USB and MPS Flow

- The pmbus/mpq7932 driver now also supports MPQ2286

- The nct6683 now also supports ASRock X670E Taichi

* Various other minor improvements and fixes

- One patch series to call out is the conversion of hwmon platform
  drivers to use the platform remove callback returning void

----------------------------------------------------------------
Aleksa Savic (2):
      hwmon: (aquacomputer_d5next) Add support for Aquacomputer High Flow USB and MPS Flow
      hwmon: (aquacomputer_d5next) Check if temp sensors of legacy devices are connected

Alexander Koskovich (1):
      hwmon: (nct6683) Add another customer ID for ASRock X670E Taichi

Antoniu Miclaus (4):
      hwmon: (ltc2992) Avoid division by zero
      hwmon: (max31827) handle vref regulator
      dt-bindings: hwmon: ltc2991: add bindings
      hwmon: Add driver for ltc2991

Armin Wolf (5):
      hwmon: (sch5627) Use bit macros when accessing the control register
      hwmon: (sch5627) Disallow write access if virtual registers are locked
      hwmon: (sch5627) Use regmap for pwm map register caching
      hwmon: (sch5627) Add support for writing limit registers
      hwmon: (sch5627) Document behaviour of limit registers

Biju Das (2):
      hwmon: tmp513: Add max_channels variable to struct tmp51x_data
      hwmon: tmp513: Simplify tmp51x_read_properties()

Colin Ian King (1):
      hwmon: (hs3001) remove redundant store on division

Daniel Matyas (3):
      hwmon: (max31827) Make code cleaner
      hwmon: (max31827) Modify conversion wait time
      dt-bindings: hwmon: Add possible new properties to max31827 bindings

Dragos Bogdan (1):
      hwmon: (axi-fan-control) Fix possible NULL pointer dereference

Ellie Hermaszewska (1):
      hwmon: (asus-ec-sensors) add ROG Crosshair X670E Gene.

Guenter Roeck (2):
      Revert "hwmon: (sch56xx-common) Add DMI override table"
      Revert "hwmon: (sch56xx-common) Add automatic module loading on supported devices"

Hal Feng (1):
      MAINTAINERS: Add Hal as one of the maintainers of SFCTEMP HWMON DRIVER

Jon Hunter (1):
      dt-bindings: hwmon: ina3221: Add ti,summation-disable

Lakshmi Yadlapati (1):
      hwmon: (pmbus/max31785) Add delay between bus accesses

Naresh Solanki (1):
      hwmon: (pmbus/mp2975) Move PGOOD fix

Ninad Malwade (2):
      dt-bindings: hwmon: ina3221: Convert to json-schema
      hwmon: (ina3221) Add support for channel summation disable

Patrick Rudolph (3):
      dt-bindings: hwmon: Add Infineon TDA38640
      hwmon: (pmbus) Add ON_OFF_CONFIG register bits
      hwmon: (pmbus/tda38640) Add workaround for SVID mode

Raag Jadav (1):
      hwmon: (nct6775) use acpi_dev_hid_uid_match() for matching _HID and _UID

Richard Leitner (2):
      dt-bindings: hwmon: ti,ina2xx: add ti,ina237
      hwmon: (ina238) add ina237 support

Saravanan Sekar (4):
      hwmon: (pmbus/mpq7932) Get page count based on chip info
      regulator: dt-bindings: Add mps,mpq2286 power-management IC
      hwmon: (pmbus/core) Add helper macro to define single pmbus regulator
      hwmon: (pmbus/mpq7932) Add a support for mpq2286 Power Management IC

Su Hui (1):
      hwmon: (npcm750-pwm) Add an error code check in npcm7xx_en_pwm_fan

Thomas Weißschuh (2):
      hwmon: add POWER-Z driver
      hwmon: (powerz) add support for ChargerLAB KM002C

Timothy Pearson (1):
      hwmon: (adt7475) Add support for Imon readout on ADT7490

Tomer Maimon (1):
      dt-bindings: hwmon: npcm: Add npcm845 compatible string

Uwe Kleine-König (24):
      hwmon: (abitguru{,3}) Enable build testing on !X86
      hwmon: (abituguru) Convert to platform remove callback returning void
      hwmon: (abituguru3) Convert to platform remove callback returning void
      hwmon: (da9052-hwmon) Convert to platform remove callback returning void
      hwmon: (dme1737) Convert to platform remove callback returning void
      hwmon: (f71805f) Convert to platform remove callback returning void
      hwmon: (f71882fg) Convert to platform remove callback returning void
      hwmon: (i5k_amb) Convert to platform remove callback returning void
      hwmon: (max197) Convert to platform remove callback returning void
      hwmon: (mc13783-adc) Convert to platform remove callback returning void
      hwmon: (occ/p9_sbe) Convert to platform remove callback returning void
      hwmon: (pc87360) Convert to platform remove callback returning void
      hwmon: (pc87427) Convert to platform remove callback returning void
      hwmon: (sch5636) Convert to platform remove callback returning void
      hwmon: (sht15) Convert to platform remove callback returning void
      hwmon: (sis5595) Convert to platform remove callback returning void
      hwmon: (ultra45_env) Convert to platform remove callback returning void
      hwmon: (via-cputemp) Convert to platform remove callback returning void
      hwmon: (via686a) Convert to platform remove callback returning void
      hwmon: (vt1211) Convert to platform remove callback returning void
      hwmon: (vt8231) Convert to platform remove callback returning void
      hwmon: (w83627hf) Convert to platform remove callback returning void
      hwmon: (w83781d) Convert to platform remove callback returning void
      hwmon: (xgene-hwmon) Convert to platform remove callback returning void

Zev Weiss (1):
      hwmon: (nct6775) Fix incorrect variable reuse in fan_div calculation

Zhang Rui (1):
      hwmon: (coretemp) Fix potentially truncated sysfs attribute name

 .../devicetree/bindings/hwmon/adi,ltc2991.yaml     | 128 ++++++
 .../devicetree/bindings/hwmon/adi,max31827.yaml    |  66 ++++
 .../devicetree/bindings/hwmon/ina3221.txt          |  54 ---
 .../devicetree/bindings/hwmon/npcm750-pwm-fan.txt  |   6 +-
 .../bindings/hwmon/pmbus/infineon,tda38640.yaml    |  49 +++
 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |   1 +
 .../devicetree/bindings/hwmon/ti,ina3221.yaml      | 121 ++++++
 .../devicetree/bindings/regulator/mps,mpq2286.yaml |  59 +++
 .../devicetree/bindings/trivial-devices.yaml       |   2 -
 Documentation/hwmon/adt7475.rst                    |   3 +-
 Documentation/hwmon/aquacomputer_d5next.rst        |   7 +
 Documentation/hwmon/asus_ec_sensors.rst            |   1 +
 Documentation/hwmon/index.rst                      |   2 +
 Documentation/hwmon/ltc2991.rst                    |  43 ++
 Documentation/hwmon/max31827.rst                   |   4 +-
 Documentation/hwmon/nct6683.rst                    |   1 +
 Documentation/hwmon/powerz.rst                     |  30 ++
 Documentation/hwmon/sch5627.rst                    |  10 +
 MAINTAINERS                                        |  16 +
 drivers/hwmon/Kconfig                              |  26 +-
 drivers/hwmon/Makefile                             |   2 +
 drivers/hwmon/abituguru.c                          |   6 +-
 drivers/hwmon/abituguru3.c                         |   5 +-
 drivers/hwmon/adt7475.c                            |  68 +++-
 drivers/hwmon/aquacomputer_d5next.c                |  72 +++-
 drivers/hwmon/asus-ec-sensors.c                    |  12 +
 drivers/hwmon/axi-fan-control.c                    |  29 +-
 drivers/hwmon/coretemp.c                           |   2 +-
 drivers/hwmon/da9052-hwmon.c                       |   6 +-
 drivers/hwmon/dme1737.c                            |   6 +-
 drivers/hwmon/f71805f.c                            |   6 +-
 drivers/hwmon/f71882fg.c                           |   5 +-
 drivers/hwmon/hs3001.c                             |   2 +-
 drivers/hwmon/i5k_amb.c                            |   5 +-
 drivers/hwmon/ina238.c                             |   3 +-
 drivers/hwmon/ina3221.c                            |  33 +-
 drivers/hwmon/ltc2991.c                            | 437 +++++++++++++++++++++
 drivers/hwmon/ltc2992.c                            |   6 +-
 drivers/hwmon/max197.c                             |   6 +-
 drivers/hwmon/max31827.c                           | 131 +++---
 drivers/hwmon/mc13783-adc.c                        |   6 +-
 drivers/hwmon/nct6683.c                            |   3 +
 drivers/hwmon/nct6775-core.c                       |  12 +-
 drivers/hwmon/nct6775-platform.c                   |   4 +-
 drivers/hwmon/npcm750-pwm-fan.c                    |   2 +
 drivers/hwmon/occ/p9_sbe.c                         |   6 +-
 drivers/hwmon/pc87360.c                            |   6 +-
 drivers/hwmon/pc87427.c                            |   6 +-
 drivers/hwmon/pmbus/max31785.c                     | 188 ++++++++-
 drivers/hwmon/pmbus/mp2975.c                       |  10 +-
 drivers/hwmon/pmbus/mpq7932.c                      |  19 +-
 drivers/hwmon/pmbus/pmbus.h                        |  24 ++
 drivers/hwmon/pmbus/tda38640.c                     | 154 +++++++-
 drivers/hwmon/powerz.c                             | 275 +++++++++++++
 drivers/hwmon/sch5627.c                            | 267 +++++++++----
 drivers/hwmon/sch5636.c                            |   6 +-
 drivers/hwmon/sch56xx-common.c                     | 171 +++++---
 drivers/hwmon/sch56xx-common.h                     |   6 +
 drivers/hwmon/sht15.c                              |   6 +-
 drivers/hwmon/sis5595.c                            |   6 +-
 drivers/hwmon/tmp513.c                             |  52 ++-
 drivers/hwmon/ultra45_env.c                        |   6 +-
 drivers/hwmon/via-cputemp.c                        |   5 +-
 drivers/hwmon/via686a.c                            |   6 +-
 drivers/hwmon/vt1211.c                             |   6 +-
 drivers/hwmon/vt8231.c                             |   6 +-
 drivers/hwmon/w83627hf.c                           |   6 +-
 drivers/hwmon/w83781d.c                            |   7 +-
 drivers/hwmon/xgene-hwmon.c                        |   6 +-
 69 files changed, 2292 insertions(+), 456 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2991.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/infineon,tda38640.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
 create mode 100644 Documentation/hwmon/ltc2991.rst
 create mode 100644 Documentation/hwmon/powerz.rst
 create mode 100644 drivers/hwmon/ltc2991.c
 create mode 100644 drivers/hwmon/powerz.c
