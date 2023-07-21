Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258BC75D0F3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGURxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjGURx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:53:28 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7792830FF;
        Fri, 21 Jul 2023 10:53:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68336d06620so1924856b3a.1;
        Fri, 21 Jul 2023 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689962007; x=1690566807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zdmHVEOZnx9XkZhHfTLEdLkTSGQEKCcj987Y0mRU5GU=;
        b=HC7nGhxL3EmXoXAdJXuBBcaA0qGN2ZxhF6YPAO0MwAsKSgJbLKmYWLIawxOeBIAdZl
         A3fpVkxLPRjL077cHZoL+FvNzDIvWFsYN+qqUcEB4+N7jLOxOFn9sngWGuPegPXMdU7Q
         Ve7pBoy0ZlNmfmHwuHQZYQ18w2U5GSQhkjNp9em31PMKE++uWPYBIo7Iv8tsSIAEnXRS
         PQl7pJ+vjMZKKnBY3Wq6YqDEEBbwVAqD95DGA6QIWNmuoWU1cLL/z2vr7S9A8QwXINr9
         3jxspamvrk8lOl7oBP5huXNU5fPrMV+Eow7lzhZrlMgex72gfILVaueBctvVMSoIm7jt
         jiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689962007; x=1690566807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdmHVEOZnx9XkZhHfTLEdLkTSGQEKCcj987Y0mRU5GU=;
        b=WUOQUNRZfFQdoqYdJ4A+3NOuRt73MdSaVOjP5hozQpjywuwfcAe4BkL6MIECkjukli
         uv8Ea8MseTPUlNnvM3YGZbusmRTIk5I1eBvgx3ZCo9qA5eiYnv5hOah+5GRm3Qat9ZWb
         uaJSdFWKYvSd7CDGKn+K1Ax9VQAqqFTZPzdeuYInBitFv1wqptJUXXfjN2eKK14Azgqk
         hVLULK3cmULvdkJWRXfeCkyHhTUNglD3StD9SSoxmU/Xah57Su5zqjZPjabjbXHQf/99
         Nioe0b2/5OCyZcz+NefvOo1vebru/O55EOkceQYdN0UUTgn+Nkd1Wm5IC6ctVWcFOxww
         lnlw==
X-Gm-Message-State: ABy/qLbqlpdp34XwD6Q7n+GGVvv/5X0aQDqO57OfaMB4LhLz1FYH1cIj
        HdWL6/oG4ZlYBF+6JoXxHzs=
X-Google-Smtp-Source: APBJJlE0EF47yVGan9WyTUm8NikrNutaf7wooOpEbhjBKKXG3gzX/Fbrd550ajmHULa5VM+34PGWqQ==
X-Received: by 2002:a05:6a20:9389:b0:138:1980:1837 with SMTP id x9-20020a056a20938900b0013819801837mr3394164pzh.13.1689962006833;
        Fri, 21 Jul 2023 10:53:26 -0700 (PDT)
Received: from yoga ([2400:1f00:13:cde2:d588:8109:e86b:839c])
        by smtp.gmail.com with ESMTPSA id jh6-20020a170903328600b001aad714400asm3791582plb.229.2023.07.21.10.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:53:26 -0700 (PDT)
Date:   Fri, 21 Jul 2023 23:23:19 +0530
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
Subject: [PATCH v5 3/8] perf scripts python: Add classes and conversion
 functions
Message-ID: <ab7b40bd32df7101a6f8b4a3aa41570b63b831ac.1689961706.git.anupnewsmail@gmail.com>
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

This commit introduces new classes and conversion functions to
facilitate the representation of Gecko profile information. The new
classes Frame, Stack, Sample, and Thread are added to handle specific
components of the profile data, also link to the origin docs has been
commented out.

Additionally, Inside the Thread class _to_json_dict() method has been
created that converts the current thread data into the corresponding
format expected by the GeckoThread JSON schema, as per the Gecko
profile format specification.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/scripts/python/perf-gecko.py | 133 +++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/perf-gecko.py b/tools/perf/scripts/python/perf-gecko.py
index 02849d3c9e81..71e2b042e695 100644
--- a/tools/perf/scripts/python/perf-gecko.py
+++ b/tools/perf/scripts/python/perf-gecko.py
@@ -11,7 +11,8 @@
 
 import os
 import sys
-from typing import Dict
+from dataclasses import dataclass, field
+from typing import List, Dict, Optional, NamedTuple, Set, Tuple, Any
 
 # Add the Perf-Trace-Util library to the Python path
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
@@ -20,9 +21,139 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 from perf_trace_context import *
 from Core import *
 
+StringID = int
+StackID = int
+FrameID = int
+CategoryID = int
+Milliseconds = float
+
 # start_time is intialiazed only once for the all event traces.
 start_time = None
 
+# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L156
+class Frame(NamedTuple):
+	string_id: StringID
+	relevantForJS: bool
+	innerWindowID: int
+	implementation: None
+	optimizations: None
+	line: None
+	column: None
+	category: CategoryID
+	subcategory: int
+
+# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L216
+class Stack(NamedTuple):
+	prefix_id: Optional[StackID]
+	frame_id: FrameID
+
+# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L90
+class Sample(NamedTuple):
+	stack_id: Optional[StackID]
+	time_ms: Milliseconds
+	responsiveness: int
+
+@dataclass
+class Thread:
+	"""A builder for a profile of the thread.
+
+	Attributes:
+		comm: Thread command-line (name).
+		pid: process ID of containing process.
+		tid: thread ID.
+		samples: Timeline of profile samples.
+		frameTable: interned stack frame ID -> stack frame.
+		stringTable: interned string ID -> string.
+		stringMap: interned string -> string ID.
+		stackTable: interned stack ID -> stack.
+		stackMap: (stack prefix ID, leaf stack frame ID) -> interned Stack ID.
+		frameMap: Stack Frame string -> interned Frame ID.
+		comm: str
+		pid: int
+		tid: int
+		samples: List[Sample] = field(default_factory=list)
+		frameTable: List[Frame] = field(default_factory=list)
+		stringTable: List[str] = field(default_factory=list)
+		stringMap: Dict[str, int] = field(default_factory=dict)
+		stackTable: List[Stack] = field(default_factory=list)
+		stackMap: Dict[Tuple[Optional[int], int], int] = field(default_factory=dict)
+		frameMap: Dict[str, int] = field(default_factory=dict)
+	"""
+	comm: str
+	pid: int
+	tid: int
+	samples: List[Sample] = field(default_factory=list)
+	frameTable: List[Frame] = field(default_factory=list)
+	stringTable: List[str] = field(default_factory=list)
+	stringMap: Dict[str, int] = field(default_factory=dict)
+	stackTable: List[Stack] = field(default_factory=list)
+	stackMap: Dict[Tuple[Optional[int], int], int] = field(default_factory=dict)
+	frameMap: Dict[str, int] = field(default_factory=dict)
+
+	def _to_json_dict(self) -> Dict:
+		"""Converts current Thread to GeckoThread JSON format."""
+		# Gecko profile format is row-oriented data as List[List],
+		# And a schema for interpreting each index.
+		# Schema:
+		# https://github.com/firefox-devtools/profiler/blob/main/docs-developer/gecko-profile-format.md
+		# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L230
+		return {
+			"tid": self.tid,
+			"pid": self.pid,
+			"name": self.comm,
+			# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L51
+			"markers": {
+				"schema": {
+					"name": 0,
+					"startTime": 1,
+					"endTime": 2,
+					"phase": 3,
+					"category": 4,
+					"data": 5,
+				},
+				"data": [],
+			},
+
+			# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L90
+			"samples": {
+				"schema": {
+					"stack": 0,
+					"time": 1,
+					"responsiveness": 2,
+				},
+				"data": self.samples
+			},
+
+			# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L156
+			"frameTable": {
+				"schema": {
+					"location": 0,
+					"relevantForJS": 1,
+					"innerWindowID": 2,
+					"implementation": 3,
+					"optimizations": 4,
+					"line": 5,
+					"column": 6,
+					"category": 7,
+					"subcategory": 8,
+				},
+				"data": self.frameTable,
+			},
+
+			# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L216
+			"stackTable": {
+				"schema": {
+					"prefix": 0,
+					"frame": 1,
+				},
+				"data": self.stackTable,
+			},
+			"stringTable": self.stringTable,
+			"registerTime": 0,
+			"unregisterTime": None,
+			"processType": "default",
+		}
+
 # Uses perf script python interface to parse each
 # event and store the data in the thread builder.
 def process_event(param_dict: Dict) -> None:
-- 
2.34.1

