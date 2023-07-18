Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0467588B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGRWsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGRWr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:47:58 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E052DA1;
        Tue, 18 Jul 2023 15:47:53 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-38c35975545so4839172b6e.1;
        Tue, 18 Jul 2023 15:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689720473; x=1692312473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R5YqH3VqKGjLLAoXXHfP8sq49ATZcVTncb1eNoNAhtA=;
        b=SGae1hx5Ep3cwgFdPAy75Mv3EV96nNYg5p5X+GUs0FZ9jcD2vL3yTAENZV/+qLhaTO
         7h75tXKjL9rNTf3Wvg6xHLiRo6V7987kBEmldd52lMhgrjIec8+26EYINE+GYiaAgIDS
         9u0xaLpFsX/GBlFsyZPyG2AIiKUXqqGyYwPYW7LgQG2RoRrK+MB4zfHRBuiuQC8WUF9v
         7YNqYQ3x0OGKbVYRvw6rhDu+1QNt448ysVd1XO5lnz2sFJRQgQWe1N7nvgvMEaTZ4Nti
         vPZBgEt45q90u9XTl3nw2pZCP/R6y86byGiltDxypFy/ZWHkU5rsT3gKbHBI+DNPfDkE
         uXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720473; x=1692312473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5YqH3VqKGjLLAoXXHfP8sq49ATZcVTncb1eNoNAhtA=;
        b=LYO+VMFOI9eT4DNeaDFQvB0bEVCeuqxyeHWgSId4BvFs8PmjoVP2i2DA4GPjqVqMm9
         GMpJ5iDyzh72fnnTycZkQ9XMzb9qe/iUPQy/Ee6Xa4qC5V7oVrCDBzKfGnxEwpOeoU3H
         PuEAtw/21mRutJKC5ngLPH8ieXtwlQyvBm7sEZELqGFf/TtDrr0YPjC12pu/btsDAlgK
         hcfbeRM/zbTJ4xM6B0xqARpS3cXNtkdI45aBFbNnyK+3lbMvV2YgmSe/874VY137PgB7
         YMRu0xPqjcdsP5c7xBKTTbkbE0qPb7JX+KtuuVUjCkM0fxkct7VSs8yf2ugkTQF+5iYD
         K1bQ==
X-Gm-Message-State: ABy/qLbM1Y7ygUh5NS9R0LxdePN3+cxSuKoAbthk+QQjGSgIa88hqIrn
        A0uYrXzUznRKR0yBoI4OjNU=
X-Google-Smtp-Source: APBJJlFgWGatezkp9nPkMa8w08ly5NtSVSXqx51EiWMl8ZUgey5YauYcJG6q8Nkal092t9zMgC/6Ag==
X-Received: by 2002:aca:bd04:0:b0:398:2f92:65ca with SMTP id n4-20020acabd04000000b003982f9265camr12531578oif.7.1689720472963;
        Tue, 18 Jul 2023 15:47:52 -0700 (PDT)
Received: from yoga ([2400:1f00:13:be68:c61a:77e0:3624:e4f6])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090a380500b0025e7f7b46c3sm86662pjb.25.2023.07.18.15.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:47:52 -0700 (PDT)
Date:   Wed, 19 Jul 2023 04:17:44 +0530
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
Subject: [PATCH v4 1/6] perf scripts python: Add initial script file with
 usage information
Message-ID: <a9c432016409db2fcebbaf7bdfdd2921cbcc5300.1689718662.git.anupnewsmail@gmail.com>
References: <cover.1689718662.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689718662.git.anupnewsmail@gmail.com>
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
also imported. Also added usage information.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
new file mode 100644
index 000000000000..63ecaf1abee8
--- /dev/null
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
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
+#     perf script firefox-gecko-converter.py > output.json
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

