Return-Path: <linux-kernel+bounces-35709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E371283956C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A482860F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE000129A63;
	Tue, 23 Jan 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aZcvd1hX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UwkqvgMn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918882D6B;
	Tue, 23 Jan 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028444; cv=none; b=e+Qz1ZmpPRbO9opTOAhk5hmT3brDUjzaOmb6gbugbPPOe0Fjyr58eZkcCjExfN/ELNF9Bk6zeosKar0CY38sroqOlqRVSubLC/G/KtNkhZXYJ/V0md/GdWjGSyKD4oGSot0HFRZYqy6J6t4LWWqc4zZAodgti06cPDszJSw7ET8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028444; c=relaxed/simple;
	bh=3LNhHfci3f3fHL8QZF2f9WWX+aZxoCrrzCZ6No3k10I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHlX4DyeDcI0YZzndulW7D5/cbH7boz0cs+RdQ0MAbnilEetdHPJ4DsHJZ6tllBvejJUSunb7obqrB0G/vcMtk/FhLo5TsAqRvmrQxgLVpjY23N+a37Y5R0FdREJjqBWvM+5zW+Hqss6Yu3d+EXXJdDyHho+3VEm51NI6vQyY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aZcvd1hX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UwkqvgMn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706028438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/rFGi6KLFOmslk7r4TJ7Hb4p+h1puESpm2cPfdBJRs=;
	b=aZcvd1hXwhFzktglpojoAQb5XGn4sr52kAr0yITbqWCVm1PQh6tjymxtET+Fmo6MzTFuV9
	spL4IHHd5m8kRwkGu/Ywdn0uS8LPNtRle5sh2ChUCt08MJASKLYJx1+PfQtuUDXqoyTBVs
	mX3SpWSQiqtIHDRAEBOgERL14UedN7HyAI3GKVPwNXjDSA9TWCErqSQdiPd1LG3k0x7YyY
	1WPn8C1OrPWDoQUJyUkJUC06NRRbfuz0KdESgWVSOT8o9IPlO7K6i1SoY+MKWIUBq9E8mq
	qVABTrZIOxf1Zt2H+k2G7+AKu/XdnuYiNyd9rZB314YbqGUOaSmArKVYwqJRdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706028438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/rFGi6KLFOmslk7r4TJ7Hb4p+h1puESpm2cPfdBJRs=;
	b=UwkqvgMnUEfksfbPBXe4jTkYP4krx6oXWr4h1yuDWuoQwe6dIrph6DXXIKPyQsIAavQnnN
	XmR/hmdanu4J0CBA==
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
Subject: [PATCH 8/8] timers: Add timer wheel documentation
Date: Tue, 23 Jan 2024 17:47:02 +0100
Message-Id: <20240123164702.55612-9-anna-maria@linutronix.de>
In-Reply-To: <20240123164702.55612-1-anna-maria@linutronix.de>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a lot of documentation inside the timer code. But this
documentation is not exported into the official kernel documentation.

Rework the comments to follow the rules of kernel-doc and rst. Create a new
documentation file about the timer wheel concept and another file which
contains information for the user of timer list timers.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 Documentation/core-api/timers/index.rst       |   6 +
 .../core-api/timers/timer-list-timers.rst     |  13 ++
 Documentation/core-api/timers/timer-wheel.rst |  38 +++++
 include/linux/timer.h                         |  15 +-
 kernel/time/timer.c                           | 139 ++++++++++--------
 5 files changed, 142 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/core-api/timers/timer-list-timers.rst
 create mode 100644 Documentation/core-api/timers/timer-wheel.rst

diff --git a/Documentation/core-api/timers/index.rst b/Documentation/core-api/timers/index.rst
index 2f99fc9d4f44..9f8f6afac859 100644
--- a/Documentation/core-api/timers/index.rst
+++ b/Documentation/core-api/timers/index.rst
@@ -20,7 +20,13 @@ Information for Users
    :maxdepth: 1
 
    api
+   timer-list-timers
 
 
 Information about concepts and internals
 ========================================
+
+.. toctree::
+   :maxdepth: 1
+
+   timer-wheel
diff --git a/Documentation/core-api/timers/timer-list-timers.rst b/Documentation/core-api/timers/timer-list-timers.rst
new file mode 100644
index 000000000000..ba2d3841098c
--- /dev/null
+++ b/Documentation/core-api/timers/timer-list-timers.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================
+Timer list timers - How to use them
+===================================
+
+Timer flags
+===========
+
+A timer list timer could have specified one of the following timer flags:
+
+.. kernel-doc:: include/linux/timer.h
+   :doc: Flags of the timer list timers
diff --git a/Documentation/core-api/timers/timer-wheel.rst b/Documentation/core-api/timers/timer-wheel.rst
new file mode 100644
index 000000000000..f0469445d2c6
--- /dev/null
+++ b/Documentation/core-api/timers/timer-wheel.rst
@@ -0,0 +1,38 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================================
+Timer wheel and timer list timers - Implementation Details
+===================================================================
+
+The timer wheel is the infrastructure to handle all timer list
+timers. Originally it was a cascading wheel and was reworked as a
+non-cascading timer wheel back in 2016 with commit 500462a9de65 ("timers:
+Switch to a non-cascading wheel").
+
+Concept
+=======
+
+.. kernel-doc:: kernel/time/timer.c
+   :doc: Concept of the timer wheel
+
+
+Locking of timer bases
+======================
+
+.. kernel-doc:: kernel/time/timer.c
+   :doc: Timer bases and hashed locking
+
+
+NOHZ and timer bases
+====================
+
+.. kernel-doc:: kernel/time/timer.c
+   :doc: NOHZ and timer bases
+
+
+How to use timer list timers
+============================
+
+See also the users guide for how to use timer list timers. Details which are
+important for the user are not listed here a second time to prevent duplicated
+information (:doc:`timer-list-timers`).
diff --git a/include/linux/timer.h b/include/linux/timer.h
index f18a2f1eb79e..b1ae19df17e1 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -23,6 +23,8 @@
 #endif
 
 /**
+ * DOC: Flags of the timer list timers
+ *
  * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
  * system is busy, but will not cause a CPU to come out of idle just
  * to service it; instead, the timer will be serviced when the CPU
@@ -40,12 +42,13 @@
  * placement heuristics (like, NOHZ) and will always expire on the CPU
  * on which the timer was enqueued.
  *
- * Note: Because enqueuing of timers can migrate the timer from one
- * CPU to another, pinned timers are not guaranteed to stay on the
- * initialy selected CPU.  They move to the CPU on which the enqueue
- * function is invoked via mod_timer() or add_timer().  If the timer
- * should be placed on a particular CPU, then add_timer_on() has to be
- * used.
+ * .. note::
+ *   Because enqueuing of timers can migrate the timer from one
+ *   CPU to another, pinned timers are not guaranteed to stay on the
+ *   initialy selected CPU.  They move to the CPU on which the enqueue
+ *   function is invoked via mod_timer() or add_timer().  If the timer
+ *   should be placed on a particular CPU, then add_timer_on() has to be
+ *   used.
  */
 #define TIMER_CPUMASK		0x0003FFFF
 #define TIMER_MIGRATING		0x00040000
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d44dba1d4af0..c001d8934172 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -61,13 +61,15 @@ __visible u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 
 EXPORT_SYMBOL(jiffies_64);
 
-/*
- * The timer wheel has LVL_DEPTH array levels. Each level provides an array of
- * LVL_SIZE buckets. Each level is driven by its own clock and therefor each
- * level has a different granularity.
+/**
+ * DOC: Concept of the timer wheel
+ *
+ * The timer wheel has ``LVL_DEPTH`` array levels. Each level provides an array
+ * of ``LVL_SIZE`` buckets. Each level is driven by its own clock and therefor
+ * each level has a different granularity.
  *
- * The level granularity is:		LVL_CLK_DIV ^ lvl
- * The level clock frequency is:	HZ / (LVL_CLK_DIV ^ level)
+ * * The level granularity is: ``LVL_CLK_DIV ^ lvl``
+ * * The level clock frequency is: ``HZ / (LVL_CLK_DIV ^ level)``
  *
  * The array level of a newly armed timer depends on the relative expiry
  * time. The farther the expiry time is away the higher the array level and
@@ -99,54 +101,54 @@ EXPORT_SYMBOL(jiffies_64);
  * The currently chosen array constants values are a good compromise between
  * array size and granularity.
  *
- * This results in the following granularity and range levels:
- *
- * HZ 1000 steps
- * Level Offset  Granularity            Range
- *  0      0         1 ms                0 ms -         63 ms
- *  1     64         8 ms               64 ms -        511 ms
- *  2    128        64 ms              512 ms -       4095 ms (512ms - ~4s)
- *  3    192       512 ms             4096 ms -      32767 ms (~4s - ~32s)
- *  4    256      4096 ms (~4s)      32768 ms -     262143 ms (~32s - ~4m)
- *  5    320     32768 ms (~32s)    262144 ms -    2097151 ms (~4m - ~34m)
- *  6    384    262144 ms (~4m)    2097152 ms -   16777215 ms (~34m - ~4h)
- *  7    448   2097152 ms (~34m)  16777216 ms -  134217727 ms (~4h - ~1d)
- *  8    512  16777216 ms (~4h)  134217728 ms - 1073741822 ms (~1d - ~12d)
- *
- * HZ  300
- * Level Offset  Granularity            Range
- *  0	   0         3 ms                0 ms -        210 ms
- *  1	  64        26 ms              213 ms -       1703 ms (213ms - ~1s)
- *  2	 128       213 ms             1706 ms -      13650 ms (~1s - ~13s)
- *  3	 192      1706 ms (~1s)      13653 ms -     109223 ms (~13s - ~1m)
- *  4	 256     13653 ms (~13s)    109226 ms -     873810 ms (~1m - ~14m)
- *  5	 320    109226 ms (~1m)     873813 ms -    6990503 ms (~14m - ~1h)
- *  6	 384    873813 ms (~14m)   6990506 ms -   55924050 ms (~1h - ~15h)
- *  7	 448   6990506 ms (~1h)   55924053 ms -  447392423 ms (~15h - ~5d)
- *  8    512  55924053 ms (~15h) 447392426 ms - 3579139406 ms (~5d - ~41d)
- *
- * HZ  250
- * Level Offset  Granularity            Range
- *  0	   0         4 ms                0 ms -        255 ms
- *  1	  64        32 ms              256 ms -       2047 ms (256ms - ~2s)
- *  2	 128       256 ms             2048 ms -      16383 ms (~2s - ~16s)
- *  3	 192      2048 ms (~2s)      16384 ms -     131071 ms (~16s - ~2m)
- *  4	 256     16384 ms (~16s)    131072 ms -    1048575 ms (~2m - ~17m)
- *  5	 320    131072 ms (~2m)    1048576 ms -    8388607 ms (~17m - ~2h)
- *  6	 384   1048576 ms (~17m)   8388608 ms -   67108863 ms (~2h - ~18h)
- *  7	 448   8388608 ms (~2h)   67108864 ms -  536870911 ms (~18h - ~6d)
- *  8    512  67108864 ms (~18h) 536870912 ms - 4294967288 ms (~6d - ~49d)
- *
- * HZ  100
- * Level Offset  Granularity            Range
- *  0	   0         10 ms               0 ms -        630 ms
- *  1	  64         80 ms             640 ms -       5110 ms (640ms - ~5s)
- *  2	 128        640 ms            5120 ms -      40950 ms (~5s - ~40s)
- *  3	 192       5120 ms (~5s)     40960 ms -     327670 ms (~40s - ~5m)
- *  4	 256      40960 ms (~40s)   327680 ms -    2621430 ms (~5m - ~43m)
- *  5	 320     327680 ms (~5m)   2621440 ms -   20971510 ms (~43m - ~5h)
- *  6	 384    2621440 ms (~43m) 20971520 ms -  167772150 ms (~5h - ~1d)
- *  7	 448   20971520 ms (~5h) 167772160 ms - 1342177270 ms (~1d - ~15d)
+ * This results in the following granularity and range levels::
+ *
+ *  HZ 1000 steps
+ *  Level Offset  Granularity            Range
+ *   0      0         1 ms                0 ms -         63 ms
+ *   1     64         8 ms               64 ms -        511 ms
+ *   2    128        64 ms              512 ms -       4095 ms (512ms - ~4s)
+ *   3    192       512 ms             4096 ms -      32767 ms (~4s - ~32s)
+ *   4    256      4096 ms (~4s)      32768 ms -     262143 ms (~32s - ~4m)
+ *   5    320     32768 ms (~32s)    262144 ms -    2097151 ms (~4m - ~34m)
+ *   6    384    262144 ms (~4m)    2097152 ms -   16777215 ms (~34m - ~4h)
+ *   7    448   2097152 ms (~34m)  16777216 ms -  134217727 ms (~4h - ~1d)
+ *   8    512  16777216 ms (~4h)  134217728 ms - 1073741822 ms (~1d - ~12d)
+ *
+ *  HZ  300
+ *  Level Offset  Granularity            Range
+ *   0     0         3 ms                0 ms -        210 ms
+ *   1    64        26 ms              213 ms -       1703 ms (213ms - ~1s)
+ *   2   128       213 ms             1706 ms -      13650 ms (~1s - ~13s)
+ *   3   192      1706 ms (~1s)      13653 ms -     109223 ms (~13s - ~1m)
+ *   4   256     13653 ms (~13s)    109226 ms -     873810 ms (~1m - ~14m)
+ *   5   320    109226 ms (~1m)     873813 ms -    6990503 ms (~14m - ~1h)
+ *   6   384    873813 ms (~14m)   6990506 ms -   55924050 ms (~1h - ~15h)
+ *   7   448   6990506 ms (~1h)   55924053 ms -  447392423 ms (~15h - ~5d)
+ *   8   512  55924053 ms (~15h) 447392426 ms - 3579139406 ms (~5d - ~41d)
+ *
+ *  HZ  250
+ *  Level Offset  Granularity            Range
+ *   0     0         4 ms                0 ms -        255 ms
+ *   1    64        32 ms              256 ms -       2047 ms (256ms - ~2s)
+ *   2   128       256 ms             2048 ms -      16383 ms (~2s - ~16s)
+ *   3   192      2048 ms (~2s)      16384 ms -     131071 ms (~16s - ~2m)
+ *   4   256     16384 ms (~16s)    131072 ms -    1048575 ms (~2m - ~17m)
+ *   5   320    131072 ms (~2m)    1048576 ms -    8388607 ms (~17m - ~2h)
+ *   6   384   1048576 ms (~17m)   8388608 ms -   67108863 ms (~2h - ~18h)
+ *   7   448   8388608 ms (~2h)   67108864 ms -  536870911 ms (~18h - ~6d)
+ *   8   512  67108864 ms (~18h) 536870912 ms - 4294967288 ms (~6d - ~49d)
+ *
+ *  HZ  100
+ *  Level Offset  Granularity            Range
+ *   0     0         10 ms               0 ms -        630 ms
+ *   1    64         80 ms             640 ms -       5110 ms (640ms - ~5s)
+ *   2   128        640 ms            5120 ms -      40950 ms (~5s - ~40s)
+ *   3   192       5120 ms (~5s)     40960 ms -     327670 ms (~40s - ~5m)
+ *   4   256      40960 ms (~40s)   327680 ms -    2621430 ms (~5m - ~43m)
+ *   5   320     327680 ms (~5m)   2621440 ms -   20971510 ms (~43m - ~5h)
+ *   6   384    2621440 ms (~43m) 20971520 ms -  167772150 ms (~5h - ~1d)
+ *   7   448   20971520 ms (~5h) 167772160 ms - 1342177270 ms (~1d - ~15d)
  */
 
 /* Clock divisor for the next level */
@@ -181,11 +183,20 @@ EXPORT_SYMBOL(jiffies_64);
 #define WHEEL_TIMEOUT_MAX	(WHEEL_TIMEOUT_CUTOFF - LVL_GRAN(LVL_DEPTH - 1))
 
 /*
- * The resulting wheel size. If NOHZ is configured we allocate two
- * wheels so we have a separate storage for the deferrable timers.
+ * The resulting wheel size.
  */
 #define WHEEL_SIZE	(LVL_SIZE * LVL_DEPTH)
 
+/**
+ * DOC: NOHZ and timer bases
+ *
+ * If NOHZ is configured two timer bases are allocated to have a separate
+ * storage for deferrable timers:
+ *
+ * @BASE_STD: Contains are all non deferrable timers
+ *
+ * @BASE_DEF: Contains all deferrable timers (with ``TIMER_DEFERRABLE`` flag)
+ */
 #ifdef CONFIG_NO_HZ_COMMON
 # define NR_BASES	2
 # define BASE_STD	0
@@ -1013,16 +1024,18 @@ static inline void forward_timer_base(struct timer_base *base)
 	__forward_timer_base(base, READ_ONCE(jiffies));
 }
 
-/*
- * We are using hashed locking: Holding per_cpu(timer_bases[x]).lock means
- * that all timers which are tied to this base are locked, and the base itself
- * is locked too.
+/**
+ * DOC: Timer bases and hashed locking
+ *
+ * For locking, hashed locking is used: Holding ``per_cpu(timer_bases[x]).lock``
+ * means that all timers which are tied to this base are locked, and the base
+ * itself is locked too.
  *
- * So __run_timers/migrate_timers can safely modify all timers which could
+ * So __run_timers()/migrate_timer_list() can safely modify all timers which could
  * be found in the base->vectors array.
  *
- * When a timer is migrating then the TIMER_MIGRATING flag is set and we need
- * to wait until the migration is done.
+ * When a timer is migrating then the ``TIMER_MIGRATING`` flag is set and it's
+ * required to wait before grabbing the lock, until the migration is done.
  */
 static struct timer_base *lock_timer_base(struct timer_list *timer,
 					  unsigned long *flags)
-- 
2.39.2


