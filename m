Return-Path: <linux-kernel+bounces-70956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1127859EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5CB31C2167C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9905425108;
	Mon, 19 Feb 2024 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hgTEMjRc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H4Nw45Ny"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9307B224CA;
	Mon, 19 Feb 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332339; cv=none; b=aCHqbVH8QRuJBlMq1KzydpN7esxT34B7MBWVuNnT1recPkJzurQx5UtUh7zNc19Z/sP/ajpK6VF1aVkzo5AtNxo1dIHfPcODIV5h/mAL21ZbQVkcdvj59CUaOJcr4vYGKw73+1BlCXNUZEWOQDPdQDxckxEVaiIAVMtOEV6M31A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332339; c=relaxed/simple;
	bh=aP3a2VaMCfvGZdPOvnOMG7G2bH0AyGP96msZ2vSrZv8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xt0dtQ8pFMkRgjVe3kz4ArHRQ9qe8E0bspuTyyxMN/zvhmk6tpg2nLSbzYR2nkmlGWKJYJcMxv1b2JJrBklQ6nH7mHtkB2Pqbh3Fa+0BJ2C/4jS1nNfZdEUJJKueAy6yDruhLd9ElSUSPYJnEOpci7t/OYR0kppY7VmVZ7XBWBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hgTEMjRc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H4Nw45Ny; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 08:45:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708332335;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e79XwFm9T8JkG9FwTmyG4lbnGIMfdP83AZ1lUQhNCcM=;
	b=hgTEMjRcTfBk7heAzFYJJ7BjV5BxyT/6hdHuEEY/4E5MiLk4Zjb1crnxdl9ar8HmtRJP6y
	9trkwMpYDdxgtRr/1PDF+6nBPCwl1rz8gwav8LXQvrsWwF4BboODl40pkH/FsoZiuP1isL
	FZPcFfF1TqR+czxhrVCQdrcdlC952DD0BaucaqtsW6O+bgTzB9+TjLYBO2p2JMfwwjpDrk
	9NU/O8G0IJoX5HWNxy+xrEgvdWYPMPnHHWMJA9c/wfSD5V97EP2Mkps+X9ie4oAisdJ4Tr
	tO5j1omgBFVyiWJ1JGutV+rx82oALejyFgJLyQISFJtQuq183a1qyRyGTPi5ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708332335;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e79XwFm9T8JkG9FwTmyG4lbnGIMfdP83AZ1lUQhNCcM=;
	b=H4Nw45Nyod3IwWdtjKlKmBPJJyH6Q4b/+KraN7Tax/9+wQMlspoyAjnsVFcRO/jk76UkDV
	bhOGS1lT5qo+/rAQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimers: Move hrtimer base related definitions
 into hrtimer_defs.h
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240123164702.55612-2-anna-maria@linutronix.de>
References: <20240123164702.55612-2-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170833233491.398.13327405048781821251.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1a4729ecafc239f922d0c758bab7be0038714e88
Gitweb:        https://git.kernel.org/tip/1a4729ecafc239f922d0c758bab7be0038714e88
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 23 Jan 2024 17:46:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Feb 2024 09:37:59 +01:00

hrtimers: Move hrtimer base related definitions into hrtimer_defs.h

hrtimer base related struct definitions are part of hrtimers.h as it is
required there. With this, also the struct documentation which is for core
code internal use, is exposed into the general api.

To prevent this, move all core internal definitions and the related
includes into hrtimer_defs.h.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240123164702.55612-2-anna-maria@linutronix.de

---
 include/linux/hrtimer.h      | 103 +----------------------------------
 include/linux/hrtimer_defs.h | 102 ++++++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 103 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 87e3bed..792a0ac 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -18,12 +18,8 @@
 #include <linux/list.h>
 #include <linux/percpu-defs.h>
 #include <linux/rbtree.h>
-#include <linux/seqlock.h>
 #include <linux/timer.h>
 
-struct hrtimer_clock_base;
-struct hrtimer_cpu_base;
-
 /*
  * Mode arguments of xxx_hrtimer functions:
  *
@@ -98,105 +94,6 @@ struct hrtimer_sleeper {
 	struct task_struct *task;
 };
 
-#ifdef CONFIG_64BIT
-# define __hrtimer_clock_base_align	____cacheline_aligned
-#else
-# define __hrtimer_clock_base_align
-#endif
-
-/**
- * struct hrtimer_clock_base - the timer base for a specific clock
- * @cpu_base:		per cpu clock base
- * @index:		clock type index for per_cpu support when moving a
- *			timer to a base on another cpu.
- * @clockid:		clock id for per_cpu support
- * @seq:		seqcount around __run_hrtimer
- * @running:		pointer to the currently running hrtimer
- * @active:		red black tree root node for the active timers
- * @get_time:		function to retrieve the current time of the clock
- * @offset:		offset of this clock to the monotonic base
- */
-struct hrtimer_clock_base {
-	struct hrtimer_cpu_base	*cpu_base;
-	unsigned int		index;
-	clockid_t		clockid;
-	seqcount_raw_spinlock_t	seq;
-	struct hrtimer		*running;
-	struct timerqueue_head	active;
-	ktime_t			(*get_time)(void);
-	ktime_t			offset;
-} __hrtimer_clock_base_align;
-
-enum  hrtimer_base_type {
-	HRTIMER_BASE_MONOTONIC,
-	HRTIMER_BASE_REALTIME,
-	HRTIMER_BASE_BOOTTIME,
-	HRTIMER_BASE_TAI,
-	HRTIMER_BASE_MONOTONIC_SOFT,
-	HRTIMER_BASE_REALTIME_SOFT,
-	HRTIMER_BASE_BOOTTIME_SOFT,
-	HRTIMER_BASE_TAI_SOFT,
-	HRTIMER_MAX_CLOCK_BASES,
-};
-
-/**
- * struct hrtimer_cpu_base - the per cpu clock bases
- * @lock:		lock protecting the base and associated clock bases
- *			and timers
- * @cpu:		cpu number
- * @active_bases:	Bitfield to mark bases with active timers
- * @clock_was_set_seq:	Sequence counter of clock was set events
- * @hres_active:	State of high resolution mode
- * @in_hrtirq:		hrtimer_interrupt() is currently executing
- * @hang_detected:	The last hrtimer interrupt detected a hang
- * @softirq_activated:	displays, if the softirq is raised - update of softirq
- *			related settings is not required then.
- * @nr_events:		Total number of hrtimer interrupt events
- * @nr_retries:		Total number of hrtimer interrupt retries
- * @nr_hangs:		Total number of hrtimer interrupt hangs
- * @max_hang_time:	Maximum time spent in hrtimer_interrupt
- * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
- *			 expired
- * @timer_waiters:	A hrtimer_cancel() invocation waits for the timer
- *			callback to finish.
- * @expires_next:	absolute time of the next event, is required for remote
- *			hrtimer enqueue; it is the total first expiry time (hard
- *			and soft hrtimer are taken into account)
- * @next_timer:		Pointer to the first expiring timer
- * @softirq_expires_next: Time to check, if soft queues needs also to be expired
- * @softirq_next_timer: Pointer to the first expiring softirq based timer
- * @clock_base:		array of clock bases for this cpu
- *
- * Note: next_timer is just an optimization for __remove_hrtimer().
- *	 Do not dereference the pointer because it is not reliable on
- *	 cross cpu removals.
- */
-struct hrtimer_cpu_base {
-	raw_spinlock_t			lock;
-	unsigned int			cpu;
-	unsigned int			active_bases;
-	unsigned int			clock_was_set_seq;
-	unsigned int			hres_active		: 1,
-					in_hrtirq		: 1,
-					hang_detected		: 1,
-					softirq_activated       : 1;
-#ifdef CONFIG_HIGH_RES_TIMERS
-	unsigned int			nr_events;
-	unsigned short			nr_retries;
-	unsigned short			nr_hangs;
-	unsigned int			max_hang_time;
-#endif
-#ifdef CONFIG_PREEMPT_RT
-	spinlock_t			softirq_expiry_lock;
-	atomic_t			timer_waiters;
-#endif
-	ktime_t				expires_next;
-	struct hrtimer			*next_timer;
-	ktime_t				softirq_expires_next;
-	struct hrtimer			*softirq_next_timer;
-	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
-} ____cacheline_aligned;
-
 static inline void hrtimer_set_expires(struct hrtimer *timer, ktime_t time)
 {
 	timer->node.expires = time;
diff --git a/include/linux/hrtimer_defs.h b/include/linux/hrtimer_defs.h
index 2d3e3c5..b12869d 100644
--- a/include/linux/hrtimer_defs.h
+++ b/include/linux/hrtimer_defs.h
@@ -3,6 +3,8 @@
 #define _LINUX_HRTIMER_DEFS_H
 
 #include <linux/ktime.h>
+#include <linux/timerqueue.h>
+#include <linux/seqlock.h>
 
 #ifdef CONFIG_HIGH_RES_TIMERS
 
@@ -24,4 +26,104 @@
 
 #endif
 
+#ifdef CONFIG_64BIT
+# define __hrtimer_clock_base_align	____cacheline_aligned
+#else
+# define __hrtimer_clock_base_align
+#endif
+
+/**
+ * struct hrtimer_clock_base - the timer base for a specific clock
+ * @cpu_base:		per cpu clock base
+ * @index:		clock type index for per_cpu support when moving a
+ *			timer to a base on another cpu.
+ * @clockid:		clock id for per_cpu support
+ * @seq:		seqcount around __run_hrtimer
+ * @running:		pointer to the currently running hrtimer
+ * @active:		red black tree root node for the active timers
+ * @get_time:		function to retrieve the current time of the clock
+ * @offset:		offset of this clock to the monotonic base
+ */
+struct hrtimer_clock_base {
+	struct hrtimer_cpu_base	*cpu_base;
+	unsigned int		index;
+	clockid_t		clockid;
+	seqcount_raw_spinlock_t	seq;
+	struct hrtimer		*running;
+	struct timerqueue_head	active;
+	ktime_t			(*get_time)(void);
+	ktime_t			offset;
+} __hrtimer_clock_base_align;
+
+enum  hrtimer_base_type {
+	HRTIMER_BASE_MONOTONIC,
+	HRTIMER_BASE_REALTIME,
+	HRTIMER_BASE_BOOTTIME,
+	HRTIMER_BASE_TAI,
+	HRTIMER_BASE_MONOTONIC_SOFT,
+	HRTIMER_BASE_REALTIME_SOFT,
+	HRTIMER_BASE_BOOTTIME_SOFT,
+	HRTIMER_BASE_TAI_SOFT,
+	HRTIMER_MAX_CLOCK_BASES,
+};
+
+/**
+ * struct hrtimer_cpu_base - the per cpu clock bases
+ * @lock:		lock protecting the base and associated clock bases
+ *			and timers
+ * @cpu:		cpu number
+ * @active_bases:	Bitfield to mark bases with active timers
+ * @clock_was_set_seq:	Sequence counter of clock was set events
+ * @hres_active:	State of high resolution mode
+ * @in_hrtirq:		hrtimer_interrupt() is currently executing
+ * @hang_detected:	The last hrtimer interrupt detected a hang
+ * @softirq_activated:	displays, if the softirq is raised - update of softirq
+ *			related settings is not required then.
+ * @nr_events:		Total number of hrtimer interrupt events
+ * @nr_retries:		Total number of hrtimer interrupt retries
+ * @nr_hangs:		Total number of hrtimer interrupt hangs
+ * @max_hang_time:	Maximum time spent in hrtimer_interrupt
+ * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
+ *			 expired
+ * @timer_waiters:	A hrtimer_cancel() invocation waits for the timer
+ *			callback to finish.
+ * @expires_next:	absolute time of the next event, is required for remote
+ *			hrtimer enqueue; it is the total first expiry time (hard
+ *			and soft hrtimer are taken into account)
+ * @next_timer:		Pointer to the first expiring timer
+ * @softirq_expires_next: Time to check, if soft queues needs also to be expired
+ * @softirq_next_timer: Pointer to the first expiring softirq based timer
+ * @clock_base:		array of clock bases for this cpu
+ *
+ * Note: next_timer is just an optimization for __remove_hrtimer().
+ *	 Do not dereference the pointer because it is not reliable on
+ *	 cross cpu removals.
+ */
+struct hrtimer_cpu_base {
+	raw_spinlock_t			lock;
+	unsigned int			cpu;
+	unsigned int			active_bases;
+	unsigned int			clock_was_set_seq;
+	unsigned int			hres_active		: 1,
+					in_hrtirq		: 1,
+					hang_detected		: 1,
+					softirq_activated       : 1;
+#ifdef CONFIG_HIGH_RES_TIMERS
+	unsigned int			nr_events;
+	unsigned short			nr_retries;
+	unsigned short			nr_hangs;
+	unsigned int			max_hang_time;
+#endif
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t			softirq_expiry_lock;
+	atomic_t			timer_waiters;
+#endif
+	ktime_t				expires_next;
+	struct hrtimer			*next_timer;
+	ktime_t				softirq_expires_next;
+	struct hrtimer			*softirq_next_timer;
+	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
+} ____cacheline_aligned;
+
+
 #endif

