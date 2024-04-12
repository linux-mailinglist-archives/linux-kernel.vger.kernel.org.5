Return-Path: <linux-kernel+bounces-143368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1A68A37A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC56C2871F7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F1154436;
	Fri, 12 Apr 2024 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzekSNZu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE2153569;
	Fri, 12 Apr 2024 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956101; cv=none; b=NXqy3ZC1/p7+rpfHreZ3AXua9isyvxb8xxJPDPTeVdEeCM6qCNuuYFNxWSDLbv3VPnuY+bUD4VYYwhZqeERzG6siIUzlbL5eUQ08Zlwpi8SROxYIQSpJxdA9E4xGVhTkgd5gwKHdP6/1h4V6n8d2PU7toAy3HdtwjY2vBFWgHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956101; c=relaxed/simple;
	bh=jJTUOTvTBpXp5NYD72GuR6rMpvYJe5VM3t1ZmRAIhXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyW/aIT0i6BUujKNQW6XOy7UmPM88E36SWdDrN4vSr2JuEXzEdUU/Y2JKcyx2/AJ0Sd5fbkFxZx1Pa/fSm46leDfuXdZ9lnqsbEhqe3YaZup89nkoiJdq2z/J5JbyYG0EuU0scwxd9dEtFNEv7dIpAaioZ1r5dqfFI0zQuJa4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzekSNZu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956099; x=1744492099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jJTUOTvTBpXp5NYD72GuR6rMpvYJe5VM3t1ZmRAIhXU=;
  b=lzekSNZu/3BWrWnYP8obrTXutXbw0Gj6CxG8MTSv6u2tIKvjoc2DPoXz
   RAtA7pypg39p7XE3FqDjVlfJgaBpAOcsbO5IwOyftVIQ4LSCziMhpO0k8
   mFeaM0sUN3HX5E31ugr+fcg9MKnLiX5Vkfrcw00H/YuofXq89Ykohsswo
   QNC7/FR4HZ314ta1D8GUF2v682BiJVY013X815uU8mHuJOuXD7B0XT0xO
   RA4pMc2PQ6szpQns1fC8JLIs6VX3+V/5iD1ckysfbz/hOdpyHVNyLAcWp
   LSO1RwjGWqrleRkhJxKNlNoF+A2gTkP+GSeiZys2yoKs2BqD2kWKAyV6y
   A==;
X-CSE-ConnectionGUID: COKkI826Shq1aCCO0unaYA==
X-CSE-MsgGUID: biVfDhJ/TCmDRULw5WBoAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575503"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575503"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:12 -0700
X-CSE-ConnectionGUID: D3DXYr+/QxKYI/HnblX2Pw==
X-CSE-MsgGUID: cw69BwKxSxabsTpxKzSxYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772123"
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
Subject: [RFC PATCH v5 15/16] perf stat: use tool event helper function in metricgroup__build_event_string
Date: Fri, 12 Apr 2024 14:07:55 -0700
Message-ID: <20240412210756.309828-16-weilin.wang@intel.com>
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

We want to include all used tool events in each event group to ensure
sharing events so that help improve multiplexing.

This change updates parse_id and metricgroupg__build_event_string to use
the get_tool_event_str helper function to generate tool event string
instead of inserting temporary tool event ids and generate string from
the tool event ids.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 61 +++++++++++++----------------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 86b6528e5a44..39746d18f078 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -774,6 +774,18 @@ static int get_tool_event_str(struct strbuf *events,
 	int i = 0;
 	int ret;
 
+	/*
+	 * We may fail to share events between metrics because a tool
+	 * event isn't present in one metric. For example, a ratio of
+	 * cache misses doesn't need duration_time but the same events
+	 * may be used for a misses per second. Events without sharing
+	 * implies multiplexing, that is best avoided, so place
+	 * all tool events in every group.
+	 * This function helps place all tool events in every group by
+	 * generating the tool event strbuf that to be added in event
+	 * group strings.
+	 */
+
 	perf_tool_event__for_each_event(i) {
 		if (tool_events[i]) {
 			const char *tmp = strdup(perf_tool_event__to_str(i));
@@ -795,15 +807,18 @@ static int get_tool_event_str(struct strbuf *events,
 static int metricgroup__build_event_string(struct strbuf *events,
 					   const struct expr_parse_ctx *ctx,
 					   const char *modifier,
-					   bool group_events)
+					   bool group_events,
+					   const bool tool_events[PERF_TOOL_MAX])
 {
 	struct hashmap_entry *cur;
 	size_t bkt;
 	bool no_group = true, has_tool_events = false;
-	bool tool_events[PERF_TOOL_MAX] = {false};
 	int ret = 0;
+	struct strbuf tool_event_str = STRBUF_INIT;
 
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
+	ret = get_tool_event_str(&tool_event_str, tool_events, &has_tool_events);
+	RETURN_IF_NON_ZERO(ret);
 
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *sep, *rsep, *id = cur->pkey;
@@ -814,8 +829,6 @@ static int metricgroup__build_event_string(struct strbuf *events,
 		/* Always move tool events outside of the group. */
 		ev = perf_tool_event__from_str(id);
 		if (ev != PERF_TOOL_NONE) {
-			has_tool_events = true;
-			tool_events[ev] = true;
 			continue;
 		}
 		/* Separate events with commas and open the group if necessary. */
@@ -879,19 +892,8 @@ static int metricgroup__build_event_string(struct strbuf *events,
 		RETURN_IF_NON_ZERO(ret);
 	}
 	if (has_tool_events) {
-		int i;
-
-		perf_tool_event__for_each_event(i) {
-			if (tool_events[i]) {
-				if (!no_group) {
-					ret = strbuf_addch(events, ',');
-					RETURN_IF_NON_ZERO(ret);
-				}
-				no_group = false;
-				ret = strbuf_addstr(events, perf_tool_event__to_str(i));
-				RETURN_IF_NON_ZERO(ret);
-			}
-		}
+		ret = strbuf_addstr(events, tool_event_str.buf);
+		RETURN_IF_NON_ZERO(ret);
 	}
 
 	return ret;
@@ -2421,32 +2423,13 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 
 	*out_evlist = NULL;
 	if (!metric_no_merge || hashmap__size(ids->ids) == 0) {
-		bool added_event = false;
-		int i;
 		/*
-		 * We may fail to share events between metrics because a tool
-		 * event isn't present in one metric. For example, a ratio of
-		 * cache misses doesn't need duration_time but the same events
-		 * may be used for a misses per second. Events without sharing
-		 * implies multiplexing, that is best avoided, so place
-		 * all tool events in every group.
-		 *
-		 * Also, there may be no ids/events in the expression parsing
+		 * There may be no ids/events in the expression parsing
 		 * context because of constant evaluation, e.g.:
 		 *    event1 if #smt_on else 0
 		 * Add a tool event to avoid a parse error on an empty string.
 		 */
-		perf_tool_event__for_each_event(i) {
-			if (tool_events[i]) {
-				char *tmp = strdup(perf_tool_event__to_str(i));
-
-				if (!tmp)
-					return -ENOMEM;
-				ids__insert(ids->ids, tmp);
-				added_event = true;
-			}
-		}
-		if (!added_event && hashmap__size(ids->ids) == 0) {
+		if (hashmap__size(ids->ids) == 0) {
 			char *tmp = strdup("duration_time");
 
 			if (!tmp)
@@ -2455,7 +2438,7 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 		}
 	}
 	ret = metricgroup__build_event_string(&events, ids, modifier,
-					      group_events);
+					      group_events, tool_events);
 	if (ret)
 		return ret;
 
-- 
2.42.0


