Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF7F786695
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbjHXEO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbjHXENv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:13:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7922E10C4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:13:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5925f39aa5cso9861397b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692850427; x=1693455227;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vidwpQVtDg+nsMorfnSSpTNR26f6Ss+rFWesfZXB9VY=;
        b=3F1TL04ywJL5vypns2Jb9R29aqSKg/txZdIM6WYWZH/G3mq9fKwJkCbGJpOCHbe9so
         QnO4BYS/BVa3LIvYPAAhQKBJfhnjfcj6JnplAj4LhdIXj4yZGJRiBpBFaoRYoTfqeC8k
         ykV6RWwoEY3w13h9g/Kko6jYBRizIHgiUd0G23FLA0IjEYWJFqrx08YPllWcJZ6LxsKn
         88AsVTpg2SC38KwkBEgg4cSGB8g+jSSY0qRuKnuY6cckOVcRDq3GcDi3Uc7pz6qGlz8Q
         OmsuHFqT4C40Zv3Lnq9HKJwRr/vCvsOrbzjaAw/bDyH1CBqp0ftx2cWCN+ydTWj+u8SX
         Xk4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692850427; x=1693455227;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vidwpQVtDg+nsMorfnSSpTNR26f6Ss+rFWesfZXB9VY=;
        b=OFHWNONycPRxv2ClUeo4qh/wEi/MH28elZz7CFpCEKj2+68G4TJOWNHi1DWiaj2G8c
         E9ljMv9JNEhjt0ZpH7xpr2i7/1oMbXbWeA2IBmHqPE5WDeG/t3f2wVmtU4pWJ5OLESJk
         xZKZSzh+uNhWlwMyvtHwuLI8EzVufPI8a/UTc9uzs5ouzF5dmHm4JJo5Uwi/YwfZXM12
         bW/VDqEs4+GWFB1kOtjygTEz7ouIe4Agaa/ojFto5hSg4W3B5XlmzkW8wwThHzy4SqBG
         T230wjPpMkd187tY8DccMAspPbQD0PCITFXpJJPwnWt/4jJTMf15Rmh+aCdNGUk+P4JK
         IjMQ==
X-Gm-Message-State: AOJu0YxkBq73Ic1is5fXZ3Owg5eNLBcARMUsv98+xk9ZySf2ZOJ+81lX
        mae21NE6HzSD0/AKRSCvx8XzSjwVLTsZ
X-Google-Smtp-Source: AGHT+IEUHfhrPgqscGGuHzM23N1Nfy5/5Gx+u6lVa+IeriqzL3Lxa19wb2x+rlBhrNkd3gZa16UZHE5ZX+VO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fbb9:d9e7:7405:2651])
 (user=irogers job=sendgmr) by 2002:a05:690c:2f87:b0:586:e91a:46c2 with SMTP
 id ew7-20020a05690c2f8700b00586e91a46c2mr264893ywb.4.1692850427738; Wed, 23
 Aug 2023 21:13:47 -0700 (PDT)
Date:   Wed, 23 Aug 2023 21:13:15 -0700
In-Reply-To: <20230824041330.266337-1-irogers@google.com>
Message-Id: <20230824041330.266337-4-irogers@google.com>
Mime-Version: 1.0
References: <20230824041330.266337-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v2 03/18] perf pmu-events: Add extra underscore to function names
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add extra underscore before "for" of pmu_events_table_for_each_event
and pmu_metrics_table_for_each_metric.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 10 +++++-----
 tools/perf/pmu-events/jevents.py         | 12 ++++++------
 tools/perf/pmu-events/pmu-events.h       |  4 ++--
 tools/perf/tests/pmu-events.c            |  4 ++--
 tools/perf/util/metricgroup.c            | 10 +++++-----
 tools/perf/util/pmu.c                    |  2 +-
 tools/perf/util/s390-sample-raw.c        |  2 +-
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index a630c617e879..807f2e55c17c 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -266,7 +266,7 @@ static const struct pmu_sys_events pmu_sys_event_tables[] = {
 	},
 };
 
-int pmu_events_table_for_each_event(const struct pmu_events_table *table, pmu_event_iter_fn fn,
+int pmu_events_table__for_each_event(const struct pmu_events_table *table, pmu_event_iter_fn fn,
 				    void *data)
 {
 	for (const struct pmu_event *pe = &table->entries[0]; pe->name; pe++) {
@@ -278,7 +278,7 @@ int pmu_events_table_for_each_event(const struct pmu_events_table *table, pmu_ev
 	return 0;
 }
 
-int pmu_metrics_table_for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
+int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				      void *data)
 {
 	for (const struct pmu_metric *pm = &table->entries[0]; pm->metric_expr; pm++) {
@@ -371,7 +371,7 @@ const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
 {
 	for (const struct pmu_events_map *tables = &pmu_events_map[0]; tables->arch; tables++) {
-		int ret = pmu_events_table_for_each_event(&tables->event_table, fn, data);
+		int ret = pmu_events_table__for_each_event(&tables->event_table, fn, data);
 
 		if (ret)
 			return ret;
@@ -384,7 +384,7 @@ int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data)
 	for (const struct pmu_events_map *tables = &pmu_events_map[0];
 	     tables->arch;
 	     tables++) {
-		int ret = pmu_metrics_table_for_each_metric(&tables->metric_table, fn, data);
+		int ret = pmu_metrics_table__for_each_metric(&tables->metric_table, fn, data);
 
 		if (ret)
 			return ret;
@@ -408,7 +408,7 @@ int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
 	for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
 	     tables->name;
 	     tables++) {
-		int ret = pmu_events_table_for_each_event(&tables->table, fn, data);
+		int ret = pmu_events_table__for_each_event(&tables->table, fn, data);
 
 		if (ret)
 			return ret;
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 98cccc3fcbbd..aae5334099b1 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -753,7 +753,7 @@ static void decompress_metric(int offset, struct pmu_metric *pm)
       _args.output_file.write('\twhile (*p++);')
   _args.output_file.write("""}
 
-int pmu_events_table_for_each_event(const struct pmu_events_table *table,
+int pmu_events_table__for_each_event(const struct pmu_events_table *table,
                                     pmu_event_iter_fn fn,
                                     void *data)
 {
@@ -771,7 +771,7 @@ int pmu_events_table_for_each_event(const struct pmu_events_table *table,
         return 0;
 }
 
-int pmu_metrics_table_for_each_metric(const struct pmu_metrics_table *table,
+int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table,
                                      pmu_metric_iter_fn fn,
                                      void *data)
 {
@@ -870,7 +870,7 @@ int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data)
         for (const struct pmu_events_map *tables = &pmu_events_map[0];
              tables->arch;
              tables++) {
-                int ret = pmu_events_table_for_each_event(&tables->event_table, fn, data);
+                int ret = pmu_events_table__for_each_event(&tables->event_table, fn, data);
 
                 if (ret)
                         return ret;
@@ -883,7 +883,7 @@ int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data)
         for (const struct pmu_events_map *tables = &pmu_events_map[0];
              tables->arch;
              tables++) {
-                int ret = pmu_metrics_table_for_each_metric(&tables->metric_table, fn, data);
+                int ret = pmu_metrics_table__for_each_metric(&tables->metric_table, fn, data);
 
                 if (ret)
                         return ret;
@@ -907,7 +907,7 @@ int pmu_for_each_sys_event(pmu_event_iter_fn fn, void *data)
         for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
              tables->name;
              tables++) {
-                int ret = pmu_events_table_for_each_event(&tables->event_table, fn, data);
+                int ret = pmu_events_table__for_each_event(&tables->event_table, fn, data);
 
                 if (ret)
                         return ret;
@@ -920,7 +920,7 @@ int pmu_for_each_sys_metric(pmu_metric_iter_fn fn, void *data)
         for (const struct pmu_sys_events *tables = &pmu_sys_event_tables[0];
              tables->name;
              tables++) {
-                int ret = pmu_metrics_table_for_each_metric(&tables->metric_table, fn, data);
+                int ret = pmu_metrics_table__for_each_metric(&tables->metric_table, fn, data);
 
                 if (ret)
                         return ret;
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index caf59f23cd64..6557381b7de1 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -77,9 +77,9 @@ typedef int (*pmu_metric_iter_fn)(const struct pmu_metric *pm,
 				  const struct pmu_metrics_table *table,
 				  void *data);
 
-int pmu_events_table_for_each_event(const struct pmu_events_table *table, pmu_event_iter_fn fn,
+int pmu_events_table__for_each_event(const struct pmu_events_table *table, pmu_event_iter_fn fn,
 				    void *data);
-int pmu_metrics_table_for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
+int pmu_metrics_table__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
 				     void *data);
 
 const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu);
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index dc87e66fb118..5f541eadc088 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -477,12 +477,12 @@ static int test__pmu_event_table(struct test_suite *test __maybe_unused,
 	if (!table || !sys_event_table)
 		return -1;
 
-	err = pmu_events_table_for_each_event(table, test__pmu_event_table_core_callback,
+	err = pmu_events_table__for_each_event(table, test__pmu_event_table_core_callback,
 					      &map_events);
 	if (err)
 		return err;
 
-	err = pmu_events_table_for_each_event(sys_event_table, test__pmu_event_table_sys_callback,
+	err = pmu_events_table__for_each_event(sys_event_table, test__pmu_event_table_sys_callback,
 					      &map_events);
 	if (err)
 		return err;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a6a5ed44a679..6231044a491e 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -527,7 +527,7 @@ void metricgroup__print(const struct print_callbacks *print_cb, void *print_stat
 	groups.node_delete = mep_delete;
 	table = pmu_metrics_table__find();
 	if (table) {
-		pmu_metrics_table_for_each_metric(table,
+		pmu_metrics_table__for_each_metric(table,
 						 metricgroup__add_to_mep_groups_callback,
 						 &groups);
 	}
@@ -1069,7 +1069,7 @@ static bool metricgroup__find_metric(const char *pmu,
 		.pm = pm,
 	};
 
-	return pmu_metrics_table_for_each_metric(table, metricgroup__find_metric_callback, &data)
+	return pmu_metrics_table__for_each_metric(table, metricgroup__find_metric_callback, &data)
 		? true : false;
 }
 
@@ -1255,7 +1255,7 @@ static int metricgroup__add_metric(const char *pmu, const char *metric_name, con
 		 * Iterate over all metrics seeing if metric matches either the
 		 * name or group. When it does add the metric to the list.
 		 */
-		ret = pmu_metrics_table_for_each_metric(table, metricgroup__add_metric_callback,
+		ret = pmu_metrics_table__for_each_metric(table, metricgroup__add_metric_callback,
 						       &data);
 		if (ret)
 			goto out;
@@ -1740,7 +1740,7 @@ bool metricgroup__has_metric(const char *pmu, const char *metric)
 	if (!table)
 		return false;
 
-	return pmu_metrics_table_for_each_metric(table, metricgroup__has_metric_callback, &data)
+	return pmu_metrics_table__for_each_metric(table, metricgroup__has_metric_callback, &data)
 		? true : false;
 }
 
@@ -1770,7 +1770,7 @@ unsigned int metricgroups__topdown_max_level(void)
 	if (!table)
 		return false;
 
-	pmu_metrics_table_for_each_metric(table, metricgroup__topdown_max_level_callback,
+	pmu_metrics_table__for_each_metric(table, metricgroup__topdown_max_level_callback,
 					  &max_level);
 	return max_level;
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 268aaebfa70c..d91367155e29 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -896,7 +896,7 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu, const struct pmu_events_tab
 		.pmu = pmu,
 	};
 
-	pmu_events_table_for_each_event(table, pmu_add_cpu_aliases_map_callback, &data);
+	pmu_events_table__for_each_event(table, pmu_add_cpu_aliases_map_callback, &data);
 	free(data.default_pmu_name);
 }
 
diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index c10b891dbad6..91330c874170 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -168,7 +168,7 @@ static const char *get_counter_name(int set, int nr, const struct pmu_events_tab
 	if (!table)
 		return NULL;
 
-	pmu_events_table_for_each_event(table, get_counter_name_callback, &data);
+	pmu_events_table__for_each_event(table, get_counter_name_callback, &data);
 	return data.result;
 }
 
-- 
2.42.0.rc1.204.g551eb34607-goog

