Return-Path: <linux-kernel+bounces-74160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEF185D098
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6F01F26026
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2C03A28B;
	Wed, 21 Feb 2024 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7arW2xe"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981F3984F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708497936; cv=none; b=ZLu1G7zXLM8ItPqUisEDAdpcB00DBOzzg6tcHZXiUYxfRfb/LUsvfvBq5pPEnQnpjSKU65sCubfWzIoa4pW6VkWFFzRmOMfbhhWT6V6kTD82lMGystx6kJEKpmCgZblJWQYMJsaoK9V9nmFp/gE/Dv7WOE+Na6S+WPIoI2bTUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708497936; c=relaxed/simple;
	bh=p2BFm98alOENnWqviYTCy9ucqswGbAxkTLrhYtaIgqA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=eRye7Vtc/I7N+gC1zHIa+kKTfY+krzgb/g5LWvDPLMfRVQgGAYjF6NyJ7Dll21wJkj8YdKkWoxzQ1qE+l/jw3eFTjq1zi6lb+YfMkPloB491o98MopZCebOSYXsFPp7WjU44388/Uuqja+zWmRVgCE+mYJHLz2/YMSPd49KA3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L7arW2xe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso88330507b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708497933; x=1709102733; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvthopvNRdGOZJq8hSaBpJ0dA5xV4FM2S9eVhI67i9I=;
        b=L7arW2xeroCatEAI/S0tIoebBlSOUDaDW2LlOwa9CQE9bSZDfkaQ5hsUQJ4cBBxFdc
         JIGPDRIwSAKhOHOjNl0ke83hJXbiRJQC2PkLna3A63MGn5NVrOl06vleehJ7nbg5U9a6
         4qdiCXC8ivoxitYWyK0HWRPs605alLD52PeMLcmQZAi9GJaIJgv0QK9MH4E9G2Htf/EX
         u8uqfbODdtapITajOPsREiA6fOSEcmzgsbOHmXMaN2hKNpvjv79ERJ4JlSM+bdufta6/
         uShnAFT8Irjh/XWKlsSrbE7F+XMjHkKCuv7NInGdMEPH8m4TX/N6Y4nErS5g4PYW/YQi
         ml/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708497933; x=1709102733;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvthopvNRdGOZJq8hSaBpJ0dA5xV4FM2S9eVhI67i9I=;
        b=lzXiF6N+X97zRKpJiKaLLRa9ca0hD3rqSCSCOdh9jYxb23XewPJjopgFg15Fg+NdIB
         /tB8X8I+V/J0RHso2lM2zUiDBJ3lf+Ii3iuQyGkW4+1ZFLl4XneW74fnvaJiuGjgJBS6
         XJnCCvrD9jecMHPNafg4vNxyQUTC0zUuNHDWM7MfNbab/Xdp5lt0bJu7JrJrT42psTa6
         FiXYjYVRRs9Yl/bBK+pInTwWPkBGQ9f3TA9plhUd6wzbRDPXDxbl+znctzoypY1otY67
         cZqRdEHfts1HvIsiWo9CR0lRYfTYlL3Iw2C9kRJftBBmvFFDRcHAsxLoeBiXeBuv6RNR
         msxw==
X-Forwarded-Encrypted: i=1; AJvYcCWGF8S8QI91ra3wiM0xfGu49Q3NIKJidtWIaLiZJhuN8dkm2W0rJxs7gpDLGZW3Bw+ZyR37JT+WlqVqOWwLi1TH1jVvHUPFkLH7v4Xi
X-Gm-Message-State: AOJu0YxeTqjK2falYqJcOSKk0T0Yq6oV34zKJu5crJiQGifSoId5dUg3
	CfIM2OzgX2MrxaGm3q7Fr0LLktUS2oBQVWeNc+d/U+KKfS4/GEGxnSI3bfUUZct8YmFYA8wEICg
	W7Z7koA==
X-Google-Smtp-Source: AGHT+IFf97MAYgZA2M6FgTZl1w7ndLv5a8Z8QbZFGhM4VY7vsAcfKic/WjsCJ5vJOtuLaAD7Ju/L7hQs3X+a
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a0d:d5d7:0:b0:607:9bfd:d0bc with SMTP id
 x206-20020a0dd5d7000000b006079bfdd0bcmr2958361ywd.7.1708497932795; Tue, 20
 Feb 2024 22:45:32 -0800 (PST)
Date: Tue, 20 Feb 2024 22:45:25 -0800
In-Reply-To: <20240221064527.4157979-1-irogers@google.com>
Message-Id: <20240221064527.4157979-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221064527.4157979-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v3 2/3] perf metrics: Compute unmerged uncore metrics individually
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	John Garry <john.g.garry@oracle.com>, Kaige Ye <ye@kaige.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

When merging counts from multiple uncore PMUs the metric is only
computed for the metric leader. When merging/aggregation is disabled,
prior to this patch just the leader's metric would be computed. Fix
this by computing the metric for each PMU.

On a SkylakeX:
Before:
```
$ perf stat -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

CPU0               82,217      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      9.2 MB/s  memory_bandwidth_total
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      0.0 MB/s  memory_bandwidth_total
CPU0               61,395      UNC_M_CAS_COUNT.WR [uncore_imc_0]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_0]
CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_1]
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_1]
CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
CPU0               81,570      UNC_M_CAS_COUNT.RD [uncore_imc_2]
CPU18             113,886      UNC_M_CAS_COUNT.RD [uncore_imc_2]
CPU0               62,330      UNC_M_CAS_COUNT.WR [uncore_imc_2]
CPU18              66,942      UNC_M_CAS_COUNT.WR [uncore_imc_2]
CPU0               75,489      UNC_M_CAS_COUNT.RD [uncore_imc_3]
CPU18              27,958      UNC_M_CAS_COUNT.RD [uncore_imc_3]
CPU0               55,864      UNC_M_CAS_COUNT.WR [uncore_imc_3]
CPU18              38,727      UNC_M_CAS_COUNT.WR [uncore_imc_3]
CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_4]
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_4]
CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
CPU0               75,423      UNC_M_CAS_COUNT.RD [uncore_imc_5]
CPU18             104,527      UNC_M_CAS_COUNT.RD [uncore_imc_5]
CPU0               57,596      UNC_M_CAS_COUNT.WR [uncore_imc_5]
CPU18              56,777      UNC_M_CAS_COUNT.WR [uncore_imc_5]
CPU0        1,003,440,851 ns   duration_time

       1.003440851 seconds time elapsed
```

After:
```
$ perf stat -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

CPU0               88,968      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      9.5 MB/s  memory_bandwidth_total
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      0.0 MB/s  memory_bandwidth_total
CPU0               59,498      UNC_M_CAS_COUNT.WR [uncore_imc_0]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_0]
CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_1] #      0.0 MB/s  memory_bandwidth_total
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_1] #      0.0 MB/s  memory_bandwidth_total
CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
CPU0               88,635      UNC_M_CAS_COUNT.RD [uncore_imc_2] #      9.5 MB/s  memory_bandwidth_total
CPU18             117,975      UNC_M_CAS_COUNT.RD [uncore_imc_2] #     11.5 MB/s  memory_bandwidth_total
CPU0               60,829      UNC_M_CAS_COUNT.WR [uncore_imc_2]
CPU18              62,105      UNC_M_CAS_COUNT.WR [uncore_imc_2]
CPU0               82,238      UNC_M_CAS_COUNT.RD [uncore_imc_3] #      8.7 MB/s  memory_bandwidth_total
CPU18              22,906      UNC_M_CAS_COUNT.RD [uncore_imc_3] #      3.6 MB/s  memory_bandwidth_total
CPU0               53,959      UNC_M_CAS_COUNT.WR [uncore_imc_3]
CPU18              32,990      UNC_M_CAS_COUNT.WR [uncore_imc_3]
CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_4] #      0.0 MB/s  memory_bandwidth_total
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_4] #      0.0 MB/s  memory_bandwidth_total
CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
CPU0               83,595      UNC_M_CAS_COUNT.RD [uncore_imc_5] #      8.9 MB/s  memory_bandwidth_total
CPU18             110,151      UNC_M_CAS_COUNT.RD [uncore_imc_5] #     10.5 MB/s  memory_bandwidth_total
CPU0               56,540      UNC_M_CAS_COUNT.WR [uncore_imc_5]
CPU18              53,816      UNC_M_CAS_COUNT.WR [uncore_imc_5]
CPU0        1,003,353,416 ns   duration_time
```

Signed-off-by: Ian Rogers <irogers@google.com>                                  |
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/metricgroup.c |  2 ++
 tools/perf/util/stat-shadow.c | 31 +++++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 966cca5a3e88..b24a1c177a80 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -44,6 +44,8 @@ struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 	if (!metric_events)
 		return NULL;
 
+	if (evsel->metric_leader)
+		me.evsel = evsel->metric_leader;
 	nd = rblist__find(metric_events, &me);
 	if (nd)
 		return container_of(nd, struct metric_event, nd);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 10b452792037..3466aa952442 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -356,6 +356,7 @@ static void print_nsecs(struct perf_stat_config *config,
 }
 
 static int prepare_metric(const struct metric_expr *mexp,
+			  const struct evsel *evsel,
 			  struct expr_parse_ctx *pctx,
 			  int aggr_idx)
 {
@@ -399,8 +400,29 @@ static int prepare_metric(const struct metric_expr *mexp,
 			source_count = 1;
 		} else {
 			struct perf_stat_evsel *ps = metric_events[i]->stats;
-			struct perf_stat_aggr *aggr = &ps->aggr[aggr_idx];
+			struct perf_stat_aggr *aggr;
 
+			/*
+			 * If there are multiple uncore PMUs and we're not
+			 * reading the leader's stats, determine the stats for
+			 * the appropriate uncore PMU.
+			 */
+			if (evsel && evsel->metric_leader &&
+			    evsel->pmu != evsel->metric_leader->pmu &&
+			    mexp->metric_events[i]->pmu == evsel->metric_leader->pmu) {
+				struct evsel *pos;
+
+				evlist__for_each_entry(evsel->evlist, pos) {
+					if (pos->pmu != evsel->pmu)
+						continue;
+					if (pos->metric_leader != mexp->metric_events[i])
+						continue;
+					ps = pos->stats;
+					source_count = 1;
+					break;
+				}
+			}
+			aggr = &ps->aggr[aggr_idx];
 			if (!aggr)
 				break;
 
@@ -416,7 +438,8 @@ static int prepare_metric(const struct metric_expr *mexp,
 				source_count = 0;
 			} else {
 				val = aggr->counts.val;
-				source_count = evsel__source_count(metric_events[i]);
+				if (!source_count)
+					source_count = evsel__source_count(metric_events[i]);
 			}
 		}
 		n = strdup(evsel__metric_id(metric_events[i]));
@@ -463,7 +486,7 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = runtime;
 	pctx->sctx.system_wide = config->system_wide;
-	i = prepare_metric(mexp, pctx, aggr_idx);
+	i = prepare_metric(mexp, evsel, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
@@ -524,7 +547,7 @@ double test_generic_metric(struct metric_expr *mexp, int aggr_idx)
 	if (!pctx)
 		return NAN;
 
-	if (prepare_metric(mexp, pctx, aggr_idx) < 0)
+	if (prepare_metric(mexp, /*evsel=*/NULL, pctx, aggr_idx) < 0)
 		goto out;
 
 	if (expr__parse(&ratio, pctx, mexp->metric_expr))
-- 
2.44.0.rc1.240.g4c46232300-goog


