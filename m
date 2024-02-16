Return-Path: <linux-kernel+bounces-69126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870568584DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF87C1F21526
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7382D138491;
	Fri, 16 Feb 2024 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlKqpYad"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E51137C28
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106790; cv=none; b=hGcmYtJidvzlzq4xQvgirOZsU66581OVY0Oiar3PWHnNW/BgtaDmLooLJAp7ou9Om88JJUAFJX4eCTTfIEmnR5nc9aMuvqst/LGIrutET4Mk7ADj9bqmUCWSd47QYM9Jl/Hj+98tY/h5TRE6tTK+lqcppMiSPrh1W1SlX9p4ryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106790; c=relaxed/simple;
	bh=ylqgSgPh9dnX0Y5CbOgQcNyBm4zxKG0QVJ5yrKucFnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heJTQJAJZpeyN76/iHDwLjbrbnxJdu6VMDggTQ72pgEy/KiR6O8GoDWFo1fHFVQ4NBDkKlIVYz+aI98PEv89EPka0TOJ09QaNjNdY/+SsRE5Ycqa7VFCJeVT3lupTeko6CFHUveD+pzgsUbJntm2s6JXNLRmJHtgvYMvzTVJwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlKqpYad; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e10303de41so989154b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106788; x=1708711588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWQ++TfiXPPbsr6vtxYlRZHmraPzLnchssMNAsSwn3w=;
        b=QlKqpYadqdu1OE0HXevKB/xzBHYXZJZw215R7IbTPkTMm6n+5QI8HdlXukJznp6oQX
         vQNyoWjGF4UW33BmF9a4VM1+snohEsHnoZSADVJ+vdRzwcMoN11k7aeXUgoHI6FuJmd7
         reXZ3wjO/IYMBw66xlMtBQSsIpxOHWcUpm0ig7FQoa3kCjzNKI6tzLYmSMzO6i9QimPv
         bijzNAVTCGNzZMQVXC6ald/74VC/wJchGSdGC2fea0kJ7lxh/KSeSGRCzkdwuIhDBb3n
         ILJ/LrlJ+p8jwjpgWcNQ3At0lTWRXfMujvwKBWmFmO7t17qndYUX+1VCBVSrUjnNO/DE
         6Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106788; x=1708711588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UWQ++TfiXPPbsr6vtxYlRZHmraPzLnchssMNAsSwn3w=;
        b=EMA6DJy4G+y3VybOH5qiX75MjgiTvs57Gd+wsTSbsoEkX2D4JGnqEdnyJS8D7Ubpzh
         M4PicEi2j+Is5zT6RvoRJ4ceInaq6idZtlCXfxJDosJjK+rlrI6sVJzcSbPVL16J4zs8
         w/GYmIvPNLdVkBt8ig9huXYBrYhWeT1imoUVxDrmPeivm3ll4KBvQ7b9154hgNBVGp6V
         umEIqUAZmeMNtExIfrSREsJjNNBiLMs0mu7XqNQtWeE/nCYJIwY5Jn1SWKyMMaAXJd1G
         KPj0RtSozqVcMVJGCVlevvGuM7bprccb2LzAaUHGoCQ8UMPV0BasUZUqjcJckd0SuW4z
         rD2w==
X-Forwarded-Encrypted: i=1; AJvYcCUVWaQY6b4CE9WKWFT9f1UAlmyjTkQf3/AftWO+/ABnx0WjVzwHglI1x66pBAwEZ16lYU4DRpwIVIQ10t7wVpg1qHPvzsCjifzxbOJk
X-Gm-Message-State: AOJu0YzNltl0isbRZ0hCqrRM4ZapqjOQa74dPnadzDQojbL6kbZOrDpl
	sF9cP4x8RNxFBBMR9ZV7W4Rs0ZbcV8IY+XzrEvhlaairDY3E45Ia
X-Google-Smtp-Source: AGHT+IG//C7kyrykWLItAGRcH9RyoASZXMbHjtA0hkucv2Enx560W221FNfUO1sYE1AuQK1qCPmBJg==
X-Received: by 2002:a05:6a21:3511:b0:19e:bc68:3c67 with SMTP id zc17-20020a056a21351100b0019ebc683c67mr7060998pzb.33.1708106788020;
        Fri, 16 Feb 2024 10:06:28 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id o23-20020a056a001b5700b006e025ce0beesm232976pfv.168.2024.02.16.10.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/17] workqueue: Factor out work_grab_pending() from __cancel_work_sync()
Date: Fri, 16 Feb 2024 08:04:49 -1000
Message-ID: <20240216180559.208276-9-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216180559.208276-1-tj@kernel.org>
References: <20240216180559.208276-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The planned disable/enable support will need the same logic. Let's factor it
out. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 130 +++++++++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 52 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7c6915e23c5c..38e589b6871c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -484,6 +484,12 @@ static struct workqueue_attrs *unbound_std_wq_attrs[NR_STD_WORKER_POOLS];
 /* I: attributes used when instantiating ordered pools on demand */
 static struct workqueue_attrs *ordered_wq_attrs[NR_STD_WORKER_POOLS];
 
+/*
+ * Used to synchronize multiple cancel_sync attempts on the same work item. See
+ * work_grab_pending() and __cancel_work_sync().
+ */
+static DECLARE_WAIT_QUEUE_HEAD(wq_cancel_waitq);
+
 /*
  * I: kthread_worker to release pwq's. pwq release needs to be bounced to a
  * process context while holding a pool lock. Bounce to a dedicated kthread
@@ -2147,6 +2153,73 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 	return -EAGAIN;
 }
 
+struct cwt_wait {
+	wait_queue_entry_t	wait;
+	struct work_struct	*work;
+};
+
+static int cwt_wakefn(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
+{
+	struct cwt_wait *cwait = container_of(wait, struct cwt_wait, wait);
+
+	if (cwait->work != key)
+		return 0;
+	return autoremove_wake_function(wait, mode, sync, key);
+}
+
+/**
+ * work_grab_pending - steal work item from worklist and disable irq
+ * @work: work item to steal
+ * @cflags: %WORK_CANCEL_ flags
+ *
+ * Grab PENDING bit of @work. @work can be in any stable state - idle, on timer
+ * or on worklist.
+ *
+ * Must be called in process context. IRQ is disabled on return. The caller is
+ * responsible for re-enabling it using local_irq_enable().
+ *
+ * Returns %true if @work was pending. %false if idle.
+ */
+static bool work_grab_pending(struct work_struct *work, u32 cflags,
+			      unsigned long *irq_flags)
+{
+	struct cwt_wait cwait;
+	int ret;
+
+	might_sleep();
+repeat:
+	ret = try_to_grab_pending(work, cflags, irq_flags);
+	if (likely(ret >= 0))
+		return ret;
+	if (ret != -ENOENT)
+		goto repeat;
+
+	/*
+	 * Someone is already canceling. Wait for it to finish. flush_work()
+	 * doesn't work for PREEMPT_NONE because we may get woken up between
+	 * @work's completion and the other canceling task resuming and clearing
+	 * CANCELING - flush_work() will return false immediately as @work is no
+	 * longer busy, try_to_grab_pending() will return -ENOENT as @work is
+	 * still being canceled and the other canceling task won't be able to
+	 * clear CANCELING as we're hogging the CPU.
+	 *
+	 * Let's wait for completion using a waitqueue. As this may lead to the
+	 * thundering herd problem, use a custom wake function which matches
+	 * @work along with exclusive wait and wakeup.
+	 */
+	init_wait(&cwait.wait);
+	cwait.wait.func = cwt_wakefn;
+	cwait.work = work;
+
+	prepare_to_wait_exclusive(&wq_cancel_waitq, &cwait.wait,
+				  TASK_UNINTERRUPTIBLE);
+	if (work_is_canceling(work))
+		schedule();
+	finish_wait(&wq_cancel_waitq, &cwait.wait);
+
+	goto repeat;
+}
+
 /**
  * insert_work - insert a work into a pool
  * @pwq: pwq @work belongs to
@@ -4125,60 +4198,13 @@ static bool __cancel_work(struct work_struct *work, u32 cflags)
 	return ret;
 }
 
-struct cwt_wait {
-	wait_queue_entry_t		wait;
-	struct work_struct	*work;
-};
-
-static int cwt_wakefn(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
-{
-	struct cwt_wait *cwait = container_of(wait, struct cwt_wait, wait);
-
-	if (cwait->work != key)
-		return 0;
-	return autoremove_wake_function(wait, mode, sync, key);
-}
-
 static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 {
-	static DECLARE_WAIT_QUEUE_HEAD(cancel_waitq);
 	unsigned long irq_flags;
-	int ret;
-
-	do {
-		ret = try_to_grab_pending(work, cflags, &irq_flags);
-		/*
-		 * If someone else is already canceling, wait for it to
-		 * finish.  flush_work() doesn't work for PREEMPT_NONE
-		 * because we may get scheduled between @work's completion
-		 * and the other canceling task resuming and clearing
-		 * CANCELING - flush_work() will return false immediately
-		 * as @work is no longer busy, try_to_grab_pending() will
-		 * return -ENOENT as @work is still being canceled and the
-		 * other canceling task won't be able to clear CANCELING as
-		 * we're hogging the CPU.
-		 *
-		 * Let's wait for completion using a waitqueue.  As this
-		 * may lead to the thundering herd problem, use a custom
-		 * wake function which matches @work along with exclusive
-		 * wait and wakeup.
-		 */
-		if (unlikely(ret == -ENOENT)) {
-			struct cwt_wait cwait;
-
-			init_wait(&cwait.wait);
-			cwait.wait.func = cwt_wakefn;
-			cwait.work = work;
-
-			prepare_to_wait_exclusive(&cancel_waitq, &cwait.wait,
-						  TASK_UNINTERRUPTIBLE);
-			if (work_is_canceling(work))
-				schedule();
-			finish_wait(&cancel_waitq, &cwait.wait);
-		}
-	} while (unlikely(ret < 0));
+	bool ret;
 
-	/* tell other tasks trying to grab @work to back off */
+	/* claim @work and tell other tasks trying to grab @work to back off */
+	ret = work_grab_pending(work, cflags, &irq_flags);
 	mark_work_canceling(work);
 	local_irq_restore(irq_flags);
 
@@ -4197,8 +4223,8 @@ static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 	 * visible there.
 	 */
 	smp_mb();
-	if (waitqueue_active(&cancel_waitq))
-		__wake_up(&cancel_waitq, TASK_NORMAL, 1, work);
+	if (waitqueue_active(&wq_cancel_waitq))
+		__wake_up(&wq_cancel_waitq, TASK_NORMAL, 1, work);
 
 	return ret;
 }
-- 
2.43.2


