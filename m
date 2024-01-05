Return-Path: <linux-kernel+bounces-18418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB644825D31
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8737528260D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB0364DF;
	Fri,  5 Jan 2024 23:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="agNdjeqs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B049F360B4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso67284e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 15:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704497660; x=1705102460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ca8QpilXW9nIueljtJCFA85v0Hen2fQTmG6mJOfT0Tg=;
        b=agNdjeqsfDfDS+HAC3UxEJYxh6UNd2pgrT4YzFqR8TjIrfUjAZUS4DmzcxuEwtiD2O
         SrqaGzMaiJ3WaSQn6g0QjzwZASa7dZWsd2EHBsU3g6yWqX81ysC1ZFKzXaph+7zKOyp/
         Hk4jossFZpcee8yZA4addodAGk7OddnoNuMhiPh/Z67gfo1jOz48qcc3Qg9sHSBifIKg
         0tJNhrTL/6A86avR7lEFSiRAd9gbm/KsDkF0FteDGOCy9970krfacwao3Df+BURQpmCI
         pF2D1RRTZ9RY8fUh1IfS5kbO3w0zzzrA8vUCx+bPvydX2XS/vUFHoqwgW6z1jfV2d5xR
         in3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704497660; x=1705102460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ca8QpilXW9nIueljtJCFA85v0Hen2fQTmG6mJOfT0Tg=;
        b=COWWQM3rs5YVKk4wWXLALGoaArTbKAT7E1EJQ1PIeuXoihpEhMJNq8IEHq6uiA3nN6
         AWrnuhNFcnz4vR7jXXvHGQv46HWRHB61yUlEWwjuIwPeU9KeN3Qbpb4xzosDts6DQ8Ji
         +lGnU+iWR2B/fZST9StbJp/ARs0e9whUyGsvKqT9bu3ohKrJXTQldRfNOrXx+YsXa7BX
         E0mKzcCLS5e90IilccrmPqNP3oH0+rhh+tKsadBQ6yZvz0mwGSu4LntKN1HTlGmMfJN1
         NnUrarSyERmKq6D6PA9Jt0F8QWV7x98Z9dKoak3DNcxySOYtI081ieHaRRhpyWzMWRXu
         V61w==
X-Gm-Message-State: AOJu0Yz/hGoT9jwRumfix2cWqNzKO+TsPvKWMQ8fGEHHgnHYjVAPzzKO
	j4vUkU+PZKCBjAZ1gHwvBnDLyippRVE2HQ==
X-Google-Smtp-Source: AGHT+IGMR+uDBBj+HxtcIk41GnXMSBMW/eQumehmT4kFqTC7BOPEvc4PDEeLuhIoW+vhS10c4S2r/w==
X-Received: by 2002:ac2:4a8a:0:b0:50e:7f70:a08b with SMTP id l10-20020ac24a8a000000b0050e7f70a08bmr65774lfp.112.1704497659755;
        Fri, 05 Jan 2024 15:34:19 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id k4-20020ac24f04000000b0050e74d04c8asm362211lfr.132.2024.01.05.15.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 15:34:19 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 06 Jan 2024 01:34:17 +0200
Subject: [PATCH v3 3/4] drm/msm: add a kernel param to select between MDP5
 and DPU drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-fd-migrate-mdp5-v3-3-3d2750378063@linaro.org>
References: <20240106-fd-migrate-mdp5-v3-0-3d2750378063@linaro.org>
In-Reply-To: <20240106-fd-migrate-mdp5-v3-0-3d2750378063@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Stephen Boyd <swboyd@chromium.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3741;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=abAC+lw4hjGPuNmxpktM2ndFdh6eRFn95EvCwJH6BVI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBlmJH35H1Sc7wsyEAR8ndmd1/uurtz+VgYXO7iI
 IlnDLKn032JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZZiR9wAKCRCLPIo+Aiko
 1T5fB/9F0oTDVX6dnOnu/guTRuyY9cAlZrxxzwIIsUIrwdacCBuuOfH/xvwArLOr2mTEQv0OQ+b
 u0VpTuKpvASKrm0ZPG38DHXndlKgr//GhnQZCkZT0i5tAgfkrf7d6XAWhE7VzEskg1U7dxtYmYR
 SnIDBmvA68Iug8QPrM2KsauOF+B0SMKhm3bBhN4lfmEibQctGSZU+29Hdhdr4zKs6A71WzY3ZG6
 2yMLYUTbeqg5WuVr1hPaoLFf47FvIfF6zoKl+vUlxlE0+BnSR8EmpWP/Pj4OJIBTdaX0D09JhCe
 IVIK1RxDQ65a+gtqO5VUMmC5VtxpklfgMvjnyG+mevMstM6S
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

For some of the platforms (e.g. SDM660, SDM630, MSM8996, etc.) it is
possible to support this platform via the DPU driver (e.g. to provide
support for DP, multirect, etc). Add a modparam to be able to switch
between these two drivers.

All platforms supported by both drivers are by default handled by the
MDP5 driver. To let them be handled by the DPU driver pass the
`msm.prefer_mdp5=false` kernel param.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  |  3 +++
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |  3 +++
 drivers/gpu/drm/msm/msm_drv.c            | 31 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.h            |  1 +
 4 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index aa9e0ad33ebb..8f11a98491a1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1276,6 +1276,9 @@ static int dpu_dev_probe(struct platform_device *pdev)
 	int irq;
 	int ret = 0;
 
+	if (!msm_disp_drv_should_bind(&pdev->dev, true))
+		return -ENODEV;
+
 	dpu_kms = devm_kzalloc(dev, sizeof(*dpu_kms), GFP_KERNEL);
 	if (!dpu_kms)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 0827634664ae..43d05851c54d 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -866,6 +866,9 @@ static int mdp5_dev_probe(struct platform_device *pdev)
 
 	DBG("");
 
+	if (!msm_disp_drv_should_bind(&pdev->dev, false))
+		return -ENODEV;
+
 	mdp5_kms = devm_kzalloc(&pdev->dev, sizeof(*mdp5_kms), GFP_KERNEL);
 	if (!mdp5_kms)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 50b65ffc24b1..ef57586fbeca 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -969,6 +969,37 @@ static int add_components_mdp(struct device *master_dev,
 	return 0;
 }
 
+#if !IS_REACHABLE(CONFIG_DRM_MSM_MDP5) || !IS_REACHABLE(CONFIG_DRM_MSM_DPU)
+bool msm_disp_drv_should_bind(struct device *dev, bool mdp5_driver)
+{
+	/* If just a single driver is enabled, use it no matter what */
+	return true;
+}
+#else
+
+static bool prefer_mdp5 = true;
+MODULE_PARM_DESC(prefer_mdp5, "Select whether MDP5 or DPU driver should be preferred");
+module_param(prefer_mdp5, bool, 0444);
+
+/* list all platforms supported by both mdp5 and dpu drivers */
+static const char *const msm_mdp5_dpu_migration[] = {
+	NULL,
+};
+
+bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver)
+{
+	/* If it is not an MDP5 device, do not try MDP5 driver */
+	if (!of_device_is_compatible(dev->of_node, "qcom,mdp5"))
+		return dpu_driver;
+
+	/* If it is not in the migration list, use MDP5 */
+	if (!of_device_compatible_match(dev->of_node, msm_mdp5_dpu_migration))
+		return !dpu_driver;
+
+	return prefer_mdp5 ? !dpu_driver : dpu_driver;
+}
+#endif
+
 /*
  * We don't know what's the best binding to link the gpu with the drm device.
  * Fow now, we just hunt for all the possible gpus that we support, and add them
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 01e783130054..762e13e2df74 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -563,5 +563,6 @@ int msm_drv_probe(struct device *dev,
 	struct msm_kms *kms);
 void msm_kms_shutdown(struct platform_device *pdev);
 
+bool msm_disp_drv_should_bind(struct device *dev, bool dpu_driver);
 
 #endif /* __MSM_DRV_H__ */

-- 
2.39.2


