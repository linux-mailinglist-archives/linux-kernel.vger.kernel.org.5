Return-Path: <linux-kernel+bounces-25303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F6282CD30
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0714A283C54
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E065F6ADE;
	Sat, 13 Jan 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5HzG03Y"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716815673
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 14:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e68d0dbf9so12771045e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 06:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705157465; x=1705762265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nZ/FgD+oGFs2Rc41jcok1cEWb2G/4+bAmbkMjU4FYc=;
        b=Q5HzG03YwMZQK+4GAQ/s0b+3LjbztUi+Ts/hJc9SQwCiWMfo1K9k7zOR9t9vIbut4a
         XG9PHz7bUKLqZ+0XE83Y8FoF99G9xgWsBSXgGQkKkStAEgKtHVBDCkMkSBuRe21/Aw/N
         dZIcO+8iBI8phKZRwh6mhNzz28s/ihJUhTexVManjM8cXx8I+AiMvMsixLPsCXwO9XWG
         HTTo1dXJYMmCqXVxueg2PZ0Z1RDHC89DaRo43C493MJYdchfPK0KfE93JzOtkc7kUFeT
         NFfO6qDI+PUD1aXXZHOcAr8nWlYLCXutIQ3NfT4qzSrh4XxbTqsMZsewLJN+irqZizUP
         AY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705157465; x=1705762265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nZ/FgD+oGFs2Rc41jcok1cEWb2G/4+bAmbkMjU4FYc=;
        b=QYLTsRSwDVdpVoheOUm3ioF+2JLvJIyCP0w1MaYEOfSzSjyHPR3zCfNJ7uJiIZUrLh
         iGQzp+r7ebYGMBSJrggqFtWiPf692d3AsHvBX3GrdG0fsB5c4624QHGeJJ5SvWfDG0zT
         El8tlwSntFPJm5NN9qLRQjkmTNVW8JtJw3Xewah5sWnFmr/6TJU7CuCkrBoadg7Yy52d
         j1WPWDph4jnWm+0XmHKSX70RbVKfnmA3VzVR+3k5l7R9Rbt/1OerX9NcEtbqILOjIjpT
         WI3OYBtjDqw8GGB9ERabHv6ifdebueoKPcFi149X0BPEYHwkzIYOoP7o10p75BNUxg+8
         0CyA==
X-Gm-Message-State: AOJu0YxIYrF922fLQufE8la8R3b3Z7rLipzSZPA5fRxMSkc7H7sybnuY
	HOUHOQ+vqphULFrmUw2J+8/7B3nDYqmUCYmSOcRnDhKmYI8=
X-Google-Smtp-Source: AGHT+IEA6DCY4L1xNDTZlOoVuqnSU+jZNst7pJoihff872lYIf+doPhxu4LpEa7NyTBn0InszQw/dQ==
X-Received: by 2002:a05:600c:198d:b0:40e:6efe:acc5 with SMTP id t13-20020a05600c198d00b0040e6efeacc5mr180894wmq.162.1705157465391;
        Sat, 13 Jan 2024 06:51:05 -0800 (PST)
Received: from [10.167.154.1] (178235179017.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.17])
        by smtp.gmail.com with ESMTPSA id es18-20020a056402381200b00554b1d1a934sm3014593edb.27.2024.01.13.06.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 06:51:05 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 13 Jan 2024 15:50:54 +0100
Subject: [PATCH v6 05/12] clk: qcom: gpucc-sm6115: Unregister critical
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v6-5-46d136a4e8d0@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705157455; l=2984;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=RdTke+2ukdWoXFZFASghqIHvc/0hMwv913x8iK/xxg0=;
 b=zj3qdXjPhLJXgD1SWGjFwy2rux5JtRFdv4CJUYJqqNPZAxjLsgsEUZg6KlioVyPc8TyGPr/u7
 VlPTlZyhYk8BknWVbSPB7CF5zdznxV2g4TIRXwlFKpF75wbwoxl5h3a
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


