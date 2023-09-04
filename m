Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB540791BED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349125AbjIDRR4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Sep 2023 13:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjIDRRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:17:55 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0822CDB;
        Mon,  4 Sep 2023 10:17:51 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1c134602a55so390357fac.1;
        Mon, 04 Sep 2023 10:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693847871; x=1694452671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8k0ChYUiH1C/yKr25inV4dt0+WLlcX9Vgm2MaZ38ABQ=;
        b=BGAFknwiphQdMSP/tx7yWaHA5XoF0/kPBJ7AYRDyETh+8os07YnK7E4TUVYXH7x9Fz
         +HtED1dDAhb+pP38w84gxsRZJb7dk/v1rKm6wXfv4Z9lj80icns7/RgIiopQyfLnsN0I
         dW3F8/oBtPrPJ+aqsvm/z4e0aGX/r0TWjx46vQjbUONHTLJ+JfEFGH/D9J9xlsN3wqpw
         9pEEhuluGHJszWfp5SQ/caT/9K4L2g/ozMciNTtXB35MwR1Z5MMZkBX/IB6tY1VoyrQG
         eKhuA/gs4GblfZlJ/8TJgZS8SfZEBOEB6BQ/8bAPcw/C6pe93WWp4DPWd8SN1r/QhUAG
         2YPQ==
X-Gm-Message-State: AOJu0YzD+2Ih07n70T0LvlLkvqz+h36PGgLiRZ8/aMI1gSZO+FfjoS6D
        l5o2yqgx6ld7c7b5sgzawmOa96J47SUlq06XEdE=
X-Google-Smtp-Source: AGHT+IF/FrH15T3TcgVVDQM/HgBHTYL0uKRLYlu4zAVKHcaZ+3itB33hR3wkfKx7nA9AF614kjJfVrhiiVMMfuHcPOA=
X-Received: by 2002:a4a:764d:0:b0:573:55af:777c with SMTP id
 w13-20020a4a764d000000b0057355af777cmr9524198ooe.0.1693847870994; Mon, 04 Sep
 2023 10:17:50 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 4 Sep 2023 19:17:40 +0200
Message-ID: <CAJZ5v0i5XLwN8vpR+MdECHVusMBowtWfDb-fQZDjip+hcoagMA@mail.gmail.com>
Subject: [GIT PULL] More thermal control updates for v6.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.6-rc1-2

with top-most commit 8289d810ea85755a9d22f75785806cb34eecd5e5

 thermal: core: Rework .get_trend() thermal zone callback

on top of commit 36534782b584389afd281f326421a35dcecde1ec

 Merge tag 'thermal-6.6-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more thermal control updates for 6.6-rc1.

These are mostly updates of thermal control drivers for ARM platforms,
new thermal control support for Loongson-2 and a couple of core cleanups
made possible by recent changes merged previously.

Specifics:

  - Check if the Tegra BPMP supports the trip points in order to set the
    .set_trips callback (Mikko Perttunen).

  - Add new Loongson-2 thermal sensor along with the DT bindings (Yinbo
    Zhu).

  - Use IS_ERR_OR_NULL() helper to replace a double test on the TI
    bandgap sensor (Li Zetao).

  - Remove redundant platform_set_drvdata() calls, as there are no
    corresponding calls to platform_get_drvdata(), from a bunch of
    drivers (Andrei Coardos).

  - Switch the Mediatek LVTS mode to filtered in order to enable
    interrupts (Nícolas F. R. A. Prado).

  - Fix Wvoid-pointer-to-enum-cast warning on the Exynos TMU (Krzysztof
    Kozlowski).

  - Remove redundant dev_err_probe(), because the underlying function
    already called it, from the Mediatek sensor (Chen Jiahao).

   - Free calibration nvmem after reading it on sun8i (Mark Brown).

   - Remove useless comment from the sun8i driver (Yangtao Li).

   - Make tsens_xxxx_nvmem static to fix a sparse warning on QCom
     tsens (Min-Hua Chen).

   - Remove error message at probe deferral on imx8mm (Ahmad Fatoum).

   - Fix parameter check in lvts_debugfs_init() with IS_ERR() on
     Mediatek LVTS (Minjie Du).

   - Fix interrupt routine and configuration for Mediatek LVTS (Nícolas
     F. R. A. Prado).

   - Drop unused .get_trip_type(), .get_trip_temp() and .get_trip_hyst()
     thermal zone callbacks from the core and rework the .get_trend()
     one to take a trip point pointer as an argument (Rafael Wysocki).

Thanks!


---------------

Ahmad Fatoum (1):
      thermal/drivers/imx8mm: Suppress log message on probe deferral

Andrei Coardos (8):
      thermal/drivers/broadcom/sr-thermal: Removed call to
platform_set_drvdata()
      thermal/drivers/k3_j72xx_bandgap: Removed unneeded call to
platform_set_drvdata()
      thermal/drivers/k3_bandgap: Remove unneeded call to platform_set_drvdata()
      thermal/drivers/broadcom/brcstb_thermal: Removed unneeded
platform_set_drvdata()
      thermal/drivers/sun8i_thermal: Remove unneeded call to
platform_set_drvdata()
      thermal/drivers/mediatek/auxadc_thermal: Removed call to
platform_set_drvdata()
      thermal/drivers/max77620_thermal: Removed unneeded call to
platform_set_drvdata()
      thermal/drivers/generic-adc: Removed unneeded call to
platform_set_drvdata()

Chen Jiahao (1):
      thermal/drivers/mediatek: Clean up redundant dev_err_probe()

Krzysztof Kozlowski (1):
      thermal/drivers/samsung: Fix Wvoid-pointer-to-enum-cast warning

Li Zetao (1):
      thermal/drivers/ti-soc-thermal: Use helper function IS_ERR_OR_NULL()

Mark Brown (1):
      thermal/drivers/sun8i: Free calibration nvmem after reading it

Mikko Perttunen (1):
      thermal/drivers/tegra-bpmp: Check if BPMP supports trip points

Min-Hua Chen (1):
      thermal/drivers/tsens: Make tsens_xxxx_nvmem static

Minjie Du (1):
      thermal/drivers/mediatek/lvts: Fix parameter check in lvts_debugfs_init()

Nícolas F. R. A. Prado (7):
      thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers
      thermal/drivers/mediatek/lvts_thermal: Honor sensors in immediate mode
      thermal/drivers/mediatek/lvts_thermal: Use offset threshold for IRQ
      thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts
      thermal/drivers/mediatek/lvts_thermal: Don't leave threshold zeroed
      thermal/drivers/mediatek/lvts_thermal: Manage threshold between sensors
      thermal/drivers/mediatek/lvts_thermal: Make readings valid in
filtered mode

Rafael J. Wysocki (2):
      thermal: core: Drop unused .get_trip_*() callbacks
      thermal: core: Rework .get_trend() thermal zone callback

Ruan Jinjie (1):
      thermal/drivers/db8500: Remove redundant of_match_ptr()

Yangtao Li (1):
      thermal/drivers/sun8i: Remove unneeded comments

Yinbo Zhu (2):
      thermal/drivers/loongson-2: Add thermal management support
      thermal: dt-bindings: add loongson-2 thermal

---------------

 .../bindings/thermal/loongson,ls2k-thermal.yaml    |  44 ++++++
 MAINTAINERS                                        |   8 +
 drivers/acpi/thermal.c                             |  41 +++--
 drivers/thermal/Kconfig                            |  12 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/broadcom/brcmstb_thermal.c         |   1 -
 drivers/thermal/broadcom/sr-thermal.c              |   1 -
 drivers/thermal/db8500_thermal.c                   |   2 +-
 drivers/thermal/imx8mm_thermal.c                   |   6 +-
 drivers/thermal/k3_bandgap.c                       |   1 -
 drivers/thermal/k3_j72xx_bandgap.c                 |   2 -
 drivers/thermal/loongson2_thermal.c                | 169 ++++++++++++++++++++
 drivers/thermal/max77620_thermal.c                 |   2 -
 drivers/thermal/mediatek/auxadc_thermal.c          |   2 -
 drivers/thermal/mediatek/lvts_thermal.c            | 175 +++++++++++++++------
 drivers/thermal/qcom/tsens-v0_1.c                  |   6 +-
 drivers/thermal/qcom/tsens-v1.c                    |   2 +-
 drivers/thermal/samsung/exynos_tmu.c               |   2 +-
 drivers/thermal/sun8i_thermal.c                    |   8 +-
 drivers/thermal/tegra/tegra-bpmp-thermal.c         |  52 +++++-
 drivers/thermal/thermal-generic-adc.c              |   1 -
 drivers/thermal/thermal_core.c                     |   2 +-
 drivers/thermal/thermal_core.h                     |   2 +-
 drivers/thermal/thermal_helpers.c                  |   3 +-
 drivers/thermal/thermal_trip.c                     |  24 +--
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   2 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   3 +-
 include/linux/thermal.h                            |  34 ++--
 28 files changed, 468 insertions(+), 140 deletions(-)
