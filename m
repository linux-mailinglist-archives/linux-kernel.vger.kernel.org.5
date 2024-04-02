Return-Path: <linux-kernel+bounces-128746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19792895EEA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2159B1C21BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6120C15ECE3;
	Tue,  2 Apr 2024 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdGyjJVF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2EA15E801;
	Tue,  2 Apr 2024 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094375; cv=none; b=QYbVkwUlAxA83UpUU2wzi0oQB9C8xusyfw58Yl1XgmrOvHwyhgYtc++9arGA85bgNUXiaBEVP2cAKtpi9ElqnBWhTrs33rikIiTOGlSGh/FDqeiPCxjgQ/3D68Kg7EgsbQdcuh9W5aP3lONUCmcSTqbEjSW/DZm00xZe0y7KtAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094375; c=relaxed/simple;
	bh=2lHSEpJTsedWv+KHgknqQO3JpNz+YAg/uqo64Wkj/Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTMsWvwyHSVF3VrHbWA9TAF7rR2xUQ7PUzUjw3DLZ6JlSJ2JnTOmtutel7/LUFEQEPOznQCKbs7yzWkTIIpkleHI73OEA328ICVGCyqNoEpOLV1+6o61L3Uj7sKyvJ0mSMakw4RIpo4UUI1EPAjm4bft+UX5S4hdEpVqlGJyiSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdGyjJVF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712094374; x=1743630374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2lHSEpJTsedWv+KHgknqQO3JpNz+YAg/uqo64Wkj/Zo=;
  b=fdGyjJVF3bTQtquN7KhhOZNI2ru1QleIP3O+7pL+SUT//tFBk+etzd13
   NFIyhl5Yh5+W3pwCpX7olgJzslTkpnRvvWx1/GRDDABhKxq26kowPHmCG
   jSOdait3/6jr3bppkqIvMOq6J1QMMQS+WUr3JpZmhTojm5RvVb/+TxFkL
   DB5kIJWUKPBAyU95UbcPD/y/r5rfWTLi88ggTkcV3e0nXPrgmFJBt6l0U
   SQjAM08OmQ/U/2GZ529cB7SdJYXIW1upwUKgh8hLHGIk+q/BIa9QhwFqZ
   2p+BZTXBCgM2okpIR18RukuYWaci9aGZO07p5fZh1vNqI8CssKxTZxjyy
   Q==;
X-CSE-ConnectionGUID: /J719p/tTo+b2d3Qjmo+Mw==
X-CSE-MsgGUID: 863Kr1m6RWKRDlFNcZhj/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18020021"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18020021"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:45:05 -0700
X-CSE-ConnectionGUID: 1rRHjqmfQ3yvHUK1yoob8Q==
X-CSE-MsgGUID: lRFKOsFQRqOEfD99O9qttg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22849088"
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
Subject: [RFC PATCH v7 4/6] perf stat: Add retire latency values into the expr_parse_ctx to prepare for final metric calculation
Date: Tue,  2 Apr 2024 17:44:34 -0400
Message-ID: <20240402214436.1409476-5-weilin.wang@intel.com>
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

Retire latency values of events are used in metric formulas. This update adds
code to process data from perf record for required retire latency values.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     |  1 +
 tools/perf/util/metricgroup.h |  4 ++++
 tools/perf/util/stat-shadow.c | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2dcc1a12f7ef..bf8045f0b879 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -816,6 +816,7 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 		if (!strcmp(evname, t->event.name)) {
 			t->count += 1;
 			t->sum += sample->retire_lat;
+			t->val = (double) t->sum / t->count;
 			break;
 		}
 	}
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index ae788edef30f..d63209b29bf1 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -76,8 +76,12 @@ struct tpebs_event {
 
 struct tpebs_retire_lat {
 	struct tpebs_event event;
+	/* Count of retire_latency values found in sample data */
 	size_t count;
+	/* Sum of all the retire_latency values in sample data */
 	int sum;
+	/* Average of retire_latency, val = sum / count */
+	double val;
 };
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3466aa952442..bc77e9e02892 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -355,6 +355,20 @@ static void print_nsecs(struct perf_stat_config *config,
 		print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
 }
 
+static int prepare_retire_lat(struct expr_parse_ctx *pctx,
+			     struct list_head *retire_lats)
+{
+	int ret = 0;
+	struct tpebs_retire_lat *t;
+
+	list_for_each_entry(t, retire_lats, event.nd) {
+		ret = expr__add_id_val(pctx, strdup(t->event.tpebs_name), t->val);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
+}
+
 static int prepare_metric(const struct metric_expr *mexp,
 			  const struct evsel *evsel,
 			  struct expr_parse_ctx *pctx,
@@ -486,6 +500,11 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = runtime;
 	pctx->sctx.system_wide = config->system_wide;
+	i = prepare_retire_lat(pctx, &config->tpebs_results);
+	if (i < 0) {
+		expr__ctx_free(pctx);
+		return;
+	}
 	i = prepare_metric(mexp, evsel, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
-- 
2.43.0


