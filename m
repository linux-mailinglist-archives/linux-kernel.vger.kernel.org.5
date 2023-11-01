Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66B27DDF54
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjKAK0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjKAK0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:26:45 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C2FDA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:26:39 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507a29c7eefso9465102e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698834398; x=1699439198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tCsnTw9G/N7+9b/5OyCWnwytBb//hdrqvpTAVBVTcjs=;
        b=wg3/+ebk8ebV+NKavBjY7c8BZKYuqsNh2J53mKuEKag+mWOJpNz+aNqumfpCYQCmIQ
         QW3zksgJ+KeefTyJEZ5SAIqx0IZ8bEP2VEOVHqQJ2HUcpf+hCwr6XdOfSZ+dEXAKhgOd
         Hw24RRnVytJzYA6p5m53nMH2Kd4/9p+ZeWRSqVH5b3W6N4qOMVFFijdvjGafECHg+/6p
         O1xQz6CVTipWUehvVI5e73FYQQaFGTWcr4IsuycboEGcse0hUY2xlyzOsfaLimFUeUj/
         1N7Y/UBa+tFRI1Kn3bNEtd+ir3KOiOO/ZheObjOpcotJCZY8y+3wluV/jal77zVcJOxr
         15pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698834398; x=1699439198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tCsnTw9G/N7+9b/5OyCWnwytBb//hdrqvpTAVBVTcjs=;
        b=h9Lkslc5EujV4T8EJFAnFxxHRzbaZsZIUYwQkrHifP/BXkt0D7QM+vMonldFEoSt6d
         uAQ62b+F/129iupnAYPJXt+5CvMmd1CDTJCWeZETxkLmi0bkODa8flOzLtVZaUMXDg/I
         HhQgFbKqaEY4aLzwkGDb9AnDxsamUrjb8ItZv7sv7s/DLAdC93Iq/+2bmFipC6HEyYnT
         vAI+wBEvMLpiwoi6RTJt9HzxzG31EiCrPRz+PXcWXL04uhwI3Yvn5yQRBktMySECFkSm
         ubCwaJsLN7Pg7Jy/t50Y58oJww7S6a6Xw7yligCAqlnhDJWXwx12eUezI8Q1c6tCWuS7
         0k4A==
X-Gm-Message-State: AOJu0Ywsi3ZTnTGTUROI7sASYurmjD2H1maRKaqgOdNpZdDrF5HBB1Ld
        0mmlz1kvwjt1Phx/SuFuBJDejA==
X-Google-Smtp-Source: AGHT+IGDHSmTRMp+DQPCwPp1iEl0Z60JF5+pwDLeqsrAC1axXeyH0dDWC5jptYR1GCcL3n/lnZdCvg==
X-Received: by 2002:a19:ca49:0:b0:507:9a8c:a8fe with SMTP id h9-20020a19ca49000000b005079a8ca8femr10219765lfj.53.1698834397802;
        Wed, 01 Nov 2023 03:26:37 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w4-20020ac25d44000000b00507b869b068sm177139lfd.302.2023.11.01.03.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 03:26:37 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK updates for v6.7
Date:   Wed,  1 Nov 2023 11:26:36 +0100
Message-Id: <20231101102636.5155-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's the pull-request with the MMC and MEMSTICK updates for v6.7. Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 84ee19bffc9306128cd0f1c650e89767079efeff:

  mmc: core: Capture correct oemid-bits for eMMC cards (2023-09-27 12:17:04 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7

for you to fetch changes up to 5428a40a308f220dbbffda66cb01b212f88e9a06:

  mmc: Merge branch fixes into next (2023-10-27 12:00:35 +0200)

----------------------------------------------------------------
MMC core:
 - Enable host caps to be modified via debugfs to test speed-modes
 - Improve random I/O writes for 4k buffers for hsq enabled hosts

MMC host:
 - atmel-mci/sdhci-of-at91: Aubin Constans takes over as maintainer
 - dw_mmc-starfive: Re-work tuning support
 - meson-gx: Fix bogus IRQ when using CMD_CFG_ERROR
 - mmci: Use peripheral flow control for the STM32 variant
 - renesas,sdhi: Add support for the RZ/G3S variant
 - sdhci-esdhc-imx: Optimize the manual tuning logic
 - sdhci-msm: Add support for the SM8650 variant
 - sdhci-npcm: Add driver to support the Nuvoton NPCM BMC variant
 - sdhci-pci-gli: Add workaround to allow GL9750 to enter ASPM L1.2

----------------------------------------------------------------
Andy Shevchenko (3):
      mmc: sdhci-pci: Switch to use acpi_evaluate_dsm_typed()
      mmc: sdhci-pltfm: Drop unnecessary error messages in sdhci_pltfm_init()
      mmc: sdhci-pltfm: Make driver OF independent

Aubin Constans (1):
      MAINTAINERS: mmc: take over as maintainer of MCI & SDHCI MICROCHIP DRIVERS

Balamanikandan Gunasundar (1):
      mmc: atmel-mci: Add description for struct member

Ben Wolsieffer (1):
      mmc: mmci: use peripheral flow control for STM32

Claudiu Beznea (1):
      dt-bindings: mmc: renesas,sdhi: Document RZ/G3S support

Haibo Chen (1):
      mmc: sdhci-esdhc-imx: optimize the manual tuing logic to get the best timing

Julia Lawall (1):
      mmc: atmel-mci: add missing of_node_put

Justin Stitt (1):
      mmc: vub300: replace deprecated strncpy with strscpy

Kees Cook (1):
      memstick: jmb38x_ms: Annotate struct jmb38x_ms with __counted_by

Krzysztof Kozlowski (1):
      dt-bindings: mmc: sdhci-msm: allow flexible order of optional clocks

Lad Prabhakar (1):
      mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC config option dependant on ARCH_RENESAS

Neil Armstrong (1):
      dt-bindings: mmc: sdhci-msm: document the SM8650 SDHCI Controller

Rob Herring (1):
      mmc: jz4740: Use device_get_match_data()

Rong Chen (1):
      mmc: meson-gx: Remove setting of CMD_CFG_ERROR

Tomer Maimon (2):
      dt-bindings: mmc: npcm,sdhci: Document NPCM SDHCI controller
      mmc: sdhci-npcm: Add NPCM SDHCI driver

Ulf Hansson (3):
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next
      mmc: Merge branch fixes into next

Victor Shih (1):
      mmc: sdhci-pci-gli: A workaround to allow GL9750 to enter ASPM L1.2

Vincent Whitchurch (2):
      mmc: core: Always reselect card type
      mmc: debugfs: Allow host caps to be modified

Wenchao Chen (2):
      mmc: core: Allow dynamical updates of the number of requests for hsq
      mmc: hsq: Improve random I/O write performance for 4k buffers

William Qiu (2):
      dt-bindings: mmc: starfive: Remove properties from required
      mmc: starfive: Change tuning implementation

 .../devicetree/bindings/mmc/npcm,sdhci.yaml        |  45 +++++++
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   2 +
 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   9 +-
 .../bindings/mmc/starfive,jh7110-mmc.yaml          |   2 -
 MAINTAINERS                                        |   5 +-
 drivers/memstick/host/jmb38x_ms.c                  |   2 +-
 drivers/mmc/core/debugfs.c                         |  51 +++++++-
 drivers/mmc/core/mmc.c                             |   7 +-
 drivers/mmc/core/queue.c                           |   6 +-
 drivers/mmc/host/Kconfig                           |  12 +-
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/atmel-mci.c                       |   9 +-
 drivers/mmc/host/dw_mmc-starfive.c                 | 137 ++++++---------------
 drivers/mmc/host/jz4740_mmc.c                      |  15 +--
 drivers/mmc/host/meson-gx-mmc.c                    |   1 -
 drivers/mmc/host/mmc_hsq.c                         |  22 ++++
 drivers/mmc/host/mmc_hsq.h                         |  11 ++
 drivers/mmc/host/mmci.c                            |   3 +-
 drivers/mmc/host/mmci.h                            |   2 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  52 +++++---
 drivers/mmc/host/sdhci-npcm.c                      |  94 ++++++++++++++
 drivers/mmc/host/sdhci-pci-core.c                  |   5 +-
 drivers/mmc/host/sdhci-pci-gli.c                   |  14 +++
 drivers/mmc/host/sdhci-pltfm.c                     |  38 ++----
 drivers/mmc/host/vub300.c                          |  22 ++--
 include/linux/mmc/host.h                           |   1 +
 26 files changed, 384 insertions(+), 184 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-npcm.c
