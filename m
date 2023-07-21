Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D552275D0F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjGURwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGURwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:52:37 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ABE3586;
        Fri, 21 Jul 2023 10:52:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-668709767b1so1570234b3a.2;
        Fri, 21 Jul 2023 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689961956; x=1690566756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIWTPg91sCg5EQFT4pLbsMmSxH/5LnBec+qLbL/rIOI=;
        b=GAL8WUrDbkrFBZ5AerXBFNk3kRpjC+2ID9l8TPMmPEzPyjX96N11mkjCmnjr7y5Anl
         mk+Gdx0xCxRuhi0GXaNFq36Ww1tcB9kzEZ6xO5J9AbkKyndhUOAEpVT1ocZcgJTTTWHm
         7Yu/DBy5t5o1+f1DJkDZW/8jnVE8FP3MFaLkGnF1lKeFWYxhverbzS0LCvX8x0hA+emL
         Xa9zsl/PRRZCBxDgvJ70ZwS1qahP1zF0j9JpaTkrlD5W8Rsh81wGEHNN30OunKnk8pPz
         JS+TuBY8pGVxphnIBYunqUVQkuY3Niqs8X2Zh2Q6R7eHYMtQFA2FcueJ4BBRyYmA83jt
         PhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689961956; x=1690566756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIWTPg91sCg5EQFT4pLbsMmSxH/5LnBec+qLbL/rIOI=;
        b=LWJ9rojwkR/XFH9v3/6079urzyBNMLLvD18WGb8DTcDXthQZPQ5+roE3kxHz5CvBts
         8KDfHlpXtko2ngvaejXgcv658susronj8J5/x1zgpFLpZVSLdr3kLfCMUO0K8KDic5dG
         Kl4z6nyfu5ePBXEDvj6y6WPMyzYyXxCbFAWuvjMRzoO0DQ6Kudv1hEAX7tioclu2Z1nE
         f7GvvGPrPK5gZU1U8tD+EncCSd3ORJt64HClyHKe5YiPFabkoTH73APJVTxhLrwPfY/w
         3Fn46aDsITRoHJQK57WGKwmIZu9BPtz54DQqS3l0BddrOoFjTLcofNeNxljTpkM4M5rs
         ffAA==
X-Gm-Message-State: ABy/qLYi6Q/m1ndiFeaz5bG4LgZ/MjaTQk+ZTGtkySpFXrk3EumJT0ej
        i7j6yQWrcasIo7QxolCZmqQ=
X-Google-Smtp-Source: APBJJlGLgqKyhKjGqE+g/9+ojyQQvvD7hCdKHxWTeNt1UyLjV7Ub0utLfhrMoT7yDWMaIAsNdJO1sg==
X-Received: by 2002:a05:6a20:1589:b0:12d:d615:9279 with SMTP id h9-20020a056a20158900b0012dd6159279mr2657490pzj.25.1689961955711;
        Fri, 21 Jul 2023 10:52:35 -0700 (PDT)
Received: from yoga ([2400:1f00:13:cde2:d588:8109:e86b:839c])
        by smtp.gmail.com with ESMTPSA id x18-20020a056a00271200b00671aa6b4962sm3242378pfv.114.2023.07.21.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:52:35 -0700 (PDT)
Date:   Fri, 21 Jul 2023 23:22:28 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] perf scripts python: Add initial script file with
 usage information
Message-ID: <f2f1a62f1cc69f44a5414da46a26a4cf124d2744.1689961706.git.anupnewsmail@gmail.com>
References: <cover.1689961706.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689961706.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added necessary modules, including the Perf-Trace-Util
library, and defines the required functions and variables
for using perf script python. The perf_trace_context and
Core modules for tracing and processing events has been
also imported. Added usage information.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/scripts/python/perf-gecko.py | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/perf/scripts/python/perf-gecko.py

diff --git a/tools/perf/scripts/python/perf-gecko.py b/tools/perf/scripts/python/perf-gecko.py
new file mode 100644
index 000000000000..4e651adb6395
--- /dev/null
+++ b/tools/perf/scripts/python/perf-gecko.py
@@ -0,0 +1,31 @@
+# firefox-gecko-converter.py - Convert perf record output to Firefox's gecko profile format
+# SPDX-License-Identifier: GPL-2.0
+#
+# The script converts perf.data to Gecko Profile Format,
+# which can be read by https://profiler.firefox.com/.
+#
+# Usage:
+#
+#     perf record -a -g -F 99 sleep 60
+#     perf script report perf-gecko > output.json
+
+import os
+import sys
+from typing import Dict
+
+# Add the Perf-Trace-Util library to the Python path
+sys.path.append(os.environ['PERF_EXEC_PATH'] + \
+	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+
+from perf_trace_context import *
+from Core import *
+
+# Uses perf script python interface to parse each
+# event and store the data in the thread builder.
+def process_event(param_dict: Dict) -> None:
+	pass
+
+# Trace_end runs at the end and will be used to aggregate
+# the data into the final json object and print it out to stdout.
+def trace_end() -> None:
+	pass
-- 
2.34.1

