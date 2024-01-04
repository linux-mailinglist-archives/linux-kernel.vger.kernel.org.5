Return-Path: <linux-kernel+bounces-16326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 521D9823CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59FB1F25048
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1741F93C;
	Thu,  4 Jan 2024 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4wlG2h1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40E200A4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 07:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe7595c204so1497547276.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 23:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704354207; x=1704959007; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NhQxpQYzclhiYM2Pyq/1LWbkNuaHqLn47SlBA52aAew=;
        b=h4wlG2h19Sk4yJzqsOnENDIF73FErjBqXIcFM5juLgTeUgC3tBxptHGE8/DgGnFvsx
         omYaqk+Xs73oCUNNGtPcbBi8ERb6ak2Ff33hDDbL+8q0iKD40tm/aCNlUZHcsLtPy1JO
         DLJtdcN6Lcm6fOCMlFo2VWtjnjWd3sb9DAEgyX270gn0O7q9Q/nYLXtjVbq3j2eOOMjR
         C7VdWGEfnS0mjosr3ctyKOnlH0JCHPoqjfrnN9MJvNWSoXwpthsOa5m8GSJ4/a+H9JeS
         GxBO3s5Kmya2u2vBwQHXX+nCsoFkoA8V18KdSFF/0aDGYlNE2quWuTsYPurVO6XxOiMp
         d7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704354207; x=1704959007;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhQxpQYzclhiYM2Pyq/1LWbkNuaHqLn47SlBA52aAew=;
        b=vFLD1m0gUyWaElLcQURbhsxjQQrYlYfedV7xIU31OE1YVBlJnzGlX2eu1Sc7jqBUb2
         nTVeA4bVpGMK2W56C2RVGk9Ybu06gzLUNHt/vQocB8mAuqTwyXOW4lO8Op5m3XZD9vCE
         qW+XMnH2rPcUyrKBeXnNwf7hvrSgiE2+nM3HhVYWVFBL3HAuYqf1r4cbcqX9SiwB4I/1
         WekImVqUCQ/SKZ/J25nsJZysfzCWsd4hkjwCkEAIq6pqNsB+Xtsm8CuIGSk0dmUabt6e
         Q8cXfynhJ45IWz7QFIQSVuPnvYtle0Yq9hzDFm0451uU0UVuC6CcqdAWoCjD90STB+XO
         XFug==
X-Gm-Message-State: AOJu0YyfRiuqOWlYu1mheO+Wk9FX3bywGsdtCvrLwgkrS4u/PwmMi9rH
	shwv2XZ2ZAUOEmTXTv3Z0wlN+NZbdpt9vbdlB6w=
X-Google-Smtp-Source: AGHT+IEQBXdm9jx7fSwymZBRJH79KgcITd3ZiwhUpruXJruz8V6yFBJNrybFJb2MQAFxOIpSXX061JeapM/g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f607:7105:a86e:433f])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c1:b0:dbd:b613:46a9 with SMTP
 id w1-20020a05690210c100b00dbdb61346a9mr35905ybu.5.1704354207779; Wed, 03 Jan
 2024 23:43:27 -0800 (PST)
Date: Wed,  3 Jan 2024 23:42:56 -0800
Message-Id: <20240104074259.653219-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v1 1/4] perf vendor events intel: Alderlake/rocketlake metric fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix that the core PMU is being specified for 2 uncore events. Specify
a PMU for the alderlake UNCORE_FREQ metric.

Conversion script updated in:
https://github.com/intel/perfmon/pull/126

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/lkml/ZZWOdHXJJ_oecWwm@kernel.org/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/adl-metrics.json           | 15 ++++++++-------
 .../arch/x86/rocketlake/rkl-metrics.json          |  2 +-
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index 3388b58b8f1a..35124a4ddcb2 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -69,12 +69,6 @@
         "MetricName": "C9_Pkg_Residency",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "Uncore frequency per die [GHZ]",
-        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duration_time / 1e9",
-        "MetricGroup": "SoC",
-        "MetricName": "UNCORE_FREQ"
-    },
     {
         "BriefDescription": "Percentage of cycles spent in System Management Interrupts.",
         "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0 else 0)",
@@ -809,6 +803,13 @@
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duration_time / 1e9",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This metric represents Core fraction of cycles CPU dispatched uops on execution ports for ALU operations.",
         "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ + cpu_core@UOPS_DISPATCHED.PORT_1@ + cpu_core@UOPS_DISPATCHED.PORT_5_11@ + cpu_core@UOPS_DISPATCHED.PORT_6@) / (5 * tma_info_core_core_clks)",
@@ -1838,7 +1839,7 @@
     },
     {
         "BriefDescription": "Average number of parallel data read requests to external memory",
-        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / cpu_core@UNC_ARB_DAT_OCCUPANCY.RD\\,cmask\\=1@",
+        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / UNC_ARB_DAT_OCCUPANCY.RD@cmask\\=1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
         "PublicDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json b/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
index 0c880e415669..27433fc15ede 100644
--- a/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
@@ -985,7 +985,7 @@
     },
     {
         "BriefDescription": "Average number of parallel data read requests to external memory",
-        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / cpu@UNC_ARB_DAT_OCCUPANCY.RD\\,cmask\\=1@",
+        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / UNC_ARB_DAT_OCCUPANCY.RD@cmask\\=1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
         "PublicDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches"
-- 
2.43.0.472.g3155946c3a-goog


