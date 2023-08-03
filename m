Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8B476F56F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjHCWDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjHCWCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:02:52 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F230C49E6;
        Thu,  3 Aug 2023 15:02:35 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-564b326185bso287439a12.2;
        Thu, 03 Aug 2023 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691100155; x=1691704955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMDPDTveGL0XcUxjW8MDNhSNAkJwzlTE+WboD+rmGEU=;
        b=K5i3GJH74VyDW/Jnmr2wdrMdRA/gKgvGuAvzOT8myorsO3NeQaBOBreJNBjYoNQWNg
         uzoHb2SP+NRSGHO7/22vPzxXQV+u8VN76aNFfqtsNOH1UumHIyncxW/opHtvgwLqAhGv
         C6O52woALbRk0uYz3G0YUjWZrJKL86vzOlH4m2uEdRh8JfyoslqeDVIb4+PGbuPaxl5f
         DsoYpsylrR0sfvi7OsSDYYhOjiWlTjFqF5ByTmRbfsDV2I/dZ2tdGz+iIptnSarAUdAC
         a4TV+bBzWzsO44QV8hF3UQ/LK7fLhxNs8xs7ym/47qJspRqsZDpqStaRtavsfzElDyXx
         NSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691100155; x=1691704955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMDPDTveGL0XcUxjW8MDNhSNAkJwzlTE+WboD+rmGEU=;
        b=dq06Hi+7DMRP//QyuuhamYjuvarGYMG+WMKeSMNk2DvBZQLPm0eHKHVFzE6NxemC63
         cpbZw1XayUCpnyuK7FTDTMpB1nsaYQUny48Z511EWbS1RkP28L9FWmFYtzibWsJfjDJ/
         fgWIJALVRabuKd1rLNaU5AypTYlsqwRqqa0chtUtcs3Oeppp6x1feILb4CCQJJVWzgzM
         JwZvF6vb7O23383TeJTDj1GqOrd0cb4ePJys6ZSst1V0GtVOzWOjsgDMotMh+EbjsgtV
         RYlfNmC8/RVsnNIoOw0YeFVzcKt37quJvr6iQZlI16Zkp9KHXNTkel+rmSnpyqQ5lkjy
         rWrA==
X-Gm-Message-State: AOJu0YwCv5V9yU3kZuub8zYPw2aUnSAnXqEI0UQkVMEgoe/6h8Fx5UKs
        mnL4X8+331tC49sMfWblHlE=
X-Google-Smtp-Source: AGHT+IGxaayfkSbW7gr+exgp8ER/palrd0d4li5a+dZz8brgaJjEo3IxY3Az+mnAuhnhmiF9IO4AzQ==
X-Received: by 2002:a17:90a:9482:b0:268:23d7:21c with SMTP id s2-20020a17090a948200b0026823d7021cmr8394pjo.30.1691100155002;
        Thu, 03 Aug 2023 15:02:35 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a654300b002641a9faa01sm2946613pjs.52.2023.08.03.15.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 15:02:34 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <luben.tuikov@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 8/9] drm/sched: Add (optional) fence signaling annotation
Date:   Thu,  3 Aug 2023 15:01:56 -0700
Message-ID: <20230803220202.78036-9-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803220202.78036-1-robdclark@gmail.com>
References: <20230803220202.78036-1-robdclark@gmail.com>
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

Based on
https://lore.kernel.org/dri-devel/20200604081224.863494-10-daniel.vetter@ffwll.ch/
but made to be optional.

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 9 +++++++++
 include/drm/gpu_scheduler.h            | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 7b2bfc10c1a5..b0368b815ff5 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1005,10 +1005,15 @@ static bool drm_sched_blocked(struct drm_gpu_scheduler *sched)
 static int drm_sched_main(void *param)
 {
 	struct drm_gpu_scheduler *sched = (struct drm_gpu_scheduler *)param;
+	const bool fence_signalling = sched->fence_signalling;
+	bool fence_cookie;
 	int r;
 
 	sched_set_fifo_low(current);
 
+	if (fence_signalling)
+		fence_cookie = dma_fence_begin_signalling();
+
 	while (!kthread_should_stop()) {
 		struct drm_sched_entity *entity = NULL;
 		struct drm_sched_fence *s_fence;
@@ -1064,6 +1069,10 @@ static int drm_sched_main(void *param)
 
 		wake_up(&sched->job_scheduled);
 	}
+
+	if (fence_signalling)
+		dma_fence_end_signalling(fence_cookie);
+
 	return 0;
 }
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index e95b4837e5a3..58d958ad31a1 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -493,6 +493,7 @@ struct drm_sched_backend_ops {
  * @ready: marks if the underlying HW is ready to work
  * @free_guilty: A hit to time out handler to free the guilty job.
  * @dev: system &struct device
+ * @fence_signalling: Opt in to fence signalling annotations
  *
  * One scheduler is implemented for each hardware ring.
  */
@@ -517,6 +518,7 @@ struct drm_gpu_scheduler {
 	bool				ready;
 	bool				free_guilty;
 	struct device			*dev;
+	bool 				fence_signalling;
 };
 
 int drm_sched_init(struct drm_gpu_scheduler *sched,
-- 
2.41.0

