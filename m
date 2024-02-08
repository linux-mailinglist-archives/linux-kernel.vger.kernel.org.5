Return-Path: <linux-kernel+bounces-58261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB684E3A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE29B1F28531
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52CE7C099;
	Thu,  8 Feb 2024 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVH5MiP4"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E041F149DFF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404475; cv=none; b=H/05w0mtVwvByfkb/OgGzvve9wXDX5EjMYOmoNwelynCkhvFkiRvaC6FpOpFgA8ATTiVwiR7/FE0jh/y8go681lFHOx69cAfuoq1XGBOR1nCjHj0P5TxZhV5Y0zfkZTceZHagRUKdT2Wz3vT7keztNENR9kEw7qVmRCImjsT2pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404475; c=relaxed/simple;
	bh=tl6JEvUus0xlZ8U5q5uQ8wyhk+g9z4wbwtBHieQ2hyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X2gvUFvRdwdhOVGFmyiCfvNh4dPXyyxtVmMVEb+bBBW/F7Fqaz7w5WXWbtDVrl9vzOVw01GBaVz7HbPPeXevZF6NJwXDe2hsuX1V34sFsKj814N62TUDypxngEln8OyTfHJZ1mHwaXO3lvpeIRpYoP7ftxg8OknrMrHG9tREVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nVH5MiP4; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5116ec49081so745182e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707404472; x=1708009272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bM1ON0mCYxX+OrdVKZhi68MkEuup4raYVaf9XhQ9xPo=;
        b=nVH5MiP4i3NaC6AdTyHOiU1rHuIN8Wk9dl3cRG65BlUQZXQc9YaMV2FyEAhQ8wqs9h
         lBeIam8eD4x0X5vecrKHKyzx2CKMgCwyMYQkjnoKQcz4yZ2isI6+fwjsnuRegIPz7exa
         0/JgKsD1VRkST/IeUlHR/ZVKXSWdEx/xB8phNizDJgR0+Y6lmUXrq4Tu7R4jzMPEJaKy
         Kx/PeF7tlCCnMrWPpf+jDWwQE2JDIKsA0PxrA6My8HZsKXigsAhkZdnYI/A5ZSpp6OrM
         7a8m2a2idkQ5lAfFJ59iLjQdqlJRngecRwoozIxVX9Kh8c02rB2GNpDAFXnN6NZQGRMe
         6OeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404472; x=1708009272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bM1ON0mCYxX+OrdVKZhi68MkEuup4raYVaf9XhQ9xPo=;
        b=P5u2vyXs7Pm95/0OBCbQcbJPSoOfELcojEUUATJxIRSbz54FrjZTE6Bmi1SpJVn/sc
         xvunlfuUv4UlNZ9/ZuQ65apJVGyhem9o7h8N4bjvPDoNjCRjMMtY3EVw9ZgPdBnKk93a
         DjjbgSw0861mO+JpraML6oR0HXaKYnEgx97wSb5+Emk21NIpoIlahQ9APVaY8RtK1qun
         Au7HpxANmfeVa5diwrYP1qXSLEbcnyBvwE+txm9eKeK5d3Xm5HfDR4IWOB8Zl1DAZd/p
         Ya29XXX3Ta0ylzHDsykyYyfjhXZy58pifHO/WeYUqCpZFWCw0br243Ut3NTtTShG/iS9
         MIXA==
X-Gm-Message-State: AOJu0YzBuLg97waLtOLxnMFnFWwZzH1XicC/nqBqP4LjqKkeXnwQOvl6
	EZdgaEAewnP9cav1p1iQ+8Eu07Jwx+4ICBPCp2Hi+7Ts6IV/YZnKW3tuqQMbWNU=
X-Google-Smtp-Source: AGHT+IHmgBBEIVWJ3JryLNAVPgOAqRUrD4/Io65FjB2JFKaahMiRIVll1dtAbGsF3ZA81Eb7MTARIg==
X-Received: by 2002:a05:6512:3084:b0:511:4cc9:33a4 with SMTP id z4-20020a056512308400b005114cc933a4mr8423242lfd.52.1707404472071;
        Thu, 08 Feb 2024 07:01:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPI7jqCSDTEQwvf49fCJB2nh7Ft9ZVdyBaxPIsoFErUzO5eWZvcgHD2TbF4rEI5iuJkjhI8AK0Wh82Sw/UdmgCNZRz1Ob08A9Kw3OMk/gabqeh1L6sFzf2TqULTbj1sJshhoSqyhwihX+CqEbFVoYotiAKP6UrBzg1fL02hdFDyFuB29Rv+HSQs+eIe3G7D4h5F9J3t+s1DC2/a3mdNYwR3w7sVDLArt6qhnVLLnyTsjIzxrGC+v85FvKE8cMYShl89HE8sbXPT6wJ2cCQtDnGUgzmheEAFbUtSbLSTRKsUGzBF6CjSaMYv0SEto5fgI3NbMcQPc2R0RHVCZgh
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x18-20020a19f612000000b00511498107b8sm22444lfe.65.2024.02.08.07.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:01:11 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 08 Feb 2024 17:01:09 +0200
Subject: [PATCH v4 2/4] drm/msm/dpu: support binding to the mdp5 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-fd-migrate-mdp5-v4-2-945d08ef3fa8@linaro.org>
References: <20240208-fd-migrate-mdp5-v4-0-945d08ef3fa8@linaro.org>
In-Reply-To: <20240208-fd-migrate-mdp5-v4-0-945d08ef3fa8@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5596;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=tl6JEvUus0xlZ8U5q5uQ8wyhk+g9z4wbwtBHieQ2hyo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlxOy1hHipg/dl04ngXKXm31WoTPg06D4744LEw
 TGvy4CLo9iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZcTstQAKCRCLPIo+Aiko
 1ZXXB/0RJS1fympL90lLUdAGvRisrATJ6XoAg/Oo8/RJvTpFhiUkkwhqsaZLBnqi9yfqYwnLYGh
 CqwHwd67IigqsW3DYhGGFl2zRNCQncbhH4PA2GY2NHWNcSWxygh7Ql/w/EXEQ7/eG3voik4IuYc
 3Bek4Gu7oV/kWt9N2aR+F7uRzNLK572iGLy+ei7XxY5rfIxX6Su0+b6Z8SHsZHx51lZ2u8X3NTO
 5+/E4fXhLW/QwHRH9JLIbx1FLoxE4ypbQbrEbkWIGQWe5V/2TzLdPQpGMKzS/ADFgE7eF4Gapyg
 Tb4oc0uIwySsb+Dn43ofsjL4LlxBRkdUI5k2U2iPT8Az+FIS
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
index 723cc1d82143..5de1861f608e 100644
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
+	if (!dev_is_platform(dpu_kms->pdev->dev.parent))
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


