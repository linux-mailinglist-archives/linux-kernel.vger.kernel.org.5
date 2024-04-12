Return-Path: <linux-kernel+bounces-143367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEFD8A379D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555F91F24192
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7DD153BDF;
	Fri, 12 Apr 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGpQeDp+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779D1534F7;
	Fri, 12 Apr 2024 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956100; cv=none; b=lkNXpAVlwV7rg1XWDZLs9qfIOeGQJrmpHC1voSrqKMKmhgYj9aixkZqs5SkSeNsQ+YuIDlcHzaTvF4SxG81Nm+hr3GwjIcNj/THDl2YEBBmn6ifcwDqKOkEYg+m67ZpSyUcCfB4kEO8rB7hb63HQu+dd6LQTf+O8HR7a3BihSYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956100; c=relaxed/simple;
	bh=XkrdL1qPBlybD5gbCiARJ41rqvwqqxSL8T+Bt5/xD44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9OlGVDgkNRXyI9bvjeN8o8/enAEFB7C/SbcLWSQPatMffyaxRsC7ZzubwtNJ++LrcbhyoG7GaJK5q3AzbpK0TNZ8kPN2QzdiwEdDhmGlw4JAFt3+rXrWarEw4SNHRTSjeRqBYyGdawExgg6tg6nxBRuHzeLMOms7AclqKEBVgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGpQeDp+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956099; x=1744492099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XkrdL1qPBlybD5gbCiARJ41rqvwqqxSL8T+Bt5/xD44=;
  b=SGpQeDp+0mthp68HynJSvsoFibO9a6NX0+VY/bvqps8zggGfIFRYEnY1
   7gyVZz8kkQi2A6yPUNQWthWsiBDgQxLS/3jVQf3AH8KydkHNVx73GQrj0
   IVAjVTlI9jZm1fRacm1FAQVtN0TqEDtgL8Huf0PurO4oeumSYgeJAhG1O
   SuD9p4D3DijoD8X4d/8mOulVTvnuinVxdnugGKgpqrd1Py1cMy7633r6c
   cWzvHnGpZWMb6n1FGxIrv6VWhHNjQP6pnNgDklWRHTJfFLr/jx8ey/DJu
   /SXDGpBu6M7YBmHhb3RAvCxeavAQ6qAMZMh1eF27zzU+K/q9ab61lL1p/
   A==;
X-CSE-ConnectionGUID: PtoONbTTQ2iBqLJKFU3UTQ==
X-CSE-MsgGUID: iOwKmo+1Reuz91DdsD05eA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575498"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575498"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:12 -0700
X-CSE-ConnectionGUID: Mu/KI6kFQ7aXfDNChUyE9w==
X-CSE-MsgGUID: 2eVRs6F5QVy3jKIvdSc6cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772120"
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
Subject: [RFC PATCH v5 14/16] perf stat: Add tool events support in hardware-grouping
Date: Fri, 12 Apr 2024 14:07:54 -0700
Message-ID: <20240412210756.309828-15-weilin.wang@intel.com>
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

Add tool events into default_core grouping strings if find tool events so
that metrics use tool events could be correctly calculated. Need this step
to support TopdownL4-L5.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 49 ++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c6db21a2c340..86b6528e5a44 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -763,6 +763,35 @@ static int decode_all_metric_ids(struct evlist *perf_evlist, const char *modifie
 	return ret;
 }
 
+/**
+ * get_tool_event_str - Generate and return a string with all the used tool
+ * event names.
+ */
+static int get_tool_event_str(struct strbuf *events,
+			      const bool tool_events[PERF_TOOL_MAX],
+			      bool *has_tool_event)
+{
+	int i = 0;
+	int ret;
+
+	perf_tool_event__for_each_event(i) {
+		if (tool_events[i]) {
+			const char *tmp = strdup(perf_tool_event__to_str(i));
+
+			if (!tmp)
+				return -ENOMEM;
+			*has_tool_event = true;
+			ret = strbuf_addstr(events, ",");
+			if (ret)
+				return ret;
+			ret = strbuf_addstr(events, tmp);
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
+}
+
 static int metricgroup__build_event_string(struct strbuf *events,
 					   const struct expr_parse_ctx *ctx,
 					   const char *modifier,
@@ -2096,6 +2125,7 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
 
 static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs,
 					   const char *modifier,
+					   const bool tool_events[PERF_TOOL_MAX],
 					   struct list_head *groups)
 {
 	struct metricgroup__pmu_group_list *p;
@@ -2103,8 +2133,12 @@ static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs
 	struct metricgroup__group_events *ge;
 	bool no_group = true;
 	int ret = 0;
+	struct strbuf tool_event_str = STRBUF_INIT;
+	bool has_tool_event = false;
 
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
+	ret = get_tool_event_str(&tool_event_str, tool_events, &has_tool_event);
+	RETURN_IF_NON_ZERO(ret);
 
 	list_for_each_entry(p, groups, nd) {
 		list_for_each_entry(g, &p->group_head, nd) {
@@ -2176,6 +2210,12 @@ static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs
 			}
 			ret = strbuf_addf(events, "}");
 			RETURN_IF_NON_ZERO(ret);
+
+			if (has_tool_event) {
+				ret = strbuf_addstr(events, tool_event_str.buf);
+				RETURN_IF_NON_ZERO(ret);
+			}
+
 			pr_debug("events-buf: %s\n", events->buf);
 			list_add_tail(&new_group_str->nd, group_strs);
 		}
@@ -2261,6 +2301,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx,
 		if (ret)
 			goto err_out;
 	}
+
 	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
 	if (ret)
 		goto err_out;
@@ -2306,6 +2347,7 @@ static void metricgroup__free_grouping_strs(struct list_head
  */
 static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 			     struct expr_parse_ctx *ids, const char *modifier,
+			     const bool tool_events[PERF_TOOL_MAX],
 			     struct evlist **out_evlist)
 {
 	struct parse_events_error parse_error;
@@ -2319,7 +2361,8 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	ret = hw_aware_build_grouping(ids, &grouping);
 	if (ret)
 		goto out;
-	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier, &grouping);
+	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier,
+						      tool_events, &grouping);
 	if (ret)
 		goto out;
 
@@ -2454,6 +2497,7 @@ static int hw_aware_parse_groups(struct evlist *perf_evlist,
 	struct evlist *combined_evlist = NULL;
 	LIST_HEAD(metric_list);
 	struct metric *m;
+	bool tool_events[PERF_TOOL_MAX] = {false};
 	int ret;
 	bool metric_no_group = false;
 	bool metric_no_merge = false;
@@ -2472,11 +2516,14 @@ static int hw_aware_parse_groups(struct evlist *perf_evlist,
 	if (!metric_no_merge) {
 		struct expr_parse_ctx *combined = NULL;
 
+		find_tool_events(&metric_list, tool_events);
+
 		ret = hw_aware_build_combined_expr_ctx(&metric_list, &combined);
 
 		if (!ret && combined && hashmap__size(combined->ids)) {
 			ret = hw_aware_parse_ids(fake_pmu, combined,
 						/*modifier=*/NULL,
+						tool_events,
 						&combined_evlist);
 		}
 
-- 
2.42.0


