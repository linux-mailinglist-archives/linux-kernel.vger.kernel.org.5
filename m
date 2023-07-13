Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E309575260A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjGMPEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjGMPE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:04:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F047E65
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:04:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99357737980so117634766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689260666; x=1691852666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TwNGulIA2ho0EBWPPONOOw90suBzDLAU+ZErTuI+Vzc=;
        b=hRZggRhob6aVHF8C/YtZ1wNcx/+AtkQw4WxbNzb/Y0jrRutfiQDp6DsjI+SCBxq7AA
         6lRPJWVDWYzgXHmOLgZ3ASS9HoDyxaToeUAcKivABM8Bfo0G+zxLFbT+hwu05zZy2jJp
         7kFfqBAiKA8whjWz4HoafKKQiK6IGSIxxoZNxCYrhLp9MeNcbLacGj3kIm+V+0uzct0V
         kQvIOX/AH1+kaypzuHob1K0/+1roW0Op8OlPwHC0FrcQdlitNtK072ap5mKo+KeHto2u
         H8S9rG/Xd5Qqny/FDkLCSi5in5nA4c6nO8mglpoVkE7SoGkaEnhu9yQLwnf1hJ63GRU1
         GbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260666; x=1691852666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwNGulIA2ho0EBWPPONOOw90suBzDLAU+ZErTuI+Vzc=;
        b=QEvCAlGuT0LYnxbyQ3yXw3Nf58NirPqawn1+p+Y/HMQvhGsKQ+CyzVqIPBH/lg/SxT
         PCkV3tYI5L/KgRCjIaMv22eAToeuY4zPpMnmzasEHt8GMRZAtffrmrtKu1tXduhZfE7j
         VP+CxDgVW0/ChHEbV7TnxvstS80KdPdbp4GS1MtHHgCwoqY679+hiMDKlU8eSnfbJ/Kj
         L0V4IU1bZHjnQNR+NjU/21wW4qCzGu0GqsXm3OKzfreJX6aNJ/cVZzf1vjQgCqoMnFLB
         hLZ/yCH6tWg9aENI5TWV49/LQPwJ3CGIplA8Lkduamp7JM2yz5iSFEpoAKafeuLY3OIC
         ngOQ==
X-Gm-Message-State: ABy/qLYyNBlWtyjAA8+v8Su0//ZAClxpePiHW26qO27tP4qJWA4xiJnO
        Me7P10kOi+KICYv9adIEg7OouA==
X-Google-Smtp-Source: APBJJlG70SgkGGn23vEi3FSKwCEUIJMon8LV4qYHTuV1LyiLcqxeGAwf1wxRGXZOoEsp5bCsKbtmeA==
X-Received: by 2002:a17:906:7786:b0:993:d8be:53f5 with SMTP id s6-20020a170906778600b00993d8be53f5mr1818669ejm.14.1689260666585;
        Thu, 13 Jul 2023 08:04:26 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:1d6d:d215:e7c4:dd5e])
        by smtp.gmail.com with ESMTPSA id cd26-20020a170906b35a00b009929c39d5c4sm4102939ejb.36.2023.07.13.08.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:04:26 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v7 0/8] soc: mediatek: MT8365 power support
Date:   Thu, 13 Jul 2023 17:04:06 +0200
Message-Id: <20230713150414.891893-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this version just fixes some small style issues and rebases to v6.5-rc1.

Thanks for any feedback!

Best,
Markus

Based on v6.5-rc1

Changes in v7:
- Rebased to v6.5-rc1
- Fixed a couple of small style issues pointed out by Angelo

Changes in v6:
- Change flags field to be u8 instead of u32
- Use macro concatenation to simplify BUS_PROT macros:
  BUS_PROT_WR(_hwip, ...) etc.
- Use the final bit values for scpsys_bus_prot_flags from the beginning
  of the series.
- Changed scpsys_domain_data->caps to be u16 to accommodate the new flag
  MTK_SCPD_STRICT_BUS_PROTECTION.

Changes in v5:
- Create defines for all registers and bits in mt8365 power domain patch
- Redesign scpsys_bus_prot_data to use flags to store reg_update,
  clr_ack as well as the difference between SMI and INFRACFG. The code
  uses the appropriate regmap depending on the flags.
- The WAY_EN patch now uses two flags, one for inverted operations
  'BUS_PROT_INVERTED' and one to use infracfg-nao for the status flags
  'BUS_PROT_STA_COMPONENT_INFRA_NAO'.

Changes in v4:
- Redesigned WAY_EN patch and split it up in smaller patches.
- Added two documentation patches.
- Added mediatek,infracfg-nao field to the binding.

Changes in v3:
- Mainly redesigned WAY_EN patch to be easier to understand
- Rebased onto v6.0-rc1
- Several other stuff that is described in the individual patches

Changes in v2:
- Updated error handling path for scpsys_power_on()
- Minor updates described in each patch

Previous versions:
v1 - https://lore.kernel.org/linux-mediatek/20220530204214.913251-1-fparent@baylibre.com/
v2 - https://lore.kernel.org/linux-mediatek/20220725081853.1636444-1-msp@baylibre.com/
v3 - https://lore.kernel.org/linux-mediatek/20220822144303.3438467-1-msp@baylibre.com/
v4 - https://lore.kernel.org/linux-arm-kernel/20230105170735.1637416-1-msp@baylibre.com/
v5 - https://lore.kernel.org/linux-arm-kernel/20230619085344.2885311-1-msp@baylibre.com/
v6 - https://lore.kernel.org/linux-arm-kernel/20230627131040.3418538-1-msp@baylibre.com/

Alexandre Bailon (2):
  soc: mediatek: Add support for WAY_EN operations
  soc: mediatek: Add support for MTK_SCPD_STRICT_BUS_PROTECTION cap

Fabien Parent (2):
  dt-bindings: power: Add MT8365 power domains
  soc: mediatek: pm-domains: Add support for MT8365

Markus Schneider-Pargmann (4):
  soc: mediatek: pm-domains: Move bools to a flags field
  soc: mediatek: pm-domains: Split bus_prot_mask
  soc: mediatek: pm-domains: Create bus protection operation functions
  soc: mediatek: pm-domains: Unify configuration for infracfg and smi

 .../power/mediatek,power-controller.yaml      |   6 +
 drivers/soc/mediatek/mt6795-pm-domains.h      |  16 +-
 drivers/soc/mediatek/mt8167-pm-domains.h      |  20 +-
 drivers/soc/mediatek/mt8173-pm-domains.h      |  16 +-
 drivers/soc/mediatek/mt8183-pm-domains.h      | 125 ++++++----
 drivers/soc/mediatek/mt8186-pm-domains.h      | 236 ++++++++++--------
 drivers/soc/mediatek/mt8188-pm-domains.h      | 223 +++++++++++------
 drivers/soc/mediatek/mt8192-pm-domains.h      | 112 ++++++---
 drivers/soc/mediatek/mt8195-pm-domains.h      | 199 +++++++++------
 drivers/soc/mediatek/mt8365-pm-domains.h      | 197 +++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c         | 157 ++++++++----
 drivers/soc/mediatek/mtk-pm-domains.h         |  51 ++--
 .../dt-bindings/power/mediatek,mt8365-power.h |  19 ++
 include/linux/soc/mediatek/infracfg.h         |  41 +++
 14 files changed, 972 insertions(+), 446 deletions(-)
 create mode 100644 drivers/soc/mediatek/mt8365-pm-domains.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8365-power.h


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.40.1

