Return-Path: <linux-kernel+bounces-18419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F55A825D32
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBF21F23FA9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAB436AF8;
	Fri,  5 Jan 2024 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bD2h52WP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BC2360BA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 23:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e67f70f34so78713e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 15:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704497659; x=1705102459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3T5J8bNQK5XAdBehncduzCFxSoGLPqlnF2Hr6/4OwAc=;
        b=bD2h52WPzyTiKB+cnPNZ9PVk7tQF8yhUjGALviclp7jn2N8d/xq4PAOhBnjXVIuqNr
         /5TMwbRMqrkr+LSoOUFOOplX8tBhaDRsxddiI/vxt1J08VG7WyASb5BOrLJSzPOowMFi
         v/d3CCltApIfdHA3QfIeUhFD8IlOklnAT8pibCidbDtdFfCrusX98ao6kdTHfx92WGxV
         ssQe5v2PPShz2he7aeaj5ghhFE575rnsURLPY5WwyPIw0M6aSgIbtkPjcOCcGXjaDY2Z
         RQ3eSJsGl8p0HG0E7+SjEcSOWxfk7zijYk/e/R8EW85L6smXrQIvP1Mt6G0SAn/EwSkU
         NaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704497659; x=1705102459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3T5J8bNQK5XAdBehncduzCFxSoGLPqlnF2Hr6/4OwAc=;
        b=TsXNUU1hjIXLKpFcPQrZWhJh2iby5634ISEF8a62CCPnSbQC9HdRG/fgJoyTaLrb66
         Ccr8zK2RKxKRdebn1DdastTaC1qpqJlltZKTv2tHrKT5mCmi9/qP4EEfFvgRdi28jnCH
         xXdOVGMBmJRMnpLyAzOBEc4ARUvmzpyEsvIRzrSU/isi9eiLxdxd0s5LRcBj8gxYThWT
         WT16SRfWweg269hfbEqu8U6zcYK5kxPhwwiUsTBZdwE4ILu8GzwDqqdXihCU+Js+uD/E
         CyO7so4XVvtJqDVdvEuLf1QwUfPpeNA9rlp6Xs8n/eIIf6ReQ3UGVgeMI24aEcJQ7Emu
         Pw+Q==
X-Gm-Message-State: AOJu0Ywz6J5RXUrO6I+0itqwiCFjKHZhtRmUcvI/Pok+QKSQ3JDYE8Ty
	PtUWwZC0IKZSaY8rXcBcUdKGxdo4STEl3Q==
X-Google-Smtp-Source: AGHT+IHKWE78pMyEjlTpgPNa1sUMzNcI+WPVxfGXQ8Wb1NYK0/u1LUCOQwSo6DSENPY0rC9OYWezvw==
X-Received: by 2002:a05:6512:246:b0:50e:4acb:3d0d with SMTP id b6-20020a056512024600b0050e4acb3d0dmr65443lfo.47.1704497658844;
        Fri, 05 Jan 2024 15:34:18 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k4-20020ac24f04000000b0050e74d04c8asm362211lfr.132.2024.01.05.15.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 15:34:18 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 06 Jan 2024 01:34:16 +0200
Subject: [PATCH v3 2/4] drm/msm/dpu: support binding to the mdp5 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-fd-migrate-mdp5-v3-2-3d2750378063@linaro.org>
References: <20240106-fd-migrate-mdp5-v3-0-3d2750378063@linaro.org>
In-Reply-To: <20240106-fd-migrate-mdp5-v3-0-3d2750378063@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5597;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=r6/gCr+xdab3sdKL6gyWMEBbRFCgBrcmQFNSej3FNt4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlmJH3hkLeNpca5eBe7y5aspXQ7mzoe0WXri4OI
 ml2TKAybc+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZiR9wAKCRCLPIo+Aiko
 1aYnCACL5b6aY3/WBVU0bHnAtiSYAggE5sIpLL9DBYnCl9x56LYDer3A3MLpui4oSh09ZL+fHES
 im2z/U0d/I6rqRi53pBWdRLA/oVkdgRmc9JOj0mf9hMI2Xpc0v1J9sZZr3y7JbypSumNTlKeBUN
 muozWQ4OTUcz4fyVhq706SBY9ebMo/zbpGLrrW8I5jS92qz/Cdy7LV+UJVs/J9E0CFyNdoXKlzh
 OeXi7QhhvN4nQbooKV7zFi95i8FH7pbB2cUdm7Uiku6DQgS6ADJVQIMZzI1vdtBPM42nfRQB+09
 3Bjyiru4YK/nSzRJBvmSyN2zrl62lZ/MXmBRmMiLxQ7DMhFG
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Existing MDP5 devices have slightly different bindings. The main
register region is called `mdp_phys' instead of `mdp'. Also vbif
register regions are a part of the parent, MDSS device. Add support for
handling this binding differences.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 98 ++++++++++++++++++++++++++-------
 drivers/gpu/drm/msm/msm_drv.h           |  3 +
 drivers/gpu/drm/msm/msm_io_utils.c      | 13 +++++
 3 files changed, 93 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 723cc1d82143..aa9e0ad33ebb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1197,6 +1197,78 @@ static int dpu_kms_init(struct drm_device *ddev)
 	return 0;
 }
 
+static int dpu_kms_mmap_mdp5(struct dpu_kms *dpu_kms)
+{
+	struct platform_device *pdev = dpu_kms->pdev;
+	struct platform_device *mdss_dev;
+	int ret;
+
+	if (dpu_kms->pdev->dev.bus != &platform_bus_type)
+		return -EINVAL;
+
+	mdss_dev = to_platform_device(dpu_kms->pdev->dev.parent);
+
+	dpu_kms->mmio = msm_ioremap(pdev, "mdp_phys");
+	if (IS_ERR(dpu_kms->mmio)) {
+		ret = PTR_ERR(dpu_kms->mmio);
+		DPU_ERROR("mdp register memory map failed: %d\n", ret);
+		dpu_kms->mmio = NULL;
+		return ret;
+	}
+	DRM_DEBUG("mapped dpu address space @%pK\n", dpu_kms->mmio);
+
+	dpu_kms->vbif[VBIF_RT] = msm_ioremap_mdss(mdss_dev,
+						  dpu_kms->pdev,
+						  "vbif_phys");
+	if (IS_ERR(dpu_kms->vbif[VBIF_RT])) {
+		ret = PTR_ERR(dpu_kms->vbif[VBIF_RT]);
+		DPU_ERROR("vbif register memory map failed: %d\n", ret);
+		dpu_kms->vbif[VBIF_RT] = NULL;
+		return ret;
+	}
+
+	dpu_kms->vbif[VBIF_NRT] = msm_ioremap_mdss(mdss_dev,
+						   dpu_kms->pdev,
+						   "vbif_nrt_phys");
+	if (IS_ERR(dpu_kms->vbif[VBIF_NRT])) {
+		dpu_kms->vbif[VBIF_NRT] = NULL;
+		DPU_DEBUG("VBIF NRT is not defined");
+	}
+
+	return 0;
+}
+
+static int dpu_kms_mmap_dpu(struct dpu_kms *dpu_kms)
+{
+	struct platform_device *pdev = dpu_kms->pdev;
+	int ret;
+
+	dpu_kms->mmio = msm_ioremap(pdev, "mdp");
+	if (IS_ERR(dpu_kms->mmio)) {
+		ret = PTR_ERR(dpu_kms->mmio);
+		DPU_ERROR("mdp register memory map failed: %d\n", ret);
+		dpu_kms->mmio = NULL;
+		return ret;
+	}
+	DRM_DEBUG("mapped dpu address space @%pK\n", dpu_kms->mmio);
+
+	dpu_kms->vbif[VBIF_RT] = msm_ioremap(pdev, "vbif");
+	if (IS_ERR(dpu_kms->vbif[VBIF_RT])) {
+		ret = PTR_ERR(dpu_kms->vbif[VBIF_RT]);
+		DPU_ERROR("vbif register memory map failed: %d\n", ret);
+		dpu_kms->vbif[VBIF_RT] = NULL;
+		return ret;
+	}
+
+	dpu_kms->vbif[VBIF_NRT] = msm_ioremap_quiet(pdev, "vbif_nrt");
+	if (IS_ERR(dpu_kms->vbif[VBIF_NRT])) {
+		dpu_kms->vbif[VBIF_NRT] = NULL;
+		DPU_DEBUG("VBIF NRT is not defined");
+	}
+
+	return 0;
+}
+
 static int dpu_dev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1230,28 +1302,12 @@ static int dpu_dev_probe(struct platform_device *pdev)
 
 	dpu_kms->base.irq = irq;
 
-	dpu_kms->mmio = msm_ioremap(pdev, "mdp");
-	if (IS_ERR(dpu_kms->mmio)) {
-		ret = PTR_ERR(dpu_kms->mmio);
-		DPU_ERROR("mdp register memory map failed: %d\n", ret);
-		dpu_kms->mmio = NULL;
-		return ret;
-	}
-	DRM_DEBUG("mapped dpu address space @%pK\n", dpu_kms->mmio);
-
-	dpu_kms->vbif[VBIF_RT] = msm_ioremap(pdev, "vbif");
-	if (IS_ERR(dpu_kms->vbif[VBIF_RT])) {
-		ret = PTR_ERR(dpu_kms->vbif[VBIF_RT]);
-		DPU_ERROR("vbif register memory map failed: %d\n", ret);
-		dpu_kms->vbif[VBIF_RT] = NULL;
+	if (of_device_is_compatible(dpu_kms->pdev->dev.of_node, "qcom,mdp5"))
+		ret = dpu_kms_mmap_mdp5(dpu_kms);
+	else
+		ret = dpu_kms_mmap_dpu(dpu_kms);
+	if (ret)
 		return ret;
-	}
-
-	dpu_kms->vbif[VBIF_NRT] = msm_ioremap_quiet(pdev, "vbif_nrt");
-	if (IS_ERR(dpu_kms->vbif[VBIF_NRT])) {
-		dpu_kms->vbif[VBIF_NRT] = NULL;
-		DPU_DEBUG("VBIF NRT is not defined");
-	}
 
 	ret = dpu_kms_parse_data_bus_icc_path(dpu_kms);
 	if (ret)
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 16a7cbc0b7dd..01e783130054 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -476,6 +476,9 @@ void __iomem *msm_ioremap(struct platform_device *pdev, const char *name);
 void __iomem *msm_ioremap_size(struct platform_device *pdev, const char *name,
 		phys_addr_t *size);
 void __iomem *msm_ioremap_quiet(struct platform_device *pdev, const char *name);
+void __iomem *msm_ioremap_mdss(struct platform_device *mdss_pdev,
+			       struct platform_device *dev,
+			       const char *name);
 
 struct icc_path *msm_icc_get(struct device *dev, const char *name);
 
diff --git a/drivers/gpu/drm/msm/msm_io_utils.c b/drivers/gpu/drm/msm/msm_io_utils.c
index 59d2788c4510..afedd61c3e28 100644
--- a/drivers/gpu/drm/msm/msm_io_utils.c
+++ b/drivers/gpu/drm/msm/msm_io_utils.c
@@ -50,6 +50,19 @@ struct clk *msm_clk_get(struct platform_device *pdev, const char *name)
 	return clk;
 }
 
+void __iomem *msm_ioremap_mdss(struct platform_device *mdss_pdev,
+			       struct platform_device *pdev,
+			       const char *name)
+{
+	struct resource *res;
+
+	res = platform_get_resource_byname(mdss_pdev, IORESOURCE_MEM, name);
+	if (!res)
+		return ERR_PTR(-EINVAL);
+
+	return devm_ioremap_resource(&pdev->dev, res);
+}
+
 static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name,
 				  bool quiet, phys_addr_t *psize)
 {

-- 
2.39.2


