Return-Path: <linux-kernel+bounces-137909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2859D89E94B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D7F1F23CA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE981170D;
	Wed, 10 Apr 2024 04:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wZkDubGS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pwTU6RoP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED010958;
	Wed, 10 Apr 2024 04:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712725070; cv=none; b=Jf1TROvL+tAfCUSc2I1qYrHUwhKnkTdwWeEQFfmlIdYi7KxeNv7H2MYxNYl5Q8EKEniQDFn5FvznE1GtKwY4I/MyKnNokI4zJyynzTHi7rRmGynqJB5lpBMLgwqGt01+i8fU+3J0Vv3t48h1i1OAPa4dmzW+Gn6GCd9JLK66Xck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712725070; c=relaxed/simple;
	bh=oLAA/0WsDIqdT+k3dmlISNBCgTB5kF9LHGjz4l4hygw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BXuvPHvlJQEVh9/jKTJsJCC9XdmUjjQ2Cr7O37DCsGwfH1sOFs8gGVGDhsEMa4UoRSBxfEmgSUTF3pRzKfdG7HaIaL5pOtOaCZtxMYePqqwPETYc0ynEW1g2ayicNkmFjO+My0PfAg0KHRUXsHNu1CK8AlPhP4glGWgUCkNMeaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wZkDubGS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pwTU6RoP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 04:57:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712725066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fi9oYBUp2oHFk/LgprvgN1kEo1Cu9Ghr8LQ1Aby5Ku8=;
	b=wZkDubGSk8TQeCLbT9r/GpATWexJ1QIadOC7Ad53sZ4MGrKeTbjqIg0AJ7j3dmmCuehNEF
	qQZs206PntCYacitOr/1TXU4uBndg5oBC/ctEb0P+YmeFCzFd2EG0ssux4k+ddt8mcsrk+
	UzL3eH6nwASKYXFuqCzPjZF1IsbqmKv3xTMP6/YlSf/MmdvqiQ5AR3eCILeVGzNbxlFYQc
	3YNDNMO+fsDCR/EF2vb+M69T+nAO+brR61ceokRtuc/iVaqcMU3zatfnondy72Ywoe8mvE
	fTv41hxO4jq3cfm74/DgIr6TMULrgoSNF+ez4dsHk0D6mq+FXX2ymzF/rfUsSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712725066;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fi9oYBUp2oHFk/LgprvgN1kEo1Cu9Ghr8LQ1Aby5Ku8=;
	b=pwTU6RoP1/sV5wl5swXIZoen7A3oKU5EiwnRnjiTcayqu65MknU1b3wuXS51X+xUqYXcn7
	ApAaUCcndKz0JaDw==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Optimize perf_adjust_freq_unthr_context()
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Mingwei Zhang <mizhang@google.com>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240207050545.2727923-1-namhyung@kernel.org>
References: <20240207050545.2727923-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171272506590.10875.10398837861739254570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0259bf63f71e2accfeca4a4e346ede8edcc86aab
Gitweb:        https://git.kernel.org/tip/0259bf63f71e2accfeca4a4e346ede8edcc86aab
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Tue, 06 Feb 2024 21:05:44 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 06:13:57 +02:00

perf/core: Optimize perf_adjust_freq_unthr_context()

It was unnecessarily disabling and enabling PMUs for each event.  It
should be done at PMU level.  Add pmu_ctx->nr_freq counter to check it
at each PMU.  As PMU context has separate active lists for pinned group
and flexible group, factor out a new function to do the job.

Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
even if it needs to unthrottle sampling events.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Mingwei Zhang <mizhang@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20240207050545.2727923-1-namhyung@kernel.org
---
 include/linux/perf_event.h |  6 +++-
 kernel/events/core.c       | 70 +++++++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0..3e33b36 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -883,6 +883,7 @@ struct perf_event_pmu_context {
 
 	unsigned int			nr_events;
 	unsigned int			nr_cgroups;
+	unsigned int			nr_freq;
 
 	atomic_t			refcount; /* event <-> epc */
 	struct rcu_head			rcu_head;
@@ -897,6 +898,11 @@ struct perf_event_pmu_context {
 	int				rotate_necessary;
 };
 
+static inline bool perf_pmu_ctx_is_active(struct perf_event_pmu_context *epc)
+{
+	return !list_empty(&epc->flexible_active) || !list_empty(&epc->pinned_active);
+}
+
 struct perf_event_groups {
 	struct rb_root	tree;
 	u64		index;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7..9566cfb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2302,8 +2302,10 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 
 	if (!is_software_event(event))
 		cpc->active_oncpu--;
-	if (event->attr.freq && event->attr.sample_freq)
+	if (event->attr.freq && event->attr.sample_freq) {
 		ctx->nr_freq--;
+		epc->nr_freq--;
+	}
 	if (event->attr.exclusive || !cpc->active_oncpu)
 		cpc->exclusive = 0;
 
@@ -2558,9 +2560,10 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 
 	if (!is_software_event(event))
 		cpc->active_oncpu++;
-	if (event->attr.freq && event->attr.sample_freq)
+	if (event->attr.freq && event->attr.sample_freq) {
 		ctx->nr_freq++;
-
+		epc->nr_freq++;
+	}
 	if (event->attr.exclusive)
 		cpc->exclusive = 1;
 
@@ -4123,30 +4126,14 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	}
 }
 
-/*
- * combine freq adjustment with unthrottling to avoid two passes over the
- * events. At the same time, make sure, having freq events does not change
- * the rate of unthrottling as that would introduce bias.
- */
-static void
-perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
+static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 {
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	u64 now, period = TICK_NSEC;
 	s64 delta;
 
-	/*
-	 * only need to iterate over all events iff:
-	 * - context have events in frequency mode (needs freq adjust)
-	 * - there are events to unthrottle on this cpu
-	 */
-	if (!(ctx->nr_freq || unthrottle))
-		return;
-
-	raw_spin_lock(&ctx->lock);
-
-	list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
+	list_for_each_entry(event, event_list, active_list) {
 		if (event->state != PERF_EVENT_STATE_ACTIVE)
 			continue;
 
@@ -4154,8 +4141,6 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 		if (!event_filter_match(event))
 			continue;
 
-		perf_pmu_disable(event->pmu);
-
 		hwc = &event->hw;
 
 		if (hwc->interrupts == MAX_INTERRUPTS) {
@@ -4165,7 +4150,7 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 		}
 
 		if (!event->attr.freq || !event->attr.sample_freq)
-			goto next;
+			continue;
 
 		/*
 		 * stop the event and update event->count
@@ -4187,8 +4172,41 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 			perf_adjust_period(event, period, delta, false);
 
 		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
-	next:
-		perf_pmu_enable(event->pmu);
+	}
+}
+
+/*
+ * combine freq adjustment with unthrottling to avoid two passes over the
+ * events. At the same time, make sure, having freq events does not change
+ * the rate of unthrottling as that would introduce bias.
+ */
+static void
+perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
+{
+	struct perf_event_pmu_context *pmu_ctx;
+
+	/*
+	 * only need to iterate over all events iff:
+	 * - context have events in frequency mode (needs freq adjust)
+	 * - there are events to unthrottle on this cpu
+	 */
+	if (!(ctx->nr_freq || unthrottle))
+		return;
+
+	raw_spin_lock(&ctx->lock);
+
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+		if (!(pmu_ctx->nr_freq || unthrottle))
+			continue;
+		if (!perf_pmu_ctx_is_active(pmu_ctx))
+			continue;
+		if (pmu_ctx->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT)
+			continue;
+
+		perf_pmu_disable(pmu_ctx->pmu);
+		perf_adjust_freq_unthr_events(&pmu_ctx->pinned_active);
+		perf_adjust_freq_unthr_events(&pmu_ctx->flexible_active);
+		perf_pmu_enable(pmu_ctx->pmu);
 	}
 
 	raw_spin_unlock(&ctx->lock);

