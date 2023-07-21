Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E759A75D0F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjGURzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGURzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:55:47 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4543583;
        Fri, 21 Jul 2023 10:55:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6687096c6ddso1507122b3a.0;
        Fri, 21 Jul 2023 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689962146; x=1690566946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpJVh7Wa8yjpHxUJX1BOdNbTC2pXJ0eBIYFHqeqxfJM=;
        b=sX3XNSv7IowWcyMhaJeFw1o5fNoqWzquDZ2f92X7lqyrorbBu6FRnYJ4xE1hNvOwkz
         obMhfFkuDhXJmlRfyvO+nUMBpVWnI6LF3mHPDR6znXemRwqKEnGIfVpC4M/QgtD0YJ44
         qQhKFjTsnVjKwlqY2CILI8TsizvIeYp7UELyKbgzpiSP4E7UNq0e7gk8ZRvWbLNFvDwt
         sHv/SphQaSML2Ko6kD0FLk8iyTNV7MPc+eZNQ+33gxPsiJisndNokRUGrSS2tu0r6h1a
         zG89lK1kBdxkXPGl9QPBNvP9G9mb7sNYkHIQepnSdDYSNacBew3KrTChieD33FQFPuW5
         O7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689962146; x=1690566946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpJVh7Wa8yjpHxUJX1BOdNbTC2pXJ0eBIYFHqeqxfJM=;
        b=XvDTl7vBtU4oIs4sajufigen77zQEi5tOzAiAhl6sUxIltyolg/IarfeKJWt6TQsYB
         KaG0pZX9Nv+07z4B5IfY/86ghztwJ64GiPJdVINUdoVGdc1bYJ9NaBlRv81PxicNj2Lr
         aC9K/OWPCjpCd15pqki9dg9B1r0RzInW96H7pV+5jQKM1hQilL3eddCdoSIGLHhfgPvt
         zB5rNHBAF3a/4ResmcHtaShWOPjgw37k9cRUN9Y9Jmah5kSfor9VRa0J7cogspvaLHmJ
         LnTTZ8cyKYZlX94BHGj4tCO8IyAKqMNxXWpDqTNDYvvLjGsCBeedZUbecQG2+82Ep+hF
         zbCA==
X-Gm-Message-State: ABy/qLba2cJxq7xDncRmN1lhFhBf1vufMm1lPkooUXyBOAmMqHa5dt7R
        03E1gJLJyGEyT38DApOjJJE=
X-Google-Smtp-Source: APBJJlFinFmeBE69MH0AwSxU9U2YhjULA/g/TScIJrX7RoiHERMMBwY6O9W32+xbYIerFX23WYr4pw==
X-Received: by 2002:a05:6a20:12c9:b0:133:c9d0:75ff with SMTP id v9-20020a056a2012c900b00133c9d075ffmr2741086pzg.42.1689962146008;
        Fri, 21 Jul 2023 10:55:46 -0700 (PDT)
Received: from yoga ([2400:1f00:13:cde2:d588:8109:e86b:839c])
        by smtp.gmail.com with ESMTPSA id x15-20020a1709027c0f00b001bb4f9d86ebsm3813659pll.23.2023.07.21.10.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:55:45 -0700 (PDT)
Date:   Fri, 21 Jul 2023 23:25:38 +0530
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
Subject: [PATCH v5 5/8] perf scripts python: Implement add sample function
 and thread processing
Message-ID: <4442f4b1ab4c7317cf940560a3a285fcdfbeeb08.1689961706.git.anupnewsmail@gmail.com>
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
 tools/perf/scripts/python/perf-gecko.py | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/perf/scripts/python/perf-gecko.py b/tools/perf/scripts/python/perf-gecko.py
index f0d29f48467e..35e25e64d6d9 100644
--- a/tools/perf/scripts/python/perf-gecko.py
+++ b/tools/perf/scripts/python/perf-gecko.py
@@ -13,6 +13,7 @@ import os
 import sys
 import json
 import argparse
+from functools import reduce
 from dataclasses import dataclass, field
 from typing import List, Dict, Optional, NamedTuple, Set, Tuple, Any
 
@@ -39,6 +40,10 @@ CATEGORIES = None
 # The product name is used by the profiler UI to show the Operating system and Processor.
 PRODUCT = os.popen('uname -op').read().strip()
 
+# The category index is used by the profiler UI to show the color of the flame graph.
+USER_CATEGORY_INDEX = 0
+KERNEL_CATEGORY_INDEX = 1
+
 # https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L156
 class Frame(NamedTuple):
 	string_id: StringID
@@ -99,6 +104,55 @@ class Thread:
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
-- 
2.34.1

