Return-Path: <linux-kernel+bounces-140699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BAF8A17E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F258B1F22760
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808616415;
	Thu, 11 Apr 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TE8nO/Kr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105E9134D1;
	Thu, 11 Apr 2024 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847237; cv=none; b=BOvyg/0TnDdAfSmuTBGT/oh+DMzxYynKj/+NMMPsnkaXKvDaaDloCmr2Fk/YV2FyLofTklikzUyiYXnFw1bH6iyt+WnjPtJh1VssxDcu3YbfJr1PWHp+7XTITVaNdx45qG1hxqbDyk+cWByVXkpY18DyZmdz8PTMkpRzf9jhaXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847237; c=relaxed/simple;
	bh=tOn7zspEOJuo3RQx9oTcVrEl/b2IGzPG/7ARcezpV7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TgpKbahkdaCSYz+aa/73gBPOR1saC9g7ciiM8Trrhi5Ud+ZXOC9EtFXchM9sTpJ0BbffZolArZLLbnmqohASZ/6wNC4Cyw5RBUDxiwzweIMsC4nhrk0uwYex/z4cNPPD7R699Mo+kg4Zl7iJFxTUM4wj79iTY/cd2EhLEy0bL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TE8nO/Kr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712847236; x=1744383236;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tOn7zspEOJuo3RQx9oTcVrEl/b2IGzPG/7ARcezpV7c=;
  b=TE8nO/KrDqohaYihEmn96tj9GfP/NiYSE1XfWM5QDCA34q8clvoRDLzO
   teovQ2mO+0ayVRV5b/y3wgsOGoW51mATr+KtjWfWeKm77DnKdY/OPTzzW
   rQD5N0YroaYzVd3EsQ2DNIqFSrdqtUs+38S8zEL3cdGfN90L9TS1k5HP4
   IPLLQvVeExrJdZPvGhQixUHybxi7H2xto33KEuo6U8b6N/tF4tUZaHZz6
   /E/Spu69n+YO7UPm7BakLbhCiRbA5/eANC4LBsg4rn2+68kSRD64t2VsJ
   LIUxs2gUqDLMYFDUXT5ghIRRN24lNdUjHtdEacYC6WkuqfGrQV2Zr6JDu
   Q==;
X-CSE-ConnectionGUID: edOyOLtfSKunMtMZUCi0qg==
X-CSE-MsgGUID: 9mLS1ZeYQ5OH72ASzSXS4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="11225195"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="11225195"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 07:53:55 -0700
X-CSE-ConnectionGUID: xy0iLq3QSf+JRgzXp3SsNA==
X-CSE-MsgGUID: MVX73wf/Q5aPrOkMcVxcCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25442273"
Received: from tower.bj.intel.com ([10.238.157.70])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 07:53:52 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yanfei.xu@intel.com
Subject: [PATCH] perf parse-events: Avoid two scenarios involving the reordering of topdown events
Date: Thu, 11 Apr 2024 22:48:52 +0800
Message-Id: <20240411144852.2507143-1-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We found that even an events group with slots but without topdown events
will still reroder to place the slots first. It's unnecessary, and may
break tools expecting the command line order to match the printed order.
The issue was previously fixed [1], but was later discarded since [2].

Add an extra check of evsel leader, variable must_be_in_group, to ensure
the slots event is only moved if the group has non-slots topdown events.

Without the patch:

  $ perf stat  -e '{cpu/cpu-cycles/,slots}'  sleep 1
  WARNING: events were regrouped to match PMUs

   Performance counter stats for 'sleep 1':

           2,663,256      slots:u
             443,876      cpu/cpu-cycles/u

         1.001079566 seconds time elapsed

         0.001054000 seconds user
         0.000000000 seconds sys

With the patch:

  $ perf stat  -e '{cpu/cpu-cycles/,slots}'  sleep 1

   Performance counter stats for 'sleep 1':

            469,039      cpu/cpu-cycles/u
          2,814,234      slots:u

        1.001148306 seconds time elapsed

        0.001123000 seconds user
        0.000000000 seconds sys

In cases where both slots and topdown events are present, moving the
slots event to be the first event is necessary. However there is no
requirement to move the topdown events to be adjacent to slots event.
So keep the original order of the topdown events is expected. Further
more, if a group doesn't have slots event, the topdown events will be
unexpectedly moved to the head of the group.

Remove the movements regarding topdown events in arch_evlist__cmp()

Without the patch:

  $ perf stat -e '{slots,cpu/cpu-cycles/,cpu/topdown-bad-spec/}' sleep 1
  WARNING: events were regrouped to match PMUs

   Performance counter stats for 'sleep 1':

          2,681,460      slots:u
            336,496      cpu/topdown-bad-spec/u
            446,910      cpu/cpu-cycles/u

        1.001210088 seconds time elapsed

        0.001160000 seconds user
        0.000000000 seconds sys

With the patch:

  $ perf stat -e '{slots,cpu/cpu-cycles/,cpu/topdown-bad-spec/}' sleep 1

   Performance counter stats for 'sleep 1':

          2,715,486      slots:u
            452,581      cpu/cpu-cycles/u
            340,766      cpu/topdown-bad-spec/u

        1.001116709 seconds time elapsed

        0.001111000 seconds user
        0.000000000 seconds sys

[1] https://lore.kernel.org/lkml/20220321223344.1034479-1-irogers@google.com/#/
[2] https://lore.kernel.org/lkml/20230302041211.852330-10-irogers@google.com/#/

Fixes: 347c2f0a0988 ("perf parse-events: Sort and group parsed events")
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 tools/perf/arch/x86/util/evlist.c | 13 +++++--------
 tools/perf/arch/x86/util/evsel.c  |  6 ++++++
 tools/perf/util/evsel.h           |  2 ++
 tools/perf/util/parse-events.c    |  9 ++++++---
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index b1ce0c52d88d..eed0a74c561a 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -75,17 +75,14 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
 
 int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 {
+	struct evsel *leader;
+
 	if (topdown_sys_has_perf_metrics() &&
 	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
+		leader = evsel__leader(rhs);
 		/* Ensure the topdown slots comes first. */
-		if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->name, "uops_retired.slots"))
-			return -1;
-		if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots"))
-			return 1;
-		/* Followed by topdown events. */
-		if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->name, "topdown"))
-			return -1;
-		if (!strcasestr(lhs->name, "topdown") && strcasestr(rhs->name, "topdown"))
+		if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots")
+			&& leader->must_be_in_group)
 			return 1;
 	}
 
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 090d0f371891..16f42fcfbe0b 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -44,6 +44,12 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
 	    strcasestr(evsel->name, "uops_retired.slots"))
 		return false;
 
+	if (strcasestr(evsel->name, "topdown")) {
+		struct evsel *leader = evsel__leader(evsel);
+
+		leader->must_be_in_group = true;
+	}
+
 	return strcasestr(evsel->name, "topdown") || strcasestr(evsel->name, "slots");
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 517cff431de2..a7ab266bc915 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -98,6 +98,8 @@ struct evsel {
 		bool			bpf_counter;
 		bool			use_config_name;
 		bool			skippable;
+		/* any evsels with the flag set must be in a group */
+		bool            must_be_in_group;
 		int			bpf_fd;
 		struct bpf_object	*bpf_obj;
 		struct list_head	config_terms;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6f8b0fa17689..37950056a661 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2052,9 +2052,12 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 		 */
 		pos->core.idx = idx++;
 
-		/* Remember an index to sort all forced grouped events together to. */
-		if (force_grouped_idx == -1 && pos == pos_leader && pos->core.nr_members < 2 &&
-		    arch_evsel__must_be_in_group(pos))
+		/*
+		 * Remember an index to sort all forced grouped events together to,
+		 * and check each evsel for setting must_be_in_group of its leader.
+		 */
+		if (arch_evsel__must_be_in_group(pos) && force_grouped_idx == -1 &&
+			pos == pos_leader && pos->core.nr_members < 2)
 			force_grouped_idx = pos->core.idx;
 	}
 
-- 
2.40.1


