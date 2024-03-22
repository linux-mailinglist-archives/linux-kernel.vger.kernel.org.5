Return-Path: <linux-kernel+bounces-111032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB17886726
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707C01C23921
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7F1134DE;
	Fri, 22 Mar 2024 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QRnaIk3Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="srG5idyu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE15B12E56;
	Fri, 22 Mar 2024 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090337; cv=none; b=JGnME1JSbCQmfTYNxqHz21guCy2gmNdqv34t6h7yqrRwpVe9GH2tWWn7lxHSUDKCho95tjFN5tTd1uu0sX0pKmh4uLofwyF7GyMcC5/0ieLexIPqgDmPqO9onUOCJ9kdupOTrzqtju7+9YMNZAleUmfUluv3eAnmshkdYdkmwnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090337; c=relaxed/simple;
	bh=SshC32YEexUo3g/CT1Jab1UAR6HgOFlH0X5KoqCdP8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UG8E0fhIRIw2lZZJxk9dsvM/xF9yVnuqE+J6DMsb335DeuRgaEfVrxnKe1AHQHmR4pEwzcMsTtAJcLexmA5HvMP95p1lE8GJgMpobb0I8UYtr4M491hrgKgcGKDJhZtfKSJTlomc6Xa6fBTIc/08SUC7KfqueCVM/mp9QZbUEEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QRnaIk3Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=srG5idyu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711090333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVWkTfLyeena7uooSCx+qKpvfluWfb5gR012eo5Qaig=;
	b=QRnaIk3YqfUgMyeXsAuTSZuaIWsD908AqkeCTTHWHgcsVlDIgZGaRhleqYEKzD1Yim06sc
	jiIJ/fqpiDLAwBWfrVDaZzRQPlmkdAuhQ35VMiZ66jw919erMFZR/9ByqE05HkbA6/jsEu
	t2XJc0iMN2ONveBsL2JZswXoAZ2TRdJM3/RTug/uiD/zPy/0tZ3yB5r7wzMqirUwA/74KW
	CEhAOpipsbxlfINBUXJKiRWtt7bAXWSviwykRbnzK1lHtvro9aajdRgoW3k8O4z79Lqe4x
	4ZJmvlk1jZyKQDQhD92XTD1ZMgEhvo7xGfOHcBSDglJxN7vcoyyaZBnMVclBAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711090333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVWkTfLyeena7uooSCx+qKpvfluWfb5gR012eo5Qaig=;
	b=srG5idyuqejdKcOeTBbac3C2XmruqocMTd0cS/ZaY7fqkK4vpIS+oaz6dxTSTkNVzHIa4j
	6h/0LWBRY4jRg0Bw==
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
Subject: [PATCH v3 2/4] perf: Enqueue SIGTRAP always via task_work.
Date: Fri, 22 Mar 2024 07:48:22 +0100
Message-ID: <20240322065208.60456-3-bigeasy@linutronix.de>
In-Reply-To: <20240322065208.60456-1-bigeasy@linutronix.de>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
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

Tested-by: Marco Elver <elver@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/perf_event.h |  3 +-
 kernel/events/core.c       | 58 ++++++++++++++++++++++----------------
 2 files changed, 34 insertions(+), 27 deletions(-)

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
index c7a0274c662c8..e0b2da8de485f 100644
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
@@ -9592,14 +9572,23 @@ static int __perf_event_overflow(struct perf_event =
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
+			/*
+			 * The NMI path returns directly to userland. The
+			 * irq_work is raised as a dummy interrupt to ensure
+			 * regular return path to user is taken and task_work
+			 * is processed.
+			 */
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
@@ -9609,7 +9598,7 @@ static int __perf_event_overflow(struct perf_event *e=
vent,
 			 *     To approximate progress (with false negatives),
 			 *     check 32-bit hash of the current IP.
 			 */
-			WARN_ON_ONCE(event->pending_sigtrap !=3D pending_id);
+			WARN_ON_ONCE(event->pending_work !=3D pending_id);
 		}
=20
 		event->pending_addr =3D 0;
@@ -13049,6 +13038,13 @@ static void sync_child_event(struct perf_event *ch=
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
@@ -13088,6 +13084,18 @@ perf_event_exit_event(struct perf_event *event, st=
ruct perf_event_context *ctx)
 		 * Kick perf_poll() for is_event_hup();
 		 */
 		perf_event_wakeup(parent_event);
+		/*
+		 * Cancel pending task_work and update counters if it has not
+		 * yet been delivered to userland. free_event() expects the
+		 * reference counter at one and keeping the event around until
+		 * the task returns to userland can be a unexpected if there is
+		 * no signal handler registered.
+		 */
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


