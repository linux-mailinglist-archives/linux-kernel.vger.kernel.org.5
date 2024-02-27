Return-Path: <linux-kernel+bounces-83727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6118A869DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E045D1F22405
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3A31509AB;
	Tue, 27 Feb 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cqgul2B7"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680814900E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054943; cv=none; b=AiwpJ3YoX0RXvUSdBOfgilvQz1rBL9XcQOdUUgyMO09uGfZSJB3w49kHo8SGHt1WzAKLlmj/ZCHl5fJBglG6xs73ytBEjRgmWRT+Ya6Cz14IjaOQ4JYyy406ZIZjoBQptmR4hKbOLkhxPGiGcsWbD8B4WcoOKWrqOv510qGj8zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054943; c=relaxed/simple;
	bh=nQAuvr5KrAyXm9br1ei0161GC9yr4LeaeUrXjWzVG4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHHeiQ5T6QdnkSQV3h6WLwciaYhPvUQWqe01WEIpKU6VLBDxbLWHepagMSDoZX1qk/pYdywiBNaWhAA4JdbnCd1xZFfbYEkMf675Qc9+p+rU+A2Oso4mySmeizg2y+B+98QVd9Ys/9afds5qkabN7DU2Aq1d/dGgWX9G6XyZW+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cqgul2B7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e54ffdd0b5so445860b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709054941; x=1709659741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8L0w+filKhnx5ou6lK4ASaEc5Nqt4aefqvsq9AGbtU=;
        b=Cqgul2B7/dVm6QUywWqUzWDAlC96bLPRrPLY5P+8TTjMXs91egg+tW8EAct5cL8kfr
         NHNh7M1MYpnAng/NNGVD7iGRfoYJH2rayYLHHTvHbVTy7eVlYNmfzowo3BTXvcHJ7jkp
         Rk7g2YqSQdb+Enh4u+0jO0NzfmuXQAiRJ1J+8JUVm5SBuSp6CfUqdCn24ChqVpYBBSLF
         C96rfzW1MnFS+/gd0M4t210HuPy/0rPfGGIzSODdo8ACSdI/sSOKxyJtbK9sILrbVXV0
         S0SFtQJ0TPHuaTeLYrKqpOtBFYPQlBw04ihZszg3Wj5I8/9uswnfaE6joKK1sgf+lQMr
         5Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709054941; x=1709659741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H8L0w+filKhnx5ou6lK4ASaEc5Nqt4aefqvsq9AGbtU=;
        b=DzW073HixGfkD6xjDX5jr3j5G2HYyoThTBYUAvL8hMc5gqvCScQlN45+zAhVfHUeiq
         p8Klhe3grFPiiB7Fh9rv4ySKy/Bo6bn8rcU1cDhD2wkFkxE+xPWpctgjteYIhfnrVGMY
         AFU/aBLDUpUTBaVKe5al2lEyz7wQy4+eJIhdgqyUedkXhuptfdgo7RR9agZsUoYWxhBt
         HRlXrluyYXpePNU/UamwadJcm5br86XydyAs3RWoAPykZ3Ndv4BWUAPPyDADeLDpFwhu
         p6ZR+9e9s61hsBV7mgX33xlUiD0a1hRw1X4qmvF7dy4HIymSh1Aguc24YpmtXMy65lu1
         je7A==
X-Forwarded-Encrypted: i=1; AJvYcCVhVjnUNMx5Mrh8FO0NccWuMEmgKjdtBWTaCD61FLitfRksGIpB7RVDRtAqv6UqY/93t6LOXISc/LU8OE5CT+1fjF/59d/8Apd5Vdkc
X-Gm-Message-State: AOJu0YxRm5jCec6nsvmESWQ2O5RQhm3xtSZJi3jdQoiazFizE/gn7aHs
	Jby5zMuZmWIMzESgehBXLFaLoX8IiKZGhUCijCjeQMyqK98K5tGw
X-Google-Smtp-Source: AGHT+IF557UZPZ1WHG+OK9aQFeJ47WCN1/dfNTYHSF6Qd5qcndVYrHQgDBScqxhXYCy68svHS6dc+Q==
X-Received: by 2002:aa7:88d4:0:b0:6e5:456b:bff9 with SMTP id k20-20020aa788d4000000b006e5456bbff9mr4338406pff.12.1709054940927;
        Tue, 27 Feb 2024 09:29:00 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id a17-20020aa78e91000000b006e554afa254sm626033pfr.38.2024.02.27.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:29:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	boqun.feng@gmail.com,
	tglx@linutronix.de,
	peterz@infradead.org,
	romain.perier@gmail.com,
	mingo@kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] workqueue: Remove WORK_OFFQ_CANCELING
Date: Tue, 27 Feb 2024 07:28:14 -1000
Message-ID: <20240227172852.2386358-4-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227172852.2386358-1-tj@kernel.org>
References: <20240227172852.2386358-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cancel[_delayed]_work_sync() guarantees that it can shut down
self-requeueing work items. To achieve that, it grabs and then holds
WORK_STRUCT_PENDING bit set while flushing the currently executing instance.
As the PENDING bit is set, all queueing attempts including the
self-requeueing ones fail and once the currently executing instance is
flushed, the work item should be idle as long as someone else isn't actively
queueing it.

This means that the cancel_work_sync path may hold the PENDING bit set while
flushing the target work item. This isn't a problem for the queueing path -
it can just fail which is the desired effect. It doesn't affect flush. It
doesn't matter to cancel_work either as it can just report that the work
item has successfully canceled. However, if there's another cancel_work_sync
attempt on the work item, it can't simply fail or report success and that
would breach the guarantee that it should provide. cancel_work_sync has to
wait for and grab that PENDING bit and go through the motions.

WORK_OFFQ_CANCELING and wq_cancel_waitq are what implement this
cancel_work_sync to cancel_work_sync wait mechanism. When a work item is
being canceled, WORK_OFFQ_CANCELING is also set on it and other
cancel_work_sync attempts wait on the bit to be cleared using the wait
queue.

While this works, it's an isolated wart which doesn't jive with the rest of
flush and cancel mechanisms and forces enable_work() and disable_work() to
require a sleepable context, which hampers their usability.

Now that a work item can be disabled, we can use that to block queueing
while cancel_work_sync is in progress. Instead of holding PENDING the bit,
it can temporarily disable the work item, flush and then re-enable it as
that'd achieve the same end result of blocking queueings while canceling and
thus enable canceling of self-requeueing work items.

- WORK_OFFQ_CANCELING and the surrounding mechanims are removed.

- work_grab_pending() is now simpler, no longer has to wait for a blocking
  operation and thus can be called from any context.

- With work_grab_pending() simplified, no need to use try_to_grab_pending()
  directly. All users are converted to use work_grab_pending().

- __cancel_work_sync() is updated to __cancel_work() with
  WORK_CANCEL_DISABLE to cancel and plug racing queueing attempts. It then
  flushes and re-enables the work item if necessary.

- These changes allow disable_work() and enable_work() to be called from any
  context.

v2: Lai pointed out that mod_delayed_work_on() needs to check the disable
    count before queueing the delayed work item. Added
    clear_pending_if_disabled() call.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 include/linux/workqueue.h |   4 +-
 kernel/workqueue.c        | 140 ++++++--------------------------------
 2 files changed, 20 insertions(+), 124 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index f25915e47efb..86483743ad28 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -52,10 +52,9 @@ enum work_bits {
 	 *
 	 * MSB
 	 * [ pool ID ] [ disable depth ] [ OFFQ flags ] [ STRUCT flags ]
-	 *                  16 bits          1 bit        4 or 5 bits
+	 *                  16 bits          0 bits       4 or 5 bits
 	 */
 	WORK_OFFQ_FLAG_SHIFT	= WORK_STRUCT_FLAG_BITS,
-	WORK_OFFQ_CANCELING_BIT = WORK_OFFQ_FLAG_SHIFT,
 	WORK_OFFQ_FLAG_END,
 	WORK_OFFQ_FLAG_BITS	= WORK_OFFQ_FLAG_END - WORK_OFFQ_FLAG_SHIFT,
 
@@ -99,7 +98,6 @@ enum wq_misc_consts {
 };
 
 /* Convenience constants - of type 'unsigned long', not 'enum'! */
-#define WORK_OFFQ_CANCELING	(1ul << WORK_OFFQ_CANCELING_BIT)
 #define WORK_OFFQ_FLAG_MASK	(((1ul << WORK_OFFQ_FLAG_BITS) - 1) << WORK_OFFQ_FLAG_SHIFT)
 #define WORK_OFFQ_DISABLE_MASK	(((1ul << WORK_OFFQ_DISABLE_BITS) - 1) << WORK_OFFQ_DISABLE_SHIFT)
 #define WORK_OFFQ_POOL_NONE	((1ul << WORK_OFFQ_POOL_BITS) - 1)
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a2f2847d464b..07e77130227c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -495,12 +495,6 @@ static struct workqueue_attrs *unbound_std_wq_attrs[NR_STD_WORKER_POOLS];
 /* I: attributes used when instantiating ordered pools on demand */
 static struct workqueue_attrs *ordered_wq_attrs[NR_STD_WORKER_POOLS];
 
-/*
- * Used to synchronize multiple cancel_sync attempts on the same work item. See
- * work_grab_pending() and __cancel_work_sync().
- */
-static DECLARE_WAIT_QUEUE_HEAD(wq_cancel_waitq);
-
 /*
  * I: kthread_worker to release pwq's. pwq release needs to be bounced to a
  * process context while holding a pool lock. Bounce to a dedicated kthread
@@ -782,11 +776,6 @@ static int work_next_color(int color)
  * corresponding to a work.  Pool is available once the work has been
  * queued anywhere after initialization until it is sync canceled.  pwq is
  * available only while the work item is queued.
- *
- * %WORK_OFFQ_CANCELING is used to mark a work item which is being
- * canceled.  While being canceled, a work item may have its PENDING set
- * but stay off timer and worklist for arbitrarily long and nobody should
- * try to steal the PENDING bit.
  */
 static inline void set_work_data(struct work_struct *work, unsigned long data)
 {
@@ -920,13 +909,6 @@ static unsigned long work_offqd_pack_flags(struct work_offq_data *offqd)
 		((unsigned long)offqd->flags);
 }
 
-static bool work_is_canceling(struct work_struct *work)
-{
-	unsigned long data = atomic_long_read(&work->data);
-
-	return !(data & WORK_STRUCT_PWQ) && (data & WORK_OFFQ_CANCELING);
-}
-
 /*
  * Policy functions.  These define the policies on how the global worker
  * pools are managed.  Unless noted otherwise, these functions assume that
@@ -2055,8 +2037,6 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
  *  1		if @work was pending and we successfully stole PENDING
  *  0		if @work was idle and we claimed PENDING
  *  -EAGAIN	if PENDING couldn't be grabbed at the moment, safe to busy-retry
- *  -ENOENT	if someone else is canceling @work, this state may persist
- *		for arbitrarily long
  *  ========	================================================================
  *
  * Note:
@@ -2152,26 +2132,9 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 fail:
 	rcu_read_unlock();
 	local_irq_restore(*irq_flags);
-	if (work_is_canceling(work))
-		return -ENOENT;
-	cpu_relax();
 	return -EAGAIN;
 }
 
-struct cwt_wait {
-	wait_queue_entry_t	wait;
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
 /**
  * work_grab_pending - steal work item from worklist and disable irq
  * @work: work item to steal
@@ -2181,7 +2144,7 @@ static int cwt_wakefn(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
  * Grab PENDING bit of @work. @work can be in any stable state - idle, on timer
  * or on worklist.
  *
- * Must be called in process context. IRQ is disabled on return with IRQ state
+ * Can be called from any context. IRQ is disabled on return with IRQ state
  * stored in *@irq_flags. The caller is responsible for re-enabling it using
  * local_irq_restore().
  *
@@ -2190,41 +2153,14 @@ static int cwt_wakefn(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
 static bool work_grab_pending(struct work_struct *work, u32 cflags,
 			      unsigned long *irq_flags)
 {
-	struct cwt_wait cwait;
 	int ret;
 
-	might_sleep();
-repeat:
-	ret = try_to_grab_pending(work, cflags, irq_flags);
-	if (likely(ret >= 0))
-		return ret;
-	if (ret != -ENOENT)
-		goto repeat;
-
-	/*
-	 * Someone is already canceling. Wait for it to finish. flush_work()
-	 * doesn't work for PREEMPT_NONE because we may get woken up between
-	 * @work's completion and the other canceling task resuming and clearing
-	 * CANCELING - flush_work() will return false immediately as @work is no
-	 * longer busy, try_to_grab_pending() will return -ENOENT as @work is
-	 * still being canceled and the other canceling task won't be able to
-	 * clear CANCELING as we're hogging the CPU.
-	 *
-	 * Let's wait for completion using a waitqueue. As this may lead to the
-	 * thundering herd problem, use a custom wake function which matches
-	 * @work along with exclusive wait and wakeup.
-	 */
-	init_wait(&cwait.wait);
-	cwait.wait.func = cwt_wakefn;
-	cwait.work = work;
-
-	prepare_to_wait_exclusive(&wq_cancel_waitq, &cwait.wait,
-				  TASK_UNINTERRUPTIBLE);
-	if (work_is_canceling(work))
-		schedule();
-	finish_wait(&wq_cancel_waitq, &cwait.wait);
-
-	goto repeat;
+	while (true) {
+		ret = try_to_grab_pending(work, cflags, irq_flags);
+		if (ret >= 0)
+			return ret;
+		cpu_relax();
+	}
 }
 
 /**
@@ -2642,19 +2578,14 @@ bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
 			 struct delayed_work *dwork, unsigned long delay)
 {
 	unsigned long irq_flags;
-	int ret;
+	bool ret;
 
-	do {
-		ret = try_to_grab_pending(&dwork->work, WORK_CANCEL_DELAYED,
-					  &irq_flags);
-	} while (unlikely(ret == -EAGAIN));
+	ret = work_grab_pending(&dwork->work, WORK_CANCEL_DELAYED, &irq_flags);
 
-	if (likely(ret >= 0)) {
+	if (!clear_pending_if_disabled(&dwork->work))
 		__queue_delayed_work(cpu, wq, dwork, delay);
-		local_irq_restore(irq_flags);
-	}
 
-	/* -ENOENT from try_to_grab_pending() becomes %true */
+	local_irq_restore(irq_flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mod_delayed_work_on);
@@ -4235,16 +4166,7 @@ static bool __cancel_work(struct work_struct *work, u32 cflags)
 	unsigned long irq_flags;
 	int ret;
 
-	if (cflags & WORK_CANCEL_DISABLE) {
-		ret = work_grab_pending(work, cflags, &irq_flags);
-	} else {
-		do {
-			ret = try_to_grab_pending(work, cflags, &irq_flags);
-		} while (unlikely(ret == -EAGAIN));
-
-		if (unlikely(ret < 0))
-			return false;
-	}
+	ret = work_grab_pending(work, cflags, &irq_flags);
 
 	work_offqd_unpack(&offqd, *work_data_bits(work));
 
@@ -4259,22 +4181,9 @@ static bool __cancel_work(struct work_struct *work, u32 cflags)
 
 static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 {
-	struct work_offq_data offqd;
-	unsigned long irq_flags;
 	bool ret;
 
-	/* claim @work and tell other tasks trying to grab @work to back off */
-	ret = work_grab_pending(work, cflags, &irq_flags);
-
-	work_offqd_unpack(&offqd, *work_data_bits(work));
-
-	if (cflags & WORK_CANCEL_DISABLE)
-		work_offqd_disable(&offqd);
-
-	offqd.flags |= WORK_OFFQ_CANCELING;
-	set_work_pool_and_keep_pending(work, offqd.pool_id,
-				       work_offqd_pack_flags(&offqd));
-	local_irq_restore(irq_flags);
+	ret = __cancel_work(work, cflags | WORK_CANCEL_DISABLE);
 
 	/*
 	 * Skip __flush_work() during early boot when we know that @work isn't
@@ -4283,19 +4192,8 @@ static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 	if (wq_online)
 		__flush_work(work, true);
 
-	work_offqd_unpack(&offqd, *work_data_bits(work));
-
-	/*
-	 * smp_mb() at the end of set_work_pool_and_clear_pending() is paired
-	 * with prepare_to_wait() above so that either waitqueue_active() is
-	 * visible here or !work_is_canceling() is visible there.
-	 */
-	offqd.flags &= ~WORK_OFFQ_CANCELING;
-	set_work_pool_and_clear_pending(work, WORK_OFFQ_POOL_NONE,
-					work_offqd_pack_flags(&offqd));
-
-	if (waitqueue_active(&wq_cancel_waitq))
-		__wake_up(&wq_cancel_waitq, TASK_NORMAL, 1, work);
+	if (!(cflags & WORK_CANCEL_DISABLE))
+		enable_work(work);
 
 	return ret;
 }
@@ -4379,8 +4277,8 @@ EXPORT_SYMBOL(cancel_delayed_work_sync);
  * will fail and return %false. The maximum supported disable depth is 2 to the
  * power of %WORK_OFFQ_DISABLE_BITS, currently 65536.
  *
- * Must be called from a sleepable context. Returns %true if @work was pending,
- * %false otherwise.
+ * Can be called from any context. Returns %true if @work was pending, %false
+ * otherwise.
  */
 bool disable_work(struct work_struct *work)
 {
@@ -4411,8 +4309,8 @@ EXPORT_SYMBOL_GPL(disable_work_sync);
  * Undo disable_work[_sync]() by decrementing @work's disable count. @work can
  * only be queued if its disable count is 0.
  *
- * Must be called from a sleepable context. Returns %true if the disable count
- * reached 0. Otherwise, %false.
+ * Can be called from any context. Returns %true if the disable count reached 0.
+ * Otherwise, %false.
  */
 bool enable_work(struct work_struct *work)
 {
-- 
2.43.2


