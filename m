Return-Path: <linux-kernel+bounces-111031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72E6886725
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D0B1C2392A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EAB134B7;
	Fri, 22 Mar 2024 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R/coBq4W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xp+iD1Gd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF92012E58;
	Fri, 22 Mar 2024 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090337; cv=none; b=IPijOGtixbef1YwP2CbYPOz9oQpVuX7Vp8K4gqFPir/zId9rHybQThEyK5c/SlrinbzqWHdpIpQSlAnVy/GavS/P7V10deyhNpM05qyqsPgSmfBflo857xq9ytBONtbnL29/KMubnQyNVkQMp0MPonG1IxjFbvhjO0JFs1KfxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090337; c=relaxed/simple;
	bh=Hbaot7IOfbezNSwmi+D2RM/9exlbCH1lvaP6EvROjME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MD6WCeaHsoor8pc3FgiWsEcouICEXlH4ibNdSGA5o0b5qbH9SgBGKg+pQuoLXi4B5jbbGJsmX4phw9Jz8JUMfoVek2iEjl2VWPQKuBgQMNNN/bekywFBuA42uPORVC4cfAQZqw1KJwXqbeshfVh6jHgkOVCcLaZ9HXUXCXfx4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R/coBq4W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xp+iD1Gd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711090334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mViIwBzJy2LbFMx+Z7s8eLKaVOiaGkwX39mLOOJ/Zkk=;
	b=R/coBq4WVDanAJSympKYEkcTLEPkFfr+pUYY2xlwu+a3Evqi4jBxt1tw3RwxxgATxp7xxo
	7H7rdcf2SchrIzqH744ucqN/hkEcnvQfnKWTwlW0dMswNmy8ruFOWbL62b/k8+PpR/lbjm
	Ne1tebYvDKELwJap0TG8dKvnDfUx6xKuTJ+SL5j+wauGLP6KUMWjC3uXsjIHyDjkhGHGHf
	huRgTZs0WPsUmkiVa17MiX1gqhuT/plxEEAiA2T+k2oNoe0QQNGvuyZhQGMrR1+epvMwqw
	bHtaHkx+Hm7bygyvRRuONcKvaVFL+v4ffH4bzsRqKc7KYR5ZLjP0jCTEROEKXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711090334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mViIwBzJy2LbFMx+Z7s8eLKaVOiaGkwX39mLOOJ/Zkk=;
	b=Xp+iD1GdbQXf30FVh0tu2M6r9nb6GmCCcjyrrb22uE4CYjXHszVNWSthCNXKJ0oPu4nimP
	YJHWkjLADt292wDQ==
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 4/4] perf: Split __perf_pending_irq() out of perf_pending_irq()
Date: Fri, 22 Mar 2024 07:48:24 +0100
Message-ID: <20240322065208.60456-5-bigeasy@linutronix.de>
In-Reply-To: <20240322065208.60456-1-bigeasy@linutronix.de>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

perf_pending_irq() invokes perf_event_wakeup() and __perf_pending_irq().
The former is in charge of waking any tasks which wait to be woken up
while the latter disables perf-events.

The irq_work perf_pending_irq(), while this an irq_work, the callback
is invoked in thread context on PREEMPT_RT. This is needed because all
the waking functions (wake_up_all(), kill_fasync()) acquire sleep locks
which must not be used with disabled interrupts.
Disabling events, as done by __perf_pending_irq(), expects a hardirq
context and disabled interrupts. This requirement is not fulfilled on
PREEMPT_RT.

Split functionality based on perf_event::pending_disable into irq_work
named `pending_disable_irq' and invoke it in hardirq context on
PREEMPT_RT. Rename the split out callback to perf_pending_disable().

Tested-by: Marco Elver <elver@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 31 +++++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 24ac6765146c7..c1c6600541657 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -783,6 +783,7 @@ struct perf_event {
 	unsigned int			pending_disable;
 	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending_irq;
+	struct irq_work			pending_disable_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
=20
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5400f7ed2f98b..7266265ed8cc3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2449,7 +2449,7 @@ static void __perf_event_disable(struct perf_event *e=
vent,
  * hold the top-level event's child_mutex, so any descendant that
  * goes to exit will block in perf_event_exit_event().
  *
- * When called from perf_pending_irq it's OK because event->ctx
+ * When called from perf_pending_disable it's OK because event->ctx
  * is the current context on this CPU and preemption is disabled,
  * hence we can't get into perf_event_task_sched_out for this context.
  */
@@ -2489,7 +2489,7 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
 void perf_event_disable_inatomic(struct perf_event *event)
 {
 	event->pending_disable =3D 1;
-	irq_work_queue(&event->pending_irq);
+	irq_work_queue(&event->pending_disable_irq);
 }
=20
 #define MAX_INTERRUPTS (~0ULL)
@@ -5175,6 +5175,7 @@ static void perf_addr_filters_splice(struct perf_even=
t *event,
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
+	irq_work_sync(&event->pending_disable_irq);
=20
 	unaccount_event(event);
=20
@@ -6711,7 +6712,7 @@ static void perf_sigtrap(struct perf_event *event)
 /*
  * Deliver the pending work in-event-context or follow the context.
  */
-static void __perf_pending_irq(struct perf_event *event)
+static void __perf_pending_disable(struct perf_event *event)
 {
 	int cpu =3D READ_ONCE(event->oncpu);
=20
@@ -6749,11 +6750,26 @@ static void __perf_pending_irq(struct perf_event *e=
vent)
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
+	struct perf_event *event =3D container_of(entry, struct perf_event, pendi=
ng_disable_irq);
+	int rctx;
+
+	/*
+	 * If we 'fail' here, that's OK, it means recursion is already disabled
+	 * and we won't recurse 'further'.
+	 */
+	rctx =3D perf_swevent_get_recursion_context();
+	__perf_pending_disable(event);
+	if (rctx >=3D 0)
+		perf_swevent_put_recursion_context(rctx);
 }
=20
 static void perf_pending_irq(struct irq_work *entry)
@@ -6776,8 +6792,6 @@ static void perf_pending_irq(struct irq_work *entry)
 		perf_event_wakeup(event);
 	}
=20
-	__perf_pending_irq(event);
-
 	if (rctx >=3D 0)
 		perf_swevent_put_recursion_context(rctx);
 }
@@ -9572,7 +9586,7 @@ static int __perf_event_overflow(struct perf_event *e=
vent,
 			 * is processed.
 			 */
 			if (in_nmi())
-				irq_work_queue(&event->pending_irq);
+				irq_work_queue(&event->pending_disable_irq);
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
@@ -11912,6 +11926,7 @@ perf_event_alloc(struct perf_event_attr *attr, int =
cpu,
=20
 	init_waitqueue_head(&event->waitq);
 	init_irq_work(&event->pending_irq, perf_pending_irq);
+	event->pending_disable_irq =3D IRQ_WORK_INIT_HARD(perf_pending_disable);
 	init_task_work(&event->pending_task, perf_pending_task);
=20
 	mutex_init(&event->mmap_mutex);
--=20
2.43.0


