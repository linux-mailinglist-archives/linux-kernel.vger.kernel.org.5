Return-Path: <linux-kernel+bounces-143366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C988C8A379C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BBB91F21D58
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C3153BD6;
	Fri, 12 Apr 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlCeTDyX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B2152E1D;
	Fri, 12 Apr 2024 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956100; cv=none; b=gcX4YMSl5Pcazf9W026gNXzU9D+QHYchxDqTmDkBn7QveGidv/wd57BXKwQ6ZRZGvvv2U3TB2Q/7LZfxdZ2w7CU4Ppi5mYGpzmraQ5FvZTrz+nq6XfQzuzxQ4UpUVpKUbRCVm8TmpTReC6WDGJ8GJ4F4PMF0lbdck4XcS7Xu+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956100; c=relaxed/simple;
	bh=9kqT2qBiVTRhOHGmVy0/cf4XF6kfZ88bRzpyn6BQtTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGzhLk6dOWlSbPfT+DzR4LDRLJUJaDcvUOMTYKKjb36RD8YchVplwcgsxldtO/0G9dfduQx5P+F4lyXj4vt3HguzJJA7XjBHyeAqSB8d8WEd7HpE2qOHWP6xANBK8rgPiokSHJsFMPSv2RaloNT06RbctDLX/0BjzbLK0BdtZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlCeTDyX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956098; x=1744492098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9kqT2qBiVTRhOHGmVy0/cf4XF6kfZ88bRzpyn6BQtTs=;
  b=DlCeTDyXMbCcqQ4/VFCgtEEGyEzM57G2qCnKsAJBs7kFiMzM3l0pLXUs
   poxdAfEMavm7t7fv91zo1dfOzuEcoc2QlF5vimiglokBmEZUhvF3FEV4h
   tbGiHJvDPaqDHlpSlkUPzPgrnxHdNNST+U0OCP8pR/5uyvao2X7Gl6Pun
   Eoni/VCxLkTIhAOV2oBWAlQkCjxrUAQNIc4GwRv1fIquKamjLlHk5Pxrd
   gYvaz2FPa7IagQnOF6TfApDZ+AJ6s/GIJeStIPaTUYl+WpFfe3//SsOYz
   KpjuWEkbb2DbKmnWX8Hn/G2pESIq6KLIUob7C9az8IR+V5TFoFVt+L1/8
   w==;
X-CSE-ConnectionGUID: 36JEms7aTYmh1O8IPfqJ3Q==
X-CSE-MsgGUID: k32WOPb0StyP9BvZ8D03+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575493"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575493"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:12 -0700
X-CSE-ConnectionGUID: KW6cz7Q9Qky0dx+LMdbnPA==
X-CSE-MsgGUID: QPvs95gvQymHpNdEgiggug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772117"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa006.jf.intel.com with ESMTP; 12 Apr 2024 14:08:11 -0700
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
Subject: [RFC PATCH v5 13/16] perf stat: Code refactoring in hardware-grouping
Date: Fri, 12 Apr 2024 14:07:53 -0700
Message-ID: <20240412210756.309828-14-weilin.wang@intel.com>
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

Decouple the step to generate final grouping strings out from the
build_grouping step so that we could do single metric grouping and then
merge groups if needed later.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 44 +++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 31036035484c..c6db21a2c340 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1939,6 +1939,7 @@ static int find_and_set_counters(struct metricgroup__event_info *e,
 	if (e->msr != NULL && current_group->msr != NULL && !strcmp(e->msr, current_group->msr)) {
 		pr_debug("current group uses the required MSR %s already\n", e->msr);
 		return -ENOSPC;
+	}
 	if (e->free_counter)
 		return 0;
 	if (e->fixed_counter) {
@@ -2062,7 +2063,8 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
 
 	list_for_each_entry(g, groups, nd) {
 		if (!strcasecmp(g->pmu_name, e->pmu_name)) {
-			pr_debug("found group for event %s in pmu %s\n", e->name, g->pmu_name);
+			pr_debug("found group header for event %s in pmu %s\n",
+				e->name, g->pmu_name);
 			pmu_group_head = g;
 			break;
 		}
@@ -2193,26 +2195,22 @@ static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs
  */
 static int create_grouping(struct list_head *pmu_info_list,
 			  struct list_head *event_info_list,
-			  struct list_head *groupings,
-			  const char *modifier)
+			  struct list_head *grouping)
 {
 	int ret = 0;
 	struct metricgroup__event_info *e;
-	LIST_HEAD(groups);
 	char *bit_buf = malloc(NR_COUNTERS);
 
-	//TODO: for each new core group, we should consider to add events that uses fixed counters
+	//TODO: for each new core group, we could consider to add events that
+	//uses fixed counters
 	list_for_each_entry(e, event_info_list, nd) {
 		bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_COUNTERS);
 		pr_debug("Event name %s, [pmu]=%s, [counters]=%s\n", e->name,
 			e->pmu_name, bit_buf);
 		ret = assign_event_grouping(e, pmu_info_list, grouping);
 		if (ret)
-			goto out;
+			return ret;
 	}
-	ret = hw_aware_metricgroup__build_event_string(groupings, modifier, &groups);
-out:
-	metricgroup__free_group_list(&groups);
 	return ret;
 };
 
@@ -2233,9 +2231,8 @@ static bool is_special_event(const char *id)
  * @groupings: header to the list of final event grouping.
  * @modifier: any modifiers added to the events.
  */
-static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
-				  struct list_head *groupings __maybe_unused,
-				  const char *modifier __maybe_unused)
+static int hw_aware_build_grouping(struct expr_parse_ctx *ctx,
+				   struct list_head *grouping)
 {
 	int ret = 0;
 	struct hashmap_entry *cur;
@@ -2267,8 +2264,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
 	if (ret)
 		goto err_out;
-	ret = create_grouping(&pmu_info_list, &event_info_list, groupings,
-			     modifier);
+	ret = create_grouping(&pmu_info_list, &event_info_list, grouping);
 
 err_out:
 	metricgroup__free_event_info(&event_info_list);
@@ -2314,23 +2310,25 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
-	LIST_HEAD(groupings);
+	LIST_HEAD(grouping_str);
+	LIST_HEAD(grouping);
 	struct metricgroup__group_strs *group;
 	int ret;
 
 	*out_evlist = NULL;
-	ret = hw_aware_build_grouping(ids, &groupings, modifier);
-	if (ret) {
-		metricgroup__free_grouping_strs(&groupings);
-		return ret;
-	}
+	ret = hw_aware_build_grouping(ids, &grouping);
+	if (ret)
+		goto out;
+	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier, &grouping);
+	if (ret)
+		goto out;
 
 	parsed_evlist = evlist__new();
 	if (!parsed_evlist) {
 		ret = -ENOMEM;
 		goto err_out;
 	}
-	list_for_each_entry(group, &groupings, nd) {
+	list_for_each_entry(group, &grouping_str, nd) {
 		struct strbuf *events = &group->grouping_str;
 
 		pr_debug("Parsing metric events '%s'\n", events->buf);
@@ -2350,7 +2348,9 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 err_out:
 	parse_events_error__exit(&parse_error);
 	evlist__delete(parsed_evlist);
-	metricgroup__free_grouping_strs(&groupings);
+out:
+	metricgroup__free_group_list(&grouping);
+	metricgroup__free_grouping_strs(&grouping_str);
 	return ret;
 }
 
-- 
2.42.0


