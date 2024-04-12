Return-Path: <linux-kernel+bounces-143359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECE58A3793
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E27B244A6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293C9152DE5;
	Fri, 12 Apr 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBcYE4pN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9215216F;
	Fri, 12 Apr 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956096; cv=none; b=adm72HS1YmbCw7TrFXIV/fsfhpGUSrgYDF8vMeDonZaQxcjaBuz/WwvMzwXQ7QY2TcjAJF4loJTe30o0nMbcPOSeo7HmYDAsleEqtV4hwep28/q4uqRVAN8jGoM4m+2O6CsVSuBIatgaKp6CnFT0qu9fF0D2wsPjtcVq6jDH+18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956096; c=relaxed/simple;
	bh=HNG8EA0UJsyVjaeRiH+XOJfw23G7htj/ITVnQAFcHlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coSbb/Wyaf+Xk2gL7DEcx79yqWFCJaCTSmYYU9lsEG46O9hp3lM798OQYM0uphO87T4hH0n2PPR/+xHZKI776atXkMaT3MyJ00rK8zXrBpWxamklI8mYRhQqrTJ8ECg5zq8A9B+D1tyeWK3mfGhoxsUSqggGF1AMlUyi9HEbYNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBcYE4pN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956094; x=1744492094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HNG8EA0UJsyVjaeRiH+XOJfw23G7htj/ITVnQAFcHlM=;
  b=WBcYE4pN28ZG7qlt8FjFbg09VzyegWSbLy6ZaWGE0qUx9BA6d6g5n1HJ
   0nY+EqlhVLpF9K3nK//OYIcV66uexIKOMZkdVQ0dGNPSCB6nwGLSyCEWq
   YRNZCcGLlaVyYmkzcLOmL5m6lcAxN9nupe36uo0uZ1XOyxm2f/Bj3BkDH
   zFA7E3OHHEAD8rOY7i4UJv/FWHeamLF6bP2U0HQaqC7yvY8j4NiviGPuw
   JD6XzsWhJDOQ9NUUt0xHms119JoLwCOUHqP2ZZA+8xAIkYlttLG696RWD
   9G0JLsyanv6TMoFG58j/Xj1bkDujGUMKN/gErKYNzK4GiG7wL/WMQv8Zp
   g==;
X-CSE-ConnectionGUID: BiaxjMYOSiG9qsU2gLg/Zg==
X-CSE-MsgGUID: oupYbsNCQmuW0Z0D6nxrIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575458"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575458"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:11 -0700
X-CSE-ConnectionGUID: F5JMx7SoQviC7CYtIddpnQ==
X-CSE-MsgGUID: iNcuMAGvR5uYvaFCY+8y7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772095"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa006.jf.intel.com with ESMTP; 12 Apr 2024 14:08:10 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v5 06/16] perf stat: Add functions to get counter info
Date: Fri, 12 Apr 2024 14:07:46 -0700
Message-ID: <20240412210756.309828-7-weilin.wang@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240412210756.309828-1-weilin.wang@intel.com>
References: <20240412210756.309828-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Add data structure metricgroup__pmu_counters to represent hardware counters
available in the system.

Add functions to parse pmu-events and create the list of pmu_info_list to
hold the counter information of the system.

Add functions to free pmu_info_list and event_info_list before exit
grouping for hardware-grouping method

This method would fall back to normal grouping when event json files do not
support hardware aware grouping.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 115 +++++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1a7ac17f7ae1..78a5410cdc09 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -183,6 +183,21 @@ struct metricgroup__event_info {
 	DECLARE_BITMAP(counters, NR_COUNTERS);
 };
 
+/**
+ * A node is the counter availability of a pmu.
+ * This info is built up at the beginning from JSON file and
+ * used as a reference in metric grouping process.
+ */
+struct metricgroup__pmu_counters {
+	struct list_head nd;
+	/** The name of the pmu the event collected on. */
+	const char *name;
+	/** The number of gp counters in the pmu. */
+	size_t counters_num_gp;
+	/** The number of fixed counters in the pmu. */
+	size_t counters_num_fixed;
+};
+
 /**
  * Each group is one node in the group string list.
  */
@@ -1534,6 +1549,40 @@ static int parse_counter(const char *counter,
 	return 0;
 }
 
+static void metricgroup__event_info__delete(struct metricgroup__event_info *e)
+{
+	zfree(&e->name);
+	zfree(&e->pmu_name);
+	free(e);
+}
+
+static void metricgroup__pmu_counter__delete(struct metricgroup__pmu_counters *p)
+{
+	zfree(&p->name);
+	free(p);
+}
+
+static void metricgroup__free_event_info(struct list_head
+					*event_info_list)
+{
+	struct metricgroup__event_info *e, *tmp;
+
+	list_for_each_entry_safe(e, tmp, event_info_list, nd) {
+		list_del_init(&e->nd);
+		metricgroup__event_info__delete(e);
+	}
+}
+
+static void metricgroup__free_pmu_info(struct list_head *pmu_info_list)
+{
+	struct metricgroup__pmu_counters *p, *tmp;
+
+	list_for_each_entry_safe(p, tmp, pmu_info_list, nd) {
+		list_del_init(&p->nd);
+		metricgroup__pmu_counter__delete(p);
+	}
+}
+
 static struct metricgroup__event_info *event_info__new(const char *name,
 						      const char *pmu_name,
 						      const char *counter,
@@ -1589,7 +1638,9 @@ static int metricgroup__add_metric_event_callback(const struct pmu_event *pe,
 	struct metricgroup__add_metric_event_data *d = data;
 
 	if (!strcasecmp(pe->name, d->event_name)) {
-		event = event_info__new(d->event_id, pe->pmu, pe->counter, /*free_counter=*/false);
+		if (!pe->counters_list)
+			return -EINVAL;
+		event = event_info__new(d->event_id, pe->pmu, pe->counters_list, /*free_counter=*/false);
 		if (!event)
 			return -ENOMEM;
 		list_add(&event->nd, d->list);
@@ -1630,7 +1681,7 @@ static int get_metricgroup_events(const char *full_id,
 			.event_name = id,
 			.event_id = full_id,
 		};
-		ret = pmu_events_table_for_each_event(table,
+		ret = pmu_events_table__for_each_event(table, /*pmu=*/NULL,
 				metricgroup__add_metric_event_callback, &data);
 	}
 
@@ -1639,6 +1690,59 @@ static int get_metricgroup_events(const char *full_id,
 	return ret;
 }
 
+static struct metricgroup__pmu_counters *pmu_layout__new(const struct pmu_layout *pl)
+{
+	struct metricgroup__pmu_counters *l;
+
+	l = zalloc(sizeof(*l));
+
+	if (!l)
+		return NULL;
+
+	l->name = strdup(pl->pmu);
+	if (!l->name)
+		return NULL;
+	l->counters_num_gp = pl->counters_num_gp;
+	l->counters_num_fixed = pl->counters_num_fixed;
+	pr_debug("create new pmu_layout: [pmu]=%s, [gp_size]=%ld, [fixed_size]=%ld\n",
+		l->name, l->counters_num_gp, l->counters_num_fixed);
+	return l;
+}
+
+static int metricgroup__add_pmu_layout_callback(const struct pmu_layout *pl,
+						void *data)
+{
+	struct metricgroup__pmu_counters *pmu;
+	struct list_head *d = data;
+	int ret = 0;
+
+	pmu = pmu_layout__new(pl);
+	if (!pmu)
+		return -ENOMEM;
+	list_add(&pmu->nd, d);
+	return ret;
+}
+
+/**
+ * get_pmu_counter_layouts - Find counter info of the architecture from
+ * the pmu_layouts table
+ * @pmu_info_list: the list that the new counter info of a pmu is added to.
+ * @table: pmu_layouts table that is searched for counter info.
+ */
+static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
+				   const struct pmu_layouts_table
+				   *table)
+{
+	LIST_HEAD(list);
+	int ret;
+
+	ret = pmu_layouts_table__for_each_layout(table,
+						metricgroup__add_pmu_layout_callback, &list);
+
+	list_splice(&list, pmu_info_list);
+	return ret;
+}
+
 /**
  * hw_aware_build_grouping - Build event groupings by reading counter
  * requirement of the events and counter available on the system from
@@ -1657,6 +1761,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	LIST_HEAD(event_info_list);
 	size_t bkt;
 	const struct pmu_events_table *etable = perf_pmu__find_events_table(NULL);
+	const struct pmu_layouts_table *ltable = perf_pmu__find_layouts_table(NULL);
 
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
@@ -1666,9 +1771,13 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 
 		ret = get_metricgroup_events(id, etable, &event_info_list);
 		if (ret)
-			return ret;
+			goto err_out;
 	}
+	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
 
+err_out:
+	metricgroup__free_event_info(&event_info_list);
+	metricgroup__free_pmu_info(&pmu_info_list);
 	return ret;
 #undef RETURN_IF_NON_ZERO
 }
-- 
2.42.0


