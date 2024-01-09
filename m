Return-Path: <linux-kernel+bounces-21248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E68828C7D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49BD2B24E6D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1073C6BC;
	Tue,  9 Jan 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZkbIMM/"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C313C68E;
	Tue,  9 Jan 2024 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d41bb4da91so15600515ad.0;
        Tue, 09 Jan 2024 10:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704824541; x=1705429341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k4A842bIbNaLxIo03lzXt0/VhyZzfulbNd4Jc/GgvJg=;
        b=eZkbIMM/OXBLA834+i0Re8gizkmALs8+6ruF88bZhAQpYPMp9/vTXz6FM+I21RkJj/
         GKPVFdsicx3ICpWcjVmQnAq5f8IbTxNK6wh9q/kjUoE2vyrWBBxVWBICLuvBMa1DcwXc
         Kbw7CSu0nf43geyJMBvRAO9tshY7KVDCYvT/zHTAvKuFg7DM8jHaE/ufUjl5Fk+N+4qF
         Z1Z+Cz6RHp5Utb1mGkPJMIjixxW3+5CoOeFyofF1NeFW8onuyjf6Qxwz3mOVExCDRAcS
         HlvwgWW8EZ/PkyQu8ufu0+Yf75zHO+XZsYbG94LlStQbJ36TGTZrq0yfVvoFtpkf3fZ2
         GGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824541; x=1705429341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4A842bIbNaLxIo03lzXt0/VhyZzfulbNd4Jc/GgvJg=;
        b=YsIreEoRPYQGT466m2hJ3yEgVO8u05WY/t7oqSLxYTTL3dkyWBuNUceTWhSogE7TTs
         WOQm0LPJH80HUEJYf8PvWQb+u76A8Q5QZwKKzYgTZ8ctQb7dFYo4RHZlXEeFkZ4/xeRX
         NnCE2MD0VoDMvP9atl+EE8iuX0eP1LgnDEaNVTQYolU/E72FG1UMtiztUwfEiHHFBsbO
         N2cd0UPHZc8+DUAiFie/zcTJXOIy2zNRpdfsvo3tswVRETW/4ttVbRX0exoBDP5io0+v
         eOjIxz7LYvw1Dau2tuVJp4JPKvBxHt0v2cPnQBmJEksNZP4bd46lI8tx1cTiRTIAox0u
         JPLQ==
X-Gm-Message-State: AOJu0YyCVJa8/FN94GYWEWL3SWE7GzpWYw+bvm+aaEOSMGqvKLjGrQQz
	qx8fCr4snoPPRvXX0lYz1+k=
X-Google-Smtp-Source: AGHT+IHnNJgT4Frcmf+mu0NObp6XPVh7FkAVBM9nfEuBx/+VqBzGvs5E5OOVp4iBa8sQu9sssKuqoA==
X-Received: by 2002:a17:903:32c3:b0:1d4:1a55:6e70 with SMTP id i3-20020a17090332c300b001d41a556e70mr3390318plr.113.1704824540985;
        Tue, 09 Jan 2024 10:22:20 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id jf15-20020a170903268f00b001d3e6f58e5esm2104217plb.6.2024.01.09.10.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:22:20 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "drm/msm/gpu: Push gpu lock down past runpm"
Date: Tue,  9 Jan 2024 10:22:17 -0800
Message-ID: <20240109182218.193804-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

This reverts commit abe2023b4cea192ab266b351fd38dc9dbd846df0.

Changing the locking order means that scheduler/msm_job_run() can race
with the recovery kthread worker, with the result that the GPU gets an
extra runpm get when we are trying to power it off.  Leaving the GPU in
an unrecovered state.

I'll need to come up with a different scheme for appeasing lockdep.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gpu.c        | 11 +++++------
 drivers/gpu/drm/msm/msm_ringbuffer.c |  7 +++++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 095390774f22..655002b21b0d 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -751,12 +751,14 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	struct msm_ringbuffer *ring = submit->ring;
 	unsigned long flags;
 
-	pm_runtime_get_sync(&gpu->pdev->dev);
+	WARN_ON(!mutex_is_locked(&gpu->lock));
 
-	mutex_lock(&gpu->lock);
+	pm_runtime_get_sync(&gpu->pdev->dev);
 
 	msm_gpu_hw_init(gpu);
 
+	submit->seqno = submit->hw_fence->seqno;
+
 	update_sw_cntrs(gpu);
 
 	/*
@@ -781,11 +783,8 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	gpu->funcs->submit(gpu, submit);
 	gpu->cur_ctx_seqno = submit->queue->ctx->seqno;
 
-	hangcheck_timer_reset(gpu);
-
-	mutex_unlock(&gpu->lock);
-
 	pm_runtime_put(&gpu->pdev->dev);
+	hangcheck_timer_reset(gpu);
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index e0ed27739449..548f5266a7d3 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -21,8 +21,6 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 
 	msm_fence_init(submit->hw_fence, fctx);
 
-	submit->seqno = submit->hw_fence->seqno;
-
 	mutex_lock(&priv->lru.lock);
 
 	for (i = 0; i < submit->nr_bos; i++) {
@@ -35,8 +33,13 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
 
 	mutex_unlock(&priv->lru.lock);
 
+	/* TODO move submit path over to using a per-ring lock.. */
+	mutex_lock(&gpu->lock);
+
 	msm_gpu_submit(gpu, submit);
 
+	mutex_unlock(&gpu->lock);
+
 	return dma_fence_get(submit->hw_fence);
 }
 
-- 
2.43.0


