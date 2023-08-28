Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96D378B13D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjH1NAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjH1M7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:59:50 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C479124;
        Mon, 28 Aug 2023 05:59:46 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6bcde3d8657so526798a34.0;
        Mon, 28 Aug 2023 05:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693227585; x=1693832385;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4peBhLu8MQYvl58M18+OddTFKDm1vPPiYRnwVgiDEuw=;
        b=hJYUCRipf7Tublwr2gNX+Fi4xKLCiClTM6IF9jEQB9CpTBFIOERLe3mPvPuhNwxXjv
         bE+L2JvJQXp0/b1SNMSEYsgBipY0DtW6U5hH7ktQYw+MOqSkCI0BkxRtCt1GEx1qayGn
         jrqSnXhFZkPA91Ylkhm6RmD11hNBIDSpy8HdpCnLfV8U7mWM2+P1iHz9nrAJbtaYfoHd
         9eyu2eJKHeN2RsuUGHCCd67JKNpqa3UvY15nImICWrpWNEia02JyUYbGIs+U24qovUbO
         GZVofEegAE1HEfaHiglJanQJYDDOg2xgpXKP6aSOz28ITggKBe4HqnwhwzJX0nS+BFdV
         ZOhQ==
X-Gm-Message-State: AOJu0YyPjt2sW3O8MHLp81+/+P9L4Hl9zRklq74JnCiOtLNmK0AszwKE
        g82HEY1Ra/zvuqVJN9PLksIxXnMdQAQswYrVa/Xx0ZWWw2o=
X-Google-Smtp-Source: AGHT+IEKIV74YEZNmAQZAup+hhRnecO7BgzZpXRsolmcmWiKv3V1Z0iSoQNx950A9Puhnc8cjEdR7dYUsxtHUjjR6lI=
X-Received: by 2002:a4a:df4f:0:b0:573:764b:3b8d with SMTP id
 j15-20020a4adf4f000000b00573764b3b8dmr4167747oou.0.1693227583846; Mon, 28 Aug
 2023 05:59:43 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Aug 2023 14:59:29 +0200
Message-ID: <CAJZ5v0hWmfVHqaaD5kPiXx-M8-oHFdzwG327FERVPF4RnR285g@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.6-rc1

with top-most commit d08122864e7d127d3481c97f9e8afda1371e116b

 Merge updates of thermal drivers for Intel platforms for 6.6-rc1.

on top of commit ac4436a5b20e0ef1f608a9ef46c08d5d142f8da6

 thermal: of: fix double-free on unregistration

to receive thermal control updates for 6.6-rc1.

These rework the Intel DTS IOSF and the ACPI thermal drivers to pass
tables of generic trip point structures to the core during
initialization and make some requisite modifications in the thermal
core, fix a few issues elsewhere and clean up code.

This includes changes that are present in the ACPI updates for
6.6-rc1 pull request too, because they involve both ACPI and the
thermal core.  The list of specific changes below is limited to thermal
control, however.

Specifics:

 - Make the ACPI thermal driver use its own Notify() handler (Michal
   Wilczynski).

 - Rework the ACPI thermal driver to use a table of generic trip point
   structures on top of the internal representation of trip points and
   remove thermal zone callbacks that are not necessary any more from
   that driver (Rafael Wysocki).

 - Fix a few issues in the Intel DTS IOSF thermal driver, clean up code
   in it and make it pass tables of generic trip point structures to the
   core during thermal zone registration (Rafael Wysocki).

 - Drop a redundant check from the Intel DTS IOSF thermal driver's
   "remove" routine (Zhang Rui).

 - Use module_platform_driver() to replace an open-coded counterpart of
   it in the int340x thermal driver (Yang Yingliang).

 - Fix possible uninitialized value access in __thermal_of_bind() and
   __thermal_of_unbind() (Peng Fan).

 - Make the int3400 driver use thermal zone device wrappers (Daniel
   Lezcano).

 - Remove redundant thermal zone state check from the int340x thermal
   driver (Daniel Lezcano).

 - Drop non-functional nocrt parameter from ACPI thermal (Mario
   Limonciello).

 - Explicitly include correct DT includes in the thermal core and
   drivers (Rob Herring).

Thanks!


---------------

Daniel Lezcano (2):
      thermal/drivers/int3400: Use thermal zone device wrappers
      thermal/drivers/int340x: Do not check the thermal zone state

Mario Limonciello (1):
      ACPI: thermal: Drop nocrt parameter

Michal Wilczynski (9):
      ACPI: bus: Introduce wrappers for ACPICA notify handler install/remove
      ACPI: bus: Set driver_data to NULL every time .add() fails
      ACPI: AC: Install Notify() handler directly
      ACPI: video: Install Notify() handler directly
      ACPI: battery: Install Notify() handler directly
      ACPI: HED: Install Notify() handler directly
      ACPI: NFIT: Install Notify() handler directly
      ACPI: NFIT: Remove unnecessary .remove callback
      ACPI: thermal: Install Notify() handler directly

Peng Fan (1):
      thermal/of: Fix potential uninitialized value access

Rafael J. Wysocki (23):
      ACPI: thermal: Drop enabled flag from struct acpi_thermal_active
      ACPI: thermal: Do not attach private data to ACPI handles
      ACPI: thermal: Drop redundant local variable from acpi_thermal_resume()
      thermal: core: Do not handle trip points with invalid temperature
      thermal: intel: intel_soc_dts_iosf: Always use 2 trips
      thermal: intel: intel_soc_dts_iosf: Drop redundant symbol definition
      thermal: intel: intel_soc_dts_iosf: Always assume notification support
      thermal: intel: intel_soc_dts_iosf: Untangle update_trip_temp()
      thermal: intel: intel_soc_dts_iosf: Pass sensors to update_trip_temp()
      thermal: intel: intel_soc_dts_iosf: Change initialization ordering
      thermal: intel: intel_soc_dts_iosf: Add helper for resetting trip points
      thermal: intel: intel_soc_dts_iosf: Rework critical trip setup
      thermal: intel: intel_soc_dts_iosf: Use struct thermal_trip
      thermal: core: Introduce thermal_zone_device_exec()
      thermal: core: Add priv pointer to struct thermal_trip
      ACPI: thermal: Clean up acpi_thermal_register_thermal_zone()
      ACPI: thermal: Carry out trip point updates under zone lock
      ACPI: thermal: Introduce struct acpi_thermal_trip
      thermal: core: Rework and rename __for_each_thermal_trip()
      ACPI: thermal: Use trip point table to register thermal zones
      ACPI: thermal: Rework thermal_get_trend()
      ACPI: thermal: Drop unnecessary thermal zone callbacks
      ACPI: thermal: Eliminate code duplication from acpi_thermal_notify()

Rob Herring (1):
      thermal: Explicitly include correct DT includes

Yang Yingliang (1):
      thermal: intel: int340x: simplify the code with module_platform_driver()

Zhang Rui (1):
      thermal: intel: intel_soc_dts_iosf: Remove redundant check

---------------

 Documentation/admin-guide/kernel-parameters.txt    |   4 -
 drivers/acpi/ac.c                                  |  27 +-
 drivers/acpi/acpi_video.c                          |  20 +-
 drivers/acpi/battery.c                             |  24 +-
 drivers/acpi/bus.c                                 |  28 +-
 drivers/acpi/hed.c                                 |  15 +-
 drivers/acpi/nfit/core.c                           |  42 +-
 drivers/acpi/thermal.c                             | 470 ++++++++++-----------
 drivers/thermal/amlogic_thermal.c                  |   2 -
 drivers/thermal/broadcom/bcm2711_thermal.c         |   2 +-
 drivers/thermal/broadcom/brcmstb_thermal.c         |   2 +-
 drivers/thermal/hisi_thermal.c                     |   2 +-
 drivers/thermal/imx8mm_thermal.c                   |   1 -
 drivers/thermal/imx_sc_thermal.c                   |   1 -
 drivers/thermal/imx_thermal.c                      |   2 +-
 .../intel/int340x_thermal/int3400_thermal.c        |  44 +-
 .../intel/int340x_thermal/int3401_thermal.c        |  13 +-
 .../processor_thermal_device_pci_legacy.c          |   2 +-
 drivers/thermal/intel/intel_soc_dts_iosf.c         | 188 +++------
 drivers/thermal/intel/intel_soc_dts_iosf.h         |  15 +-
 drivers/thermal/intel/intel_soc_dts_thermal.c      |  17 +-
 drivers/thermal/k3_bandgap.c                       |   2 +-
 drivers/thermal/k3_j72xx_bandgap.c                 |   2 +-
 drivers/thermal/mediatek/auxadc_thermal.c          |   1 -
 drivers/thermal/mediatek/lvts_thermal.c            |   2 +-
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           |   1 -
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   1 -
 drivers/thermal/rcar_gen3_thermal.c                |   2 +-
 drivers/thermal/rcar_thermal.c                     |   2 +-
 drivers/thermal/rzg2l_thermal.c                    |   2 +-
 drivers/thermal/samsung/exynos_tmu.c               |   2 +-
 drivers/thermal/sprd_thermal.c                     |   2 +-
 drivers/thermal/st/stm_thermal.c                   |   2 -
 drivers/thermal/sun8i_thermal.c                    |   2 +-
 drivers/thermal/tegra/tegra30-tsensor.c            |   2 +-
 drivers/thermal/thermal_core.c                     |  22 +-
 drivers/thermal/thermal_core.h                     |   4 -
 drivers/thermal/thermal_of.c                       |  11 +-
 drivers/thermal/thermal_trip.c                     |  18 +-
 drivers/thermal/uniphier_thermal.c                 |   1 -
 include/acpi/acpi_bus.h                            |   6 +
 include/linux/thermal.h                            |   9 +
 42 files changed, 508 insertions(+), 509 deletions(-)
