Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270ED7D7987
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbjJZAdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjJZAcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:32:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB04010D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a828bdcfbaso2890457b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280355; x=1698885155; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfdWwTvyDNmkXJFvpwodNNnDTxsqw7dXofnRZLFRzuI=;
        b=DQ4tt0E1p6X+hUfZjfP4Ze4sYKszXe9Yl9uNI3yoTyLf7Lw7HU0eWZnwsKWDbexfI4
         RyiKvMpo0fui7IWFa58d09TTI/7ppAPGvrFg/B8DUzP3jBU6HhFI6Wv8W0Nqtl6S6IGv
         EoQjxekmXkegoeDn5+xKSYAlQe1Lwya0cn+NpmQd0h2Qkf5w+GGjvJ/2b2oq4pbVx3Yi
         hnIpZp3OfU0FtpWpk91GC6uDNBHCUucUTTu0yGyVaBP0GpdTRHiKf5w68W+HqQgCh0aP
         odxsK7vILWz25EGxPWnvOqPpOX78hAcLv3WjwsACyeC5LvJRagzHwUEdXBJbkgf97Y/o
         q9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280355; x=1698885155;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfdWwTvyDNmkXJFvpwodNNnDTxsqw7dXofnRZLFRzuI=;
        b=MmwweMzWuLcvmyInbLgjXHR/tjVE0a0NQny1Z18C+JQzwz15S/exTlM98NSy4iQdQm
         DZI1WIV5bZ8Jw9GjosHLm7SFwQdJAs2nmu1wppKmkI7H/vW2WNOYYAL7a0/RlGzVciaq
         oY0tfaTkLXaLZybvEy9tRRZRq7+YqJjuCB2qm6pF5m44g0TIfM5y7vIihtaY+sdKMIJx
         vhNsyI0nUq9ioXQ2hpOula+KS6eRtTWBU35tquHBtNE9kKzxr/4DgJgINJHH7k8J0ctH
         j7rhoJZJjR5v0eP7ZgKE0GFG0V37o9Z1mpi28D2P6K7aiLyxqZ9PgsnDSbhSihZRuHgz
         Unwg==
X-Gm-Message-State: AOJu0YxZoDAWX17iEC8TNj3THXK4IxkmFHsVUzb12ivQ04wYaimDYzZr
        Jee8QTvUnOgUtnbJrFJ1RYjQ0EaiPU4u
X-Google-Smtp-Source: AGHT+IGj1sb54Wr0jVCSUPr2uD28COpn/QjZaVe0JG0Ns95HLoTZaNJs6O9EwxCG51xZhQm0SMnhu2BGvIJ7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a05:6902:105:b0:da0:3da9:ce08 with SMTP id
 o5-20020a056902010500b00da03da9ce08mr137176ybh.10.1698280354791; Wed, 25 Oct
 2023 17:32:34 -0700 (PDT)
Date:   Wed, 25 Oct 2023 17:31:49 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-9-irogers@google.com>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 9/9] perf vendor events intel: Update tsx_cycles_per_elision
 metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update tsx_cycles_per_elision as per:
https://github.com/intel/perfmon/pull/116

Prefer the el-start event rather than cycles-t for detecting whether
the metric will work as HLE may be disabled. Remove the metric from
sapphirerapids that has no el-start event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json | 2 +-
 tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json    | 2 +-
 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json   | 2 +-
 tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json | 2 +-
 .../pmu-events/arch/x86/sapphirerapids/spr-metrics.json    | 7 -------
 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json    | 2 +-
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json   | 2 +-
 tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json  | 2 +-
 8 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index fbb111e40829..84c132af3dfa 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -1837,7 +1837,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
diff --git a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
index a6eed0d9a26d..b43a6c6d8b7f 100644
--- a/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
@@ -1525,7 +1525,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index 7082ad5ba961..e98602c66707 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -1821,7 +1821,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json b/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
index a0191c8b708d..0c880e415669 100644
--- a/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/rocketlake/rkl-metrics.json
@@ -1551,7 +1551,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index 222212abd811..06c6d67cb76b 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -1944,13 +1944,6 @@
         "MetricName": "tsx_aborted_cycles",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
-        "MetricGroup": "transaction",
-        "MetricName": "tsx_cycles_per_elision",
-        "ScaleUnit": "1cycles / elision"
-    },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of transactions.",
         "MetricExpr": "(cycles\\-t / tx\\-start if has_event(cycles\\-t) else 0)",
diff --git a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
index 2795a404bb58..faa615c57893 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
@@ -1473,7 +1473,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index fa4209809c57..4a8f8eeb7525 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -1781,7 +1781,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
index fab084e1bc69..31738726185e 100644
--- a/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
@@ -1539,7 +1539,7 @@
     },
     {
         "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
-        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
+        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
         "MetricGroup": "transaction",
         "MetricName": "tsx_cycles_per_elision",
         "ScaleUnit": "1cycles / elision"
-- 
2.42.0.758.gaed0368e0e-goog

