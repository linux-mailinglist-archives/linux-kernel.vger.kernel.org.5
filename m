Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E2078B568
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjH1Qc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjH1Qcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:32:46 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3E8EA;
        Mon, 28 Aug 2023 09:32:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a42d06d02so2253731b3a.0;
        Mon, 28 Aug 2023 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693240363; x=1693845163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+YpMbOFDTnP9JdvKWfaSvl485+xcpZcCKxCRJ7pSV2Q=;
        b=r1D3T3tAbZDi6AU3KcqIHAtMsHFEYGbxND9J5lNZXaHjViVDWBcINtwqr1vLTZZhZP
         aoZbVkTnN60+W1tnKWr+xP9KPT2R9o6MJYQ/jZ9TU0Hi1MRc1tbtAlvixb4SJdzWc+MH
         kCqp92eS2mdWnxEeFE9xmbxTWPdHLCCg9jOhdRYPB//3ziHxRCtp0FLUd67h8NQoq8ss
         fa70CFh2rrIcgTEOoHP9D/wUY96ZEh6o7jPDiHCfRxiLPQKf1SHXCoTuXjR0nZn+r7ur
         42B3OOCLRoFfxljiSKzEo3FUTkmnz9QLVr/bzM5NwDVDk9GTmN1MWR6zKcwIPQ40h4kB
         gnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693240363; x=1693845163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YpMbOFDTnP9JdvKWfaSvl485+xcpZcCKxCRJ7pSV2Q=;
        b=M3wI8jlySpzB2gB8eQlvrMGcJjX8iF183fi8sN518GOIis8iJMYD9FJk8KQdohmVPF
         Hmmz9x9EngX63Tf4e5L6b6cnm90mXAT+N7yM4bktYrFpL8NXJyHtntaW3hQJyIt7esj3
         kEfDUb3fTX4ZMINrKs+ESX9RRGpkDII9a9fQNt0QUqghH+19lpyK0SI665RPi0OcepAN
         1dZ66bxqrJuoSwIgTcGjRmRvdiMjDAQQwezr/NDktLWmy+kBokin3SWleLVBXmBoBN0B
         80sqWPy6Dy/YX8WkKm7YL1M6FR7929Rud0entW9ooiqGNrjY0AkQeu5lThSII9/OFxW2
         k2uw==
X-Gm-Message-State: AOJu0YwXURCFoF++9rvSO3YRQoSF5kMI4pLsAfOTtxcTXWe9FhB1U2o+
        JHH35MxY94ktacfsRT8CJ/auTPMdmHo=
X-Google-Smtp-Source: AGHT+IGYfzL7FK9gLX1kqFBMcHb6m4f45f6oHW+VfM7CH1FqgEPq9hq3Ndqu0uAZfuAbDiHpRvhMOQ==
X-Received: by 2002:a05:6a00:23c6:b0:68a:406f:8a11 with SMTP id g6-20020a056a0023c600b0068a406f8a11mr23821122pfc.15.1693240362871;
        Mon, 28 Aug 2023 09:32:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79210000000b0068338b6667asm6848141pfo.212.2023.08.28.09.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 09:32:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v6.6
Date:   Mon, 28 Aug 2023 09:32:39 -0700
Message-Id: <20230828163239.2945690-1-linux@roeck-us.net>
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

Please pull hwmon updates for Linux v6.6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.6

Thanks,
Guenter
------

The following changes since commit 56b930dcd88c2adc261410501c402c790980bdb5:

  hwmon: (aquacomputer_d5next) Add selective 200ms delay after sending ctrl report (2023-08-09 21:09:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.6

for you to fetch changes up to 919a83d020a8dfa1411c1dc1cff23a833f0f5268:

  hwmon: (tmp513) Simplify probe() (2023-08-25 07:43:10 -0700)

----------------------------------------------------------------
hwmon updates for v6.6

- New drivers

  * Driver for Renesas HS3001

- Chip support added to existing drivers

  * pmbus/mp2975 driver now supports MP2971 and MP2973

- Functional improvements

  * Additional voltage and temperature sensor support for
    NCT6798/NCT6799 in nt6755 driver

  * it87 driver now detects AMDTSI sensor type

  * dimmtemp now supports more than 32 DIMMs

- Driver removals

  * sm665 driver removed as unsupportable and long since obsolete

- Minor fixes, cleanups, and simplifications in several drivers

----------------------------------------------------------------
Ahmad Khalifa (4):
      hwmon: (nct6775) Change labels for nct6799
      hwmon: (nct6775) Increase and reorder ALARM/BEEP bits
      hwmon: (nct6775) Add support for 18 IN readings for nct6799
      hwmon: (nct6775) Additional TEMP registers for nct6799

Andre Werner (2):
      dt-bindings: hwmon: Add description for new hwmon sensor hs3001
      hwmon: Add driver for Renesas HS3001

Azeem Shaikh (1):
      hwmon: (pmbus/max20730) Remove strlcpy occurences

Biju Das (2):
      hwmon: (tmp513) Fix the channel number in tmp51x_is_visible()
      hwmon: (tmp513) Simplify probe()

Christophe JAILLET (1):
      hwmon: (lan966x) Use the devm_clk_get_enabled() helper function

Eddie James (1):
      hwmon: (pmbus/acbel-fsg032) Add firmware version debugfs attribute

Eugene Shalygin (1):
      hwmon: (asus-ec-sensosrs) fix mutex path for X670E Hero

Frank Crawford (3):
      hwmon: (it87) Split temperature sensor detection to separate function
      hwmon: (it87) Improve temperature reporting support
      hwmon: (it87) Add support to detect sensor type AMDTSI

Guenter Roeck (1):
      hwmon: Remove smm665 driver

Ilpo Järvinen (3):
      hwmon: (via686a) Do PCI error checks on own line
      hwmon: (vt8231) Do PCI error checks on own line
      hwmon: (sis5595) Do PCI error checks on own line

James Seo (2):
      hwmon: (hp-wmi-sensors) Get WMI instance count from WMI driver core
      hwmon: (hp-wmi-sensors) Initialize pevents in hp_wmi_sensors_init()

Joaquín Ignacio Aramendía (1):
      hwmon: (oxp-sensors) Move board detection to the init function

JuenKit Yip (1):
      hwmon: (sht3x) convert some of sysfs interface to hwmon

Krzysztof Kozlowski (15):
      hwmon: (adt7475) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (ad7418) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (ads7828) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (ina2xx) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (lm63) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (lm75) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (lm85) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (lm90) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (max20730) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (max6697) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (tmp513) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (pmbus/ibm-cffps) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (pmbus/tps53679) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (pmbus/ucd9000) fix Wvoid-pointer-to-enum-cast warning
      hwmon: (pmbus/ucd9200) fix Wvoid-pointer-to-enum-cast warning

Naresh Solanki (1):
      hwmon: (max6639) Add compatible string

Patrick Rudolph (13):
      hwmon: (dimmtemp) Support more than 32 DIMMs
      hwmon: (pmbus/mp2975) Fix whitespace error
      dt-bindings: trivial-devices: Add MPS MP2971 and MP2973
      hwmon: (pmbus/mp2975) Prepare for MP2973 and MP2971
      hwmon: (pmbus/mp2975) Simplify VOUT code
      hwmon: (pmbus/mp2975) Make phase count variable
      hwmon: (pmbus/mp2975) Add support for MP2971 and MP2973
      hwmon: (pmbus/mp2975) Add regulator support
      hwmon: (pmbus/mp2975) Add OCP limit
      hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD
      hwmon: pmbus: Reduce clear fault page invocations
      hwmon: pmbus: Drop unnecessary clear fault page
      hwmon: pmbus: Fix -EIO seen on pli1209

Rob Herring (1):
      hwmon: Explicitly include correct DT includes

Ruan Jinjie (1):
      hwmon: (nsa320-hwmon) Remove redundant of_match_ptr()

Uwe Kleine-König (1):
      hwmon: (pmbus) Update documentation to not use .probe_new() any more

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Extend number of supported fans

Yangtao Li (1):
      hwmon: (bt1-pvt) Convert to devm_platform_ioremap_resource()

 .../devicetree/bindings/trivial-devices.yaml       |   6 +
 Documentation/hwmon/hs3001.rst                     |  37 ++
 Documentation/hwmon/index.rst                      |   2 +-
 Documentation/hwmon/nct6775.rst                    |  11 +-
 Documentation/hwmon/pmbus.rst                      |   2 +-
 Documentation/hwmon/smm665.rst                     | 187 ------
 MAINTAINERS                                        |  13 +-
 drivers/hwmon/Kconfig                              |  24 +-
 drivers/hwmon/Makefile                             |   2 +-
 drivers/hwmon/ad7418.c                             |   4 +-
 drivers/hwmon/ads7828.c                            |   5 +-
 drivers/hwmon/adt7475.c                            |   3 +-
 drivers/hwmon/as370-hwmon.c                        |   3 +-
 drivers/hwmon/aspeed-pwm-tacho.c                   |   3 +-
 drivers/hwmon/asus-ec-sensors.c                    |   2 +-
 drivers/hwmon/bt1-pvt.c                            |   9 +-
 drivers/hwmon/g762.c                               |   1 -
 drivers/hwmon/gxp-fan-ctrl.c                       |   2 +-
 drivers/hwmon/hp-wmi-sensors.c                     |  22 +-
 drivers/hwmon/hs3001.c                             | 242 +++++++
 drivers/hwmon/ina2xx.c                             |   3 +-
 drivers/hwmon/it87.c                               |  74 ++-
 drivers/hwmon/lan966x-hwmon.c                      |  24 +-
 drivers/hwmon/lm63.c                               |   4 +-
 drivers/hwmon/lm75.c                               |   3 +-
 drivers/hwmon/lm85.c                               |   4 +-
 drivers/hwmon/lm90.c                               |   4 +-
 drivers/hwmon/lochnagar-hwmon.c                    |   1 -
 drivers/hwmon/ltq-cputemp.c                        |   3 +-
 drivers/hwmon/max31730.c                           |   1 -
 drivers/hwmon/max6621.c                            |   2 +-
 drivers/hwmon/max6639.c                            |   6 +
 drivers/hwmon/max6697.c                            |   3 +-
 drivers/hwmon/mcp3021.c                            |   1 -
 drivers/hwmon/mlxreg-fan.c                         |  12 +-
 drivers/hwmon/nct6775-core.c                       | 355 +++++++----
 drivers/hwmon/nct6775-platform.c                   |   2 +-
 drivers/hwmon/nct6775.h                            |  30 +-
 drivers/hwmon/nsa320-hwmon.c                       |   4 +-
 drivers/hwmon/oxp-sensors.c                        |  29 +-
 drivers/hwmon/peci/dimmtemp.c                      |  26 +-
 drivers/hwmon/pmbus/Kconfig                        |   7 +
 drivers/hwmon/pmbus/acbel-fsg032.c                 |  38 ++
 drivers/hwmon/pmbus/dps920ab.c                     |   2 +-
 drivers/hwmon/pmbus/ibm-cffps.c                    |   4 +-
 drivers/hwmon/pmbus/ir38064.c                      |   4 +-
 drivers/hwmon/pmbus/max20730.c                     |  68 +-
 drivers/hwmon/pmbus/mp2975.c                       | 427 ++++++++++---
 drivers/hwmon/pmbus/mp5023.c                       |   2 +-
 drivers/hwmon/pmbus/mpq7932.c                      |   2 +-
 drivers/hwmon/pmbus/pli1209bc.c                    |  26 +
 drivers/hwmon/pmbus/pmbus_core.c                   |   4 +-
 drivers/hwmon/pmbus/q54sj108a2.c                   |   2 +-
 drivers/hwmon/pmbus/tps53679.c                     |   4 +-
 drivers/hwmon/pmbus/ucd9000.c                      |   4 +-
 drivers/hwmon/pmbus/ucd9200.c                      |   4 +-
 drivers/hwmon/sbtsi_temp.c                         |   1 -
 drivers/hwmon/scpi-hwmon.c                         |   2 +-
 drivers/hwmon/sht3x.c                              | 389 ++++++++----
 drivers/hwmon/sis5595.c                            |  35 +-
 drivers/hwmon/smm665.c                             | 706 ---------------------
 drivers/hwmon/tmp421.c                             |   2 +-
 drivers/hwmon/tmp464.c                             |   2 +-
 drivers/hwmon/tmp513.c                             |   7 +-
 drivers/hwmon/tps23861.c                           |   2 +-
 drivers/hwmon/ultra45_env.c                        |   3 +-
 drivers/hwmon/vexpress-hwmon.c                     |   1 -
 drivers/hwmon/via686a.c                            |  18 +-
 drivers/hwmon/vt8231.c                             |  11 +-
 drivers/hwmon/w83773g.c                            |   2 +-
 70 files changed, 1452 insertions(+), 1498 deletions(-)
 create mode 100644 Documentation/hwmon/hs3001.rst
 delete mode 100644 Documentation/hwmon/smm665.rst
 create mode 100644 drivers/hwmon/hs3001.c
 delete mode 100644 drivers/hwmon/smm665.c
