Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513807588BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjGRWvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGRWvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:51:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02958113;
        Tue, 18 Jul 2023 15:51:00 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-262d33fa37cso3434069a91.3;
        Tue, 18 Jul 2023 15:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689720659; x=1692312659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bAziTTNqkuDxnsVhswEAtYdwMiQKe4Q0DSlep6xN+rY=;
        b=TG6BttH0y1XtYqBNMg8rULmY5CDgCLLSQfYicSCLKZa00WKkMgXKSZBlzUChvsKO4A
         47qSYrFT1ZhmczurwUznvobMAGABpncs7nh339VmTHq92fLtQPjZG86JwikiQY9pvenC
         q0Tjt5X/ff2Fvsxkgrb++IQsrPhRe5W0PGtnf+b4+tFWrw/rcnzQuLZ+L4AkySf5zV5C
         h1lm/Uq9VpRMzkR2lyq1vqfRh9V/EeVQLZwY5LjkxKeoSPrdMqyu1uGLBXvurROtFJ0i
         KoQmawZkYh6EFnmCaMyy5xPTIRoaFS762wuIMdRtccr1aSzm3S737s7bJX3ZHahj2eiC
         xMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720659; x=1692312659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAziTTNqkuDxnsVhswEAtYdwMiQKe4Q0DSlep6xN+rY=;
        b=HRTAyoqu3Glmk/++aYCyBsFRrOFw36c40NK+1KcJMMMFLk0HOnz3IUXbNRNbg6vCze
         ek+/vjkwJ3fvPv06lHyujO1gw/XUuC71xT1LGWk1bgQaHsPNIqnfk0lN9D2c4H9WoMk3
         4aNeA/sVG5V8eGU/VJPW+bJdqymD9DbRL4AwX7RmfoMRDT24dHsppEs/W+52EPUlO/EA
         1rO8pLy8vr12dhjuHGz+CHinA/0NJJ8AwuwZSRln5opYnetKFiZdMu+JG2Nn3KL9opTx
         6YnLHM1b6FCTtbKEGmmeC44Ggq1/aeHBHSzuIZusWhgx9urgyuzpnTd30wlzqx0KZ0U2
         zpXA==
X-Gm-Message-State: ABy/qLbN5KXKDyhaGM/3NQNuna8WWObEau6cdmfUs4KqVWWppdQk1hhH
        HeykhGMUKujyHNMUdwdjcumEr0bTd3C2mouI
X-Google-Smtp-Source: APBJJlE1LxEerg9t/i5ahWNwoPzbIJNTBbMbyjoMt5nbezqaUrOmkjFtf27vc87mxvPig5D29FIKyg==
X-Received: by 2002:a17:90a:294b:b0:263:70d5:6d60 with SMTP id x11-20020a17090a294b00b0026370d56d60mr13331369pjf.30.1689720659188;
        Tue, 18 Jul 2023 15:50:59 -0700 (PDT)
Received: from yoga ([2400:1f00:13:be68:c61a:77e0:3624:e4f6])
        by smtp.gmail.com with ESMTPSA id gp20-20020a17090adf1400b0025023726fc4sm75420pjb.26.2023.07.18.15.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:50:58 -0700 (PDT)
Date:   Wed, 19 Jul 2023 04:20:51 +0530
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
Subject: [PATCH v4 5/6] perf scripts python: implement internal get or create
 frame, stack and string function
Message-ID: <4cbbbb2b748f29c1a5025d23f0260a395054003a.1689718662.git.anupnewsmail@gmail.com>
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

The intern_stack function is responsible for retrieving
or creating a stack_id based on the provided frame_id and prefix_id.
It first generates a key using the frame_id and prefix_id values.
If the stack corresponding to the key is found in the stackMap,
it is returned. Otherwise, a new stack is created by appending
the prefix_id and frame_id to the stackTable. The key
and the index of the newly created stack are added to the
stackMap for future reference.

The _intern_frame function is responsible for retrieving or
creating a frame_id based on the provided frame string. If the frame_id
corresponding to the frameString is found in the frameMap, it is
returned. Otherwise, a new frame is created by appending relevant
information to the frameTable and adding the frameString to the string_id
through _intern_string.

The _intern_string function will gets a matching string, or saves the new
string and returns a String ID.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 58 ++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index a0218e2245f2..ae69c0a4af13 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -13,6 +13,7 @@ import os
 import sys
 import json
 import argparse
+from functools import reduce
 from dataclasses import dataclass, field
 from typing import List, Dict, Optional, NamedTuple, Set, Tuple, Any
 
@@ -39,6 +40,13 @@ CATEGORIES = None
 # The product name is used by the profiler UI to show the Operating system and Processor.
 PRODUCT = os.popen('uname -op').read().strip()
 
+# Here key = tid, value = Thread
+tid_to_thread = dict()
+
+# The category index is used by the profiler UI to show the color of the flame graph.
+USER_CATEGORY_INDEX = 0
+KERNEL_CATEGORY_INDEX = 1
+
 # https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L156
 class Frame(NamedTuple):
 	string_id: StringID
@@ -99,6 +107,55 @@ class Thread:
 	stackMap: Dict[Tuple[Optional[int], int], int] = field(default_factory=dict)
 	frameMap: Dict[str, int] = field(default_factory=dict)
 
+	def _intern_stack(self, frame_id: int, prefix_id: Optional[int]) -> int:
+		"""Gets a matching stack, or saves the new stack. Returns a Stack ID."""
+		key = f"{frame_id}" if prefix_id is None else f"{frame_id},{prefix_id}"
+		# key = (prefix_id, frame_id)
+		stack_id = self.stackMap.get(key)
+		if stack_id is None:
+			# return stack_id
+			stack_id = len(self.stackTable)
+			self.stackTable.append(Stack(prefix_id=prefix_id, frame_id=frame_id))
+			self.stackMap[key] = stack_id
+		return stack_id
+
+	def _intern_string(self, string: str) -> int:
+		"""Gets a matching string, or saves the new string. Returns a String ID."""
+		string_id = self.stringMap.get(string)
+		if string_id is not None:
+			return string_id
+		string_id = len(self.stringTable)
+		self.stringTable.append(string)
+		self.stringMap[string] = string_id
+		return string_id
+
+	def _intern_frame(self, frame_str: str) -> int:
+		"""Gets a matching stack frame, or saves the new frame. Returns a Frame ID."""
+		frame_id = self.frameMap.get(frame_str)
+		if frame_id is not None:
+			return frame_id
+		frame_id = len(self.frameTable)
+		self.frameMap[frame_str] = frame_id
+		string_id = self._intern_string(frame_str)
+
+		symbol_name_to_category = KERNEL_CATEGORY_INDEX if frame_str.find('kallsyms') != -1 \
+		or frame_str.find('/vmlinux') != -1 \
+		or frame_str.endswith('.ko)') \
+		else USER_CATEGORY_INDEX
+
+		self.frameTable.append(Frame(
+			string_id=string_id,
+			relevantForJS=False,
+			innerWindowID=0,
+			implementation=None,
+			optimizations=None,
+			line=None,
+			column=None,
+			category=symbol_name_to_category,
+			subcategory=None,
+		))
+		return frame_id
+
 	def _to_json_dict(self) -> Dict:
 		"""Converts current Thread to GeckoThread JSON format."""
 		# Gecko profile format is row-oriented data as List[List],
@@ -163,7 +220,6 @@ class Thread:
 			"processType": "default",
 		}
 
-
 # Uses perf script python interface to parse each
 # event and store the data in the thread builder.
 def process_event(param_dict: Dict) -> None:
-- 
2.34.1

