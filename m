Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D580785287
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjHWIQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjHWIK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:10:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0541707
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d74a012e6a6so3645298276.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778139; x=1693382939;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjKOCLuFJFgx6ztDnM71PYKJcUuovlvTFeoWlk3ZsFE=;
        b=jSur6rALwrNCBUMquiewe0adRDNIiOBBenT4Mj3YLqBzYEOVCm8n/ISkTFQucZ3H1s
         79TQDb3pbn3og0OzZuPVntUQJxO+ic8P5h002rwJzEmTfA79vCR5bgPaiMvUI2L2TcUT
         /ppQoqAvI9ArnE4W0ESPHfaBLRuPf/WAC743kaphNVt//Uive4ERLT57en2TZI1GEUVU
         7yO3XreaPllhTJAPtYuVV46/QtT/h/0zL5Iz+9W92bTgbU9MqJO2klG3ZTRfIgGiqJEH
         ZvLVeNYFzrVxYrYK1diWuQmCdYq0rFlXljXAioj6tt3k2enqHWz8yaO1psHYpg93Ef8r
         mRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778139; x=1693382939;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjKOCLuFJFgx6ztDnM71PYKJcUuovlvTFeoWlk3ZsFE=;
        b=KBUE3Njr3rmeBP06BiGr91zH0in4L0a2aoy+G87y1bOrTruu5r8jDrU7l6rsfrdz9r
         Ig+Vi73UxPdOQPswxTxbuBx9NL8/bCJhWW8SRu0ZQUDh1cj525oQC08tscxAKkfDsPyM
         s3Z6SZxDXvtgy5SILozwQPYBz4e/2e3HNNkGNmS4zPeTmQQK2cw1bI4CIbpDLO8FVIIG
         o01OcuHcru+wiqNnlNQoxgCMaR4NzyrNWceOz5cFHd0LHCIPRFZZLHeLp4lMOQjn8cpi
         pHVU6+Hs7XZefdnhKK4/dgQ0l+M31T0kffLJgjikJ+/QOWtLNxuK5f/Zk0FBpmuDEMc2
         KcfQ==
X-Gm-Message-State: AOJu0YwtxfuO88lIskIuoElZpmuJzvuDEinL1+/NA7XE9WR1sv9j5VcO
        PXgvlW8qpwsTJ38UmjS1HY1cNj58NbW2
X-Google-Smtp-Source: AGHT+IGVExLkde0SFlvgOq7rJp2KB4sQNHPzqEgJoI++UNPQ4wtXdd1qAqaBsYBM+fmSyfkl7rirEn75gp8W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a05:6902:12c6:b0:d77:bcce:eb11 with SMTP
 id j6-20020a05690212c600b00d77bcceeb11mr37370ybu.10.1692778139350; Wed, 23
 Aug 2023 01:08:59 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:14 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-12-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 11/25] perf pmu-events: Add extra underscore to function names
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
index c315f0cecc73..95872bee28ac 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -892,7 +892,7 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu, const struct pmu_events_tab
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

