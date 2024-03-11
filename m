Return-Path: <linux-kernel+bounces-98845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA19878031
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A7B283DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643D33C493;
	Mon, 11 Mar 2024 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eup7EDIa"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0623DBA1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710161893; cv=none; b=QN03dl4A/u4gnmDqO9zlpbgmElyggWaBnQYjAn2d2X4NfHnDWICoLDhroB+fF09QMweQr4iWnBMZEYDY5rkadeHj60LuPNpLZ5f0so600d/Un4GUMu4eEQ9HhS9Iu88MkziSyZFk2wk8Ifb4BzCXCQNEosnTG3/eaH8yP/zFX2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710161893; c=relaxed/simple;
	bh=p6LCC/tBik0/9mAMc6Pwphe/GopEuw3WpqTixgT1xTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tlWQ31OnI5VeVyt0zHaxpzy2O3yANWcPwZt39mCqwlTTE5VfcdCfjxIbFt4InbJKkJGxNaDEECJoSNhAtxKjxYlO9IJFMJ5swWxoheaOXOHiGZV33icjnMVXI5Thtxui39jcpZBvep5HaP7lIzOVWB43JifwRlk/geQ+6TXZy28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eup7EDIa; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513af1a29b1so581411e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710161888; x=1710766688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gsILAMkZyT/jOCqdttMoT4+7ymZlaW0eKqPLkCqhEQ=;
        b=eup7EDIaDPKD8DFKYO4Yq2RiaAq2eUlPBnVbFVIKkSty+CG4dTRsunoSZ8DljRi96T
         YL5gPFac3tOZXasfl9AtEqALjL3Kq/W+VOWuROyBtlzux6SzMBNQlyrApil2xFCoeqhN
         +tH0yJrq4pnQz5FSl3kaWq7H+kg7Un58WfiG9JSEVfKBoMwOEiabzhr56TPp0oFlVkhn
         dwwSPmGtdaLad6tYt3aucCM7/XPfX1So42Xzm/5zWb/OpzKSM8MXiq3cvDcPZthL8LLi
         xaT7kBkV6FJv+GD8xrmExmHO6UF/dpdplE4Nlre1rjcUqolq7wUqrdrMWK1j8kaY3Pk7
         TFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710161888; x=1710766688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gsILAMkZyT/jOCqdttMoT4+7ymZlaW0eKqPLkCqhEQ=;
        b=H7b6+bOpshPIqjm3oELWD2qREOddFMcjpoQQxaJX5tAQbv5faPv2/Oh936rmqPcpyH
         Js/TyrwUmNGd9qZbnK8li3tSCclNvrHRXuS0Mu6rn8pMf9064/5dkVw5116w1i34x2fZ
         i7CYFGOIdoT5Do6NN+QMAM/5njC6tgxb6MtOIjV9635BVdqwbloKZrY0mPClIZShd1My
         v9Is2fkNvqq3T80i3ryGF33ENEceQiui/4NDh1jlzd3LtQJ0M8usfSPaQR6RTFI3DAmN
         Ec8OfxTv+xKfQBqt72E2mnluGG16P5pUXwYn9duUHHaaFWGiniYa7Evv+e5WsMf1zyCW
         +QSw==
X-Forwarded-Encrypted: i=1; AJvYcCU8hZXw3BrUxSvmQgtutwQWvxzop6TsFbfjy3sFwF+Mtyu//qRPtD1w9mXOtCbLoobEd5VQvyijChDCC4sYz5UaLbmGvEsYl0YXZ6tS
X-Gm-Message-State: AOJu0Yy5T3iPLZSILew3/IsnuFvhF3L4WMW5eX8qAeZpt7OFq32dP2tF
	jrJ6E+tyl7ys27BDjZNuIe4kEIolILwScPHVihInc4IawSstkzMyjxSWMeyH1eP2ZVJFSxCcJCW
	W
X-Google-Smtp-Source: AGHT+IGBFNOnfAhWD4IhxZRO/ZVCYIAdLRAdq1JZMugz0zM/FHTnEMov1PCGhZV9OgK1ej+HOoVO2A==
X-Received: by 2002:ac2:5bdc:0:b0:513:df6:dcd3 with SMTP id u28-20020ac25bdc000000b005130df6dcd3mr4451573lfn.48.1710161888496;
        Mon, 11 Mar 2024 05:58:08 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id er26-20020a05651248da00b00513a1fe7767sm800946lfb.209.2024.03.11.05.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 05:58:08 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v6.9
Date: Mon, 11 Mar 2024 13:58:07 +0100
Message-Id: <20240311125807.1143937-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request for MMC and MEMSTICK for v6.9. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 09e23823ae9a3e2d5d20f2e1efe0d6e48cef9129:

  mmc: sdhci-xenon: add timeout for PHY init complete (2024-02-28 13:41:35 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.9

for you to fetch changes up to faf3b8014c357d71c7a9414302e217a1dd1679af:

  mmc: core: make mmc_host_class constant (2024-03-06 23:36:29 +0100)

----------------------------------------------------------------
MMC core:
 - Drop the use of BLK_BOUNCE_HIGH
 - Fix partition switch for GP3
 - Remove usage of the deprecated ida_simple API

MMC host:
 - cqhci: Update bouncing email-addresses in MAINTAINERS
 - davinci_mmc: Use sg_miter for PIO
 - dw_mmc-hi3798cv200: Convert the DT bindings to YAML
 - dw_mmc-hi3798mv200: Add driver for the new dw_mmc variant
 - fsl-imx-esdhc: A couple of corrections/updates to the DT bindings
 - meson-mx-sdhc: Drop use of the ->card_hw_reset() callback
 - moxart-mmc: Use sg_miter for PIO
 - moxart-mmc: Fix accounting for DMA transfers
 - mvsdio: Use sg_miter for PIO
 - mxcmmc: Use sg_miter for PIO
 - omap: Use sg_miter for PIO
 - renesas,sdhi: Add support for R-Car V4M variant
 - sdhci-esdhc-mcf: Use sg_miter for swapping
 - sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002 variants
 - sh_mmcif: Use sg_miter for PIO
 - tmio: Avoid concurrent runs of mmc_request_done()

----------------------------------------------------------------
Andy Shevchenko (2):
      mmc: dw_mmc: Remove unused of_gpio.h
      mmc: mmc_spi: Don't mention DMA direction

Christophe JAILLET (2):
      mmc: core: Remove usage of the deprecated ida_simple_xx() API
      mmc: wmt-sdmmc: remove an incorrect release_mem_region() call in the .remove function

Colin Ian King (1):
      mmc: wbsd: remove redundant assignment to variable id

Dominique Martinet (1):
      mmc: core: Fix switch on gp3 partition

Fabio Estevam (1):
      dt-bindings: mmc: fsl-imx-mmc: Document the required clocks

Frank Li (1):
      dt-bindings: mmc: fsl-imx-esdhc: add iommus property

Geert Uytterhoeven (1):
      dt-bindings: mmc: renesas,sdhi: Document R-Car V4M support

Jeffrey Hugo (1):
      MAINTAINERS: Update bouncing @codeaurora addresses for EMMC CMDQ

Jisheng Zhang (2):
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo CV1800B and SG2002 support
      mmc: sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002

Krzysztof Kozlowski (1):
      mmc: renesas_sdhi: use typedef for dma_filter_fn

Linus Walleij (14):
      mmc: core Drop BLK_BOUNCE_HIGH
      mmc: davinci_mmc: Use sg_miter for PIO
      mmc: moxart-mmc: Factor out moxart_use_dma() helper
      mmc: moxart-mmc: Fix accounting in DMA transfer
      mmc: moxart-mmc: Use sg_miter for PIO
      mmc: mvsdio: Use sg_miter for PIO
      mmc: mxcmmc: Use sg_miter for PIO
      mmc: omap: Use sg_miter for PIO
      mmc: sdhci-esdhc-mcf: Use sg_miter for swapping
      mmc: sh_mmcif: Use sg_miter for PIO
      mmc: davinci_mmc: Drop dangling variable
      mmc: sdhci-esdhc-mcf: Flag the sg_miter as atomic
      mmc: sh_mmcif: sg_miter must not be atomic
      mmc: sh_mmcif: Advance sg_miter before reading blocks

Marco Felsch (1):
      dt-bindings: mmc: fsl-imx-esdhc: add default and 100mhz state

Martin Blumenstingl (2):
      mmc: meson-mx-sdhc: Use devm_clk_hw_get_clk() for clock retrieval
      mmc: meson-mx-sdhc: Remove .card_hw_reset callback

Peng Fan (1):
      dt-bindings: mmc: fsl-imx-esdhc: add i.MX95 compatible string

Ricardo B. Marliere (6):
      mmc: core: make mmc_rpmb_bus_type const
      mmc: core: make mmc_bus_type const
      mmc: core: make sdio_bus_type const
      memstick: core: make memstick_bus_type const
      mmc: core: constify the struct device_type usage
      mmc: core: make mmc_host_class constant

Ulf Hansson (5):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

Wolfram Sang (2):
      mmc: tmio: avoid concurrent runs of mmc_request_done()
      mmc: tmio: comment the ERR_PTR usage in this driver

Yang Xiwen (5):
      mmc: core: Use a struct device* as in-param to mmc_of_parse_clk_phase()
      mmc: dw_mmc-hi3798cv200: remove MODULE_ALIAS()
      dt-bindings: mmc: dw-mshc-hi3798cv200: convert to YAML
      dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc: add Hi3798MV200 binding
      mmc: dw_mmc: add support for hi3798mv200

 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |  11 +-
 .../devicetree/bindings/mmc/fsl-imx-mmc.yaml       |  12 +
 .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  40 ----
 .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml         |  97 ++++++++
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   1 +
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   2 +
 MAINTAINERS                                        |   4 +-
 drivers/memstick/core/memstick.c                   |   2 +-
 drivers/mmc/core/block.c                           |  24 +-
 drivers/mmc/core/bus.c                             |   4 +-
 drivers/mmc/core/bus.h                             |   2 +-
 drivers/mmc/core/host.c                            |  11 +-
 drivers/mmc/core/mmc.c                             |   2 +-
 drivers/mmc/core/queue.c                           |   2 -
 drivers/mmc/core/sd.c                              |   2 +-
 drivers/mmc/core/sd.h                              |   2 +-
 drivers/mmc/core/sdio.c                            |   2 +-
 drivers/mmc/core/sdio_bus.c                        |   2 +-
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/davinci_mmc.c                     |  59 +++--
 drivers/mmc/host/dw_mmc-exynos.c                   |   1 -
 drivers/mmc/host/dw_mmc-hi3798cv200.c              |   1 -
 drivers/mmc/host/dw_mmc-hi3798mv200.c              | 251 +++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c                          |   1 -
 drivers/mmc/host/meson-mx-sdhc-clkc.c              |  43 ++--
 drivers/mmc/host/meson-mx-sdhc-mmc.c               |  13 +-
 drivers/mmc/host/mmc_spi.c                         |  30 ++-
 drivers/mmc/host/moxart-mmc.c                      |  90 ++++----
 drivers/mmc/host/mvsdio.c                          |  71 ++++--
 drivers/mmc/host/mxcmmc.c                          |  53 +++--
 drivers/mmc/host/omap.c                            |  53 ++---
 drivers/mmc/host/renesas_sdhi.h                    |   3 +-
 drivers/mmc/host/sdhci-esdhc-mcf.c                 |  12 +-
 drivers/mmc/host/sdhci-of-aspeed.c                 |   2 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c                |  66 ++++++
 drivers/mmc/host/sh_mmcif.c                        | 114 ++++++----
 drivers/mmc/host/tmio_mmc_core.c                   |   6 +-
 drivers/mmc/host/wbsd.c                            |   2 -
 drivers/mmc/host/wmt-sdmmc.c                       |   4 -
 include/linux/mmc/host.h                           |   2 +-
 41 files changed, 791 insertions(+), 318 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
 create mode 100644 drivers/mmc/host/dw_mmc-hi3798mv200.c

