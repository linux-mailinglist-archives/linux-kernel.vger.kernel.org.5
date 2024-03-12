Return-Path: <linux-kernel+bounces-100630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF048879AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F1EAB22575
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD78113A241;
	Tue, 12 Mar 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FzDvtQFE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bplIYOM7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFA51386D7;
	Tue, 12 Mar 2024 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266903; cv=none; b=r5vA1bFmQFXdfS7sJ0mN9Z4FylZHhzstu48U5NhJ2pvFnBFSztB1bB9J+gmCECPxKKOYTUH3uCcoJiwwl8vAMJtnKvoKn8KSPxQE9VaTnSM8hdNGSAOLVKEQkt0LMlTFOVEFE1Ba2bVQSjCcQVCvhzwj+v/w72h0Ok3zoqGZino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266903; c=relaxed/simple;
	bh=6l83FdDvP2J288XcuZLEjZlDTBYSxX9HG2Utn+NslVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oi87Ud9CnGH/EDQFzsbCGjclSwzghAs7mQKgAJIACMzExysQZwaGJf3r4Puej/prZQjk48zdIm1vJ3q5B7FWGd6Jf/L97/SyCXWiv4HHVHTgs91QmOTFexZvpzKaSNdNOMQjWMsYifGaPOTZmqyBcMnGIHwJYi6+eOqn4c2xebY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FzDvtQFE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bplIYOM7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710266900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gzy9SPwrARPOA/xtYrKfgamluH10kQc4EK8NgErjSzg=;
	b=FzDvtQFEzj+uxqVz20lyDguF5w0hRZYS5SiiuaR7ot6QhuzZfFogCA/McJz54kouG3Do19
	QeuKoEq8+zloHOTOcCGtf+lH5g6tYAxvMjnMLFp7wcfzVR4VNT8Jz60DlDiyatOcyfwwT3
	l1BPwQ/LuCG21dlgsrHd5vXCMurTlWzQ7Lb8N10b0CI49ZRaGe3gevwisBUlfcQguS7beS
	9CfgWTKZmkOX7EzvXctcIhns8vauZyQhtNhlT5OUSqAe+khzBKzD1wsY04UK38bNNzRNVw
	TjH/ptf4HKT3NsIcL4XgMprXUTn7wEtyMa5b8aXjahdYe/J1edRCIgxP9Ki9Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710266900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gzy9SPwrARPOA/xtYrKfgamluH10kQc4EK8NgErjSzg=;
	b=bplIYOM7cFbineSWB8elScLOdzw+FTEw6B8e9WUQKRVFaJaacp+04guBx7xIjgafWCj+U6
	JTEZ3AV1sWbdInAA==
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
Subject: [PATCH v2 3/4] perf: Remove perf_swevent_get_recursion_context() from perf_pending_task().
Date: Tue, 12 Mar 2024 19:01:51 +0100
Message-ID: <20240312180814.3373778-4-bigeasy@linutronix.de>
In-Reply-To: <20240312180814.3373778-1-bigeasy@linutronix.de>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
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
index e9926baaa1587..806514d76d8dc 100644
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


