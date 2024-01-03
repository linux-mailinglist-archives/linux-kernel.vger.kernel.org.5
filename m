Return-Path: <linux-kernel+bounces-15596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BDD822E9B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27992856F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3951BDED;
	Wed,  3 Jan 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDQLzVAv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C161B29A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-556cd81163fso615658a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704289029; x=1704893829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04GA/gYikhVm70mp04BE89vJbyB+HCgNcamoEcplm6o=;
        b=MDQLzVAvbHFQdNCFz1L7tuuslY0vfAbjeAqMx1ux/E07ieqegX3aX/KiyXEbSdiVc4
         1n37A9ielzv2JaxluXcR+QVovJTkQsIceQoSPuEi8CeyfQGRZQmY0rNcuOY61GHbCxnO
         cl+we3mbQ9I0RFfiONWDDouqyV135Fj1AmSbfBtpDmKJXrcy/LLdB3RjP+xqypjWMvUA
         vJ5GQX0ziMcXZloc6PJsKc/B5EmOyUa+PSWHP244++7EQbPzfQapMCwub4dA72QR8Hps
         XsAE7gVs7T5VKCGhb+Xl8aG+mj/7EQlhQ//6kW9sFfyfQkGE7rcYWwOng11pGCLhw8bq
         FkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289029; x=1704893829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04GA/gYikhVm70mp04BE89vJbyB+HCgNcamoEcplm6o=;
        b=ifv+nvkluRUfKBJOlrwQ0r5R2g+sXpzSUn/QXWtuB2fQX7qsCq5pjo7hPuRrGnxeFd
         MWfdlFKB9fY4nWI3pIkYfKScRy39a8nQox0N8es2f2CYkhLqtUMlOnuSZRwec070alBc
         Jf8w2o+KLeD5UaX4c4K+DMWHLwNtcW+Z5Et2rJXreA0B3BuL4N64bWb7c5fNz8SfDEJA
         IfZUkTaAJWc2sFm/i+Qmvp3qcOcUCzrpd77L8U3uVGevu9AHNkj9s387ZVaYuye9PdzD
         fBY6c2A8F4E51CPhvhmO/x2ADZIYyxCe57MUZecGja7y3cEwmVvfc80IgY524ii0f2Ge
         ewXA==
X-Gm-Message-State: AOJu0Yy+96NVYYq2E+M1l0L27jW+8FP9ipeluH+Lr0UfKqGeZTQg9+ej
	SxIc8RfKBBzXs9Ofg8I7C9MdbjFtwpdJ6g==
X-Google-Smtp-Source: AGHT+IFV0w31rqoLt9vSqzh0T6ScG8iYjN75jF53jvf4lVP/qavgZouRKDWwmFjf6Ct7fztt3EZKvQ==
X-Received: by 2002:a17:906:ca92:b0:a27:cfe3:f8a2 with SMTP id js18-20020a170906ca9200b00a27cfe3f8a2mr1397262ejb.10.1704289029005;
        Wed, 03 Jan 2024 05:37:09 -0800 (PST)
Received: from [10.167.154.1] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id cl2-20020a170906c4c200b00a275637e699sm6474351ejb.166.2024.01.03.05.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:37:08 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 03 Jan 2024 14:36:04 +0100
Subject: [PATCH v5 06/12] clk: qcom: gpucc-sm6115: Add runtime PM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v5-6-99942e6bf1ba@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704289018; l=1935;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=alZr67bLnwqb3yV+3Ojldc2X/6n9g3vN6yGz8GMYLR4=;
 b=VY7iX087OYTjgUsb+T75Ntm60WeEZ1+WIw8ho4GUgfty/ZLYMyBtOaINhNMPFhEuD4ZGYVP3a
 TVoTNQ7Z4GyBx10tIKAJXiQHwDRSDs6YBPV/Y6x3T7mc2nRrjlDVpFR
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The GPU_CC block on SM6115 is powered by the VDD_CX rail. We only need
to cast an enable vote for it if the GPU blocks are in use.

Enable runtime PM to keep the power flowing only when necessary.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gpucc-sm6115.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sm6115.c b/drivers/clk/qcom/gpucc-sm6115.c
index 2c2c184747b1..15cf5d63c9ad 100644
--- a/drivers/clk/qcom/gpucc-sm6115.c
+++ b/drivers/clk/qcom/gpucc-sm6115.c
@@ -8,6 +8,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,sm6115-gpucc.h>
@@ -443,10 +444,21 @@ MODULE_DEVICE_TABLE(of, gpu_cc_sm6115_match_table);
 static int gpu_cc_sm6115_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
+	int ret;
+
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
 
 	regmap = qcom_cc_map(pdev, &gpu_cc_sm6115_desc);
-	if (IS_ERR(regmap))
+	if (IS_ERR(regmap)) {
+		pm_runtime_put(&pdev->dev);
 		return PTR_ERR(regmap);
+	}
 
 	clk_alpha_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
 	clk_alpha_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
@@ -462,7 +474,10 @@ static int gpu_cc_sm6115_probe(struct platform_device *pdev)
 	qcom_branch_set_clk_en(regmap, 0x1078); /* GPU_CC_AHB_CLK */
 	qcom_branch_set_clk_en(regmap, 0x1060); /* GPU_CC_GX_CXO_CLK */
 
-	return qcom_cc_really_probe(pdev, &gpu_cc_sm6115_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &gpu_cc_sm6115_desc, regmap);
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
 }
 
 static struct platform_driver gpu_cc_sm6115_driver = {

-- 
2.43.0


