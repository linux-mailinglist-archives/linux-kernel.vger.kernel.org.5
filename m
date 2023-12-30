Return-Path: <linux-kernel+bounces-13423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC1D820666
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A109A1F219DD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26976B65E;
	Sat, 30 Dec 2023 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkKVDbF0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAE6B665
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cca5e7b390so73543451fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 05:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703941472; x=1704546272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZCmLkQxcwYLgBE1mbdbQPfZeHizeYZhVgqdzCTyqws=;
        b=HkKVDbF0ykNtS1rg1lRZ39cev3ZP5kWsp3HEilRlqV7r9FreDOgsu6sJdMPFBs8xgj
         dzy17HB8g6V+kZt7caHKxgN9MZ9Tw6pWkBiGW7UEo3Zd/z4WiUma13isTPZYmdHsowTx
         Oqw2DUAubb/KCDzKWH4qI6osVHWXOxkoFLkRpJZ9fie+5ilOV+6lulTqXcciSspvpfpm
         Lj2/0Z5K5SVw0NLaPiEw+gNb263H0RnnLPZRGh2QPDSgbGiO0Tm0qTFHOPlL/Iq6eRNB
         tWbALunSrKrSNyQEwSVVc2mIEHE8gEoTNg+tI16oG7Tohq0BRO2VHMSdQr/RhkQx01wX
         r0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703941472; x=1704546272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZCmLkQxcwYLgBE1mbdbQPfZeHizeYZhVgqdzCTyqws=;
        b=cmQSKTQBUVQbeA1wH+w714TWbLSikH4XXKGUY5RbcA+hnnWd3icbOe2JM4QsnuN7Z+
         Z6LGydS+UgWvtW33kpCljRjd8v4Mp/XvuwpuOvGBeZDkzwlPYawyC/utKzK+sIEiurdT
         7EyNP4R84m9tqwdhyHfLp5sJWtDnE6CUeg5Ac2BkUaiaY5kAsxVLfll1iXwEQTUtZ0oO
         kPSP/BfVk2+sIUhCMI/rUnif+yKDEqUR2vfiOuDKW7qAKRbG7yU6fjHVNDuB4E5ni9AD
         zUQBBZwkYfFxftdxZcfwe0L8uTGdsy91XAfrOL8aHQsvM7mVfDKKcFJGo4SxIUItZnIZ
         nYHg==
X-Gm-Message-State: AOJu0Yw2Y43TftPAe/6nH977Row0ZbgJ9OY/Aqg4znyb4s2KFrt794YE
	lgvIXa2yaT9Mmo8vMvbAK5gZCZtfH50W4uoT1azjrGR7ous=
X-Google-Smtp-Source: AGHT+IE8AzxZBSXX8bHO0SE71bi4xDlqKl4VHoVOVspWcpgOGt/GWA8qwun2kDWbBCiwKDSH5ybZww==
X-Received: by 2002:a2e:ba0a:0:b0:2cc:6088:74b1 with SMTP id p10-20020a2eba0a000000b002cc608874b1mr4875863lja.75.1703941472332;
        Sat, 30 Dec 2023 05:04:32 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id ij14-20020a056402158e00b00554368c9ce8sm11359578edb.1.2023.12.30.05.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 05:04:31 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 30 Dec 2023 14:04:05 +0100
Subject: [PATCH v4 03/12] clk: qcom: gcc-sm6375: Unregister critical clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v4-3-32c293ded915@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703941465; l=6876;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=YKshHakFI9eVbjWbYdLj0FC9zBMVp8IAw+bvR+xC9uo=;
 b=3EtyDzJkZGCtm7l+xdt5Sv5WVe8V5Y0buZ1FJtDTk6jsmWRyYZMiR8pyZwntkN98ckX2ZT/Hw
 qf9BCBQIiANBDDtr4N6R1njcYoPWr4Pa7uA8E35kmAdWSLmd1sJ47+I
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some clocks need to be always-on, but we don't really do anything
with them, other than calling enable() once and telling Linux they're
enabled.

Unregister them to save a couple of bytes and, perhaps more
importantly, allow for runtime suspend of the clock controller device,
as CLK_IS_CRITICAL prevents the latter.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm6375.c | 94 +++----------------------------------------
 1 file changed, 5 insertions(+), 89 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6375.c b/drivers/clk/qcom/gcc-sm6375.c
index c795b5db70bb..5abe7d60ec85 100644
--- a/drivers/clk/qcom/gcc-sm6375.c
+++ b/drivers/clk/qcom/gcc-sm6375.c
@@ -1743,22 +1743,6 @@ static struct clk_branch gcc_cam_throttle_rt_clk = {
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
 static struct clk_branch gcc_camss_axi_clk = {
 	.halt_reg = 0x58044,
 	.halt_check = BRANCH_HALT,
@@ -2309,22 +2293,6 @@ static struct clk_branch gcc_cfg_noc_usb3_prim_axi_clk = {
 	},
 };
 
-static struct clk_branch gcc_disp_ahb_clk = {
-	.halt_reg = 0x1700c,
-	.halt_check = BRANCH_HALT_VOTED,
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
@@ -2455,22 +2423,6 @@ static struct clk_branch gcc_gp3_clk = {
 	},
 };
 
-static struct clk_branch gcc_gpu_cfg_ahb_clk = {
-	.halt_reg = 0x36004,
-	.halt_check = BRANCH_HALT_VOTED,
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
@@ -3094,26 +3046,6 @@ static struct clk_branch gcc_sdcc2_apps_clk = {
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
-			.parent_hws = (const struct clk_hw*[]) {
-				&gcc_cpuss_ahb_postdiv_clk_src.clkr.hw,
-			},
-			.num_parents = 1,
-			.flags = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_sys_noc_ufs_phy_axi_clk = {
 	.halt_reg = 0x45098,
 	.halt_check = BRANCH_HALT,
@@ -3433,22 +3365,6 @@ static struct clk_branch gcc_venus_ctl_axi_clk = {
 	},
 };
 
-static struct clk_branch gcc_video_ahb_clk = {
-	.halt_reg = 0x17004,
-	.halt_check = BRANCH_HALT_DELAY,
-	.hwcg_reg = 0x17004,
-	.hwcg_bit = 1,
-	.clkr = {
-		.enable_reg = 0x17004,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_video_ahb_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_video_axi0_clk = {
 	.halt_reg = 0x1701c,
 	.halt_check = BRANCH_HALT_VOTED,
@@ -3615,7 +3531,6 @@ static struct clk_regmap *gcc_sm6375_clocks[] = {
 	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
 	[GCC_CAM_THROTTLE_NRT_CLK] = &gcc_cam_throttle_nrt_clk.clkr,
 	[GCC_CAM_THROTTLE_RT_CLK] = &gcc_cam_throttle_rt_clk.clkr,
-	[GCC_CAMERA_AHB_CLK] = &gcc_camera_ahb_clk.clkr,
 	[GCC_CAMSS_AXI_CLK] = &gcc_camss_axi_clk.clkr,
 	[GCC_CAMSS_AXI_CLK_SRC] = &gcc_camss_axi_clk_src.clkr,
 	[GCC_CAMSS_CCI_0_CLK] = &gcc_camss_cci_0_clk.clkr,
@@ -3671,7 +3586,6 @@ static struct clk_regmap *gcc_sm6375_clocks[] = {
 	[GCC_CFG_NOC_USB3_PRIM_AXI_CLK] = &gcc_cfg_noc_usb3_prim_axi_clk.clkr,
 	[GCC_CPUSS_AHB_CLK_SRC] = &gcc_cpuss_ahb_clk_src.clkr,
 	[GCC_CPUSS_AHB_POSTDIV_CLK_SRC] = &gcc_cpuss_ahb_postdiv_clk_src.clkr,
-	[GCC_DISP_AHB_CLK] = &gcc_disp_ahb_clk.clkr,
 	[GCC_DISP_GPLL0_CLK_SRC] = &gcc_disp_gpll0_clk_src.clkr,
 	[GCC_DISP_GPLL0_DIV_CLK_SRC] = &gcc_disp_gpll0_div_clk_src.clkr,
 	[GCC_DISP_HF_AXI_CLK] = &gcc_disp_hf_axi_clk.clkr,
@@ -3683,7 +3597,6 @@ static struct clk_regmap *gcc_sm6375_clocks[] = {
 	[GCC_GP2_CLK_SRC] = &gcc_gp2_clk_src.clkr,
 	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
 	[GCC_GP3_CLK_SRC] = &gcc_gp3_clk_src.clkr,
-	[GCC_GPU_CFG_AHB_CLK] = &gcc_gpu_cfg_ahb_clk.clkr,
 	[GCC_GPU_GPLL0_CLK_SRC] = &gcc_gpu_gpll0_clk_src.clkr,
 	[GCC_GPU_GPLL0_DIV_CLK_SRC] = &gcc_gpu_gpll0_div_clk_src.clkr,
 	[GCC_GPU_MEMNOC_GFX_CLK] = &gcc_gpu_memnoc_gfx_clk.clkr,
@@ -3739,7 +3652,6 @@ static struct clk_regmap *gcc_sm6375_clocks[] = {
 	[GCC_SDCC2_AHB_CLK] = &gcc_sdcc2_ahb_clk.clkr,
 	[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
 	[GCC_SDCC2_APPS_CLK_SRC] = &gcc_sdcc2_apps_clk_src.clkr,
-	[GCC_SYS_NOC_CPUSS_AHB_CLK] = &gcc_sys_noc_cpuss_ahb_clk.clkr,
 	[GCC_SYS_NOC_UFS_PHY_AXI_CLK] = &gcc_sys_noc_ufs_phy_axi_clk.clkr,
 	[GCC_SYS_NOC_USB3_PRIM_AXI_CLK] = &gcc_sys_noc_usb3_prim_axi_clk.clkr,
 	[GCC_UFS_PHY_AHB_CLK] = &gcc_ufs_phy_ahb_clk.clkr,
@@ -3766,7 +3678,6 @@ static struct clk_regmap *gcc_sm6375_clocks[] = {
 	[GCC_VCODEC0_AXI_CLK] = &gcc_vcodec0_axi_clk.clkr,
 	[GCC_VENUS_AHB_CLK] = &gcc_venus_ahb_clk.clkr,
 	[GCC_VENUS_CTL_AXI_CLK] = &gcc_venus_ctl_axi_clk.clkr,
-	[GCC_VIDEO_AHB_CLK] = &gcc_video_ahb_clk.clkr,
 	[GCC_VIDEO_AXI0_CLK] = &gcc_video_axi0_clk.clkr,
 	[GCC_VIDEO_THROTTLE_CORE_CLK] = &gcc_video_throttle_core_clk.clkr,
 	[GCC_VIDEO_VCODEC0_SYS_CLK] = &gcc_video_vcodec0_sys_clk.clkr,
@@ -3886,6 +3797,11 @@ static int gcc_sm6375_probe(struct platform_device *pdev)
 	qcom_branch_set_clk_en(regmap, 0x17028); /* GCC_CAMERA_XO_CLK */
 	qcom_branch_set_clk_en(regmap, 0x2b004); /* GCC_CPUSS_GNOC_CLK */
 	qcom_branch_set_clk_en(regmap, 0x1702c); /* GCC_DISP_XO_CLK */
+	qcom_branch_set_clk_en(regmap, 0x17008); /* GCC_CAMERA_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x1700c); /* GCC_DISP_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x36004); /* GCC_GPU_CFG_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x79004); /* GCC_SYS_NOC_CPUSS_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x17004); /* GCC_VIDEO_AHB_CLK */
 
 	clk_lucid_pll_configure(&gpll10, regmap, &gpll10_config);
 	clk_lucid_pll_configure(&gpll11, regmap, &gpll11_config);

-- 
2.43.0


