Return-Path: <linux-kernel+bounces-15595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC441822E9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8FA2860C7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C981B296;
	Wed,  3 Jan 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DT5Upm+q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521E219BDE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5555f9061b9so6918457a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704289027; x=1704893827; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nZ/FgD+oGFs2Rc41jcok1cEWb2G/4+bAmbkMjU4FYc=;
        b=DT5Upm+q4fb03UtIN+T+SNVxdcnHJ+P0EXasNj7CBo7FelwyrH+V8Cpkzkf5GzdJnQ
         oBq7f+GDrjU/srQul+OUiR0SQ9dM0AhZiMIe2TPkyLtwFDt6cOTixAv1se8/MiXJPE1G
         xWwY/6QTE3R7bC52vhrjuqZl3LKCo+yOXMjMyumXvluRI1kMiBvz5b0vRFp+h6uXMahA
         ok/n14nf09KqqvEFrlt7O1H0JDmAkuuUafcIXLpwPZdNzavUYjOOKzsVEuChKrYcE4wY
         KcloXulLtvHhsgbLdNtkQifaPMYgo7Vpze+0tKKm0W+KjKve2jnfoHBoqQaaCHWt4/ET
         ittQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289027; x=1704893827;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nZ/FgD+oGFs2Rc41jcok1cEWb2G/4+bAmbkMjU4FYc=;
        b=kPMdi4QqjX4domgEqGJMBMAu5zPaw+xB97fBZ7KxIVyxRDseHGyrIvsrvQTT9MGgJA
         dnABcGVaZQUA7Qsfa5R3C1UzmG3e5dCL2vFIs0/Dl/i+CXRqpz7Pn3k3z3pujoCExdDV
         Gri0cA4RLBUesemfdz7Q1O1Rz02D89SpUQ26ucMDoVrHfgYGeVjYud4ppP55ffRseyRr
         TeSHYGVrGnI0IBTrzqQRRGzeuRC6Nt+WXH0zcyntk27nA3qTZ85NMkTijnX1S9xPrZhn
         Yi0ZJsmmZqehLKUvOOfHg7YGmvGu09fChmku/DeGF/yvZDjO7Amd0UAqmzw/6W7G+yIC
         5SYQ==
X-Gm-Message-State: AOJu0YwGXqNchwgloJBNvxnBbTSc1P6yUfpebvpahwiSli07QIk8jxFc
	3xLRmu5cw3xR4QuCeFMQsqNOyvFAHDC3tg==
X-Google-Smtp-Source: AGHT+IFCmlo3/fRMDs6alAryIWIgMCXX96y6EO1Hhto50Cylu50WTQZpRA7qOqWfLtuBhGEEI91lYg==
X-Received: by 2002:a17:906:749c:b0:a28:b830:fadb with SMTP id e28-20020a170906749c00b00a28b830fadbmr40327ejl.138.1704289027594;
        Wed, 03 Jan 2024 05:37:07 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id cl2-20020a170906c4c200b00a275637e699sm6474351ejb.166.2024.01.03.05.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:37:07 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 03 Jan 2024 14:36:03 +0100
Subject: [PATCH v5 05/12] clk: qcom: gpucc-sm6115: Unregister critical
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v5-5-99942e6bf1ba@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v5-0-99942e6bf1ba@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v5-0-99942e6bf1ba@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704289018; l=2984;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RdTke+2ukdWoXFZFASghqIHvc/0hMwv913x8iK/xxg0=;
 b=dXVz4LRN6Bw17VJpQ9OlKaq0pWQc2XGhDtXwPAqkQPsof0NdqZqmUkkKuu6wZ32HE09YtQGTq
 PKOxeZiDiGaAYdZBERGVoImw4O1fUZ/+I4n8mu+HP6dx1R1WxVNBDOb
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
 drivers/clk/qcom/gpucc-sm6115.c | 34 ++++------------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sm6115.c b/drivers/clk/qcom/gpucc-sm6115.c
index fb71c21c9a89..2c2c184747b1 100644
--- a/drivers/clk/qcom/gpucc-sm6115.c
+++ b/drivers/clk/qcom/gpucc-sm6115.c
@@ -234,20 +234,6 @@ static struct clk_rcg2 gpu_cc_gx_gfx3d_clk_src = {
 	},
 };
 
-static struct clk_branch gpu_cc_ahb_clk = {
-	.halt_reg = 0x1078,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x1078,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gpu_cc_ahb_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gpu_cc_crc_ahb_clk = {
 	.halt_reg = 0x107c,
 	.halt_check = BRANCH_HALT_DELAY,
@@ -336,20 +322,6 @@ static struct clk_branch gpu_cc_cxo_clk = {
 	},
 };
 
-static struct clk_branch gpu_cc_gx_cxo_clk = {
-	.halt_reg = 0x1060,
-	.halt_check = BRANCH_HALT_DELAY,
-	.clkr = {
-		.enable_reg = 0x1060,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gpu_cc_gx_cxo_clk",
-			.flags = CLK_IS_CRITICAL,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gpu_cc_gx_gfx3d_clk = {
 	.halt_reg = 0x1054,
 	.halt_check = BRANCH_HALT_SKIP,
@@ -418,7 +390,6 @@ static struct gdsc gpu_gx_gdsc = {
 };
 
 static struct clk_regmap *gpu_cc_sm6115_clocks[] = {
-	[GPU_CC_AHB_CLK] = &gpu_cc_ahb_clk.clkr,
 	[GPU_CC_CRC_AHB_CLK] = &gpu_cc_crc_ahb_clk.clkr,
 	[GPU_CC_CX_GFX3D_CLK] = &gpu_cc_cx_gfx3d_clk.clkr,
 	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
@@ -426,7 +397,6 @@ static struct clk_regmap *gpu_cc_sm6115_clocks[] = {
 	[GPU_CC_CXO_AON_CLK] = &gpu_cc_cxo_aon_clk.clkr,
 	[GPU_CC_CXO_CLK] = &gpu_cc_cxo_clk.clkr,
 	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
-	[GPU_CC_GX_CXO_CLK] = &gpu_cc_gx_cxo_clk.clkr,
 	[GPU_CC_GX_GFX3D_CLK] = &gpu_cc_gx_gfx3d_clk.clkr,
 	[GPU_CC_GX_GFX3D_CLK_SRC] = &gpu_cc_gx_gfx3d_clk_src.clkr,
 	[GPU_CC_PLL0] = &gpu_cc_pll0.clkr,
@@ -488,6 +458,10 @@ static int gpu_cc_sm6115_probe(struct platform_device *pdev)
 	qcom_branch_set_force_mem_core(regmap, gpu_cc_gx_gfx3d_clk, true);
 	qcom_branch_set_force_periph_on(regmap, gpu_cc_gx_gfx3d_clk, true);
 
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x1078); /* GPU_CC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x1060); /* GPU_CC_GX_CXO_CLK */
+
 	return qcom_cc_really_probe(pdev, &gpu_cc_sm6115_desc, regmap);
 }
 

-- 
2.43.0


