Return-Path: <linux-kernel+bounces-142459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E448A2BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCF61C21811
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712755490A;
	Fri, 12 Apr 2024 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bOGTgPzD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RbolePUL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C3853373;
	Fri, 12 Apr 2024 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916209; cv=none; b=AhUXbWG46INXELt3ezhrOUTg6BvcLArzJCmI16He1k+VlzSnZ/+9HNk1FHNM1URSoGMr228ePcEoRnXbW7igFEBw8O/zz1K6FtnSCPCNCVOy+DqGWbaUpvFtVZnXI263P6HuzcLNNC1Rz5oD4IIkZdDM9XsJUK8APoQcvr2ob/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916209; c=relaxed/simple;
	bh=0zIBIQeUn4d46LuH5dU3D3poxRyPy8U/DsOIFFWU5+Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OHWMqEM+zU2uI/QKmvCZS+9usW50RtBbIPcovLo8TlWrQjrnrNkc0ec7HiX5OcaNHAEjO1Vvc+nxKnSw/eUi9pq3RRIBzGc95XVKmSLiVKBQIFSpbjw5ZLOXPtvXEO7zKv/jQJitk+/hORE8XD7pbDQvtNcXRsr9sy1aGV+VwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bOGTgPzD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RbolePUL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:03:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUIq0gxrTeDmd9C5x2/2qge7B5M0XUhUeTvv4cmFhuU=;
	b=bOGTgPzDYPCX7PShrWeMmocCk44eLZUgVJJp6BWUZQ2FqbtmDyJxuYctijF/f66+FjJy/i
	Zuj7u0I51kf53k/Zoa8k20aWxKwXe6o5o3cOa4YLpfRNHFfqIQoSp8Q6SHUeN9PGP9Hw4h
	YcVGK1zMVEsErY5j6n/6jDnLDMGAbbv0uUCxbsHyCLoMwFJeR6O5R4hR7cAj5u3svtYws6
	PngTx0ntjMBchj9xXFClmxpERwl6L6trOjypQCvqNks8Mccz/FBNUDQCvo0sMKmuQxbYsY
	7+AmCCC2YyVWPp3CAKsxFI2hgVrs8za5uQgW7/3n191m6jd43R7ylNGPFnULhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUIq0gxrTeDmd9C5x2/2qge7B5M0XUhUeTvv4cmFhuU=;
	b=RbolePUL9uRIVi5mDrov9a6b2v8Xu+tM8SwGj5WpudUaMukyq+uWGncfMNfSHn4yPWwZmu
	NLi9tFfGtqryrqCw==
From: "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/bpf: Call BPF handler directly, not through
 overflow machinery
Cc: Namhyung Kim <namhyung@kernel.org>, Kyle Huey <khuey@kylehuey.com>,
 Ingo Molnar <mingo@kernel.org>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240412015019.7060-5-khuey@kylehuey.com>
References: <20240412015019.7060-5-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291620497.10875.8359396733030637270.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f11f10bfa1ca23b32020b2073aa13131a27978fe
Gitweb:        https://git.kernel.org/tip/f11f10bfa1ca23b32020b2073aa13131a27978fe
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Thu, 11 Apr 2024 18:50:16 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 11:49:49 +02:00

perf/bpf: Call BPF handler directly, not through overflow machinery

To ultimately allow BPF programs attached to perf events to completely
suppress all of the effects of a perf event overflow (rather than just the
sample output, as they do today), call bpf_overflow_handler() from
__perf_event_overflow() directly rather than modifying struct perf_event's
overflow_handler. Return the BPF program's return value from
bpf_overflow_handler() so that __perf_event_overflow() knows how to
proceed. Remove the now unnecessary orig_overflow_handler from struct
perf_event.

This patch is solely a refactoring and results in no behavior change.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240412015019.7060-5-khuey@kylehuey.com
---
 include/linux/perf_event.h |  6 +-----
 kernel/events/core.c       | 27 +++++++++++----------------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 50e01db..2ce2fbc 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -809,7 +809,6 @@ struct perf_event {
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
-	perf_overflow_handler_t		orig_overflow_handler;
 	struct bpf_prog			*prog;
 	u64				bpf_cookie;
 
@@ -1361,10 +1360,7 @@ __is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
 #ifdef CONFIG_BPF_SYSCALL
 static inline bool uses_default_overflow_handler(struct perf_event *event)
 {
-	if (likely(is_default_overflow_handler(event)))
-		return true;
-
-	return __is_default_overflow_handler(event->orig_overflow_handler);
+	return is_default_overflow_handler(event);
 }
 #else
 #define uses_default_overflow_handler(event) \
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d3f3f55..c6a6936 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9564,9 +9564,9 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
 }
 
 #ifdef CONFIG_BPF_SYSCALL
-static void bpf_overflow_handler(struct perf_event *event,
-				 struct perf_sample_data *data,
-				 struct pt_regs *regs)
+static int bpf_overflow_handler(struct perf_event *event,
+				struct perf_sample_data *data,
+				struct pt_regs *regs)
 {
 	struct bpf_perf_event_data_kern ctx = {
 		.data = data,
@@ -9587,10 +9587,8 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
-	if (!ret)
-		return;
 
-	event->orig_overflow_handler(event, data, regs);
+	return ret;
 }
 
 static int perf_event_set_bpf_handler(struct perf_event *event,
@@ -9626,8 +9624,6 @@ static int perf_event_set_bpf_handler(struct perf_event *event,
 
 	event->prog = prog;
 	event->bpf_cookie = bpf_cookie;
-	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
-	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
 	return 0;
 }
 
@@ -9638,15 +9634,15 @@ static void perf_event_free_bpf_handler(struct perf_event *event)
 	if (!prog)
 		return;
 
-	WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
 	event->prog = NULL;
 	bpf_prog_put(prog);
 }
 #else
-static void bpf_overflow_handler(struct perf_event *event,
-				 struct perf_sample_data *data,
-				 struct pt_regs *regs)
+static int bpf_overflow_handler(struct perf_event *event,
+				struct perf_sample_data *data,
+				struct pt_regs *regs)
 {
+	return 1;
 }
 
 static int perf_event_set_bpf_handler(struct perf_event *event,
@@ -9730,7 +9726,8 @@ static int __perf_event_overflow(struct perf_event *event,
 		irq_work_queue(&event->pending_irq);
 	}
 
-	READ_ONCE(event->overflow_handler)(event, data, regs);
+	if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
+		READ_ONCE(event->overflow_handler)(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;
@@ -11997,13 +11994,11 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		overflow_handler = parent_event->overflow_handler;
 		context = parent_event->overflow_handler_context;
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
-		if (overflow_handler == bpf_overflow_handler) {
+		if (parent_event->prog) {
 			struct bpf_prog *prog = parent_event->prog;
 
 			bpf_prog_inc(prog);
 			event->prog = prog;
-			event->orig_overflow_handler =
-				parent_event->orig_overflow_handler;
 		}
 #endif
 	}

