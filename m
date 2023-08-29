Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070A478CECF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbjH2VfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbjH2Veu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:34:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A94CA8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:34:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50087d47d4dso7856143e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693344884; x=1693949684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oaVlv6tUCut3MZgi+d135VbILB2oKzrGgB4uFS+DAjE=;
        b=bY9arcjpbzi3pc3jUtyOr1HSV6PGklHVlKSQZ/P1zVd5j0iTit1k9dEEK3rVwr4Pc5
         +iycpwXns/XVIMfmC7BAK8eoRhtqa3tjQOeqob1ppqQfLO+t/uKyjtoRbmlk3rI/4upn
         tP18wVuwjCgFJdJny0WxTV4y57NRRg1kGYQfYMBQx6w1r/q5fPtWqw1Wk3hsdvbKekcy
         IcZfX4bxRXleTsVa0HhkJ3NVtMYiqSrWXtWe6r/FrASNtT1FMQa1uA7m/GMgupr72Ql8
         CcYAkHlvnqektAWz4cBLNxj6fcIn/RYVzzrta/x9ekNbP3rPBISrxgh4wmAo4YMTsVZB
         sTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693344884; x=1693949684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaVlv6tUCut3MZgi+d135VbILB2oKzrGgB4uFS+DAjE=;
        b=gvsIUvxW/9NUBclV/jA8ffRJ2qt/LaqsHoqR+IMXcvH6QGpmacQstwFvTwsPuEHQnL
         e3paKvFIOuKyQXotWnov8IeSnp7qGLYnND0QSGJSU7ec07H624KTwybz4kmtPL/5p8wm
         /c1bDpavWA40cP7YPeNW3YSXM35mlOtiEW8ZDNZoYimFlLJFpmYyWaZ0Kgq0YZH0yuc6
         2g3cu6tzgTJ5OeRoXrF2h9wJmEV6vkuT0Nc7bXWAZs0byBNLFiaB4iJ15clQKz2AwRva
         lDBWL5eQVUpX/fV4pFW+OWmBYsmBUyt2q+4VFqusP0n+/o8FVE4dbf7vv7cQBktiua+D
         hoVw==
X-Gm-Message-State: AOJu0Yz5zUeO1EHEOcSvx3yKj5ssXLRHwyPOrOeej1Y5EovwJDXyTJvd
        F06g22Z0qFDck22jOOe5ps3bGw==
X-Google-Smtp-Source: AGHT+IGMeoddZ4Uqxv7LTbdxlEDiXRAD3cvy/64PQTTsJ+iPQrMszaB0KX2XnU9SQ/scAJFsIbDsBA==
X-Received: by 2002:a19:6914:0:b0:500:b890:fb38 with SMTP id e20-20020a196914000000b00500b890fb38mr97080lfc.24.1693344883430;
        Tue, 29 Aug 2023 14:34:43 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id c3-20020ac244a3000000b0050087b72169sm2078197lfm.24.2023.08.29.14.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 14:34:42 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Ulf Hansson <ulf.hansson@linaro.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: SoC/genpd driver updates for v6.6
Date:   Tue, 29 Aug 2023 23:34:41 +0200
Message-Id: <20230829213441.310655-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a pull-request that introduces the genpd provider subsystem.

Most of the changes have been shared via an immutable branch/tag, which has
been pulled in by Arnd Bergmann into the soc tree. However, as I have also
queued up a couple of additional changes on top, I am sending this pull request
for you.

The changes have been tested in linux-next via
git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git next|fixes

Beyond v6.6-rc1, I am planning to keep sending pull-requests with fixes and new
material for new genpd provider subsystem to you. If you prefer another route,
please let us know.

Kind regards
Ulf Hansson


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/genpd-v6.6

for you to fetch changes up to 5e536362f6ab97f709c07bfda962a7bb036c2563:

  genpd: ti: Use for_each_node_with_property() simplify code logic (2023-08-25 12:04:57 +0200)

----------------------------------------------------------------
This pull-request adds a new subsystem for genpd providers in drivers/genpd
and starts moving some of the corresponding code in there.

We have currently ~60 users of the genpd provider interface, which are
sprinkled across various subsystems. To release some burden from the soc
maintainers (Arnd Bergmann, etc) in particular, but also to gain a better
overall view of what goes on in the area, I will help out with maintenance.

----------------------------------------------------------------
Arnd Bergmann (2):
      soc: starfive: remove stale Makefile entry
      genpd: move owl-sps-helper.c from drivers/soc

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in STARFIVE JH71XX PMU CONTROLLER DRIVER

Peng Fan (7):
      genpd: Makefile: build imx
      genpd: imx: relocate scu-pd under genpd
      genpd: imx: scu-pd: enlarge PD range
      genpd: imx: scu-pd: add more PDs
      genpd: imx: scu-pd: do not power off console if no_console_suspend
      genpd: imx: scu-pd: Suppress bind attrs
      genpd: imx: scu-pd: initialize is_off according to HW state

Rob Herring (1):
      genpd: Explicitly include correct DT includes

Ulf Hansson (18):
      genpd: Create a new subsystem directory to host genpd providers
      soc: actions: Move power-domain driver to the genpd dir
      soc: amlogic: Move power-domain drivers to the genpd dir
      soc: apple: Move power-domain driver to the genpd dir
      soc: bcm: Move power-domain drivers to the genpd dir
      soc: imx: Move power-domain drivers to the genpd dir
      soc: mediatek: Move power-domain drivers to the genpd dir
      soc: qcom: Move power-domain drivers to the genpd dir
      soc: renesas: Move power-domain drivers to the genpd dir
      soc: rockchip: Mover power-domain driver to the genpd dir
      soc: samsung: Move power-domain driver to the genpd dir
      soc: starfive: Move the power-domain driver to the genpd dir
      soc: sunxi: Move power-domain driver to the genpd dir
      soc: tegra: Move powergate-bpmp driver to the genpd dir
      soc: ti: Mover power-domain drivers to the genpd dir
      soc: xilinx: Move power-domain driver to the genpd dir
      ARM: ux500: Convert power-domain code into a regular platform driver
      ARM: ux500: Move power-domain driver to the genpd dir

Zhang Zekun (1):
      genpd: ti: Use for_each_node_with_property() simplify code logic

 MAINTAINERS                                        |  22 +++-
 arch/arm/mach-ux500/Makefile                       |   1 -
 arch/arm/mach-ux500/cpu-db8500.c                   |   5 -
 arch/arm/mach-ux500/pm_domains.h                   |  17 ---
 drivers/Makefile                                   |   1 +
 drivers/firmware/imx/Makefile                      |   1 -
 drivers/genpd/Makefile                             |  17 +++
 drivers/genpd/actions/Makefile                     |   3 +
 drivers/{soc => genpd}/actions/owl-sps-helper.c    |   0
 drivers/{soc => genpd}/actions/owl-sps.c           |   0
 drivers/genpd/amlogic/Makefile                     |   4 +
 drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c     |   0
 drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c |   0
 drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c |   0
 drivers/genpd/apple/Makefile                       |   2 +
 .../apple/pmgr-pwrstate.c}                         |   0
 drivers/genpd/bcm/Makefile                         |   5 +
 drivers/{soc/bcm/bcm63xx => genpd/bcm}/bcm-pmb.c   |   0
 drivers/{soc => genpd}/bcm/bcm2835-power.c         |   0
 .../{soc/bcm/bcm63xx => genpd/bcm}/bcm63xx-power.c |   0
 drivers/{soc => genpd}/bcm/raspberrypi-power.c     |   0
 drivers/genpd/imx/Makefile                         |   8 ++
 drivers/{soc => genpd}/imx/gpc.c                   |   0
 drivers/{soc => genpd}/imx/gpcv2.c                 |   0
 drivers/{soc => genpd}/imx/imx8m-blk-ctrl.c        |   0
 drivers/{soc => genpd}/imx/imx8mp-blk-ctrl.c       |   0
 drivers/{soc => genpd}/imx/imx93-blk-ctrl.c        |   0
 drivers/{soc => genpd}/imx/imx93-pd.c              |   0
 drivers/{firmware => genpd}/imx/scu-pd.c           | 138 +++++++++++++++++++--
 drivers/genpd/mediatek/Makefile                    |   3 +
 .../{soc => genpd}/mediatek/mt6795-pm-domains.h    |   0
 .../{soc => genpd}/mediatek/mt8167-pm-domains.h    |   0
 .../{soc => genpd}/mediatek/mt8173-pm-domains.h    |   0
 .../{soc => genpd}/mediatek/mt8183-pm-domains.h    |   0
 .../{soc => genpd}/mediatek/mt8186-pm-domains.h    |   0
 .../{soc => genpd}/mediatek/mt8188-pm-domains.h    |   0
 .../{soc => genpd}/mediatek/mt8192-pm-domains.h    |   0
 .../{soc => genpd}/mediatek/mt8195-pm-domains.h    |   0
 drivers/{soc => genpd}/mediatek/mtk-pm-domains.c   |   2 +-
 drivers/{soc => genpd}/mediatek/mtk-pm-domains.h   |   0
 drivers/{soc => genpd}/mediatek/mtk-scpsys.c       |   2 +-
 drivers/genpd/qcom/Makefile                        |   4 +
 drivers/{soc => genpd}/qcom/cpr.c                  |   0
 drivers/{soc => genpd}/qcom/rpmhpd.c               |   0
 drivers/{soc => genpd}/qcom/rpmpd.c                |   0
 drivers/genpd/renesas/Makefile                     |  30 +++++
 drivers/{soc => genpd}/renesas/r8a7742-sysc.c      |   0
 drivers/{soc => genpd}/renesas/r8a7743-sysc.c      |   0
 drivers/{soc => genpd}/renesas/r8a7745-sysc.c      |   0
 drivers/{soc => genpd}/renesas/r8a77470-sysc.c     |   0
 drivers/{soc => genpd}/renesas/r8a774a1-sysc.c     |   0
 drivers/{soc => genpd}/renesas/r8a774b1-sysc.c     |   0
 drivers/{soc => genpd}/renesas/r8a774c0-sysc.c     |   0
 drivers/{soc => genpd}/renesas/r8a774e1-sysc.c     |   0
 drivers/{soc => genpd}/renesas/r8a7779-sysc.c      |   0
 drivers/{soc => genpd}/renesas/r8a7790-sysc.c      |   0
 drivers/{soc => genpd}/renesas/r8a7791-sysc.c      |   0
 drivers/{soc => genpd}/renesas/r8a7792-sysc.c      |   0
 drivers/{soc => genpd}/renesas/r8a7794-sysc.c      |   0
 drivers/{soc => genpd}/renesas/r8a7795-sysc.c      |   0
 drivers/{soc => genpd}/renesas/r8a7796-sysc.c      |   0
 drivers/{soc => genpd}/renesas/r8a77965-sysc.c     |   0
 drivers/{soc => genpd}/renesas/r8a77970-sysc.c     |   0
 drivers/{soc => genpd}/renesas/r8a77980-sysc.c     |   0
 drivers/{soc => genpd}/renesas/r8a77990-sysc.c     |   0
 drivers/{soc => genpd}/renesas/r8a77995-sysc.c     |   0
 drivers/{soc => genpd}/renesas/r8a779a0-sysc.c     |   0
 drivers/{soc => genpd}/renesas/r8a779f0-sysc.c     |   0
 drivers/{soc => genpd}/renesas/r8a779g0-sysc.c     |   0
 drivers/{soc => genpd}/renesas/rcar-gen4-sysc.c    |   0
 drivers/{soc => genpd}/renesas/rcar-gen4-sysc.h    |   0
 drivers/{soc => genpd}/renesas/rcar-sysc.c         |   0
 drivers/{soc => genpd}/renesas/rcar-sysc.h         |   0
 drivers/{soc => genpd}/renesas/rmobile-sysc.c      |   0
 drivers/genpd/rockchip/Makefile                    |   2 +
 .../pm_domains.c => genpd/rockchip/pm-domains.c}   |   0
 drivers/genpd/samsung/Makefile                     |   2 +
 .../samsung/exynos-pm-domains.c}                   |   0
 drivers/genpd/st/Makefile                          |   2 +
 .../genpd/st/ste-ux500-pm-domain.c                 |  25 +++-
 drivers/genpd/starfive/Makefile                    |   2 +
 .../jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c}   |   0
 drivers/genpd/sunxi/Makefile                       |   2 +
 drivers/{soc => genpd}/sunxi/sun20i-ppu.c          |   2 +-
 drivers/genpd/tegra/Makefile                       |   2 +
 drivers/{soc => genpd}/tegra/powergate-bpmp.c      |   0
 drivers/genpd/ti/Makefile                          |   3 +
 drivers/{soc => genpd}/ti/omap_prm.c               |   0
 drivers/{soc => genpd}/ti/ti_sci_pm_domains.c      |   8 +-
 drivers/genpd/xilinx/Makefile                      |   2 +
 .../xilinx/zynqmp-pm-domains.c}                    |   0
 drivers/soc/Makefile                               |   2 -
 drivers/soc/actions/Makefile                       |   4 -
 drivers/soc/amlogic/Makefile                       |   3 -
 drivers/soc/apple/Makefile                         |   2 -
 drivers/soc/bcm/Kconfig                            |  22 +++-
 drivers/soc/bcm/Makefile                           |   3 -
 drivers/soc/bcm/bcm63xx/Kconfig                    |  21 ----
 drivers/soc/bcm/bcm63xx/Makefile                   |   3 -
 drivers/soc/imx/Makefile                           |   7 +-
 drivers/soc/mediatek/Makefile                      |   2 -
 drivers/soc/qcom/Makefile                          |   3 -
 drivers/soc/renesas/Makefile                       |  27 ----
 drivers/soc/rockchip/Makefile                      |   1 -
 drivers/soc/samsung/Makefile                       |   1 -
 drivers/soc/starfive/Makefile                      |   3 -
 drivers/soc/sunxi/Makefile                         |   1 -
 drivers/soc/tegra/Makefile                         |   1 -
 drivers/soc/ti/Makefile                            |   2 -
 drivers/soc/xilinx/Makefile                        |   1 -
 110 files changed, 288 insertions(+), 138 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/pm_domains.h
 create mode 100644 drivers/genpd/Makefile
 create mode 100644 drivers/genpd/actions/Makefile
 rename drivers/{soc => genpd}/actions/owl-sps-helper.c (100%)
 rename drivers/{soc => genpd}/actions/owl-sps.c (100%)
 create mode 100644 drivers/genpd/amlogic/Makefile
 rename drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c (100%)
 rename drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c (100%)
 rename drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c (100%)
 create mode 100644 drivers/genpd/apple/Makefile
 rename drivers/{soc/apple/apple-pmgr-pwrstate.c => genpd/apple/pmgr-pwrstate.c} (100%)
 create mode 100644 drivers/genpd/bcm/Makefile
 rename drivers/{soc/bcm/bcm63xx => genpd/bcm}/bcm-pmb.c (100%)
 rename drivers/{soc => genpd}/bcm/bcm2835-power.c (100%)
 rename drivers/{soc/bcm/bcm63xx => genpd/bcm}/bcm63xx-power.c (100%)
 rename drivers/{soc => genpd}/bcm/raspberrypi-power.c (100%)
 create mode 100644 drivers/genpd/imx/Makefile
 rename drivers/{soc => genpd}/imx/gpc.c (100%)
 rename drivers/{soc => genpd}/imx/gpcv2.c (100%)
 rename drivers/{soc => genpd}/imx/imx8m-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx8mp-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx93-blk-ctrl.c (100%)
 rename drivers/{soc => genpd}/imx/imx93-pd.c (100%)
 rename drivers/{firmware => genpd}/imx/scu-pd.c (75%)
 create mode 100644 drivers/genpd/mediatek/Makefile
 rename drivers/{soc => genpd}/mediatek/mt6795-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8167-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8173-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8183-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8186-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8188-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8192-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mt8195-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.c (99%)
 rename drivers/{soc => genpd}/mediatek/mtk-pm-domains.h (100%)
 rename drivers/{soc => genpd}/mediatek/mtk-scpsys.c (99%)
 create mode 100644 drivers/genpd/qcom/Makefile
 rename drivers/{soc => genpd}/qcom/cpr.c (100%)
 rename drivers/{soc => genpd}/qcom/rpmhpd.c (100%)
 rename drivers/{soc => genpd}/qcom/rpmpd.c (100%)
 create mode 100644 drivers/genpd/renesas/Makefile
 rename drivers/{soc => genpd}/renesas/r8a7742-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7743-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7745-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77470-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774a1-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774b1-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774c0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a774e1-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7779-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7790-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7791-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7792-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7794-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7795-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a7796-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77965-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77970-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77980-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77990-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a77995-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a779a0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a779f0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/r8a779g0-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/rcar-gen4-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/rcar-gen4-sysc.h (100%)
 rename drivers/{soc => genpd}/renesas/rcar-sysc.c (100%)
 rename drivers/{soc => genpd}/renesas/rcar-sysc.h (100%)
 rename drivers/{soc => genpd}/renesas/rmobile-sysc.c (100%)
 create mode 100644 drivers/genpd/rockchip/Makefile
 rename drivers/{soc/rockchip/pm_domains.c => genpd/rockchip/pm-domains.c} (100%)
 create mode 100644 drivers/genpd/samsung/Makefile
 rename drivers/{soc/samsung/pm_domains.c => genpd/samsung/exynos-pm-domains.c} (100%)
 create mode 100644 drivers/genpd/st/Makefile
 rename arch/arm/mach-ux500/pm_domains.c => drivers/genpd/st/ste-ux500-pm-domain.c (75%)
 create mode 100644 drivers/genpd/starfive/Makefile
 rename drivers/{soc/starfive/jh71xx_pmu.c => genpd/starfive/jh71xx-pmu.c} (100%)
 create mode 100644 drivers/genpd/sunxi/Makefile
 rename drivers/{soc => genpd}/sunxi/sun20i-ppu.c (99%)
 create mode 100644 drivers/genpd/tegra/Makefile
 rename drivers/{soc => genpd}/tegra/powergate-bpmp.c (100%)
 create mode 100644 drivers/genpd/ti/Makefile
 rename drivers/{soc => genpd}/ti/omap_prm.c (100%)
 rename drivers/{soc => genpd}/ti/ti_sci_pm_domains.c (97%)
 create mode 100644 drivers/genpd/xilinx/Makefile
 rename drivers/{soc/xilinx/zynqmp_pm_domains.c => genpd/xilinx/zynqmp-pm-domains.c} (100%)
 delete mode 100644 drivers/soc/actions/Makefile
 delete mode 100644 drivers/soc/bcm/bcm63xx/Kconfig
 delete mode 100644 drivers/soc/bcm/bcm63xx/Makefile
 delete mode 100644 drivers/soc/starfive/Makefile
