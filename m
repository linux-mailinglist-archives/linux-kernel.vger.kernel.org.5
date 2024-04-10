Return-Path: <linux-kernel+bounces-138362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6867F89F020
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CEFB23A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A08915956D;
	Wed, 10 Apr 2024 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BuAg7V5Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B813159566;
	Wed, 10 Apr 2024 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745908; cv=none; b=doARYOYi5CR8SDvb4YMpFP3MnMgqEpcepsiWw07+Tb4/72maC9Bj4YQCTg/9jBjILT9EEAijx2keTXn4ZTjSoA8yKlMcVzZQrsSAus0hj6pFVI2cWhKqv8sYhdLTapUz/FGTsYS0yEW/wlcI5fvMfX7pSGvvkn/ejDZTITtt+wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745908; c=relaxed/simple;
	bh=55Kx0QNqq2kdn87S5raCQY6gLhXmnYKjaQ+u8JeTHKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RM9yZb3EPSjh7I49tl/WeJ+NbrFGMzKxJuCm8RX0nOPqa11sHAyDDU2kPM3lljnJfCQPTVqMB13glW2sm//lpzP7FZ1If7hiBsqt6JbToY8L7oWq5u8dnZ0uPSWD0IDN+glv9LkURRKekUABdz7oy5fu54Kq1RHHYsinu7JbWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BuAg7V5Q; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712745906; x=1744281906;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=55Kx0QNqq2kdn87S5raCQY6gLhXmnYKjaQ+u8JeTHKs=;
  b=BuAg7V5QpnvAn8p9j53ML3micqYREJHhiYZqyVxciwmzyuGd6Q+3MeUk
   SozWjw+yLlvLyD6Ju2jGedi0p+Rcghy+cqsVwFunTOjF7DAYsn2qjLiez
   3GjkJtTP6ZIEGJmCeLpz4bl95UIoSa8/CCU7qLsx8qRiGmqp5DJ/KaL1G
   n0z4RYK9ycKqJZ03G66WfSM3qACcQ0Mnz1PqiCLfju5BrHtDThVtqkFch
   kEbH9m1JYSBVfCefUZMJxEiuuTJvFdfaCi0I8KIkRGUp8JYvuZZJz82qy
   J52fa0+ldDFXp8BF71bzGSnnbiqLTp4bz3uFoKBJF7w3x3CH0VexMDcOf
   Q==;
X-CSE-ConnectionGUID: w0lmgqqOSMaIMYsXTwE5rw==
X-CSE-MsgGUID: Cazz14NcS0Ozf0m9o14DTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19489167"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19489167"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:45:05 -0700
X-CSE-ConnectionGUID: RGTYuv+xQqe3eE+In6IcJw==
X-CSE-MsgGUID: ZZiWQ51/RiiN64ExWAMmnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25293793"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.214.234])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:45:04 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf tools: Simplify is_event_supported()
Date: Wed, 10 Apr 2024 13:44:50 +0300
Message-Id: <20240410104450.15602-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Simplify is_event_supported by using sys_perf_event_open() directly like
other perf API probe functions and move it into perf_api_probe.c where
other perf API probe functions reside.

A side effect is that the probed events do not appear when debug prints
are enabled, which is beneficial because otherwise they can be confused
with selected events.

This also affects "Test per-thread recording" in
"Miscellaneous Intel PT testing" which expects the debug prints of
only selected events to appear between the debug prints:
"perf record opening and mmapping events" and
"perf record done opening and mmapping events"

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/perf_api_probe.c | 40 +++++++++++++++++++++++++
 tools/perf/util/perf_api_probe.h |  2 ++
 tools/perf/util/pmus.c           |  1 +
 tools/perf/util/print-events.c   | 50 +-------------------------------
 tools/perf/util/print-events.h   |  1 -
 5 files changed, 44 insertions(+), 50 deletions(-)

diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index 1de3b69cdf4a..13acb34a4e1c 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -195,3 +195,43 @@ bool perf_can_record_cgroup(void)
 {
 	return perf_probe_api(perf_probe_cgroup);
 }
+
+bool is_event_supported(u8 type, u64 config)
+{
+	struct perf_event_attr attr = {
+		.type = type,
+		.config = config,
+		.disabled = 1,
+	};
+	int fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+
+	if (fd < 0) {
+		/*
+		 * The event may fail to open if the paranoid value
+		 * /proc/sys/kernel/perf_event_paranoid is set to 2
+		 * Re-run with exclude_kernel set; we don't do that by
+		 * default as some ARM machines do not support it.
+		 */
+		attr.exclude_kernel = 1;
+		fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+	}
+
+	if (fd < 0) {
+		/*
+		 * The event may fail to open if the PMU requires
+		 * exclude_guest to be set (e.g. as the Apple M1 PMU
+		 * requires).
+		 * Re-run with exclude_guest set; we don't do that by
+		 * default as it's equally legitimate for another PMU
+		 * driver to require that exclude_guest is clear.
+		 */
+		attr.exclude_guest = 1;
+		fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+	}
+
+	if (fd < 0)
+		return false;
+
+	close(fd);
+	return true;
+}
diff --git a/tools/perf/util/perf_api_probe.h b/tools/perf/util/perf_api_probe.h
index b104168efb15..820f6a03221a 100644
--- a/tools/perf/util/perf_api_probe.h
+++ b/tools/perf/util/perf_api_probe.h
@@ -4,6 +4,7 @@
 #define __PERF_API_PROBE_H
 
 #include <stdbool.h>
+#include <linux/types.h>
 
 bool perf_can_aux_sample(void);
 bool perf_can_comm_exec(void);
@@ -13,5 +14,6 @@ bool perf_can_record_text_poke_events(void);
 bool perf_can_sample_identifier(void);
 bool perf_can_record_build_id(void);
 bool perf_can_record_cgroup(void);
+bool is_event_supported(u8 type, u64 config);
 
 #endif // __PERF_API_PROBE_H
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 2fd369e45832..5442442e0508 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -13,6 +13,7 @@
 #include "cpumap.h"
 #include "debug.h"
 #include "evsel.h"
+#include "perf_api_probe.h"
 #include "pmus.h"
 #include "pmu.h"
 #include "print-events.h"
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 3f38c27f0157..a25be2b2c774 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -20,6 +20,7 @@
 #include "evsel.h"
 #include "metricgroup.h"
 #include "parse-events.h"
+#include "perf_api_probe.h"
 #include "pmu.h"
 #include "pmus.h"
 #include "print-events.h"
@@ -239,55 +240,6 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 	strlist__delete(sdtlist);
 }
 
-bool is_event_supported(u8 type, u64 config)
-{
-	bool ret = true;
-	struct evsel *evsel;
-	struct perf_event_attr attr = {
-		.type = type,
-		.config = config,
-		.disabled = 1,
-	};
-	struct perf_thread_map *tmap = thread_map__new_by_tid(0);
-
-	if (tmap == NULL)
-		return false;
-
-	evsel = evsel__new(&attr);
-	if (evsel) {
-		ret = evsel__open(evsel, NULL, tmap) >= 0;
-
-		if (!ret) {
-			/*
-			 * The event may fail to open if the paranoid value
-			 * /proc/sys/kernel/perf_event_paranoid is set to 2
-			 * Re-run with exclude_kernel set; we don't do that by
-			 * default as some ARM machines do not support it.
-			 */
-			evsel->core.attr.exclude_kernel = 1;
-			ret = evsel__open(evsel, NULL, tmap) >= 0;
-		}
-
-		if (!ret) {
-			/*
-			 * The event may fail to open if the PMU requires
-			 * exclude_guest to be set (e.g. as the Apple M1 PMU
-			 * requires).
-			 * Re-run with exclude_guest set; we don't do that by
-			 * default as it's equally legitimate for another PMU
-			 * driver to require that exclude_guest is clear.
-			 */
-			evsel->core.attr.exclude_guest = 1;
-			ret = evsel__open(evsel, NULL, tmap) >= 0;
-		}
-
-		evsel__delete(evsel);
-	}
-
-	perf_thread_map__put(tmap);
-	return ret;
-}
-
 int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	struct perf_pmu *pmu = NULL;
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index bf4290bef0cd..5d241b33b5a3 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -38,6 +38,5 @@ void print_symbol_events(const struct print_callbacks *print_cb, void *print_sta
 			 unsigned int max);
 void print_tool_events(const struct print_callbacks *print_cb, void *print_state);
 void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state);
-bool is_event_supported(u8 type, u64 config);
 
 #endif /* __PERF_PRINT_EVENTS_H */
-- 
2.34.1


