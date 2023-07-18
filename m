Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290A97588B9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjGRWur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjGRWup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:50:45 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF7110A;
        Tue, 18 Jul 2023 15:50:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8ad907ba4so37168925ad.0;
        Tue, 18 Jul 2023 15:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689720616; x=1692312616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=80aRBWvaVaWLuW8nDpBJWXcRLl3VPc3POw1KKbLSEx4=;
        b=B2t7nteaMvgwOtKhySgmdV3tsVDETsWZoJAbzd16487TXUVnftXjvzq/BadVWL4cjB
         emH8NGSmC2fBAidHjs7T9I19ohQXTNEfPxvM6fQSFNTqRuHDJ0clV9fBeAiV0eTdb4ff
         o1g6zg1z4VEndA5Ko8G3os6TgzzhP5482DI/cQebTX+kQPDFToS9MIRm4pSNwbWDpPTe
         qsfQD/U20QVnlJUxYE0i/2l5UutIzilga1uKBFwitrmYJ1NZtwmL0OfFlcS9Cuuf2DQc
         c+NFZ8diSixknyzgOAC9f1qK5n6NxQk7hCXcGALt2mLTKpDSrFI5FBmxiOrixyBKNfm0
         r6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720616; x=1692312616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80aRBWvaVaWLuW8nDpBJWXcRLl3VPc3POw1KKbLSEx4=;
        b=kJSRP/nzIhKS9DXeVmVpWh6yVu2hh6mwyyFbvhBU6bYNUV+rFsp531rHqfYLhzrumg
         ZQWOZPZen6KoQU9xOixqrNed9hQmiQRWjuek04iiiUM9XEzk5/pe3G5PfXAg43FOQGBB
         ZUxrm1hbnb1Ch3LvvwVa3V76cf0nBSTylEgw1wNKjfRw88A6TK9HNscimf2Vu0vzPHCZ
         fL8XgZkhlOxZC24+4eyW3R76Gm2Hc8dxCH4XSyg6uakUXNB5bskrhmzorYONfgthdqpl
         OwV+9Rday6ualcI/uj3C5CfmO27DdPjBPjlGmcvK3J+zAnhpxNG8zVnGLYtSr8LiTBsL
         eYAQ==
X-Gm-Message-State: ABy/qLYGgSkj4d6TeNOi5aXYmlyY0dNcqv3o6l/wi/avn2EcbLlZMdnf
        jlesq3QPXm/puTwajd1FEss=
X-Google-Smtp-Source: APBJJlG29XKMrtZlXN8ZhQ+TIxumqEBXKXA2mzs6U+FOca1FaZtq+TNQ7K/FRaNaVqcMbdtYLicSMw==
X-Received: by 2002:a17:902:e744:b0:1b6:7f96:42ca with SMTP id p4-20020a170902e74400b001b67f9642camr15791921plf.66.1689720615804;
        Tue, 18 Jul 2023 15:50:15 -0700 (PDT)
Received: from yoga ([2400:1f00:13:be68:c61a:77e0:3624:e4f6])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902b08800b001b9ff5aa2e7sm2372950plr.239.2023.07.18.15.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:50:15 -0700 (PDT)
Date:   Wed, 19 Jul 2023 04:20:08 +0530
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
Subject: [PATCH v4 4/6] perf scripts python: Add trace end processing and
 PRODUCT and CATEGORIES information
Message-ID: <662239f70618982ef659362ae5729422f318db66.1689718662.git.anupnewsmail@gmail.com>
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

The final output will now be presented in JSON format following the Gecko
profile structure. Additionally, the inclusion of PRODUCT allows easy retrieval
of header information for UI.

Furthermore, CATEGORIES have been introduced to enable customization of
kernel and user colors using input arguments. To facilitate this functionality,
an argparse-based parser has been implemented.

Note that the implementation of threads will be addressed in subsequent commits."

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 64 ++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index d9b1ec18997a..a0218e2245f2 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
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
@@ -172,4 +181,57 @@ def process_event(param_dict: Dict) -> None:
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
+		"threads": threads,
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

