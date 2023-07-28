Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017E17661C4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjG1CZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjG1CZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:25:03 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95930DC;
        Thu, 27 Jul 2023 19:24:57 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-78847bb8940so68497539f.0;
        Thu, 27 Jul 2023 19:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690511097; x=1691115897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qde5oqHOAvsDSREhKG9It0ouCEwVKT5mPlK+bDyfn8=;
        b=UkixTDoY7LOV17oa9nRZhZAQaN2Mj+2yTSttLogXFgCMFPM9B5TBsPHse2aoZ33Ode
         xYrl26hQZQ1+kTEVHKTh8uweBic+vNFuELyC07uDGSPXNddhvxAKLtcYmHtL7begeeXc
         6cvN7hxxx1EUOEN/ziwSi2+yUkTs4EufWFmT+XqvksNatla9NJCK0qJDIFa6tvU4hoSr
         G1MMOQ6wwsPUifF8YNPoDSWAQjujyOVnBXH1paGDHnjNwkNpcjJxeH+dFidwcAYpq0tU
         jCSfRQtCwzAS5DldFHdhWfiu5dfX6LFymiJgnpfG77fW3/MSbxxR4B9CJYXSX65fiU/B
         qj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690511097; x=1691115897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3qde5oqHOAvsDSREhKG9It0ouCEwVKT5mPlK+bDyfn8=;
        b=No43+/o9ZgMIb6gkILBnxROG3+b2LqLQDO+5VqLjyf9QTmNErG2QEycOjcBm9LQJN/
         vhKK4F4j0ykhWCsy6YKoremtKBQlZSgNEs1+4ZHDGXCmiFnhaJASGkM8kB8jxSJ99/uG
         UubbrVPDKYriHWmBYc7IJHVNsFHiKOXBaqTep+FBPxYIlpl+D8xnnoYUXKnZhhcSjO8J
         qwnUrfMgi8vJWmugYLfpKCzyE2cbebeGwWqOcMBhCMkF1LlJWbMXGiFV7bbfMLEFgOhI
         Mxoa2uC6D+dZ2H8vggq3mfLLYG1+Haoi+H2GPJllLxRRtJO9ekwB3eewH64nhuGc/A3n
         Cd+g==
X-Gm-Message-State: ABy/qLb03OYNgR/yUqO2bmrv7/13dSf2S+ccxrvAOCUf9mprw++z0kkN
        OkmAAFzx3weY7uvWAg5cwy4=
X-Google-Smtp-Source: APBJJlF6t68jjR7oPSohtE8LKCrzR5k41/zGO4rIXzlObMnzhYO/Huq9UTUwM+T5ScYQqZozzckmCw==
X-Received: by 2002:a05:6e02:128f:b0:343:c8b1:b7f0 with SMTP id y15-20020a056e02128f00b00343c8b1b7f0mr1280054ilq.23.1690511097076;
        Thu, 27 Jul 2023 19:24:57 -0700 (PDT)
Received: from bangji.roam.corp.google.com ([101.235.25.38])
        by smtp.gmail.com with ESMTPSA id gz24-20020a17090b0ed800b002677739860fsm1696204pjb.34.2023.07.27.19.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 19:24:56 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/2] perf build: Include generated header files properly
Date:   Thu, 27 Jul 2023 19:24:47 -0700
Message-ID: <20230728022447.1323563-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230728022447.1323563-1-namhyung@kernel.org>
References: <20230728022447.1323563-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flex and bison generate header files from the source.  When user
specified a build directory with O= option, it'd generate files under
the directory.  The build command has -I option to specify the header
include directory.

But the -I option only affects the files included like <...>.  Let's
change the flex and bison headers to use it instead of "...".

Fixes: 80eeb67fe577 ("perf jevents: Program to convert JSON file")
Cc: stable@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 tools/perf/util/bpf-filter.c     | 4 ++--
 tools/perf/util/expr.c           | 4 ++--
 tools/perf/util/parse-events.c   | 4 ++--
 tools/perf/util/pmu.c            | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 12e80bb7939b..82c42c46d886 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -999,7 +999,7 @@ such as "arm/cortex-a34".''',
   _args = ap.parse_args()
 
   _args.output_file.write("""
-#include "pmu-events/pmu-events.h"
+#include <pmu-events/pmu-events.h>
 #include "util/header.h"
 #include "util/pmu.h"
 #include <string.h>
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 0b30688d78a7..47f01df658d9 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -9,8 +9,8 @@
 #include "util/evsel.h"
 
 #include "util/bpf-filter.h"
-#include "util/bpf-filter-flex.h"
-#include "util/bpf-filter-bison.h"
+#include <util/bpf-filter-flex.h>
+#include <util/bpf-filter-bison.h>
 
 #include "bpf_skel/sample-filter.h"
 #include "bpf_skel/sample_filter.skel.h"
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 4814262e3805..7410a165f68b 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -10,8 +10,8 @@
 #include "debug.h"
 #include "evlist.h"
 #include "expr.h"
-#include "expr-bison.h"
-#include "expr-flex.h"
+#include <util/expr-bison.h>
+#include <util/expr-flex.h>
 #include "util/hashmap.h"
 #include "smt.h"
 #include "tsc.h"
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index acde097e327c..f3773467c103 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -18,8 +18,8 @@
 #include "debug.h"
 #include <api/fs/tracing_path.h>
 #include <perf/cpumap.h>
-#include "parse-events-bison.h"
-#include "parse-events-flex.h"
+#include <util/parse-events-bison.h>
+#include <util/parse-events-flex.h>
 #include "pmu.h"
 #include "pmus.h"
 #include "asm/bug.h"
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7f984a7f16ca..b6654b9f55d2 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -19,8 +19,8 @@
 #include "evsel.h"
 #include "pmu.h"
 #include "pmus.h"
-#include "pmu-bison.h"
-#include "pmu-flex.h"
+#include <util/pmu-bison.h>
+#include <util/pmu-flex.h>
 #include "parse-events.h"
 #include "print-events.h"
 #include "header.h"
-- 
2.41.0.487.g6d72f3e995-goog

