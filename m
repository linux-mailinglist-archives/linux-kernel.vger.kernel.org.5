Return-Path: <linux-kernel+bounces-24640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B310F82BF9D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D321F24871
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9456A02B;
	Fri, 12 Jan 2024 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sa/xTFpq"
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D225788F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-50e67e37661so8554255e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 04:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705061557; x=1705666357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4MkwOOsCiR5/RKAzG+EikPytxaE3upASjfe6P8xL2Qw=;
        b=sa/xTFpqx5jg/+r99ODplLblhilPc3vXYErFyA8Chw6Tu1SKnEtC5XoUClZ1skN5aD
         Vw/dINGDNLCFF4jUlyuKFNybHhWyV5B5PXd1MNf1t+5+MhUYRe1I1qpcp9c9bKGuPu2d
         oKt6g0DOyw941ebiyIXRsjdAqrCNywz7fDPoUUPo4ugSe5J5a3V9J4EL06jN9BE8ny77
         BDKr52lRhNZSfymm2FU3VLrirpzsWRl1dy/5Ej5AykzL/gXmE9lnyCD/gpJPPThdujFG
         40ydKJkrLUncbNRa51ehv5iDEk9GME0/HilIzO0zjD/P0nNKWi4OuvVwAimEc9Ek4y9l
         Qi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705061557; x=1705666357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MkwOOsCiR5/RKAzG+EikPytxaE3upASjfe6P8xL2Qw=;
        b=R+hUHhV/8fXu4PqfQwMDvJRXz1ESA+vXK6tLh+AA58UqEoWKtczpPGpBl1T2S1SKn5
         buU84jnvpWLLsnRPlEP23TJdSt6U+/H9k87wh5iTbiHJQ4Y7inEZN6AbA4NM7Dmz1rTf
         HpzkCyr2X8jDEht9MQ2CWD8ou+Wsdw6MlkJc2O1IWWUTaDSVa/DBaIEeJdU0E0uzhjPN
         n6uvng9tqCMCOgcP7YEBLZPHRKRfaN5zIsNF+TLdsnEPxJiH1uU76AWVOmYkgjIpNV4r
         Zz7vhjA3/7YWH5j9rcoMAC0WNBTSPO2wyfBwRrN7jxfyoVnNhach3jZ6pssNTL9I5YXg
         Z8ng==
X-Gm-Message-State: AOJu0YxOQSBtOVXnWDl3oidMfRR/6RdN4Mlm6wfL6S5J/RIZ2feHQOWL
	1uggFb5kXzlJC7laGq186x8GeAXbaLzWhg==
X-Google-Smtp-Source: AGHT+IFTQuTYKQF+f1XSTsvFgJINYyqAciSMLhz666upJ9DgYyyaOXOA+MPx1Sf4rrBgfkQCwjkkEQ==
X-Received: by 2002:a05:6512:3b22:b0:50e:7555:ddf4 with SMTP id f34-20020a0565123b2200b0050e7555ddf4mr805863lfv.20.1705061556872;
        Fri, 12 Jan 2024 04:12:36 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id br5-20020a056512400500b0050e84a3d75bsm482376lfb.254.2024.01.12.04.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 04:12:36 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v6.8
Date: Fri, 12 Jan 2024 13:12:35 +0100
Message-Id: <20240112121235.48296-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with the MMC updates for v6.8. No MEMSTICK updates this
time. Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8abf77c88929b6d20fa4f9928b18d6448d64e293:

  mmc: sdhci-sprd: Fix eMMC init failure after hw reset (2024-01-03 11:24:03 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.8

for you to fetch changes up to 5d40213347480e3ab903d5438dbd0d6b0110e6b8:

  mmc: xenon: Add ac5 support via bounce buffer (2024-01-05 11:03:56 +0100)

----------------------------------------------------------------
MMC core:
 - Don't force a retune before eMMC RPMB switch
 - Add optional HS400 tuning in HS400es initialization
 - Add a sysfs node to for write-protect-group-size
 - Add re-tuning test to the mmc-test module
 - Use mrq.sbc to support close-ended ioctl requests

MMC host:
 - mmci: Add support for SDIO in-band irqs for the stm32 variant
 - mmc_spi: Remove broken support custom DMA mapped buffers
 - mtk-sd: Improve and extend the support for tunings
 - renesas_sdhi: Document support for the RZ/Five variant
 - sdhci_am654: Drop support for the ti,otap-del-sel DT property
 - sdhci-brcmstb: Add support for the brcm 74165b0 variant
 - sdhci-msm: Add compatibles for IPQ4019 and IPQ8074
 - sdhci-of-dwcmshc: Add support for the T-Head TH1520 variant
 - sdhci-xenon: Add support for the Marvell ac5 variant

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: mmc_test: Add re-tuning test

Andy Shevchenko (1):
      mmc: mmc_spi: remove custom DMA mapped buffers

Avri Altman (2):
      mmc: core: Remove packed command leftovers
      mmc: core: Use mrq.sbc in close-ended ffu

Axe Yang (2):
      dt-bindings: mmc: mtk-sd: add tuning steps related property
      mmc: mtk-sd: Extend number of tuning steps

Christophe Kerello (1):
      mmc: mmci: stm32: add SDIO in-band interrupt mode

Drew Fustini (3):
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head TH1520 support
      mmc: sdhci: add __sdhci_execute_tuning() to header
      mmc: sdhci-of-dwcmshc: Add support for T-Head TH1520

Elad Nachman (2):
      dt-bindings: mmc: add Marvell ac5
      mmc: xenon: Add ac5 support via bounce buffer

Jorge Ramirez-Ortiz (1):
      mmc: core: Do not force a retune before RPMB switch

Kamal Dasu (2):
      dt-bindings: mmc: brcm,sdhci-brcmstb: Add support for 74165b0
      mmc: sdhci-brcmstb: add new sdhci reset sequence for brcm 74165b0

Krzysztof Kozlowski (2):
      dt-bindings: mmc: synopsys-dw-mshc: add iommus for Intel SocFPGA
      dt-bindings: mmc: sdhci-msm: document dedicated IPQ4019 and IPQ8074

Lad Prabhakar (1):
      dt-bindings: mmc: renesas,sdhi: Document RZ/Five SoC

Lin Gui (1):
      mmc: core: Add wp_grp_size sysfs node

Mengqi Zhang (1):
      mmc: core: Add HS400 tuning in HS400es initialization

Nathan Chancellor (1):
      mmc: sdhci-of-dwcmshc: Use logical OR instead of bitwise OR in dwcmshc_probe()

Peter Robinson (2):
      mmc: sdhci_am654: Fix TI SoC dependencies
      mmc: sdhci_omap: Fix TI SoC dependencies

Pin-yen Lin (1):
      mmc: mtk-sd: Increase the verbosity of msdc_track_cmd_data

Randy Dunlap (1):
      mmc: sdhci-omap: don't misuse kernel-doc marker

Swati Agarwal (1):
      dt-bindings: mmc: arasan,sdci: Add gate property for Xilinx platforms

Ulf Hansson (3):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

Vignesh Raghavendra (1):
      mmc: sdhci_am654: Drop lookup for deprecated ti,otap-del-sel

 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |   8 +-
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml           |   4 +-
 .../bindings/mmc/marvell,xenon-sdhci.yaml          |   4 +-
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |   9 +
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   2 +-
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   2 +
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   1 +
 .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml  |   4 +
 drivers/mmc/core/block.c                           |  46 ++-
 drivers/mmc/core/host.c                            |   3 +-
 drivers/mmc/core/mmc.c                             |  30 +-
 drivers/mmc/core/mmc_test.c                        |  33 +-
 drivers/mmc/host/Kconfig                           |  10 +-
 drivers/mmc/host/mmc_spi.c                         | 186 +----------
 drivers/mmc/host/mmci.c                            |  69 +++-
 drivers/mmc/host/mmci.h                            |   2 +
 drivers/mmc/host/mtk-sd.c                          | 166 +++++++---
 drivers/mmc/host/sdhci-brcmstb.c                   |  69 +++-
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 349 +++++++++++++++++++++
 drivers/mmc/host/sdhci-omap.c                      |   2 +-
 drivers/mmc/host/sdhci-xenon.c                     |  31 ++
 drivers/mmc/host/sdhci-xenon.h                     |   3 +-
 drivers/mmc/host/sdhci.c                           |   3 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 drivers/mmc/host/sdhci_am654.c                     |  37 +--
 include/linux/mmc/card.h                           |   5 +-
 include/linux/mmc/core.h                           |   1 -
 include/linux/mmc/mmc.h                            |  10 -
 28 files changed, 771 insertions(+), 319 deletions(-)

