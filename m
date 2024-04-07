Return-Path: <linux-kernel+bounces-134232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F2189AF53
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A101C21215
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37DF1173F;
	Sun,  7 Apr 2024 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr5JBz//"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49F33D7A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712476998; cv=none; b=MXlcvtbzAJfJ43fqvWqoC47ds+bn3uk3797zCjX3iRblELkEBsX27D0yhfJJu0ugDSU+wer5Xx9zs6iySghGF+e3AWvEYHjObes4xL1057Bkit0AXRzpd3M7oUlSwY/foPqFfEfPFCGuFDv7BXJ/YhUiXXZvd0MfGKeB9oNIyc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712476998; c=relaxed/simple;
	bh=CN2BV3XME9WRvdvYPbjBaIUVvZrwssMX4QhIThv3yko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lmOzZ6vBSH05Jz3WxQu0t+no/HfDzRZ4hSf+K3ni26nq+jvwnz5MZycQEZaHqzkcOAL8gdIYczgADKEjuWKA8KvxfXvO1CRAZvq8TjrO5EiskT0nk1v3+WEEOSYmXPUdu1IYtt2vhQbVl2A9ib3hr8Nmg7VIe2DbUDP+5otJA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fr5JBz//; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d886dd4f18so2530141fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712476994; x=1713081794; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=t7LPR+gGyuLUvRr5iHyO4SWVgpiE0pa0IZwPafAQEcE=;
        b=Fr5JBz//VcSm0emJDujX+Kk0TPj9GEdyL70DKtRml5lUlbptmCvhkAxhBRGoDnDR4u
         Jq/vKnbNuY0zaaixwLmp7G7zmaxOE2ilpMp13oZYJgmJQOvsDU1lCoANnkbwiG53P5P4
         Etl4oWBeX3FnoxdXDjsjPzRmtVldVrNrualXr6+dhVto5Mj7C+qhDH078c3bZ5gAIfXr
         jZtC8W+C7lI2UDmI807Sjrr9OE+a9hGSOEIY0MQ4qLATP8rqokbIm8JrnijMJ6SSIQC/
         ZmyE9eyWoQZnbuJFub+s9r7CW6waDMpA2cLhI2OOJmFavbppf98nS2L4tW2Azu75xxpn
         3m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712476994; x=1713081794;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7LPR+gGyuLUvRr5iHyO4SWVgpiE0pa0IZwPafAQEcE=;
        b=YzUfFdsyUdOaZA3KETW+Xt8f0Ux++NcxzDLGx/bQJThwIDQGAMGaVhaEjWy+6a8fHg
         NMViIzi0lhLpkUPQWoKeGjNUCQeSfvUDawzhRLa4NvCjCT0Ywt0/RPuZ0LxWq0Ek1Qvt
         hz/CnWq0OFKL2CY4AAhLi08x/Vyb4wFqiKO6ZsksFix37H7CB9E+Sl8YpVJQTYZTZTB7
         ScFr7d4al1QypvXhrZo/TpRNV9OQSvXT6YOGOnAIFZ9kJny8Jl0wsprJMeYsBlgfFpso
         n5aex31tHZGv/DjuomZsKnum6Zm1SwugCspN+PaktysJHNCGaOhtkOKBj8iwy3PQjpMD
         tt4g==
X-Gm-Message-State: AOJu0YzkBM3mS+S3ghY4x+JExvzWgLDqBWfdykun1tK2gQoY1kEJ+LKi
	hKS0M9nNlHX9K9WpifKUWSquuj6H4G9uaUkQLx2IznfGZEk21hJqBkr0BNw4pWk=
X-Google-Smtp-Source: AGHT+IEqfMIXQlCmvVgJLemlx5a2wFXUWXyivHfjpzZXtRN46VZzAQFAxvlvT2z7hua4x55bvs9Apw==
X-Received: by 2002:a2e:a545:0:b0:2d8:781c:7b9c with SMTP id e5-20020a2ea545000000b002d8781c7b9cmr2586926ljn.5.1712476993346;
        Sun, 07 Apr 2024 01:03:13 -0700 (PDT)
Received: from gmail.com (84-236-113-28.pool.digikabel.hu. [84.236.113.28])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c468a00b00415f496b9b7sm10019083wmo.39.2024.04.07.01.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:03:12 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 7 Apr 2024 10:03:10 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [GIT PULL] timer fixes
Message-ID: <ZhJTPt6s4Kwibcas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest timers/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-04-07

   # HEAD: 7a96a84bfbee96871bb16c70ee3e93d564e190f4 timers/migration: Return early on deactivation

Fix various timer bugs:

 - Fix a timer migration bug that may result in missed events
 - Fix timer migration group hierarchy event updates
 - Fix a PowerPC64 build warning
 - Fix a handful of DocBook annotation bugs

 Thanks,

	Ingo

------------------>
Anna-Maria Behnsen (1):
      timers/migration: Return early on deactivation

Arnd Bergmann (1):
      vdso: Use CONFIG_PAGE_SHIFT in vdso/datapage.h

Frederic Weisbecker (1):
      timers/migration: Fix ignored event due to missing CPU update

Randy Dunlap (6):
      time/timecounter: Fix inline documentation
      time/timekeeping: Fix kernel-doc warnings and typos
      timers: Fix kernel-doc format and add Return values
      tick/sched: Fix various kernel-doc warnings
      tick/sched: Fix struct tick_sched doc warnings
      timers: Fix text inconsistencies and spelling


 arch/powerpc/include/asm/vdso/gettimeofday.h |  3 +-
 include/linux/timecounter.h                  | 11 +++++--
 include/linux/timekeeping.h                  | 49 ++++++++++++++++++++++++----
 include/linux/timer.h                        | 12 +++++--
 include/vdso/datapage.h                      |  8 +----
 kernel/time/tick-sched.c                     | 18 ++++++++--
 kernel/time/tick-sched.h                     |  2 +-
 kernel/time/timer.c                          | 22 ++++++-------
 kernel/time/timer_migration.c                | 32 +++++++++++++++++-
 9 files changed, 121 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index f0a4cf01e85c..78302f6c2580 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -4,7 +4,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <asm/page.h>
 #include <asm/vdso/timebase.h>
 #include <asm/barrier.h>
 #include <asm/unistd.h>
@@ -95,7 +94,7 @@ const struct vdso_data *__arch_get_vdso_data(void);
 static __always_inline
 const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
-	return (void *)vd + PAGE_SIZE;
+	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
 }
 #endif
 
diff --git a/include/linux/timecounter.h b/include/linux/timecounter.h
index c6540ceea143..0982d1d52b24 100644
--- a/include/linux/timecounter.h
+++ b/include/linux/timecounter.h
@@ -22,7 +22,7 @@
  *
  * @read:		returns the current cycle value
  * @mask:		bitmask for two's complement
- *			subtraction of non 64 bit counters,
+ *			subtraction of non-64-bit counters,
  *			see CYCLECOUNTER_MASK() helper macro
  * @mult:		cycle to nanosecond multiplier
  * @shift:		cycle to nanosecond divisor (power of two)
@@ -35,7 +35,7 @@ struct cyclecounter {
 };
 
 /**
- * struct timecounter - layer above a %struct cyclecounter which counts nanoseconds
+ * struct timecounter - layer above a &struct cyclecounter which counts nanoseconds
  *	Contains the state needed by timecounter_read() to detect
  *	cycle counter wrap around. Initialize with
  *	timecounter_init(). Also used to convert cycle counts into the
@@ -66,6 +66,8 @@ struct timecounter {
  * @cycles:	Cycles
  * @mask:	bit mask for maintaining the 'frac' field
  * @frac:	pointer to storage for the fractional nanoseconds.
+ *
+ * Returns: cycle counter cycles converted to nanoseconds
  */
 static inline u64 cyclecounter_cyc2ns(const struct cyclecounter *cc,
 				      u64 cycles, u64 mask, u64 *frac)
@@ -79,6 +81,7 @@ static inline u64 cyclecounter_cyc2ns(const struct cyclecounter *cc,
 
 /**
  * timecounter_adjtime - Shifts the time of the clock.
+ * @tc:		The &struct timecounter to adjust
  * @delta:	Desired change in nanoseconds.
  */
 static inline void timecounter_adjtime(struct timecounter *tc, s64 delta)
@@ -107,6 +110,8 @@ extern void timecounter_init(struct timecounter *tc,
  *
  * In other words, keeps track of time since the same epoch as
  * the function which generated the initial time stamp.
+ *
+ * Returns: nanoseconds since the initial time stamp
  */
 extern u64 timecounter_read(struct timecounter *tc);
 
@@ -123,6 +128,8 @@ extern u64 timecounter_read(struct timecounter *tc);
  *
  * This allows conversion of cycle counter values which were generated
  * in the past.
+ *
+ * Returns: cycle counter converted to nanoseconds since the initial time stamp
  */
 extern u64 timecounter_cyc2time(const struct timecounter *tc,
 				u64 cycle_tstamp);
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 7e50cbd97f86..0ea7823b7f31 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -22,14 +22,14 @@ extern int do_sys_settimeofday64(const struct timespec64 *tv,
 				 const struct timezone *tz);
 
 /*
- * ktime_get() family: read the current time in a multitude of ways,
+ * ktime_get() family - read the current time in a multitude of ways.
  *
  * The default time reference is CLOCK_MONOTONIC, starting at
  * boot time but not counting the time spent in suspend.
  * For other references, use the functions with "real", "clocktai",
  * "boottime" and "raw" suffixes.
  *
- * To get the time in a different format, use the ones wit
+ * To get the time in a different format, use the ones with
  * "ns", "ts64" and "seconds" suffix.
  *
  * See Documentation/core-api/timekeeping.rst for more details.
@@ -74,6 +74,8 @@ extern u32 ktime_get_resolution_ns(void);
 
 /**
  * ktime_get_real - get the real (wall-) time in ktime_t format
+ *
+ * Returns: real (wall) time in ktime_t format
  */
 static inline ktime_t ktime_get_real(void)
 {
@@ -86,10 +88,12 @@ static inline ktime_t ktime_get_coarse_real(void)
 }
 
 /**
- * ktime_get_boottime - Returns monotonic time since boot in ktime_t format
+ * ktime_get_boottime - Get monotonic time since boot in ktime_t format
  *
  * This is similar to CLOCK_MONTONIC/ktime_get, but also includes the
  * time spent in suspend.
+ *
+ * Returns: monotonic time since boot in ktime_t format
  */
 static inline ktime_t ktime_get_boottime(void)
 {
@@ -102,7 +106,9 @@ static inline ktime_t ktime_get_coarse_boottime(void)
 }
 
 /**
- * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
+ * ktime_get_clocktai - Get the TAI time of day in ktime_t format
+ *
+ * Returns: the TAI time of day in ktime_t format
  */
 static inline ktime_t ktime_get_clocktai(void)
 {
@@ -144,32 +150,60 @@ static inline u64 ktime_get_coarse_clocktai_ns(void)
 
 /**
  * ktime_mono_to_real - Convert monotonic time to clock realtime
+ * @mono: monotonic time to convert
+ *
+ * Returns: time converted to realtime clock
  */
 static inline ktime_t ktime_mono_to_real(ktime_t mono)
 {
 	return ktime_mono_to_any(mono, TK_OFFS_REAL);
 }
 
+/**
+ * ktime_get_ns - Get the current time in nanoseconds
+ *
+ * Returns: current time converted to nanoseconds
+ */
 static inline u64 ktime_get_ns(void)
 {
 	return ktime_to_ns(ktime_get());
 }
 
+/**
+ * ktime_get_real_ns - Get the current real/wall time in nanoseconds
+ *
+ * Returns: current real time converted to nanoseconds
+ */
 static inline u64 ktime_get_real_ns(void)
 {
 	return ktime_to_ns(ktime_get_real());
 }
 
+/**
+ * ktime_get_boottime_ns - Get the monotonic time since boot in nanoseconds
+ *
+ * Returns: current boottime converted to nanoseconds
+ */
 static inline u64 ktime_get_boottime_ns(void)
 {
 	return ktime_to_ns(ktime_get_boottime());
 }
 
+/**
+ * ktime_get_clocktai_ns - Get the current TAI time of day in nanoseconds
+ *
+ * Returns: current TAI time converted to nanoseconds
+ */
 static inline u64 ktime_get_clocktai_ns(void)
 {
 	return ktime_to_ns(ktime_get_clocktai());
 }
 
+/**
+ * ktime_get_raw_ns - Get the raw monotonic time in nanoseconds
+ *
+ * Returns: current raw monotonic time converted to nanoseconds
+ */
 static inline u64 ktime_get_raw_ns(void)
 {
 	return ktime_to_ns(ktime_get_raw());
@@ -224,8 +258,8 @@ extern bool timekeeping_rtc_skipresume(void);
 
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
-/*
- * struct ktime_timestanps - Simultaneous mono/boot/real timestamps
+/**
+ * struct ktime_timestamps - Simultaneous mono/boot/real timestamps
  * @mono:	Monotonic timestamp
  * @boot:	Boottime timestamp
  * @real:	Realtime timestamp
@@ -242,7 +276,8 @@ struct ktime_timestamps {
  * @cycles:	Clocksource counter value to produce the system times
  * @real:	Realtime system time
  * @raw:	Monotonic raw system time
- * @clock_was_set_seq:	The sequence number of clock was set events
+ * @cs_id:	Clocksource ID
+ * @clock_was_set_seq:	The sequence number of clock-was-set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
  */
 struct system_time_snapshot {
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 14a633ba61d6..e67ecd1cbc97 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -22,7 +22,7 @@
 #define __TIMER_LOCKDEP_MAP_INITIALIZER(_kn)
 #endif
 
-/**
+/*
  * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
  * system is busy, but will not cause a CPU to come out of idle just
  * to service it; instead, the timer will be serviced when the CPU
@@ -140,7 +140,7 @@ static inline void destroy_timer_on_stack(struct timer_list *timer) { }
  * or not. Callers must ensure serialization wrt. other operations done
  * to this timer, eg. interrupt contexts, or other CPUs on SMP.
  *
- * return value: 1 if the timer is pending, 0 if not.
+ * Returns: 1 if the timer is pending, 0 if not.
  */
 static inline int timer_pending(const struct timer_list * timer)
 {
@@ -175,6 +175,10 @@ extern int timer_shutdown(struct timer_list *timer);
  * See timer_delete_sync() for detailed explanation.
  *
  * Do not use in new code. Use timer_delete_sync() instead.
+ *
+ * Returns:
+ * * %0	- The timer was not pending
+ * * %1	- The timer was pending and deactivated
  */
 static inline int del_timer_sync(struct timer_list *timer)
 {
@@ -188,6 +192,10 @@ static inline int del_timer_sync(struct timer_list *timer)
  * See timer_delete() for detailed explanation.
  *
  * Do not use in new code. Use timer_delete() instead.
+ *
+ * Returns:
+ * * %0	- The timer was not pending
+ * * %1	- The timer was pending and deactivated
  */
 static inline int del_timer(struct timer_list *timer)
 {
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 5d5c0b8efff2..c71ddb6d4691 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,12 +19,6 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
-#ifdef CONFIG_ARM64
-#include <asm/page-def.h>
-#else
-#include <asm/page.h>
-#endif
-
 #ifdef CONFIG_ARCH_HAS_VDSO_DATA
 #include <asm/vdso/data.h>
 #else
@@ -132,7 +126,7 @@ extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden
  */
 union vdso_data_store {
 	struct vdso_data	data[CS_BASES];
-	u8			page[PAGE_SIZE];
+	u8			page[1U << CONFIG_PAGE_SHIFT];
 };
 
 /*
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 269e21590df5..1331216a9cae 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -697,6 +697,7 @@ bool tick_nohz_tick_stopped_cpu(int cpu)
 
 /**
  * tick_nohz_update_jiffies - update jiffies when idle was interrupted
+ * @now: current ktime_t
  *
  * Called from interrupt entry when the CPU was idle
  *
@@ -794,7 +795,7 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * This function returns -1 if NOHZ is not enabled.
+ * Return: -1 if NOHZ is not enabled, else total idle time of the @cpu
  */
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
@@ -820,7 +821,7 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * This function returns -1 if NOHZ is not enabled.
+ * Return: -1 if NOHZ is not enabled, else total iowait time of @cpu
  */
 u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
@@ -1287,6 +1288,8 @@ void tick_nohz_irq_exit(void)
 
 /**
  * tick_nohz_idle_got_tick - Check whether or not the tick handler has run
+ *
+ * Return: %true if the tick handler has run, otherwise %false
  */
 bool tick_nohz_idle_got_tick(void)
 {
@@ -1305,6 +1308,8 @@ bool tick_nohz_idle_got_tick(void)
  * stopped, it returns the next hrtimer.
  *
  * Called from power state control code with interrupts disabled
+ *
+ * Return: the next expiration time
  */
 ktime_t tick_nohz_get_next_hrtimer(void)
 {
@@ -1320,6 +1325,8 @@ ktime_t tick_nohz_get_next_hrtimer(void)
  * The return value of this function and/or the value returned by it through the
  * @delta_next pointer can be negative which must be taken into account by its
  * callers.
+ *
+ * Return: the expected length of the current sleep
  */
 ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 {
@@ -1357,8 +1364,11 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 /**
  * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
  * for a particular CPU.
+ * @cpu: target CPU number
  *
  * Called from the schedutil frequency scaling governor in scheduler context.
+ *
+ * Return: the current idle calls counter value for @cpu
  */
 unsigned long tick_nohz_get_idle_calls_cpu(int cpu)
 {
@@ -1371,6 +1381,8 @@ unsigned long tick_nohz_get_idle_calls_cpu(int cpu)
  * tick_nohz_get_idle_calls - return the current idle calls counter value
  *
  * Called from the schedutil frequency scaling governor in scheduler context.
+ *
+ * Return: the current idle calls counter value for the current CPU
  */
 unsigned long tick_nohz_get_idle_calls(void)
 {
@@ -1559,7 +1571,7 @@ early_param("skew_tick", skew_tick);
 
 /**
  * tick_setup_sched_timer - setup the tick emulation timer
- * @mode: tick_nohz_mode to setup for
+ * @hrtimer: whether to use the hrtimer or not
  */
 void tick_setup_sched_timer(bool hrtimer)
 {
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index e11c4dc65bcb..b4a7822f495d 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -46,8 +46,8 @@ struct tick_device {
  * @next_tick:		Next tick to be fired when in dynticks mode.
  * @idle_jiffies:	jiffies at the entry to idle for idle time accounting
  * @idle_waketime:	Time when the idle was interrupted
+ * @idle_sleeptime_seq:	sequence counter for data consistency
  * @idle_entrytime:	Time when the idle call was entered
- * @nohz_mode:		Mode - one state of tick_nohz_mode
  * @last_jiffies:	Base jiffies snapshot when next event was last computed
  * @timer_expires_base:	Base time clock monotonic for @timer_expires
  * @timer_expires:	Anticipated timer expiration time (in case sched tick is stopped)
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index dee29f1f5b75..3baf2fbe6848 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -64,15 +64,15 @@ EXPORT_SYMBOL(jiffies_64);
 
 /*
  * The timer wheel has LVL_DEPTH array levels. Each level provides an array of
- * LVL_SIZE buckets. Each level is driven by its own clock and therefor each
+ * LVL_SIZE buckets. Each level is driven by its own clock and therefore each
  * level has a different granularity.
  *
- * The level granularity is:		LVL_CLK_DIV ^ lvl
+ * The level granularity is:		LVL_CLK_DIV ^ level
  * The level clock frequency is:	HZ / (LVL_CLK_DIV ^ level)
  *
  * The array level of a newly armed timer depends on the relative expiry
  * time. The farther the expiry time is away the higher the array level and
- * therefor the granularity becomes.
+ * therefore the granularity becomes.
  *
  * Contrary to the original timer wheel implementation, which aims for 'exact'
  * expiry of the timers, this implementation removes the need for recascading
@@ -207,7 +207,7 @@ EXPORT_SYMBOL(jiffies_64);
  * struct timer_base - Per CPU timer base (number of base depends on config)
  * @lock:		Lock protecting the timer_base
  * @running_timer:	When expiring timers, the lock is dropped. To make
- *			sure not to race agains deleting/modifying a
+ *			sure not to race against deleting/modifying a
  *			currently running timer, the pointer is set to the
  *			timer, which expires at the moment. If no timer is
  *			running, the pointer is NULL.
@@ -737,7 +737,7 @@ static bool timer_is_static_object(void *addr)
 }
 
 /*
- * fixup_init is called when:
+ * timer_fixup_init is called when:
  * - an active object is initialized
  */
 static bool timer_fixup_init(void *addr, enum debug_obj_state state)
@@ -761,7 +761,7 @@ static void stub_timer(struct timer_list *unused)
 }
 
 /*
- * fixup_activate is called when:
+ * timer_fixup_activate is called when:
  * - an active object is activated
  * - an unknown non-static object is activated
  */
@@ -783,7 +783,7 @@ static bool timer_fixup_activate(void *addr, enum debug_obj_state state)
 }
 
 /*
- * fixup_free is called when:
+ * timer_fixup_free is called when:
  * - an active object is freed
  */
 static bool timer_fixup_free(void *addr, enum debug_obj_state state)
@@ -801,7 +801,7 @@ static bool timer_fixup_free(void *addr, enum debug_obj_state state)
 }
 
 /*
- * fixup_assert_init is called when:
+ * timer_fixup_assert_init is called when:
  * - an untracked/uninit-ed object is found
  */
 static bool timer_fixup_assert_init(void *addr, enum debug_obj_state state)
@@ -914,7 +914,7 @@ static void do_init_timer(struct timer_list *timer,
  * @key: lockdep class key of the fake lock used for tracking timer
  *       sync lock dependencies
  *
- * init_timer_key() must be done to a timer prior calling *any* of the
+ * init_timer_key() must be done to a timer prior to calling *any* of the
  * other timer functions.
  */
 void init_timer_key(struct timer_list *timer,
@@ -1417,7 +1417,7 @@ static int __timer_delete(struct timer_list *timer, bool shutdown)
 	 * If @shutdown is set then the lock has to be taken whether the
 	 * timer is pending or not to protect against a concurrent rearm
 	 * which might hit between the lockless pending check and the lock
-	 * aquisition. By taking the lock it is ensured that such a newly
+	 * acquisition. By taking the lock it is ensured that such a newly
 	 * enqueued timer is dequeued and cannot end up with
 	 * timer->function == NULL in the expiry code.
 	 *
@@ -2306,7 +2306,7 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 
 		/*
 		 * When timer base is not set idle, undo the effect of
-		 * tmigr_cpu_deactivate() to prevent inconsitent states - active
+		 * tmigr_cpu_deactivate() to prevent inconsistent states - active
 		 * timer base but inactive timer migration hierarchy.
 		 *
 		 * When timer base was already marked idle, nothing will be
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c63a0afdcebe..ccba875d2234 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -751,6 +751,33 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 
 		first_childevt = evt = data->evt;
 
+		/*
+		 * Walking the hierarchy is required in any case when a
+		 * remote expiry was done before. This ensures to not lose
+		 * already queued events in non active groups (see section
+		 * "Required event and timerqueue update after a remote
+		 * expiry" in the documentation at the top).
+		 *
+		 * The two call sites which are executed without a remote expiry
+		 * before, are not prevented from propagating changes through
+		 * the hierarchy by the return:
+		 *  - When entering this path by tmigr_new_timer(), @evt->ignore
+		 *    is never set.
+		 *  - tmigr_inactive_up() takes care of the propagation by
+		 *    itself and ignores the return value. But an immediate
+		 *    return is possible if there is a parent, sparing group
+		 *    locking at this level, because the upper walking call to
+		 *    the parent will take care about removing this event from
+		 *    within the group and update next_expiry accordingly.
+		 *
+		 * However if there is no parent, ie: the hierarchy has only a
+		 * single level so @group is the top level group, make sure the
+		 * first event information of the group is updated properly and
+		 * also handled properly, so skip this fast return path.
+		 */
+		if (evt->ignore && !remote && group->parent)
+			return true;
+
 		raw_spin_lock(&group->lock);
 
 		childstate.state = 0;
@@ -762,8 +789,11 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 	 * queue when the expiry time changed only or when it could be ignored.
 	 */
 	if (timerqueue_node_queued(&evt->nextevt)) {
-		if ((evt->nextevt.expires == nextexp) && !evt->ignore)
+		if ((evt->nextevt.expires == nextexp) && !evt->ignore) {
+			/* Make sure not to miss a new CPU event with the same expiry */
+			evt->cpu = first_childevt->cpu;
 			goto check_toplvl;
+		}
 
 		if (!timerqueue_del(&group->events, &evt->nextevt))
 			WRITE_ONCE(group->next_expiry, KTIME_MAX);

