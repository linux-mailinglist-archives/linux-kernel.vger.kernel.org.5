Return-Path: <linux-kernel+bounces-143354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB48A8A378E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567521F23BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37461514EA;
	Fri, 12 Apr 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aa9INqXT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830BA22EE0;
	Fri, 12 Apr 2024 21:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956092; cv=none; b=MfAdeblt0/wHLruIotCelve/BZwHM2uQXBfsm7wpEEVjhLYudToWZ7mHZdMd0u+0+E4yXQpkfyHeyeOaTrv4PI7wBcnkGR84xeK8326VulUYevg95UlshYeYadnAEXyuevQBtlk5PUVK+regkkO6iNMPlNLf6MI0RN19Lg9xukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956092; c=relaxed/simple;
	bh=UQMRzkNEk2MsDjXOZVo9LUR5e+ngNGOU38dE+7tP6BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OL2FeTlbh2IHOthptiWU9qY/AS5+vUL9+3fy64vQAai0hUACEVDFaEKWZFZmGUYw/ZySXqx40UVAHFcNjiFxRUjOpn7iGf2ftlAfTKQiq8uLrUB3WXIVnGzSgxN+j4m2F2dfW/LZi6fhmivsNNJjOvfBxiMNT0+YgE+NRWk21s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aa9INqXT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956091; x=1744492091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UQMRzkNEk2MsDjXOZVo9LUR5e+ngNGOU38dE+7tP6BQ=;
  b=aa9INqXTdnzun1GgoZbCFTAtowFJ/o/1VCcZUgc8WtEvnkqO2rb+MsHS
   YqGzlWgBTOT9vrffpdutynvu9cO9O7S+fS92u1jBeef5CYXgo4/6blVDZ
   cep8spx1LtWAJVuwd/F1lm+SITIOKUIfssK6p3Fyhc8zT7v2at4SAJYZR
   yj2kNGFFSRHgsPjc13Af6Po/F0wqLXhFikiihUE6ZCMX4DxYNH0xNjl1G
   t0Q35p6bVr0XyyoPRlbjGh7yHEdKPAlGBDFXq2RmRE+ALfMdA+wAD6fTg
   yW2JgnCg82GJe2qOf4tvWUMFIowzCyY/KHxhmsIRjjlWH+1B0Gmr/UMhY
   A==;
X-CSE-ConnectionGUID: IBFxIFwSQ0OhR3GgfcPSyw==
X-CSE-MsgGUID: BYUeEIVrQQ67Xqgi5nHgGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575422"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575422"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:08 -0700
X-CSE-ConnectionGUID: 0OzVMJMnRB243szEzy5XEw==
X-CSE-MsgGUID: K7l+l18oSE2zu0tu91c+oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772064"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa006.jf.intel.com with ESMTP; 12 Apr 2024 14:08:08 -0700
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
Subject: [RFC PATCH v5 01/16] perf stat: Add new field in stat_config to enable hardware aware grouping.
Date: Fri, 12 Apr 2024 14:07:41 -0700
Message-ID: <20240412210756.309828-2-weilin.wang@intel.com>
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

Hardware counter and event information could be used to help creating event
groups that better utilize hardware counters and improve multiplexing.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c     | 5 +++++
 tools/perf/util/metricgroup.c | 5 +++++
 tools/perf/util/metricgroup.h | 1 +
 tools/perf/util/stat.h        | 1 +
 4 files changed, 12 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6bba1a89d030..c4a5f0984295 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2106,6 +2106,7 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events);
 	}
 
@@ -2139,6 +2140,7 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events);
 	}
 
@@ -2173,6 +2175,7 @@ static int add_default_attributes(void)
 						/*metric_no_threshold=*/true,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events) < 0)
 			return -1;
 	}
@@ -2214,6 +2217,7 @@ static int add_default_attributes(void)
 							/*metric_no_threshold=*/true,
 							stat_config.user_requested_cpu_list,
 							stat_config.system_wide,
+							stat_config.hardware_aware_grouping,
 							&stat_config.metric_events) < 0)
 				return -1;
 
@@ -2748,6 +2752,7 @@ int cmd_stat(int argc, const char **argv)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events);
 
 		zfree(&metrics);
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 79ef6095ab28..11613450725a 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1690,12 +1690,17 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool metric_no_threshold,
 			      const char *user_requested_cpu_list,
 			      bool system_wide,
+			      bool hardware_aware_grouping,
 			      struct rblist *metric_events)
 {
 	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 
 	if (!table)
 		return -EINVAL;
+	if (hardware_aware_grouping) {
+		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
+	}
+
 
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index d5325c6ec8e1..779f6ede1b51 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -77,6 +77,7 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool metric_no_threshold,
 			      const char *user_requested_cpu_list,
 			      bool system_wide,
+			      bool hardware_aware_grouping,
 			      struct rblist *metric_events);
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_metrics_table *table,
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index d6e5c8787ba2..fd7a187551bd 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -87,6 +87,7 @@ struct perf_stat_config {
 	bool			 metric_no_group;
 	bool			 metric_no_merge;
 	bool			 metric_no_threshold;
+	bool			 hardware_aware_grouping;
 	bool			 stop_read_counter;
 	bool			 iostat_run;
 	char			 *user_requested_cpu_list;
-- 
2.42.0


