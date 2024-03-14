Return-Path: <linux-kernel+bounces-103213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FAF87BC74
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B9D1C210D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63EC6F08C;
	Thu, 14 Mar 2024 12:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nbr07aKq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="09+5Y9LJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F148B54677;
	Thu, 14 Mar 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417823; cv=none; b=uZxeFLJLS3YOHNDD62PAzcO2ul+Gml3kfKWrFEoVHSrvYnA3ANLBMCpoFLVXW4kYE3LzDTqFe98jb5BMlbZfN28wVQWA5y4j6jeZC1IpCgqf1Tp1oZ+tlPPuMcSkPB2RdQ85S0jMblreAxo25pVd5XHc1HsZ9rRT1K8RbgXPyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417823; c=relaxed/simple;
	bh=Ya9ClXmprOYCXToCDV/TonbxEk6cIDyym6QwzAq8A2M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tCaExIDuG0klRR2gqz4ZzVyY0H668mmv6bt764vF5SUXMb+e0xQh68B5ZRgr2V2e1zVKd5bk1aAO2+IJDNKmQkSArxr0cplxy+wz1x43W3JJQS7epQbUJiC0SApbtY+JbRw74jk1wdIUKdDhnMcZ92aiaGH7BSfUX07ufggw3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nbr07aKq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=09+5Y9LJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Mar 2024 13:03:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710417819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ur50fVRaQP7TkIq5KmIsmOdoE7+QG3BQ02aH7AEkF0U=;
	b=nbr07aKq0tkk2jsGIAGh61+ROw0/Mka0hPge0BKzhIovLRFt8LPBkennMG1Q9nGoyJQQjD
	Png2j2Wc9Vp0LP6Bt9j84F28Vnr2Ym/GAk6T7Tqs71iAfnWNh+Oqq9pTAAHaBK8gdy3gHw
	5a60ES5p9QO64pR67K+ZPtlwNJR8IuAtKKSc0xZRLtaXc2xXCWSwhAmzVHBV225brw8wv8
	922jEltXUyTBvF7aKEqibv+2JJg/99q//cydjmYWau7p+6BqJ+nptR2RHAWdYswa8Haszn
	c09XWatcI4DXUXlOBnDtzOUWLJfkAOia5uPHxju1Q1An/8g2ck1jIMiPQ108jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710417819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ur50fVRaQP7TkIq5KmIsmOdoE7+QG3BQ02aH7AEkF0U=;
	b=09+5Y9LJshEwUO4LjL5hgcAYLLn+Pd/7zQtTK+Le23OHCeEX3m/6YIQFwGs00f3r6P2nIR
	9JLUGwE5zyXPjcCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.8-rt8
Message-ID: <20240314120337.jQwGma2t@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Dear RT folks!

I'm pleased to announce the v6.8-rt8 patch set. 

Changes since v6.8-rt7:

  - Add NAPI threads for backlog processing. The patch series replaces a
    RT specific workaround in the current RT series and avoids a warning
    once RPS is enabled. The warning, that is triggered once RPS gets
    enabled, was reported by Wander Lairson Costa.

  - perf's testsuite 'perf test sigtrap' reported an error. The way
    perf's SIGTRAP gets reported and how events are sometimes disabled
    has been reworked. Upstream didn't complain but is still testing.
    The issue has been reported by Arnaldo Carvalho de Melo.

Known issues
    None.

The delta patch against v6.8-rt7 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/incr/patch-6.8-rt7-rt8.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.8-rt8

The RT patch against v6.8 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patch-6.8-rt8.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.8/older/patches-6.8-rt8.tar.xz

Sebastian

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 557efca75a74c..0a29b856786e7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3323,11 +3323,7 @@ struct softnet_data {
 	int			defer_count;
 	int			defer_ipi_scheduled;
 	struct sk_buff		*defer_list;
-#ifndef CONFIG_PREEMPT_RT
 	call_single_data_t	defer_csd;
-#else
-	struct work_struct	defer_work;
-#endif
 };
 
 static inline void input_queue_head_incr(struct softnet_data *sd)
@@ -3369,6 +3365,7 @@ static inline void dev_xmit_recursion_dec(void)
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
 
+void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a9..c1c6600541657 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -781,9 +781,9 @@ struct perf_event {
 	unsigned int			pending_wakeup;
 	unsigned int			pending_kill;
 	unsigned int			pending_disable;
-	unsigned int			pending_sigtrap;
 	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending_irq;
+	struct irq_work			pending_disable_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
 
@@ -959,7 +959,7 @@ struct perf_event_context {
 	struct rcu_head			rcu_head;
 
 	/*
-	 * Sum (event->pending_sigtrap + event->pending_work)
+	 * Sum (event->pending_work + event->pending_work)
 	 *
 	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
 	 * that until the signal is delivered.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0f0f71213a1d..d5af4d03c2680 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2283,21 +2283,6 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 		state = PERF_EVENT_STATE_OFF;
 	}
 
-	if (event->pending_sigtrap) {
-		bool dec = true;
-
-		event->pending_sigtrap = 0;
-		if (state != PERF_EVENT_STATE_OFF &&
-		    !event->pending_work) {
-			event->pending_work = 1;
-			dec = false;
-			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
-			task_work_add(current, &event->pending_task, TWA_RESUME);
-		}
-		if (dec)
-			local_dec(&event->ctx->nr_pending);
-	}
-
 	perf_event_set_state(event, state);
 
 	if (!is_software_event(event))
@@ -2464,7 +2449,7 @@ static void __perf_event_disable(struct perf_event *event,
  * hold the top-level event's child_mutex, so any descendant that
  * goes to exit will block in perf_event_exit_event().
  *
- * When called from perf_pending_irq it's OK because event->ctx
+ * When called from perf_pending_disable it's OK because event->ctx
  * is the current context on this CPU and preemption is disabled,
  * hence we can't get into perf_event_task_sched_out for this context.
  */
@@ -2504,7 +2489,7 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
 void perf_event_disable_inatomic(struct perf_event *event)
 {
 	event->pending_disable = 1;
-	irq_work_queue(&event->pending_irq);
+	irq_work_queue(&event->pending_disable_irq);
 }
 
 #define MAX_INTERRUPTS (~0ULL)
@@ -5190,6 +5175,7 @@ static void perf_addr_filters_splice(struct perf_event *event,
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
+	irq_work_sync(&event->pending_disable_irq);
 
 	unaccount_event(event);
 
@@ -6726,7 +6712,7 @@ static void perf_sigtrap(struct perf_event *event)
 /*
  * Deliver the pending work in-event-context or follow the context.
  */
-static void __perf_pending_irq(struct perf_event *event)
+static void __perf_pending_disable(struct perf_event *event)
 {
 	int cpu = READ_ONCE(event->oncpu);
 
@@ -6741,11 +6727,6 @@ static void __perf_pending_irq(struct perf_event *event)
 	 * Yay, we hit home and are in the context of the event.
 	 */
 	if (cpu == smp_processor_id()) {
-		if (event->pending_sigtrap) {
-			event->pending_sigtrap = 0;
-			perf_sigtrap(event);
-			local_dec(&event->ctx->nr_pending);
-		}
 		if (event->pending_disable) {
 			event->pending_disable = 0;
 			perf_event_disable_local(event);
@@ -6769,11 +6750,26 @@ static void __perf_pending_irq(struct perf_event *event)
 	 *				  irq_work_queue(); // FAILS
 	 *
 	 *  irq_work_run()
-	 *    perf_pending_irq()
+	 *    perf_pending_disable()
 	 *
 	 * But the event runs on CPU-B and wants disabling there.
 	 */
-	irq_work_queue_on(&event->pending_irq, cpu);
+	irq_work_queue_on(&event->pending_disable_irq, cpu);
+}
+
+static void perf_pending_disable(struct irq_work *entry)
+{
+	struct perf_event *event = container_of(entry, struct perf_event, pending_disable_irq);
+	int rctx;
+
+	/*
+	 * If we 'fail' here, that's OK, it means recursion is already disabled
+	 * and we won't recurse 'further'.
+	 */
+	rctx = perf_swevent_get_recursion_context();
+	__perf_pending_disable(event);
+	if (rctx >= 0)
+		perf_swevent_put_recursion_context(rctx);
 }
 
 static void perf_pending_irq(struct irq_work *entry)
@@ -6796,8 +6792,6 @@ static void perf_pending_irq(struct irq_work *entry)
 		perf_event_wakeup(event);
 	}
 
-	__perf_pending_irq(event);
-
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
 }
@@ -6805,14 +6799,6 @@ static void perf_pending_irq(struct irq_work *entry)
 static void perf_pending_task(struct callback_head *head)
 {
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
-	int rctx;
-
-	/*
-	 * If we 'fail' here, that's OK, it means recursion is already disabled
-	 * and we won't recurse 'further'.
-	 */
-	preempt_disable_notrace();
-	rctx = perf_swevent_get_recursion_context();
 
 	if (event->pending_work) {
 		event->pending_work = 0;
@@ -6820,10 +6806,6 @@ static void perf_pending_task(struct callback_head *head)
 		local_dec(&event->ctx->nr_pending);
 	}
 
-	if (rctx >= 0)
-		perf_swevent_put_recursion_context(rctx);
-	preempt_enable_notrace();
-
 	put_event(event);
 }
 
@@ -9592,13 +9574,23 @@ static int __perf_event_overflow(struct perf_event *event,
 
 		if (regs)
 			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
-		if (!event->pending_sigtrap) {
-			event->pending_sigtrap = pending_id;
+		if (!event->pending_work) {
+			event->pending_work = pending_id;
 			local_inc(&event->ctx->nr_pending);
+			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
+			task_work_add(current, &event->pending_task, TWA_RESUME);
+			/*
+			 * The NMI path returns directly to userland. The
+			 * irq_work is raised as a dummy interrupt to ensure
+			 * regular return path to user is taken and task_work
+			 * is processed.
+			 */
+			if (in_nmi())
+				irq_work_queue(&event->pending_disable_irq);
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
-			 * consuming pending_sigtrap; with exceptions:
+			 * consuming pending_work; with exceptions:
 			 *
 			 *  1. Where !exclude_kernel, events can overflow again
 			 *     in the kernel without returning to user space.
@@ -9608,13 +9600,12 @@ static int __perf_event_overflow(struct perf_event *event,
 			 *     To approximate progress (with false negatives),
 			 *     check 32-bit hash of the current IP.
 			 */
-			WARN_ON_ONCE(event->pending_sigtrap != pending_id);
+			WARN_ON_ONCE(event->pending_work != pending_id);
 		}
 
 		event->pending_addr = 0;
 		if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
 			event->pending_addr = data->addr;
-		irq_work_queue(&event->pending_irq);
 	}
 
 	READ_ONCE(event->overflow_handler)(event, data, regs);
@@ -11935,6 +11926,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	init_waitqueue_head(&event->waitq);
 	init_irq_work(&event->pending_irq, perf_pending_irq);
+	event->pending_disable_irq = IRQ_WORK_INIT_HARD(perf_pending_disable);
 	init_task_work(&event->pending_task, perf_pending_task);
 
 	mutex_init(&event->mmap_mutex);
@@ -13049,6 +13041,13 @@ static void sync_child_event(struct perf_event *child_event)
 		     &parent_event->child_total_time_running);
 }
 
+static bool task_work_cb_match(struct callback_head *cb, void *data)
+{
+	struct perf_event *event = container_of(cb, struct perf_event, pending_task);
+
+	return event == data;
+}
+
 static void
 perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 {
@@ -13088,6 +13087,17 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		 * Kick perf_poll() for is_event_hup();
 		 */
 		perf_event_wakeup(parent_event);
+		/*
+		 * Cancel pending task_work and update counters if it has not
+		 * yet been delivered to userland. free_event() expects the
+		 * reference counter at 1 and keeping the event around until the
+		 * task return to userland will be a unexpected.
+		 */
+		if (event->pending_work &&
+		    task_work_cancel_match(current, task_work_cb_match, event)) {
+			put_event(event);
+			local_dec(&event->ctx->nr_pending);
+		}
 		free_event(event);
 		put_event(parent_event);
 		return;
diff --git a/localversion-rt b/localversion-rt
index 045478966e9f1..700c857efd9ba 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt7
+-rt8
diff --git a/net/core/dev.c b/net/core/dev.c
index df102ed8622c9..9e66559611e73 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -78,6 +78,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
+#include <linux/smpboot.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/string.h>
@@ -216,35 +217,60 @@ static inline struct hlist_head *dev_index_hash(struct net *net, int ifindex)
 	return &net->dev_index_head[ifindex & (NETDEV_HASHENTRIES - 1)];
 }
 
-static inline void rps_lock_irqsave(struct softnet_data *sd,
-				    unsigned long *flags)
+#ifndef CONFIG_PREEMPT_RT
+
+static DEFINE_STATIC_KEY_FALSE(use_backlog_threads_key);
+
+static int __init setup_backlog_napi_threads(char *arg)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	static_branch_enable(&use_backlog_threads_key);
+	return 0;
+}
+early_param("thread_backlog_napi", setup_backlog_napi_threads);
+
+static bool use_backlog_threads(void)
+{
+	return static_branch_unlikely(&use_backlog_threads_key);
+}
+
+#else
+
+static bool use_backlog_threads(void)
+{
+	return true;
+}
+
+#endif
+
+static inline void backlog_lock_irq_save(struct softnet_data *sd,
+					 unsigned long *flags)
+{
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irqsave(&sd->input_pkt_queue.lock, *flags);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_save(*flags);
 }
 
-static inline void rps_lock_irq_disable(struct softnet_data *sd)
+static inline void backlog_lock_irq_disable(struct softnet_data *sd)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irq(&sd->input_pkt_queue.lock);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_disable();
 }
 
-static inline void rps_unlock_irq_restore(struct softnet_data *sd,
-					  unsigned long *flags)
+static inline void backlog_unlock_irq_restore(struct softnet_data *sd,
+					      unsigned long *flags)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, *flags);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_restore(*flags);
 }
 
-static inline void rps_unlock_irq_enable(struct softnet_data *sd)
+static inline void backlog_unlock_irq_enable(struct softnet_data *sd)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irq(&sd->input_pkt_queue.lock);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_enable();
@@ -4420,6 +4446,7 @@ EXPORT_SYMBOL(__dev_direct_xmit);
 /*************************************************************************
  *			Receiver routines
  *************************************************************************/
+static DEFINE_PER_CPU(struct task_struct *, backlog_napi);
 
 int netdev_max_backlog __read_mostly = 1000;
 EXPORT_SYMBOL(netdev_max_backlog);
@@ -4452,18 +4479,16 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 		 */
 		thread = READ_ONCE(napi->thread);
 		if (thread) {
-			/* Avoid doing set_bit() if the thread is in
-			 * INTERRUPTIBLE state, cause napi_thread_wait()
-			 * makes sure to proceed with napi polling
-			 * if the thread is explicitly woken from here.
-			 */
-			if (READ_ONCE(thread->__state) != TASK_INTERRUPTIBLE)
-				set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
+			if (use_backlog_threads() && thread == raw_cpu_read(backlog_napi))
+				goto use_local_napi;
+
+			set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
 			wake_up_process(thread);
 			return;
 		}
 	}
 
+use_local_napi:
 	list_add_tail(&napi->poll_list, &sd->poll_list);
 	WRITE_ONCE(napi->list_owner, smp_processor_id());
 	/* If not called from net_rx_action()
@@ -4684,6 +4709,15 @@ static void rps_trigger_softirq(void *data)
 
 #endif /* CONFIG_RPS */
 
+/* Called from hardirq (IPI) context */
+static void trigger_rx_softirq(void *data)
+{
+	struct softnet_data *sd = data;
+
+	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+	smp_store_release(&sd->defer_ipi_scheduled, 0);
+}
+
 /*
  * After we queued a packet into sd->input_pkt_queue,
  * we need to make sure this queue is serviced soon.
@@ -4700,6 +4734,11 @@ static void napi_schedule_rps(struct softnet_data *sd)
 
 #ifdef CONFIG_RPS
 	if (sd != mysd) {
+		if (use_backlog_threads()) {
+			__napi_schedule_irqoff(&sd->backlog);
+			return;
+		}
+
 		sd->rps_ipi_next = mysd->rps_ipi_list;
 		mysd->rps_ipi_list = sd;
 
@@ -4714,6 +4753,23 @@ static void napi_schedule_rps(struct softnet_data *sd)
 	__napi_schedule_irqoff(&mysd->backlog);
 }
 
+void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu)
+{
+	unsigned long flags;
+
+	if (use_backlog_threads()) {
+		backlog_lock_irq_save(sd, &flags);
+
+		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
+			__napi_schedule_irqoff(&sd->backlog);
+
+		backlog_unlock_irq_restore(sd, &flags);
+
+	} else if (!cmpxchg(&sd->defer_ipi_scheduled, 0, 1)) {
+		smp_call_function_single_async(cpu, &sd->defer_csd);
+	}
+}
+
 #ifdef CONFIG_NET_FLOW_LIMIT
 int netdev_flow_limit_table_len __read_mostly = (1 << 12);
 #endif
@@ -4769,7 +4825,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	sd = &per_cpu(softnet_data, cpu);
 
-	rps_lock_irqsave(sd, &flags);
+	backlog_lock_irq_save(sd, &flags);
 	if (!netif_running(skb->dev))
 		goto drop;
 	qlen = skb_queue_len(&sd->input_pkt_queue);
@@ -4778,7 +4834,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 enqueue:
 			__skb_queue_tail(&sd->input_pkt_queue, skb);
 			input_queue_tail_incr_save(sd, qtail);
-			rps_unlock_irq_restore(sd, &flags);
+			backlog_unlock_irq_restore(sd, &flags);
 			return NET_RX_SUCCESS;
 		}
 
@@ -4793,7 +4849,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 
 drop:
 	sd->dropped++;
-	rps_unlock_irq_restore(sd, &flags);
+	backlog_unlock_irq_restore(sd, &flags);
 
 	dev_core_stats_rx_dropped_inc(skb->dev);
 	kfree_skb_reason(skb, reason);
@@ -5824,7 +5880,7 @@ static void flush_backlog(struct work_struct *work)
 	local_bh_disable();
 	sd = this_cpu_ptr(&softnet_data);
 
-	rps_lock_irq_disable(sd);
+	backlog_lock_irq_disable(sd);
 	skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->input_pkt_queue);
@@ -5832,7 +5888,7 @@ static void flush_backlog(struct work_struct *work)
 			input_queue_head_incr(sd);
 		}
 	}
-	rps_unlock_irq_enable(sd);
+	backlog_unlock_irq_enable(sd);
 
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
@@ -5850,14 +5906,14 @@ static bool flush_required(int cpu)
 	struct softnet_data *sd = &per_cpu(softnet_data, cpu);
 	bool do_flush;
 
-	rps_lock_irq_disable(sd);
+	backlog_lock_irq_disable(sd);
 
 	/* as insertion into process_queue happens with the rps lock held,
 	 * process_queue access may race only with dequeue
 	 */
 	do_flush = !skb_queue_empty(&sd->input_pkt_queue) ||
 		   !skb_queue_empty_lockless(&sd->process_queue);
-	rps_unlock_irq_enable(sd);
+	backlog_unlock_irq_enable(sd);
 
 	return do_flush;
 #endif
@@ -5923,7 +5979,7 @@ static void net_rps_action_and_irq_enable(struct softnet_data *sd)
 #ifdef CONFIG_RPS
 	struct softnet_data *remsd = sd->rps_ipi_list;
 
-	if (remsd) {
+	if (!use_backlog_threads() && remsd) {
 		sd->rps_ipi_list = NULL;
 
 		local_irq_enable();
@@ -5938,7 +5994,7 @@ static void net_rps_action_and_irq_enable(struct softnet_data *sd)
 static bool sd_has_rps_ipi_waiting(struct softnet_data *sd)
 {
 #ifdef CONFIG_RPS
-	return sd->rps_ipi_list != NULL;
+	return !use_backlog_threads() && sd->rps_ipi_list;
 #else
 	return false;
 #endif
@@ -5972,7 +6028,7 @@ static int process_backlog(struct napi_struct *napi, int quota)
 
 		}
 
-		rps_lock_irq_disable(sd);
+		backlog_lock_irq_disable(sd);
 		if (skb_queue_empty(&sd->input_pkt_queue)) {
 			/*
 			 * Inline a custom version of __napi_complete().
@@ -5982,13 +6038,13 @@ static int process_backlog(struct napi_struct *napi, int quota)
 			 * We can use a plain write instead of clear_bit(),
 			 * and we dont need an smp_mb() memory barrier.
 			 */
-			napi->state = 0;
+			napi->state &= NAPIF_STATE_THREADED;
 			again = false;
 		} else {
 			skb_queue_splice_tail_init(&sd->input_pkt_queue,
 						   &sd->process_queue);
 		}
-		rps_unlock_irq_enable(sd);
+		backlog_unlock_irq_enable(sd);
 	}
 
 	return work;
@@ -6645,8 +6701,6 @@ static int napi_poll(struct napi_struct *n, struct list_head *repoll)
 
 static int napi_thread_wait(struct napi_struct *napi)
 {
-	bool woken = false;
-
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	while (!kthread_should_stop()) {
@@ -6655,15 +6709,13 @@ static int napi_thread_wait(struct napi_struct *napi)
 		 * Testing SCHED bit is not enough because SCHED bit might be
 		 * set by some other busy poll thread or by napi_disable().
 		 */
-		if (test_bit(NAPI_STATE_SCHED_THREADED, &napi->state) || woken) {
+		if (test_bit(NAPI_STATE_SCHED_THREADED, &napi->state)) {
 			WARN_ON(!list_empty(&napi->poll_list));
 			__set_current_state(TASK_RUNNING);
 			return 0;
 		}
 
 		schedule();
-		/* woken being true indicates this thread owns this napi. */
-		woken = true;
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	__set_current_state(TASK_RUNNING);
@@ -6692,66 +6744,46 @@ static void skb_defer_free_flush(struct softnet_data *sd)
 	}
 }
 
-#ifndef CONFIG_PREEMPT_RT
-
-/* Called from hardirq (IPI) context */
-static void trigger_rx_softirq(void *data)
-{
-	struct softnet_data *sd = data;
-
-	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
-	smp_store_release(&sd->defer_ipi_scheduled, 0);
-}
-
-#else
-
-static void trigger_rx_softirq(struct work_struct *defer_work)
+static void napi_threaded_poll_loop(struct napi_struct *napi)
 {
 	struct softnet_data *sd;
 
-	sd = container_of(defer_work, struct softnet_data, defer_work);
-	smp_store_release(&sd->defer_ipi_scheduled, 0);
-	local_bh_disable();
-	skb_defer_free_flush(sd);
-	local_bh_enable();
-}
+	for (;;) {
+		bool repoll = false;
+		void *have;
 
-#endif
+		local_bh_disable();
+		sd = this_cpu_ptr(&softnet_data);
+		sd->in_napi_threaded_poll = true;
+
+		have = netpoll_poll_lock(napi);
+		__napi_poll(napi, &repoll);
+		netpoll_poll_unlock(have);
+
+		sd->in_napi_threaded_poll = false;
+		barrier();
+
+		if (sd_has_rps_ipi_waiting(sd)) {
+			local_irq_disable();
+			net_rps_action_and_irq_enable(sd);
+		}
+		skb_defer_free_flush(sd);
+		local_bh_enable();
+
+		if (!repoll)
+			break;
+
+		cond_resched();
+	}
+}
 
 static int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi = data;
-	struct softnet_data *sd;
-	void *have;
 
-	while (!napi_thread_wait(napi)) {
-		for (;;) {
-			bool repoll = false;
+	while (!napi_thread_wait(napi))
+		napi_threaded_poll_loop(napi);
 
-			local_bh_disable();
-			sd = this_cpu_ptr(&softnet_data);
-			sd->in_napi_threaded_poll = true;
-
-			have = netpoll_poll_lock(napi);
-			__napi_poll(napi, &repoll);
-			netpoll_poll_unlock(have);
-
-			sd->in_napi_threaded_poll = false;
-			barrier();
-
-			if (sd_has_rps_ipi_waiting(sd)) {
-				local_irq_disable();
-				net_rps_action_and_irq_enable(sd);
-			}
-			skb_defer_free_flush(sd);
-			local_bh_enable();
-
-			if (!repoll)
-				break;
-
-			cond_resched();
-		}
-	}
 	return 0;
 }
 
@@ -11350,7 +11382,7 @@ static int dev_cpu_dead(unsigned int oldcpu)
 
 		list_del_init(&napi->poll_list);
 		if (napi->poll == process_backlog)
-			napi->state = 0;
+			napi->state &= NAPIF_STATE_THREADED;
 		else
 			____napi_schedule(sd, napi);
 	}
@@ -11358,12 +11390,14 @@ static int dev_cpu_dead(unsigned int oldcpu)
 	raise_softirq_irqoff(NET_TX_SOFTIRQ);
 	local_irq_enable();
 
+	if (!use_backlog_threads()) {
 #ifdef CONFIG_RPS
-	remsd = oldsd->rps_ipi_list;
-	oldsd->rps_ipi_list = NULL;
+		remsd = oldsd->rps_ipi_list;
+		oldsd->rps_ipi_list = NULL;
 #endif
-	/* send out pending IPI's on offline CPU */
-	net_rps_send_ipi(remsd);
+		/* send out pending IPI's on offline CPU */
+		net_rps_send_ipi(remsd);
+	}
 
 	/* Process offline CPU's input_pkt_queue */
 	while ((skb = __skb_dequeue(&oldsd->process_queue))) {
@@ -11682,6 +11716,38 @@ static void __init net_dev_struct_check(void)
  *
  */
 
+static int backlog_napi_should_run(unsigned int cpu)
+{
+	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
+	struct napi_struct *napi = &sd->backlog;
+
+	return test_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
+}
+
+static void run_backlog_napi(unsigned int cpu)
+{
+	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
+
+	napi_threaded_poll_loop(&sd->backlog);
+}
+
+static void backlog_napi_setup(unsigned int cpu)
+{
+	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
+	struct napi_struct *napi = &sd->backlog;
+
+	napi->thread = this_cpu_read(backlog_napi);
+	set_bit(NAPI_STATE_THREADED, &napi->state);
+}
+
+static struct smp_hotplug_thread backlog_threads = {
+	.store			= &backlog_napi,
+	.thread_should_run	= backlog_napi_should_run,
+	.thread_fn		= run_backlog_napi,
+	.thread_comm		= "backlog_napi/%u",
+	.setup			= backlog_napi_setup,
+};
+
 /*
  *       This is called single threaded during boot, so no need
  *       to take the rtnl semaphore.
@@ -11728,17 +11794,16 @@ static int __init net_dev_init(void)
 		INIT_CSD(&sd->csd, rps_trigger_softirq, sd);
 		sd->cpu = i;
 #endif
-#ifndef CONFIG_PREEMPT_RT
 		INIT_CSD(&sd->defer_csd, trigger_rx_softirq, sd);
-#else
-		INIT_WORK(&sd->defer_work, trigger_rx_softirq);
-#endif
 		spin_lock_init(&sd->defer_lock);
 
 		init_gro_hash(&sd->backlog);
 		sd->backlog.poll = process_backlog;
 		sd->backlog.weight = weight_p;
+		INIT_LIST_HEAD(&sd->backlog.poll_list);
 	}
+	if (use_backlog_threads())
+		smpboot_register_percpu_thread(&backlog_threads);
 
 	dev_boot_phase = 0;
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 633da914cc499..bd4985ff5717a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6921,13 +6921,8 @@ nodefer:	__kfree_skb(skb);
 	/* Make sure to trigger NET_RX_SOFTIRQ on the remote CPU
 	 * if we are unlucky enough (this seems very unlikely).
 	 */
-	if (unlikely(kick) && !cmpxchg(&sd->defer_ipi_scheduled, 0, 1)) {
-#ifndef CONFIG_PREEMPT_RT
-		smp_call_function_single_async(cpu, &sd->defer_csd);
-#else
-		schedule_work_on(cpu, &sd->defer_work);
-#endif
-	}
+	if (unlikely(kick))
+		kick_defer_list_purge(sd, cpu);
 }
 
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,

