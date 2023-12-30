Return-Path: <linux-kernel+bounces-13425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCC982066C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 14:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789DB1F21B2F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1895CCA73;
	Sat, 30 Dec 2023 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhynUyFS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EC2BA31
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-555f581aed9so459676a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 05:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703941474; x=1704546274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v976SmXxRiZAGe8x+4gqFafbRMwHJbbnvfO+A1vZOV4=;
        b=VhynUyFSj3yDmBcJo8tKbMGYqVRCjAXPIw3kNtVt10HWzc/BnZGA3JHtMFmorrSCR6
         GkzH2b5cC02j13b2bLm2bXYNnnSoiEMiyIF8yxfbCZpuUaEi4Wvoy23bppOKPy88+l0g
         sVT78mwH3xWWpURyuKFbOPRcCU4hVo/1R9EFMIc7HK2crh7AKK0QN0hNvy0TGLft07iE
         TSUB+VDfjuuVSwo5jXNBa9iWvIKgIqAEXtACbMlm6b8axO0IXfTkjzKXF6INTKUM28YO
         47f5yh4kPUElAU4rrKBA99BxbCJUwxrOVaDJZjW+E3MtV7UNmc46m5ek52DVe+nPrjrL
         ExWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703941474; x=1704546274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v976SmXxRiZAGe8x+4gqFafbRMwHJbbnvfO+A1vZOV4=;
        b=J0qWJwEENIG3VBzING2qt4h7407JTZxMKtMvBR8aWKZPj5WUpUR6fygeu1tJcx1li8
         wwHnAzwVUQPn0zx3n+p25tu9rzVwWVIsOJAfu2KJ7cMYmbrYikS4nXkvKAPwRDx+TmHD
         N8axC6LgEM0EX5rbowQNYLim5G8ZDMXGpnrbDF6erkvwzWZOdHTJJt7nYuCFtx3INF60
         GpaICn0swJqID/WIwHPmAlY04Ww1X4pYnkqIjxv7lzpUWeoeJXr/8dv9vZLnN8tjLN5p
         VPv+8ukE1eyYoD0r7+Es6lQXSmPa1ZVH2VDCdvyPGzZtQXWRtyMQ/voc3WnVt94Ij/8z
         cHzA==
X-Gm-Message-State: AOJu0YwfW1nVc2wOw5EWh2RQGcWuSu4wGd9cMHNW73Mi3tJTnVy4wHmu
	nQjL8V/sb112iORD0iP0g67FFGjbIY8FSN8e/ejGFZztTKs=
X-Google-Smtp-Source: AGHT+IFNj7bQ30a4/ajSEWu7qLYQ+AJhXfuMEz8HDO1aHoafOB7lYhzYPpbB3EuGS45u66sXO1XqZQ==
X-Received: by 2002:a50:9357:0:b0:554:71a6:2133 with SMTP id n23-20020a509357000000b0055471a62133mr7726960eda.40.1703941473726;
        Sat, 30 Dec 2023 05:04:33 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id ij14-20020a056402158e00b00554368c9ce8sm11359578edb.1.2023.12.30.05.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 05:04:33 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 30 Dec 2023 14:04:06 +0100
Subject: [PATCH v4 04/12] clk: qcom: gpucc-sm6375: Unregister critical
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v4-4-32c293ded915@linaro.org>
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
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703941465; l=3028;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fXRoqdRlJHc5Qzabc5UfVEq2iMwhjOiaxUJ84TrgGsw=;
 b=vq0CGg04byY51x8KXl6tKrZv3/dNVlS9kAnwvRUtq6WonwDpwEjwI9rGvQ+OJK1BcNft9wsj+
 80LfujP6G3fDvynQrbVSd+H+QBaAgVY/UeXKYLdrT72DHqjQczMNUkL
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


