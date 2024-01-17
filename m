Return-Path: <linux-kernel+bounces-28493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35FE82FF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C268289D49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BDABA29;
	Wed, 17 Jan 2024 03:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxuGW0P3"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E3883C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705461146; cv=none; b=lRFOy9om0A8v036c8+vpG4lnT3WvBp9wqpqnHJQ/Zkcx3HdHokAGDUHlCq9y/DUVJyJXbZrBkj4zYr9fXIgVtJqgSo07wr33YK5GRFp8L79ZZkhRJn7UnYb3jEz5IY+e5O6G7n/PqKZsC/NdHQkTM/Sz+gcICU0XQ1KeGMdHoNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705461146; c=relaxed/simple;
	bh=o8hW3J2/oOQV2jYyvMuhZMTvx2GwUSDxyrpGj6TLrhA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=oUYxB3l6G1zIYfeDtC+A1gOKEwnoXTLfqvTncLXKVSChQZlisVz/Xq5fdzV3gY2V/ioxueKI2G1gG1VEVr3LP8v/jXlmWKzJRyEQxBne8KQHsBAcONUgalOwLSWB7MIl6MCucDBQ4X0bOu3QW9vMNxw99Y0i3FSW/pfGPlwEM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxuGW0P3; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd8b64a52dso63005881fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705461143; x=1706065943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wbzi3EnFlPT7VHx8X0cPGf7wGavBuju6JI8nYElqQU=;
        b=HxuGW0P3uL8rySgqRYtcsPoHYMX4Mk80V03NoqJWWHRbHeVNQRqlhzkRbRTPd2FALY
         rV1D7EZibTxfyBP9cAeXMflnr4q/VC9+jmorJIHhMvrOTXenbcj6et+eqC4S8z3IryfJ
         wg7GIIWwKwtHonPSjafonmJ1oNC78oHJFsBVTKlltNljuRswIZdqrq29We0pNRRvXohZ
         rDL7YmlM6njcYvMAsdoC6AvWH3rGY0oX192Sl2XjMVqEFParJ5oR3B/8RZRqQxRqsHlq
         Gux5AERYzj2AIzfWRswYndpQC1M+SdWq7Wmi1gCGXvD4fxPhRbU2SxFUXSgiGbIsZJ3J
         rsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705461143; x=1706065943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wbzi3EnFlPT7VHx8X0cPGf7wGavBuju6JI8nYElqQU=;
        b=jkUnX6vv4ey9br0uBI4JgJCR/RQeMo/FYF+Ws4JG3gIGgJJYZBPh6Ya+gDuEJGjUiq
         N/srNNlXrQ0UREpmbkLVykViSKPy/D1zTgS/TauKJlKmyKLSTjurDAlmRIMKX7BxN02A
         +k02pbioDlapnkq1rd8OH/TSRuBU3W/6YX8lMCzvzyRmuHg8x6q21dRVhJ/3Qs9kcSgD
         FNHncNzf+Sud3mwbH6LrloaTVxokJYZ9PyJvbyYHumTZUJc5QL1pMf5Px9SaoU64r4YF
         FJNkBUGySbzFRr75VJnFpOM8P0NyFQ76QZtNjTHIwbTuEevOT9779/XYb+M1NacG89ru
         tu4w==
X-Gm-Message-State: AOJu0YxO5h/6yBvltwYPNEIJ4mMWZKiia2pA2OEjnMdZ8MtVE3fdpyO3
	sXPnnO7ZThF2OrqUWqj5RCU=
X-Google-Smtp-Source: AGHT+IELPdudRcRB5rbBm58TIPpk4jrqXQSMiUsaBUYpCfikolg1o0C7SeNXHZ8nFtI+R+1PiVTd0g==
X-Received: by 2002:a2e:978a:0:b0:2cd:2838:78d with SMTP id y10-20020a2e978a000000b002cd2838078dmr3639516lji.63.1705461143092;
        Tue, 16 Jan 2024 19:12:23 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640204cd00b0055971af7a23sm2258418edw.95.2024.01.16.19.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 19:12:22 -0800 (PST)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: anarsoul@gmail.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	christian.koenig@amd.com,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH v1 4/6] drm/lima: handle spurious timeouts due to high irq latency
Date: Wed, 17 Jan 2024 04:12:10 +0100
Message-ID: <20240117031212.1104034-5-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117031212.1104034-1-nunes.erico@gmail.com>
References: <20240117031212.1104034-1-nunes.erico@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are several unexplained and unreproduced cases of rendering
timeouts with lima, for which one theory is high IRQ latency coming from
somewhere else in the system.
This kind of occurrence may cause applications to trigger unnecessary
resets of the GPU or even applications to hang if it hits an issue in
the recovery path.
Panfrost already does some special handling to account for such
"spurious timeouts", it makes sense to have this in lima too to reduce
the chance that it hit users.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_sched.c | 32 ++++++++++++++++++++++++++-----
 drivers/gpu/drm/lima/lima_sched.h |  2 ++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 66317296d831..9449b81bcd5b 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR MIT
 /* Copyright 2017-2019 Qiang Yu <yuq825@gmail.com> */
 
+#include <linux/hardirq.h>
 #include <linux/iosys-map.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
@@ -223,10 +224,7 @@ static struct dma_fence *lima_sched_run_job(struct drm_sched_job *job)
 
 	task->fence = &fence->base;
 
-	/* for caller usage of the fence, otherwise irq handler
-	 * may consume the fence before caller use it
-	 */
-	dma_fence_get(task->fence);
+	task->done_fence = dma_fence_get(task->fence);
 
 	pipe->current_task = task;
 
@@ -401,9 +399,33 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
 	struct lima_sched_pipe *pipe = to_lima_pipe(job->sched);
 	struct lima_sched_task *task = to_lima_task(job);
 	struct lima_device *ldev = pipe->ldev;
+	struct lima_ip *ip = pipe->processor[0];
+
+	/*
+	 * If the GPU managed to complete this jobs fence, the timeout is
+	 * spurious. Bail out.
+	 */
+	if (dma_fence_is_signaled(task->done_fence)) {
+		DRM_WARN("%s spurious timeout\n", lima_ip_name(ip));
+		return DRM_GPU_SCHED_STAT_NOMINAL;
+	}
+
+	/*
+	 * Lima IRQ handler may take a long time to process an interrupt
+	 * if there is another IRQ handler hogging the processing.
+	 * In order to catch such cases and not report spurious Lima job
+	 * timeouts, synchronize the IRQ handler and re-check the fence
+	 * status.
+	 */
+	synchronize_irq(ip->irq);
+
+	if (dma_fence_is_signaled(task->done_fence)) {
+		DRM_WARN("%s unexpectedly high interrupt latency\n", lima_ip_name(ip));
+		return DRM_GPU_SCHED_STAT_NOMINAL;
+	}
 
 	if (!pipe->error)
-		DRM_ERROR("lima job timeout\n");
+		DRM_ERROR("%s lima job timeout\n", lima_ip_name(ip));
 
 	drm_sched_stop(&pipe->base, &task->base);
 
diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/lima_sched.h
index 6a11764d87b3..34050facb110 100644
--- a/drivers/gpu/drm/lima/lima_sched.h
+++ b/drivers/gpu/drm/lima/lima_sched.h
@@ -29,6 +29,8 @@ struct lima_sched_task {
 	bool recoverable;
 	struct lima_bo *heap;
 
+	struct dma_fence *done_fence;
+
 	/* pipe fence */
 	struct dma_fence *fence;
 };
-- 
2.43.0


