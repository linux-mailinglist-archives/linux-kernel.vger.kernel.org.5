Return-Path: <linux-kernel+bounces-152093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4FA8AB8C1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626ED1F21532
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34055D502;
	Sat, 20 Apr 2024 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwiyeFI+"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA0610E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 02:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713580388; cv=none; b=fu+6j8Uf5uTFgp4iAIK9GuGX4aXxnsJIxTrW1z2iF8GBGO+5+FyAFHw2gOyXqx5K8qReQA8l22hK+ocyCXcBnqzMDwRv54MTiJrAyP1Yu9G2+KCU7PYy9pNIFivqrthIoL3yNs9L48apkyU8wMrPf3FlpJ4zz4g4OWz85+NDJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713580388; c=relaxed/simple;
	bh=GQzVVYo33W2Hu30tmAXW3x/XysFC6yW9pZ62iPoS2M8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UgFZeGVqSP+TdjCcDQ59Bo1/nuFiDX+9LnBJa87YHD76Cr3PRUo+ejr0RXKgjI/iCeWi+DBmHLDRGWLVl+jfcQgmCEluhuVNvw7hFx8taq72QyRR3cnaf4ttP3IkFkMRDQg3qikvRBm6FfxvTU4SlMzI1N2GB57DAPpEGYR3JDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iwiyeFI+; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so48127041fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 19:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713580385; x=1714185185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDk5fHKqnh3Ymuh3Yv85wCMuAKGtkk4BBfWgOawHww4=;
        b=iwiyeFI+3+PFF665iWwyQzoZcU05ykctkrLqzfYwGf6EgsMGI/v9c1qWyUpJF/7NTO
         BsiNzpmhkUP5cwfkAK9kcmC/D3bVZVhDh/oRtGqa0yuBhB2FPpek1eGChDX4dTrI8mzJ
         E8IEyc0DB7QwX7ikpii2+TJVV3hJf3ytubIw9ePY60oaLVCDezBX9EV7NDQToPCY51zA
         otlDtlWewru8RY3BgOTZCpgVMiHmwmT+//DVPfyuovSDsYdpOHTGraaTwdlZaM/OLmiX
         phBSe9OITWiycrHYRQVqh3yONFV9zvESuegca43MEAlnYuZ37GPXZHqIbw5jptL3Ssnd
         pB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713580385; x=1714185185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDk5fHKqnh3Ymuh3Yv85wCMuAKGtkk4BBfWgOawHww4=;
        b=wlrEwCodegqEFea9zwplwTC+jj2HnFYw4tDeDa8ar6atoQrYG/Yoh7gYjKbQag9tge
         LYz9tSy5UvwbcnBWixFMIHPFBlivk1Ur+cLcLLuRTUOls7gc7i0r6YhetBkByujNFrTy
         Z1LSRW6pQJb89h2eGhfxBMUq+VKLEEPSbaR38mNiruQoqKeRFLXgnxNrIfdoj3QLPRdG
         QmTMGDe6hgLy+gAhdVFI9ENfHXlWV4aaG7rdBuBp7jNpuWY+G6s4UWB69A5qnBb7gH4f
         8gzDtV7Al94FGDIPjB1WHXtRUErcptWQKbrOXb26E5YVfB/DAezf5KzBXAX6Oeh0e4sj
         GqOw==
X-Forwarded-Encrypted: i=1; AJvYcCV16Z+Iwj3cfM0TFDncADV08T14YcTDyG2wjlIXmVpd2rcU0BhJUhpXy2VkB9Totv/ZcbqqS2O3VBiNf8ZSx4qAGQUh+m8dnsRWGGQ7
X-Gm-Message-State: AOJu0YyZVaXbrQL87bgixUPHZptGDGtGEE5QiLzjQMkR3BwjPtfLN3fa
	C2TS+cU3xK8nLVBiN0NcByTkg9kury101GbwR9QXa7UN+ISOTnH5HC4brPBjJMs=
X-Google-Smtp-Source: AGHT+IGFYxHPEv2nSz87/BQG1vu5Ypasi44ZiSz0Hd7YZdpw3Mv7a1b7WxKcr9RE6G9H+Hjktfr6oQ==
X-Received: by 2002:a2e:b0f8:0:b0:2d4:6a34:97bf with SMTP id h24-20020a2eb0f8000000b002d46a3497bfmr2467906ljl.49.1713580384898;
        Fri, 19 Apr 2024 19:33:04 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 20-20020a05651c009400b002d87e936833sm836843ljq.125.2024.04.19.19.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 19:33:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 20 Apr 2024 05:33:02 +0300
Subject: [PATCH 2/3] drm/msm/mdp4: don't destroy mdp4_kms in mdp4_kms_init
 error path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240420-mdp4-fixes-v1-2-96a70f64fa85@linaro.org>
References: <20240420-mdp4-fixes-v1-0-96a70f64fa85@linaro.org>
In-Reply-To: <20240420-mdp4-fixes-v1-0-96a70f64fa85@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3569;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=GQzVVYo33W2Hu30tmAXW3x/XysFC6yW9pZ62iPoS2M8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmIyleU+XAbOqMszZPcfnbC9pF4dSLOlWp+Ro35
 4c0yo6gjzCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZiMpXgAKCRCLPIo+Aiko
 1cWhCACZKliWZcXp6bbxQIhR8oxBlqI4DLHnHBVhq6OGdyyjnViPn5pQU9Q4fK12Q6KNcX9mBdz
 EgvXq3S8n2+eBQB7talFGSVCorXGTfgcd0HnpnrzidpOyP08gJ7FLEOTvVHvIBoMHtcGcYwOhMM
 W0IfSH0gYVQp/C/SVFt2SOdiB+RsH9n3HhrFoy4DXbnklviFLSyKlnSm9jJTqD+CpnhZfxP9J2R
 W2RXl5oRc7pyT0y2BkkX+eVWc7pO8MZf7sTczYMI3+b3MbcTIBYUL4VCMRWP86xVoEriWWwJ5Sg
 zEFC+g6BtQrPpwvvZKVQ5EHSF7/w/l5r5B4D05AcWtuR9nX0
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Since commit 3c74682637e6 ("drm/msm/mdp4: move resource allocation to
the _probe function") the mdp4_kms data is allocated during probe. It is
an error to destroy it during mdp4_kms_init(), as the data is still
referenced by the drivers's data and can be used later in case of probe
deferral.

Fixes: 3c74682637e6 ("drm/msm/mdp4: move resource allocation to the _probe function")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 4ba1cb74ad76..4c5f72b7e0e5 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -392,7 +392,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 	ret = mdp_kms_init(&mdp4_kms->base, &kms_funcs);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "failed to init kms\n");
-		goto fail;
+		return ret;
 	}
 
 	kms = priv->kms;
@@ -403,7 +403,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 		ret = regulator_enable(mdp4_kms->vdd);
 		if (ret) {
 			DRM_DEV_ERROR(dev->dev, "failed to enable regulator vdd: %d\n", ret);
-			goto fail;
+			return ret;
 		}
 	}
 
@@ -414,8 +414,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 	if (major != 4) {
 		DRM_DEV_ERROR(dev->dev, "unexpected MDP version: v%d.%d\n",
 			      major, minor);
-		ret = -ENXIO;
-		goto fail;
+		return -ENXIO;
 	}
 
 	mdp4_kms->rev = minor;
@@ -423,8 +422,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 	if (mdp4_kms->rev >= 2) {
 		if (!mdp4_kms->lut_clk) {
 			DRM_DEV_ERROR(dev->dev, "failed to get lut_clk\n");
-			ret = -ENODEV;
-			goto fail;
+			return -ENODEV;
 		}
 		clk_set_rate(mdp4_kms->lut_clk, max_clk);
 	}
@@ -445,8 +443,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 
 	mmu = msm_iommu_new(&pdev->dev, 0);
 	if (IS_ERR(mmu)) {
-		ret = PTR_ERR(mmu);
-		goto fail;
+		return PTR_ERR(mmu);
 	} else if (!mmu) {
 		DRM_DEV_INFO(dev->dev, "no iommu, fallback to phys "
 				"contig buffers for scanout\n");
@@ -458,8 +455,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 		if (IS_ERR(aspace)) {
 			if (!IS_ERR(mmu))
 				mmu->funcs->destroy(mmu);
-			ret = PTR_ERR(aspace);
-			goto fail;
+			return PTR_ERR(aspace);
 		}
 
 		kms->aspace = aspace;
@@ -468,7 +464,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 	ret = modeset_init(mdp4_kms);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "modeset_init failed: %d\n", ret);
-		goto fail;
+		return ret;
 	}
 
 	mdp4_kms->blank_cursor_bo = msm_gem_new(dev, SZ_16K, MSM_BO_WC | MSM_BO_SCANOUT);
@@ -476,14 +472,14 @@ static int mdp4_kms_init(struct drm_device *dev)
 		ret = PTR_ERR(mdp4_kms->blank_cursor_bo);
 		DRM_DEV_ERROR(dev->dev, "could not allocate blank-cursor bo: %d\n", ret);
 		mdp4_kms->blank_cursor_bo = NULL;
-		goto fail;
+		return ret;
 	}
 
 	ret = msm_gem_get_and_pin_iova(mdp4_kms->blank_cursor_bo, kms->aspace,
 			&mdp4_kms->blank_cursor_iova);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "could not pin blank-cursor bo: %d\n", ret);
-		goto fail;
+		return ret;
 	}
 
 	dev->mode_config.min_width = 0;
@@ -492,12 +488,6 @@ static int mdp4_kms_init(struct drm_device *dev)
 	dev->mode_config.max_height = 2048;
 
 	return 0;
-
-fail:
-	if (kms)
-		mdp4_destroy(kms);
-
-	return ret;
 }
 
 static const struct dev_pm_ops mdp4_pm_ops = {

-- 
2.39.2


