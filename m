Return-Path: <linux-kernel+bounces-132666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AE389983E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE87B22288
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29451607A6;
	Fri,  5 Apr 2024 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gE8OTgcN"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983515F319
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306502; cv=none; b=MR9pBo1zEOrdesUtg4mlV1ekbBNTIymdPby2QtMDD3a/ON087HCZDUX71nffeqNEMJiQR074LkOtflKP4gUnDgTiG7Ogf7KNpxBQkZ82FayPobsMZpXnLgn/60SvEE1bukS8KpQOks6fpxxKdZ4eMneLKCh5DJpPKlHW5zkZwh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306502; c=relaxed/simple;
	bh=Ou8aZn8bQkVD/m5r7MVoDTV+g3hs5GCvF5tL5IVBhCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uKXX+Z9nidBUXwtOX6Zhh2MWYbPgswPqnmm86hRZ8fQASE6F4knVRDXNAvx4ShylBW/CRj7NhNcheLl67pVC6NowgC2HEXA0zZeNaqebqR7y2D8d9+BptK4j3tNMJrjnU9nFnBC9Rw7aPYAIHQjkJc6QgrWahTAyyoNn8+qwLU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gE8OTgcN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d85da5a7d1so10124901fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712306499; x=1712911299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrIDGJdQyN3Qs3kdMSMKwxSvCzhRkNvUk3FQRrR3UEA=;
        b=gE8OTgcNLErkuQ8y+kJbeTs94nxKrZ9pGlCQa93MwM+Syy+yX6RF6FneX4tmxSXzO5
         SayAPZXLlMdr9+lJf1Mje9YA8+MZl9FIAX1Miz/wqRP+tN4fXTEDjFnaoZF7pmpCF6vS
         wxgPqJFQuTqLqdpxBSaHU95EE/V57R8RmpN9HJEeAJpmM9T99myuxl2RFpMh5IdhMs2M
         9ja2ctoWFCNTmc0CDOK+FZ2vt93ZViFq7o4Z+9TN1Ug3JoD4+IroWXsw2qT/YDLC7are
         r9u/jVFB8FbEmGEWIm4a0iLi99PAQCLfWL6u1viFfgU2csMrNZJC+nal13zSQD/k+Rce
         jkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712306499; x=1712911299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrIDGJdQyN3Qs3kdMSMKwxSvCzhRkNvUk3FQRrR3UEA=;
        b=l/exwuSgD/9t4yM7gMaWof+0Q8fZLl7llnjuAGEr78QMyz1iyCXK5MSOyHK1Uyli9N
         JoHPf9dHU1xiefhIrpX8ZD68cefSnIIW7uM6QRVHnIreQYNln4l8su7LtiAwccOFyg+h
         ud7mYkuB05UcE3BrrCjRmPInnucj1cn1m4b/3Mei66MaCU9rt/kjQvd/3DsT9p3iN17Q
         2SGXH3Jrk3iOPaMm+4qdF+TMUDLAP6Au0YY5Z/KmrZz0VyRVGVs9uAGVyqoDnsr2NbY9
         KIHSnSNR7SdgUN4Jr9IfmmVv4AqYLMn7twzM9BIA0v/KLSQYpDOo1FW5lYlxVpMI1zgP
         0pDw==
X-Forwarded-Encrypted: i=1; AJvYcCWSZoPQKzGiHCNQSN1nC+i6AjP2i+LNDbx9G6cJKGEQ4KvoKkvoNT/KCqRM2rf0JbigOA2BrLAMO+y7IK5Vf3g9ewSkbnYZIuhgjOm4
X-Gm-Message-State: AOJu0YzHg9bpqyGvrByKpCaZb1eaTAExd2ithMghxx6YX6Lby6bJPrFf
	CJqkLl3XxvUz7+ZaLFd+msmhbuMgt9E2FA0g0IHCy1KIPE27uG+c2YCevix3cmw=
X-Google-Smtp-Source: AGHT+IFBziklUtc+FbW+7LRtWCnnN6zKDAY/PIgp9Ri894zGj6uc53DW8wEcUxIz/7mcsRZTdjd/7g==
X-Received: by 2002:a05:651c:1047:b0:2d6:fc27:2e9b with SMTP id x7-20020a05651c104700b002d6fc272e9bmr485092ljm.25.1712306499038;
        Fri, 05 Apr 2024 01:41:39 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-101.pol.akademiki.lublin.pl. [87.246.222.101])
        by smtp.gmail.com with ESMTPSA id y3-20020a05651c020300b002d429304a20sm116880ljn.8.2024.04.05.01.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 01:41:38 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 05 Apr 2024 10:41:32 +0200
Subject: [PATCH 4/6] drm/msm/adreno: Implement SMEM-based speed bin
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-smem_speedbin-v1-4-ce2b864251b1@linaro.org>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
In-Reply-To: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

On recent (SM8550+) Snapdragon platforms, the GPU speed bin data is
abstracted through SMEM, instead of being directly available in a fuse.

Add support for SMEM-based speed binning, which includes getting
"feature code" and "product code" from said source and parsing them
to form something that lets us match OPPs against.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  8 +++---
 drivers/gpu/drm/msm/adreno/adreno_device.c |  2 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 39 +++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    | 12 ++++++---
 4 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 4cbdfabbcee5..6776fd80f7a6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2890,13 +2890,15 @@ static u32 fuse_to_supp_hw(const struct adreno_info *info, u32 fuse)
 	return UINT_MAX;
 }
 
-static int a6xx_set_supported_hw(struct device *dev, const struct adreno_info *info)
+static int a6xx_set_supported_hw(struct adreno_gpu *adreno_gpu,
+				 struct device *dev,
+				 const struct adreno_info *info)
 {
 	u32 supp_hw;
 	u32 speedbin;
 	int ret;
 
-	ret = adreno_read_speedbin(dev, &speedbin);
+	ret = adreno_read_speedbin(adreno_gpu, dev, &speedbin);
 	/*
 	 * -ENOENT means that the platform doesn't support speedbin which is
 	 * fine
@@ -3056,7 +3058,7 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 
 	a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
 
-	ret = a6xx_set_supported_hw(&pdev->dev, config->info);
+	ret = a6xx_set_supported_hw(adreno_gpu, &pdev->dev, config->info);
 	if (ret) {
 		a6xx_destroy(&(a6xx_gpu->base.base));
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index c3703a51287b..901ef767e491 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -6,6 +6,8 @@
  * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
  */
 
+#include <linux/soc/qcom/socinfo.h>
+
 #include "adreno_gpu.h"
 
 bool hang_debug = false;
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 074fb498706f..0e4ff532ac3c 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -21,6 +21,9 @@
 #include "msm_gem.h"
 #include "msm_mmu.h"
 
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
+
 static u64 address_space_size = 0;
 MODULE_PARM_DESC(address_space_size, "Override for size of processes private GPU address space");
 module_param(address_space_size, ullong, 0600);
@@ -1057,9 +1060,37 @@ void adreno_gpu_ocmem_cleanup(struct adreno_ocmem *adreno_ocmem)
 			   adreno_ocmem->hdl);
 }
 
-int adreno_read_speedbin(struct device *dev, u32 *speedbin)
+int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
+			 struct device *dev, u32 *speedbin)
 {
-	return nvmem_cell_read_variable_le_u32(dev, "speed_bin", speedbin);
+	u32 fcode, pcode;
+	int ret;
+
+	/* Try reading the speedbin via a nvmem cell first */
+	ret = nvmem_cell_read_variable_le_u32(dev, "speed_bin", speedbin);
+	if (!ret && ret != -EINVAL)
+		return ret;
+
+	ret = qcom_smem_get_feature_code(&fcode);
+	if (ret) {
+		dev_err(dev, "Couldn't get feature code from SMEM!\n");
+		return ret;
+	}
+
+	ret = qcom_smem_get_product_code(&pcode);
+	if (ret) {
+		dev_err(dev, "Couldn't get product code from SMEM!\n");
+		return ret;
+	}
+
+	/* Don't consider fcode for external feature codes */
+	if (fcode <= SOCINFO_FC_EXT_RESERVE)
+		fcode = SOCINFO_FC_UNKNOWN;
+
+	*speedbin = FIELD_PREP(ADRENO_SKU_ID_PCODE, pcode) |
+		    FIELD_PREP(ADRENO_SKU_ID_FCODE, fcode);
+
+	return ret;
 }
 
 int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
@@ -1098,9 +1129,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 			devm_pm_opp_set_clkname(dev, "core");
 	}
 
-	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
+	if (adreno_read_speedbin(adreno_gpu, dev, &speedbin) || !speedbin)
 		speedbin = 0xffff;
-	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
+	adreno_gpu->speedbin = speedbin;
 
 	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
 			ADRENO_CHIPID_ARGS(config->chip_id));
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 460b399be37b..1770a9e20484 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -81,7 +81,12 @@ extern const struct adreno_reglist a612_hwcg[], a615_hwcg[], a630_hwcg[], a640_h
 extern const struct adreno_reglist a660_hwcg[], a690_hwcg[], a702_hwcg[], a730_hwcg[], a740_hwcg[];
 
 struct adreno_speedbin {
-	uint16_t fuse;
+	/* <= 16-bit for NVMEM fuses, 32b for SOCID values */
+	uint32_t fuse;
+#define ADRENO_SKU_ID_PCODE		GENMASK(31, 16)
+#define ADRENO_SKU_ID_FCODE		GENMASK(15, 0)
+#define ADRENO_SKU_ID(pcode, fcode)	(pcode << 16 | fcode)
+
 	uint16_t speedbin;
 };
 
@@ -137,7 +142,7 @@ struct adreno_gpu {
 	struct msm_gpu base;
 	const struct adreno_info *info;
 	uint32_t chip_id;
-	uint16_t speedbin;
+	uint32_t speedbin;
 	const struct adreno_gpu_funcs *funcs;
 
 	/* interesting register offsets to dump: */
@@ -520,7 +525,8 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 			 struct adreno_smmu_fault_info *info, const char *block,
 			 u32 scratch[4]);
 
-int adreno_read_speedbin(struct device *dev, u32 *speedbin);
+int adreno_read_speedbin(struct adreno_gpu *adreno_gpu,
+			 struct device *dev, u32 *speedbin);
 
 /*
  * For a5xx and a6xx targets load the zap shader that is used to pull the GPU

-- 
2.40.1


