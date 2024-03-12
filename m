Return-Path: <linux-kernel+bounces-100629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886EA879AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6CC28450F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37948139580;
	Tue, 12 Mar 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FlRpaK8V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zkQxTGQN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6B1386C9;
	Tue, 12 Mar 2024 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266902; cv=none; b=TjR0yoR63k8thHBZpGlKzluSDfDM4tVeX09TCgcxHvWdKswgk2GKu4E9xnFJdmnNQX+xtj2eaYkkSP9AUykgl3yQMxqyqOIsUqPmtW/BSxplSepNPjUGTb4kzk1r95Us0DyTLtcRbwvF9vFLZ/8FqA6DiQyGllC+EntJXi0Fvgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266902; c=relaxed/simple;
	bh=1x/H3KVUUkvLDmgpGS1Nke9B7aI3HIltrKV+AEtaWUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zzjoo7CXlaKlcGfK2EIwT+/sBmeVZGt2ua9lkBOJeqT9QDeEIiJ24wh47EIq85ZlCkTZbnlJkoobj0EFf5onWjsmUHadzL+u1B7ZHs1OLYmOdcp5gOVuwzmPL9D/qNP6rdD0yFqyXA/MGRrfcksYJl15+j91DQdHjz+wA5JefjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FlRpaK8V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zkQxTGQN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710266899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Hqyi2fLhMWja1cb9pKy7mpQ/l/tY6lU3b5qleZavj0=;
	b=FlRpaK8V0LL+grFWiufBw6+J4iYqdxrDkwuneWjK1G48cxiZtepWKEOa2k/7TPhSwRz6Gn
	EpYwmF4LUCXk4zVE0Ij+6iIHU5lVhQ45qExcy9z7ToJiRHyoomz9F9nOK6dpk1b7uNFsCm
	DoxYXnkzrainnR3BdfiydZwdEXUWSibSQPn+bZfv8z2rZz7T54sLUAYWB96ltn4hH+AoXe
	cwVGdm6r233oUFOFnzQzHE1gfHNPNQIutPXx356RU5QUAfo4axFH8h5ZPKnSImGgM2yQRJ
	R7HPpcIPlxzDiZqb6/JDY6fj524+48V33G+N6kv6X3ojPtmI3JAcjpypEhZgMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710266899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Hqyi2fLhMWja1cb9pKy7mpQ/l/tY6lU3b5qleZavj0=;
	b=zkQxTGQNAcgLTsONtHCfBggjrEVyeFiJ7l+Hc7dC1ndjspI4TpWGszvL4/I+7FHgYNvTKT
	A/Z9i0hwgXo8WxCw==
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
Subject: [PATCH v2 1/4] perf: Move irq_work_queue() where the event is prepared.
Date: Tue, 12 Mar 2024 19:01:49 +0100
Message-ID: <20240312180814.3373778-2-bigeasy@linutronix.de>
In-Reply-To: <20240312180814.3373778-1-bigeasy@linutronix.de>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
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


