Return-Path: <linux-kernel+bounces-111030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F73886724
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCD628664D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDCA125CF;
	Fri, 22 Mar 2024 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OfM2OJn5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D5En/XVX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47D12E4E;
	Fri, 22 Mar 2024 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090337; cv=none; b=A/848OsFi/yi4rO4ZzHi0k8h3yML+iSxdR4EiJl6jgIXxJFOOZAKEbc/LXViUQbXXezoeYJk1cvPa5AZjNS8eyCo4om0B0OsE9JVKlVo5loFXkuMneWy3bzqhrHwpE5/Ib1sbeKWsaNXv0Jt6mvsVLiZv1XCvVqlJQ86grRbSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090337; c=relaxed/simple;
	bh=c/c2J0T4Njb2yEG5FXJ/KJsgOSV2WBfTuNEbXUIr2sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmUyc1mstjtCE/lUQYwgBRoXSUeRu12av/fQapvNOEGNHJl9LQAGV+cOl/YNMts9jDhQRqSAKxy833cy6k8WNC8VJoOsSA4Q5rD/HmqAkfAu0rfTmWhB5Aqbo+RD2VxxKHhsYEqUDU5C+Y3uA6/vOb6a6uZGBLDTg8RXutGNjFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OfM2OJn5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D5En/XVX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711090333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnlY1ymuqUTKAU2tKPJuN/MrGHqEs1BNfNhRgjDfv7c=;
	b=OfM2OJn5IabXIDYl8vmOV2MLXD5UBzlico2CZPj6O+ZZ7CASQ3NIJm3J4Bu/2LjcX9MRvQ
	bChWYQOhAMaH5Y8ANmL2JvTbSh8t5XUk5lJX6tR0hVs/VNc4rxZvTl42JcxWrCksSv9vBH
	6UykHfMqr/xSZr0uIU57pozfow3WdeATjEOBn1Z9Qj3nOwAY9Pe55xouOylzZxbcf73Y+q
	bD1ZdP2P3KMBiH5h5erepNVgT89AzRCehrT8oOjJ8DepMagb2Q58WkzPyhejPo13hlgo2S
	8OWJ6jxzGbWxNhX/5gXHKUQfEeQiFALsZEQvtnYI84YL8bXvAlfi5fS90bJRIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711090333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnlY1ymuqUTKAU2tKPJuN/MrGHqEs1BNfNhRgjDfv7c=;
	b=D5En/XVXaGh2CWize9oJe0opewKazr80KyguOrkAtzXDDcDOWzgQUDxXXTfW66dae5VVVv
	Q5YFLO8KZUd//9Dw==
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
Subject: [PATCH v3 3/4] perf: Remove perf_swevent_get_recursion_context() from perf_pending_task().
Date: Fri, 22 Mar 2024 07:48:23 +0100
Message-ID: <20240322065208.60456-4-bigeasy@linutronix.de>
In-Reply-To: <20240322065208.60456-1-bigeasy@linutronix.de>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
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

Tested-by: Marco Elver <elver@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/events/core.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e0b2da8de485f..5400f7ed2f98b 100644
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


