Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5446E805E42
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345413AbjLETCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLETCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:02:32 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C156C0;
        Tue,  5 Dec 2023 11:02:39 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ce7c1b07e1so503776b3a.2;
        Tue, 05 Dec 2023 11:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701802958; x=1702407758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gr71sNINRYPArpI+CNr5Fv+CLv1NDL4SnaWZ3f+C3cc=;
        b=VGTyqItAKaJJ121VxwJgMSOYSwDBSM1hsX9x5Lfign6yRXzCDK+EX3nhdm57ZpxAp+
         Y7Uj7495reVgDdusIl72X8E2wRHkDMfbx3gpLgd2ykd8W71kZdq9pKYUFoTjTX06OC9P
         bDSuhgwbh3NK47ISaCUiP01w6rNaqyKU1m6giMTQMJ89VxrR8zkVC4O9o3Ao5GIaLeRq
         kV7E8npIDa+WPmpS1tJ0GFAtJeqxIZeEof6zFmxY1+VV573xElwO2EW36OjJGFA3gj2X
         /4VDgRAi59RQcogoEqK3tAFcznVLs4fnY2vlFbtBGUPufqfm0WA8wou9q2ufhQwkTuyM
         vN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701802958; x=1702407758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gr71sNINRYPArpI+CNr5Fv+CLv1NDL4SnaWZ3f+C3cc=;
        b=mdTpePcADzD0gBBUP9Wte+R9cFY+glvUCcRWU6HjlAUpE0VHEIyhTxr9B2LysePfqQ
         648odZ9v52TptvUc75f5/QjXIi9WH+r+e3i2G7MH71lzK66t22rSjXSW4xf5LBiyRMeg
         u537GsoCtphrxFqgw2oX0K4jFgiZvVd8F7C8XxeVj4vdvunFSnKnd65HmVhFoanGPQSf
         EwVqdI+kZDoZXLqUjtLMOtcyklulUgWouF4gJfrO7YrKc/rzWEmrz2ctccAjHZybwUOF
         UE9FXzDQg6sCSDXuin+BhIa/FzmpL08S9HWCXKF+zeF9bJu4ynK0zl/zgPuKHUq9Wc3q
         4xPQ==
X-Gm-Message-State: AOJu0Yy8XWmiCSzhqHSDYgPsEoQEh57oybkiEubkwbyxiEgUNmUU73Xi
        H/XysRtojuUyPyeOmMByRFg=
X-Google-Smtp-Source: AGHT+IHU2ya8bSn4bAfwtnCaBXtL2UTM+QfuRrIn5PJLt281Wya4plXg44RgEht3EFWm/rTyANJk7g==
X-Received: by 2002:a05:6a00:1806:b0:6ce:3f02:10a3 with SMTP id y6-20020a056a00180600b006ce3f0210a3mr2331731pfa.8.1701802958385;
        Tue, 05 Dec 2023 11:02:38 -0800 (PST)
Received: from localhost ([2a00:79e1:2e00:1301:e1c5:6354:b45d:8ffc])
        by smtp.gmail.com with ESMTPSA id r14-20020aa7844e000000b006ce467a2489sm4867944pfn.175.2023.12.05.11.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 11:02:37 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Luben Tuikov <ltuikov89@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING
        FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b)
Subject: [PATCH] drm/scheduler: Unwrap job dependencies
Date:   Tue,  5 Dec 2023 11:02:33 -0800
Message-ID: <20231205190234.371322-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Container fences have burner contexts, which makes the trick to store at
most one fence per context somewhat useless if we don't unwrap array or
chain fences.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 47 ++++++++++++++++++--------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 9762464e3f99..16b550949c57 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -52,6 +52,7 @@
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/completion.h>
+#include <linux/dma-fence-unwrap.h>
 #include <linux/dma-resv.h>
 #include <uapi/linux/sched/types.h>
 
@@ -684,27 +685,14 @@ void drm_sched_job_arm(struct drm_sched_job *job)
 }
 EXPORT_SYMBOL(drm_sched_job_arm);
 
-/**
- * drm_sched_job_add_dependency - adds the fence as a job dependency
- * @job: scheduler job to add the dependencies to
- * @fence: the dma_fence to add to the list of dependencies.
- *
- * Note that @fence is consumed in both the success and error cases.
- *
- * Returns:
- * 0 on success, or an error on failing to expand the array.
- */
-int drm_sched_job_add_dependency(struct drm_sched_job *job,
-				 struct dma_fence *fence)
+static int drm_sched_job_add_single_dependency(struct drm_sched_job *job,
+					       struct dma_fence *fence)
 {
 	struct dma_fence *entry;
 	unsigned long index;
 	u32 id = 0;
 	int ret;
 
-	if (!fence)
-		return 0;
-
 	/* Deduplicate if we already depend on a fence from the same context.
 	 * This lets the size of the array of deps scale with the number of
 	 * engines involved, rather than the number of BOs.
@@ -728,6 +716,35 @@ int drm_sched_job_add_dependency(struct drm_sched_job *job,
 
 	return ret;
 }
+
+/**
+ * drm_sched_job_add_dependency - adds the fence as a job dependency
+ * @job: scheduler job to add the dependencies to
+ * @fence: the dma_fence to add to the list of dependencies.
+ *
+ * Note that @fence is consumed in both the success and error cases.
+ *
+ * Returns:
+ * 0 on success, or an error on failing to expand the array.
+ */
+int drm_sched_job_add_dependency(struct drm_sched_job *job,
+				 struct dma_fence *fence)
+{
+	struct dma_fence_unwrap iter;
+	struct dma_fence *f;
+	int ret = 0;
+
+	dma_fence_unwrap_for_each (f, &iter, fence) {
+		dma_fence_get(f);
+		ret = drm_sched_job_add_single_dependency(job, f);
+		if (ret)
+			break;
+	}
+
+	dma_fence_put(fence);
+
+	return ret;
+}
 EXPORT_SYMBOL(drm_sched_job_add_dependency);
 
 /**
-- 
2.42.0

