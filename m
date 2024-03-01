Return-Path: <linux-kernel+bounces-88956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC7786E8D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D9E1C22F8B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617F33A268;
	Fri,  1 Mar 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYoSTGjC"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E03A1D7;
	Fri,  1 Mar 2024 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319236; cv=none; b=IAvbPCh9a4r6l5Yq/g10lYFmzTfAwoANZKXIDTdbXEL0llslj7u+SJ72BjB2TEuXezH1LHAnezjDO/eBaf0H08q4rrULwoz7h2Evtb2hw80jyMVxSKKCt0BiK4ywvOOAk+lQZ9jlLnVNMnQdJ4VA21MPUD/Ggsdf1a1i4w+C6Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319236; c=relaxed/simple;
	bh=/ot686WqIfX6GoXRHFsDogaovQzE7mhfzlRa4JUb7I0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=It5n07fXkdNxjvFHat4IG4FQ58T0tvJ7nRjPDeEvJO7alognGf4Atqxd+a4f+qfApw8mj9ZIIJAjsod1bpE3S6adqwPqD407qX6cNttH5aAlpoxcaagw7Z2EeiMHO2XA9UcRUvsFrhFhGtz0+6NYSjK9VoVhCqZ3oJvJIIAopaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYoSTGjC; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29954bb87b4so1826886a91.2;
        Fri, 01 Mar 2024 10:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709319234; x=1709924034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yIYqiiV52DrCvcmUn0qPP1S4nB6cxKqcd4qPrzkso9I=;
        b=PYoSTGjCQjEWF92FiQtAa4fE2+ppQQvf2C4QD3p2v8B1z0syw2WkWc8iocGHW2WGGE
         zVkrVRDOaL9LvpR52P8Z15jfzbL8y7/OFhTYsIf8pdq/CKz09l65EijJPA181zFwBtj6
         lNazWHYkuDChepjodAP5Jgyo01FVgXjIpSp9hJuEhJstIkmpW+H/OdrEO2olZAl6bz7+
         5G1YFnP+El+gwlTIvuecir4k7Q+LM66hvI/acABi6G4eUbwxJRThKsUYg0VJeLuUQ/B5
         /OdF6PmH0B6d4cUMxh8jEITz87lpJQ3EqkGjxT0id8qhSeJi3WWiRO7O3ioNAw9qM1x0
         ICIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319234; x=1709924034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIYqiiV52DrCvcmUn0qPP1S4nB6cxKqcd4qPrzkso9I=;
        b=uvnX5Wl5/mUvDr+sqx6qksIxSGfYhKoKj1XYZpT1tyB2txV212r9us87TAPXZuawwW
         yfnM3Ch8v6xZFRuSIX5o87NDCtpamnMyOn3ngZmJvOhSLQYsIKD17esF/CJxXgaekB5X
         YnCZVWKEEgbezNwjDnLk4UqExV2GT/KNr2Ce4OvTYYW3ouTpWeyfO7KXRudHf/IQPl1U
         8a3cz1AH+7phyJWIaapxvfckqYBTdSNndWwe8iqTTLXW9RyLSPJSA9ABlj2BiXDQJJmk
         EJU+SmTST2/VJhDMSxSRzvutCVmAtwPUZTEfFg5CnzvCgNaEA/JPzlLDR7XQzx7vUCCg
         hIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSqZEO4LgE6UvykqqYS7t/C7pIrwG5skYo5CvKEuToAlO4FPMgDsSTPvQ6PaFZG2kcGB8KkuZQ4Uf/PSGjQAuilCcmujurf4Fmms2G
X-Gm-Message-State: AOJu0Yz7iNX32iHZtZj8mq1nznh31obKJtoiW1YOECc7vJqy0UTwurKU
	6lxgiuugtCWcXfCemH/7UPaGJI9z06Xi+Wy5CLQx0DmsietzOIAc
X-Google-Smtp-Source: AGHT+IFBLkTRqvmopJ44TtJLDd19SqEGIN2btaMvXJlxKW3m/Decir/GU7WF6Ioh8FWOIXcT9G9s9A==
X-Received: by 2002:a17:90a:bf01:b0:29a:a1c7:fc28 with SMTP id c1-20020a17090abf0100b0029aa1c7fc28mr2436127pjs.10.1709319234277;
        Fri, 01 Mar 2024 10:53:54 -0800 (PST)
Received: from localhost ([2601:1c0:5000:d5c:ae1c:de46:682a:206])
        by smtp.gmail.com with ESMTPSA id sl6-20020a17090b2e0600b0029aaabcb82asm5706114pjb.10.2024.03.01.10.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 10:53:53 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC] drm/msm: Add GPU memory traces
Date: Fri,  1 Mar 2024 10:53:45 -0800
Message-ID: <20240301185346.10412-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Perfetto can use these traces to track global and per-process GPU memory
usage.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
I realized the tracepoint that perfetto uses to show GPU memory usage
globally and per-process was already upstream, but with no users.

This overlaps a bit with fdinfo, but ftrace is a lighter weight
mechanism and fits better with perfetto (plus is already supported in
trace_processor and perfetto UI, whereas something fdinfo based would
require new code to be added in perfetto.

We could probably do this more globally (ie. drm_gem_get/put_pages() and
drm_gem_handle_create_tail()/drm_gem_object_release_handle() if folks
prefer.  Not sure where that leaves the TTM drivers.

 drivers/gpu/drm/msm/Kconfig   |  1 +
 drivers/gpu/drm/msm/msm_drv.h |  5 +++++
 drivers/gpu/drm/msm/msm_gem.c | 37 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_gpu.h |  8 ++++++++
 4 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index f202f26adab2..e4c912fcaf22 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -33,6 +33,7 @@ config DRM_MSM
 	select PM_OPP
 	select NVMEM
 	select PM_GENERIC_DOMAINS
+	select TRACE_GPU_MEM
 	help
 	  DRM/KMS driver for MSM/snapdragon.
 
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 16a7cbc0b7dd..cb8f7e804b5b 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -137,6 +137,11 @@ struct msm_drm_private {
 	struct msm_rd_state *hangrd;   /* debugfs to dump hanging submits */
 	struct msm_perf_state *perf;
 
+	/**
+	 * total_mem: Total/global amount of memory backing GEM objects.
+	 */
+	atomic64_t total_mem;
+
 	/**
 	 * List of all GEM objects (mainly for debugfs, protected by obj_lock
 	 * (acquire before per GEM object lock)
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 175ee4ab8a6f..e04c4af5d154 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -12,6 +12,9 @@
 #include <linux/pfn_t.h>
 
 #include <drm/drm_prime.h>
+#include <drm/drm_file.h>
+
+#include <trace/events/gpu_mem.h>
 
 #include "msm_drv.h"
 #include "msm_fence.h"
@@ -33,6 +36,34 @@ static bool use_pages(struct drm_gem_object *obj)
 	return !msm_obj->vram_node;
 }
 
+static void update_device_mem(struct msm_drm_private *priv, ssize_t size)
+{
+	uint64_t total_mem = atomic64_add_return(size, &priv->total_mem);
+	trace_gpu_mem_total(0, 0, total_mem);
+}
+
+static void update_ctx_mem(struct drm_file *file, ssize_t size)
+{
+	struct msm_file_private *ctx = file->driver_priv;
+	uint64_t ctx_mem = atomic64_add_return(size, &ctx->ctx_mem);
+
+	rcu_read_lock(); /* Locks file->pid! */
+	trace_gpu_mem_total(0, pid_nr(file->pid), ctx_mem);
+	rcu_read_unlock();
+
+}
+
+static int msm_gem_open(struct drm_gem_object *obj, struct drm_file *file)
+{
+	update_ctx_mem(file, obj->size);
+	return 0;
+}
+
+static void msm_gem_close(struct drm_gem_object *obj, struct drm_file *file)
+{
+	update_ctx_mem(file, -obj->size);
+}
+
 /*
  * Cache sync.. this is a bit over-complicated, to fit dma-mapping
  * API.  Really GPU cache is out of scope here (handled on cmdstream)
@@ -156,6 +187,8 @@ static struct page **get_pages(struct drm_gem_object *obj)
 			return p;
 		}
 
+		update_device_mem(dev->dev_private, obj->size);
+
 		msm_obj->pages = p;
 
 		msm_obj->sgt = drm_prime_pages_to_sg(obj->dev, p, npages);
@@ -209,6 +242,8 @@ static void put_pages(struct drm_gem_object *obj)
 			msm_obj->sgt = NULL;
 		}
 
+		update_device_mem(obj->dev->dev_private, -obj->size);
+
 		if (use_pages(obj))
 			drm_gem_put_pages(obj, msm_obj->pages, true, false);
 		else
@@ -1118,6 +1153,8 @@ static const struct vm_operations_struct vm_ops = {
 
 static const struct drm_gem_object_funcs msm_gem_object_funcs = {
 	.free = msm_gem_free_object,
+	.open = msm_gem_open,
+	.close = msm_gem_close,
 	.pin = msm_gem_prime_pin,
 	.unpin = msm_gem_prime_unpin,
 	.get_sg_table = msm_gem_prime_get_sg_table,
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 2bfcb222e353..f7d2a7d6f8cc 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -428,6 +428,14 @@ struct msm_file_private {
 	 * level.
 	 */
 	struct drm_sched_entity *entities[NR_SCHED_PRIORITIES * MSM_GPU_MAX_RINGS];
+
+	/**
+	 * ctx_mem:
+	 *
+	 * Total amount of memory of GEM buffers with handles attached for
+	 * this context.
+	 */
+	atomic64_t ctx_mem;
 };
 
 /**
-- 
2.44.0


