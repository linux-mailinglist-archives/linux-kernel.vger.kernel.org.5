Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C19751383
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjGLWZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGLWZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:25:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F704199E;
        Wed, 12 Jul 2023 15:25:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6689430d803so79225b3a.0;
        Wed, 12 Jul 2023 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689200728; x=1691792728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p16HJUeFjh0Up2EuZ/dd2QVMrO3mMIhcqelMbrELgUs=;
        b=AS3vGV8GaYrFYrEl8H7hKOjmb4Es0czMAC6TL+m1BtL8qPw1sXJihYI42F4fQzasCr
         9C/y54pmvfVY9HMvfXgQdtw4Dg9mHXrMPvs5VDa9hXep9esXb/RyZvxjNfMvsYcmnTMJ
         ocpZaEc7VznJX4Es9MCc/gosChAkNclEWfsQ1LzguTrGQsuHe8ivx1aoV4U52w3gRZd1
         qZsRONMzbiDqyWR73A3DZ3K7r1Was6iNreseQs4VmEeXtoGKGC18Wefn0FQ+w4mhF049
         sjq6dTthUjmgvqR6YZ9s3TqubH7fPlMeM6m33OUtbuIclNjP+ZtOTBA0A25zi/fln4hk
         NM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689200728; x=1691792728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p16HJUeFjh0Up2EuZ/dd2QVMrO3mMIhcqelMbrELgUs=;
        b=c566o7bRynKlnlN+P4cEbyz6vzHUeMRGU4RFWkENyNcViDSAWEVfwBYD8u98AmjpN9
         eE/JVDeQ/xyrNM9/eXqkE9chQRMDx3OCctW89SYBd2cDrOMr6/gXmxYHLUlUAw1Ighmd
         NwObLRZb/uQxVR2R/0Orl5NNmChJRLw6KLjOquJ30o+4DTXOTW/GqzsiuFCjfP/Tm24G
         82UqidNEUdaV0MgQRd+ULivx9YuDH7yChEug46NrKwGGLM+3G+y+Cz9ylLXBsiDcUFwH
         uf5k6Pp2pGMzKRcfDnr8Vg+A326E1p/Xltns0VPzdtQVlUHXwgyE9knwhCyYQIODAot2
         2Psg==
X-Gm-Message-State: ABy/qLYKIX/gsSuYZNTLyqMOCZ17NcFSOX2CmuBOMJJMtGpFfzgVs8HL
        T2WDvNQtIt2rg/KpmSxxTew=
X-Google-Smtp-Source: APBJJlG3beF7ERt/uLgX1UHxkuEN/pg8U+e7c3SJSiwKs5FaMN/c4UXTKiygCxqrZPeQl6oKY+i78g==
X-Received: by 2002:a05:6a00:23ca:b0:668:8596:7524 with SMTP id g10-20020a056a0023ca00b0066885967524mr21229199pfc.20.1689200727294;
        Wed, 12 Jul 2023 15:25:27 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:69d1:d8aa:25be:a2b6])
        by smtp.gmail.com with ESMTPSA id i23-20020aa78b57000000b00662610cf7a8sm4174893pfd.172.2023.07.12.15.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:25:26 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Fix hw_fence error path cleanup
Date:   Wed, 12 Jul 2023 15:25:23 -0700
Message-ID: <20230712222523.7404-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

In an error path where the submit is free'd without the job being run,
the hw_fence pointer is simply a kzalloc'd block of memory.  In this
case we should just kfree() it, rather than trying to decrement it's
reference count.  Fortunately we can tell that this is the case by
checking for a zero refcount, since if the job was run, the submit would
be holding a reference to the hw_fence.

Fixes: f94e6a51e17c ("drm/msm: Pre-allocate hw_fence")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_fence.c      |  6 ++++++
 drivers/gpu/drm/msm/msm_gem_submit.c | 14 +++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
index 96599ec3eb78..1a5d4f1c8b42 100644
--- a/drivers/gpu/drm/msm/msm_fence.c
+++ b/drivers/gpu/drm/msm/msm_fence.c
@@ -191,6 +191,12 @@ msm_fence_init(struct dma_fence *fence, struct msm_fence_context *fctx)
 
 	f->fctx = fctx;
 
+	/*
+	 * Until this point, the fence was just some pre-allocated memory,
+	 * no-one should have taken a reference to it yet.
+	 */
+	WARN_ON(kref_read(&fence->refcount));
+
 	dma_fence_init(&f->base, &msm_fence_ops, &fctx->spinlock,
 		       fctx->context, ++fctx->last_fence);
 }
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 3f1aa4de3b87..9d66498cdc04 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -86,7 +86,19 @@ void __msm_gem_submit_destroy(struct kref *kref)
 	}
 
 	dma_fence_put(submit->user_fence);
-	dma_fence_put(submit->hw_fence);
+
+	/*
+	 * If the submit is freed before msm_job_run(), then hw_fence is
+	 * just some pre-allocated memory, not a reference counted fence.
+	 * Once the job runs and the hw_fence is initialized, it will
+	 * have a refcount of at least one, since the submit holds a ref
+	 * to the hw_fence.
+	 */
+	if (kref_read(&submit->hw_fence->refcount) == 0) {
+		kfree(submit->hw_fence);
+	} else {
+		dma_fence_put(submit->hw_fence);
+	}
 
 	put_pid(submit->pid);
 	msm_submitqueue_put(submit->queue);
-- 
2.41.0

