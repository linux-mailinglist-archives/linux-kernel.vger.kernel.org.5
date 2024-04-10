Return-Path: <linux-kernel+bounces-139488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F2B8A03B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88751C2101F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0121292FC;
	Wed, 10 Apr 2024 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="da5FNt0f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o/yUsh2y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02A985928
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789237; cv=none; b=b7h3UGMtp2NCxNuJ59nk/Qnc3yf5VZfot4+OkXtc4Zz3VreOdxQu2KW7b9e99yVc78cpKfGG62JkRWh6tBmeOawQEOORX4fr3oSl0GeEpkLauFFmIFVfSi2r2CI4RLlwsnGCYi4J5ZYKm9gykbKs4o5v7pTUXKVUfX0RbwgaQAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789237; c=relaxed/simple;
	bh=SeQ2OVxjlLINqynDEK9vT3MFjf860yuU+9xoy6p/o24=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=pPKYgwxZPWxwIRiVPqUTRMSpCwA5R+UcCrDAySGUWeJRd+pGl2y35GpBJ8DyBEybAk8p11Z49JeGv/37ZUcyjHD59x2vAZv9vtQWVf/Y1izPnKs6lOfMECgzl5GBNEuOim6s0f9bzQjHkUvzuRSpmeDIGZKve4xc9y5fR+ZQzKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=da5FNt0f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o/yUsh2y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165553.141005565@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hZthBClJqDYnocBuqiMS4yLZv+QB2bQbndBZ4lDgqqQ=;
	b=da5FNt0f+6gCM2oMb3FB/ZNQNsbuKurn7MGmZK5KiVJcmraK5ghlj9ln3bvPOljHUhhTxa
	t/8D3Bx590UZQyMWTPHPtaoXEMC+ulp2l1U5RlFbIsUvy96lw4BnoRWyldaYwgpP4iJ2Hc
	gNU42f7lnGYuHWqoOFDdy38OnOtNaUF/K+Z8Z1rh7wI3pboqxtkrvOtd7TPeAIl9lL5p7f
	RvHp0zesNYkplNVWCN2TXuNkymvY1RVCWy71slE6NNWvgDGIEeElrcnipwla6YgXknDwZQ
	jARjN4eiHAKI5T2K3WxIuixrxCPVx5Shekwbuav3CKPKZWXVps/TfRTG3t3vwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hZthBClJqDYnocBuqiMS4yLZv+QB2bQbndBZ4lDgqqQ=;
	b=o/yUsh2y3J7rZsQfE1irH6DnTnNXFms0FT97Ok/4Ti4uS9VaBGWRxFK73P5shf12exmEvN
	wuzgyCgSk+iBk2DA==
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
Subject: [patch V2 35/50] posix-timers: Add a refcount to struct k_itimer
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:13 +0200 (CEST)

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

To make this work correctly this needs reference counting so that timer
deletion does not free the timer prematuraly when there is a signal queued
or delivered concurrently.

Add a rcuref to the posix timer part.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |   14 ++++++++++++++
 kernel/time/posix-timers.c   |    7 ++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -6,11 +6,13 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/posix-timers_types.h>
+#include <linux/rcuref.h>
 #include <linux/spinlock.h>
 #include <linux/timerqueue.h>
 
 struct kernel_siginfo;
 struct task_struct;
+struct k_itimer;
 
 static inline clockid_t make_process_cpuclock(const unsigned int pid,
 		const clockid_t clock)
@@ -105,6 +107,7 @@ static inline void posix_cputimers_rt_wa
 
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
+void posixtimer_free_timer(struct k_itimer *timer);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -129,6 +132,7 @@ static inline void posix_cputimers_group
 					      u64 cpu_limit) { }
 static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
 static inline bool posixtimer_deliver_signal(struct kernel_siginfo *info) { return false; }
+static inline void posixtimer_free_timer(struct k_itimer *timer) { }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
@@ -156,6 +160,7 @@ static inline void posix_cputimers_init_
  * @it_signal:		Pointer to the creators signal struct
  * @it_pid:		The pid of the process/task targeted by the signal
  * @it_process:		The task to wakeup on clock_nanosleep (CPU timers)
+ * @rcuref:		Reference count for life time management
  * @sigq:		Pointer to preallocated sigqueue
  * @it:			Union representing the various posix timer type
  *			internals.
@@ -180,6 +185,7 @@ struct k_itimer {
 		struct task_struct	*it_process;
 	};
 	struct sigqueue		*sigq;
+	rcuref_t		rcuref;
 	union {
 		struct {
 			struct hrtimer	timer;
@@ -200,4 +206,12 @@ void set_process_cpu_timer(struct task_s
 
 int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
 
+#ifdef CONFIG_POSIX_TIMERS
+static inline void posixtimer_putref(struct k_itimer *tmr)
+{
+	if (rcuref_put(&tmr->rcuref))
+		posixtimer_free_timer(tmr);
+}
+#endif /* !CONFIG_POSIX_TIMERS */
+
 #endif
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -417,6 +417,7 @@ static struct k_itimer * alloc_posix_tim
 		return NULL;
 	}
 	clear_siginfo(&tmr->sigq->info);
+	rcuref_init(&tmr->rcuref, 1);
 	return tmr;
 }
 
@@ -427,7 +428,7 @@ static void k_itimer_rcu_free(struct rcu
 	kmem_cache_free(posix_timers_cache, tmr);
 }
 
-static void posix_timer_free(struct k_itimer *tmr)
+void posixtimer_free_timer(struct k_itimer *tmr)
 {
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
@@ -439,7 +440,7 @@ static void posix_timer_unhash_and_free(
 	spin_lock(&hash_lock);
 	hlist_del_rcu(&tmr->t_hash);
 	spin_unlock(&hash_lock);
-	posix_timer_free(tmr);
+	posixtimer_putref(tmr);
 }
 
 static int common_timer_create(struct k_itimer *new_timer)
@@ -474,7 +475,7 @@ static int do_timer_create(clockid_t whi
 	 */
 	new_timer_id = posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
-		posix_timer_free(new_timer);
+		posixtimer_free_timer(new_timer);
 		return new_timer_id;
 	}
 


