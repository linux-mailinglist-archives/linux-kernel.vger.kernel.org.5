Return-Path: <linux-kernel+bounces-6174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101CE819565
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773161F26162
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303C2BE64;
	Wed, 20 Dec 2023 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BSGqCX4R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60E567C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-54cd2281ccbso6195278a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703032261; x=1703637061; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v976SmXxRiZAGe8x+4gqFafbRMwHJbbnvfO+A1vZOV4=;
        b=BSGqCX4R61NhDKiPiYWISHxAbdNWsr7j5o/2LgoCwoAV9w1AvMgEnVMgBmGbgS9Uxw
         P4USeUEAqVE/obOTfloqATI7o2GrM5esnoFb/V6cRSsIBTFPYQs2vcxIMjIgdQaHUMd3
         LUwwQ0E5x69uuRlbmKI1VDSW2u7O6mURseeKUG08Hfby4AdJsHOGk5mG6F9bPt9Om4zt
         LCb5AvkwAf0pnBN1d4uGCaGeJKwDVqncmMg0cy9jpdQEarll1AKyIPtaR7MFFQy4aqB2
         2iMeuExxFyy82kXTo3/wB8sLmRsPNOxA7bdQG2h+M/AYzAEyLRITVVtvjtzDCTxERp9u
         9nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703032261; x=1703637061;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v976SmXxRiZAGe8x+4gqFafbRMwHJbbnvfO+A1vZOV4=;
        b=hx3aCyO4Ya8NQ6jzKA7Sk2qyk2w5JfQs0amSI+ZdN1W8T8YpaqWWXl5iX5DlkzYXL1
         BMwnbU8P2YbnLHpLvXoHNx3VAuvL2gZLRpbIpmaR3XqyPX0D3uL2/19OLGnACNs7ClXC
         cMcpHt85G2x4pxyrDiyp+Z2GxRxbR66dPxA/6YVrA/U7Cz8BPhbuU/e9hvyrDKifsSek
         cSvE18rNAMOsJ3vjrbxB0vn0+D9d51bKROIYAawzqXwFEhlE9UGOLujJz9P23sGFdEj2
         AkwKKE9F6GRm64EO5izquDV9Hv383c93s+uzviZ2EFn+/fP6giUZLKWn2ANNWzDtvS54
         fPAw==
X-Gm-Message-State: AOJu0Yzs+x19Loj6lUPWj0wp6OiXWsfwSYd2Iq8DhkT0PC6enbt4tylp
	YzrHsJvOOJyQ7OXRiu4KSL3I9Q==
X-Google-Smtp-Source: AGHT+IEgCwWdv7WulwvVUT1+TcVv5u8WKJK63fTV/w5qKC3D87Wf+Jsrl9mBjB+9DF2N0Bwvj/AyzQ==
X-Received: by 2002:a50:d7c1:0:b0:553:6195:b866 with SMTP id m1-20020a50d7c1000000b005536195b866mr1880176edj.66.1703032260989;
        Tue, 19 Dec 2023 16:31:00 -0800 (PST)
Received: from [10.167.154.1] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id k16-20020a056402049000b00552d03a17acsm4824397edv.61.2023.12.19.16.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 16:31:00 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 20 Dec 2023 01:30:46 +0100
Subject: [PATCH v3 05/15] clk: qcom: gpucc-sm6375: Unregister critical
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v3-5-3e31bce9c626@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v3-0-3e31bce9c626@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v3-0-3e31bce9c626@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703032250; l=3028;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fXRoqdRlJHc5Qzabc5UfVEq2iMwhjOiaxUJ84TrgGsw=;
 b=Mepc+kyD8ErB7ZogQGNmtUTVAoPSNFvg4MV4ZMzEdy8x1+AVJHQvX5wrEv9IPlnTUbaCxaKQd
 1Mq2WRj8a/TAmOUIj8Hmu/0GMNrLOgd8fFXvg7ZC/+mZCbIeiWIic0i
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some clocks need to be always-on, but we don't really do anything
with them, other than calling enable() once and telling Linux they're
enabled.

Unregister them to save a couple of bytes and, perhaps more
importantly, allow for runtime suspend of the clock controller device,
as CLK_IS_CRITICAL prevents the latter.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gpucc-sm6375.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sm6375.c b/drivers/clk/qcom/gpucc-sm6375.c
index da24276a018e..6d85936dd441 100644
--- a/drivers/clk/qcom/gpucc-sm6375.c
+++ b/drivers/clk/qcom/gpucc-sm6375.c
@@ -183,20 +183,6 @@ static struct clk_rcg2 gpucc_gx_gfx3d_clk_src = {
 	},
 };
 
-static struct clk_branch gpucc_ahb_clk = {
-	.halt_reg = 0x1078,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x1078,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gpucc_ahb_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gpucc_cx_gfx3d_clk = {
 	.halt_reg = 0x10a4,
 	.halt_check = BRANCH_HALT_DELAY,
@@ -294,20 +280,6 @@ static struct clk_branch gpucc_cxo_clk = {
 	},
 };
 
-static struct clk_branch gpucc_gx_cxo_clk = {
-	.halt_reg = 0x1060,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x1060,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gpucc_gx_cxo_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gpucc_gx_gfx3d_clk = {
 	.halt_reg = 0x1054,
 	.halt_check = BRANCH_HALT_DELAY,
@@ -381,7 +353,6 @@ static struct gdsc gpu_gx_gdsc = {
 };
 
 static struct clk_regmap *gpucc_sm6375_clocks[] = {
-	[GPU_CC_AHB_CLK] = &gpucc_ahb_clk.clkr,
 	[GPU_CC_CX_GFX3D_CLK] = &gpucc_cx_gfx3d_clk.clkr,
 	[GPU_CC_CX_GFX3D_SLV_CLK] = &gpucc_cx_gfx3d_slv_clk.clkr,
 	[GPU_CC_CX_GMU_CLK] = &gpucc_cx_gmu_clk.clkr,
@@ -389,7 +360,6 @@ static struct clk_regmap *gpucc_sm6375_clocks[] = {
 	[GPU_CC_CXO_AON_CLK] = &gpucc_cxo_aon_clk.clkr,
 	[GPU_CC_CXO_CLK] = &gpucc_cxo_clk.clkr,
 	[GPU_CC_GMU_CLK_SRC] = &gpucc_gmu_clk_src.clkr,
-	[GPU_CC_GX_CXO_CLK] = &gpucc_gx_cxo_clk.clkr,
 	[GPU_CC_GX_GFX3D_CLK] = &gpucc_gx_gfx3d_clk.clkr,
 	[GPU_CC_GX_GFX3D_CLK_SRC] = &gpucc_gx_gfx3d_clk_src.clkr,
 	[GPU_CC_GX_GMU_CLK] = &gpucc_gx_gmu_clk.clkr,
@@ -455,6 +425,9 @@ static int gpucc_sm6375_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&gpucc_pll0, regmap, &gpucc_pll0_config);
 	clk_lucid_pll_configure(&gpucc_pll1, regmap, &gpucc_pll1_config);
 
+	qcom_branch_set_clk_en(regmap, 0x1078); /* GPUCC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x1060); /* GPUCC_GX_CXO_CLK */
+
 	ret = qcom_cc_really_probe(pdev, &gpucc_sm6375_desc, regmap);
 	pm_runtime_put(&pdev->dev);
 

-- 
2.43.0


