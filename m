Return-Path: <linux-kernel+bounces-143369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526368A37A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097251F21DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22DE154450;
	Fri, 12 Apr 2024 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsdAPOMw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEB4153800;
	Fri, 12 Apr 2024 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956101; cv=none; b=fvoi/ZynIMuRoDEI7X0VqmYij9ArSqYFaJ/v3BkGGUCIwoqEDMNb5Aor/w3jKgqeU9goMFYECcp4bbD7mX2SxNS7eO18QVPlnSKz2DMZQTt8Q2dDzbh636inXd6b44G1l+TAMjdALYeBWgXzMlkTNAHzRwVSh6yJq8qOh/oGyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956101; c=relaxed/simple;
	bh=bd4PQWlSFr0I9pEM8FxSoW1pVNhaL0iIOylEleDEVQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAm2evZxmqlStTpTJo8z2nmu5iVyGhDVwLdpgKB7/ghyWvYEfu9YrvzS/BXAY70PKhZObgnMh44Q6kRm3H/bfuXpPUS7roJ7g/Um5dHAs+tdORgw7m8QmjVl9sydopuYVVLggCQ8T1FOGRuHFuo3IZ/djTWzg0cQJywZrm8Anck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsdAPOMw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712956100; x=1744492100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bd4PQWlSFr0I9pEM8FxSoW1pVNhaL0iIOylEleDEVQU=;
  b=LsdAPOMwlG2FqUnspiBDu4qmStxwqYSF64I7icUgMDznGS03DVfCCb+J
   DSY3AwbWJhUr7w041ozjuKWUiYJpIlvKA7kY1/M4d6bnxRrlBZJOntf25
   UwzZHS9E6LDCtjDyuWAG1BDPfbqZ6R/xh3xS0wLh0n8TptyIjaiFIKl03
   U6qZfizK60M5Euf1flJg9SJssKPzPmosOiMPpSlKcQQYOcUc0MliKL0fP
   n4Lwuie5fGjXfxdQ5LiXqn+i1QFiO4vDTt2Q56GmXcfMJzqYMvRahFGIr
   a6Flbm+nt2oYWsNQFRQZMBOHYmndsi9RpLPWiBo1isk0re/sTKa6Ti2Ta
   Q==;
X-CSE-ConnectionGUID: Ixi9ogX3Tbeprexk6qypeA==
X-CSE-MsgGUID: ZJjArDDrQWeJqsvVbXcEvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="19575508"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="19575508"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 14:08:12 -0700
X-CSE-ConnectionGUID: vZJWBqgWQ8yT8B2mIDpbHA==
X-CSE-MsgGUID: dnWJWx1SSaqJwNi2OhIeqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="21772126"
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
Subject: [RFC PATCH v5 16/16] perf stat: Add hardware-grouping cmd option to perf stat
Date: Fri, 12 Apr 2024 14:07:56 -0700
Message-ID: <20240412210756.309828-17-weilin.wang@intel.com>
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

Add a cmd option to allow user to choose this new metric grouping method.

$ perf stat -M TopdownL1 -a --hardware-grouping

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c4a5f0984295..8c33e3f8bc80 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1259,6 +1259,8 @@ static struct option stat_options[] = {
 		       "don't try to share events between metrics in a group"),
 	OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_threshold,
 		       "disable adding events for the metric threshold calculation"),
+	OPT_BOOLEAN(0, "hardware-grouping", &stat_config.hardware_aware_grouping,
+				"Use hardware aware metric grouping method"),
 	OPT_BOOLEAN(0, "topdown", &topdown_run,
 			"measure top-down statistics"),
 	OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
-- 
2.42.0


