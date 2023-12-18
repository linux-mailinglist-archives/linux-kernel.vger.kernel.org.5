Return-Path: <linux-kernel+bounces-4005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAA781768F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7C11F24C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B1F42373;
	Mon, 18 Dec 2023 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwxmF33H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD093D546;
	Mon, 18 Dec 2023 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cd870422c8so467076a12.0;
        Mon, 18 Dec 2023 07:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702915175; x=1703519975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X5RGGPLxL7RmqDldU4zVC+vRt1k5TON9j6VLsGbzQWQ=;
        b=XwxmF33HwQigmDruhBCU8ErAmTBN4SfuYJBclrU4HfBruz5mGtS+MHbHvMK+JNNIqd
         kXL1BWknMhgM5sYHq2u5IUDhmk+qodhsn7+naOEDdoG31kyASMK5ZePG2fXfaK7L5Lbo
         NrobTXrVTyBnWFBjYwzWosY3Xv1rqka3PEA6ArRhmAEjvi11o6OWNERoHGC3Ft/f1IOG
         ozVWXe63E7lzgES8oPDsdFt7iOpt0mbLfpw6AHVFSDpNH96SA18A0l++L0LP+sQnHW6/
         SUal4T5KmA8sUxaiYIXGP44/kB2fpL3JZUT/JJBXAjsbslN7q1BHkqn2sjz1e3q11VNz
         shgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915175; x=1703519975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5RGGPLxL7RmqDldU4zVC+vRt1k5TON9j6VLsGbzQWQ=;
        b=xGGmiqqvyzd6wxxSwslPEMFQGZ5y1esqBofENcN4oJds0vv1tA/eS6KGBdS4sp/2cV
         StMKRRqPYx0bse/+JF9xi3CXe7aFUWVwewrFIvAwoFpV5rssioI3UGwHP28Tzy0wZrqY
         Hl2hKF9eoyWjWCnRiLat8ceirawQT7DLSkqEj0ZZEhqpB5Kgw53swcSioTnzTSQpfV3T
         bsbToParXveqcpuHUIOIzttoepU2X5aHeNq6e51JqvHOiDI65t4uYtCfPWSYjKuIescV
         /hlxlAL9Pef6xAPDc+wIVaZ5hwq03mquw8E9HpUnuSnPoqR6M/cKrCpZE36ELDrVD+uc
         T9Qg==
X-Gm-Message-State: AOJu0Yxori0xTQBIzlkOSDtEIeIsAfXffK4o1H8NPtxtEeimI8xJELBF
	8VV5e2VqFvwFzz4+N+v6i6A=
X-Google-Smtp-Source: AGHT+IE7d7GDHTHnS8E5/AboMKPlZPnuoc6gcsADQrBLRGPYI2JmLd8QBiWoJ/biThaG/8vYNNumhg==
X-Received: by 2002:a17:90a:bb04:b0:280:cd7b:1fa5 with SMTP id u4-20020a17090abb0400b00280cd7b1fa5mr6789760pjr.4.1702915175541;
        Mon, 18 Dec 2023 07:59:35 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id pb7-20020a17090b3c0700b0028aea6c24bcsm6535129pjb.53.2023.12.18.07.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:59:34 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	Rob Clark <robdclark@chromium.org>,
	David Heidelberg <david.heidelberg@collabora.com>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	Danylo Piliaiev <dpiliaiev@igalia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a6xx: Fix recovery vs runpm race
Date: Mon, 18 Dec 2023 07:59:24 -0800
Message-ID: <20231218155927.368881-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

a6xx_recover() is relying on the gpu lock to serialize against incoming
submits doing a runpm get, as it tries to temporarily balance out the
runpm gets with puts in order to power off the GPU.  Unfortunately this
gets worse when we (in a later patch) will move the runpm get out of the
scheduler thread/work to move it out of the fence signaling path.

Instead we can just simplify the whole thing by using force_suspend() /
force_resume() instead of trying to be clever.

Reported-by: David Heidelberg <david.heidelberg@collabora.com>
Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/10272
Fixes: abe2023b4cea ("drm/msm/gpu: Push gpu lock down past runpm")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 268737e59131..a5660d63535b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1244,12 +1244,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
 	dev_pm_genpd_add_notifier(gmu->cxpd, &gmu->pd_nb);
 	dev_pm_genpd_synced_poweroff(gmu->cxpd);
 
-	/* Drop the rpm refcount from active submits */
-	if (active_submits)
-		pm_runtime_put(&gpu->pdev->dev);
-
-	/* And the final one from recover worker */
-	pm_runtime_put_sync(&gpu->pdev->dev);
+	pm_runtime_force_suspend(&gpu->pdev->dev);
 
 	if (!wait_for_completion_timeout(&gmu->pd_gate, msecs_to_jiffies(1000)))
 		DRM_DEV_ERROR(&gpu->pdev->dev, "cx gdsc didn't collapse\n");
@@ -1258,10 +1253,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
 
 	pm_runtime_use_autosuspend(&gpu->pdev->dev);
 
-	if (active_submits)
-		pm_runtime_get(&gpu->pdev->dev);
-
-	pm_runtime_get_sync(&gpu->pdev->dev);
+	pm_runtime_force_resume(&gpu->pdev->dev);
 
 	gpu->active_submits = active_submits;
 	mutex_unlock(&gpu->active_lock);
-- 
2.43.0


