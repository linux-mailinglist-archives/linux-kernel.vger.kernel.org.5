Return-Path: <linux-kernel+bounces-74357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A82E85D311
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299F01F22AF5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB763F9E9;
	Wed, 21 Feb 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tvSifHza";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wtOujEsX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83323D965
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506381; cv=none; b=ns+ZXF1IyDH01ChP2U1t5bdBIQroyvxcKIrPs+AGXeIhtUM1ge5sEa8V6BHDKyIFJzRxSqu9jzDIXFhgbfN6MdpRA0EhrgdWsMUqXfmrzFMjWD/0HPwKE0V/S0cW4tZH9hbczuHaq9jz3JLBSEwI2+xvw/fDzMeN3vB3aO9tvCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506381; c=relaxed/simple;
	bh=Y2acepoGiFBus/o+gYKEuBFXzXXX1WvysSEaYzKXOYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G5BZGaSMCKY2MFUqrZ4xK116RqM3+KzZRmmNqp3872MaPx4GVjCj4npfIWhrga/o8x72RigndSnd3yGKVPL7No+EOb7M/gaSc621wJ4OjFAwxMH8RqsD4KKHYMSVMmrU4Ouyt2zm7xgqUo5D8BysRObIePEaEQz9z791vcAZGOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tvSifHza; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wtOujEsX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Rk56jS4ox3LCyUSnYHvNlLdqZIvRSv1jWR0mBi/KNM=;
	b=tvSifHza9FJpYdPGN14ZKC6V3XR8MQF6d1u8sRX1M3nXQkeBVoGTK3ed45Tp+Wn6Pxl34P
	6IeT7hO5vshrkdsYEa11CvDY2TV2OumynAdBsHrz+zGnGhKt5939Qqixkem4dRqkNsoTPI
	YijYecLSRUiZQ/jzOkiN2Y7VXUeNBznGVaQYdGRZzLjCRSkyMvzFXo1YZTF+Sy+89QbpAf
	ghnWE/HFPgZJN+LMRiSk7WFx/ajpy7z3E4F4L3QiApGCdFBmTmQ2n/qD8Get8icU8Hgkg8
	cgOk0xiWQf1V2On6T0jm+96lB03fPKwNMt8JjwbzQW1sSlWDG8drZ4x0dqlDnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Rk56jS4ox3LCyUSnYHvNlLdqZIvRSv1jWR0mBi/KNM=;
	b=wtOujEsXq56FVsf4pAgUz4UY2mcmXcLUCrvFSKEik1is8Jtqy3EJq05R0YiQNLzYwXRU1a
	TUIrAQ29Ip7CV2BA==
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
	"Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v11 14/20] timers: Restructure internal locking
Date: Wed, 21 Feb 2024 10:05:42 +0100
Message-Id: <20240221090548.36600-15-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>

Move the locking out from __run_timers() to the call sites, so the
protected section can be extended at the call site. Preparatory patch for
changing the NOHZ timer placement to a pull at expiry time model.

No functional change.

Signed-off-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 88160b3461e0..52af50d00ae6 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2238,11 +2238,7 @@ static inline void __run_timers(struct timer_base *base)
 	struct hlist_head heads[LVL_DEPTH];
 	int levels;
 
-	if (time_before(jiffies, base->next_expiry))
-		return;
-
-	timer_base_lock_expiry(base);
-	raw_spin_lock_irq(&base->lock);
+	lockdep_assert_held(&base->lock);
 
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
@@ -2266,21 +2262,36 @@ static inline void __run_timers(struct timer_base *base)
 		while (levels--)
 			expire_timers(base, heads + levels);
 	}
+}
+
+static void __run_timer_base(struct timer_base *base)
+{
+	if (time_before(jiffies, base->next_expiry))
+		return;
+
+	timer_base_lock_expiry(base);
+	raw_spin_lock_irq(&base->lock);
+	__run_timers(base);
 	raw_spin_unlock_irq(&base->lock);
 	timer_base_unlock_expiry(base);
 }
 
+static void run_timer_base(int index)
+{
+	struct timer_base *base = this_cpu_ptr(&timer_bases[index]);
+
+	__run_timer_base(base);
+}
+
 /*
  * This function runs timers and the timer-tq in bottom half context.
  */
 static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 {
-	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
-
-	__run_timers(base);
+	run_timer_base(BASE_LOCAL);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
-		__run_timers(this_cpu_ptr(&timer_bases[BASE_GLOBAL]));
-		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+		run_timer_base(BASE_GLOBAL);
+		run_timer_base(BASE_DEF);
 	}
 }
 
-- 
2.39.2


