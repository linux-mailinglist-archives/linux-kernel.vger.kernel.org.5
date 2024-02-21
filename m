Return-Path: <linux-kernel+bounces-74186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8D385D0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB00B25594
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DCB3AC14;
	Wed, 21 Feb 2024 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ivxFwb4d"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD183A278
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499281; cv=none; b=rLNY6onRoMBVOgjOEcSJ3eD2ZK/7x74anIb/1jim8BAbVD2JF1yX0zJK7ynBz8P6xoeyZ8wWZlL5wDNWiaLPNUBK4LrJ8A7/9+oIvoShM2nP4TxC36WbBUmyxQRhSAo+Iw80S/uuznHG4PYwvW5eI2Fy5YOFX9vY74Sb+B6WUA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499281; c=relaxed/simple;
	bh=p2BFm98alOENnWqviYTCy9ucqswGbAxkTLrhYtaIgqA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=mjhQ01175RDZGuKgDY1MIWR+uKwkvHU+Kir/ZCbiobo6JcGnAP1HBtuOLiqXaFRijAblDCARCQ52sRdjiskQyPl46Jslr42qftLUW7p62N7ymjrxpT0HF2N0SAb4Vb7vaHrkN6/3GDJNYGy+J6MQ2yoNRDRVhY+pUtvGX9cGCvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ivxFwb4d; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so740209276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708499279; x=1709104079; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvthopvNRdGOZJq8hSaBpJ0dA5xV4FM2S9eVhI67i9I=;
        b=ivxFwb4dUdthYRCAv6vIqtbS+I1zglAjh6vcwZEQydEK+G/49kJp1miwXOxlIS2BGU
         kNeKEoIrRU9ZiZRAVtpTmJf8dyBeyDWKr50vG8ryA4nTg/z4bhokaHC6bjvMVplNnmZb
         CW4KpDQtrXQlAl5l1hVOGOhJR6+6LxuZzFJJ+TPJ7QCw0O6gwWdDsmnfAgCHjdrMZuFJ
         CAo31h090xJU2OQmBIEX0Cwgea3FBpske+LoAf5LTonpjqSVIdiV7Bt3JEdOVQhaPFje
         fTRDEZk20SPhSo8bO719au+nLEVhoiC9lu2k+HLmAvQpN9qGyotkNpzDhQkFshdYo8Ze
         KtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499279; x=1709104079;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvthopvNRdGOZJq8hSaBpJ0dA5xV4FM2S9eVhI67i9I=;
        b=wHwdYo4pfd31hVhczed3NJWkQa2Lz3HqZCbybJcdgdWk3r3P26gc3hj7YIiQBEuJif
         n8tUWU9x+pW/VIJseG4FusfuslW91cKLsTQvYcJHqB01RfkafY4i79n5SRS+QUZXSzxe
         i59FURRStcdbyx83ANmsmhHztmcnoP0+IXjYCel/dhdzbBFoTgbzga7cavUX58a/0YOm
         hJIZMmdB5uU1qoTbs6bgNmzTGXpfG04ZhyXpRmvKBa2O8FOd70aPb7IQpRzU/ZzByvC9
         APNnl6Iv2+uHZ8tYTNjSVLZvszUucxIGfgHvuOpVOSKkBMPQhZR/gFKbj4H4xHyxWnf2
         twnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmcFRXtr1FBq0NGLdzjx9bmCNKG1Y3B5fjQrl+4/IPDuStspdWemzXuWsBt10NTgh1w03L/LSZ+azv3T/T4GnUP9ZGqOgYrn0s+585
X-Gm-Message-State: AOJu0Yya8GLF2Fl7Vxt/lELBiiqHqI/W0wkDyOueCzlVCar+Zp5pN7pT
	4sKpB+in+zsLc7mvsRJH/XGCWBSo34lX6uFy8hYmKRd9EfhRLFuXYYmIVo72wmKH/kWgAjVtcyd
	9hQL62Q==
X-Google-Smtp-Source: AGHT+IG5R00oeM12RtzeV62E2QIR4BUQvSSm0trHyittdMsFtZyC3327ZG1+s17sRL8OXKiNXIAo06CZEXj3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a05:6902:18ce:b0:dbd:b165:441 with SMTP id
 ck14-20020a05690218ce00b00dbdb1650441mr4691108ybb.0.1708499279254; Tue, 20
 Feb 2024 23:07:59 -0800 (PST)
Date: Tue, 20 Feb 2024 23:07:53 -0800
In-Reply-To: <20240221070754.4163916-1-irogers@google.com>
Message-Id: <20240221070754.4163916-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221070754.4163916-1-irogers@google.com>
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


