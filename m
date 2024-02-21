Return-Path: <linux-kernel+bounces-74359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4924B85D313
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2081C22C82
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E92A3FB1D;
	Wed, 21 Feb 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="erx+rjUr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALe/TX7h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F9E3D570
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506382; cv=none; b=j/jFcqXtP24xwM9p9WR3TSGQeBJHlB/IBmLwHamsGtSdle6+OKFQPBCWjc0N3oVjrDBwDyCfw8RNsdjsPrMRJWZKcj+TE5niGZswmQaouUeYC6MQRfORmIXLOS3IeDYmzckrvP7GwQJcH5FUplmD+Y8mttYHlB7K0BBwsKFKO1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506382; c=relaxed/simple;
	bh=+PFtgywkqe7EU2O4wsgXtoFK8yKu231t3eYiycwv0as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2ggfdbk5fAl+h3Qw58r8ScCzH/SCpMdYqLiqxoeSSpvBE5wReMoUASKrF7I+1BRTyrXQXfeASM5Zvigr/pQ2Zx5R/UzZEp1rfKXFiLFxu0bho//Mmv63RpyZDKo/f3pu/1PLSGtpguGg9waG6tFVkFItWG4abfxbQ08s9LR3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=erx+rjUr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ALe/TX7h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rdV5ipuCK7k881Y4gsklU0XL1atEsQC6N/1j4oq3gU=;
	b=erx+rjUrJdkST1kCUsNdV3qpWn4r06LFiSqvkL7kmB4JHRJ9LiuzUpm9g63+X8yOzssUjl
	sk3O9UMZK+QH6OrOfToxhnMwwKJv1ABH8CinEpiw5cqz+SH+qjq3cEKUIa8C8BNxiXl3LV
	wZI8VvXSqNZ10X9/mTy02OFuQDVje6Diz8yLYnTqbyTr+wNtM/EO2CxMa/5At/82+G7Rq+
	Tha+7iNgOUlyRPFqLDHPzjo2Xpy6f5jkAiVFTAjNPNKkt+B6MBN+ofr4agIfeSP5ongHnE
	vVuefPq1ocPlR932unA/U6qIYuFxxbCeHZyDVw/cufC81ligWvamgylWIbkKgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rdV5ipuCK7k881Y4gsklU0XL1atEsQC6N/1j4oq3gU=;
	b=ALe/TX7h7OMA4pyk46Rv7ZfsqFG3JzoYB32BJWYlgCRvXZET1YkekoXmmuFdcUshUynjrc
	9kP8mFmyhR+x/VCw==
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
Subject: [PATCH v11 11/20] timers: Retrieve next expiry of pinned/non-pinned timers separately
Date: Wed, 21 Feb 2024 10:05:39 +0100
Message-Id: <20240221090548.36600-12-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the conversion of the NOHZ timer placement to a pull at expiry time
model it's required to have separate expiry times for the pinned and the
non-pinned (movable) timers. Therefore struct timer_events is introduced.

No functional change

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v10: Fix no functional change message

v9: Update was required (change of preceding patches)
---
 kernel/time/timer.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 5ca831444954..f119b44e44e0 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -221,6 +221,11 @@ struct timer_base {
 
 static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
 
+struct timer_events {
+	u64	local;
+	u64	global;
+};
+
 #ifdef CONFIG_NO_HZ_COMMON
 
 static DEFINE_STATIC_KEY_FALSE(timers_nohz_active);
@@ -1986,10 +1991,11 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 					     bool *idle)
 {
+	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
 	unsigned long nextevt, nextevt_local, nextevt_global;
 	struct timer_base *base_local, *base_global;
-	u64 expires = KTIME_MAX;
 	bool local_first;
+	u64 expires;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1998,7 +2004,7 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	if (cpu_is_offline(smp_processor_id())) {
 		if (idle)
 			*idle = true;
-		return expires;
+		return tevt.local;
 	}
 
 	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
@@ -2014,13 +2020,32 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 
 	nextevt = local_first ? nextevt_local : nextevt_global;
 
-	if (base_local->timers_pending || base_global->timers_pending) {
+	/*
+	 * If the @nextevt is at max. one tick away, use @nextevt and store
+	 * it in the local expiry value. The next global event is irrelevant in
+	 * this case and can be left as KTIME_MAX.
+	 */
+	if (time_before_eq(nextevt, basej + 1)) {
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
-		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		tevt.local = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		goto forward;
 	}
 
+	/*
+	 * Update tevt.* values:
+	 *
+	 * If the local queue expires first, then the global event can be
+	 * ignored. If the global queue is empty, nothing to do either.
+	 */
+	if (!local_first && base_global->timers_pending)
+		tevt.global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+
+	if (base_local->timers_pending)
+		tevt.local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+
+forward:
 	/*
 	 * We have a fresh next event. Check whether we can forward the
 	 * base.
@@ -2051,6 +2076,8 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	raw_spin_unlock(&base_global->lock);
 	raw_spin_unlock(&base_local->lock);
 
+	expires = min_t(u64, tevt.local, tevt.global);
+
 	return cmp_next_hrtimer_event(basem, expires);
 }
 
-- 
2.39.2


