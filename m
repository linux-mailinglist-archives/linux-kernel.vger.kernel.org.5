Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EF87D12F0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377753AbjJTPhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377696AbjJTPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:37:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19761D65
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:37:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b95622c620so150503366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697816234; x=1698421034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BcjhE/VDAP/vUUzCJ5UsdBYIA+V/VX3Pzs2a+6tDBk0=;
        b=DPT5PnNa8mJCnKthHN449tMAbgDaAVvmnWz93V7a6pmBh0OaH/7waVtlK7kwZ5glry
         siiM/1bglLhTH7bhsLancP82MDDC08qEqESSbd7pZgegOmGWSoVfFD1yhWJf5on0ACEA
         G5Olav9y9ShwNSaI003NSQDa+vjt78UTsrsFQNfAU/rbV4ZhqmF5wRCDI60NSDDQdSN3
         kpdLAEzV9Eo6sq2QfopPYYbD5HFeiyqE3kpNWxwZIwQT4mn3s71ClYvQbV78aiVQLllo
         TCLyr3iaDT83ex6wOw4H0mvuKxCxGqOEC/1XBzRkTta2fTSr98X04lCTQDEwANkbumpM
         FJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697816234; x=1698421034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BcjhE/VDAP/vUUzCJ5UsdBYIA+V/VX3Pzs2a+6tDBk0=;
        b=oXYUd9QG85sbs3U52Ie2OR7yVHbQTyfThEKn6IyweO4gB+/U4ZxjOdEouIjYfjsjqC
         /s/sNVw7Rxh4n2VLqrLsYU2Y63nHUi2n3hjacWZZefNz3xxmUmb0lZfOWAUorWeB/VpO
         tlpAVF1JNKgKsFOPpLiBPmNs37eGjSK5o5qUrTMTfahl/TJMbMEH6Hc49xsZ4Qmgr/1V
         mmR1MbTsiWWeDmql/NOX9B3oENEMUybk0MQ15ZBxdijO1FmAh1/wAmEgKrMnHNmnxlke
         1pOnPPtTKhETSmKuqe8EAD2wPHacYORcJa7GJD0Ja2nk3egMfXqQq1+HtPuzO5OGX9k1
         jZSg==
X-Gm-Message-State: AOJu0YxM4E//7bj67Wzm8g02Wx8xyLV+RIHfUZoG8puciZdjRHN9QKn6
        c9vyvXD3xRcwwVAy3GLGOh2QRQ==
X-Google-Smtp-Source: AGHT+IHZPN2+UrCMVFrf3KNUsmji8s01Mviv4I64tQ8tn/u/gi1W+3A4Y/35RW/yDbc3Pj+6dUwMVw==
X-Received: by 2002:a17:907:3688:b0:9c2:a072:78bf with SMTP id bi8-20020a170907368800b009c2a07278bfmr1701512ejc.26.1697816234418;
        Fri, 20 Oct 2023 08:37:14 -0700 (PDT)
Received: from hackbox.lan ([79.115.22.174])
        by smtp.gmail.com with ESMTPSA id x13-20020a170906710d00b009ad87fd4e65sm1692162ejj.108.2023.10.20.08.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:37:13 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v6.7
Date:   Fri, 20 Oct 2023 18:37:11 +0300
Message-Id: <20231020153711.1979439-1-abel.vesa@linaro.org>
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

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-6.7

for you to fetch changes up to 2838820800dcaa60f32bef715c7e2e87e049aebc:

  clk: imx: imx8qm/qxp: add more resources to whitelist (2023-10-04 15:44:19 +0300)

----------------------------------------------------------------
i.MX clocks changes for 6.7

- Select MXC_CLK when building in the CLK_IMX8QXP
- Fixes for error handling paths in i.MX8 ACM driver
- Move the clocks check in i.MX8 ACM driver in order to log any error
- Drop the unused return value of clk_imx_acm_detach_pm_domains
- Drop non-existant IMX8MP_CLK_AUDIOMIX_PDM_ROOT clock
- Fix error handling in i.MX8MQ clock driver
- Allow a different LCDIF1 clock parent if DT describes it for i.MX6SX
- Keep the SCU resource table sorted in the i.MX8DXL rsrc driver
- Move the elcdif PLL clock registration above lcd_clk, as it is its parent
- Correct some ENET specific clocks for i.MX8DXL platform
- Drop the VPU_UART and VPUCORE from i.MX8QM as latest HW revision doesn't have them
- Remove "de-featured" MLB support from i.MX8QM/QXP/DXL platforms
- Skip registering clocks owned by Cortex-A partition SCU-based platforms
- Add CAN_1/2 to i.MX8QM and M4_0, PI_0_PWM_0 and PI_0_I2C_0 to i.MX8QXP resources

----------------------------------------------------------------
Abel Vesa (1):
      clk: imx: Select MXC_CLK for CLK_IMX8QXP

Adam Ford (1):
      clk: imx8mp: Remove non-existent IMX8MP_CLK_AUDIOMIX_PDM_ROOT

Christophe JAILLET (5):
      clk: imx: imx8: Fix an error handling path in clk_imx_acm_attach_pm_domains()
      clk: imx: imx8: Fix an error handling path if devm_clk_hw_register_mux_parent_data_table() fails
      clk: imx: imx8: Fix an error handling path in imx8_acm_clk_probe()
      clk: imx: imx8: Add a message in case of devm_clk_hw_register_mux_parent_data_table() error
      clk: imx: imx8: Simplify clk_imx_acm_detach_pm_domains()

Fabio Estevam (1):
      clk: imx: imx6sx: Allow a different LCDIF1 clock parent

Peng Fan (5):
      clk: imx: imx8mq: correct error handling path
      clk: imx: imx8qm-rsrc: drop VPU_UART/VPUCORE
      clk: imx8: remove MLB support
      clk: imx: scu: ignore clks not owned by Cortex-A partition
      clk: imx: imx8qm/qxp: add more resources to whitelist

Robert Chiras (1):
      clk: imx: imx8qxp: Fix elcdif_pll clock

Shenwei Wang (1):
      clk: imx: imx8qxp: correct the enet clocks for i.MX8DXL

Viorel Suman (1):
      clk: imx: imx8dxl-rsrc: keep sorted in the ascending order

 drivers/clk/imx/Kconfig                  |  1 +
 drivers/clk/imx/clk-imx6sx.c             | 14 +++++++++++---
 drivers/clk/imx/clk-imx8-acm.c           | 33 +++++++++++++++++---------------
 drivers/clk/imx/clk-imx8dxl-rsrc.c       |  3 +--
 drivers/clk/imx/clk-imx8mq.c             | 17 +++++++++-------
 drivers/clk/imx/clk-imx8qm-rsrc.c        |  5 ++---
 drivers/clk/imx/clk-imx8qxp-lpcg.h       |  1 -
 drivers/clk/imx/clk-imx8qxp-rsrc.c       |  4 +++-
 drivers/clk/imx/clk-imx8qxp.c            | 13 ++++++++++---
 drivers/clk/imx/clk-scu.c                | 20 +++++++++++++++++++
 include/dt-bindings/clock/imx8mp-clock.h |  1 -
 11 files changed, 76 insertions(+), 36 deletions(-)
