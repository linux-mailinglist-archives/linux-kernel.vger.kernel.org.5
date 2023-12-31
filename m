Return-Path: <linux-kernel+bounces-13640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC708209D8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 06:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7E2283220
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 05:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A89433CA;
	Sun, 31 Dec 2023 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FbMBJWTr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FD7320A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=sbB7maGQ0Pjc+3G4bBvIiBwsq0OWbX3og3kP0LcQmcI=; b=FbMBJWTrPqZ6TYlnXhNUY0iffg
	1JTkmY8htlvL1T1oRw2cAd3VWwTX55srLRdoHdu4jRByDa6nlXIstmpxGbjSp2gXhKR9kdX9PTF0f
	CHdKjqFcsWQdekYafPCINPaJTZRpS3opF+PTwD2i3gegeyWQY0XbG3w2/oO/zNXPOhZ98M6Yk2Lk6
	gelxjJ55FPmAHRwXnKxdUgjNmYTNfCLTsw684Sap69QPrDyueHp7UVa2kvszpf9AHqMdFkMNQJjDY
	YOH2EzkwxzM1qKgSETH8ZI8yGPoHGO8/gS0oucBWTIdYaXjk8wPjUCsDB6IPe7L0m/emIk4VScubq
	23MrwtMg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rJohD-0041cE-1I;
	Sun, 31 Dec 2023 05:49:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Frank Binns <frank.binns@imgtec.com>,
	Donald Robson <donald.robson@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Jonathan Corbet <corbet@lwn.net>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH] drm/imagination: pvr_device.h: fix all kernel-doc warnings
Date: Sat, 30 Dec 2023 21:49:10 -0800
Message-ID: <20231231054910.31805-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct all kernel-doc notation on pvr_device.h so that there are no
kernel-doc warnings remaining.

pvr_device.h:292: warning: Excess struct member 'active' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'idle' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'lock' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'work' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'old_kccb_cmds_executed' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'kccb_stall_count' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'ccb' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'rtn_q' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'rtn_obj' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'rtn' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'slot_count' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'reserved_count' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'waiters' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'fence_ctx' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'id' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'seqno' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'lock' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'active' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'idle' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'lock' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'work' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'old_kccb_cmds_executed' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'kccb_stall_count' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'ccb' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'rtn_q' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'rtn_obj' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'rtn' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'slot_count' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'reserved_count' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'waiters' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'fence_ctx' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'id' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'seqno' description in 'pvr_device'
pvr_device.h:292: warning: Excess struct member 'lock' description in 'pvr_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Frank Binns <frank.binns@imgtec.com>
Cc: Donald Robson <donald.robson@imgtec.com>
Cc: Matt Coster <matt.coster@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/gpu/drm/imagination/pvr_device.h |   46 +++++++++++----------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff -- a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -193,13 +193,14 @@ struct pvr_device {
 	 * @queues: Queue-related fields.
 	 */
 	struct {
-		/** @active: Active queue list. */
+		/** @queues.active: Active queue list. */
 		struct list_head active;
 
-		/** @idle: Idle queue list. */
+		/** @queues.idle: Idle queue list. */
 		struct list_head idle;
 
-		/** @lock: Lock protecting access to the active/idle lists. */
+		/** @queues.lock: Lock protecting access to the active/idle
+		 *  lists. */
 		struct mutex lock;
 	} queues;
 
@@ -207,18 +208,18 @@ struct pvr_device {
 	 * @watchdog: Watchdog for communications with firmware.
 	 */
 	struct {
-		/** @work: Work item for watchdog callback. */
+		/** @watchdog.work: Work item for watchdog callback. */
 		struct delayed_work work;
 
 		/**
-		 * @old_kccb_cmds_executed: KCCB command execution count at last
-		 * watchdog poll.
+		 * @watchdog.old_kccb_cmds_executed: KCCB command execution
+		 * count at last watchdog poll.
 		 */
 		u32 old_kccb_cmds_executed;
 
 		/**
-		 * @kccb_stall_count: Number of watchdog polls KCCB has been
-		 * stalled for.
+		 * @watchdog.kccb_stall_count: Number of watchdog polls
+		 * KCCB has been stalled for.
 		 */
 		u32 kccb_stall_count;
 	} watchdog;
@@ -227,43 +228,46 @@ struct pvr_device {
 	 * @kccb: Circular buffer for communications with firmware.
 	 */
 	struct {
-		/** @ccb: Kernel CCB. */
+		/** @kccb.ccb: Kernel CCB. */
 		struct pvr_ccb ccb;
 
-		/** @rtn_q: Waitqueue for KCCB command return waiters. */
+		/** @kccb.rtn_q: Waitqueue for KCCB command return waiters. */
 		wait_queue_head_t rtn_q;
 
-		/** @rtn_obj: Object representing KCCB return slots. */
+		/** @kccb.rtn_obj: Object representing KCCB return slots. */
 		struct pvr_fw_object *rtn_obj;
 
 		/**
-		 * @rtn: Pointer to CPU mapping of KCCB return slots. Must be
-		 * accessed by READ_ONCE()/WRITE_ONCE().
+		 * @kccb.rtn: Pointer to CPU mapping of KCCB return slots.
+		 * Must be accessed by READ_ONCE()/WRITE_ONCE().
 		 */
 		u32 *rtn;
 
-		/** @slot_count: Total number of KCCB slots available. */
+		/** @kccb.slot_count: Total number of KCCB slots available. */
 		u32 slot_count;
 
-		/** @reserved_count: Number of KCCB slots reserved for future use. */
+		/** @kccb.reserved_count: Number of KCCB slots reserved for
+		 *  future use. */
 		u32 reserved_count;
 
 		/**
-		 * @waiters: List of KCCB slot waiters.
+		 * @kccb.waiters: List of KCCB slot waiters.
 		 */
 		struct list_head waiters;
 
-		/** @fence_ctx: KCCB fence context. */
+		/** @kccb.fence_ctx: KCCB fence context. */
 		struct {
-			/** @id: KCCB fence context ID allocated with dma_fence_context_alloc(). */
+			/** @kccb.fence_ctx.id: KCCB fence context ID
+			 *  allocated with dma_fence_context_alloc(). */
 			u64 id;
 
-			/** @seqno: Sequence number incremented each time a fence is created. */
+			/** @kccb.fence_ctx.seqno: Sequence number incremented
+			 *  each time a fence is created. */
 			atomic_t seqno;
 
 			/**
-			 * @lock: Lock used to synchronize access to fences allocated by this
-			 * context.
+			 * @kccb.fence_ctx.lock: Lock used to synchronize
+			 * access to fences allocated by this context.
 			 */
 			spinlock_t lock;
 		} fence_ctx;

