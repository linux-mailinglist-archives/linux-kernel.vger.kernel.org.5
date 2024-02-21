Return-Path: <linux-kernel+bounces-74363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DA585D318
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09960B2221A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6770F41757;
	Wed, 21 Feb 2024 09:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i+8YJTPe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wa8EvOGU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48CD3E49C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506384; cv=none; b=DC8SHdd5AD9acPcZCX3x3LmXd9f9smqbKeLgDZpLqd3RtHRVvNrnPBJgdcTEo0vwqI6q+MfpXb0eVF8saUkWGYlus1t3lOWZT4GJP0+bb7qiQ90XzBLQFY+KxCDpXVZ+CdNDMRzpK0KZZukvpaveQIXqb/LPAa/vsPEGbRYnbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506384; c=relaxed/simple;
	bh=KMdGvqAqNunk9f49u3SAzHLnc4ZmsFKul3Ua8+evWDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TYAlJ2PEJuSOHDQpax3LCPfcPF95x0MytOyqmdhoSME6E5jk6n+OGGYnIXhWS01HkLUa/QZKNbX5iqZBw8BKgrorzyeClYCE8v1rFmw+jYQTkkDLFe+yzIf+T2J7ixVg6BzpvPtfMKZI1s2fdk7jdpNpEtBUpqw4DrlP1ESSI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i+8YJTPe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wa8EvOGU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeKqlLMkWK4hDy9uLHYSPeSLgMoip1gsYk9scrtIqMg=;
	b=i+8YJTPebGk1WVJrX3XNgQONZjwIY4Iv+gVXLqBX3z9f92R5yM3rcIeT1GxvVOu7NMJsDh
	1EqBTECCn/SA2aXJ4DuGeyBCiMKDDkuzLMxUCrihkQFAuSHdYbqLg1stINWsMzBLfeossT
	EygREtcXqgdsDqoySEvmKUTVwoIbv2CoFzGNWME6pv6mBZRrP+QpWE8TnrKcmM+/6kC7Oh
	LH0UdZiCoAvTbsQ3vl8nCRa+JnbnFDZE1CZd3bYfgMeRJ1/6/sMihg6cYKIbTmq2CAz7CM
	qBIEHIHwjT+sqtonq2A7kRT1S7dUKNNKYLqu0Ht0gj1SMHFoPalgZ7izku8SnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeKqlLMkWK4hDy9uLHYSPeSLgMoip1gsYk9scrtIqMg=;
	b=Wa8EvOGUcNwj0imH5TRhabVRJOouUi/urXpTv/E0Us3Ng/dWEGrES3E7V+Zb34Rg0Qmb8S
	DwzAVjq+mL7DGLAA==
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
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v11 20/20] timers: Always queue timers on the local CPU
Date: Wed, 21 Feb 2024 10:05:48 +0100
Message-Id: <20240221090548.36600-21-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timer pull model is in place so we can remove the heuristics which try
to guess the best target CPU at enqueue/modification time.

All non pinned timers are queued on the local CPU in the separate storage
and eventually pulled at expiry time to a remote CPU.

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v11:
 - drop check for TIMER_PINNED flag and replace it with a WARN_ON_ONCE()

v9:
 - Update to the changes of the preceding patches

v6:
 - Update TIMER_PINNED flag description.

v5:
 - Move WARN_ONCE() in add_timer_on() into a previous patch
 - Fold crystallball magic related hunks into this patch

v4: Update comment about TIMER_PINNED flag (heristic is removed)
---
 include/linux/timer.h | 14 ++++----------
 kernel/time/timer.c   | 36 +++++++++++++++---------------------
 2 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 2be8be6dd317..14a633ba61d6 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -36,16 +36,10 @@
  * workqueue locking issues. It's not meant for executing random crap
  * with interrupts disabled. Abuse is monitored!
  *
- * @TIMER_PINNED: A pinned timer will not be affected by any timer
- * placement heuristics (like, NOHZ) and will always expire on the CPU
- * on which the timer was enqueued.
- *
- * Note: Because enqueuing of timers can migrate the timer from one
- * CPU to another, pinned timers are not guaranteed to stay on the
- * initialy selected CPU.  They move to the CPU on which the enqueue
- * function is invoked via mod_timer() or add_timer().  If the timer
- * should be placed on a particular CPU, then add_timer_on() has to be
- * used.
+ * @TIMER_PINNED: A pinned timer will always expire on the CPU on which the
+ * timer was enqueued. When a particular CPU is required, add_timer_on()
+ * has to be used. Enqueue via mod_timer() and add_timer() is always done
+ * on the local CPU.
  */
 #define TIMER_CPUMASK		0x0003FFFF
 #define TIMER_MIGRATING		0x00040000
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 0339273f9365..9ca921383497 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -590,11 +590,16 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 
 	/*
 	 * We might have to IPI the remote CPU if the base is idle and the
-	 * timer is not deferrable. If the other CPU is on the way to idle
-	 * then it can't set base->is_idle as we hold the base lock:
+	 * timer is pinned. If it is a non pinned timer, it is only queued
+	 * on the remote CPU, when timer was running during queueing. Then
+	 * everything is handled by remote CPU anyway. If the other CPU is
+	 * on the way to idle then it can't set base->is_idle as we hold
+	 * the base lock:
 	 */
-	if (base->is_idle)
+	if (base->is_idle) {
+		WARN_ON_ONCE(!(timer->flags & TIMER_PINNED));
 		wake_up_nohz_cpu(base->cpu);
+	}
 }
 
 /*
@@ -941,17 +946,6 @@ static inline struct timer_base *get_timer_base(u32 tflags)
 	return get_timer_cpu_base(tflags, tflags & TIMER_CPUMASK);
 }
 
-static inline struct timer_base *
-get_target_base(struct timer_base *base, unsigned tflags)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
-	if (static_branch_likely(&timers_migration_enabled) &&
-	    !(tflags & TIMER_PINNED))
-		return get_timer_cpu_base(tflags, get_nohz_timer_target());
-#endif
-	return get_timer_this_cpu_base(tflags);
-}
-
 static inline void __forward_timer_base(struct timer_base *base,
 					unsigned long basej)
 {
@@ -1106,7 +1100,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	if (!ret && (options & MOD_TIMER_PENDING_ONLY))
 		goto out_unlock;
 
-	new_base = get_target_base(base, timer->flags);
+	new_base = get_timer_this_cpu_base(timer->flags);
 
 	if (base != new_base) {
 		/*
@@ -2252,7 +2246,7 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		 * granularity skew (by design).
 		 */
 		if (!base_local->is_idle && time_after(nextevt, basej + 1)) {
-			base_local->is_idle = base_global->is_idle = true;
+			base_local->is_idle = true;
 			trace_timer_base_idle(true, base_local->cpu);
 		}
 		*idle = base_local->is_idle;
@@ -2318,13 +2312,13 @@ u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
 void timer_clear_idle(void)
 {
 	/*
-	 * We do this unlocked. The worst outcome is a remote enqueue sending
-	 * a pointless IPI, but taking the lock would just make the window for
-	 * sending the IPI a few instructions smaller for the cost of taking
-	 * the lock in the exit from idle path.
+	 * We do this unlocked. The worst outcome is a remote pinned timer
+	 * enqueue sending a pointless IPI, but taking the lock would just
+	 * make the window for sending the IPI a few instructions smaller
+	 * for the cost of taking the lock in the exit from idle
+	 * path. Required for BASE_LOCAL only.
 	 */
 	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
-	__this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false);
 	trace_timer_base_idle(false, smp_processor_id());
 
 	/* Activate without holding the timer_base->lock */
-- 
2.39.2


