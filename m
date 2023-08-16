Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBA877DE42
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243752AbjHPKMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243739AbjHPKLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:11:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681C8E3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:11:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so57619805e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692180697; x=1692785497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gGbwkZ5V6/YyLPE8Zp3GkVLQyAqLALpzu6OjLBSVDy0=;
        b=rAT9NQD7eCXUU472fon6nEd0kOc41WdS0+8kUIvA47MmJSq4kl9RzdyBgMCTV2bnIY
         pnakgROCIzfW+LV86BvUuvAnjSNUt/aDpfvXpwkyxt0L6x71pgiXnnNxGZKLP7eY0uUp
         l77CDjTI3XOAFCb4jexOIxdWRCe2yEocGJez/d7gGM4SVg8Xlx3QL8Pjshvai6wpQ2QS
         UxIwkBx0sR8uTwvPCzPk4rLpXgj86HrnR4lN0INbJWMwQrNVgqc4ebJBZ7hbhaAtyH9S
         RfS8bEoPRmxV+eSeWF6BdnLLnCMsmFqB/6ueH+PHmAGNboqRZfjuejoHg2TjFRvvIqBb
         4/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692180697; x=1692785497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGbwkZ5V6/YyLPE8Zp3GkVLQyAqLALpzu6OjLBSVDy0=;
        b=ib6tsheoF6GUDTjuPGIxARYU7Wx/RTnliVGmuEO9+NWb35AWcW7OxZHCBD44TbgFII
         sgrPDmga//Zq2Hmc0QPX0BAzylJXSbV+rGPJlqbu/rinG+/PPHnZjiXKdpjCKRLOawSM
         DSvpPBn5fIjvY/j7p1Ev+WfU8WWQS3/jMuZvzrEqPH77A0JYjUEHtcEeug60LO1qQnek
         FkFq40vNG8JdPnMbIfDUO7V57odIWEQRXM1LXFj0tnhM4fJFWY8eT0yThIgGvMxINopS
         MU0zODBOT8H2RA4X7NO3Z6UK2z5D4DRk/l9xwQH9A7y79FGByOPECtotikt5Dl5jJKON
         Uu9Q==
X-Gm-Message-State: AOJu0Yx6UKz4Zk+kOP+f2h+jqNQBiXr7bVrEReJx89CIe8NJxBXgSZTb
        Mhh2ccvOEJhAowdpFq48G7ftYw==
X-Google-Smtp-Source: AGHT+IG/ajfND14aH8TEYYlnoQqe8yFUni7toeHyU2hTsv5/z3osWzlG5FBQuGaXT+MXU4IexkK42Q==
X-Received: by 2002:a7b:ca53:0:b0:3fc:9e:eead with SMTP id m19-20020a7bca53000000b003fc009eeeadmr1093482wml.20.1692180696913;
        Wed, 16 Aug 2023 03:11:36 -0700 (PDT)
Received: from hackbox.lan ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d698d000000b003180027d67asm20848822wru.19.2023.08.16.03.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 03:11:36 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v6.6
Date:   Wed, 16 Aug 2023 13:11:20 +0300
Message-Id: <20230816101120.885812-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-6.6

for you to fetch changes up to 72d00e560d10665e6139c9431956a87ded6e9880:

  clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz (2023-08-14 12:52:32 +0300)

----------------------------------------------------------------
i.MX clocks changes for 6.6

- Add the PDM IPC clock for i.MX93
- Add 519.75MHz frequency support for i.MX9 PLL
- Simplify the .determine_rate() for GPR mux
- Make the i.MX8QXP LPCG clock use devm_platform_ioremap_resource
- Add the audio mux clock to i.MX8
- Fix the SPLL2 MULT range for PLLv4
- Update the SPLL2 type in i.MX8ULP
- Fix the SAI4 clock on i.MX8MP
- Add silicon revision print for i.MX25 on clocks init
- Drop the return value from __mx25_clocks_init
- Fix the clock pauses on no-op set_rate for i.MX8M composite clock
- Drop restrictions for PLL14xx and fix its max prediv value
- Drop the 393216000 and 361267200 from PLL14xx rate table to allow
  glitch free switching

----------------------------------------------------------------
Ahmad Fatoum (2):
      clk: imx: composite-8m: fix clock pauses when set_rate would be a no-op
      clk: imx: pll14xx: dynamically configure PLL for 393216000/361267200Hz

Chancel Liu (2):
      dt-bindings: clock: imx93: Add PDM IPG clk
      clk: imx93: Add PDM IPG clk

Christophe JAILLET (1):
      clk: imx: clk-gpr-mux: Simplify .determine_rate()

Jacky Bai (1):
      clk: imx: Add 519.75MHz frequency support for imx9 pll

Marco Felsch (3):
      clk: imx8mp: fix sai4 clock
      dt-bindings: clocks: imx8mp: make sai4 a dummy clock
      clk: imx: pll14xx: align pdiv with reference manual

Martin Kaiser (2):
      clk: imx25: print silicon revision during init
      clk: imx25: make __mx25_clocks_init return void

Peng Fan (1):
      clk: imx: imx8ulp: update SPLL2 type

Shengjiu Wang (2):
      dt-bindings: clock: fsl,imx8-acm: Add audio clock mux support
      clk: imx: imx8: add audio clock mux driver

Yangtao Li (1):
      clk: imx: clk-imx8qxp-lpcg: Convert to devm_platform_ioremap_resource()

Ye Li (1):
      clk: imx: pllv4: Fix SPLL2 MULT range

 .../devicetree/bindings/clock/fsl,imx8-acm.yaml    | 282 ++++++++++++
 drivers/clk/imx/Makefile                           |   3 +-
 drivers/clk/imx/clk-composite-8m.c                 |  12 +-
 drivers/clk/imx/clk-fracn-gppll.c                  |   1 +
 drivers/clk/imx/clk-gpr-mux.c                      |   8 +-
 drivers/clk/imx/clk-imx25.c                        |   5 +-
 drivers/clk/imx/clk-imx8-acm.c                     | 476 +++++++++++++++++++++
 drivers/clk/imx/clk-imx8mp.c                       |   5 -
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 |   4 +-
 drivers/clk/imx/clk-imx8ulp.c                      |   2 +-
 drivers/clk/imx/clk-imx93.c                        |   4 +-
 drivers/clk/imx/clk-pll14xx.c                      |  13 +-
 drivers/clk/imx/clk-pllv4.c                        |  46 +-
 drivers/clk/imx/clk.h                              |   1 +
 include/dt-bindings/clock/imx8-clock.h             |  28 ++
 include/dt-bindings/clock/imx8mp-clock.h           |   2 +-
 include/dt-bindings/clock/imx93-clock.h            |   3 +-
 include/soc/imx/revision.h                         |   1 +
 18 files changed, 851 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml
 create mode 100644 drivers/clk/imx/clk-imx8-acm.c
