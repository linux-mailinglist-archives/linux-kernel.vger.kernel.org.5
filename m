Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182BE78E99D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbjHaJj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245544AbjHaJj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:39:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835ABCFA
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:39:21 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50087d47d4dso1234944e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 02:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693474760; x=1694079560; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kajh2E7/37kXZY1AxbQpVoMzzMOUM2H0Ogl3H7ANGY0=;
        b=FEWFGUT++EHoCRrzQt6H+DisSUlKC5cZpe6J55mrfbTxSlq/6sXoOobtHznaOQK0lV
         Bbr0MsAsf/3SuO35WcZPpHm+xoOKIX940owhFV60XIWOY3qKBSXCQtXXVP0M/7l+7lk1
         i98oNQdGS5M0Mf+qLA6R7l6o5uwUakIHv8GL+45ZMZ6laPA0J6gKQuPAua4z5NM6D2t2
         pFLMHaAYnLGhBoHyvD2Y5PcU4AJ+Dhf/fO+X7yUuDV4lk6jb4N4cjZ4jGWTGcjZoYtFW
         TFZVBWgeWD+hajaf0WjyUWB7bVn1a023ATkEJM9cWvjiAu2NU8OvboHmghI1TFlaS56u
         txyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693474760; x=1694079560;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kajh2E7/37kXZY1AxbQpVoMzzMOUM2H0Ogl3H7ANGY0=;
        b=Inzp4Dk0A+DbYhlIrY5vZ1JUbardWIz5HtCYHSBuRx14koF/u5pQkuKp4bzVcegvhG
         G0wbs9oCOtuSBz6hBBELJqlglCs2fgGVFoPwmQmX6tSPW63S0njUN18OUZRTZRHOiUg7
         vT1JCr5yi6NYVbZjAI+F8iSxc08eYSlWGfTvq2lViWQA9swDm9PP+KwQlX7TiiCgQ/DX
         VTOdXFBRP1rstn4xIaa1TG0lDNxbG7ri38/vR/zSM6rYrf0JV7AkT+bKKumByHEt2+WC
         oyq2suL7nNAom8BXdPB5CbBu0uhq+J0ZQMTLR9015LAGI7bFlBassdfk12Rif1tp/y4n
         Fz3g==
X-Gm-Message-State: AOJu0YzAtlC+Zbc38SIkyOjZr6MDtel2Cnh7bnwXKdPjzlF2jheHFogb
        eEbdtVp22/tI9Wc5nKn8jQ9E2NT6i7hhRPrWrpBV/Q==
X-Google-Smtp-Source: AGHT+IGmjXKg9ripktsfGjPk1i3tc5vyosHeQRN9tZoNAtlGjCJ+CXhokMuSX8fSS74Es0/lrvxPFQ==
X-Received: by 2002:a05:6512:3291:b0:4fc:df79:3781 with SMTP id p17-20020a056512329100b004fcdf793781mr3369940lfe.66.1693474759719;
        Thu, 31 Aug 2023 02:39:19 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id o9-20020ac24949000000b00500b561285bsm185429lfi.292.2023.08.31.02.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 02:39:19 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 31 Aug 2023 11:39:14 +0200
Subject: [PATCH] clk: qcom: gcc-msm8996: Remove RPM bus clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-topic-rpmbusclocks8996gcc-v1-1-9e99bedcdc3b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMFf8GQC/x2NQQ6CMBBFr0JmbZMKKMWrEBftMMLE2jYzYkwId
 7dx+X7y/ttBSZgUbs0OQh9WzqnC+dQArj4tZHiuDK1tO+s6a965MBopr7ApxoxPdeN4XRDN4BB
 toH7uhwtUP3glE8QnXOtD2mKsYxF68PcfnO7H8QNiDLQBgAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693474758; l=16108;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=8HTriqGtLuoKxVW5oAMs9Hl5tGzcH6He8qF0pkWDCck=;
 b=DlU5fiuWqkcy9K3NggW6NYBIGgYsCidrD2Up2tSNt8fo3X3oTQ/8xL/p7ZQ2RVNyW5RfD/hLH
 0Mu42zhzakCB9wCLcxHhe0Glh+nZFLQBGmczd0udPD9LkM41za+E8WG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GCC driver contains clocks that are owned (meaning configured and
scaled) by the RPM core.

Remove them from Linux to stop interjecting the RPM's logic.

Fixes: b1e010c0730a ("clk: qcom: Add MSM8996 Global Clock Control (GCC) driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Evolution of:
https://lore.kernel.org/linux-arm-msm/20230612-topic-rcg2_ro-v1-0-e7d824aeb628@linaro.org/
---
 drivers/clk/qcom/gcc-msm8996.c | 237 +----------------------------------------
 1 file changed, 5 insertions(+), 232 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index 14dcc3f03668..e7b03a17514a 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -244,71 +244,6 @@ static const struct clk_parent_data gcc_xo_gpll0_gpll4_gpll0_early_div[] = {
 	{ .hw = &gpll0_early_div.hw }
 };
 
-static const struct freq_tbl ftbl_system_noc_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(50000000, P_GPLL0_EARLY_DIV, 6, 0, 0),
-	F(100000000, P_GPLL0, 6, 0, 0),
-	F(150000000, P_GPLL0, 4, 0, 0),
-	F(200000000, P_GPLL0, 3, 0, 0),
-	F(240000000, P_GPLL0, 2.5, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 system_noc_clk_src = {
-	.cmd_rcgr = 0x0401c,
-	.hid_width = 5,
-	.parent_map = gcc_xo_gpll0_gpll0_early_div_map,
-	.freq_tbl = ftbl_system_noc_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "system_noc_clk_src",
-		.parent_data = gcc_xo_gpll0_gpll0_early_div,
-		.num_parents = ARRAY_SIZE(gcc_xo_gpll0_gpll0_early_div),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static const struct freq_tbl ftbl_config_noc_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(37500000, P_GPLL0, 16, 0, 0),
-	F(75000000, P_GPLL0, 8, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 config_noc_clk_src = {
-	.cmd_rcgr = 0x0500c,
-	.hid_width = 5,
-	.parent_map = gcc_xo_gpll0_map,
-	.freq_tbl = ftbl_config_noc_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "config_noc_clk_src",
-		.parent_data = gcc_xo_gpll0,
-		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static const struct freq_tbl ftbl_periph_noc_clk_src[] = {
-	F(19200000, P_XO, 1, 0, 0),
-	F(37500000, P_GPLL0, 16, 0, 0),
-	F(50000000, P_GPLL0, 12, 0, 0),
-	F(75000000, P_GPLL0, 8, 0, 0),
-	F(100000000, P_GPLL0, 6, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 periph_noc_clk_src = {
-	.cmd_rcgr = 0x06014,
-	.hid_width = 5,
-	.parent_map = gcc_xo_gpll0_map,
-	.freq_tbl = ftbl_periph_noc_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "periph_noc_clk_src",
-		.parent_data = gcc_xo_gpll0,
-		.num_parents = ARRAY_SIZE(gcc_xo_gpll0),
-		.ops = &clk_rcg2_ops,
-	},
-};
-
 static const struct freq_tbl ftbl_usb30_master_clk_src[] = {
 	F(19200000, P_XO, 1, 0, 0),
 	F(120000000, P_GPLL0, 5, 0, 0),
@@ -1297,11 +1232,7 @@ static struct clk_branch gcc_mmss_noc_cfg_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_mmss_noc_cfg_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&config_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+			.flags = CLK_IGNORE_UNUSED,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1464,11 +1395,6 @@ static struct clk_branch gcc_usb_phy_cfg_ahb2phy_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_usb_phy_cfg_ahb2phy_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&periph_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1498,11 +1424,6 @@ static struct clk_branch gcc_sdcc1_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_sdcc1_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&periph_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1549,11 +1470,6 @@ static struct clk_branch gcc_sdcc2_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_sdcc2_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&periph_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1583,11 +1499,6 @@ static struct clk_branch gcc_sdcc3_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_sdcc3_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&periph_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1617,11 +1528,6 @@ static struct clk_branch gcc_sdcc4_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_sdcc4_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&periph_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1635,11 +1541,6 @@ static struct clk_branch gcc_blsp1_ahb_clk = {
 		.enable_mask = BIT(17),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_blsp1_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&periph_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1977,11 +1878,6 @@ static struct clk_branch gcc_blsp2_ahb_clk = {
 		.enable_mask = BIT(15),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_blsp2_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&periph_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2318,11 +2214,6 @@ static struct clk_branch gcc_pdm_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pdm_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&periph_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2353,11 +2244,6 @@ static struct clk_branch gcc_prng_ahb_clk = {
 		.enable_mask = BIT(13),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_prng_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&config_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2370,11 +2256,6 @@ static struct clk_branch gcc_tsif_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_tsif_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&periph_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2422,11 +2303,6 @@ static struct clk_branch gcc_boot_rom_ahb_clk = {
 		.enable_mask = BIT(10),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_boot_rom_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&config_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2520,11 +2396,6 @@ static struct clk_branch gcc_pcie_0_slv_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_slv_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&system_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2537,11 +2408,6 @@ static struct clk_branch gcc_pcie_0_mstr_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_mstr_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&system_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2554,11 +2420,6 @@ static struct clk_branch gcc_pcie_0_cfg_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_0_cfg_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&config_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2606,11 +2467,6 @@ static struct clk_branch gcc_pcie_1_slv_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_slv_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&system_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2623,11 +2479,6 @@ static struct clk_branch gcc_pcie_1_mstr_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_mstr_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&system_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2640,11 +2491,6 @@ static struct clk_branch gcc_pcie_1_cfg_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_1_cfg_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&config_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2692,11 +2538,6 @@ static struct clk_branch gcc_pcie_2_slv_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_2_slv_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&system_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2709,11 +2550,6 @@ static struct clk_branch gcc_pcie_2_mstr_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_2_mstr_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&system_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2726,11 +2562,6 @@ static struct clk_branch gcc_pcie_2_cfg_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_2_cfg_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&config_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2778,11 +2609,6 @@ static struct clk_branch gcc_pcie_phy_cfg_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_pcie_phy_cfg_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&config_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -2829,11 +2655,6 @@ static struct clk_branch gcc_ufs_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_ufs_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&config_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3060,11 +2881,7 @@ static struct clk_branch gcc_aggre0_snoc_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_aggre0_snoc_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&system_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3077,11 +2894,7 @@ static struct clk_branch gcc_aggre0_cnoc_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_aggre0_cnoc_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&config_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3094,11 +2907,7 @@ static struct clk_branch gcc_smmu_aggre0_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_smmu_aggre0_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&system_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3111,11 +2920,7 @@ static struct clk_branch gcc_smmu_aggre0_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_smmu_aggre0_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&config_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+			.flags = CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3162,10 +2967,6 @@ static struct clk_branch gcc_dcc_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_dcc_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&config_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3178,10 +2979,6 @@ static struct clk_branch gcc_aggre0_noc_mpu_cfg_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_aggre0_noc_mpu_cfg_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&config_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3194,11 +2991,6 @@ static struct clk_branch gcc_qspi_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qspi_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&periph_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3347,10 +3139,6 @@ static struct clk_branch gcc_mss_cfg_ahb_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_mss_cfg_ahb_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&config_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3363,10 +3151,6 @@ static struct clk_branch gcc_mss_mnoc_bimc_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_mss_mnoc_bimc_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&system_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3379,10 +3163,6 @@ static struct clk_branch gcc_mss_snoc_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_mss_snoc_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&system_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3395,10 +3175,6 @@ static struct clk_branch gcc_mss_q6_bimc_axi_clk = {
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_mss_q6_bimc_axi_clk",
-			.parent_hws = (const struct clk_hw*[]){
-				&system_noc_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -3495,9 +3271,6 @@ static struct clk_regmap *gcc_msm8996_clocks[] = {
 	[GPLL0] = &gpll0.clkr,
 	[GPLL4_EARLY] = &gpll4_early.clkr,
 	[GPLL4] = &gpll4.clkr,
-	[SYSTEM_NOC_CLK_SRC] = &system_noc_clk_src.clkr,
-	[CONFIG_NOC_CLK_SRC] = &config_noc_clk_src.clkr,
-	[PERIPH_NOC_CLK_SRC] = &periph_noc_clk_src.clkr,
 	[USB30_MASTER_CLK_SRC] = &usb30_master_clk_src.clkr,
 	[USB30_MOCK_UTMI_CLK_SRC] = &usb30_mock_utmi_clk_src.clkr,
 	[USB3_PHY_AUX_CLK_SRC] = &usb3_phy_aux_clk_src.clkr,

---
base-commit: 56585460cc2ec44fc5d66924f0a116f57080f0dc
change-id: 20230830-topic-rpmbusclocks8996gcc-78cc0be4d475

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

