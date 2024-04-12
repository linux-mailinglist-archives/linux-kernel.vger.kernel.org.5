Return-Path: <linux-kernel+bounces-143358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9928A3792
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D421F23D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54482152517;
	Fri, 12 Apr 2024 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJO8hpZI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0CB1514E9;
	Fri, 12 Apr 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956095; cv=none; b=Radh04TmG4xeRqmBFsUHwIwRXWQmVE/jXfnNGf+7grhzls8hIA+iPpafwewKr67SjV41NL4bMUl7jPII0fDBYA3P8o0mzQCxG6+t10+RCuBD71dkFlY6vff6fywDIre5yRgUWBc0rOEtMDX99mPA+IZDMaSqrqPiuxlFwQ5O+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956095; c=relaxed/simple;
	bh=kmD3Ow0z4vDuQgPB5ElG6sRuBpbFzXyR93y6Lfu2zDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8AvShsdHa3OCJ8aPssVGgy2x0CL6frCsWiwbCMM+yDub6SqSChu+q76dw+LPfB9Zqw4nMZYWEGiLd0aKzppI99kZsQB5kOJeSV+PO6CNSAcsg1IFtjGrORv9SIdUV8mTE94hjrTokM81qQtnRruI4iulbmf+pfxIR69eMJFck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJO8hpZI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956093; x=1744492093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kmD3Ow0z4vDuQgPB5ElG6sRuBpbFzXyR93y6Lfu2zDw=;
  b=hJO8hpZIg9M7pXoHNDzUtSyd+GEJkJGtemYSg82DsYLoRL/ZZocSLy1j
   9XJGGNpHaO9BBUtOdCI707aexsezm3RHW/ipD4s08h4/C9sP2q8H7upHv
   Q2WcuAHAWJoBEcqp3PTL0hxbPZH5SEBkupsgSBLX079hObc8gmueqcvI7
   7+nnjop5H5YtndUb3gFY0b793ZNcckPhFnVmgvB11iMEv6XqH2ILsY5/J
   C4qEjIX1f/7SyWHW1JhpHISYeJf3JFjTUOBgoS3AdA/yT6A75pdf+JjRP
   SERFvli3XidIYnkh3yNjHqPcf2B8QItz7OGcNQBR3gHbjINWoxzb+CF/l
   w==;
X-CSE-ConnectionGUID: ON+oiIkZSpe7OCN2DY08jg==
X-CSE-MsgGUID: w/cI+8lWS9+wO9p42RgHNg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575452"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575452"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:11 -0700
X-CSE-ConnectionGUID: HrkS4uKzRNO0KV46ALHd5A==
X-CSE-MsgGUID: PAsh3twkTaipIdGqQ0kXuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772087"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa006.jf.intel.com with ESMTP; 12 Apr 2024 14:08:09 -0700
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
Subject: [RFC PATCH v5 05/16] perf stat: Add functions to set counter bitmaps for hardware-grouping method
Date: Fri, 12 Apr 2024 14:07:45 -0700
Message-ID: <20240412210756.309828-6-weilin.wang@intel.com>
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

Add metricgroup__event_info data structure to represent an event in the
metric grouping context; the list of counters and the PMU name an event
should be collected with.

Add functions to parse event counter info from pmu-events and generate a
list of metricgroup__event_info data to prepare grouping.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 219 +++++++++++++++++++++++++++++++++-
 1 file changed, 216 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 8047f03b2b1f..1a7ac17f7ae1 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -24,6 +24,7 @@
 #include <linux/list_sort.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
+#include <linux/bitmap.h>
 #include <perf/cpumap.h>
 #include <subcmd/parse-options.h>
 #include <api/fs/fs.h>
@@ -159,6 +160,29 @@ struct metric {
 	struct evlist *evlist;
 };
 
+/* Maximum number of counters per PMU*/
+#define NR_COUNTERS	16
+
+/**
+ * An event used in a metric. This info is for metric grouping.
+ */
+struct metricgroup__event_info {
+	struct list_head nd;
+	/** The name of the event. */
+	const char *name;
+	/** The name of the pmu the event be collected on. */
+	const char *pmu_name;
+	/** The event uses fixed counter. */
+	bool fixed_counter;
+	/**
+	 * The event uses special counters that we consider that as free counter
+	 * during the event grouping.
+	 */
+	bool free_counter;
+	/** The counters the event allowed to be collected on. */
+	DECLARE_BITMAP(counters, NR_COUNTERS);
+};
+
 /**
  * Each group is one node in the group string list.
  */
@@ -1440,6 +1464,181 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 	return ret;
 }
 
+/**
+ * set_counter_bitmap - The counter bitmap: [0-15].
+ */
+static int set_counter_bitmap(int pos, unsigned long *bitmap)
+{
+	if (pos >= NR_COUNTERS || pos < 0)
+		return -EINVAL;
+	__set_bit(pos, bitmap);
+	return 0;
+}
+
+static int parse_fixed_counter(const char *counter,
+			      unsigned long *bitmap,
+			      bool *fixed)
+{
+	int ret = -ENOENT;
+	/* TODO: this pattern maybe different on some other platforms */
+	const char *pattern = "Fixed counter ";
+	int pos = 0;
+
+	if (!strncmp(counter, pattern, strlen(pattern))) {
+		pos = atoi(counter + strlen(pattern));
+		ret = set_counter_bitmap(pos, bitmap);
+		if (ret)
+			return ret;
+		*fixed = true;
+		return 0;
+	}
+	return ret;
+}
+
+/**
+ * parse_counter - Parse event counter info from pmu-events and set up bitmap
+ * accordingly.
+ *
+ * @counter: counter info string to be parsed.
+ * @bitmap: bitmap to set based on counter info parsed.
+ * @fixed: is set to true if the event uses fixed counter.
+ */
+static int parse_counter(const char *counter,
+			unsigned long *bitmap,
+			bool *fixed)
+{
+	int ret = 0;
+	char *p;
+	char *tok;
+	int pos = 0;
+
+	ret = parse_fixed_counter(counter, bitmap, fixed);
+	/* ret==0 means matched with fixed counter */
+	if (ret == 0)
+		return ret;
+
+	p = strdup(counter);
+	if (!p)
+		return -ENOMEM;
+	tok = strtok(p, ",");
+	if (!tok)
+		return -ENOENT;
+
+	while (tok) {
+		pos = atoi(tok);
+		ret = set_counter_bitmap(pos, bitmap);
+		if (ret)
+			return ret;
+		tok = strtok(NULL, ",");
+	}
+	return 0;
+}
+
+static struct metricgroup__event_info *event_info__new(const char *name,
+						      const char *pmu_name,
+						      const char *counter,
+						      bool free_counter)
+{
+	int ret = 0;
+	char *bit_buf = malloc(NR_COUNTERS);
+	bool fixed_counter = false;
+	struct metricgroup__event_info *e;
+
+	e = zalloc(sizeof(*e));
+	if (!e)
+		return NULL;
+	if (!pmu_name)
+		pmu_name = "core";
+
+	e->name = strdup(name);
+	e->pmu_name = strdup(pmu_name);
+	if (!e->pmu_name || !e->name)
+		return NULL;
+	e->free_counter = free_counter;
+	if (free_counter) {
+		ret = set_counter_bitmap(0, e->counters);
+		if (ret)
+			return NULL;
+	} else {
+		ret = parse_counter(counter, e->counters, &fixed_counter);
+		if (ret)
+			return NULL;
+		e->fixed_counter = fixed_counter;
+	}
+
+	bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_COUNTERS);
+	pr_debug("Event %s requires pmu %s counter: %s bitmap %s, [pmu=%s]\n",
+		e->name, e->pmu_name, counter, bit_buf, pmu_name);
+
+	return e;
+}
+
+struct metricgroup__add_metric_event_data {
+	struct list_head *list;
+	/* pure event name, exclude umask and other info*/
+	const char *event_name;
+	/* event name and umask if applicable*/
+	const char *event_id;
+};
+
+static int metricgroup__add_metric_event_callback(const struct pmu_event *pe,
+						 const struct pmu_events_table *table __maybe_unused,
+						 void *data)
+{
+	struct metricgroup__event_info *event;
+	struct metricgroup__add_metric_event_data *d = data;
+
+	if (!strcasecmp(pe->name, d->event_name)) {
+		event = event_info__new(d->event_id, pe->pmu, pe->counter, /*free_counter=*/false);
+		if (!event)
+			return -ENOMEM;
+		list_add(&event->nd, d->list);
+	}
+
+	return 0;
+}
+
+/**
+ * get_metricgroup_events - Find counter requirement of events from the
+ * pmu_events table
+ * @full_id: the full event identifiers.
+ * @table: pmu_events table that is searched for event data.
+ * @event_info_list: the list that the new event counter info added to.
+ */
+static int get_metricgroup_events(const char *full_id,
+				 const struct pmu_events_table *table,
+				 struct list_head *event_info_list)
+{
+	LIST_HEAD(list);
+	int ret = 0;
+	const char *id;
+	const char *rsep, *sep = strchr(full_id, '@');
+
+	if (sep) {
+		rsep = strchr(full_id, ',');
+		id = strndup(sep + 1, rsep - sep - 1);
+		if (!id) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else {
+		id = full_id;
+	}
+	{
+		struct metricgroup__add_metric_event_data data = {
+			.list = &list,
+			.event_name = id,
+			.event_id = full_id,
+		};
+		ret = pmu_events_table_for_each_event(table,
+				metricgroup__add_metric_event_callback, &data);
+	}
+
+out:
+	list_splice(&list, event_info_list);
+	return ret;
+}
+
 /**
  * hw_aware_build_grouping - Build event groupings by reading counter
  * requirement of the events and counter available on the system from
@@ -1453,9 +1652,25 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 				  const char *modifier __maybe_unused)
 {
 	int ret = 0;
+	struct hashmap_entry *cur;
+	LIST_HEAD(pmu_info_list);
+	LIST_HEAD(event_info_list);
+	size_t bkt;
+	const struct pmu_events_table *etable = perf_pmu__find_events_table(NULL);
+
+#define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
+	hashmap__for_each_entry(ctx->ids, cur, bkt) {
+		const char *id = cur->pkey;
+
+		pr_debug("found event %s\n", id);
+
+		ret = get_metricgroup_events(id, etable, &event_info_list);
+		if (ret)
+			return ret;
+	}
 
-	pr_debug("This is a placeholder\n");
 	return ret;
+#undef RETURN_IF_NON_ZERO
 }
 
 static void group_str_free(struct metricgroup__group_strs *g)
@@ -1529,8 +1744,6 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	*out_evlist = parsed_evlist;
 	parsed_evlist = NULL;
 err_out:
-	parse_events_error__exit(&parse_error);
-	evlist__delete(parsed_evlist);
 	metricgroup__free_grouping_strs(&groupings);
 	return ret;
 }
-- 
2.42.0


