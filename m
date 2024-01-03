Return-Path: <linux-kernel+bounces-15594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C7822E93
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDF31C227D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1B91B278;
	Wed,  3 Jan 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PeVT9nCL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C391A5BE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-556ea884968so19318a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704289026; x=1704893826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yq1JGC68uTd3cPMS7VFU/4ZnPLni1wHoKXEP4mEYH+A=;
        b=PeVT9nCLH1khJbkYP+c+CYw5YfvNtBu0iEfoEnuXCAoVKrscSHWbPXStIoOF8rWrUJ
         VIOct8cMRpgFcA8yiS4oK5Cqbl0kkHk4utulCgEoUH2FjQloW4vUfIE47/IR+ph3RTtK
         1it3nEkt4PVHgkZ56wvaJJes7rNaV7Xd7tAU1G3GPT/vHqv1R8NBTZMGfZcJWsE8xK5h
         YybT5lFNQPI6YYSGlGEIGFZv4ahUAHoTqhAzNHNPZJmI7sCMHctRxm4+6ouPUPJJAGfm
         JcxLxFZrogOatrWZQckQtwuTLRVGqEyhS8Fl9LtEcUdCpaM68ar7v3wkBGP3cgrFzJg4
         56Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289026; x=1704893826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yq1JGC68uTd3cPMS7VFU/4ZnPLni1wHoKXEP4mEYH+A=;
        b=abcgXLMg+AwEcUECeH4pY75coA5Ew8lqkpqOci/B+Vr8z53rFr/J5zCNFGRgFR/h0+
         VVabbjGUBuQaBLfgAObpnNbSedc7/Pr0ww+jd0ZtyFDYF2fz3h74vMi+jd/QkkCtkzlv
         6Ittr3/C16RKBy+7I5xSFrMh2rxF9FNMQrgu+p71grzEHMSzAGUqqiNC5SxEh7DsgqVn
         bNJfPX/97bOVvxQ6ZSvE1Roj5y9ckpa+skOdDtp+4rVfJ/SVc8fpslOBeYyN+E5/5plu
         gu0/YRj1nPQq8YcJ9q+cQoemTtvyHWmRhZw1iXky9H/cilAeXKDobjfwQzE6rHnZMJU6
         spNA==
X-Gm-Message-State: AOJu0Yx5fa1+M46ugoGJn3F4TjSF/vd8yOEbwCa65GxFfdoLCiROcXje
	JrOnCLUSAM/1fID3ApvvwmlMYwSjI8SlPg==
X-Google-Smtp-Source: AGHT+IGZY+EXGbVD9tTFe7R1bRK9SLf68p64TnkgQFK8XUyK3z3eTgulvxsqwSqXe/3lBezuM2n3pQ==
X-Received: by 2002:a17:906:6952:b0:a28:a01:ee92 with SMTP id c18-20020a170906695200b00a280a01ee92mr2120619ejs.36.1704289025971;
        Wed, 03 Jan 2024 05:37:05 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id cl2-20020a170906c4c200b00a275637e699sm6474351ejb.166.2024.01.03.05.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:37:05 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 03 Jan 2024 14:36:02 +0100
Subject: [PATCH v5 04/12] clk: qcom: gpucc-sm6375: Unregister critical
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v5-4-99942e6bf1ba@linaro.org>
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
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704289018; l=3066;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GHhudpM9IAN/Lc38xFu1FTckBvfyQEfeLWFuAx9ceqc=;
 b=h//62tjk6Hx8GrQUJmei/DxNFmIbbfRVZKURbysVBxVyeHMJyfQFBjgjrNv2jR4Zg0Ug2KwY/
 eZnlvruiNbTD7Ra4hNdqgmrp+1yALlDuFEdWW+HcvIfV7iTYhMJW6F6
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
 drivers/clk/qcom/gpucc-sm6375.c | 34 ++++------------------------------
 1 file changed, 4 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sm6375.c b/drivers/clk/qcom/gpucc-sm6375.c
index da24276a018e..07ebe5e139d5 100644
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
@@ -455,6 +425,10 @@ static int gpucc_sm6375_probe(struct platform_device *pdev)
 	clk_lucid_pll_configure(&gpucc_pll0, regmap, &gpucc_pll0_config);
 	clk_lucid_pll_configure(&gpucc_pll1, regmap, &gpucc_pll1_config);
 
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x1078); /* GPUCC_AHB_CLK */
+	qcom_branch_set_clk_en(regmap, 0x1060); /* GPUCC_GX_CXO_CLK */
+
 	ret = qcom_cc_really_probe(pdev, &gpucc_sm6375_desc, regmap);
 	pm_runtime_put(&pdev->dev);
 

-- 
2.43.0


