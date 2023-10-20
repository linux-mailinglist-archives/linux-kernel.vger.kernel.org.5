Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33137D0F40
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377284AbjJTL5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377137AbjJTL5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:57:03 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183B8D52
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:57:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c51f5a1ecdso20947351fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697803019; x=1698407819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hh++GJc3kGJM2bQdA5aanDk5yqbDgE0CFVbC9pD/A04=;
        b=iWXmXRELkqs/d1JgDtz9Ikp9vkBWXVyVOvDjqEdrsFq/6DYS5Vbm9SjzpzeJIg6f/+
         IAcfV0e8/lT9O4E8L8ItqpjyfiDSMLd0YB3xg0q+9KXzKOlDadBuOy0ckP0nu2IpIH+c
         EFBh7vexBgBMpcH3QIzC/IapACYj2fkNRR7qDsdQ5VQ8TQy2304jo4B2Avhj/PX6i9uF
         Gq7B8Re5AipntdQFZ36kCryQV18l+oZ4OxClOdwWpzWWJQLJ/QNduNCVAnYUhZeFjasi
         f6RCJ/oyjTQlB4nnS4nAdkdo+4jybA70ee+ndVnRlkKvx4QqStov/n1hL590PPzYwsLu
         FxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697803019; x=1698407819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hh++GJc3kGJM2bQdA5aanDk5yqbDgE0CFVbC9pD/A04=;
        b=wEjFboaJJNK881MTGYYsiqQDGnPM8zRJnvYjpKLyFCZT2eL8gpm5eb6XU9/BhXkefE
         mM5SKvXmPYzEL4tkpV1GlCK1HNnTxQ9krUNNVWQubqASMC3mqXpTUqTbM16bFO03jXTE
         ysmi3b/Oeg+W2WyUvLpN25USWzeg5XBKQNkmX8JUoRapmErRso/nYvoNTOjLjUcjATO/
         nAB4is4707m8WbIgiEKDXakaa7jaBH6dMip+KIIM91rI6hBsyB9nDsZGH7UkCoREwPxe
         GX3EAqNJ29NBPKOKQWEoNArFcx6av699JDvYfZLLMSg9hJOaY/Enc1lxVyMPKEz72Wvg
         Utbw==
X-Gm-Message-State: AOJu0YxMpVHUXSeiN/qP1/f0y4mNsotbpqcvYuzGzICqR6qGoxlkTEhx
        +f9zWjyZPpnnhES/JobWW+JUxA==
X-Google-Smtp-Source: AGHT+IHnGfzeX3kx7GOLdN3ynQSE3OBRsSmF/GQF3URlL9EC4qOVUrtvUe1p9Xhb+apubjZEC+Ky4A==
X-Received: by 2002:a05:651c:1308:b0:2c4:fdaf:1d62 with SMTP id u8-20020a05651c130800b002c4fdaf1d62mr1674662lja.11.1697803019267;
        Fri, 20 Oct 2023 04:56:59 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id b41-20020a05651c0b2900b002c02b36d381sm337496ljr.88.2023.10.20.04.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:56:58 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.6-rc7
Date:   Fri, 20 Oct 2023 13:56:57 +0200
Message-Id: <20231020115657.153077-1-ulf.hansson@linaro.org>
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

Here's a PR with a couple of MMC fixes intended for v6.6-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.6-rc3

for you to fetch changes up to 84ee19bffc9306128cd0f1c650e89767079efeff:

  mmc: core: Capture correct oemid-bits for eMMC cards (2023-09-27 12:17:04 +0200)

----------------------------------------------------------------
MMC core:
 - Capture correct oemid-bits for eMMC cards
 - Fix error propagation for some ioctl commands
 - Hold retuning if SDIO is in 1-bit mode

MMC host:
 - mtk-sd: Use readl_poll_timeout_atomic to not "schedule while atomic"
 - sdhci-msm: Correct minimum number of clocks
 - sdhci-pci-gli: Fix LPM negotiation so x86/S0ix SoCs can suspend
 - sdhci-sprd: Fix error code in sdhci_sprd_tuning()

----------------------------------------------------------------
Avri Altman (1):
      mmc: core: Capture correct oemid-bits for eMMC cards

Dan Carpenter (1):
      mmc: sdhci-sprd: Fix error code in sdhci_sprd_tuning()

Haibo Chen (1):
      mmc: core: sdio: hold retuning if sdio in 1-bit mode

Krzysztof Kozlowski (1):
      dt-bindings: mmc: sdhci-msm: correct minimum number of clocks

Pablo Sun (1):
      mmc: mtk-sd: Use readl_poll_timeout_atomic in msdc_reset_hw

Sven van Ashbrook (1):
      mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix SoCs can suspend

Ulf Hansson (1):
      mmc: core: Fix error propagation for some ioctl commands

 .../devicetree/bindings/mmc/sdhci-msm.yaml         |   2 +-
 drivers/mmc/core/block.c                           |  31 +++---
 drivers/mmc/core/mmc.c                             |   2 +-
 drivers/mmc/core/sdio.c                            |   8 +-
 drivers/mmc/host/mtk-sd.c                          |   6 +-
 drivers/mmc/host/sdhci-pci-gli.c                   | 104 +++++++++++++--------
 drivers/mmc/host/sdhci-sprd.c                      |   1 +
 7 files changed, 99 insertions(+), 55 deletions(-)
