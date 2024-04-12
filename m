Return-Path: <linux-kernel+bounces-143364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D31C8A3798
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53E6B24E99
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0773153563;
	Fri, 12 Apr 2024 21:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUHLddYj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F164515253B;
	Fri, 12 Apr 2024 21:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956098; cv=none; b=Es0RDZ9tuDNTCyRnhyBLwTO93/LFn4xzKUfX0U71jgrmpJOn451PORAPYF1n+Aemx2A2FCHq8zNbTanGg8EIXW+HCyjFi8OaPYb54SnJ3cqLU409meswCol9el6BECrZCAUbtZKxs3+DJSse7X3pQLPXZ0FVK9t4MfTBNqY668o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956098; c=relaxed/simple;
	bh=ogrxKE2gR5mVkVtp7MLCNz0k+qduvC4zFBtBAG24Xhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPNVgv8bxUHshS29qtoa8vMw9chn/qbYbk3Yj41EY/hXohSQPEGHge7fUG9/kZj2Q01bKN/2iMT0GRonLilsLF4xicSpnMo/5ZeSSBZcFUkuvdXu/hZ5aDqttlcGEYeAPiBVVB/S3GCYJmR9ruLpaNGMVnRnzTXbhqyqHNqJaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUHLddYj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956097; x=1744492097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ogrxKE2gR5mVkVtp7MLCNz0k+qduvC4zFBtBAG24Xhg=;
  b=RUHLddYjbcNDu3mYWdyD8JHX7tTlkj7VEBOmua+Wk5SVpHCDu0rsb/Y8
   B+4jf+vy7cRH/WQJrORtb1le1W7fvbosEG/RO8kDL/uf/+IRot7LknUbo
   RSEwEEHUlsUSI8Ty1SwtkmtJyDl9xqg8fgsx8+Wrlz53R1c0VNYnbjPM9
   UIoIKMlGPVSQ1DOH285FemsdNdam3VrQSnSU4yz8HWrOm6U9RhX+i49f4
   yX9ZFBVYve0SkQNCjZSj8fjtmS5pVrJjQrwNl4C3010Pm0sAAMkPXfPV2
   3rweNbLw/aXHj859c5Nax/2L1xnKbhmj9c23b/ZoHajA1euwhjY4KryL/
   g==;
X-CSE-ConnectionGUID: TPbLbcXtTwqXpq/+4cud4Q==
X-CSE-MsgGUID: S0DG0pzESvme0MhmGkG43A==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575486"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575486"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:11 -0700
X-CSE-ConnectionGUID: ishY4e1mTE2web46tuLqAg==
X-CSE-MsgGUID: bwfcFw67RAeYZSDash3Scw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772111"
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
Subject: [RFC PATCH v5 11/16] perf stat: Add partial support on MSR in hardware-grouping
Date: Fri, 12 Apr 2024 14:07:51 -0700
Message-ID: <20240412210756.309828-12-weilin.wang@intel.com>
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

Add MSR usage into consideration when grouping. Each group can only
include one event that requires one specific MSR. Currently, we only
support events that requries one MSR. For some OCR events that have
multiple MSRs in their MSRIndex field, this commit will treat them as
one "large MSR". We're planning to improve this part in future.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/pmu-events/jevents.py   |  4 +++-
 tools/perf/pmu-events/pmu-events.h |  6 ++++++
 tools/perf/util/metricgroup.c      | 27 ++++++++++++++++++++++-----
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 7cfd86d77fea..66531c2df224 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -54,7 +54,9 @@ _json_event_attributes = [
     # Short things in alphabetical order.
     'compat', 'deprecated', 'perpkg', 'unit',
     # Longer things (the last won't be iterated over during decompress).
-    'long_desc'
+    'long_desc',
+    # MSRIndex required by the event. NULL if no MSR is required.
+    'msr'
 ]
 
 # Attributes that are in pmu_unit_layout.
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 5b42a18693cf..76ec2b431dce 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -54,6 +54,12 @@ struct pmu_event {
 	const char *unit;
 	bool perpkg;
 	bool deprecated;
+	/*
+	 * MSR is another resource that restricts grouping. Currently, we
+	 * support only MSRIndex 0x3F6 and 0x3F7.  TODO: add support for all the
+	 * MSRs related to event grouping.
+	 */
+	const char *msr;
 };
 
 struct pmu_metric {
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b9e46dff1e17..9548654c9f6d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -193,6 +193,7 @@ struct metricgroup__event_info {
 	 * during the event grouping.
 	 */
 	bool free_counter;
+	const char *msr;
 	/** The counters the event allowed to be collected on. */
 	DECLARE_BITMAP(counters, NR_COUNTERS);
 };
@@ -240,6 +241,7 @@ struct metricgroup__group {
 	DECLARE_BITMAP(fixed_counters, NR_COUNTERS);
 	/** Head to the list of event names in this group*/
 	struct list_head event_head;
+	const char *msr;
 };
 
 struct metricgroup__group_events {
@@ -1747,6 +1749,7 @@ static void metricgroup__free_pmu_info(struct list_head *pmu_info_list)
 static struct metricgroup__event_info *event_info__new(const char *name,
 						      const char *pmu_name,
 						      const char *counter,
+						      const char *msr,
 						      bool free_counter)
 {
 	int ret = 0;
@@ -1764,6 +1767,11 @@ static struct metricgroup__event_info *event_info__new(const char *name,
 	e->pmu_name = strdup(pmu_name);
 	if (!e->pmu_name || !e->name)
 		return NULL;
+	if (msr) {
+		e->msr = strdup(msr);
+		if (!e->msr)
+			return NULL;
+	}
 	e->free_counter = free_counter;
 	if (free_counter) {
 		ret = set_counter_bitmap(0, e->counters);
@@ -1801,7 +1809,8 @@ static int metricgroup__add_metric_event_callback(const struct pmu_event *pe,
 	if (!strcasecmp(pe->name, d->event_name)) {
 		if (!pe->counters_list)
 			return -EINVAL;
-		event = event_info__new(d->event_id, pe->pmu, pe->counters_list, /*free_counter=*/false);
+		event = event_info__new(d->event_id, pe->pmu, pe->counters_list,
+					pe->msr, /*free_counter=*/false);
 		if (!event)
 			return -ENOMEM;
 		list_add(&event->nd, d->list);
@@ -1927,7 +1936,9 @@ static int find_and_set_counters(struct metricgroup__event_info *e,
 {
 	int ret;
 	unsigned long find_bit = 0;
-
+	if (e->msr != NULL && current_group->msr != NULL && !strcmp(e->msr, current_group->msr)) {
+		pr_debug("current group uses the required MSR %s already\n", e->msr);
+		return -ENOSPC;
 	if (e->free_counter)
 		return 0;
 	if (e->fixed_counter) {
@@ -1964,11 +1975,17 @@ static int _insert_event(struct metricgroup__event_info *e,
 		list_add(&event->nd, &group->event_head);
 	else
 		list_add_tail(&event->nd, &group->event_head);
+	if (e->msr != NULL) {
+		group->msr = strdup(e->msr);
+		pr_debug("Add event %s to group, uses MSR %s\n", e->name, e->msr);
+		if (!group->msr)
+			return -ENOMEM;
+	}
 	return 0;
 }
 
 /**
- * Insert the new_group node at the end of the group list.
+ * Initialize the new group and insert it to the end of the group list.
  */
 static int insert_new_group(struct list_head *head,
 			   struct metricgroup__group *new_group,
@@ -2185,7 +2202,7 @@ static int create_grouping(struct list_head *pmu_info_list,
 		bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_COUNTERS);
 		pr_debug("Event name %s, [pmu]=%s, [counters]=%s\n", e->name,
 			e->pmu_name, bit_buf);
-		ret = assign_event_grouping(e, pmu_info_list, &groups);
+		ret = assign_event_grouping(e, pmu_info_list, grouping);
 		if (ret)
 			goto out;
 	}
@@ -2231,7 +2248,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 		if (is_special_event(id)) {
 			struct metricgroup__event_info *event;
 
-			event = event_info__new(id, "default_core", "0",
+			event = event_info__new(id, "default_core", "0", /*msr=*/NULL,
 						/*free_counter=*/true);
 			if (!event)
 				goto err_out;
-- 
2.42.0


