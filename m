Return-Path: <linux-kernel+bounces-36374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44396839FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FE91F22D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9789BF9C1;
	Wed, 24 Jan 2024 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmHwAlz8"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97DC158
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065216; cv=none; b=leuRoMt+gGMtpOapvYRGHVdng2PHHJqgqtDoGVoN4ErKKD0D/WWE7ORil/6BpFTWPhedcld/X5jBEDMxzEPxqpneosG4iEhWJF7tZQxlfV222xKnMMceNrsDKPqDhCqfmnzeKXvgAB7ER7Uw6d9hm8nVJ1J2+MC8x/+zZdawOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065216; c=relaxed/simple;
	bh=kU8GnjmVHoPQSpbhEVkW73vEGzbs7ySfOs49yLSu1c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIl+yNRy+Vpl2x9/nJOaPEE8xcOLyoJGQ1gLMhdzZV8va73CJgYP3ciu62U83Ruhg+4zeGIVlcyj0rivHoBFrprjNyA+1NPjn8JinlVKW/NMGA8Vj8Ma1VylpBJUd24eonbzgP99GPGocxO61Y1D202PQOF9hKQEqSLqV+GFn+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmHwAlz8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so55373355e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706065213; x=1706670013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opZYreiEG2AcFzWD38eEu/SQH9nltnXulQyDLOx9jXo=;
        b=cmHwAlz8nwXXrZYhK4uXlwICZmrwaNMxA0xv8ZBlQEADPDQFPkKls+PVMeUEvzgx/9
         ntlRSkhjST7kQn1a1stjN8YyXLXh2G6APiG3TZ3XPiXw95u3oGjdT/OSV9JFUEoda2KO
         dYAL6nK0Ow4k9/3O7sU8KQh0MOTENae92s82ShOf4cuZhTwXpIG10DCD3MMTQDC/FsRt
         fSTtz9JZSfdQATZZaxtK2O1OsqzNwHiTAgFr5R+7IwD46AcH1ON2yFyTqe6bxJs5bq1E
         aDTeEh7zIF0SdP8U8SwVHZasDRDA7CaFsGVKN3x/vrXPXw+y+fXYr4gzM/hr0/KeoqWS
         HaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065213; x=1706670013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opZYreiEG2AcFzWD38eEu/SQH9nltnXulQyDLOx9jXo=;
        b=PcPg85rjFS5l1KgWdzaeAZnWNFIKa2Brka0wHKfaL+OAdf4e0n4RtYThQv2l60NHlu
         OKWYCt5J4iUw5CJu6dopVJ9VMNwDZ0K2HoSzJRLwkIiOHXvTGOfwKLhZmPLDfIonurEp
         Slo+eMmx1DIUw6wiv73Lz7DqAkkec2QyiAHLYDmHRWw4Bq2UBMrnCviPNhh9mF9QyzSX
         gq6s49xoHyGuOPqcquVCdWh4E0VXmBOujYPSFFiBGKnNgQkMO9SBALweKdYQkV8+hCOP
         xORFQiibunwhwH+AkJ+KR5s6NZEU2mtyGx77G1Se/oWkO6ZsBN0/KmdU9GeMP9rZ6Q6m
         Hz5A==
X-Gm-Message-State: AOJu0Yx0+H8Zvqd6OnTcRjYM4kpuMbkvKLcJ+p/thZ1BbOFz17BW4B7d
	3/g6C8OwSkvkeNENG8xF4fQdNUv7fLulJ+qfSMN9O0QzS5sTS2qL
X-Google-Smtp-Source: AGHT+IFSHthVhbNG0Qfb0DDYrPsBvJwa1h3gBSGkCx5GOfjIWDgE++7W0fC/TiEr/1O0wANexbQlPQ==
X-Received: by 2002:a05:600c:1705:b0:40e:ab2a:25a0 with SMTP id c5-20020a05600c170500b0040eab2a25a0mr683615wmn.181.1706065213437;
        Tue, 23 Jan 2024 19:00:13 -0800 (PST)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id dj17-20020a05640231b100b00559bb146ecbsm9637914edb.6.2024.01.23.19.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 19:00:12 -0800 (PST)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	anarsoul@gmail.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH v2 5/8] drm/lima: handle spurious timeouts due to high irq latency
Date: Wed, 24 Jan 2024 03:59:44 +0100
Message-ID: <20240124025947.2110659-6-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124025947.2110659-1-nunes.erico@gmail.com>
References: <20240124025947.2110659-1-nunes.erico@gmail.com>
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
 drivers/gpu/drm/lima/lima_sched.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index c3bf8cda8498..814428564637 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR MIT
 /* Copyright 2017-2019 Qiang Yu <yuq825@gmail.com> */
 
+#include <linux/hardirq.h>
 #include <linux/iosys-map.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
@@ -401,9 +402,35 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
 	struct lima_sched_pipe *pipe = to_lima_pipe(job->sched);
 	struct lima_sched_task *task = to_lima_task(job);
 	struct lima_device *ldev = pipe->ldev;
+	struct lima_ip *ip = pipe->processor[0];
+	int i;
+
+	/*
+	 * If the GPU managed to complete this jobs fence, the timeout is
+	 * spurious. Bail out.
+	 */
+	if (dma_fence_is_signaled(task->fence)) {
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
+	for (i = 0; i < pipe->num_processor; i++)
+		synchronize_irq(pipe->processor[i]->irq);
+
+	if (dma_fence_is_signaled(task->fence)) {
+		DRM_WARN("%s unexpectedly high interrupt latency\n", lima_ip_name(ip));
+		return DRM_GPU_SCHED_STAT_NOMINAL;
+	}
 
 	if (!pipe->error)
-		DRM_ERROR("lima job timeout\n");
+		DRM_ERROR("%s job timeout\n", lima_ip_name(ip));
 
 	drm_sched_stop(&pipe->base, &task->base);
 
@@ -417,8 +444,6 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
 	if (pipe->bcast_mmu)
 		lima_mmu_page_fault_resume(pipe->bcast_mmu);
 	else {
-		int i;
-
 		for (i = 0; i < pipe->num_mmu; i++)
 			lima_mmu_page_fault_resume(pipe->mmu[i]);
 	}
-- 
2.43.0


