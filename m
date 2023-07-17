Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D44D75678B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjGQPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjGQPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:19:29 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A75BD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:24 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso7289185e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689607162; x=1692199162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9bzAyxEmZcjuCgWaxCe1scGgqcWcCc2saD7jQbkp1s=;
        b=vT5vpikihNkMJKaZ/Qf6szhp3xNMEA4DwQ6u06WwTwuPK7dKC7kQJwAii06wK7TNKS
         XLF6hdPM0V7qNOM1A7+iXyNi01G9cPKcjb9zx5oC71o+dF+gh+yfm9EV7cV2IpGyyd7Q
         aue+eCvd/GaLRITjAJhJRqqIXE9sQHejGU5OdINb37UV3Z/vgAXa4NBeH+jXB5ZMve5f
         XAFQIbc6akIiZBwhf/BjSXlmR9rzv8G9Rlry2Ypfgeud8Oi7LrDrPWZNiQKKo+vVEzpe
         KJmoW7Z1AdITQrCgbXULFCk4FQFcUaI6g3oUa7K2e5MZFMncTHPGtswaWdXVKFPBEXtn
         /q7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689607162; x=1692199162;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9bzAyxEmZcjuCgWaxCe1scGgqcWcCc2saD7jQbkp1s=;
        b=GvXjW5SDTU9DlfHZ8iXNJgqMyV+Ab3U0/dG50rsoMXEVFoUYY0YQBG+GY5DV3Z2WbS
         BCDzWxAnz2WOEoqFoot7YQbWVusZdxzL1f7z6CLOtD2LjkVieJq+nsxhEqDo9Eu9GsZt
         ZPEA23L6YuEXliB0cArqkNcQoS1yOHhVEpS+uRFMKmWzL+vfACrBKulRu4Nr2bqq/QM1
         DMhUl+1hMop7AA5dw+pxz3TsWvF9x0tKFcwBC9FNgs92+PJsZ8bgI4fTJ4Ut3SztVwdS
         3/PfcX3mZWwo2dQ9+eULJn2CgwKSWJb/nzECl77Pu34K2aDoWrCL4+PTWFdqoP+OfUI5
         rlTQ==
X-Gm-Message-State: ABy/qLbDTEGhfin7L9tC3j56jTPuNc5Wt+qOit1a2BUhYo6+fWVFnMtu
        7RcJ8iSdJHdoulI270mD/HN4dg==
X-Google-Smtp-Source: APBJJlEYn7XZQDHm872lmrD3HHbdNPVNmhgyBztZ+PidTZMCUCNaQ2G94NYFJWgsOdrEMwgj3/nQlg==
X-Received: by 2002:a05:6512:348b:b0:4fb:8616:7a03 with SMTP id v11-20020a056512348b00b004fb86167a03mr7426349lfr.4.1689607162748;
        Mon, 17 Jul 2023 08:19:22 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id z7-20020ac24187000000b004f26d63f823sm2873949lfh.237.2023.07.17.08.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 08:19:22 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 17 Jul 2023 17:19:15 +0200
Subject: [PATCH 08/15] clk: qcom: gcc-sm6115: Unregister critical clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v1-8-27784d27a4f4@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689607149; l=7208;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Aprdi0pZJRcBcTqfoFWAZFZktiahphM2R1wPtOeWO3k=;
 b=YtWCtGmXdJsmjCmRwxfGg668SV4dORifui04NPqdj8pEemuT9pVl8Oi2UM+iAzXxEyZc3e0pY
 9gEbb12MF3KAL+mxHS9JvdtTwH8s1g9gGR6pAmBAH+o+0DENyIsnvc+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks need to be always-on, but we don't really do anything
with them, other than calling enable() once and telling Linux they're
enabled.

Unregister them to save a couple of bytes and, perhaps more
importantly, allow for runtime suspend of the clock controller device,
as CLK_IS_CRITICAL prevents the latter.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm6115.c | 133 ++++++------------------------------------
 1 file changed, 18 insertions(+), 115 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index 033e308ff865..1b6016e7ddeb 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -1585,36 +1585,6 @@ static struct clk_branch gcc_cam_throttle_rt_clk = {
 	},
 };
 
-static struct clk_branch gcc_camera_ahb_clk = {
-	.halt_reg = 0x17008,
-	.halt_check = BRANCH_HALT_DELAY,
-	.hwcg_reg = 0x17008,
-	.hwcg_bit = 1,
-	.clkr = {
-		.enable_reg = 0x17008,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_camera_ahb_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_camera_xo_clk = {
-	.halt_reg = 0x17028,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x17028,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_camera_xo_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_camss_axi_clk = {
 	.halt_reg = 0x58044,
 	.halt_check = BRANCH_HALT,
@@ -2123,38 +2093,6 @@ static struct clk_branch gcc_cfg_noc_usb3_prim_axi_clk = {
 	},
 };
 
-static struct clk_branch gcc_cpuss_gnoc_clk = {
-	.halt_reg = 0x2b004,
-	.halt_check = BRANCH_HALT_VOTED,
-	.hwcg_reg = 0x2b004,
-	.hwcg_bit = 1,
-	.clkr = {
-		.enable_reg = 0x79004,
-		.enable_mask = BIT(22),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_cpuss_gnoc_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_disp_ahb_clk = {
-	.halt_reg = 0x1700c,
-	.halt_check = BRANCH_HALT,
-	.hwcg_reg = 0x1700c,
-	.hwcg_bit = 1,
-	.clkr = {
-		.enable_reg = 0x1700c,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_disp_ahb_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_regmap_div gcc_disp_gpll0_clk_src = {
 	.reg = 0x17058,
 	.shift = 0,
@@ -2214,20 +2152,6 @@ static struct clk_branch gcc_disp_throttle_core_clk = {
 	},
 };
 
-static struct clk_branch gcc_disp_xo_clk = {
-	.halt_reg = 0x1702c,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x1702c,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_disp_xo_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_gp1_clk = {
 	.halt_reg = 0x4d000,
 	.halt_check = BRANCH_HALT,
@@ -2282,22 +2206,6 @@ static struct clk_branch gcc_gp3_clk = {
 	},
 };
 
-static struct clk_branch gcc_gpu_cfg_ahb_clk = {
-	.halt_reg = 0x36004,
-	.halt_check = BRANCH_HALT,
-	.hwcg_reg = 0x36004,
-	.hwcg_bit = 1,
-	.clkr = {
-		.enable_reg = 0x36004,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_gpu_cfg_ahb_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_gpu_gpll0_clk_src = {
 	.halt_check = BRANCH_HALT_DELAY,
 	.clkr = {
@@ -2770,22 +2678,6 @@ static struct clk_branch gcc_sdcc2_apps_clk = {
 	},
 };
 
-static struct clk_branch gcc_sys_noc_cpuss_ahb_clk = {
-	.halt_reg = 0x2b06c,
-	.halt_check = BRANCH_HALT_VOTED,
-	.hwcg_reg = 0x2b06c,
-	.hwcg_bit = 1,
-	.clkr = {
-		.enable_reg = 0x79004,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_sys_noc_cpuss_ahb_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_sys_noc_ufs_phy_axi_clk = {
 	.halt_reg = 0x45098,
 	.halt_check = BRANCH_HALT,
@@ -3271,8 +3163,6 @@ static struct clk_regmap *gcc_sm6115_clocks[] = {
 	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
 	[GCC_CAM_THROTTLE_NRT_CLK] = &gcc_cam_throttle_nrt_clk.clkr,
 	[GCC_CAM_THROTTLE_RT_CLK] = &gcc_cam_throttle_rt_clk.clkr,
-	[GCC_CAMERA_AHB_CLK] = &gcc_camera_ahb_clk.clkr,
-	[GCC_CAMERA_XO_CLK] = &gcc_camera_xo_clk.clkr,
 	[GCC_CAMSS_AXI_CLK] = &gcc_camss_axi_clk.clkr,
 	[GCC_CAMSS_AXI_CLK_SRC] = &gcc_camss_axi_clk_src.clkr,
 	[GCC_CAMSS_CAMNOC_ATB_CLK] = &gcc_camss_camnoc_atb_clk.clkr,
@@ -3321,20 +3211,16 @@ static struct clk_regmap *gcc_sm6115_clocks[] = {
 	[GCC_CAMSS_TOP_AHB_CLK] = &gcc_camss_top_ahb_clk.clkr,
 	[GCC_CAMSS_TOP_AHB_CLK_SRC] = &gcc_camss_top_ahb_clk_src.clkr,
 	[GCC_CFG_NOC_USB3_PRIM_AXI_CLK] = &gcc_cfg_noc_usb3_prim_axi_clk.clkr,
-	[GCC_CPUSS_GNOC_CLK] = &gcc_cpuss_gnoc_clk.clkr,
-	[GCC_DISP_AHB_CLK] = &gcc_disp_ahb_clk.clkr,
 	[GCC_DISP_GPLL0_CLK_SRC] = &gcc_disp_gpll0_clk_src.clkr,
 	[GCC_DISP_GPLL0_DIV_CLK_SRC] = &gcc_disp_gpll0_div_clk_src.clkr,
 	[GCC_DISP_HF_AXI_CLK] = &gcc_disp_hf_axi_clk.clkr,
 	[GCC_DISP_THROTTLE_CORE_CLK] = &gcc_disp_throttle_core_clk.clkr,
-	[GCC_DISP_XO_CLK] = &gcc_disp_xo_clk.clkr,
 	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
 	[GCC_GP1_CLK_SRC] = &gcc_gp1_clk_src.clkr,
 	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
 	[GCC_GP2_CLK_SRC] = &gcc_gp2_clk_src.clkr,
 	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
 	[GCC_GP3_CLK_SRC] = &gcc_gp3_clk_src.clkr,
-	[GCC_GPU_CFG_AHB_CLK] = &gcc_gpu_cfg_ahb_clk.clkr,
 	[GCC_GPU_GPLL0_CLK_SRC] = &gcc_gpu_gpll0_clk_src.clkr,
 	[GCC_GPU_GPLL0_DIV_CLK_SRC] = &gcc_gpu_gpll0_div_clk_src.clkr,
 	[GCC_GPU_IREF_CLK] = &gcc_gpu_iref_clk.clkr,
@@ -3375,7 +3261,6 @@ static struct clk_regmap *gcc_sm6115_clocks[] = {
 	[GCC_SDCC2_AHB_CLK] = &gcc_sdcc2_ahb_clk.clkr,
 	[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
 	[GCC_SDCC2_APPS_CLK_SRC] = &gcc_sdcc2_apps_clk_src.clkr,
-	[GCC_SYS_NOC_CPUSS_AHB_CLK] = &gcc_sys_noc_cpuss_ahb_clk.clkr,
 	[GCC_SYS_NOC_UFS_PHY_AXI_CLK] = &gcc_sys_noc_ufs_phy_axi_clk.clkr,
 	[GCC_SYS_NOC_USB3_PRIM_AXI_CLK] = &gcc_sys_noc_usb3_prim_axi_clk.clkr,
 	[GCC_UFS_CLKREF_CLK] = &gcc_ufs_clkref_clk.clkr,
@@ -3512,6 +3397,24 @@ static int gcc_sm6115_probe(struct platform_device *pdev)
 	clk_alpha_pll_configure(&gpll10, regmap, &gpll10_config);
 	clk_alpha_pll_configure(&gpll11, regmap, &gpll11_config);
 
+	/*
+	 * Keep the following clocks always on:
+	 * GCC_CAMERA_AHB_CLK
+	 * GCC_CAMERA_XO_CLK
+	 * GCC_CPUSS_GNOC_CLK
+	 * GCC_DISP_AHB_CLK
+	 * GCC_DISP_XO_CLK
+	 * GCC_GPU_CFG_AHB_CLK
+	 * GCC_SYS_NOC_CPUSS_AHB_CLK
+	 */
+	qcom_branch_set_clk_en(regmap, 0x17008);
+	qcom_branch_set_clk_en(regmap, 0x17028);
+	qcom_branch_set_clk_en(regmap, 0x2b004);
+	qcom_branch_set_clk_en(regmap, 0x1700c);
+	qcom_branch_set_clk_en(regmap, 0x1702c);
+	qcom_branch_set_clk_en(regmap, 0x36004);
+	qcom_branch_set_clk_en(regmap, 0x2b06c);
+
 	return qcom_cc_really_probe(pdev, &gcc_sm6115_desc, regmap);
 }
 

-- 
2.41.0

