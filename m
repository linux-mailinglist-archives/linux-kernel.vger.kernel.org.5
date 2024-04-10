Return-Path: <linux-kernel+bounces-139499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D88A03BC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB74DB220DD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DD9136E26;
	Wed, 10 Apr 2024 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V9lct4Gz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/o6o6fS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862E13664C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789255; cv=none; b=k7QWF4dx9nrgHPp/RrkiFAY+CnvpbxXnhy/VQpWmXaRft3Zeykc6Ss+tPEFnLMkmNMODsXKBJLHD6UBqK2s4gyVI1yCghew1jtMuKdO6ZGrhvoZl2Nu7q515Xaafg9tSx9Y5jXdmhRinHneSfuvSrPKWYT+eJAsQpPsxsyTD7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789255; c=relaxed/simple;
	bh=S6JUDkyUPN6u68oQn5OUPewj7arp5+lzXuIlS/xwEHU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KRm5m8Pa6hX02+cjQM6neVxa9vKSQoTdKKOSoPDIK5+AA3Foa6m5bvwNSRJYLUcOhRBGsSpEbnRfSCYaFM1Vt0+UtJI9DbG7emy7j+iygn89WOxD1AV5r8aIVgLeXKHASz1ezjmfiybnpIAy01JcQkOGO+18pqpnp1R3gdiULuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V9lct4Gz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/o6o6fS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165553.760259947@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=h6hDrXB0chXNrUH4sCnb+tErkyrDv3iJrXtwT3bPMl8=;
	b=V9lct4GzHZn49a1TrhvBCi/6RZvlkGjiUqQfEuE5lNaZvghRTrpIzvenCiD7ig0kKM3WfC
	k1dZcsPXInjzXGnhKR7qe5JYm8xcT0jvFX4Llt0HMLzjqT4LreIP+T7ERDAOvoO4OhwW7R
	YeivbXxQcO480iQNRn72IfVtPtzTT2Qi86jPyH77Zc8wI4Cc2wGqtctekvsryjC765djG9
	13jd2kkk/L5MAosfOiLJt+v9SuimmAdqPfrhmDZtrMLjPCM1CTr5jroYGMfck9IBG3PmO2
	xvKxaWeDu903OKKoW3UlnfoFHwpxJ3GAIIUVySK27cIzuiXAPK+2qzL0yWt23A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=h6hDrXB0chXNrUH4sCnb+tErkyrDv3iJrXtwT3bPMl8=;
	b=N/o6o6fSPXwuZzN6JKYJYD+vNEglvin24m4COI1zmV4PdYMYn2m1NhCYkmQSy781u4qMbZ
	pJrEW2hqqEqs0CDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V2 45/50] posix-timers: Handle ignored list on delete and exit
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:31 +0200 (CEST)

To handle posix timer signals on sigaction(SIG_IGN) properly, the timers
will be queued on a separate ignored list.

Add the necessary cleanup code for timer_delete() and exit_itimers().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    4 +++-
 kernel/time/posix-timers.c   |   20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -151,7 +151,8 @@ static inline void posix_cputimers_init_
 
 /**
  * struct k_itimer - POSIX.1b interval timer structure.
- * @list:		List head for binding the timer to signals->posix_timers
+ * @list:		List node for binding the timer to tsk::signal::posix_timers
+ * @ignored_list:	List node for tracking ignored timers in tsk::signal::ignored_posix_timers
  * @t_hash:		Entry in the posix timer hash table
  * @it_lock:		Lock protecting the timer
  * @kclock:		Pointer to the k_clock struct handling this timer
@@ -174,6 +175,7 @@ static inline void posix_cputimers_init_
  */
 struct k_itimer {
 	struct hlist_node	list;
+	struct hlist_node	ignored_list;
 	struct hlist_node	t_hash;
 	spinlock_t		it_lock;
 	const struct k_clock	*kclock;
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1036,6 +1036,18 @@ int common_timer_del(struct k_itimer *ti
 	return 0;
 }
 
+/*
+ * If the deleted timer is on the ignored list, remove it and
+ * drop the associated reference.
+ */
+static inline void posix_timer_cleanup_ignored(struct k_itimer *tmr)
+{
+	if (!hlist_unhashed(&tmr->ignored_list)) {
+		hlist_del_init(&tmr->ignored_list);
+		posixtimer_putref(tmr);
+	}
+}
+
 static inline int timer_delete_hook(struct k_itimer *timer)
 {
 	const struct k_clock *kc = timer->kclock;
@@ -1068,6 +1080,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 
 	spin_lock(&current->sighand->siglock);
 	hlist_del(&timer->list);
+	posix_timer_cleanup_ignored(timer);
 	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
@@ -1119,6 +1132,8 @@ static void itimer_delete(struct k_itime
 	}
 	hlist_del(&timer->list);
 
+	posix_timer_cleanup_ignored(timer);
+
 	/*
 	 * Setting timer::it_signal to NULL is technically not required
 	 * here as nothing can access the timer anymore legitimately via
@@ -1151,6 +1166,11 @@ void exit_itimers(struct task_struct *ts
 	/* The timers are not longer accessible via tsk::signal */
 	while (!hlist_empty(&timers))
 		itimer_delete(hlist_entry(timers.first, struct k_itimer, list));
+
+	/* Mop up timers which are on the ignored list */
+	hlist_move_list(&tsk->signal->ignored_posix_timers, &timers);
+	while (!hlist_empty(&timers))
+		posix_timer_cleanup_ignored(hlist_entry(timers.first, struct k_itimer, list));
 }
 
 SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,


