Return-Path: <linux-kernel+bounces-97425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68834876A51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09742B21411
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC2954BDD;
	Fri,  8 Mar 2024 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v4OmJ48C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ziHz1O9T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0BE79E5;
	Fri,  8 Mar 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920703; cv=none; b=X3cnZ5aSdNs967pbI+oUrXX7CgmujHsTCn23m4ANBu+D95NZW+1+Nqt9zZTQevCGiNWUpFvd7Gs3LlXdnj39GF3uTt5gyRc7zoddaRskOyWWavIU4z3OLBH/3+Lz3pBZDE07KaifyMakXZNlRLlHxiBK+uZB+rvT8jutLRxEmmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920703; c=relaxed/simple;
	bh=1x/H3KVUUkvLDmgpGS1Nke9B7aI3HIltrKV+AEtaWUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWIIBRbE6Wlwtplbd9LT+lY0YDKggmYkDZS4bAWgsL5OsK06Wpgm5k7j8kAlsBbLATHhq8gj+V8ssO8SG/V98nxnDZzfJahhai/Hk3YzZsaXy2tffl2kn16HZ599Vk+mPCnLnlrjNrCMdv5a4k2N1tGha4sJswHViTsjnDjBkjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v4OmJ48C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ziHz1O9T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709920699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Hqyi2fLhMWja1cb9pKy7mpQ/l/tY6lU3b5qleZavj0=;
	b=v4OmJ48CGNYbFrppyGlC2jevaEK7plTwqLa485cAKMYLlosrVridqFwI5yxacNF9se2O7b
	5NK7Htc5j7G7lkiDU4c+ZJmsDJmT1CPKU9Y21+qC/lA6fxxovNTNYUrCs67QqCrEoNeJMM
	WUwn5nl52erfDuoU6gBJCKRrwhICWQLeTYHwkMcmiuYdaaRKKiX8V0/BmY2tIW9jQOX7S6
	xE5VzwUn0fTEoqr78KPmQv1VGw6l4Pyx0rKU8wSo9mcy8lvavd90qM4sw42xtCpkqugiBP
	RZlSNW6S13I0g1dHXc2/mgtUn0NdtbQUCqVlR/8c5YUGVe18Ez7VaWOeJWf1IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709920699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Hqyi2fLhMWja1cb9pKy7mpQ/l/tY6lU3b5qleZavj0=;
	b=ziHz1O9TIToov9AHtRlOrWFr0J5dlqqZrDDkGxrMnNg4PuEw92OkwV/rwvtnBUqoEVDeGt
	HfhYub59FMz4CxCg==
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
Subject: [PATCH 1/4] perf: Move irq_work_queue() where the event is prepared.
Date: Fri,  8 Mar 2024 18:51:27 +0100
Message-ID: <20240308175810.2894694-2-bigeasy@linutronix.de>
In-Reply-To: <20240308175810.2894694-1-bigeasy@linutronix.de>
References: <20240308175810.2894694-1-bigeasy@linutronix.de>
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


