Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856157588B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjGRWu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjGRWuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:50:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163B4FD;
        Tue, 18 Jul 2023 15:49:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-262e5e71978so140951a91.1;
        Tue, 18 Jul 2023 15:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689720582; x=1692312582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j0vN6LDudj3dFgUyjWuCTJLzuM5gYdF0WTTzcmqzoCU=;
        b=WSEwnS0RKZHGWcnIJkoVosJhvJSrwQVYhe4nHKSVNS5Sxg1n7Ng3VViJvitlDF6gyE
         msKvsLR3ARGi9KUbiw1ZWpDQdeol/UGsIeIJm/XiH0rz6Z0BAEfZ50BNFO/QjGU68Tm/
         Y/pH7pOdF3e3QOoCPL0lV7seZ+MRUsAzCl1tv5L3YHzidqN2wWCrMLKUggRZEjT8UV5/
         exLJteyMKJY8DGnulLuFmbET6gdtS2QdBjwB6Zop2Zx73IYARjhajXZB3wMoNt34hPPy
         glN3TpdpKaTVBxok3LFHn1UzVYkLGTem2MSVnAtQekxLjS6342rIArfzWyHOLrDTzKy6
         as9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720582; x=1692312582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0vN6LDudj3dFgUyjWuCTJLzuM5gYdF0WTTzcmqzoCU=;
        b=hEYQp1PizPs05X3UMRO1JDgayfLD7OFHgVKYVpiS4gtCk3LcGtXJDUZHjpvw7cV3sV
         +HS9KXBVkzOPNr5cEbyt491OBujUKAvOhhRyjnjs2T40HpISJLyh0hvgVq3va53dRqm4
         W8zN7mIw0azYisfIJkpOEi13uvhtEp4L9+9bB7CSsoWEolVdqrYX61XLES3pdXIMIx/r
         oqRfj9f+rKXeS8RV+pw8fXz+D1N77Ypnc61lHWtNm4hHEA8cGaxtSyStg3ve6AKzZ1al
         Hfx7cvNkBNZ8TmbIwwL/SYr5fcObq06tcycVA8zPHo+wfkn6DmFnojUPlpOXeMQVk1ei
         4y9g==
X-Gm-Message-State: ABy/qLbHPd5vwUoXHBFr2w2msq89XyvpYt7UR95aftrWJ6XvpGsoZz63
        TSkc/SM7SA1sBJIlIBbs8Dc=
X-Google-Smtp-Source: APBJJlHDIrXsg5LMUjeK2xSM746FyL+Vrg/R2SmZDvVK8+xHoFff6K+mIggFjV3D1GHjJUpFIQKO5g==
X-Received: by 2002:a17:90a:e8f:b0:256:675f:1d49 with SMTP id 15-20020a17090a0e8f00b00256675f1d49mr632064pjx.0.1689720582361;
        Tue, 18 Jul 2023 15:49:42 -0700 (PDT)
Received: from yoga ([2400:1f00:13:be68:c61a:77e0:3624:e4f6])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a004200b00262ff206931sm78374pjb.42.2023.07.18.15.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:49:42 -0700 (PDT)
Date:   Wed, 19 Jul 2023 04:19:34 +0530
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
Subject: [PATCH v4 3/6] perf scripts python: Add classes and conversion
 functions
Message-ID: <1cf78360595ce67c81e027d52144d4dff29d1091.1689718662.git.anupnewsmail@gmail.com>
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
 .../scripts/python/firefox-gecko-converter.py | 134 +++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index bfc8c2b026bf..d9b1ec18997a 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -11,7 +11,8 @@
 
 import os
 import sys
-from typing import Dict
+from dataclasses import dataclass, field
+from typing import List, Dict, Optional, NamedTuple, Set, Tuple, Any
 
 # Add the Perf-Trace-Util library to the Python path
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
@@ -20,9 +21,140 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
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
+
 # Uses perf script python interface to parse each
 # event and store the data in the thread builder.
 def process_event(param_dict: Dict) -> None:
-- 
2.34.1

