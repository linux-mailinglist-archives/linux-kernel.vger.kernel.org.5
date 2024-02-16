Return-Path: <linux-kernel+bounces-69134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53178584E2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E811F21A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB75146911;
	Fri, 16 Feb 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5FE57mY"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45848146008
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106804; cv=none; b=SDKxA8kHjtGtIaGZUuFMmgSKorozY3mB290kcT7m+CwArKFHGjyxggAizn52hcFHwt4QZ8avkw3Wv+jcYkQu2zfojhkrun+Fvo43VdoU3gQoqNehtS5mzuviqOII/R95YGpU1oAY0XOdr2PSlaOOf+vhyVGY9WSMqhhYqgoPm8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106804; c=relaxed/simple;
	bh=AGf1jpF8ueWGlL1VPqRKidiHEBIaTbTQYlw7Y3Hn+5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcxjgudJPpzeyzfxzjXuVK/8Hb6BbJ7NyEpeXFiIznB4J5/5i7KbUv0szhsvHMhjUpAfEP0kM58n0oSxBlf1GXNdAN9cLUunqST93ca4nfATIT/puhyUTkX3ZXQ8p25j+Av3xopvVvmot7cZ0bKirSap5vjhudB9a/1Kzeh6q+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5FE57mY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d93edfa76dso8835175ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106803; x=1708711603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9bk7H/R6dZtCT0NyxymPB9Me8HfbuqTGpGRRxjeyPY=;
        b=Q5FE57mYI4SwF31ybzAyFyLBzpjr+kn5mAiyU5FySGAqaBTDoJZuxjDb+wrb+dvPVb
         id2ZJksRE1FDB4roeR8mkB7KGmRdAz0zhnDSrM9rd2BWphAoZaS/Z3XYc1uKbFEJ5CyR
         JyPn8iQft2Ihwu5KkICUPo2M52u3zfijOslGq87rvrBIMV3ETGKX64Fwc6fh7FfuTAu4
         3f3BC7u4du8VD+ivqE3ubSp/NH24lTNXz4oE49NWOhsGPkSiCNiPIIlRnEHbOpVbxEps
         yB3Ofb0PU3YAHKZjGHr6PmD7v5k3HO02hmh3upFat1oR3l8nbqMjyJoNlG6J67QjqC7U
         FzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106803; x=1708711603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N9bk7H/R6dZtCT0NyxymPB9Me8HfbuqTGpGRRxjeyPY=;
        b=i22hNDd10vr5uhrgAg/UHcBImto7hsv4+NUWZRwssErcnf6XHHZMf535Xgyp4Ujx5r
         4ysxoRxptWvJ1pVRQFWzNTLHP8f/06bHibVdxHQZdi/uZKojk6tuRSZwwk92aYrx8Or3
         jyaGuNDUwM1BTTGeIf9vpY9Rkj0ZQpjQa29fAqe0Q4YcW/jfyA3iojAKt+zduOR9mpzC
         6qrLQ8Np2/I8R11DTE6lOc8v+JoeRpdrXE0nLctQ01FnvgRv44pTYbHQkex5XS7bKku+
         PAfKPd9LRO/UVYlmFup+ILaZXT/+Jb4WnUHSpZ/a3FkcP+XZ0fVejve8pPIi3poilCzW
         HOQA==
X-Forwarded-Encrypted: i=1; AJvYcCU1dE+XI/oNaZ/KX+EgjMmBvJERpB6HOulqaVCESVQ2iKjm07he7meviDIA3iy99RJhGAoD5FXRo+FkK04+Pp+RK+HIOPRKLPyq+6yP
X-Gm-Message-State: AOJu0Yy2A9ZasqgwUt7Qy69VUYjqGb3EnTE94f+9PQcY8ZI4NHcQh6sz
	CK54cGVBlDeLVMIBpzFbJqGZw1F1MM/p00vTg+855V+mjia57aXCcDD9MJm/UP4=
X-Google-Smtp-Source: AGHT+IHVqHcBu4dR3ViJMNeFbcaZL4T3eFZXJuckmhXOBztYxwUiVaKFSQEDDPmxXMCvSSIHfFsptg==
X-Received: by 2002:a17:902:dac1:b0:1d9:3101:c46d with SMTP id q1-20020a170902dac100b001d93101c46dmr7033665plx.55.1708106802661;
        Fri, 16 Feb 2024 10:06:42 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id u12-20020a170903308c00b001da11733477sm160054plc.75.2024.02.16.10.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 16/17] workqueue: Allow cancel_work_sync() and disable_work() from atomic contexts on BH work items
Date: Fri, 16 Feb 2024 08:04:57 -1000
Message-ID: <20240216180559.208276-17-tj@kernel.org>
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

Now that work_grab_pending() can always grab the PENDING bit without
sleeping, the only thing that prevents allowing cancel_work_sync() of a BH
work item from an atomic context is the flushing of the in-flight instance.

When we're flushing a BH work item for cancel_work_sync(), we know that the
work item is not queued and must be executing in a BH context, which means
that it's safe to busy-wait for its completion from a non-hardirq atomic
context.

This patch updates __flush_work() so that it busy-waits when flushing a BH
work item for cancel_work_sync(). might_sleep() is pushed from
start_flush_work() to its callers - when operating on a BH work item,
__cancel_work_sync() now enforces !in_hardirq() instead of might_sleep().

This allows cancel_work_sync() and disable_work() to be called from
non-hardirq atomic contexts on BH work items.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 62 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f6ea25628701..00eac314e62a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4004,8 +4004,6 @@ static struct worker_pool *start_flush_work(struct work_struct *work,
 	struct pool_workqueue *pwq;
 	struct workqueue_struct *wq;
 
-	might_sleep();
-
 	pool = get_work_pool(work);
 	if (!pool)
 		return NULL;
@@ -4072,7 +4070,32 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (!pool)
 		return false;
 
-	wait_for_completion(&barr.done);
+	if ((pool->flags & POOL_BH) && from_cancel) {
+		/*
+		 * We're flushing a BH work item which is being canceled. It
+		 * must have been executing during start_flush_work() and can't
+		 * currently be queued. If @work is still executing, we know it
+		 * is running in the BH context and thus can be busy-waited.
+		 *
+		 * On RT, prevent a live lock when current preempted soft
+		 * interrupt processing or prevents ksoftirqd from running by
+		 * keeping flipping BH. If the tasklet runs on a different CPU
+		 * then this has no effect other than doing the BH
+		 * disable/enable dance for nothing. This is copied from
+		 * kernel/softirq.c::tasklet_unlock_spin_wait().
+		 */
+		while (!try_wait_for_completion(&barr.done)) {
+			if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+				local_bh_disable();
+				local_bh_enable();
+			} else {
+				cpu_relax();
+			}
+		}
+	} else {
+		wait_for_completion(&barr.done);
+	}
+
 	destroy_work_on_stack(&barr.work);
 	return true;
 }
@@ -4090,6 +4113,7 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
  */
 bool flush_work(struct work_struct *work)
 {
+	might_sleep();
 	return __flush_work(work, false);
 }
 EXPORT_SYMBOL_GPL(flush_work);
@@ -4179,6 +4203,11 @@ static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 
 	ret = __cancel_work(work, cflags | WORK_CANCEL_DISABLE);
 
+	if (*work_data_bits(work) & WORK_OFFQ_BH)
+		WARN_ON_ONCE(in_hardirq());
+	else
+		might_sleep();
+
 	/*
 	 * Skip __flush_work() during early boot when we know that @work isn't
 	 * executing. This allows canceling during early boot.
@@ -4205,19 +4234,19 @@ EXPORT_SYMBOL(cancel_work);
  * cancel_work_sync - cancel a work and wait for it to finish
  * @work: the work to cancel
  *
- * Cancel @work and wait for its execution to finish.  This function
- * can be used even if the work re-queues itself or migrates to
- * another workqueue.  On return from this function, @work is
- * guaranteed to be not pending or executing on any CPU.
+ * Cancel @work and wait for its execution to finish. This function can be used
+ * even if the work re-queues itself or migrates to another workqueue. On return
+ * from this function, @work is guaranteed to be not pending or executing on any
+ * CPU as long as there aren't racing enqueues.
  *
- * cancel_work_sync(&delayed_work->work) must not be used for
- * delayed_work's.  Use cancel_delayed_work_sync() instead.
+ * cancel_work_sync(&delayed_work->work) must not be used for delayed_work's.
+ * Use cancel_delayed_work_sync() instead.
  *
- * The caller must ensure that the workqueue on which @work was last
- * queued can't be destroyed before this function returns.
+ * Must be called from a sleepable context if @work was last queued on a non-BH
+ * workqueue. Can also be called from non-hardirq atomic contexts including BH
+ * if @work was last queued on a BH workqueue.
  *
- * Return:
- * %true if @work was pending, %false otherwise.
+ * Returns %true if @work was pending, %false otherwise.
  */
 bool cancel_work_sync(struct work_struct *work)
 {
@@ -4287,8 +4316,11 @@ EXPORT_SYMBOL_GPL(disable_work);
  * Similar to disable_work() but also wait for @work to finish if currently
  * executing.
  *
- * Must be called from a sleepable context. Returns %true if @work was pending,
- * %false otherwise.
+ * Must be called from a sleepable context if @work was last queued on a non-BH
+ * workqueue. Can also be called from non-hardirq atomic contexts including BH
+ * if @work was last queued on a BH workqueue.
+ *
+ * Returns %true if @work was pending, %false otherwise.
  */
 bool disable_work_sync(struct work_struct *work)
 {
-- 
2.43.2


