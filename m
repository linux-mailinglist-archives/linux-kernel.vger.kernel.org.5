Return-Path: <linux-kernel+bounces-117753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC288AF1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D8D1C3CAD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C76F4A2D;
	Mon, 25 Mar 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ehda3m16"
Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED24A1E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393024; cv=pass; b=f/TM1KzfcosXrr2jOxy/265gpPLTJSnzrS68t0NRj3R/5nXUv5Ad7b+OkAewemuZB7ol/HPCKemO1QgceiH6E4StwNnury+LPaUUHpvpAtxmJoE6dScM7tmeIIERUZNlA+opOXEFCq0KfmHB+6XSO7iSNDtI3Ii70IzcRqvfg/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393024; c=relaxed/simple;
	bh=fDxfJSpiSUrtS43JT5BXDIc+RjOc4wC6PalZL6lVxZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nc3C7/NSJ8GxxkLcGq2Q6bCvEaNYxZ5yje06QdXOzLVHZFgrWFYe4T+BOT4URrvLl7nhPXM62s95eVg4RokKC/csTvu7ZwG5CIecaS/lw40RV8zmiA1QfMY8kkdrQML6iJuCahlBD5TLANYc1vyec+EUcmuq7LTdWSEa6nSmgII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ehda3m16; arc=pass smtp.client-ip=23.83.218.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A5B84503994;
	Mon, 25 Mar 2024 18:56:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a293.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id F259B5017A6;
	Mon, 25 Mar 2024 18:56:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1711393016; a=rsa-sha256;
	cv=none;
	b=WeC02x0qkd6aQ/ffA/kBgevDk109Gy85oPATu1HgIk+tyu/0q5LT4bUQq7RLH7cTHIAt3G
	cA2JzixvNxACK42QRhgvjmYWEnDS2yhhZy9SEwZtanP+ec5ilifr9lJyBsHSOjVaQ1undX
	YALFQS0UWkjbMSAJw4pmprQbizjHstcM47MLEeIE+dlHXtVacvFi9tTBKOZX0QFGhUypnu
	QCKALZPlUklCkuudocvo5w6v3w0b8HWiFwn1U7nC2EjzEtYwa7CgzpopbVNq2W5Z52R8Zc
	Eg+Ca26XeZy1uXV7e3IWd/byarR2tA7d2BUwtGWJyBYi+Rc4Lr0VG9YoQH1Jig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1711393016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=K1CXbXnAFlONaPrEbG4EfG6Hava8F3+i+2sN8gQ/+WM=;
	b=uD7EYPNo6IOeAQaHquq8OmTg2HSVUySW5sGE+uJ5AnwPjqjaYSf0IeZp0WZYAoDs2KwwgU
	14LrT735pXChxE7+chNnuI64ufz/ebrLdSZyR6vyOu4Y8icrlBFNftVNrAog8zH7hgYrUA
	7OO6JeMpBvfxc3Gu9YwdlPHSmEcI6E7U6RgiVEeHhGjrJllrK8RefwreyxuBeQxD+j1KHU
	9ZklIQXVQ3lOA2PKG1j1a+yHMYVt3xsnQbxy5aEvILszDs/VJn6U/mH1xrx5z7oACoAZfN
	2M7ifDk+COqHECpcfWnlW8pKc0qi14l7juoYuhvj/RphYwRUddNZ5Bc3k8mjTg==
ARC-Authentication-Results: i=1;
	rspamd-6c65898bb7-d5bjd;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trade-Juvenile: 43aeb75f1b60307a_1711393016545_300916818
X-MC-Loop-Signature: 1711393016545:3385171856
X-MC-Ingress-Time: 1711393016544
Received: from pdx1-sub0-mail-a293.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.119.87.146 (trex/6.9.2);
	Mon, 25 Mar 2024 18:56:56 +0000
Received: from offworld (unknown [108.175.208.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a293.dreamhost.com (Postfix) with ESMTPSA id 4V3Mc63VmPzVQ;
	Mon, 25 Mar 2024 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1711393015;
	bh=K1CXbXnAFlONaPrEbG4EfG6Hava8F3+i+2sN8gQ/+WM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ehda3m16hJ/Q5j/ASPgzJZrAtjKa94N5nlJ7PlxAh/nTkPhMaRIXlHXJhDW97OIyj
	 BPHMu9nzSBkpRKdh5vHFTZa4MD0eL6h5eJS6v8QFeny/Q8lZzwM0xJ4WEW5uephajx
	 QKqj+4r6XGRuqfa8miQrSaw3LIR6Nsh9FmmAd4GhhC9I7lyyKNiUEnE/Nbu7uW3ab1
	 LncLfpVuKdcQ6evyJtino3LD5iDl56cRpXrQnoEeqOzsbS1NF41Z/1C7gM+uDhOak7
	 9w7ESZK+7XNiQr5XYYVvCFuI2o+bNKoG1XDvJii1Y3JiCj6DfMr24bcWyKuKNmCUxq
	 6n9V2jeRDLDfQ==
Date: Mon, 25 Mar 2024 11:56:51 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Subject: Re: [PATCH v9 1/7] locking/mutex: Remove wakeups from under
 mutex::wait_lock
Message-ID: <337g63unj3bdmblohoue2m66i5mciykmngdxzjcn2ark7uvywv@cy5pn5c75prd>
References: <20240315044007.2778856-1-jstultz@google.com>
 <20240315044007.2778856-2-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240315044007.2778856-2-jstultz@google.com>
User-Agent: NeoMutt/20231221

On Thu, 14 Mar 2024, John Stultz wrote:

>From: Peter Zijlstra <peterz@infradead.org>
>
>In preparation to nest mutex::wait_lock under rq::lock we need to remove
>wakeups from under it.

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

>
>Cc: Joel Fernandes <joelaf@google.com>
>Cc: Qais Yousef <qyousef@google.com>
>Cc: Ingo Molnar <mingo@redhat.com>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: Juri Lelli <juri.lelli@redhat.com>
>Cc: Vincent Guittot <vincent.guittot@linaro.org>
>Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>Cc: Valentin Schneider <vschneid@redhat.com>
>Cc: Steven Rostedt <rostedt@goodmis.org>
>Cc: Ben Segall <bsegall@google.com>
>Cc: Zimuzo Ezeozue <zezeozue@google.com>
>Cc: Youssef Esmat <youssefesmat@google.com>
>Cc: Mel Gorman <mgorman@suse.de>
>Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>Cc: Will Deacon <will@kernel.org>
>Cc: Waiman Long <longman@redhat.com>
>Cc: Boqun Feng <boqun.feng@gmail.com>
>Cc: "Paul E. McKenney" <paulmck@kernel.org>
>Cc: Metin Kaya <Metin.Kaya@arm.com>
>Cc: Xuewen Yan <xuewen.yan94@gmail.com>
>Cc: K Prateek Nayak <kprateek.nayak@amd.com>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: kernel-team@android.com
>Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>[Heavily changed after 55f036ca7e74 ("locking: WW mutex cleanup") and
>08295b3b5bee ("locking: Implement an algorithm choice for Wound-Wait
>mutexes")]
>Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>[jstultz: rebased to mainline, added extra wake_up_q & init
> to avoid hangs, similar to Connor's rework of this patch]
>Signed-off-by: John Stultz <jstultz@google.com>
>---
>v5:
>* Reverted back to an earlier version of this patch to undo
>  the change that kept the wake_q in the ctx structure, as
>  that broke the rule that the wake_q must always be on the
>  stack, as its not safe for concurrency.
>v6:
>* Made tweaks suggested by Waiman Long
>v7:
>* Fixups to pass wake_qs down for PREEMPT_RT logic
>---
> kernel/locking/mutex.c       | 17 +++++++++++++----
> kernel/locking/rtmutex.c     | 26 +++++++++++++++++---------
> kernel/locking/rwbase_rt.c   |  4 +++-
> kernel/locking/rwsem.c       |  4 ++--
> kernel/locking/spinlock_rt.c |  3 ++-
> kernel/locking/ww_mutex.h    | 29 ++++++++++++++++++-----------
> 6 files changed, 55 insertions(+), 28 deletions(-)
>
>diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
>index cbae8c0b89ab..980ce630232c 100644
>--- a/kernel/locking/mutex.c
>+++ b/kernel/locking/mutex.c
>@@ -575,6 +575,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> 		    struct lockdep_map *nest_lock, unsigned long ip,
> 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
> {
>+	DEFINE_WAKE_Q(wake_q);
> 	struct mutex_waiter waiter;
> 	struct ww_mutex *ww;
> 	int ret;
>@@ -625,7 +626,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> 	 */
> 	if (__mutex_trylock(lock)) {
> 		if (ww_ctx)
>-			__ww_mutex_check_waiters(lock, ww_ctx);
>+			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
>
> 		goto skip_wait;
> 	}
>@@ -645,7 +646,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> 		 * Add in stamp order, waking up waiters that must kill
> 		 * themselves.
> 		 */
>-		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
>+		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx, &wake_q);
> 		if (ret)
> 			goto err_early_kill;
> 	}
>@@ -681,6 +682,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> 		}
>
> 		raw_spin_unlock(&lock->wait_lock);
>+		/* Make sure we do wakeups before calling schedule */
>+		if (!wake_q_empty(&wake_q)) {
>+			wake_up_q(&wake_q);
>+			wake_q_init(&wake_q);
>+		}
> 		schedule_preempt_disabled();
>
> 		first = __mutex_waiter_is_first(lock, &waiter);
>@@ -714,7 +720,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> 		 */
> 		if (!ww_ctx->is_wait_die &&
> 		    !__mutex_waiter_is_first(lock, &waiter))
>-			__ww_mutex_check_waiters(lock, ww_ctx);
>+			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
> 	}
>
> 	__mutex_remove_waiter(lock, &waiter);
>@@ -730,6 +736,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> 		ww_mutex_lock_acquired(ww, ww_ctx);
>
> 	raw_spin_unlock(&lock->wait_lock);
>+	wake_up_q(&wake_q);
> 	preempt_enable();
> 	return 0;
>
>@@ -741,6 +748,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
> 	raw_spin_unlock(&lock->wait_lock);
> 	debug_mutex_free_waiter(&waiter);
> 	mutex_release(&lock->dep_map, ip);
>+	wake_up_q(&wake_q);
> 	preempt_enable();
> 	return ret;
> }
>@@ -934,6 +942,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
> 		}
> 	}
>
>+	preempt_disable();
> 	raw_spin_lock(&lock->wait_lock);
> 	debug_mutex_unlock(lock);
> 	if (!list_empty(&lock->wait_list)) {
>@@ -952,8 +961,8 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
> 		__mutex_handoff(lock, next);
>
> 	raw_spin_unlock(&lock->wait_lock);
>-
> 	wake_up_q(&wake_q);
>+	preempt_enable();
> }
>
> #ifndef CONFIG_DEBUG_LOCK_ALLOC
>diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
>index 4a10e8c16fd2..eaac8b196a69 100644
>--- a/kernel/locking/rtmutex.c
>+++ b/kernel/locking/rtmutex.c
>@@ -34,13 +34,15 @@
>
> static inline int __ww_mutex_add_waiter(struct rt_mutex_waiter *waiter,
> 					struct rt_mutex *lock,
>-					struct ww_acquire_ctx *ww_ctx)
>+					struct ww_acquire_ctx *ww_ctx,
>+					struct wake_q_head *wake_q)
> {
> 	return 0;
> }
>
> static inline void __ww_mutex_check_waiters(struct rt_mutex *lock,
>-					    struct ww_acquire_ctx *ww_ctx)
>+					    struct ww_acquire_ctx *ww_ctx,
>+					    struct wake_q_head *wake_q)
> {
> }
>
>@@ -1206,6 +1208,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
> 	struct rt_mutex_waiter *top_waiter = waiter;
> 	struct rt_mutex_base *next_lock;
> 	int chain_walk = 0, res;
>+	DEFINE_WAKE_Q(wake_q);
>
> 	lockdep_assert_held(&lock->wait_lock);
>
>@@ -1244,7 +1247,8 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
>
> 		/* Check whether the waiter should back out immediately */
> 		rtm = container_of(lock, struct rt_mutex, rtmutex);
>-		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx);
>+		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx, &wake_q);
>+		wake_up_q(&wake_q);
> 		if (res) {
> 			raw_spin_lock(&task->pi_lock);
> 			rt_mutex_dequeue(lock, waiter);
>@@ -1677,7 +1681,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
> 				       struct ww_acquire_ctx *ww_ctx,
> 				       unsigned int state,
> 				       enum rtmutex_chainwalk chwalk,
>-				       struct rt_mutex_waiter *waiter)
>+				       struct rt_mutex_waiter *waiter,
>+				       struct wake_q_head *wake_q)
> {
> 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
> 	struct ww_mutex *ww = ww_container_of(rtm);
>@@ -1688,7 +1693,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
> 	/* Try to acquire the lock again: */
> 	if (try_to_take_rt_mutex(lock, current, NULL)) {
> 		if (build_ww_mutex() && ww_ctx) {
>-			__ww_mutex_check_waiters(rtm, ww_ctx);
>+			__ww_mutex_check_waiters(rtm, ww_ctx, wake_q);
> 			ww_mutex_lock_acquired(ww, ww_ctx);
> 		}
> 		return 0;
>@@ -1706,7 +1711,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
> 		/* acquired the lock */
> 		if (build_ww_mutex() && ww_ctx) {
> 			if (!ww_ctx->is_wait_die)
>-				__ww_mutex_check_waiters(rtm, ww_ctx);
>+				__ww_mutex_check_waiters(rtm, ww_ctx, wake_q);
> 			ww_mutex_lock_acquired(ww, ww_ctx);
> 		}
> 	} else {
>@@ -1728,7 +1733,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
>
> static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
> 					     struct ww_acquire_ctx *ww_ctx,
>-					     unsigned int state)
>+					     unsigned int state,
>+					     struct wake_q_head *wake_q)
> {
> 	struct rt_mutex_waiter waiter;
> 	int ret;
>@@ -1737,7 +1743,7 @@ static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
> 	waiter.ww_ctx = ww_ctx;
>
> 	ret = __rt_mutex_slowlock(lock, ww_ctx, state, RT_MUTEX_MIN_CHAINWALK,
>-				  &waiter);
>+				  &waiter, wake_q);
>
> 	debug_rt_mutex_free_waiter(&waiter);
> 	return ret;
>@@ -1753,6 +1759,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
> 				     struct ww_acquire_ctx *ww_ctx,
> 				     unsigned int state)
> {
>+	DEFINE_WAKE_Q(wake_q);
> 	unsigned long flags;
> 	int ret;
>
>@@ -1774,8 +1781,9 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
> 	 * irqsave/restore variants.
> 	 */
> 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
>-	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state);
>+	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state, &wake_q);
> 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>+	wake_up_q(&wake_q);
> 	rt_mutex_post_schedule();
>
> 	return ret;
>diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
>index 34a59569db6b..e9d2f38b70f3 100644
>--- a/kernel/locking/rwbase_rt.c
>+++ b/kernel/locking/rwbase_rt.c
>@@ -69,6 +69,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
> 				      unsigned int state)
> {
> 	struct rt_mutex_base *rtm = &rwb->rtmutex;
>+	DEFINE_WAKE_Q(wake_q);
> 	int ret;
>
> 	rwbase_pre_schedule();
>@@ -110,7 +111,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
> 	 * For rwlocks this returns 0 unconditionally, so the below
> 	 * !ret conditionals are optimized out.
> 	 */
>-	ret = rwbase_rtmutex_slowlock_locked(rtm, state);
>+	ret = rwbase_rtmutex_slowlock_locked(rtm, state, &wake_q);
>
> 	/*
> 	 * On success the rtmutex is held, so there can't be a writer
>@@ -122,6 +123,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
> 	if (!ret)
> 		atomic_inc(&rwb->readers);
> 	raw_spin_unlock_irq(&rtm->wait_lock);
>+	wake_up_q(&wake_q);
> 	if (!ret)
> 		rwbase_rtmutex_unlock(rtm);
>
>diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>index 2340b6d90ec6..74ebb2915d63 100644
>--- a/kernel/locking/rwsem.c
>+++ b/kernel/locking/rwsem.c
>@@ -1415,8 +1415,8 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
> #define rwbase_rtmutex_lock_state(rtm, state)		\
> 	__rt_mutex_lock(rtm, state)
>
>-#define rwbase_rtmutex_slowlock_locked(rtm, state)	\
>-	__rt_mutex_slowlock_locked(rtm, NULL, state)
>+#define rwbase_rtmutex_slowlock_locked(rtm, state, wq)	\
>+	__rt_mutex_slowlock_locked(rtm, NULL, state, wq)
>
> #define rwbase_rtmutex_unlock(rtm)			\
> 	__rt_mutex_unlock(rtm)
>diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
>index 38e292454fcc..fb1810a14c9d 100644
>--- a/kernel/locking/spinlock_rt.c
>+++ b/kernel/locking/spinlock_rt.c
>@@ -162,7 +162,8 @@ rwbase_rtmutex_lock_state(struct rt_mutex_base *rtm, unsigned int state)
> }
>
> static __always_inline int
>-rwbase_rtmutex_slowlock_locked(struct rt_mutex_base *rtm, unsigned int state)
>+rwbase_rtmutex_slowlock_locked(struct rt_mutex_base *rtm, unsigned int state,
>+			       struct wake_q_head *wake_q)
> {
> 	rtlock_slowlock_locked(rtm);
> 	return 0;
>diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
>index 3ad2cc4823e5..7189c6631d90 100644
>--- a/kernel/locking/ww_mutex.h
>+++ b/kernel/locking/ww_mutex.h
>@@ -275,7 +275,7 @@ __ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
>  */
> static bool
> __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
>-	       struct ww_acquire_ctx *ww_ctx)
>+	       struct ww_acquire_ctx *ww_ctx, struct wake_q_head *wake_q)
> {
> 	if (!ww_ctx->is_wait_die)
> 		return false;
>@@ -284,7 +284,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
> #ifndef WW_RT
> 		debug_mutex_wake_waiter(lock, waiter);
> #endif
>-		wake_up_process(waiter->task);
>+		wake_q_add(wake_q, waiter->task);
> 	}
>
> 	return true;
>@@ -299,7 +299,8 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
>  */
> static bool __ww_mutex_wound(struct MUTEX *lock,
> 			     struct ww_acquire_ctx *ww_ctx,
>-			     struct ww_acquire_ctx *hold_ctx)
>+			     struct ww_acquire_ctx *hold_ctx,
>+			     struct wake_q_head *wake_q)
> {
> 	struct task_struct *owner = __ww_mutex_owner(lock);
>
>@@ -331,7 +332,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
> 		 * wakeup pending to re-read the wounded state.
> 		 */
> 		if (owner != current)
>-			wake_up_process(owner);
>+			wake_q_add(wake_q, owner);
>
> 		return true;
> 	}
>@@ -352,7 +353,8 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
>  * The current task must not be on the wait list.
>  */
> static void
>-__ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
>+__ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx,
>+			 struct wake_q_head *wake_q)
> {
> 	struct MUTEX_WAITER *cur;
>
>@@ -364,8 +366,8 @@ __ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
> 		if (!cur->ww_ctx)
> 			continue;
>
>-		if (__ww_mutex_die(lock, cur, ww_ctx) ||
>-		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
>+		if (__ww_mutex_die(lock, cur, ww_ctx, wake_q) ||
>+		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx, wake_q))
> 			break;
> 	}
> }
>@@ -377,6 +379,8 @@ __ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
> static __always_inline void
> ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
> {
>+	DEFINE_WAKE_Q(wake_q);
>+
> 	ww_mutex_lock_acquired(lock, ctx);
>
> 	/*
>@@ -405,8 +409,10 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
> 	 * die or wound us.
> 	 */
> 	lock_wait_lock(&lock->base);
>-	__ww_mutex_check_waiters(&lock->base, ctx);
>+	__ww_mutex_check_waiters(&lock->base, ctx, &wake_q);
> 	unlock_wait_lock(&lock->base);
>+
>+	wake_up_q(&wake_q);
> }
>
> static __always_inline int
>@@ -488,7 +494,8 @@ __ww_mutex_check_kill(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
> static inline int
> __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
> 		      struct MUTEX *lock,
>-		      struct ww_acquire_ctx *ww_ctx)
>+		      struct ww_acquire_ctx *ww_ctx,
>+		      struct wake_q_head *wake_q)
> {
> 	struct MUTEX_WAITER *cur, *pos = NULL;
> 	bool is_wait_die;
>@@ -532,7 +539,7 @@ __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
> 		pos = cur;
>
> 		/* Wait-Die: ensure younger waiters die. */
>-		__ww_mutex_die(lock, cur, ww_ctx);
>+		__ww_mutex_die(lock, cur, ww_ctx, wake_q);
> 	}
>
> 	__ww_waiter_add(lock, waiter, pos);
>@@ -550,7 +557,7 @@ __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
> 		 * such that either we or the fastpath will wound @ww->ctx.
> 		 */
> 		smp_mb();
>-		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
>+		__ww_mutex_wound(lock, ww_ctx, ww->ctx, wake_q);
> 	}
>
> 	return 0;
>-- 
>2.44.0.291.gc1ea87d7ee-goog
>

