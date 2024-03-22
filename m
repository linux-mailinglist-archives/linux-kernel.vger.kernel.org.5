Return-Path: <linux-kernel+bounces-111033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2073C886727
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC3C282E05
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826BC168D2;
	Fri, 22 Mar 2024 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pR9WjbU0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s3klKYcv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E4612E59;
	Fri, 22 Mar 2024 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090338; cv=none; b=SxFUiGFJDN9Wtht8HM0eFePdsO/jrDDgQf2HdJfoAwsonZmMoYgCO9+fiT7SjuqYC2kJXvglKoO44WuVbUmajo6l9wCu4xyFeDdmOx8oy8eYs2y9l8aeIeaztgSnDc7RkotVkEaBy28VDZYGPks9RM2ZLlXrrLK7m2ngdN0VRD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090338; c=relaxed/simple;
	bh=uov7lUYJCh+xUy0eBkN2SDq6BsxY/KiedSXqxnqt6Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3vJcTSjZYp5lmvlFe6suLronx63CNUCuF1r0A1XMY3gzJaO6KgYWASAzf/o92G80NWsu30zylpUf00KcUWof9kySyTTfBtM7062zQWUGgqDDvDLsGskCnwbvMrw0fgyAGIlV9SuM88+yTay/ZxBvcN5UYB8mwgWCV8/VetW+zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pR9WjbU0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s3klKYcv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711090333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rP0uMrbdvGuw0gaehpXjO7C2OkXyANk5+OleJCkDezM=;
	b=pR9WjbU03BbCeOem1TuBr2e6C7jaLNauCxLnF5XgP5ZhDp7XaaH0wgwJmCrVRGOxE/I2AL
	j5yfVXuEa7B6Omy+hMJykSwI5AZI5FN4D7DR6LDK6NxxBdYe9o/WVCE5LXcjQrd7di5skl
	cebauT/DOQF20QlMC57965lnysNDLBNZndO4bqOovKOVZESBYibrkE++T90+pk7i5Er+Ks
	jPtyhlvc7iXtTNQXnAGO36tStjqYwt58HSCZjRxdQFrUkPOklM+434eyKgcM1b7QQ8biE6
	HoCF0xOn4FnMIxtIYLcOmP/a+EOdP7tfX5rLpBPxfFfxvaej3EzDYjoeHcok8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711090333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rP0uMrbdvGuw0gaehpXjO7C2OkXyANk5+OleJCkDezM=;
	b=s3klKYcvmpZ02aC2i9WAA1dxbfKQJSWzlaRIm754CJy9I49OjjGVVaQQRn3wyB67ZDtww9
	geTI6AuIaE7TelBw==
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
Subject: [PATCH v3 1/4] perf: Move irq_work_queue() where the event is prepared.
Date: Fri, 22 Mar 2024 07:48:21 +0100
Message-ID: <20240322065208.60456-2-bigeasy@linutronix.de>
In-Reply-To: <20240322065208.60456-1-bigeasy@linutronix.de>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Only if perf_event::pending_sigtrap is zero, the irq_work accounted by
increminging perf_event::nr_pending. The member perf_event::pending_addr
might be overwritten by a subsequent event if the signal was not yet
delivered and is expected. The irq_work will not be enqeueued again
because it has a check to be only enqueued once.

Move irq_work_queue() to where the counter is incremented and
perf_event::pending_sigtrap is set to make it more obvious that the
irq_work is scheduled once.

Tested-by: Marco Elver <elver@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0f0f71213a1d..c7a0274c662c8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9595,6 +9595,7 @@ static int __perf_event_overflow(struct perf_event *e=
vent,
 		if (!event->pending_sigtrap) {
 			event->pending_sigtrap =3D pending_id;
 			local_inc(&event->ctx->nr_pending);
+			irq_work_queue(&event->pending_irq);
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
@@ -9614,7 +9615,6 @@ static int __perf_event_overflow(struct perf_event *e=
vent,
 		event->pending_addr =3D 0;
 		if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
 			event->pending_addr =3D data->addr;
-		irq_work_queue(&event->pending_irq);
 	}
=20
 	READ_ONCE(event->overflow_handler)(event, data, regs);
--=20
2.43.0


