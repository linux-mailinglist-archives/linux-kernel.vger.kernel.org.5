Return-Path: <linux-kernel+bounces-6178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A32D6819574
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4368C1F264A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7C515AF8;
	Wed, 20 Dec 2023 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pOh7AODM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3846812E48
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e3901c2e2so3500308e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703032268; x=1703637068; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfCS7EJc5WZz01BXUAh+J5+ayBuQvlNbLl5dADuNIr0=;
        b=pOh7AODMGoY42p0RN24IMurN0jDQCW+zcaLxrf8IMsQ0C4GuhEWbab2wFeW7rJjWnH
         IX0y4wwrifQ8bk6flhwf3g1W90lvOKV52XVbhdGZdbwZMpqCMit4uot6m8167iuR031d
         aEozp/thYAF8Jfs+IQkLoalB1dehgs9/WE8q8FixP++yjktPN4uoYgx4+0yaOc5KIOSf
         cQzUHECIRmm08jNSayPbOKlvNUnSNPaaF5zKzT34OamHst0UanQ8b5ce2jkXIfw43npl
         LD2ok+qWVDZppG4sdwNmR2mabn/BBJB+Ve9RmH6yleyJ5ydHlkiqtO0PQjoFc/pJCDy7
         oFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703032268; x=1703637068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfCS7EJc5WZz01BXUAh+J5+ayBuQvlNbLl5dADuNIr0=;
        b=o8o9iR0AFbltE2SDAFF3nWXnm6I40eUS9WQgRrMCMlgFNHRCCPopUTzHTS6elakii4
         XYzzOvePNP78jC7Pj+2CLPtndmLEh45aNkGFSdC69ImmwjWqjtb4koAPXhjCyz79gIpj
         ABKohYhzfnQupApPQke7FeACpcGmJz61wc25b1ZANkuu7rWTwXp/fl3oREKyZG9dEVFj
         FBlyShDxolka7yhuIHmlHv7djMz7SQQS5rhfE6kwark60PC095KLMJbdVvNKU1MulFEB
         4qEao0cBHDt5Po0VUoc69uD3Ias2zSD+fglHN6rutNGhoYP/K4nWGVkmglr0Me7yv5+Z
         QLFQ==
X-Gm-Message-State: AOJu0YyzPnCXJoh5nnaLEtgRyhard0NDrtB0C4tXBd0uNRFPuFaZHCtH
	dVh2Mrvdye3Gbr6HZhKnJAW4aA==
X-Google-Smtp-Source: AGHT+IHXC6FMovvxJBXiv8yrpTzXVwJqDNlBO+ts8BrJKkAQlRIspcW8EP8tipoL2uIvAg0KM21e7Q==
X-Received: by 2002:a05:6512:b1e:b0:50e:357b:9917 with SMTP id w30-20020a0565120b1e00b0050e357b9917mr2662783lfu.106.1703032268260;
        Tue, 19 Dec 2023 16:31:08 -0800 (PST)
Received: from [10.167.154.1] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id k16-20020a056402049000b00552d03a17acsm4824397edv.61.2023.12.19.16.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 16:31:07 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 20 Dec 2023 01:30:50 +0100
Subject: [PATCH v3 09/15] clk: qcom: gcc-sm6115: Add runtime PM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-topic-branch_aon_cleanup-v3-9-3e31bce9c626@linaro.org>
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
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703032250; l=2112;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qGB7J3P0DJtbWo81wrMojy7eEnHmPOy4px200OELZEk=;
 b=Bb5Fj+0i6to7ZWc6udyT+Vs2btJJfq0/XcYI/9UOInkU0QDfwgSVlOq39MQ0o6ZrG3Py/cSKc
 yo7S4xA7oCoAO3o5K3VlpqNhFOOKbhxHuNcpIdgRecMqRKHHMNgz82K
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The GCC block on SM6115 is powered by the VDD_CX rail. We need to ensure
that CX is enabled to prevent unwanted power collapse and that the
reference is dropped when unused so that the system can enter a
firmware-managed lower power state.

Enable runtime PM to keep the power flowing only when necessary.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/clk/qcom/gcc-sm6115.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6115.c b/drivers/clk/qcom/gcc-sm6115.c
index 87a2bfe222a3..3e0a3fd09718 100644
--- a/drivers/clk/qcom/gcc-sm6115.c
+++ b/drivers/clk/qcom/gcc-sm6115.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 
@@ -3384,14 +3385,26 @@ static int gcc_sm6115_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int ret;
 
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret)
+		return ret;
+
 	regmap = qcom_cc_map(pdev, &gcc_sm6115_desc);
-	if (IS_ERR(regmap))
+	if (IS_ERR(regmap)) {
+		pm_runtime_put(&pdev->dev);
 		return PTR_ERR(regmap);
+	}
 
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
 			ARRAY_SIZE(gcc_dfs_clocks));
-	if (ret)
+	if (ret) {
+		pm_runtime_put(&pdev->dev);
 		return ret;
+	}
 
 	clk_alpha_pll_configure(&gpll8, regmap, &gpll8_config);
 	clk_alpha_pll_configure(&gpll9, regmap, &gpll9_config);
@@ -3406,7 +3419,10 @@ static int gcc_sm6115_probe(struct platform_device *pdev)
 	qcom_branch_set_clk_en(regmap, 0x36004); /* GCC_GPU_CFG_AHB_CLK */
 	qcom_branch_set_clk_en(regmap, 0x2b06c); /* GCC_SYS_NOC_CPUSS_AHB_CLK */
 
-	return qcom_cc_really_probe(pdev, &gcc_sm6115_desc, regmap);
+	ret = qcom_cc_really_probe(pdev, &gcc_sm6115_desc, regmap);
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
 }
 
 static struct platform_driver gcc_sm6115_driver = {

-- 
2.43.0


