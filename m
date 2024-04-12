Return-Path: <linux-kernel+bounces-142462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9778A2BDE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292A91C216D5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6795339D;
	Fri, 12 Apr 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kIBQ+yUr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F7DBX9x6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C93B53E25;
	Fri, 12 Apr 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916215; cv=none; b=RrW9+xSLkt+rTM6EhjP0RLPP4jgfCpZu+RhYkBuhf2Bc49MJIhW9T0ckwnK+Xqyhh6YwCKkDps8gYaQpxJvwAtuQLyPGch5/Aqg317SreNcdccDaKCzo/B+u1uLFce4p7CwUCCHiPUw1xutp5T1EvUG15yznYsmBDM7xqZDf+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916215; c=relaxed/simple;
	bh=Gkf3TjsXOGNG8muDa/jBNo/J4kUcsE62c5t2fcMoIEU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qgee+UBfNnibIbJ5wONYf+kq7vHqbR2NXMRwyLuQaOyvFhU3Zz6yZGUw4YcvA88y3icov1Og5Bl/ZRMFJIAufcaADb4qcy9seOjCPCnxaugGCsuF3IVhLgd3oa+hVPcfTldKS10sAu7TXZNVRNnjxvPTa9seYtEEPztxvUcm87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kIBQ+yUr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F7DBX9x6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:03:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqysCUtdDGvYpQRl+A32nYoQQOTsg6cOew7ligvXDWk=;
	b=kIBQ+yUraiyGLphQyY/SKklrTNXOrxW28IR80ICE+HozPqpBfk9wpcor6qPG13kMAgOAcF
	X+9oHHexjB3xjs8eiPoVHpBcgS93LJdvB8B/QXMizFLUIZBV1ZBz5kwq0lVKuEW37eqFtI
	spz6sW35ueKGBusnVOExvSj6qVaul5rP+ZuFswcJjnXPZ6K1TzvwbuIzYNnQvyjAV9Pqzv
	1nnveTlZ4JJfip8e7VT2YVEsUpEEUZK+V4PlGj+IdN81xekmtTCB3cb+XYfJ0vFQm/2D2k
	WMbxNuueQog6GzUaPHSrx0QzjbomKkk7Kh5by71DyTB6V3jdtgoDwYh7Itwssg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SqysCUtdDGvYpQRl+A32nYoQQOTsg6cOew7ligvXDWk=;
	b=F7DBX9x69hud3Y7E5JJg5FXkgdQvfLpmy+hhj2yfSrs9kaN4QoyOwQyTI9xpMpjlSbJ5IW
	LAURAJrh5m79TEDA==
From: "tip-bot2 for Kyle Huey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/bpf: Reorder bpf_overflow_handler() ahead of
 __perf_event_overflow()
Cc: Kyle Huey <khuey@kylehuey.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240412015019.7060-2-khuey@kylehuey.com>
References: <20240412015019.7060-2-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291620724.10875.15819552793312286948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4c03fe11b96bda60610aca77002e83f37b4a2242
Gitweb:        https://git.kernel.org/tip/4c03fe11b96bda60610aca77002e83f37b4a2242
Author:        Kyle Huey <me@kylehuey.com>
AuthorDate:    Thu, 11 Apr 2024 18:50:13 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 11:49:48 +02:00

perf/bpf: Reorder bpf_overflow_handler() ahead of __perf_event_overflow()

This will allow __perf_event_overflow() to call bpf_overflow_handler().

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240412015019.7060-2-khuey@kylehuey.com
---
 kernel/events/core.c | 183 +++++++++++++++++++++---------------------
 1 file changed, 92 insertions(+), 91 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fd94e45..ca0a906 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9563,6 +9563,98 @@ static inline bool sample_is_allowed(struct perf_event *event, struct pt_regs *r
 	return true;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+static void bpf_overflow_handler(struct perf_event *event,
+				 struct perf_sample_data *data,
+				 struct pt_regs *regs)
+{
+	struct bpf_perf_event_data_kern ctx = {
+		.data = data,
+		.event = event,
+	};
+	struct bpf_prog *prog;
+	int ret = 0;
+
+	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
+	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
+		goto out;
+	rcu_read_lock();
+	prog = READ_ONCE(event->prog);
+	if (prog) {
+		perf_prepare_sample(data, event, regs);
+		ret = bpf_prog_run(prog, &ctx);
+	}
+	rcu_read_unlock();
+out:
+	__this_cpu_dec(bpf_prog_active);
+	if (!ret)
+		return;
+
+	event->orig_overflow_handler(event, data, regs);
+}
+
+static int perf_event_set_bpf_handler(struct perf_event *event,
+				      struct bpf_prog *prog,
+				      u64 bpf_cookie)
+{
+	if (event->overflow_handler_context)
+		/* hw breakpoint or kernel counter */
+		return -EINVAL;
+
+	if (event->prog)
+		return -EEXIST;
+
+	if (prog->type != BPF_PROG_TYPE_PERF_EVENT)
+		return -EINVAL;
+
+	if (event->attr.precise_ip &&
+	    prog->call_get_stack &&
+	    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
+	     event->attr.exclude_callchain_kernel ||
+	     event->attr.exclude_callchain_user)) {
+		/*
+		 * On perf_event with precise_ip, calling bpf_get_stack()
+		 * may trigger unwinder warnings and occasional crashes.
+		 * bpf_get_[stack|stackid] works around this issue by using
+		 * callchain attached to perf_sample_data. If the
+		 * perf_event does not full (kernel and user) callchain
+		 * attached to perf_sample_data, do not allow attaching BPF
+		 * program that calls bpf_get_[stack|stackid].
+		 */
+		return -EPROTO;
+	}
+
+	event->prog = prog;
+	event->bpf_cookie = bpf_cookie;
+	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
+	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
+	return 0;
+}
+
+static void perf_event_free_bpf_handler(struct perf_event *event)
+{
+	struct bpf_prog *prog = event->prog;
+
+	if (!prog)
+		return;
+
+	WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
+	event->prog = NULL;
+	bpf_prog_put(prog);
+}
+#else
+static int perf_event_set_bpf_handler(struct perf_event *event,
+				      struct bpf_prog *prog,
+				      u64 bpf_cookie)
+{
+	return -EOPNOTSUPP;
+}
+
+static void perf_event_free_bpf_handler(struct perf_event *event)
+{
+}
+#endif
+
 /*
  * Generic event overflow handling, sampling.
  */
@@ -10441,97 +10533,6 @@ static void perf_event_free_filter(struct perf_event *event)
 	ftrace_profile_free_filter(event);
 }
 
-#ifdef CONFIG_BPF_SYSCALL
-static void bpf_overflow_handler(struct perf_event *event,
-				 struct perf_sample_data *data,
-				 struct pt_regs *regs)
-{
-	struct bpf_perf_event_data_kern ctx = {
-		.data = data,
-		.event = event,
-	};
-	struct bpf_prog *prog;
-	int ret = 0;
-
-	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
-	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
-		goto out;
-	rcu_read_lock();
-	prog = READ_ONCE(event->prog);
-	if (prog) {
-		perf_prepare_sample(data, event, regs);
-		ret = bpf_prog_run(prog, &ctx);
-	}
-	rcu_read_unlock();
-out:
-	__this_cpu_dec(bpf_prog_active);
-	if (!ret)
-		return;
-
-	event->orig_overflow_handler(event, data, regs);
-}
-
-static int perf_event_set_bpf_handler(struct perf_event *event,
-				      struct bpf_prog *prog,
-				      u64 bpf_cookie)
-{
-	if (event->overflow_handler_context)
-		/* hw breakpoint or kernel counter */
-		return -EINVAL;
-
-	if (event->prog)
-		return -EEXIST;
-
-	if (prog->type != BPF_PROG_TYPE_PERF_EVENT)
-		return -EINVAL;
-
-	if (event->attr.precise_ip &&
-	    prog->call_get_stack &&
-	    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
-	     event->attr.exclude_callchain_kernel ||
-	     event->attr.exclude_callchain_user)) {
-		/*
-		 * On perf_event with precise_ip, calling bpf_get_stack()
-		 * may trigger unwinder warnings and occasional crashes.
-		 * bpf_get_[stack|stackid] works around this issue by using
-		 * callchain attached to perf_sample_data. If the
-		 * perf_event does not full (kernel and user) callchain
-		 * attached to perf_sample_data, do not allow attaching BPF
-		 * program that calls bpf_get_[stack|stackid].
-		 */
-		return -EPROTO;
-	}
-
-	event->prog = prog;
-	event->bpf_cookie = bpf_cookie;
-	event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
-	WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
-	return 0;
-}
-
-static void perf_event_free_bpf_handler(struct perf_event *event)
-{
-	struct bpf_prog *prog = event->prog;
-
-	if (!prog)
-		return;
-
-	WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
-	event->prog = NULL;
-	bpf_prog_put(prog);
-}
-#else
-static int perf_event_set_bpf_handler(struct perf_event *event,
-				      struct bpf_prog *prog,
-				      u64 bpf_cookie)
-{
-	return -EOPNOTSUPP;
-}
-static void perf_event_free_bpf_handler(struct perf_event *event)
-{
-}
-#endif
-
 /*
  * returns true if the event is a tracepoint, or a kprobe/upprobe created
  * with perf_event_open()

