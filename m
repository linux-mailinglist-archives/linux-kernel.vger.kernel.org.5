Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBAE7E5EE4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjKHTyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHTyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:54:14 -0500
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ED9C2118;
        Wed,  8 Nov 2023 11:54:11 -0800 (PST)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id E639740A00; Wed,  8 Nov 2023 20:46:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org E639740A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1699472801;
        bh=DmRwMD5Bdcf33AGivhY3dMfmO2YURcEG4E+f3SDwjfY=;
        h=Date:From:To:Cc:Subject:From;
        b=s6o1CZwY9IiPhoU5WZ0hlzVeCPJVG61ihJNt2H/6dFtJhrG7smNpH6CtlG9QVkwMf
         Lpa1x99BjeGp3LIt6Pr79ihdvvpl+8D6rHxz2VYZPx4eEFDBcc/nNM0mxSDphWJpea
         /mLYHeXTZYkPcbE/3P/YGOWlewmbSwbzbDeDZvgo=
Date:   Wed, 8 Nov 2023 20:46:39 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        George Cherian <george.cherian@marvell.com>,
        Huqiang Qin <huqiang.qin@amlogic.com>,
        Jacky Bai <ping.bai@nxp.com>, Janne Grunau <j@jannau.net>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matti =?iso-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
        Michael Shych <michaelsh@nvidia.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Werner Fischer <devlists@wefi.net>,
        Xing Tong Wu <xingtong.wu@siemens.com>,
        Zev Weiss <zev@bewilderbeest.net>
Subject: [GIT PULL REQUEST] watchdog - v6.7 release cycle.
Message-ID: <20231108194639.GA29922@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.20 (2009-12-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull following watchdog changes for the v6.7 release cycle.

This series contains:
* Add support for Amlogic C3 and S4 SoCs
* add IT8613 ID
* Add MSM8226 and MSM8974 compatibles
* Other small fixes and improvements

The output from git request-pull:
----------------------------------------------------------------
The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the git repository at:

  git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.7-rc1

for you to fetch changes up to 9d08e5909c81188eb1df26ef9d1c8df58ea5a44d:

  dt-bindings: watchdog: Add support for Amlogic C3 and S4 SoCs (2023-10-29 19:45:12 +0100)

----------------------------------------------------------------
linux-watchdog 6.7-rc1 tag

----------------------------------------------------------------
Andy Shevchenko (1):
      watchdog: gpio_wdt: Make use of device properties

Bharat Bhushan (1):
      drivers: watchdog: marvell_gti: fix zero pretimeout handling

Dan Carpenter (1):
      watchdog: marvell_gti_wdt: Fix error code in probe()

Darren Hart (1):
      sbsa_gwdt: Calculate timeout with 64-bit math

George Cherian (1):
      drivers: watchdog: marvell_gti: Program the max_hw_heartbeat_ms

Huqiang Qin (1):
      dt-bindings: watchdog: Add support for Amlogic C3 and S4 SoCs

Jacky Bai (3):
      watchdog: imx_sc_wdt: continue if the wdog already enabled
      wdog: imx7ulp: Enable wdog int_en bit for watchdog any reset
      dt-bindings: watchdog: fsl-imx7ulp-wdt: Add 'fsl,ext-reset-output'

Janne Grunau (1):
      watchdog: apple: Deactivate on suspend

Jinjie Ruan (4):
      watchdog: at91sam9_wdt: Use the devm_clk_get_enabled() helper function
      watchdog: ath79_wdt: Use the devm_clk_get_enabled() helper function
      watchdog: sunplus: Use the devm_clk_get_enabled() helper function
      Watchdog: marvell_gti_wdt: Remove redundant dev_err_probe() for platform_get_irq()

Linus Walleij (1):
      watchdog: ixp4xx: Make sure restart always works

Matti Lehtimäki (1):
      dt-bindings: watchdog: qcom-wdt: Add MSM8226 and MSM8974 compatibles

Michael Shych (1):
      watchdog: mlx-wdt: Parameter desctiption warning fix

Rob Herring (2):
      watchdog: st_lpc: Use device_get_match_data()
      watchdog: marvell_gti: Replace of_platform.h with explicit includes

Srinivas Neeli (1):
      watchdog: of_xilinx_wdt: Remove unnecessary clock disable call in the remove path

Werner Fischer (1):
      watchdog: it87_wdt: add IT8613 ID

Xing Tong Wu (1):
      watchdog: wdat_wdt: Add timeout value as a param in ping method

Zev Weiss (2):
      dt-bindings: watchdog: aspeed-wdt: Add aspeed,reset-mask property
      watchdog: aspeed: Add support for aspeed,reset-mask DT property

 .../bindings/watchdog/amlogic,meson-gxbb-wdt.yaml  | 12 ++-
 .../devicetree/bindings/watchdog/aspeed-wdt.txt    | 18 ++++-
 .../bindings/watchdog/fsl-imx7ulp-wdt.yaml         |  5 ++
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |  2 +
 drivers/watchdog/apple_wdt.c                       | 25 ++++++
 drivers/watchdog/aspeed_wdt.c                      | 11 +++
 drivers/watchdog/at91sam9_wdt.c                    | 20 ++---
 drivers/watchdog/ath79_wdt.c                       | 19 +----
 drivers/watchdog/gpio_wdt.c                        | 16 ++--
 drivers/watchdog/imx7ulp_wdt.c                     |  8 ++
 drivers/watchdog/imx_sc_wdt.c                      |  5 +-
 drivers/watchdog/it87_wdt.c                        |  8 +-
 drivers/watchdog/ixp4xx_wdt.c                      | 28 ++++++-
 drivers/watchdog/marvell_gti_wdt.c                 | 14 +++-
 drivers/watchdog/mlx_wdt.c                         |  1 +
 drivers/watchdog/of_xilinx_wdt.c                   | 13 ++-
 drivers/watchdog/sbsa_gwdt.c                       |  4 +-
 drivers/watchdog/st_lpc_wdt.c                      | 11 +--
 drivers/watchdog/sunplus_wdt.c                     | 17 +---
 drivers/watchdog/wdat_wdt.c                        |  2 +-
 include/dt-bindings/watchdog/aspeed-wdt.h          | 92 ++++++++++++++++++++++
 21 files changed, 248 insertions(+), 83 deletions(-)
 create mode 100644 include/dt-bindings/watchdog/aspeed-wdt.h
----------------------------------------------------------------

Kind regards,
Wim.

