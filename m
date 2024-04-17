Return-Path: <linux-kernel+bounces-149166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D528A8CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78991F22108
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F82D47F53;
	Wed, 17 Apr 2024 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDhNh59G"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2933D0BD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384431; cv=none; b=UEl50zPcmLJTQoI4bOtiqKBHH1X1h6O5PrDSEA1tK8e4CRV3qN5Zc29+XXOeP39gz990vPWaTJxmHRDxCsj2LjLuuF9BKVscyotHg6j/tCQbDGZJbvnbaMP83veGsq+8lrz8D3b29Zun9/jGEMso9V6E9gxjt7vW6K5GJaMnXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384431; c=relaxed/simple;
	bh=3mbMg2ivwWNTK3xsS4wYTiDYZ0KlaU3IbtBCWSlfYEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUm+8/vp3J7SgKW4TLBuGSZLkFsD3EtQJmIL02ctV0B4s+ZcAhgADeTbFPi6hkWbfdOwHlk8XdE74aLcNfjm35Sva/j96ZdSCitr5ADw+Rx5Lc55YkvUdrdz0QDcJtvTDt3QpPe0vbjIJEfOcJfrC17xpLzGf35tFBM9G7NqF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oDhNh59G; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5224dfa9adso30333066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713384428; x=1713989228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t9Kjw76bMPVOsbjzjb0d38GfEfCd3+VQVKqEmN50hoY=;
        b=oDhNh59G9haBJapsG7yKtWT+6abGBRxj6ibLg/dbbX5dngcNzjvMNoNCb2CyVs41D8
         cxaKO68doWsXy9Mr1jSms845vXpBXORnvkadhn420KbX0ihRh3+ohoh423RvWvDYEmzP
         MF3eIDxx6KJZ3J3AL95KysEjbceqxsqMPyOZz/pH4j35lumSi6aCk/FUmunhMrzG4AQU
         khJ62GAGcG9YQ0CNREz9IVTEhHECUj9q0xnsxqQmUg85R+Pm03DOXeFgPxbMrtFKX4Zc
         KSCztb7ATzqf7Kzek389Oq6GHZR+ijjFT8jTnfmVbZ6w6Y7zGXizfzkWzE44CUWCIOAi
         X7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713384428; x=1713989228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9Kjw76bMPVOsbjzjb0d38GfEfCd3+VQVKqEmN50hoY=;
        b=v5HmrAmM6tA9VZwfRxMubLxQgdd73DM5NJ3IgLXF5CnUNwe+d7Gx4Y1HWGnZ+bPEwf
         Eem/qzPcsdrxFJaCLCFpJ/pencSlvrGTAeX3c4iDRQcIS3AGizu5adiWzsZpUMOUYQq5
         8juBMUH7dgWtEzTCeVX6MTpgfvgYQ0T63Y+UPgRouPta6gy5KwmU5ybKDWiu9bHk5NZR
         v8LRPA13QXocAa8+NiGWRZs2QfwCi/KIqKSzWaxgxr8SQ8Q40GmFde3nE6H+L5R2RhSc
         2xQF93ECtGAJV1IcrfnFy+NbWZh8r71LNl4kQTT2imXZXW9rLLmRwcqEvja94fXBy52j
         S6VA==
X-Forwarded-Encrypted: i=1; AJvYcCWUgr3TGqElNy3eGuqh8vLU8IAAsHxAqmBwwSh1QP8ccQSjn1ugfSUBhgUH7Oc204mVuo12TbNOKZx7KYzVH/3I/T6hCwgysc0aj16m
X-Gm-Message-State: AOJu0YxvRzB8+/mqIteKDHo9kaXZ26HyglYbTE//iK8dEup+EG9T6Plv
	p27tFaJpS7M3jwSbmAkQRusZj0byjVxZiaoC7ZN06EJwKErhtQhET4DlhpAkcRo=
X-Google-Smtp-Source: AGHT+IF6lNe7FJxy2kYSpHWMMUEGZhhuFhiDyuheXUBZhHBVpx+1Ckk0HCLalQKp09AtJ/CUpiDCaw==
X-Received: by 2002:a17:906:c812:b0:a52:a25:2077 with SMTP id cx18-20020a170906c81200b00a520a252077mr148120ejb.14.1713384427698;
        Wed, 17 Apr 2024 13:07:07 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090615c100b00a524e3f2f9esm6128057ejd.98.2024.04.17.13.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 13:07:06 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 17 Apr 2024 22:07:00 +0200
Subject: [PATCH 2/2] iommu/qcom: Always consume all clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-topic-qcom_iommu-v1-2-fabe55b3b7b3@linaro.org>
References: <20240416-topic-qcom_iommu-v1-0-fabe55b3b7b3@linaro.org>
In-Reply-To: <20240416-topic-qcom_iommu-v1-0-fabe55b3b7b3@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713384421; l=3042;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3mbMg2ivwWNTK3xsS4wYTiDYZ0KlaU3IbtBCWSlfYEw=;
 b=vMKT1TBfwDN6a7yS7Xa9gR7+R8/09NZEgAT7cVeFCam7yhXFkvI+O3+YWOJ91TNYJjTsArd92
 T3eW7mR8qIWCZp6oPYrDTvlNFLA5FPFMjMh/2H2oX1NZ647vny1akj5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some platforms provide more clocks than others, we already have the DT
schema to ensure sanity here plus these clocks simply need to be on.

Use devm_clk_bulk_get_all and get rid of some boilerplate.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 38 +++++++--------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 3dca9293c509..ace69030a422 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -34,13 +34,6 @@
 
 #define SMMU_INTR_SEL_NS     0x2000
 
-enum qcom_iommu_clk {
-	CLK_IFACE,
-	CLK_BUS,
-	CLK_TBU,
-	CLK_NUM,
-};
-
 struct qcom_iommu_ctx {
 	struct device		*dev;
 	void __iomem		*base;
@@ -54,7 +47,8 @@ struct qcom_iommu_dev {
 	/* IOMMU core code handle */
 	struct iommu_device	 iommu;
 	struct device		*dev;
-	struct clk_bulk_data clks[CLK_NUM];
+	struct clk_bulk_data	*clks;
+	int			num_clks;
 	void __iomem		*local_base;
 	u32			 sec_id;
 	u8			 max_asid;
@@ -781,7 +775,6 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 	struct qcom_iommu_dev *qcom_iommu;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
-	struct clk *clk;
 	int ret, max_asid = 0;
 
 	/* find the max asid (which is 1:1 to ctx bank idx), so we know how
@@ -804,26 +797,11 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 			return PTR_ERR(qcom_iommu->local_base);
 	}
 
-	clk = devm_clk_get(dev, "iface");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "failed to get iface clock\n");
-		return PTR_ERR(clk);
-	}
-	qcom_iommu->clks[CLK_IFACE].clk = clk;
-
-	clk = devm_clk_get(dev, "bus");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "failed to get bus clock\n");
-		return PTR_ERR(clk);
-	}
-	qcom_iommu->clks[CLK_BUS].clk = clk;
+	ret = devm_clk_bulk_get_all(dev, &qcom_iommu->clks);
+	if (ret <= 0)
+		return dev_err_probe(dev, ret, "Couldn't get clocks\n");
 
-	clk = devm_clk_get_optional(dev, "tbu");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "failed to get tbu clock\n");
-		return PTR_ERR(clk);
-	}
-	qcom_iommu->clks[CLK_TBU].clk = clk;
+	qcom_iommu->num_clks = ret;
 
 	if (of_property_read_u32(dev->of_node, "qcom,iommu-secure-id",
 				 &qcom_iommu->sec_id)) {
@@ -891,7 +869,7 @@ static int __maybe_unused qcom_iommu_resume(struct device *dev)
 	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_bulk_prepare_enable(CLK_NUM, qcom_iommu->clks);
+	ret = clk_bulk_prepare_enable(qcom_iommu->num_clks, qcom_iommu->clks);
 	if (ret < 0)
 		return ret;
 
@@ -905,7 +883,7 @@ static int __maybe_unused qcom_iommu_suspend(struct device *dev)
 {
 	struct qcom_iommu_dev *qcom_iommu = dev_get_drvdata(dev);
 
-	clk_bulk_disable_unprepare(CLK_NUM, qcom_iommu->clks);
+	clk_bulk_disable_unprepare(qcom_iommu->num_clks, qcom_iommu->clks);
 
 	return 0;
 }

-- 
2.44.0


