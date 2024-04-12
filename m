Return-Path: <linux-kernel+bounces-143363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCAB8A3796
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C1F1F23B55
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC9A153508;
	Fri, 12 Apr 2024 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxV0iNPg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD6152527;
	Fri, 12 Apr 2024 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956098; cv=none; b=rQ5RFaLGfwCcqOn2Li6eohmU0HvHJLu6s7tl8efmfYL31ysAUl9zWzKm9VXCytkgePKJRAxAzkeCH+XEqsgVUQkEZvzCMO69FwmFlMl1XbXGgBLu0Lje38D/Exa9jk4p9xH/4+X87C9OyEMcXrwWuuVFj7c5Wp7g4Pld67MlMzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956098; c=relaxed/simple;
	bh=QkVtBQWWBMMe1MNkeP0H8yozIjK/9HP9b2M/bd9n5rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRL49wY4w9Etc6bshtlG2G7j8Y541iJc+S9qxCVonmX8jRbUpgxESUQ6TtG50xNS68BiahSqXw2dZykDwtuEy/I6olnIjdIXs4lo8wHHbacaVefvV7kC6Ji/Vp/SgFOB4o5pvlCSJlJ/q4+7b5CfFZSkMq9+bnMJe0Ho10Zxm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxV0iNPg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956096; x=1744492096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QkVtBQWWBMMe1MNkeP0H8yozIjK/9HP9b2M/bd9n5rI=;
  b=AxV0iNPgRfNDHLAx2GA9T37UiNxf0Ju8RGbd9H1F5q0TfZ0fMkOozWHQ
   YB9n/uu8pN/9AHw74glxd39oYQCjLxgt1P8APYhVAT+xguWhIpKMEimKf
   WQH5PGk7599nKKMM9Hnxfx5MKEUzrrUcY/6eoxLqtsD7LGWAgpwn9Svx3
   +CR/8Akr3uZm39wvBySkrdS5HxV1k3gOAxTCrsdcXXUk1uCKmTE84t72s
   Rb97oO6sNjwvuWr9tP827WPzx4+pStd3II95/Y2797weZo5DbOXi2qoby
   yIWc3NwYW/HGv27D5q/RIY6Ak7/opmGJ8wDI7Dgg7z+bGj9YVRGfNTT4S
   w==;
X-CSE-ConnectionGUID: j+9YggPBQ02gntylHSuP2g==
X-CSE-MsgGUID: +DhTQty5RJKupYEQVavYFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575478"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575478"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:11 -0700
X-CSE-ConnectionGUID: CP8JkpW1QJCivNJxMLE4Pw==
X-CSE-MsgGUID: CLNit7O2RaucMSlIVoQdiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772108"
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
Subject: [RFC PATCH v5 10/16] perf stat: Add function to combine metrics for hardware-grouping
Date: Fri, 12 Apr 2024 14:07:50 -0700
Message-ID: <20240412210756.309828-11-weilin.wang@intel.com>
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

This function is very similar to the existing build_combined_expr_ctx().
Should be able to reuse current function instead of adding a new one. Will
fix this later.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 47 ++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 681aacc15787..b9e46dff1e17 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1528,6 +1528,46 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 	return ret;
 }
 
+/**
+ * hw_aware_build_combined_expr_ctx - Make an expr_parse_ctx with all !group_events
+ *                           metric IDs, as the IDs are held in a set,
+ *                           duplicates will be removed.
+ * @metric_list: List to take metrics from.
+ * @combined: Out argument for result.
+ */
+static int hw_aware_build_combined_expr_ctx(const struct list_head *metric_list,
+				   struct expr_parse_ctx **combined)
+{
+	struct hashmap_entry *cur;
+	size_t bkt;
+	struct metric *m;
+	char *dup;
+	int ret;
+
+	*combined = expr__ctx_new();
+	if (!*combined)
+		return -ENOMEM;
+
+	list_for_each_entry(m, metric_list, nd) {
+		hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
+			pr_debug2("metric: %s\n", m->metric_name);
+			dup = strdup(cur->pkey);
+			if (!dup) {
+				ret = -ENOMEM;
+				goto err_out;
+			}
+			ret = expr__add_id(*combined, dup);
+			if (ret)
+				goto err_out;
+		}
+	}
+	return 0;
+err_out:
+	expr__ctx_free(*combined);
+	*combined = NULL;
+	return ret;
+}
+
 /**
  * set_counter_bitmap - The counter bitmap: [0-15].
  */
@@ -1851,8 +1891,7 @@ static int metricgroup__add_pmu_layout_callback(const struct pmu_layout *pl,
  * @table: pmu_layouts table that is searched for counter info.
  */
 static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
-				   const struct pmu_layouts_table
-				   *table)
+				   const struct pmu_layouts_table *table)
 {
 	LIST_HEAD(list);
 	int ret;
@@ -2288,6 +2327,8 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	*out_evlist = parsed_evlist;
 	parsed_evlist = NULL;
 err_out:
+	parse_events_error__exit(&parse_error);
+	evlist__delete(parsed_evlist);
 	metricgroup__free_grouping_strs(&groupings);
 	return ret;
 }
@@ -2410,7 +2451,7 @@ static int hw_aware_parse_groups(struct evlist *perf_evlist,
 	if (!metric_no_merge) {
 		struct expr_parse_ctx *combined = NULL;
 
-		ret = build_combined_expr_ctx(&metric_list, &combined);
+		ret = hw_aware_build_combined_expr_ctx(&metric_list, &combined);
 
 		if (!ret && combined && hashmap__size(combined->ids)) {
 			ret = hw_aware_parse_ids(fake_pmu, combined,
-- 
2.42.0


