Return-Path: <linux-kernel+bounces-35701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF983957A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E683B2321F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01A2823CF;
	Tue, 23 Jan 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y/QQqeuL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YaBAj9s4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E981AD4;
	Tue, 23 Jan 2024 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028439; cv=none; b=UYVGmkZhbOs37Z66iv00n6ts1/LRwt/tC8sO5J5XenQwurET0oxCll8LSmeDO+e/7Rwv52Nv4CH5p5CKMdFYlzTRNv2TjsWHYFQ0Z8qjB9EnMgKYaUcuykYvpzAujT3UtEeGTq4Z02VlU1DzDnPvpyQuP4r8uW2+ND4h72OVCSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028439; c=relaxed/simple;
	bh=bX7fuTKu2BCLrBdyLmngaZOPLBAKuCahp8JdL0FUnWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uEOxwAC8ApAXcj3V+iKbsYDUwpZ6wPwXWJgdIRd9S4nt4r3K/uIfhULT0X+82zPwGX5Pa3yFGlA/zWA0vwdOHI5SYhhi1hTHTbDl/sqhF180ktCekuMXKG9ssQu/HHDNa5qBtlMb0rTp5cGGoe57jBhUTUQNm+Bmrg+PBG90vu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y/QQqeuL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YaBAj9s4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706028435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfTDt6aPz62rV806CfoeHxKKD7o7Ht8+FmIptV0yh7g=;
	b=y/QQqeuLECuIW8WkZWogpntfSkoK+YLtgxeoE0dF6y5jtmGsatmnaGRfzCwdu27XQfmF7t
	A5P94z4YNNZM1uWGpYJOXJYDcq92yiUuBmlq4THJ+XLuPeuWXGza+dUIHshKDuGMG0nHQM
	/IZic60FSpuCpVHvXLgqe2IfTwlFgy5SI7oCuzqjNmvY4h8AVcS8s4x4/ejsR3hMxaqppd
	LkC6SoWOnjYuMItHVIrqWmmIEmp5vPQkwPIZgmI6qlsVovLvfDPJNmX/InAUio1mI3OqDM
	WdBSwNsMxbQiRvphwhVIcfocV2CLM6RcPAA6cppjReNggDE0+77v0JAOJL6OtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706028435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfTDt6aPz62rV806CfoeHxKKD7o7Ht8+FmIptV0yh7g=;
	b=YaBAj9s4KrfS9Vk66W0YDX3sSr7JxKvaPxWzLf0F1TmZPxCS/NxjFYfSgmUAOpu9nEE07p
	hCXfgBIozzaFeVBg==
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Clemens Ladisch <clemens@ladisch.de>,
	linux-doc@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 1/8] include/hrtimers: Move hrtimer base related definitions into hrtimer_defs
Date: Tue, 23 Jan 2024 17:46:55 +0100
Message-Id: <20240123164702.55612-2-anna-maria@linutronix.de>
In-Reply-To: <20240123164702.55612-1-anna-maria@linutronix.de>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hrtimer base related struct definitions are part of hrtimers.h as it is
required there. With this, also the struct documentation which is for core
code internal use, is exposed into the general api. To prevent this, all
core internal definitions and the related includes are moved into
hrtimer_defs header file.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/linux/hrtimer.h      | 103 -----------------------------------
 include/linux/hrtimer_defs.h | 102 ++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 103 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 87e3bedf8eb0..792a0ac75378 100644
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
index 2d3e3c5fb946..b12869dba59a 100644
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
-- 
2.39.2


