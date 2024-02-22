Return-Path: <linux-kernel+bounces-76939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A77585FEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F419B28B5AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3E01586C6;
	Thu, 22 Feb 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qlFsd8VF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LT8I6Uv+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B359A155A32;
	Thu, 22 Feb 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621933; cv=none; b=OYr0wSem3TeItu1isEEPD+hPgherItvThJMYvKqcbO7DFosMepnBy+5urbqj/th+mqN94yXErFUZSC/A5dEBYqn+B7+BGWqm17nh0pCxWO6uRkEo3htZwbKNRrT5L73yXy+B4GVYb96TJmFLA0E8QNA1EWbqLgw6CPK8NbTCWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621933; c=relaxed/simple;
	bh=piPX2TiU+hsBcDA22veVpBQIp2dKCQ6kgAdw0E+s320=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oIYOjlWp1kp/0ToxaUz43EiTgRAEykCRfFk8/uKAId/ee3pRbkglrnNafnasZ6BNXYxA4xsGtW5bC1rqsAs13X2sCz54A8MUCmvBZ3YpcyNneBpBie8Hd07fUpzUNTgaKN2Z/YPJ5Zq2Hdd3duszKdIPpNj+H6pqDSvz8i2+pDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qlFsd8VF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LT8I6Uv+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C86y66yt7NrqOinlYS+H9YKCwnT6eT7a+seZKWiNUts=;
	b=qlFsd8VFBsluXLneSY4SdCB9afjhwn/kzVxJV6qXlIcpMoZLDHevpeYE299fN9epWSE+46
	3MbYz0xIyTumZo92enyoX0Iyb344/cfuR4F5n/5InHSkuR469EQVv/3RHVwhGxBaPQtsT+
	0+0Aej0d6BzAG6czmlOUUbO/87nP8xWV1ji7Rfj3vFEezXyY0qqlKKy6ZirafC94ROWF/N
	lHxdHYxkMtk4uus+nmmQS/xS622LJQqe35w4vQXoRjMOmdeuPEbVXakV1OoZKTc46K2hmP
	e/w5hPjeg+dm6YKqtX91mEElIMwD+KFl+FYUXU0m1x1qkpqRQu46jg4uOrle5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C86y66yt7NrqOinlYS+H9YKCwnT6eT7a+seZKWiNUts=;
	b=LT8I6Uv+aJ3MkRWk5YKdN9FMccAeI3djfW6z8zcENCkcjq9b7cuNb6kJr5QIjMnC/AuDd9
	sq9W/vlHKajS5dBQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Add get next timer interrupt functionality
 for remote CPUs
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-14-anna-maria@linutronix.de>
References: <20240221090548.36600-14-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862192926.398.11570971415900571858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f73d9257ff3c2f415e8c342a91b7f5acfc3ce512
Gitweb:        https://git.kernel.org/tip/f73d9257ff3c2f415e8c342a91b7f5acfc3ce512
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:31 +01:00

timers: Add get next timer interrupt functionality for remote CPUs

To prepare for the conversion of the NOHZ timer placement to a pull at
expiry time model it's required to have functionality available getting the
next timer interrupt on a remote CPU.

Locking of the timer bases and getting the information for the next timer
interrupt functionality is split into separate functions. This is required
to be compliant with lock ordering when the new model is in place.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-14-anna-maria@linutronix.de

---
 kernel/time/tick-internal.h | 10 ++++-
 kernel/time/timer.c         | 95 ++++++++++++++++++++++++++++++++++--
 2 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 47df30b..8b0c28e 100644
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
index b10e97c..bc074c0 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -266,11 +266,6 @@ struct timer_base {
 
 static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
 
-struct timer_events {
-	u64	local;
-	u64	global;
-};
-
 #ifdef CONFIG_NO_HZ_COMMON
 
 static DEFINE_STATIC_KEY_FALSE(timers_nohz_active);
@@ -2058,6 +2053,21 @@ static unsigned long fetch_next_timer_interrupt(unsigned long basej, u64 basem,
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
 
@@ -2076,6 +2086,81 @@ static unsigned long fetch_next_timer_interrupt(unsigned long basej, u64 basem,
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

