Return-Path: <linux-kernel+bounces-128747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7892895EEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9EC1C23877
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F3F15ECC1;
	Tue,  2 Apr 2024 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhGe2/Bd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752F715E808;
	Tue,  2 Apr 2024 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094376; cv=none; b=o8I6ri3210jzHFXzsM8Vdpmpth8hMNGRbX3j+isd0oi3dF7ALkvwtUJwG8H2ejWqcmVfA43wwE9HTkKpcPS97RC9EDWU1LhSBi051v+17WBS1TbOpOF3qK1AH1MquDnq+N9EdHBOyebJInst7KaS+73E+OP/JJMRYqzFfTqC3Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094376; c=relaxed/simple;
	bh=gbaHPOtoi6t4Dnwpo4nW/r8IVCih6GDqcft3zBeCGJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOzXhRht72ToNT8EeF7AniR3AGcHInrkllhGm7LORHFexHC3E4kqEjCwzooi8HqVZvmXLlTBE7tNv58GQnM1D7gBWBNX23eUNHkO6fF/lsKiKiGsvZKFfoMeeLApp//xxZ2VA3gdbJRa5RkiqR6H9TBymTkmq0gKt2ak8HVaS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhGe2/Bd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712094374; x=1743630374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gbaHPOtoi6t4Dnwpo4nW/r8IVCih6GDqcft3zBeCGJM=;
  b=mhGe2/BdRi7+/n7HXumm7fuP82P5+9Dv29MxLE727RweIPFAfUBt8eVq
   HS5cQF4OS0lMTmPEdhVWr9BkO+TYnxnQr8/H+DBB8r7DED5n8H4YrJGK7
   r/aLmhsZD60QFBvnUrDHzTr8eqOFXlIfB8PFsSbaRC11RBBbIsz3qCzaF
   RUbnuyhf+2axnlIaikJlvCZSRV3zrGlsnN6sPc9gfVEqDePD5Wt/Ud63J
   VO9J2kiGEdid3ezdMyahemFioNF2mlB2zcPsaPZs9zXicnyz7JKNY9QjY
   6SYNGiUSb8ZUm6GUBLgFKltZQ57JkrpKKDpaRJHX8dq5HCDf1E5Y2KXyi
   w==;
X-CSE-ConnectionGUID: E7BemyLjQEuTZjuh2obyhQ==
X-CSE-MsgGUID: orVKMnzfSb+gxf0AO2If6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18020026"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18020026"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:45:05 -0700
X-CSE-ConnectionGUID: rLph5BO9R7SZiK4ni/tutw==
X-CSE-MsgGUID: TVBfzDEITvCO8NU0JsnqMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22849091"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa004.fm.intel.com with ESMTP; 02 Apr 2024 14:45:04 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v7 5/6] perf stat: Add retire latency print functions to print out at the very end of print out
Date: Tue,  2 Apr 2024 17:44:35 -0400
Message-ID: <20240402214436.1409476-6-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402214436.1409476-1-weilin.wang@intel.com>
References: <20240402214436.1409476-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Add print out functions so that users could read retire latency values.

Example output:

 Performance counter stats for 'system wide':

            25,717      MEM_INST_RETIRED.SPLIT_STORES    #      2.2 %  tma_split_stores
        28,365,080      CPU_CLK_UNHALTED.THREAD
             24.00      MEM_INST_RETIRED.SPLIT_STORES:p  #       96        4

       2.054365083 seconds time elapsed

This output of retire latency data is in format:
 <val> <event-name> # <sum> <count>.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 69 ++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bfc1d705f437..c32d484b53a9 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -21,6 +21,7 @@
 #include "iostat.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "metricgroup.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -34,6 +35,7 @@
 #define COMM_LEN     16
 #define PID_LEN       7
 #define CPUS_LEN      4
+#define RETIRE_LEN    8
 
 static int aggr_header_lens[] = {
 	[AGGR_CORE] 	= 18,
@@ -426,6 +428,71 @@ static void print_metric_std(struct perf_stat_config *config,
 	fprintf(out, " %-*s", METRIC_LEN - n - 1, unit);
 }
 
+static void print_retire_lat_std(struct perf_stat_config *config,
+				 struct outstate *os)
+{
+	FILE *out = os->fh;
+	bool newline = os->newline;
+	struct tpebs_retire_lat *t;
+	struct list_head *retire_lats = &config->tpebs_results;
+
+	list_for_each_entry(t, retire_lats, event.nd) {
+		if (newline)
+			do_new_line_std(config, os);
+		fprintf(out, "%'*.2f ", COUNTS_LEN, t->val);
+		/* For print alignment */
+		fprintf(out, "%-*s ", config->unit_width, "");
+		fprintf(out, "%-*s", EVNAME_LEN, t->event.name);
+		fprintf(out, " # ");
+		fprintf(out, "%*d %*ld\n", RETIRE_LEN, t->sum,
+			 RETIRE_LEN, t->count);
+	}
+}
+
+static void print_retire_lat_csv(struct perf_stat_config *config,
+				 struct outstate *os)
+{
+	FILE *out = os->fh;
+	struct tpebs_retire_lat *t;
+	struct list_head *retire_lats = &config->tpebs_results;
+	const char *sep = config->csv_sep;
+
+	list_for_each_entry(t, retire_lats, event.nd) {
+		fprintf(out, "%f%s%s%s%s%ld%s%d\n", t->val, sep, sep, t->event.name, sep,
+			t->count, sep, t->sum);
+	}
+}
+
+static void print_retire_lat_json(struct perf_stat_config *config,
+				  struct outstate *os)
+{
+	FILE *out = os->fh;
+	struct tpebs_retire_lat *t;
+	struct list_head *retire_lats = &config->tpebs_results;
+
+	fprintf(out, "{");
+	list_for_each_entry(t, retire_lats, event.nd) {
+		fprintf(out, "\"retire_latency-value\" : \"%f\", ", t->val);
+		fprintf(out, "\"event-name\" : \"%s\"", t->event.name);
+		fprintf(out, "\"sample-counts\" : \"%ld\"", t->count);
+		fprintf(out, "\"retire_latency-sum\" : \"%d\"", t->sum);
+	}
+	fprintf(out, "}");
+}
+
+static void print_retire_lat(struct perf_stat_config *config,
+			     struct outstate *os)
+{
+	if (!&config->tpebs_results)
+		return;
+	if (config->json_output)
+		print_retire_lat_json(config, os);
+	else if (config->csv_output)
+		print_retire_lat_csv(config, os);
+	else
+		print_retire_lat_std(config, os);
+}
+
 static void new_line_csv(struct perf_stat_config *config, void *ctx)
 {
 	struct outstate *os = ctx;
@@ -1609,6 +1676,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		break;
 	}
 
+	print_retire_lat(config, &os);
+
 	print_footer(config);
 
 	fflush(config->output);
-- 
2.43.0


