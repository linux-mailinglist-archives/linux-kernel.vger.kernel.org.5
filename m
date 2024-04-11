Return-Path: <linux-kernel+bounces-140037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFAF8A0AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34901F22788
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BFE13E89B;
	Thu, 11 Apr 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tba2M57U"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DCF13F004;
	Thu, 11 Apr 2024 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822103; cv=none; b=k28/OHdffeskAdizXnLCL8PBKUnvppx/D2yw9t0W4aW1FdfdOlQp9kFvPxuFrhtadFuo6zROidTK77fPcsSeExtx5j13IQ0J2ElbaRMURC5IfBHXTMuQk62AcV4/Or+2zBn0yb8kMnvajbs8eC5UNL8xYe9m1k+bj0yB+SVgIjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822103; c=relaxed/simple;
	bh=7XNPCE1QAecYi2d0fQeHgXjGFDdBHRi4Kh503m2wRVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H54CLYPBqjz8Hyogg+qqZlMdbv/iYISMCCPCbmT8DT7q6ujtLNuGe7c9rpRZTK8MPvXjGTjWjxVxgPfwFStujeNBjinWvcSCub4l8IstH9Ni2WtemPCpLOAEjSBsqvIrfOXoFjhXgn3ehW53zw+BxY5n+KzTT7y2M/lMFPaU+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tba2M57U; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712822101; x=1744358101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7XNPCE1QAecYi2d0fQeHgXjGFDdBHRi4Kh503m2wRVE=;
  b=Tba2M57UdN9HEGC0e/QK8VS/yVH+E/N92buToZC8iQkRsJOAD52xZAwB
   PadC7tZyzSzeYgsVzHcYOqeqj3aV5smEtoFVDJh0RIunhF0KMSc4joQNF
   m9BMv0CDV4oZoZrpaaE0eLGzQT6IPCfeb1lHpGqrhjbtav41n3B7YUb2z
   E6HKG+/ayaWTxwgHikqSVap1yhoKsdMnmYYQMjm28hm9wyyThm4dV4fkt
   bMnvt1F3aSVMF8QrnI8hlh/kh4d/Yj5LzKY3bKIAWVpe/P2/HnruYgfiT
   yU//HIL7pkD+1ma+zzmyzby+C660W22pXl71CfTqM+cqHE/xn6rTpPqG0
   w==;
X-CSE-ConnectionGUID: haMzRHHDTQSoRCAklFfXQQ==
X-CSE-MsgGUID: TWcKA086RQmBsMxDUg8uPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8394427"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8394427"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 00:55:00 -0700
X-CSE-ConnectionGUID: KvR6xT1sQKe8ffZSQzsZzA==
X-CSE-MsgGUID: k1C1uYcGRiW21t70Wlj31w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="51800365"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.215.66])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 00:54:58 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf record: Fix debug message placement for test consumption
Date: Thu, 11 Apr 2024 10:54:47 +0300
Message-Id: <20240411075447.17306-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

evlist__config() might mess up the debug output consumed by test
"Test per-thread recording" in "Miscellaneous Intel PT testing".
Move it out from between the debug prints:
"perf record opening and mmapping events" and
"perf record done opening and mmapping events"

Fixes: da4062021e0e ("perf tools: Add debug messages and comments for testing")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/ZhVfc5jYLarnGzKa@x1/
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 40d2c1c48666..6aeae398ec28 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1355,8 +1355,6 @@ static int record__open(struct record *rec)
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
 
-	evlist__config(evlist, opts, &callchain_param);
-
 	evlist__for_each_entry(evlist, pos) {
 try_again:
 		if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
@@ -2483,6 +2481,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	evlist__uniquify_name(rec->evlist);
 
+	evlist__config(rec->evlist, opts, &callchain_param);
+
 	/* Debug message used by test scripts */
 	pr_debug3("perf record opening and mmapping events\n");
 	if (record__open(rec) != 0) {
-- 
2.34.1


