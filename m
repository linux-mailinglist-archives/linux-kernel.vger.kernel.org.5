Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E66792FE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbjIEUYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjIEUYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:24:07 -0400
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:24:01 PDT
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB450F4;
        Tue,  5 Sep 2023 13:24:01 -0700 (PDT)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id E2EEC409FE; Tue,  5 Sep 2023 22:13:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org E2EEC409FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1693944807;
        bh=UV5JmUshUZIHsvrl8TvZV8/cDSxmgS4+Z4Dn8PYNMVc=;
        h=Date:From:To:Cc:Subject:From;
        b=fW/ieQs3m1aKtkIlEDnMTpUT4/v3JSVKDbnL1f+RDL/aSGxqhW7eGXk8W7HQ9qn/e
         S4Gx2osQ+dGRoBfP9DYsrp3tSL+Zg5dE7fLqXkRJlrt3X7ZfMIs8kgiVty6wDTbPED
         VMZZ1u5nk6hG2M7jTR4N7R+VVSaAf8YOPLOHyRwM=
Date:   Tue, 5 Sep 2023 22:13:27 +0200
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Chengfeng Ye <dg573847474@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Florent CARLI <fcarli@gmail.com>,
        Huqiang Qin <huqiang.qin@amlogic.com>,
        Li Hua Qian <huaqian.li@siemens.com>,
        Li Zetao <lizetao1@huawei.com>,
        Mathieu Othacehe <othacehe@gnu.org>,
        Meng Li <meng.li@windriver.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Raag Jadav <raag.jadav@intel.com>,
        Robert Marko <robimarko@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ruan Jinjie <ruanjinjie@huawei.com>
Subject: [GIT PULL REQUEST] watchdog - v6.6 release cycle.
Message-ID: <20230905201327.GA31462@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull following watchdog changes for the v5.19 release cycle.

This series contains:
* Add marvell GTI watchdog driver
* Add support for Amlogic-T7 SoCs
* Document the IPQ5018 watchdog compatible
* Enable COMPILE_TEST for more watchdog device drivers
* core: stop watchdog when executing poweroff command
* Other small improvements and fixes

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.6-rc1

for you to fetch changes up to 8c776a0401f1dcfcfc8e5549c5260668bec59c0e:

  watchdog: Add support for Amlogic-T7 SoCs (2023-08-25 16:19:15 +0200)

----------------------------------------------------------------
linux-watchdog 6.6-rc1 tag

----------------------------------------------------------------
Bharat Bhushan (2):
      dt-bindings: watchdog: marvell GTI system watchdog driver
      Watchdog: Add marvell GTI watchdog driver

Chengfeng Ye (1):
      watchdog: s3c2410: Fix potential deadlock on &wdt->lock

Fabio Estevam (1):
      watchdog: imx2_wdt: Improve dev_crit() message

Florent CARLI (1):
      watchdog: advantech_ec_wdt: fix Kconfig dependencies

Huqiang Qin (3):
      dt-bindings: watchdog: Add support for Amlogic-T7 SoCs
      watchdog: Add a new struct for Amlogic-GXBB driver
      watchdog: Add support for Amlogic-T7 SoCs

Li Hua Qian (2):
      dt-bindings: watchdog: ti,rti-wdt: Add support for WDIOF_CARDRESET
      watchdog:rit_wdt: Add support for WDIOF_CARDRESET

Li Zetao (1):
      watchdog: menz069_wdt: Remove redundant initialization owner in men_z069_driver

Mathieu Othacehe (1):
      watchdog: sama5d4: readout initial state

Meng Li (1):
      watchdog: core: stop watchdog when executing poweroff command

Nathan Chancellor (1):
      watchdog: xilinx_wwdt: Use div_u64() in xilinx_wwdt_start()

Paul Cercueil (1):
      watchdog: starfive: Remove #ifdef guards for PM related functions

Raag Jadav (1):
      watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow auto-load

Rob Herring (3):
      watchdog: Explicitly include correct DT includes
      watchdog: Enable COMPILE_TEST for more drivers
      watchdog: stm32: Drop unnecessary of_match_ptr()

Robert Marko (1):
      dt-bindings: watchdog: qcom-wdt: document IPQ5018

Ruan Jinjie (1):
      watchdog: pm8916_wdt: Remove redundant of_match_ptr()

 .../bindings/watchdog/amlogic,meson-gxbb-wdt.yaml  |   1 +
 .../bindings/watchdog/marvell,cn10624-wdt.yaml     |  83 +++++
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |   1 +
 .../devicetree/bindings/watchdog/ti,rti-wdt.yaml   |  28 +-
 drivers/watchdog/Kconfig                           |  95 +++---
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/armada_37xx_wdt.c                 |   1 -
 drivers/watchdog/at91rm9200_wdt.c                  |   3 +-
 drivers/watchdog/cpwd.c                            |   2 +-
 drivers/watchdog/ftwdt010_wdt.c                    |   6 +-
 drivers/watchdog/gef_wdt.c                         |   2 +-
 drivers/watchdog/imx2_wdt.c                        |   5 +-
 drivers/watchdog/imx7ulp_wdt.c                     |   1 -
 drivers/watchdog/intel-mid_wdt.c                   |   1 +
 drivers/watchdog/lantiq_wdt.c                      |   3 +-
 drivers/watchdog/loongson1_wdt.c                   |   1 +
 drivers/watchdog/marvell_gti_wdt.c                 | 340 +++++++++++++++++++++
 drivers/watchdog/menz69_wdt.c                      |   1 -
 drivers/watchdog/meson_gxbb_wdt.c                  |  21 +-
 drivers/watchdog/meson_wdt.c                       |   4 +-
 drivers/watchdog/mpc8xxx_wdt.c                     |   4 +-
 drivers/watchdog/mtk_wdt.c                         |   1 -
 drivers/watchdog/of_xilinx_wdt.c                   |   3 +-
 drivers/watchdog/pic32-dmt.c                       |   1 -
 drivers/watchdog/pic32-wdt.c                       |   1 -
 drivers/watchdog/pika_wdt.c                        |   2 +-
 drivers/watchdog/pm8916_wdt.c                      |   2 +-
 drivers/watchdog/qcom-wdt.c                        |   1 -
 drivers/watchdog/rave-sp-wdt.c                     |   2 +-
 drivers/watchdog/riowd.c                           |   2 +-
 drivers/watchdog/rti_wdt.c                         |  48 +++
 drivers/watchdog/rza_wdt.c                         |   4 +-
 drivers/watchdog/rzg2l_wdt.c                       |   2 +-
 drivers/watchdog/s3c2410_wdt.c                     |  16 +-
 drivers/watchdog/sama5d4_wdt.c                     |   8 +-
 drivers/watchdog/sbsa_gwdt.c                       |   3 +-
 drivers/watchdog/starfive-wdt.c                    |  13 +-
 drivers/watchdog/stm32_iwdg.c                      |   3 +-
 drivers/watchdog/sunxi_wdt.c                       |   1 -
 drivers/watchdog/watchdog_core.c                   |   2 +-
 drivers/watchdog/xilinx_wwdt.c                     |   7 +-
 41 files changed, 625 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml
 create mode 100644 drivers/watchdog/marvell_gti_wdt.c
----------------------------------------------------------------

Kind regards,
Wim.

