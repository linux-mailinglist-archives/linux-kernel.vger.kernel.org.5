Return-Path: <linux-kernel+bounces-127077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A5894679
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80CE1F22533
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFBB54FBE;
	Mon,  1 Apr 2024 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDsrDTiG"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC988480
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006437; cv=none; b=NEfGcrLOto/03E9N2IAmzWwYnhS38UvyZt3SiMl6oRjdDSkL1hge7RrYMTMXYH2fTbvHYNnDfQW3XLkD9WUjvAdXoAWsRQbXHfA4/CswVTGnjOVBfN2jdxbpHJhoKstbXjdR7QVkxSXavQR4KUDmfv9z4qE5XVpE6cVLZLft6i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006437; c=relaxed/simple;
	bh=RF6mJBnjlX0ImYSqmMVCmxSdlAQPwr/7nYBcl44ok08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZibWvjLhsVky+2TZIY3Fd99hXsVTdY/QusPCfshGMT+2JvVYAeLQ7rJTnrGRa2j2SOh6YfzHuDMbp0HgcXXJs3q3Ornif+JPIVUg8PwqK/jzjPgHqJZyrTSl16dRwy+zJn1Uxp2VYo6Fu5/TUOWdf8lnsT/N8xxPAktrQc/N6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDsrDTiG; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34356f794a5so396362f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712006434; x=1712611234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kD3x2Vpv4rRRlg0UeJbdnpqKNVktjGi2JfkyckAf+U=;
        b=ZDsrDTiG5XFzfsp1Wm2IZFtEjSpQb716QlKrZ6gtMEFG+zyZ5ZM0db0JHLyFw4L/jt
         QJoOPfIoYUDYiiLxfVoiHIAeWbeM7jSC8boto13nJam1fybJHBWMnjQoYGDTD5uT76cS
         XkLXOZJvzJiK4um9u0j4AYMFZy50H6ro84K6gUGmIe7kmPEF6Xj/HD3FDBL5Grn1BMwC
         LAnjzZiQL7/6rqinJv2EjT0/5rYVY2gqnxaBZhkobfkWfY+8IDfWWV0kkxtCbhZhx0i7
         5/7pAu4SEuAXfZo1LCmO+OklH6ZIYOh3odsA5NIlIHa6aJ3xIS4QJQy7wqw32VRmyPlJ
         mFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712006434; x=1712611234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kD3x2Vpv4rRRlg0UeJbdnpqKNVktjGi2JfkyckAf+U=;
        b=lZGE/pVLIgdZy4Vz6kd3SwvLp1w+5doM7OlK2Aq9H8abxndWKxcLvM0QQCcpBDQk0h
         hIVaa0mOk7wkv576YTXHKyosUXX23bazJ9HRzt0Pgl+18E684ZeftDPsFIas3K1WGd7c
         ulFVvasE/gEiHa9cNfh3NANRQnvPX7nJuFDvIUKRakbbvgNwYLyZVtFlCVd+mt6+DAV+
         5PRFaPEGEh5rn6DJoMBP0AlYNjDRGRXUyc9W1T6U/Zq9+B4B5FOkr+i/16+nWdaUcUOb
         +aDtuKNhC7tPlqqtl/k2hvNGF4Ok8xW2/Hzmk3CKzTF29tSEayt36+FYMEfUas4w/XE2
         qpXw==
X-Forwarded-Encrypted: i=1; AJvYcCV3yrPtWKfmCvSXjY4ktuxaXXymp10UzBjfkcT0moLjFH+WRUmiH0V+HnOitgvhkvTXi4DdfzkkqpKrorBMeKY31uu2UWgGcxqqWVNN
X-Gm-Message-State: AOJu0YzaqkTAfq/zRicTVgqD/x9kPvXeO7nlr7PzecMzyHvXGKy5dPQj
	I/zYOYTYIOzPSXkfS80FsjAgaVgKdzHPWosJ9aqg0iCg19VLBooW
X-Google-Smtp-Source: AGHT+IF+9DM2EH3iIHWHuUvHmkzQfQ0dzdotG5pPDIp6nR8wbDWj9i3ddRzNZY64OvElr9drec7iMw==
X-Received: by 2002:adf:e30d:0:b0:341:dedd:9726 with SMTP id b13-20020adfe30d000000b00341dedd9726mr8829521wrj.3.1712006433571;
        Mon, 01 Apr 2024 14:20:33 -0700 (PDT)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709061d0c00b00a4da28f42f1sm5737881ejh.177.2024.04.01.14.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:20:33 -0700 (PDT)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	anarsoul@gmail.com,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	christian.koenig@amd.com,
	megi@xff.cz,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH 1/2] drm/lima: add mask irq callback to gp and pp
Date: Mon,  1 Apr 2024 23:20:01 +0200
Message-ID: <20240401212002.1191549-2-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401212002.1191549-1-nunes.erico@gmail.com>
References: <20240401212002.1191549-1-nunes.erico@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed because we want to reset those devices in device-agnostic
code such as lima_sched.
In particular, masking irqs will be useful before a hard reset to
prevent race conditions.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_bcast.c | 12 ++++++++++++
 drivers/gpu/drm/lima/lima_bcast.h |  3 +++
 drivers/gpu/drm/lima/lima_gp.c    |  8 ++++++++
 drivers/gpu/drm/lima/lima_pp.c    | 18 ++++++++++++++++++
 drivers/gpu/drm/lima/lima_sched.c |  2 ++
 drivers/gpu/drm/lima/lima_sched.h |  1 +
 6 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_bcast.c b/drivers/gpu/drm/lima/lima_bcast.c
index fbc43f243c54..6d000504e1a4 100644
--- a/drivers/gpu/drm/lima/lima_bcast.c
+++ b/drivers/gpu/drm/lima/lima_bcast.c
@@ -43,6 +43,18 @@ void lima_bcast_suspend(struct lima_ip *ip)
 
 }
 
+int lima_bcast_mask_irq(struct lima_ip *ip)
+{
+	bcast_write(LIMA_BCAST_BROADCAST_MASK, 0);
+	bcast_write(LIMA_BCAST_INTERRUPT_MASK, 0);
+	return 0;
+}
+
+int lima_bcast_reset(struct lima_ip *ip)
+{
+	return lima_bcast_hw_init(ip);
+}
+
 int lima_bcast_init(struct lima_ip *ip)
 {
 	int i;
diff --git a/drivers/gpu/drm/lima/lima_bcast.h b/drivers/gpu/drm/lima/lima_bcast.h
index 465ee587bceb..cd08841e4787 100644
--- a/drivers/gpu/drm/lima/lima_bcast.h
+++ b/drivers/gpu/drm/lima/lima_bcast.h
@@ -13,4 +13,7 @@ void lima_bcast_fini(struct lima_ip *ip);
 
 void lima_bcast_enable(struct lima_device *dev, int num_pp);
 
+int lima_bcast_mask_irq(struct lima_ip *ip);
+int lima_bcast_reset(struct lima_ip *ip);
+
 #endif
diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
index 6b354e2fb61d..e15295071533 100644
--- a/drivers/gpu/drm/lima/lima_gp.c
+++ b/drivers/gpu/drm/lima/lima_gp.c
@@ -233,6 +233,13 @@ static void lima_gp_task_mmu_error(struct lima_sched_pipe *pipe)
 	lima_sched_pipe_task_done(pipe);
 }
 
+static void lima_gp_task_mask_irq(struct lima_sched_pipe *pipe)
+{
+	struct lima_ip *ip = pipe->processor[0];
+
+	gp_write(LIMA_GP_INT_MASK, 0);
+}
+
 static int lima_gp_task_recover(struct lima_sched_pipe *pipe)
 {
 	struct lima_ip *ip = pipe->processor[0];
@@ -365,6 +372,7 @@ int lima_gp_pipe_init(struct lima_device *dev)
 	pipe->task_error = lima_gp_task_error;
 	pipe->task_mmu_error = lima_gp_task_mmu_error;
 	pipe->task_recover = lima_gp_task_recover;
+	pipe->task_mask_irq = lima_gp_task_mask_irq;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_pp.c
index d0d2db0ef1ce..a4a2ffe6527c 100644
--- a/drivers/gpu/drm/lima/lima_pp.c
+++ b/drivers/gpu/drm/lima/lima_pp.c
@@ -429,6 +429,9 @@ static void lima_pp_task_error(struct lima_sched_pipe *pipe)
 
 		lima_pp_hard_reset(ip);
 	}
+
+	if (pipe->bcast_processor)
+		lima_bcast_reset(pipe->bcast_processor);
 }
 
 static void lima_pp_task_mmu_error(struct lima_sched_pipe *pipe)
@@ -437,6 +440,20 @@ static void lima_pp_task_mmu_error(struct lima_sched_pipe *pipe)
 		lima_sched_pipe_task_done(pipe);
 }
 
+static void lima_pp_task_mask_irq(struct lima_sched_pipe *pipe)
+{
+	int i;
+
+	for (i = 0; i < pipe->num_processor; i++) {
+		struct lima_ip *ip = pipe->processor[i];
+
+		pp_write(LIMA_PP_INT_MASK, 0);
+	}
+
+	if (pipe->bcast_processor)
+		lima_bcast_mask_irq(pipe->bcast_processor);
+}
+
 static struct kmem_cache *lima_pp_task_slab;
 static int lima_pp_task_slab_refcnt;
 
@@ -468,6 +485,7 @@ int lima_pp_pipe_init(struct lima_device *dev)
 	pipe->task_fini = lima_pp_task_fini;
 	pipe->task_error = lima_pp_task_error;
 	pipe->task_mmu_error = lima_pp_task_mmu_error;
+	pipe->task_mask_irq = lima_pp_task_mask_irq;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
index 00b19adfc888..66841503a618 100644
--- a/drivers/gpu/drm/lima/lima_sched.c
+++ b/drivers/gpu/drm/lima/lima_sched.c
@@ -422,6 +422,8 @@ static enum drm_gpu_sched_stat lima_sched_timedout_job(struct drm_sched_job *job
 	 */
 	for (i = 0; i < pipe->num_processor; i++)
 		synchronize_irq(pipe->processor[i]->irq);
+	if (pipe->bcast_processor)
+		synchronize_irq(pipe->bcast_processor->irq);
 
 	if (dma_fence_is_signaled(task->fence)) {
 		DRM_WARN("%s unexpectedly high interrupt latency\n", lima_ip_name(ip));
diff --git a/drivers/gpu/drm/lima/lima_sched.h b/drivers/gpu/drm/lima/lima_sched.h
index 6bd4f3b70109..85b23ba901d5 100644
--- a/drivers/gpu/drm/lima/lima_sched.h
+++ b/drivers/gpu/drm/lima/lima_sched.h
@@ -80,6 +80,7 @@ struct lima_sched_pipe {
 	void (*task_error)(struct lima_sched_pipe *pipe);
 	void (*task_mmu_error)(struct lima_sched_pipe *pipe);
 	int (*task_recover)(struct lima_sched_pipe *pipe);
+	void (*task_mask_irq)(struct lima_sched_pipe *pipe);
 
 	struct work_struct recover_work;
 };
-- 
2.44.0


