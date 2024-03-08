Return-Path: <linux-kernel+bounces-97426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9564D876A52
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B961C20E38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5654057335;
	Fri,  8 Mar 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JV4ty8dQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YJBdep7/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF340861;
	Fri,  8 Mar 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920703; cv=none; b=uTVpdh5gEF1APwVVge1sRzomCXnul3QFUv8oNn793Y2c4DkxSm5wgEaU2hIZs7WO5dGdn2aQUNbomoT+drOd9FLu+70olJSOkAEVK5KxqDSDFL4RLCw+CmBwCsQVrYk0r9Zrtg+HTY0QRCQwRrcSok5qr6ulwIgsW/obmWCu3dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920703; c=relaxed/simple;
	bh=qgIOhCi1AT5/KkPlVlTKGgFIpu/HZ3VsmyhH2xLz0Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MktAfAZmXFfXDYAYlwYAjba3Q4Bql7MHtp69yrkGKkluXc+D2RMP9VcU5SI2VgfGkW1OTzanB+DZJPegAwg3NtdJelS/UDL00ZC9lL2JX6SnhRLEbhsW3IEmsfHqBG5wp8jK4Bo8fbX8WP+dVHMV0kjcV3En61MBa1EZuBj4TCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JV4ty8dQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YJBdep7/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709920700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xk1CSY2j/Du8Z3nH9cehrGYPSezPuuWTJQyDu/5RHlc=;
	b=JV4ty8dQlJElZcsroYiiZ914/yQt/Yer5CzQbRo9i2nuCjUCqZ64EIAXcOo+ox0ut4x/bd
	rosSSDROA4j4m4SxQRXWMAq2wt44UmwVtcV2SuAb0gKGdCXdmLnRXv8FHl6+3AeJIp4ePY
	2/YTljWk1UeNjPA1EdSVVJBU7EnSVxJ3MMbxjU6Om4PbKtTmKwMWwFBUrrMNKsx4alkuRm
	lek+kHr3+GcT9BFQpFoqn/y5eRNmOoMDcCu9KtSHuKr5e8bGLbsUF/t0N+zD6NNGJ3oWgQ
	aTNe54hxf7ApwH85TYXY3bYI1Kgcdl7/aG4JpY9ncUkUxIVPLNcII9hKzXGnzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709920700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xk1CSY2j/Du8Z3nH9cehrGYPSezPuuWTJQyDu/5RHlc=;
	b=YJBdep7/6jVdWfH49/GIFla8t1NJkLGvNkRNgK3L5DM5IGlxgxVukz6HUXU/ORoOHf+BoX
	zgAuKav8usy12mDg==
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/4] perf: Enqueue SIGTRAP always via task_work.
Date: Fri,  8 Mar 2024 18:51:28 +0100
Message-ID: <20240308175810.2894694-3-bigeasy@linutronix.de>
In-Reply-To: <20240308175810.2894694-1-bigeasy@linutronix.de>
References: <20240308175810.2894694-1-bigeasy@linutronix.de>
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
return path to userland instead triggering irq_work.

Queue signal via task_work. Remove perf_event::pending_sigtrap and
and use perf_event::pending_work instead.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/perf_event.h |  3 +--
 kernel/events/core.c       | 31 ++++++-------------------------
 2 files changed, 7 insertions(+), 27 deletions(-)

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
index c7a0274c662c8..e4a85d6d2d685 100644
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
@@ -9592,14 +9572,15 @@ static int __perf_event_overflow(struct perf_event =
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
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
-			 * consuming pending_sigtrap; with exceptions:
+			 * consuming pending_work; with exceptions:
 			 *
 			 *  1. Where !exclude_kernel, events can overflow again
 			 *     in the kernel without returning to user space.
@@ -9609,7 +9590,7 @@ static int __perf_event_overflow(struct perf_event *e=
vent,
 			 *     To approximate progress (with false negatives),
 			 *     check 32-bit hash of the current IP.
 			 */
-			WARN_ON_ONCE(event->pending_sigtrap !=3D pending_id);
+			WARN_ON_ONCE(event->pending_work !=3D pending_id);
 		}
=20
 		event->pending_addr =3D 0;
--=20
2.43.0


