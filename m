Return-Path: <linux-kernel+bounces-109960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 978BC885842
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5386C282F79
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52B58AC4;
	Thu, 21 Mar 2024 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gKqs2UKr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0IediqO2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F958129;
	Thu, 21 Mar 2024 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020297; cv=none; b=Q3z9pOzGdUa08lCdMDRao0WvyqPvTtNz+3hmqxeDpD4n8RsaWy0JWE2NyLqChO8US0xlLYhtGyC+xBn7XXCRGDBsTZktlvTXZwSE8yPeGWBboOlq9pAx3kCOrA91TpQmT/1y4D2YYeABqn/gBywYXkFAgmkpWHYTaN8jqFg78fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020297; c=relaxed/simple;
	bh=3ILvGA3dlGIwDdBbVnww9/UjWTQFT0UfP6FD0k71DxY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AHPGtsiqumqt4iJhUwCvcV+DsZNaK1V485oNyTnpCfKmi8X/hvFwE2/ciLed1Q/7l0QBESrBn8KzU9HM914mVdC3av6BryUWSvqxJthXUOaaf3uOrBUBj841Z4RbT+j3xcpqTX4PK1XoBsue7gtrvqX9SzgRpOnQkrHZ5ovP+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gKqs2UKr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0IediqO2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Mar 2024 11:24:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711020294;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DB3NZ8/yiTaLUxCgKAXvKDAwe8/HCjA6a2zA8+1znnM=;
	b=gKqs2UKrCIylI+dIm1SULPrulvoxlsBckxEzczWPpmyt/gYqLz1WTAwIkO7XRCPWgOwg17
	U3ztddeKcRx4BMubgNZ637zcBvNAxEf9xo/h3aPY62nbbydAppv2rV60Dbm6ndTeY0E55R
	xyPdjTxKljU34JWqMlwJHELKYF812cC+fMXvp/RWNzhfMa65VHVHvlnUsTE7lXZxeE1NN6
	QCccgJ8ktwz3YSsSt3Zg7H/kSvHMqds7xvwby6Di4roAImi4Y4pzkxLWIVj6o8ZRQLdJ7p
	AVMhabEXsobzAUV5ZYPD18ZDfftkZ3H10LCc7yRhJgRsRopGQvxJrxtjvATx3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711020294;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DB3NZ8/yiTaLUxCgKAXvKDAwe8/HCjA6a2zA8+1znnM=;
	b=0IediqO2vzc8U9VHATBsHFn4Ut+0XpvBNsLzp+sNPkIhnmSIY51Q+jfzgV/QI2iNypxpDO
	jYfbpWCguTJ6gaCg==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers: Fix removed self-IPI on global timer's
 enqueue in nohz_full
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240318230729.15497-3-frederic@kernel.org>
References: <20240318230729.15497-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171102029326.10875.6622636119030507753.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     03877039863be021a19fda307136657bb6d61f75
Gitweb:        https://git.kernel.org/tip/03877039863be021a19fda307136657bb6d61f75
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 19 Mar 2024 00:07:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 Mar 2024 10:14:55 +01:00

timers: Fix removed self-IPI on global timer's enqueue in nohz_full

While running in nohz_full mode, a task may enqueue a timer while the
tick is stopped. However the only places where the timer wheel,
alongside the timer migration machinery's decision, may reprogram the
next event accordingly with that new timer's expiry are the idle loop or
any IRQ tail.

However neither the idle task nor an interrupt may run on the CPU if it
resumes busy work in userspace for a long while in full dynticks mode.

To solve this, the timer enqueue path raises a self-IPI that will
re-evaluate the timer wheel on its IRQ tail. This asynchronous solution
avoids potential locking inversion.

This is supposed to happen both for local and global timers but commit:

	b2cf7507e186 ("timers: Always queue timers on the local CPU")

broke the global timers case with removing the ->is_idle field handling
for the global base. As a result, global timers enqueue may go unnoticed
in nohz_full.

Fix this with restoring the idle tracking of the global timer's base,
allowing self-IPIs again on enqueue time.

Fixes: b2cf7507e186 ("timers: Always queue timers on the local CPU")
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240318230729.15497-3-frederic@kernel.org

---
 kernel/time/timer.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e69e75d..dee29f1 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -642,7 +642,8 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 	 * the base lock:
 	 */
 	if (base->is_idle) {
-		WARN_ON_ONCE(!(timer->flags & TIMER_PINNED));
+		WARN_ON_ONCE(!(timer->flags & TIMER_PINNED ||
+			       tick_nohz_full_cpu(base->cpu)));
 		wake_up_nohz_cpu(base->cpu);
 	}
 }
@@ -2292,6 +2293,13 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		 */
 		if (!base_local->is_idle && time_after(nextevt, basej + 1)) {
 			base_local->is_idle = true;
+			/*
+			 * Global timers queued locally while running in a task
+			 * in nohz_full mode need a self-IPI to kick reprogramming
+			 * in IRQ tail.
+			 */
+			if (tick_nohz_full_cpu(base_local->cpu))
+				base_global->is_idle = true;
 			trace_timer_base_idle(true, base_local->cpu);
 		}
 		*idle = base_local->is_idle;
@@ -2364,6 +2372,8 @@ void timer_clear_idle(void)
 	 * path. Required for BASE_LOCAL only.
 	 */
 	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
+	if (tick_nohz_full_cpu(smp_processor_id()))
+		__this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false);
 	trace_timer_base_idle(false, smp_processor_id());
 
 	/* Activate without holding the timer_base->lock */

