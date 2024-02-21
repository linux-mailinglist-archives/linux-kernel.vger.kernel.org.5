Return-Path: <linux-kernel+bounces-74354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB4185D30F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA111F21D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C0D3C47E;
	Wed, 21 Feb 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UauhkFtN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xw6B4fp4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23503D556
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506380; cv=none; b=Zo3NATDVZPtJdv8mo6cY4e05W0dZ31wj0JqNGo4R/PKES/Uboa9qsxcS7kYgd1UGm3ANpRYQlVMOR2l3rk4TdsIb0mO+NizE0dmWbtzN2IVPO6TZQ/fbYvPVy5+UQX8o3lCRaNCmj8Jxlgc+wEMBY6q/i3sZCACMDKh6GD8acqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506380; c=relaxed/simple;
	bh=qUk4S9h8Q0/zI9/a+pkUeXQEJ/CkK2JDvQly8qMxVXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqfC7OusqtyObnBKZLGpQ1snxXqK0SjrF1m8VntcNagCf4sqfIBv+nk8NWMIzjmWcEyYb/+H6t7EFrCCiIGNw+UOhkGN5Tc3i1uW+V5MPjTi+cR+zC2KYvdZnqow21niI+Y0Eq+tXSxy5PrQDzWQd7lQyZC+PwTVpZ6U5uS1TZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UauhkFtN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xw6B4fp4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVCrlgF3mrMVRn6VCmTujRoLZ7e8Pe7/0fX1s066Dis=;
	b=UauhkFtNugJUVAcU2XBXqHgJpEFFzmmYJbalN9Bx5r6lqOQF5mi+ok6kGZQRczwcuMp45o
	TdYGS2AuQqd+26Yqo7OEgLOgB32vjtdHAK9XmFr8x8yFFuRfkq2IVI84ZuwF3gBZGmuo6Y
	jkEXZIqwsEHiU5NaQjndBffrWrOcTglHHVvXCGP0VRR+eOPFd3tvDyW8TVo6VOIaieqUrt
	KNBAyPpuaUtkdwoTd5ClwibvvsxmGq7pgYcF1HJ+oM6CForFA9X5u9gZywu+ykjpXXECis
	dgIfI6+l1BZ3DJjISCpOseksYX68Vfij+nZlSl/FbIm68tBkQey57PcXddhWwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVCrlgF3mrMVRn6VCmTujRoLZ7e8Pe7/0fX1s066Dis=;
	b=Xw6B4fp4kN3Srl3jj/CMgV47Uasf86D4P80s5n23HE3qzLv2k0wZP+p/jaKVkkGBIuH1Dn
	itPtcKAGxKRghNCA==
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
Subject: [PATCH v11 09/20] timers: Split next timer interrupt logic
Date: Wed, 21 Feb 2024 10:05:37 +0100
Message-Id: <20240221090548.36600-10-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the logic for getting next timer interrupt (no matter of recalculated
or already stored in base->next_expiry) into a separate function named
next_timer_interrupt(). Make it available to local call sites only.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v10: Reword commit message

v9: Adapt to the fix for empty timer bases.
---
 kernel/time/timer.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 793848167852..4d6cf49a2fd1 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1951,12 +1951,29 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
+static unsigned long next_timer_interrupt(struct timer_base *base,
+					  unsigned long basej)
+{
+	if (base->next_expiry_recalc)
+		next_expiry_recalc(base);
+
+	/*
+	 * Move next_expiry for the empty base into the future to prevent an
+	 * unnecessary raise of the timer softirq when the next_expiry value
+	 * will be reached even if there is no timer pending.
+	 */
+	if (!base->timers_pending)
+		base->next_expiry = basej + NEXT_TIMER_MAX_DELTA;
+
+	return base->next_expiry;
+}
+
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 					     bool *idle)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
-	unsigned long nextevt = basej + NEXT_TIMER_MAX_DELTA;
 	u64 expires = KTIME_MAX;
+	unsigned long nextevt;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1969,24 +1986,13 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	}
 
 	raw_spin_lock(&base->lock);
-	if (base->next_expiry_recalc)
-		next_expiry_recalc(base);
+	nextevt = next_timer_interrupt(base, basej);
 
 	if (base->timers_pending) {
-		nextevt = base->next_expiry;
-
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
 		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
-	} else {
-		/*
-		 * Move next_expiry for the empty base into the future to
-		 * prevent a unnecessary raise of the timer softirq when the
-		 * next_expiry value will be reached even if there is no timer
-		 * pending.
-		 */
-		base->next_expiry = nextevt;
 	}
 
 	/*
-- 
2.39.2


