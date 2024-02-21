Return-Path: <linux-kernel+bounces-74356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D258085D312
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3830BB2431D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C3F3F9EE;
	Wed, 21 Feb 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u/sfdH+V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XuF4oFDy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE23D571
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506381; cv=none; b=DvHS4KkkQGOQk9DySHMpkZPaU5ilabeKSQ7v2HReqyMnt49OQ0qsVpm7Loqi2UXHucrh5Eeckjdc9lHZaTRdoTDCvwl/xWFt6LjrwDfkBmKzk0CAPstGnsOQ7HiVtR5+s3KQvPbOqJArbw72UbEfmln2Z/wdVLkfEy5YxBVrHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506381; c=relaxed/simple;
	bh=8GAi+clf4ARudGxl8gQObKgEbjDfootfzyMlgIma4rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a9VrJItPEUE3KtO3MbcvcnDQCyIgBUQverrB/H3Oh1B47dCxXD1pL3qDspTVKRmU26p+hvs2VhUmxoGmGloeEpSJZ8NGHAgLLbAeXSocYhlI5mWkcphAdCcNPs9M80F6YRmaqJcgOWSum9swo+XEBfaPOWEACvctc+pZ7Nhk7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u/sfdH+V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XuF4oFDy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1b+XJv886jQpeQSImvPTzFbojcDlDb9MA0gl6E6c3yw=;
	b=u/sfdH+Vk7kDr9sz2nE4bHm9dCTIDU49w4pS88q+ts5uf4fH8H8L9lFaZKNsBGTLXHGi4h
	hybiBIpDkjFGsxd4qda7fWnmJI+X+iXI57e8SZuQLSi3CmfUOOG3YVFR4fLuuPnY/+NS5t
	gQRuFX6tmxSkPo7r3+mNyY2jYx++aL4c0HR3fMRakftpGMhYBEyDtgNXkNOv7r6zIY2yw6
	OzpFoq8EkguASNq+nF9MCLb99IVzQGss52yziACJ2/PBf2KFR+Ofipqo0NdkkdezWFen/Y
	avz7QIbHo0Cql5QN2efQi+T78JUUfSGIofpmOE6QXb0D0KqLoXFGEc2Q3O91nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1b+XJv886jQpeQSImvPTzFbojcDlDb9MA0gl6E6c3yw=;
	b=XuF4oFDy234l2NaSKHRP6EJO2dzYvZlOG2UwL/ppCrMgrcelmBfVunKnh0A+OOesZY0xda
	UM3Qf53oKdQpfkBw==
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
Subject: [PATCH v11 12/20] timers: Split out "get next timer interrupt" functionality
Date: Wed, 21 Feb 2024 10:05:40 +0100
Message-Id: <20240221090548.36600-13-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functionality for getting the next timer interrupt in
get_next_timer_interrupt() is split into a separate function
fetch_next_timer_interrupt() to be usable by other call sites.

This is preparatory work for the conversion of the NOHZ timer
placement to a pull at expiry time model. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v10: Update was required (change of preceding patches)
v9: Update was required (change of preceding patches)
v6: s/splitted/split
v5: Update commit message
v4: Fix typo in comment
---
 kernel/time/timer.c | 64 +++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index f119b44e44e0..9fa759dd80f5 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1988,30 +1988,13 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 	return base->next_expiry;
 }
 
-static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
-					     bool *idle)
+static unsigned long fetch_next_timer_interrupt(unsigned long basej, u64 basem,
+						struct timer_base *base_local,
+						struct timer_base *base_global,
+						struct timer_events *tevt)
 {
-	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
 	unsigned long nextevt, nextevt_local, nextevt_global;
-	struct timer_base *base_local, *base_global;
 	bool local_first;
-	u64 expires;
-
-	/*
-	 * Pretend that there is no timer pending if the cpu is offline.
-	 * Possible pending timers will be migrated later to an active cpu.
-	 */
-	if (cpu_is_offline(smp_processor_id())) {
-		if (idle)
-			*idle = true;
-		return tevt.local;
-	}
-
-	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
-	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
-
-	raw_spin_lock(&base_local->lock);
-	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
 
 	nextevt_local = next_timer_interrupt(base_local, basej);
 	nextevt_global = next_timer_interrupt(base_global, basej);
@@ -2029,8 +2012,8 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
-		tevt.local = basem + (u64)(nextevt - basej) * TICK_NSEC;
-		goto forward;
+		tevt->local = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		return nextevt;
 	}
 
 	/*
@@ -2040,12 +2023,41 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	 * ignored. If the global queue is empty, nothing to do either.
 	 */
 	if (!local_first && base_global->timers_pending)
-		tevt.global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+		tevt->global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
 
 	if (base_local->timers_pending)
-		tevt.local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+		tevt->local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+
+	return nextevt;
+}
+
+static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
+					     bool *idle)
+{
+	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
+	struct timer_base *base_local, *base_global;
+	unsigned long nextevt;
+	u64 expires;
+
+	/*
+	 * Pretend that there is no timer pending if the cpu is offline.
+	 * Possible pending timers will be migrated later to an active cpu.
+	 */
+	if (cpu_is_offline(smp_processor_id())) {
+		if (idle)
+			*idle = true;
+		return tevt.local;
+	}
+
+	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
+	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
+
+	raw_spin_lock(&base_local->lock);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+
+	nextevt = fetch_next_timer_interrupt(basej, basem, base_local,
+					     base_global, &tevt);
 
-forward:
 	/*
 	 * We have a fresh next event. Check whether we can forward the
 	 * base.
-- 
2.39.2


