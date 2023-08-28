Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E7578AFD6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjH1MQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjH1MP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:15:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D590AEA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:15:52 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5007c8308c3so4914115e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693224951; x=1693829751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfY+430Mmt3Y+JnQoDV9LCldHPmAfJHhgnZVMksWZmU=;
        b=iCfIQLPrqav92YrYCWlo3tOEQQEndymyw2iWXIo8gIpcnGNVco5f3KN6fVNXZkrU49
         Ylh3unpU6Cu+UG39+AOBf9ettTehvBU4fNZm1XAv627HysGoneX11molsywbERNSuxaY
         XoG5kWHqBbgKI0Ga6qdv00aeJGWrCQVeMlbFsh1T0mGAFnk/8sPUz/4SVzYsHzFhjEhR
         VXU3FJ9qQB5HuVUa12GH7sWNTtauKkXC8Ou3m0nto8xMuelb0sli3gAHVasMCSf1BFTu
         Tn18uoPasTdJP3ZFb8YmFgqAT9cYq8VtputFMzwPerxH+U7fsBsXdB2Ygyq1p3475Lim
         WhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693224951; x=1693829751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfY+430Mmt3Y+JnQoDV9LCldHPmAfJHhgnZVMksWZmU=;
        b=hsJM8Bk4/1J0XDAtyGcwXyd7uzIrjp8wsmwBbmJ5z227s9UyZZpKYPWCP53LKfZ9P6
         t74PEHEy1WQPtZwThSglpcZA4szaw/3yTQFn85nPKPuY1lOH9ZBNQ8GRyimrlMEBMPAA
         s+H4iwmElu/YFAv1GTyH+wxMSuvq1cTZTlJGXGidRAjhjUBAztm/iPiOjXo08+PpMd+0
         imNqu+tzUKChlX+/iv2fIzsxfu229Bt8lovhBNCPZc9tCw4mvljcN/jOo6IOmuY+3WJO
         z25Y1XhxTQ1ww8OPW+RW17kjs5K66+13NgG1Vpftd11jWIlkq8pMkxUCRjBxDjI9dqPv
         Dl1A==
X-Gm-Message-State: AOJu0YxsoteUUuQNSYAYFz46pIjxpBd7+06xglQ5+XxTT+TxwMRODvm1
        p2ZUIEyC5HlId3tZNmSocbpGfg==
X-Google-Smtp-Source: AGHT+IGHFAS4RO19fDb2Ex7ebv/VziR1QmzCkg8+4TKxErais4VcbzpdB4o0JW9ySdL8bJxvYJURUg==
X-Received: by 2002:a05:6512:3b0d:b0:500:acf1:b42f with SMTP id f13-20020a0565123b0d00b00500acf1b42fmr5703770lfv.53.1693224951107;
        Mon, 28 Aug 2023 05:15:51 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id eq8-20020a056512488800b004fe4aef5b18sm1562278lfb.164.2023.08.28.05.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 05:15:50 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v6.6
Date:   Mon, 28 Aug 2023 14:15:49 +0200
Message-Id: <20230828121549.285925-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Here's the pull-request with the MMC updates (no MEMSTICK changes this time) for
for v6.6-rc1. Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f:

  Linux 6.5-rc5 (2023-08-06 15:07:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.6

for you to fetch changes up to 98ac9e4fc07f101c435f1ab6b395b6245b096a68:

  mmc: atmel-mci: Move card detect gpio polarity quirk to gpiolib (2023-08-25 13:40:21 +0200)

----------------------------------------------------------------
MMC core:
 - Convert drivers to use the ->remove_new() callback
 - Propagate the removable attribute for the card's device

MMC host:
 - Convert drivers to use the ->remove_new() callback
 - atmel-mci: Convert to gpio descriptors and cleanup the code
 - davinci: Make SDIO irq truly optional
 - renesas_sdhi: Register irqs before registering controller
 - sdhci: Simplify the sdhci_pltfm_* interface a bit
 - sdhci-esdhc-imx: Improve support for the 1.8V errata
 - sdhci-of-at91: Add support for the microchip sam9x7 variant
 - sdhci-of-dwcmshc: Add support for runtime PM
 - sdhci-pci-o2micro: Add support for the new Bayhub GG8 variant
 - sdhci-sprd: Add support for SD high-speed mode tuning
 - uniphier-sd: Register irqs before registering controller

----------------------------------------------------------------
Adrian Hunter (16):
      mmc: sdhci-pltfm: Add sdhci_pltfm_remove()
      mmc: sdhci-bcm-kona: Use sdhci_pltfm_remove()
      mmc: sdhci-brcmstb: Use sdhci_pltfm_remove()
      mmc: sdhci-cadence: Use sdhci_pltfm_remove()
      mmc: sdhci-dove: Use sdhci_pltfm_remove()
      mmc: sdhci_f_sdh30: Use sdhci_pltfm_remove()
      mmc: sdhci-iproc: Use sdhci_pltfm_remove()
      mmc: sdhci-of-arasan: Use sdhci_pltfm_remove()
      mmc: sdhci-of-at91: Use sdhci_pltfm_remove()
      mmc: sdhci-of-esdhc: Use sdhci_pltfm_remove()
      mmc: sdhci-of-hlwd: Use sdhci_pltfm_remove()
      mmc: sdhci-of-sparx5: Use sdhci_pltfm_remove()
      mmc: sdhci-pxav2: Use sdhci_pltfm_remove()
      mmc: sdhci-st: Use sdhci_pltfm_remove()
      mmc: sdhci-pltfm: Remove sdhci_pltfm_unregister()
      mmc: sdhci-pltfm: Rename sdhci_pltfm_register()

Balamanikandan Gunasundar (3):
      mmc: atmel-mci: Convert to gpio descriptors
      mmc: atmel-mci: move atmel MCI header file
      mmc: atmel-mci: Move card detect gpio polarity quirk to gpiolib

Chevron Li (2):
      mmc: sdhci-pci-o2micro: add Bayhub new chip GG8 support for UHS-I
      mmc: sdhci-pci-o2micro: add Bayhub new chip GG8 support for express card

Frank Wunderlich (1):
      dt-bindings: mmc: mtk-sd: drop assigned-clocks/clock-parents

Giulio Benetti (1):
      mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450

Guido Günther (1):
      dt-bindings: mmc: Fix reference to pwr-seq-simple

Harshit Mogalapalli (2):
      mmc: sunplus: Fix error handling in spmmc_drv_probe()
      mmc: sunplus: Fix platform_get_irq() error checking

Julien Delbergue (1):
      mmc: davinci: Make SDIO irq truly optional

Kunihiko Hayashi (1):
      mmc: sdhci-f-sdh30: Replace with sdhci_pltfm

Li Zetao (1):
      mmc: sdhci-st: Use devm_platform_ioremap_resource_byname()

Liming Sun (2):
      mmc: sdhci-of-dwcmshc: Add error handling in dwcmshc_resume
      mmc: sdhci-of-dwcmshc: Add runtime PM operations

Linus Walleij (1):
      mmc: mmci: Improve ux500 debug prints

Michal Simek (1):
      dt-bindings: mmc: arasan,sdci: Add power-domains and iommus properties

Rob Herring (1):
      mmc: Explicitly include correct DT includes

Sergei Antonov (1):
      mmc: moxart: read scr register without changing byte order

Thomas Weißschuh (1):
      mmc: core: propagate removable attribute to driver core

Ulf Hansson (3):
      mmc: meson-gx: Drop redundant WARN_ON() in the irq handler
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

Varshini Rajendran (1):
      dt-bindings: sdhci-of-at91: add microchip,sam9x7-sdhci

Victor Shih (1):
      mmc: core: Cleanup mmc_sd_num_wr_blocks() function

Wei Chen (1):
      mmc: sunplus: fix return value check of mmc_add_host()

Wenchao Chen (2):
      mmc: core: Add host specific tuning support for SD HS mode
      mmc: sdhci-sprd: Add SD HS mode online tuning

Wolfram Sang (3):
      mmc: renesas_sdhi: register irqs before registering controller
      mmc: renesas_sdhi: remove outdated indentation
      mmc: uniphier-sd: register irqs before registering controller

Yang Yingliang (2):
      mmc: wbsd: fix double mmc_free_host() in wbsd_init()
      mmc: remove unnecessary set_drvdata() function

Yangtao Li (65):
      mmc: mxcmmc: Use devm_platform_get_and_ioremap_resource()
      mmc: omap_hsmmc: Use devm_platform_get_and_ioremap_resource()
      mmc: pxamci: Use devm_platform_get_and_ioremap_resource()
      mmc: sunxi: Convert to platform remove callback returning void
      mmc: bcm2835: Convert to platform remove callback returning void
      mmc: jz4740: Convert to platform remove callback returning void
      mmc: litex_mmc: Convert to platform remove callback returning void
      mmc: mtk-sd: Convert to platform remove callback returning void
      mmc: cb710: Convert to platform remove callback returning void
      mmc: davinci_mmc: Convert to platform remove callback returning void
      mmc: dw_mmc: hi3798cv200: Convert to platform remove callback returning void
      mmc: sdhci-pic32: Convert to platform remove callback returning void
      mmc: sdhci: milbeaut: Convert to platform remove callback returning void
      mmc: omap_hsmmc: Convert to platform remove callback returning void
      mmc: sdhci-of-at91: Convert to platform remove callback returning void
      mmc: omap: Convert to platform remove callback returning void
      mmc: dw_mmc: exynos: Convert to platform remove callback returning void
      mmc: sdhci-pxav3: Convert to platform remove callback returning void
      mmc: rtsx_pci: Drop if block with always false condition
      mmc: rtsx_pci: Convert to platform remove callback returning void
      mmc: sh_mmcif: Convert to platform remove callback returning void
      mmc: meson-gx: Convert to platform remove callback returning void
      mmc: xenon: Convert to platform remove callback returning void
      mmc: sdhci-s3c: Convert to platform remove callback returning void
      mmc: meson-mx-sdhc: Convert to platform remove callback returning void
      mmc: rtsx_usb_sdmmc: Convert to platform remove callback returning void
      mmc: mxs-mmc: Convert to platform remove callback returning void
      mmc: sdhci-of-arasan: Convert to platform remove callback returning void
      mmc: sdhci-of-dwcmshc: Convert to platform remove callback returning void
      mmc: au1xmmc: Convert to platform remove callback returning void
      mmc: cavium-octeon: Convert to platform remove callback returning void
      mmc: pxamci: Convert to platform remove callback returning void
      mmc: moxart: Convert to platform remove callback returning void
      mmc: sdhci-omap: Convert to platform remove callback returning void
      mmc: sdhci-of-aspeed: remove unneeded variables
      mmc: sdhci-of-aspeed: Convert to platform remove
      mmc: meson-mx-sdio: Convert to platform remove callback returning void
      mmc: sdhci-sprd: Convert to platform remove callback returning void
      mmc: sdhci-tegra: Convert to platform remove callback returning void
      mmc: sdhci-acpi: Convert to platform remove callback returning void
      mmc: sdhci-esdhc-imx: Convert to platform remove callback returning void
      mmc: sdhci-msm: Convert to platform remove callback returning void
      mmc: alcor: Convert to platform remove callback returning void
      mmc: dw_mmc: rockchip: Convert to platform remove callback returning void
      mmc: owl: Convert to platform remove callback returning void
      mmc: wbsd: Convert to platform remove callback returning void
      mmc: usdhi60rol0: Convert to platform remove callback returning void
      mmc: atmel-mci: Convert to platform remove callback returning void
      mmc: sdhci-st: Convert to platform remove callback returning void
      mmc: wmt-sdmmc: Convert to platform remove callback returning void
      mmc: sdhci-esdhc-mcf: Convert to platform remove callback returning void
      mmc: sunplus-mmc: Convert to platform remove callback returning void
      mmc: sdhci-spear: Convert to platform remove callback returning void
      mmc: mxcmmc: Convert to platform remove callback returning void
      mmc: mvsdio: Convert to platform remove callback returning void
      mmc: pwrseq_simple: Convert to platform remove callback returning void
      mmc: pwrseq: sd8787: Convert to platform remove callback returning void
      mmc: pwrseq: Convert to platform remove callback returning void
      mmc: renesas_sdhi: Convert to platform remove callback returning void
      mmc: Convert to platform remove callback returning void
      mmc: uniphier-sd: Convert to platform remove callback returning void
      mmc: sdhci_am654: Properly handle failures in .remove()
      mmc: sdhci_am654: Convert to platform remove callback returning void
      mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove
      mmc: f-sdh30: Convert to platform remove callback returning void

Yibin Ding (1):
      mmc: block: Fix in_flight[issue_type] value error

Zhu Wang (2):
      mmc: sdhci-spear: remove redundant of_match_ptr()
      mmc: sdhci: milbeaut: remove redundant of_match_ptr()

 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |   6 +
 .../devicetree/bindings/mmc/mmc-controller.yaml    |   2 +-
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |  10 -
 .../devicetree/bindings/mmc/sdhci-atmel.txt        |   4 +-
 drivers/gpio/gpiolib-of.c                          |  20 +-
 drivers/mmc/core/block.c                           |  18 +-
 drivers/mmc/core/bus.c                             |   3 +
 drivers/mmc/core/mmc_ops.h                         |   1 -
 drivers/mmc/core/pwrseq_emmc.c                     |   6 +-
 drivers/mmc/core/pwrseq_sd8787.c                   |   6 +-
 drivers/mmc/core/pwrseq_simple.c                   |   6 +-
 drivers/mmc/core/sd.c                              |  14 ++
 drivers/mmc/core/sd_ops.c                          |   1 +
 drivers/mmc/core/sd_ops.h                          |   2 -
 drivers/mmc/host/alcor.c                           |   6 +-
 drivers/mmc/host/atmel-mci.c                       | 140 ++++++++------
 drivers/mmc/host/au1xmmc.c                         |   5 +-
 drivers/mmc/host/bcm2835.c                         |   6 +-
 drivers/mmc/host/cavium-octeon.c                   |   7 +-
 drivers/mmc/host/cavium-thunderx.c                 |   1 +
 drivers/mmc/host/cb710-mmc.c                       |   5 +-
 drivers/mmc/host/davinci_mmc.c                     |   9 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |   6 +-
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   6 +-
 drivers/mmc/host/dw_mmc-rockchip.c                 |   6 +-
 drivers/mmc/host/jz4740_mmc.c                      |   6 +-
 drivers/mmc/host/litex_mmc.c                       |   5 +-
 drivers/mmc/host/meson-gx-mmc.c                    |  11 +-
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |   6 +-
 drivers/mmc/host/meson-mx-sdio.c                   |   6 +-
 drivers/mmc/host/mmci.c                            |  39 +++-
 drivers/mmc/host/moxart-mmc.c                      |  16 +-
 drivers/mmc/host/mtk-sd.c                          |  10 +-
 drivers/mmc/host/mvsdio.c                          |   6 +-
 drivers/mmc/host/mxcmmc.c                          |  10 +-
 drivers/mmc/host/mxs-mmc.c                         |   7 +-
 drivers/mmc/host/omap.c                            |   6 +-
 drivers/mmc/host/omap_hsmmc.c                      |  11 +-
 drivers/mmc/host/owl-mmc.c                         |   9 +-
 drivers/mmc/host/pxamci.c                          |  12 +-
 drivers/mmc/host/renesas_sdhi.h                    |   2 +-
 drivers/mmc/host/renesas_sdhi_core.c               |  26 +--
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      |   5 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c           |   5 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |   9 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |   8 +-
 drivers/mmc/host/sdhci-acpi.c                      |   6 +-
 drivers/mmc/host/sdhci-bcm-kona.c                  |  13 +-
 drivers/mmc/host/sdhci-brcmstb.c                   |  18 +-
 drivers/mmc/host/sdhci-cadence.c                   |  19 +-
 drivers/mmc/host/sdhci-dove.c                      |   8 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  15 +-
 drivers/mmc/host/sdhci-esdhc-mcf.c                 |   6 +-
 drivers/mmc/host/sdhci-iproc.c                     |  16 +-
 drivers/mmc/host/sdhci-milbeaut.c                  |   8 +-
 drivers/mmc/host/sdhci-msm.c                       |   7 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |  14 +-
 drivers/mmc/host/sdhci-of-aspeed.c                 |  15 +-
 drivers/mmc/host/sdhci-of-at91.c                   |  10 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |  93 ++++++++-
 drivers/mmc/host/sdhci-of-esdhc.c                  |   2 +-
 drivers/mmc/host/sdhci-of-hlwd.c                   |   4 +-
 drivers/mmc/host/sdhci-of-sparx5.c                 |  19 +-
 drivers/mmc/host/sdhci-omap.c                      |   7 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   4 +
 drivers/mmc/host/sdhci-pci-o2micro.c               | 211 +++++++++++++++++----
 drivers/mmc/host/sdhci-pci.h                       |   4 +
 drivers/mmc/host/sdhci-pic32.c                     |   6 +-
 drivers/mmc/host/sdhci-pltfm.c                     |  16 +-
 drivers/mmc/host/sdhci-pltfm.h                     |   8 +-
 drivers/mmc/host/sdhci-pxav2.c                     |  20 +-
 drivers/mmc/host/sdhci-pxav3.c                     |   6 +-
 drivers/mmc/host/sdhci-s3c.c                       |   7 +-
 drivers/mmc/host/sdhci-spear.c                     |  10 +-
 drivers/mmc/host/sdhci-sprd.c                      | 156 ++++++++++++++-
 drivers/mmc/host/sdhci-st.c                        |  15 +-
 drivers/mmc/host/sdhci-tegra.c                     |   7 +-
 drivers/mmc/host/sdhci-xenon.c                     |   6 +-
 drivers/mmc/host/sdhci_am654.c                     |  14 +-
 drivers/mmc/host/sdhci_f_sdh30.c                   |  77 ++++----
 drivers/mmc/host/sh_mmcif.c                        |   7 +-
 drivers/mmc/host/sunplus-mmc.c                     |  35 ++--
 drivers/mmc/host/sunxi-mmc.c                       |   6 +-
 drivers/mmc/host/uniphier-sd.c                     |  19 +-
 drivers/mmc/host/usdhi6rol0.c                      |   6 +-
 drivers/mmc/host/via-sdmmc.c                       |   2 -
 drivers/mmc/host/wbsd.c                            |  11 +-
 drivers/mmc/host/wmt-sdmmc.c                       |   7 +-
 include/linux/atmel-mci.h                          |  46 -----
 include/linux/mmc/host.h                           |   8 +
 90 files changed, 866 insertions(+), 639 deletions(-)
 delete mode 100644 include/linux/atmel-mci.h
