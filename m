Return-Path: <linux-kernel+bounces-74358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF77285D314
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FE5284C75
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6BC3FB2D;
	Wed, 21 Feb 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nyXedZ4U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tGyZD5Ps"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83503D967
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506381; cv=none; b=ugUN//gixsh+jNJYQp9kFRx+r5x/5vgmd8pDnys8iGXS4uATdssViXO8nGXdVs1RW52PNgL4jR2yHzNDSobIxkZnHVVYeym8cj6uEKHEudr9eOFRsduDdUbwV1ztLOb1qGHPyqKh/EF+hj5hNXvMEaklfQdreiTeqpKJl4PsyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506381; c=relaxed/simple;
	bh=A1ak4c05RsMMc85EHNnnsqJhV5a1qxUJ9DF2MBZohj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X8n3bo0ZeJKuAhgjynaj07HZuQPaUzUYHkL8FCHPSE5mfDtuXpL1PEDqnw3EHa9o1yUd7JfTqHA+hFspNn7Kbv63Zc02IUG6zWhTI8ku7OLncPEWIRkRVM4pgpzhAaG8m4B2cH0jEhem353twPHBnqZGVKLftZLJFyxwG9FemTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nyXedZ4U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tGyZD5Ps; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7M+cLD3z/7BiBVC+tTh5mmcK9KmfYufY+d1NGfjIUd0=;
	b=nyXedZ4ULMKfhslx9q3MBFhD3FvdgJXdxLmS7rdCWmnguxXTcrGasMApsH5yxBaJmDV0bM
	4zGkijLbX5rjWdTXQ4xW4TgfEx5XXugDVd82s+HPg9k+p3cQSIjTmcOHYF5cobkjo/CRld
	uw5A1NYLuXE0km8oXvt0ULuhxY4m12QW4qbTi20kWYS9u4x4nW/kBIK0qWrRqvU21GP2E/
	dUVV0zCP6N598KXHNQSsLKWrOD/tvimhPiSMv8Ctl7go9r1a1oncyClCIezMfwdz0OVuFu
	DfLJUjJ9NUmHQ/V8dMelUO3AKziMWJPwQLVpSQkg2wexHwOA6Ud/JGmIVGrzSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7M+cLD3z/7BiBVC+tTh5mmcK9KmfYufY+d1NGfjIUd0=;
	b=tGyZD5Pslo4rbM64ULduxSkn9Zve72LNFv+ut6WRELNpeDBPyG/Mq/S2mEYluwGVPbn8MH
	/WGMnqEd2EyulpAA==
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v11 13/20] timers: Add get next timer interrupt functionality for remote CPUs
Date: Wed, 21 Feb 2024 10:05:41 +0100
Message-Id: <20240221090548.36600-14-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for the conversion of the NOHZ timer placement to a pull at
expiry time model it's required to have functionality available getting the
next timer interrupt on a remote CPU.

Locking of the timer bases and getting the information for the next timer
interrupt functionality is split into separate functions. This is required
to be compliant with lock ordering when the new model is in place.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v11:
 - Update tevt.global when global is first event to make sure during remote
   timer handling, this global timer does not get lost

v10:
 - sparse annotations for locks

v8:
 - Update comment

v7:
 - Move functions into CONFIG_SMP && CONFIG_NO_HZ_COMMON section
 - change lock, fetch functions to be unconditional
 - split out unlock function into a separate function

v6:
 - introduce timer_lock_remote_bases() to fix race
---
 kernel/time/tick-internal.h | 10 ++++
 kernel/time/timer.c         | 95 +++++++++++++++++++++++++++++++++++--
 2 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 47df30b871e4..8b0c28edbd09 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -8,6 +8,11 @@
 #include "timekeeping.h"
 #include "tick-sched.h"
 
+struct timer_events {
+	u64	local;
+	u64	global;
+};
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 # define TICK_DO_TIMER_NONE	-1
@@ -154,6 +159,11 @@ extern unsigned long tick_nohz_active;
 extern void timers_update_nohz(void);
 # ifdef CONFIG_SMP
 extern struct static_key_false timers_migration_enabled;
+extern void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
+					      struct timer_events *tevt,
+					      unsigned int cpu);
+extern void timer_lock_remote_bases(unsigned int cpu);
+extern void timer_unlock_remote_bases(unsigned int cpu);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
 static inline void timers_update_nohz(void) { }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9fa759dd80f5..88160b3461e0 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -221,11 +221,6 @@ struct timer_base {
 
 static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
 
-struct timer_events {
-	u64	local;
-	u64	global;
-};
-
 #ifdef CONFIG_NO_HZ_COMMON
 
 static DEFINE_STATIC_KEY_FALSE(timers_nohz_active);
@@ -2013,6 +2008,21 @@ static unsigned long fetch_next_timer_interrupt(unsigned long basej, u64 basem,
 		if (time_before(nextevt, basej))
 			nextevt = basej;
 		tevt->local = basem + (u64)(nextevt - basej) * TICK_NSEC;
+
+		/*
+		 * This is required for the remote check only but it doesn't
+		 * hurt, when it is done for both call sites:
+		 *
+		 * * The remote callers will only take care of the global timers
+		 *   as local timers will be handled by CPU itself. When not
+		 *   updating tevt->global with the already missed first global
+		 *   timer, it is possible that it will be missed completely.
+		 *
+		 * * The local callers will ignore the tevt->global anyway, when
+		 *   nextevt is max. one tick away.
+		 */
+		if (!local_first)
+			tevt->global = tevt->local;
 		return nextevt;
 	}
 
@@ -2031,6 +2041,81 @@ static unsigned long fetch_next_timer_interrupt(unsigned long basej, u64 basem,
 	return nextevt;
 }
 
+# ifdef CONFIG_SMP
+/**
+ * fetch_next_timer_interrupt_remote() - Store next timers into @tevt
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ * @tevt:	Pointer to the storage for the expiry values
+ * @cpu:	Remote CPU
+ *
+ * Stores the next pending local and global timer expiry values in the
+ * struct pointed to by @tevt. If a queue is empty the corresponding
+ * field is set to KTIME_MAX. If local event expires before global
+ * event, global event is set to KTIME_MAX as well.
+ *
+ * Caller needs to make sure timer base locks are held (use
+ * timer_lock_remote_bases() for this purpose).
+ */
+void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
+				       struct timer_events *tevt,
+				       unsigned int cpu)
+{
+	struct timer_base *base_local, *base_global;
+
+	/* Preset local / global events */
+	tevt->local = tevt->global = KTIME_MAX;
+
+	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	lockdep_assert_held(&base_local->lock);
+	lockdep_assert_held(&base_global->lock);
+
+	fetch_next_timer_interrupt(basej, basem, base_local, base_global, tevt);
+}
+
+/**
+ * timer_unlock_remote_bases - unlock timer bases of cpu
+ * @cpu:	Remote CPU
+ *
+ * Unlocks the remote timer bases.
+ */
+void timer_unlock_remote_bases(unsigned int cpu)
+	__releases(timer_bases[BASE_LOCAL]->lock)
+	__releases(timer_bases[BASE_GLOBAL]->lock)
+{
+	struct timer_base *base_local, *base_global;
+
+	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	raw_spin_unlock(&base_global->lock);
+	raw_spin_unlock(&base_local->lock);
+}
+
+/**
+ * timer_lock_remote_bases - lock timer bases of cpu
+ * @cpu:	Remote CPU
+ *
+ * Locks the remote timer bases.
+ */
+void timer_lock_remote_bases(unsigned int cpu)
+	__acquires(timer_bases[BASE_LOCAL]->lock)
+	__acquires(timer_bases[BASE_GLOBAL]->lock)
+{
+	struct timer_base *base_local, *base_global;
+
+	base_local = per_cpu_ptr(&timer_bases[BASE_LOCAL], cpu);
+	base_global = per_cpu_ptr(&timer_bases[BASE_GLOBAL], cpu);
+
+	lockdep_assert_irqs_disabled();
+
+	raw_spin_lock(&base_local->lock);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+}
+# endif /* CONFIG_SMP */
+
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 					     bool *idle)
 {
-- 
2.39.2


