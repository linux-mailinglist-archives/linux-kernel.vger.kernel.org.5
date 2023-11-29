Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1743A7FDFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjK2S7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjK2S7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:59:37 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C991703
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:59:39 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9c5d30b32so1696171fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 10:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701284377; x=1701889177; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXMNH6TrR/7XnpjC35h5hcRSBIQq27ZTZGmPCePhaF4=;
        b=ceEZuJGRHjSJEEn2XThBuYRMXJhfXO8ZHHnRI+lYhiuwr3N4vCFV02KyeoV5BDfj2/
         IQYU6js95/NL321CKrIhIK+wCtVCoFI/IaZJVo7m2S5X0GK+xjUZh2sRWFHBhesZXwNy
         D8GbUWBO89qBBpFwkYL5Do4SrtrQyI+x/MKxexj55zl2ej/gQ+vO2OtYyqJa1DYJmJY6
         Dl3z8s179GyE6sANiRgQyFWYaILGhd4iCdgk8RoTwwLjxkbuil1c/uxrwyvO2WG0DRYd
         /WgpsKcEL0hdOjhIEv5Xsx+QCMxuearTdipvkMPMFGp9axlvkXc9i9HlnMpIoGSbZ4O8
         zg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701284377; x=1701889177;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXMNH6TrR/7XnpjC35h5hcRSBIQq27ZTZGmPCePhaF4=;
        b=Ki/au2J9jgO0MvYn/tgnPYTbugX6pg32oYh1yTh0iK0J9sPCs4mFj/GByfxcacCQZr
         avBkrKXAzFP/hnrbaBRvjb/J/xsjlPiKVBNyhR3rx0kO9rf5rYXXbKtRyl2e8SGpo3Lt
         DRyHbOTkOXNkwLeMaltiOHBrwyTd+a+HuddmnA4gddlHpGBwp5IFrTx6LYcWlYis31Dj
         oRdBQKVkBQzrioRF/jduT+obWNxh3KTV0GF17SAS152d54iVMpt8/kW1WgtqjI2juCEm
         zcBwC8W+Liaub8FoGkXASwKHOS15IESUybR+ifzpEiM9Kx1NR6V28ABQlN/QL2Qnhn0/
         /7dA==
X-Gm-Message-State: AOJu0Yxn9n5A1Hx4TKKrMVM2gSABv303zwbXrjvTNUwZXwEztWSJkAfV
        C8yYF+STg2wbHNiX8Q4pNZqbk6lWeVKaVIyAois=
X-Google-Smtp-Source: AGHT+IFNL3CM1j+VFhLk7jRZhqJVTMlPCIKdqhUjhzr31aTHAPGZYyplS/2f5U9wFwtpF7JP++AWtQ==
X-Received: by 2002:a2e:9b59:0:b0:2c6:ece6:5b65 with SMTP id o25-20020a2e9b59000000b002c6ece65b65mr12502580ljj.10.1701284377331;
        Wed, 29 Nov 2023 10:59:37 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id o11-20020a1709061d4b00b009faca59cf38sm8160232ejh.182.2023.11.29.10.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:59:36 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Nov 2023 19:59:24 +0100
Subject: [PATCH v2 05/15] clk: qcom: gpucc-sm6375: Unregister critical
 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v2-5-2a583460ef26@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701284367; l=2968;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=LUWIogmP6OeDvx1GjND0Am0UQ+6einhHWh1HpqaW4UI=;
 b=yQzFMJrhML7Y5IYoegSAF6IeVpUCzfIPsfrVm05xdBsTdVnFLOOzF1l8znsi7qjH8Xpj6+xGI
 YKvvl6fJ0RtAyEzXytX9eeGB375rfVMq5z4XGKhvIB6SxO6ELJcSaNB
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

