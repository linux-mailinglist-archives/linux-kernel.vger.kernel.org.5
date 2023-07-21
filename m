Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC675D0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGURy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjGURyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:54:52 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A31830FF;
        Fri, 21 Jul 2023 10:54:51 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-668709767b1so1571615b3a.2;
        Fri, 21 Jul 2023 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689962090; x=1690566890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TdUwpQJ1fvo9wPeoyUZd+h9p9WkVUECzr/4+DTfg2fw=;
        b=VDgiEFHaTR5MW0qHo4qC1ZF0ezbF2MZGTNjeR8I4GfcR6lyDLyZwyLlgUgoeA7rmlI
         NMNDx79Jk7TCZr6jSE9otVvuxm+7Gb+Yx0GzR4h8s8cb40c3qrFb8f9wiXn9zZ7IAMmE
         BQDdlV1zIV5yD0iRQns/mdQGYxK0jCkud7EiBZHMsLXT/6rCjzWSYc8aPJBDslwzpRyC
         IfY0DNd6rlO7MEhyVbxSe2H9L3WDnlvb9EZo7uqMUwDPCVXVi7CaADAQu8Z2kh6r+1Yq
         5HX+GF4vmbWcFAKRq5hvQ/desu1iJHEXTTXd/gpfbyZazuHupFj7LCXwqtl6BXpEyA4U
         aIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689962090; x=1690566890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdUwpQJ1fvo9wPeoyUZd+h9p9WkVUECzr/4+DTfg2fw=;
        b=juvSKB9OAXMBv5X+WSkV+9BY9+Pbq1+7xJ0L6id4kL76jXVe46m4MkR8+NrclYEs7o
         o+nyVoWsr1Qc2FOh1defQGnLqG7seT41eFt2UAPlR46vfweiSJSJ2Y7svXgjyTUoWyH/
         OZiLCupViwmM74b+qnhLA3fq9ffSJ7cOQ3GlAslGEIDplB9AKmZpUEJaVinfORovCAVw
         jaPvp5tiAxPuZ/TszfGZuq5enOwRGY+nrOgkt/eWvMXoFMq2eEEqPAR9a4L9miwhfTWj
         jU9+SPcvHG/xgLQTJH5G0i6fAEHVziqbRl+MUWJtDQjQUf8ZDqWFcNC2srg46q4FPoOb
         4E0w==
X-Gm-Message-State: ABy/qLZ+oIbbeHJ6CCm5wympzWFEw8OKviCx8H031z8lIST3+hLI3069
        4G31afFye91A8UlU1EK3/4xHY0DhSVRHDeli
X-Google-Smtp-Source: APBJJlHTmZUbhRZL76BtwS1Q89aM7HW+TQqebtkN7UOVLUbOYu33fR3frbkTyxy0qwVP91U5wTBweA==
X-Received: by 2002:a05:6a00:1381:b0:67f:48a2:5d9f with SMTP id t1-20020a056a00138100b0067f48a25d9fmr893357pfg.11.1689962090393;
        Fri, 21 Jul 2023 10:54:50 -0700 (PDT)
Received: from yoga ([2400:1f00:13:cde2:d588:8109:e86b:839c])
        by smtp.gmail.com with ESMTPSA id ff5-20020a056a002f4500b0067ea048cf83sm3230191pfb.186.2023.07.21.10.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:54:50 -0700 (PDT)
Date:   Fri, 21 Jul 2023 23:24:42 +0530
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
Subject: [PATCH v5 4/8] perf scripts python: Add trace end processing and
 PRODUCT and CATEGORIES information
Message-ID: <fa6d027e4134c48e8a2ea45dd8f6b21e6a3418e4.1689961706.git.anupnewsmail@gmail.com>
References: <cover.1689961706.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689961706.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final output will now be presented in JSON format following the Gecko
profile structure. Additionally, the inclusion of PRODUCT allows easy retrieval
of header information for UI.

Furthermore, CATEGORIES have been introduced to enable customization of
kernel and user colors using input arguments. To facilitate this functionality,
an argparse-based parser has been implemented.

Note: The implementation of threads will be addressed in subsequent commits
for now I have commented it out.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/scripts/python/perf-gecko.py | 65 ++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/perf-gecko.py b/tools/perf/scripts/python/perf-gecko.py
index 71e2b042e695..f0d29f48467e 100644
--- a/tools/perf/scripts/python/perf-gecko.py
+++ b/tools/perf/scripts/python/perf-gecko.py
@@ -11,6 +11,8 @@
 
 import os
 import sys
+import json
+import argparse
 from dataclasses import dataclass, field
 from typing import List, Dict, Optional, NamedTuple, Set, Tuple, Any
 
@@ -30,6 +32,13 @@ Milliseconds = float
 # start_time is intialiazed only once for the all event traces.
 start_time = None
 
+# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/profile.js#L425
+# Follow Brendan Gregg's Flamegraph convention: orange for kernel and yellow for user space by default.
+CATEGORIES = None
+
+# The product name is used by the profiler UI to show the Operating system and Processor.
+PRODUCT = os.popen('uname -op').read().strip()
+
 # https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L156
 class Frame(NamedTuple):
 	string_id: StringID
@@ -171,4 +180,58 @@ def process_event(param_dict: Dict) -> None:
 # Trace_end runs at the end and will be used to aggregate
 # the data into the final json object and print it out to stdout.
 def trace_end() -> None:
-	pass
+	# Schema: https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L305
+	gecko_profile_with_meta = {
+		"meta": {
+			"interval": 1,
+			"processType": 0,
+			"product": PRODUCT,
+			"stackwalk": 1,
+			"debug": 0,
+			"gcpoison": 0,
+			"asyncstack": 1,
+			"startTime": start_time,
+			"shutdownTime": None,
+			"version": 24,
+			"presymbolicated": True,
+			"categories": CATEGORIES,
+			"markerSchema": [],
+			},
+		"libs": [],
+		# threads will be implemented in later commits.
+		# "threads": threads,
+		"processes": [],
+		"pausedRanges": [],
+	}
+	json.dump(gecko_profile_with_meta, sys.stdout, indent=2)
+
+def main() -> None:
+	global CATEGORIES
+	parser = argparse.ArgumentParser(description="Convert perf.data to Firefox\'s Gecko Profile format")
+
+	# Add the command-line options
+	# Colors must be defined according to this:
+	# https://github.com/firefox-devtools/profiler/blob/50124adbfa488adba6e2674a8f2618cf34b59cd2/res/css/categories.css
+	parser.add_argument('--user-color', default='yellow', help='Color for the User category')
+	parser.add_argument('--kernel-color', default='orange', help='Color for the Kernel category')
+	# Parse the command-line arguments
+	args = parser.parse_args()
+	# Access the values provided by the user
+	user_color = args.user_color
+	kernel_color = args.kernel_color
+
+	CATEGORIES = [
+		{
+			"name": 'User',
+			"color": user_color,
+			"subcategories": ['Other']
+		},
+		{
+			"name": 'Kernel',
+			"color": kernel_color,
+			"subcategories": ['Other']
+		},
+	]
+
+if __name__ == '__main__':
+    main()
-- 
2.34.1

