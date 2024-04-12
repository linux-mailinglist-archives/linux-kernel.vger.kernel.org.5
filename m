Return-Path: <linux-kernel+bounces-143365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAAB8A3799
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48D3BB253B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5B3153813;
	Fri, 12 Apr 2024 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9JR3dqg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B965152E0F;
	Fri, 12 Apr 2024 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956099; cv=none; b=CR7Ap3jCtrlDq6TvsUdvvEJ+HTcDCCGGPyPnvMS0XRgcB30G211X74CJKhHSMrW4VsYzs+fchHKo/o41ij2DmOO4gD7eN3BFfIQXaUjUfbdKQ15ccYBUbn/FB/vGbAtvGtlzl4BshG0ncFTuXdXPNL1CCH4/auX4u0qmuVygTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956099; c=relaxed/simple;
	bh=SLRT/YXI45DriY5Ez7bnNSFDk+ZX/MfZJIlKThgJlpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STs532n8rtLNapoRpwnbAWvSvEVBlj8ksMbFlR2qdlO6yUbqLECBI4f/PeYbon0x0gYlQhsi00PQq6vjgaVd6JupSaDVoewlhVU/iW+kWlhwajxaUGmTBHsdsQHECBxyNAdIBmPAr7N+6u+TNfi5FQPRRJT+Cuq15+vIe37xzjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9JR3dqg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956098; x=1744492098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SLRT/YXI45DriY5Ez7bnNSFDk+ZX/MfZJIlKThgJlpo=;
  b=S9JR3dqgFcs1uLSZHjEky6YDOKt5GjzkFyghurYh9ees58qjKM4zo2kO
   cfcHvB+4NIXLwboXP1n36YE0qCshFtaI4Z431rW6g6hMAXmEUnttq6sDt
   yDDzdCNz9j4FTCJ2akk9Sev46k8hVD9qxrDXjgViy96Alj6U6dAsMouci
   /SskbRmmxdhyvTbofya6Zv64QusWGcOJVxiMxettAdzqeyQ9DAqKpsAcE
   guR66npLcz/YIkxz8r9od7NkEsy21hwbetzNm8tzw3cgXHK5Tr7J6gQhP
   iAFVP/P2laY4FNa9doWjnunAGqvjmmuMOGbA//paaHDrCMPIaXSgpAHVS
   g==;
X-CSE-ConnectionGUID: j83IAigkQAyJXzlZfgLi7Q==
X-CSE-MsgGUID: WP9QZJH3T7uZ8A5pBmfOiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575488"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575488"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:11 -0700
X-CSE-ConnectionGUID: sqyXSFLWTg+rLmERYp2xNg==
X-CSE-MsgGUID: F1OduXFwQFO6CrRLWdmANw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772114"
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
Subject: [RFC PATCH v5 12/16] perf stat: Handle NMI in hardware-grouping
Date: Fri, 12 Apr 2024 14:07:52 -0700
Message-ID: <20240412210756.309828-13-weilin.wang@intel.com>
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

Add an easy nmi watchdog support in grouping. When nmi watchdog is enabled,
we reduce the total num of events could be assigned to one group by 1. A
more efficient solution will be added in later.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 9548654c9f6d..31036035484c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1993,6 +1993,10 @@ static int insert_new_group(struct list_head *head,
 			   size_t counters_num_fixed)
 {
 	INIT_LIST_HEAD(&new_group->event_head);
+	if (sysctl__nmi_watchdog_enabled()) {
+		pr_debug("NMI watchdog is enabled. Reduce num of counters by 1\n");
+		counters_num_gp -= 1;
+	}
 	fill_counter_bitmap(new_group->gp_counters, 0, counters_num_gp);
 	fill_counter_bitmap(new_group->fixed_counters, 0, counters_num_fixed);
 	list_add_tail(&new_group->nd, head);
-- 
2.42.0


