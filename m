Return-Path: <linux-kernel+bounces-128752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34E5895EF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436621F21F76
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B964415E81E;
	Tue,  2 Apr 2024 21:54:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223912BF20
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094878; cv=none; b=ZtqfawcLCyszVdLxLXhp4R5RqsFv6uWQ18RdeRQYP1CAwDJHzXENvJkYjTJ5VG0jd4OySFAdimB86hLOhpvVbF5pZSzV9e6zwUo9pUcUX8YFHPZLO8E08mSlBon8AZvA70TeBFnDQioOb6wkC/lrzOWu++zFA+2XlhxxmDe9GTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094878; c=relaxed/simple;
	bh=MKPb+hzheT2qhKVcwQcQsv1QO6c8TYF+OIyBnug0k5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OhNACGUvK5kfkDfzEzTS3M6dYvIo3ZyT1SoxGPG29fIxnpdGh8KZZdj7A69pM1ddU3wNOdmc9bN290eC5JqbrcegUgCZgyjyqhPgCTG+Tqd5Bp8KvBL22GhcgPRAo1MRMJoFGJDgPbTJp4y7FQcQm78PEL1Pp6kpclat+2Ls1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73ECA1042;
	Tue,  2 Apr 2024 14:55:06 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37C083F7B4;
	Tue,  2 Apr 2024 14:54:34 -0700 (PDT)
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Steven Price <steven.price@arm.com>
Subject: [PATCH 2/2] drm/panthor: Fix some kerneldoc warnings
Date: Tue,  2 Apr 2024 22:54:23 +0100
Message-ID: <20240402215423.360341-2-liviu.dudau@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402215423.360341-1-liviu.dudau@arm.com>
References: <20240402215423.360341-1-liviu.dudau@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When compiling with W=1 the build process will flag empty comments,
misnamed documented variables and incorrect tagging of functions.
Fix them in one go.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index e5a710f190d2a8..a787f2fea33e98 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -517,7 +517,7 @@ struct panthor_group {
 	/** @max_compute_cores: Maximum number of shader cores used for compute jobs. */
 	u8 max_compute_cores;
 
-	/** @max_compute_cores: Maximum number of shader cores used for fragment jobs. */
+	/** @max_fragment_cores: Maximum number of shader cores used for fragment jobs. */
 	u8 max_fragment_cores;
 
 	/** @max_tiler_cores: Maximum number of tiler cores used for tiler jobs. */
@@ -993,7 +993,7 @@ cs_slot_prog_locked(struct panthor_device *ptdev, u32 csg_id, u32 cs_id)
 }
 
 /**
- * @cs_slot_reset_locked() - Reset a queue slot
+ * cs_slot_reset_locked() - Reset a queue slot
  * @ptdev: Device.
  * @csg_id: Group slot.
  * @cs_id: Queue slot.
@@ -1591,7 +1591,7 @@ static void sched_process_idle_event_locked(struct panthor_device *ptdev)
 }
 
 /**
- * panthor_sched_process_global_irq() - Process the scheduling part of a global IRQ
+ * sched_process_global_irq_locked() - Process the scheduling part of a global IRQ
  * @ptdev: Device.
  */
 static void sched_process_global_irq_locked(struct panthor_device *ptdev)
@@ -1660,8 +1660,6 @@ static const struct dma_fence_ops panthor_queue_fence_ops = {
 	.get_timeline_name = queue_fence_get_timeline_name,
 };
 
-/**
- */
 struct panthor_csg_slots_upd_ctx {
 	u32 update_mask;
 	u32 timedout_mask;
-- 
2.44.0


