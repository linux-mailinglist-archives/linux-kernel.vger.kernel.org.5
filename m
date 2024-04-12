Return-Path: <linux-kernel+bounces-143361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80A8A3794
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064CD1F23BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3244152DF7;
	Fri, 12 Apr 2024 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nq3GnpvR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D38152194;
	Fri, 12 Apr 2024 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956096; cv=none; b=pjLTU0LtBsbZkzOYlnclDKCgfun4nNswQ+JC5UEdEfkYnDWmvHqtKXgNSswXEux+zULxThweMJtVoqowq+ARwVBM8TPnkVRDscinAZTE/JlhWgITF63Cz3rOTvrEpe53iSXfBis9zPouqEZ1Sy3DqO0SEXwUZ0lgnR5TkN4WqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956096; c=relaxed/simple;
	bh=3hTJ9fWLDhNtE9cyNQKOk+MI436+hVx2AKwZNmm7sEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Px6Mg6+Tm7eu1o6RR65noOMFItUKdmqo2kXId4nF2aTOVK2kwsGUG5FkT7WZs6S407A/f9+m8UfPPt+mjhu7R+Vbsgo4qwIBtgIcsCgqvBUzVIQ8Ue5zgPanVdQzK5D6RVzBetsavhcIOcvSoXJyQl4uI6XRXCaqd+khruV0DHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nq3GnpvR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956095; x=1744492095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3hTJ9fWLDhNtE9cyNQKOk+MI436+hVx2AKwZNmm7sEg=;
  b=Nq3GnpvRrj3oCPUH3j+Vxk6Pemmu+qjT8bUFEjWf33gbp6ts7kWG3SuB
   pH0BPkCyoj1Ej60X2S8bOyYuKRa8ki2Vk8rBNEiwp7AbsQqkU8C5G9GUS
   XlojAR5bbVOs+jqeZzhdKGhLZjq+5DDsX65rN2/rvosi4ZwOth3+wGVFu
   mtLFHhh/xrXfDrnPqeXUBwJmsGLnJP2bx5WBPdYSfYD6nB1x7srGk3zEC
   0nnnSOTq8LhLA34Azwc7HT3VgyqV1TE0Ba4ox9J8S+39pWaqy7c33BrA/
   DEDWapOcSJJzABfxsxDr3TSnzOtIPod2ChFtEawLalosqim4V4Lw2S2Ve
   g==;
X-CSE-ConnectionGUID: kDkQcVOjTiWTmdlGZKvRSg==
X-CSE-MsgGUID: Tf5R7+oKRNujPfoy+1KrIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575470"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575470"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:11 -0700
X-CSE-ConnectionGUID: WnX19+FeQbCkCN15FrM1kQ==
X-CSE-MsgGUID: HQYVwZRmSnCEh3FtHj3Opg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772105"
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
Subject: [RFC PATCH v5 09/16] perf stat: Add function to handle special events in hardware-grouping
Date: Fri, 12 Apr 2024 14:07:49 -0700
Message-ID: <20240412210756.309828-10-weilin.wang@intel.com>
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

There are some special events like topdown events and TSC that are not
described in pmu-event JSON files. Add support to handle this type of
events. This should be considered as a temporary solution because including
these events in JSON files would be a better solution.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 04d988ace734..681aacc15787 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -162,6 +162,20 @@ struct metric {
 
 /* Maximum number of counters per PMU*/
 #define NR_COUNTERS	16
+/* Special events that are not described in pmu-event JSON files.
+ * topdown-* and TSC use dedicated registers, set as free
+ * counter for grouping purpose
+ */
+enum special_events {
+	TOPDOWN	= 0,
+	TSC	= 1,
+	SPECIAL_EVENT_MAX,
+};
+
+static const char *const special_event_names[SPECIAL_EVENT_MAX] = {
+	"topdown-",
+	"TSC",
+};
 
 /**
  * An event used in a metric. This info is for metric grouping.
@@ -2142,6 +2156,15 @@ static int create_grouping(struct list_head *pmu_info_list,
 	return ret;
 };
 
+static bool is_special_event(const char *id)
+{
+	for (int i = 0; i < SPECIAL_EVENT_MAX; i++) {
+		if (!strncmp(id, special_event_names[i], strlen(special_event_names[i])))
+			return true;
+	}
+	return false;
+}
+
 /**
  * hw_aware_build_grouping - Build event groupings by reading counter
  * requirement of the events and counter available on the system from
@@ -2166,6 +2189,17 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *id = cur->pkey;
 
+		if (is_special_event(id)) {
+			struct metricgroup__event_info *event;
+
+			event = event_info__new(id, "default_core", "0",
+						/*free_counter=*/true);
+			if (!event)
+				goto err_out;
+
+			list_add(&event->nd, &event_info_list);
+			continue;
+		}
 		ret = get_metricgroup_events(id, etable, &event_info_list);
 		if (ret)
 			goto err_out;
@@ -2636,8 +2670,10 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 		ret = hw_aware_parse_groups(perf_evlist, pmu, str,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
 			    /*fake_pmu=*/NULL, metric_events, table);
-		if (!ret)
+		if (!ret) {
+			pr_info("Hardware aware grouping completed\n");
 			return 0;
+		}
 	}
 
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
-- 
2.42.0


