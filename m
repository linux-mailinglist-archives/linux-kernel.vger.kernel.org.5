Return-Path: <linux-kernel+bounces-100631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AC0879AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DB2284516
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41CA13A248;
	Tue, 12 Mar 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KNe/wpzl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JuPvkuXr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638F81386D1;
	Tue, 12 Mar 2024 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266903; cv=none; b=oyk9hwO+Sj22yA9pnZYWmBQ2+kJPdQgfOOumr7L+ol14xZbmQrj6Wk9RHYvW/kjTCRmSLJ9eYNDYjxFfvSCv28eH0BONH0FGAWZVlEPXkwhq3D/xrjjiYkAfso5J09eWh58q6WeAox1QRXoSkRGSsQkXmsuvI2KDUAmS8aI6Np8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266903; c=relaxed/simple;
	bh=oSh885xTWKQ1RgRzIZ35HM/jKMTC9MM21WT7E2eDHhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkoGXLOY6B2OnSsQIhV858gtJEEYHrfLsNRx1iVIaW/kJN/NU8yviMRcVHXtpQwWywzg9Gx7aLrtiWFz3HVF1FUDAZt4QjhLQU2ydzkQw/5lNxf/hOHMZhAOX9vLvzq7xFs7Qx9OIF+4R+3TNPUXMxHZSNCZCcZARCiSSRSYxhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KNe/wpzl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JuPvkuXr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710266899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FE3b5PyhcD0TC3K+2ITLv4adUr9UbVkRxLK+4jENi1c=;
	b=KNe/wpzleBuytTNWmN+9si37DQRO1Y5ECkdID0eDtVsQ4gy82jDsGnmbnmHvE2Vroe9vmN
	y3J/uTp/xWufHXtBqzUaEhs1grsO96Ri2258o5BbmeHDpuebFs02AeoFWwnQas43MJcYKc
	H8OnaVMqNkG/x9POZiowCOcBH04P/0JEUDU0Yf96JHA4kNfVAd5QstJi+T/GQUp1uEIACU
	7Kve/X7BaAuldwIrilJ8NaRzkpRZIf/FQFj6CWa9km3tcSyWabVQAVw/YXUH1ZUtGGrBhH
	CUjGrXhTm09Bhq7kOGxX+Q97JIZDDAnZclP1goE9kYPCnylAZIuVZn6GduUBOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710266899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FE3b5PyhcD0TC3K+2ITLv4adUr9UbVkRxLK+4jENi1c=;
	b=JuPvkuXrOEbkzZdHF7heOO9tFIBO+vI7c6+PnRC2JQXqN9IFTCqYiFV7yScuvnIkMHKih9
	3s5NrcTaKLb6XSCQ==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/4] perf: Enqueue SIGTRAP always via task_work.
Date: Tue, 12 Mar 2024 19:01:50 +0100
Message-ID: <20240312180814.3373778-3-bigeasy@linutronix.de>
In-Reply-To: <20240312180814.3373778-1-bigeasy@linutronix.de>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A signal is delivered by raising irq_work() which works from any context
including NMI. irq_work() can be delayed if the architecture does not
provide an interrupt vector. In order not to lose a signal, the signal
is injected via task_work during event_sched_out().

Instead going via irq_work, the signal could be added directly via
task_work. The signal is sent to current and can be enqueued on its
return path to userland instead of triggering irq_work. A dummy IRQ is
required in the NMI case to ensure the task_work is handled before
returning to user land. For this irq_work is used. An alternative would
be just raising an interrupt like arch_send_call_function_single_ipi().

During testing with `remove_on_exec' it become visible that the event
can be enqueued via NMI during execve(). The task_work must not be kept
because free_event() will complain later. Also the new task will not
have a sighandler installed.

Queue signal via task_work. Remove perf_event::pending_sigtrap and
and use perf_event::pending_work instead. Raise irq_work in the NMI case
for a dummy interrupt. Remove the task_work if the event is freed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/perf_event.h |  3 +--
 kernel/events/core.c       | 45 +++++++++++++++++---------------------
 2 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a9..24ac6765146c7 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -781,7 +781,6 @@ struct perf_event {
 	unsigned int			pending_wakeup;
 	unsigned int			pending_kill;
 	unsigned int			pending_disable;
-	unsigned int			pending_sigtrap;
 	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending_irq;
 	struct callback_head		pending_task;
@@ -959,7 +958,7 @@ struct perf_event_context {
 	struct rcu_head			rcu_head;
=20
 	/*
-	 * Sum (event->pending_sigtrap + event->pending_work)
+	 * Sum (event->pending_work + event->pending_work)
 	 *
 	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
 	 * that until the signal is delivered.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c7a0274c662c8..e9926baaa1587 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2283,21 +2283,6 @@ event_sched_out(struct perf_event *event, struct per=
f_event_context *ctx)
 		state =3D PERF_EVENT_STATE_OFF;
 	}
=20
-	if (event->pending_sigtrap) {
-		bool dec =3D true;
-
-		event->pending_sigtrap =3D 0;
-		if (state !=3D PERF_EVENT_STATE_OFF &&
-		    !event->pending_work) {
-			event->pending_work =3D 1;
-			dec =3D false;
-			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
-			task_work_add(current, &event->pending_task, TWA_RESUME);
-		}
-		if (dec)
-			local_dec(&event->ctx->nr_pending);
-	}
-
 	perf_event_set_state(event, state);
=20
 	if (!is_software_event(event))
@@ -6741,11 +6726,6 @@ static void __perf_pending_irq(struct perf_event *ev=
ent)
 	 * Yay, we hit home and are in the context of the event.
 	 */
 	if (cpu =3D=3D smp_processor_id()) {
-		if (event->pending_sigtrap) {
-			event->pending_sigtrap =3D 0;
-			perf_sigtrap(event);
-			local_dec(&event->ctx->nr_pending);
-		}
 		if (event->pending_disable) {
 			event->pending_disable =3D 0;
 			perf_event_disable_local(event);
@@ -9592,14 +9572,17 @@ static int __perf_event_overflow(struct perf_event =
*event,
=20
 		if (regs)
 			pending_id =3D hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
-		if (!event->pending_sigtrap) {
-			event->pending_sigtrap =3D pending_id;
+		if (!event->pending_work) {
+			event->pending_work =3D pending_id;
 			local_inc(&event->ctx->nr_pending);
-			irq_work_queue(&event->pending_irq);
+			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
+			task_work_add(current, &event->pending_task, TWA_RESUME);
+			if (in_nmi())
+				irq_work_queue(&event->pending_irq);
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
-			 * consuming pending_sigtrap; with exceptions:
+			 * consuming pending_work; with exceptions:
 			 *
 			 *  1. Where !exclude_kernel, events can overflow again
 			 *     in the kernel without returning to user space.
@@ -9609,7 +9592,7 @@ static int __perf_event_overflow(struct perf_event *e=
vent,
 			 *     To approximate progress (with false negatives),
 			 *     check 32-bit hash of the current IP.
 			 */
-			WARN_ON_ONCE(event->pending_sigtrap !=3D pending_id);
+			WARN_ON_ONCE(event->pending_work !=3D pending_id);
 		}
=20
 		event->pending_addr =3D 0;
@@ -13049,6 +13032,13 @@ static void sync_child_event(struct perf_event *ch=
ild_event)
 		     &parent_event->child_total_time_running);
 }
=20
+static bool task_work_cb_match(struct callback_head *cb, void *data)
+{
+	struct perf_event *event =3D container_of(cb, struct perf_event, pending_=
task);
+
+	return event =3D=3D data;
+}
+
 static void
 perf_event_exit_event(struct perf_event *event, struct perf_event_context =
*ctx)
 {
@@ -13088,6 +13078,11 @@ perf_event_exit_event(struct perf_event *event, st=
ruct perf_event_context *ctx)
 		 * Kick perf_poll() for is_event_hup();
 		 */
 		perf_event_wakeup(parent_event);
+		if (event->pending_work &&
+		    task_work_cancel_match(current, task_work_cb_match, event)) {
+			put_event(event);
+			local_dec(&event->ctx->nr_pending);
+		}
 		free_event(event);
 		put_event(parent_event);
 		return;
--=20
2.43.0


