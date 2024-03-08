Return-Path: <linux-kernel+bounces-97427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B9B876A53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFBA1F22468
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBD45813F;
	Fri,  8 Mar 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MmosQXkY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W+3UTTpN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585540873;
	Fri,  8 Mar 2024 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920704; cv=none; b=YyUXUtzjMIXL9YostI4shNWH2QX4KVKuI+TpuOWUTtvc4kYcBLsfdCQa+EzD6G1WH7CyDjUUW/lawCo1dslMnzZxJySg9gnFNCKMJi9OzuygpnND77xZlemftMEHUJj8bF5rE2u2V50DgqLIicg/8PInT/zKzPQVjZLTHbYevPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920704; c=relaxed/simple;
	bh=a9DDZehV50x4XWLbjHcWEPL3CKFvwBk4n2wqrhoJtSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwT/D3MAW90prpD6n1/j6KVMNwhOp/IsorBRPqHQWrUA5lcoMKIlhPU/l6S/wGD709GYAMqKkqM2Fzu4ib7wzW6ipoEEySJ633m8ySpfJXMJ8thQczfKMGZw/JQM64D1kbZeKdtSc4jEYJ2zUCqVYZ+KecIxxOLaB1qGJmqMQ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MmosQXkY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W+3UTTpN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709920700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGVbVzwGMjptyOBEmR5tRxK9Ir4UTrX3Zgcyetw1CtU=;
	b=MmosQXkYlxRCAsXVqGKBRH/btOd/i92AdfGb544G35qRBb5twLYQnwRLbU8a/2sto/mUFv
	iziiUykfNmCAgz8aWx9fQ8c4nRxQhJFdo/oOek5madvrXaBfJJV8d9qcj6+Uc92HE8kOdn
	nkosZrwSfefNBrHufniIEHsCbwsSwfnPjt0EXEhtvDRqT53Cx6lgxZz2urZ/R7IPMHS/hK
	97+2X5aICCsv3v/7RuOwI060vStie0c4iHJHX8hF77M3wSF3P690P6mb/YzhrEYaikqaVu
	CeUYMNXtJfyjRaHHS9ozqTolPLEA9n6CHVasKk4q4sIaQvvkjml9Vcx/tFW9GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709920700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGVbVzwGMjptyOBEmR5tRxK9Ir4UTrX3Zgcyetw1CtU=;
	b=W+3UTTpNM5/kfWuzo8x4EEE8dijzJ4b58X9Llh3oW3Ba+M8lq5AZ4FMKvPOkgt0BiwBZ2V
	ipwsVQRqqkGhTZCA==
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
Subject: [PATCH 3/4] perf: Remove perf_swevent_get_recursion_context() from perf_pending_task().
Date: Fri,  8 Mar 2024 18:51:29 +0100
Message-ID: <20240308175810.2894694-4-bigeasy@linutronix.de>
In-Reply-To: <20240308175810.2894694-1-bigeasy@linutronix.de>
References: <20240308175810.2894694-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

perf_swevent_get_recursion_context() is supposed to avoid recursion.
This requires to remain on the same CPU in order to decrement/ increment
the same counter. This is done by using preempt_disable(). Having
preemption disabled while sending a signal leads to locking problems on
PREEMPT_RT because sighand, a spinlock_t, becomes a sleeping lock.

This callback runs in task context and currently delivers only a signal
to "itself". Any kind of recusrion protection in this context is not
required.

Remove recursion protection in perf_pending_task().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/events/core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e4a85d6d2d685..240e9b7dfd3e9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6785,14 +6785,6 @@ static void perf_pending_irq(struct irq_work *entry)
 static void perf_pending_task(struct callback_head *head)
 {
 	struct perf_event *event =3D container_of(head, struct perf_event, pendin=
g_task);
-	int rctx;
-
-	/*
-	 * If we 'fail' here, that's OK, it means recursion is already disabled
-	 * and we won't recurse 'further'.
-	 */
-	preempt_disable_notrace();
-	rctx =3D perf_swevent_get_recursion_context();
=20
 	if (event->pending_work) {
 		event->pending_work =3D 0;
@@ -6800,10 +6792,6 @@ static void perf_pending_task(struct callback_head *=
head)
 		local_dec(&event->ctx->nr_pending);
 	}
=20
-	if (rctx >=3D 0)
-		perf_swevent_put_recursion_context(rctx);
-	preempt_enable_notrace();
-
 	put_event(event);
 }
=20
--=20
2.43.0


