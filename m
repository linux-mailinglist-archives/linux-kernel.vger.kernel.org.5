Return-Path: <linux-kernel+bounces-21423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105AF828EF6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F72B239D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B66A3DB99;
	Tue,  9 Jan 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb2QbXsy"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42083D998
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3eae5c1d7so17213905ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 13:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704836185; x=1705440985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YwpEW88qruCnd7NgXrK3moFDq7nRFPEWTNIp/53tqFQ=;
        b=Gb2QbXsye5ZG2snZAfpLSTowr6MQSxCuEbdphIQpg6E0sp8ww5aSCgr/uqO4QDz7+j
         ovePuEJhg8b/eyVFEeabIT40JwNnhdm/DiPPAxtBQ8XnFDcxToiKOM6m9xqDDOAGq45i
         NzzeuTj2pyDHFBYNUcLICm1G1SMaD7AsqCd9t8b8o6BR3RCLnMNIlKOwHNFoVxGcagtf
         lqShj1en379AeSzpq4FQ676CZEOiSPvIFMd/23vGIIzskmGAzH/PcIAx89SD+5lbLace
         78rQnmJh5n+8MMBp3BWVNe9ERe81IKHzvPEKauJd/oQ1h8oW3vhTzZxnOVNDh4873Cks
         HAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704836185; x=1705440985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwpEW88qruCnd7NgXrK3moFDq7nRFPEWTNIp/53tqFQ=;
        b=D57TxJlkycblnXj7M8eKxKZWgeSR2iCjiUyNZXRo956ort3LMNXtyVysKJ4ebXiVC4
         CRtHExzL/HmOODDeqV8IlM7M1GlAv5KIJg5WmZJnKwESVKX+ESIqoK5rQH0PzitBxDYG
         PKZfii4gLiv8hp/7NJ5EZ+mIeyiNA5BrQby6C6j0ckd2rD2cAkGd1g2Etb3uvGSnjJEf
         nEgv8xcsUwKnBqCLI0yKrwNjFz3BJiYy1TQvylywsK7nlhOHeMZSYbIs2irnWP+kfuau
         stJtgFLiIBODQxZBAlqaz8B30C32CGl0T0As1gsJAYxbJaXGR+iyWKU+nYQ3DLrpilQ2
         7zmA==
X-Gm-Message-State: AOJu0Yzs4Q46ZiB3brZWT23EtLUxkggz39e1xbN9h94f+WsFOoD0uSh7
	F3LI7YrOx5exalG+0/L0XGY=
X-Google-Smtp-Source: AGHT+IGewiFzxwFLfNY/3MICgCTPeGg10Qiqm74sqL57fwfHDrD7ydIUQYVgYKCe2IkWzFPlf1bLsg==
X-Received: by 2002:a17:902:bb16:b0:1d4:e234:a3da with SMTP id im22-20020a170902bb1600b001d4e234a3damr11221plb.139.1704836184885;
        Tue, 09 Jan 2024 13:36:24 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:b4e:5c78:a5b3:ef5b])
        by smtp.gmail.com with ESMTPSA id bj2-20020a170902850200b001d55717179asm1957471plb.288.2024.01.09.13.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 13:36:24 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mingwei Zhang <mizhang@google.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH RESEND 1/2] perf/core: Update perf_adjust_freq_unthr_context()
Date: Tue,  9 Jan 2024 13:36:22 -0800
Message-ID: <20240109213623.449371-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was unnecessarily disabling and enabling PMUs for each event.  It
should be done at PMU level.  Add pmu_ctx->nr_freq counter to check it
at each PMU.  As pmu context has separate active lists for pinned group
and flexible group, factor out a new function to do the job.

Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
even if it needs to unthrottle sampling events.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 68 +++++++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..b2ff60fa487e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -883,6 +883,7 @@ struct perf_event_pmu_context {
 
 	unsigned int			nr_events;
 	unsigned int			nr_cgroups;
+	unsigned int			nr_freq;
 
 	atomic_t			refcount; /* event <-> epc */
 	struct rcu_head			rcu_head;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 59b332cce9e7..ce9db9dbfd4c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2277,8 +2277,10 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 
 	if (!is_software_event(event))
 		cpc->active_oncpu--;
-	if (event->attr.freq && event->attr.sample_freq)
+	if (event->attr.freq && event->attr.sample_freq) {
 		ctx->nr_freq--;
+		epc->nr_freq--;
+	}
 	if (event->attr.exclusive || !cpc->active_oncpu)
 		cpc->exclusive = 0;
 
@@ -2533,9 +2535,10 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 
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
 
@@ -4098,30 +4101,14 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
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
 
@@ -4129,8 +4116,6 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 		if (!event_filter_match(event))
 			continue;
 
-		perf_pmu_disable(event->pmu);
-
 		hwc = &event->hw;
 
 		if (hwc->interrupts == MAX_INTERRUPTS) {
@@ -4140,7 +4125,7 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 		}
 
 		if (!event->attr.freq || !event->attr.sample_freq)
-			goto next;
+			continue;
 
 		/*
 		 * stop the event and update event->count
@@ -4162,8 +4147,39 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
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
+		if (pmu_ctx->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT)
+			continue;
+
+		perf_pmu_disable(pmu_ctx->pmu);
+		perf_adjust_freq_unthr_events(&pmu_ctx->pinned_active);
+		perf_adjust_freq_unthr_events(&pmu_ctx->flexible_active);
+		perf_pmu_enable(pmu_ctx->pmu);
 	}
 
 	raw_spin_unlock(&ctx->lock);
-- 
2.43.0.472.g3155946c3a-goog


