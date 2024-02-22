Return-Path: <linux-kernel+bounces-76932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C0F85FED5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA081F28342
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2F41552E8;
	Thu, 22 Feb 2024 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sy2RgHVh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LisG/I9H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE2153BF3;
	Thu, 22 Feb 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621929; cv=none; b=PHZC5kfEEnxqvTq7n2Wp8oNje6JvHKyiodn2sGee1ATtmTMpfbuIH5tcbE0sq+OZ2F813/RkmzUHIU79juPYDZ9TRaOSJD2hMpSfw5p/Bwu7wwe8SnMjM2PlC41q3Ql7OudUFTTQ8CiGFdLZKFRFGmoMs7t/g7Y4BXGpwe2CbGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621929; c=relaxed/simple;
	bh=+d1s6NzoXSIvhqGFCIpB/me2eOnsyUw1n9/OG8lv5TY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AXjy03UJ6Fa96YbDRlQdHKCD6Bez4WYxO7GlACb3LrfJO9niFl49n34p/aRJj2Fajj6SE2wTtzboajyOGig4IA3gxn6plFKTYPLz2dQ7+xJtTafZ9Nxsz1Idy3Vl5HQwlYrxGVKAMEj+qDf2qmxQIHdUmRQwqIl+os2KUuihiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sy2RgHVh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LisG/I9H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vp70BqxKNDfBIbWJtNVYuXyPGtKICmt+kqCYReh1tMM=;
	b=sy2RgHVhKwMCSKRTQTTLUBJx6WucO4T9o1YeM8EVsAtzRu9BaBtGf258z4MzQfTcgJcvUo
	J9L7gmi3zeFAWwAyAQ9363sn0QZkyTdp05tyzJ196G5S0ZwgsGSdfY+IBt+DsrR8WagaUO
	3IH/WjRY40ygauz07n6ZfmvrpLVypAeNmtKyaqa2U4B/VIVu4mPCYAAuVQhFFWEBee/fdQ
	Q/Qhb2TB/+oSttDeijo3mlxaplAVY0HjZ/2t5IJ1PhNEcfJ4TtxvbjkDJhs9yes8HYVLN0
	Vy0Ei3vdrwZuSR2rHm11nPYm0mwLcYWGZCjVDRlqJeTbY8yanqwCH8JyrQg47Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vp70BqxKNDfBIbWJtNVYuXyPGtKICmt+kqCYReh1tMM=;
	b=LisG/I9HUuoKxe+IGgweJamGsvlmF73QE2OcgdCrmimPxmf/GAi/ctzJV1/RhMBym/di2J
	ZKv0XV66TO32XGDw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Always queue timers on the local CPU
Cc: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-21-anna-maria@linutronix.de>
References: <20240221090548.36600-21-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862192461.398.10613375933312669358.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b2cf7507e18649a30512515ec0ca89f26b2c2d0f
Gitweb:        https://git.kernel.org/tip/b2cf7507e18649a30512515ec0ca89f26b2c2d0f
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:32 +01:00

timers: Always queue timers on the local CPU

The timer pull model is in place so we can remove the heuristics which try
to guess the best target CPU at enqueue/modification time.

All non pinned timers are queued on the local CPU in the separate storage
and eventually pulled at expiry time to a remote CPU.

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-21-anna-maria@linutronix.de

---
 include/linux/timer.h | 14 ++++----------
 kernel/time/timer.c   | 36 +++++++++++++++---------------------
 2 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 2be8be6..14a633b 100644
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
index 3ed135c..4f4930d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -635,11 +635,16 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 
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
@@ -986,17 +991,6 @@ static inline struct timer_base *get_timer_base(u32 tflags)
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
@@ -1151,7 +1145,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	if (!ret && (options & MOD_TIMER_PENDING_ONLY))
 		goto out_unlock;
 
-	new_base = get_target_base(base, timer->flags);
+	new_base = get_timer_this_cpu_base(timer->flags);
 
 	if (base != new_base) {
 		/*
@@ -2297,7 +2291,7 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		 * granularity skew (by design).
 		 */
 		if (!base_local->is_idle && time_after(nextevt, basej + 1)) {
-			base_local->is_idle = base_global->is_idle = true;
+			base_local->is_idle = true;
 			trace_timer_base_idle(true, base_local->cpu);
 		}
 		*idle = base_local->is_idle;
@@ -2363,13 +2357,13 @@ u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
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

