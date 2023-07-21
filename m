Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3775D0FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjGUR4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGUR4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:56:34 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758BA3580;
        Fri, 21 Jul 2023 10:56:33 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-55ae2075990so1209776a12.0;
        Fri, 21 Jul 2023 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689962193; x=1690566993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3oMskO96RrM0Lz1+fZnc8bp9TyKg+DKCMlETVyH6jVs=;
        b=TxdXpRn0h9iYe4jGUc1toOw8z9LYPBc+0KtPTfEx7jWrHPgBAuDZ8+gI08bat+63HO
         SYiCn6Ag9hgVZwUZ/A+g14dRJ6ekonen++9+k12YRDSpCdRGrEMZw8N7PCKH/MPoVauz
         6bThVUbgsUiKEbKpBvuFn2D29c80OI2IDZeILVerYplrHHvvn7epkPDw33aL8R8fyl8V
         cY56fSp+kNsIhk1YYno+/+Sz+X7adfERFmQ7E1VHgwN0JpOa9+60VUm0p14z6s3F0UOf
         N7zLTTeBQnXG6zRJCfM91hQDbtPLrKy0uocZ5A7O3KiL/ZBZ85vXEJztHNtAbLp5QO9d
         meSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689962193; x=1690566993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oMskO96RrM0Lz1+fZnc8bp9TyKg+DKCMlETVyH6jVs=;
        b=Iu6Z2lxqInuTAM5P7UYRgWgfzpcoO1N9WjFBTulviQJLU1HA/JarxCXZriQBnQlLgp
         5eXRlXdnlQ/XsiKrPGzgIi3czOydzGre5xCJNwJ5+FKWgOFn+5kKyUWh5BVb1+rVnWBg
         ZlBdyV0CjcALk02nazVgnEQ2uvKqWEwh/I+KjWmfh+vkuXZOlWCExqNPQwb4KrIDtjob
         s2qdCTYwmDT30WzKcGjtSZXlT5Y1c/Y8knbc/J6PbLofsguEJBHZeLVyy58a5vEZwn/I
         /jj0a4QF/j1Rv2YaVjZSzmeZ0+v1XSp8ekILWRxmHE4RCBxCNFM6uLeg+jtRqJ8/L1T/
         S5XQ==
X-Gm-Message-State: ABy/qLbsFY135fgNhnR3hLutxRAE+EhmtquCLB65h74FMMkVjk4gywZF
        swfxId6ps+u8bWOs/X+7SGA=
X-Google-Smtp-Source: APBJJlFetWurpM/SyldZnE1NkvMH3XTvs5UCA+dW3rvcTwmxzpf7wfFYMqGZypKi30MJCLrHwpplrw==
X-Received: by 2002:a17:90b:1e4c:b0:263:f7ce:335e with SMTP id pi12-20020a17090b1e4c00b00263f7ce335emr2003927pjb.43.1689962192770;
        Fri, 21 Jul 2023 10:56:32 -0700 (PDT)
Received: from yoga ([2400:1f00:13:cde2:d588:8109:e86b:839c])
        by smtp.gmail.com with ESMTPSA id c5-20020a637245000000b0055386b1415dsm3370494pgn.51.2023.07.21.10.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:56:32 -0700 (PDT)
Date:   Fri, 21 Jul 2023 23:26:24 +0530
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
Subject: [PATCH v5 6/8] perf scripts python: Implement add sample function
 and thread processing
Message-ID: <5a112be85ccdcdcd611e343f6a7a7482d01f6299.1689961706.git.anupnewsmail@gmail.com>
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

The stack has been created for storing func and dso from the callchain.
The sample has been added to a specific thread. It first checks if the
thread exists in the Thread class. Then it call _add_sample function
which is responsible for appending a new entry to the samples list.

Also callchain parsing and storing part is implemented. Moreover removed
the comment from thread.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/scripts/python/perf-gecko.py | 52 ++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/perf-gecko.py b/tools/perf/scripts/python/perf-gecko.py
index 35e25e64d6d9..29d10985e176 100644
--- a/tools/perf/scripts/python/perf-gecko.py
+++ b/tools/perf/scripts/python/perf-gecko.py
@@ -40,6 +40,9 @@ CATEGORIES = None
 # The product name is used by the profiler UI to show the Operating system and Processor.
 PRODUCT = os.popen('uname -op').read().strip()
 
+# Here key = tid, value = Thread
+tid_to_thread = dict()
+
 # The category index is used by the profiler UI to show the color of the flame graph.
 USER_CATEGORY_INDEX = 0
 KERNEL_CATEGORY_INDEX = 1
@@ -153,6 +156,25 @@ class Thread:
 		))
 		return frame_id
 
+	def _add_sample(self, comm: str, stack: List[str], time_ms: Milliseconds) -> None:
+		"""Add a timestamped stack trace sample to the thread builder.
+		Args:
+			comm: command-line (name) of the thread at this sample
+			stack: sampled stack frames. Root first, leaf last.
+			time_ms: timestamp of sample in milliseconds.
+		"""
+		# Ihreads may not set their names right after they are created.
+		# Instead, they might do it later. In such situations, to use the latest name they have set.
+		if self.comm != comm:
+			self.comm = comm
+
+		prefix_stack_id = reduce(lambda prefix_id, frame: self._intern_stack
+						(self._intern_frame(frame), prefix_id), stack, None)
+		if prefix_stack_id is not None:
+			self.samples.append(Sample(stack_id=prefix_stack_id,
+									time_ms=time_ms,
+									responsiveness=0))
+
 	def _to_json_dict(self) -> Dict:
 		"""Converts current Thread to GeckoThread JSON format."""
 		# Gecko profile format is row-oriented data as List[List],
@@ -231,9 +253,36 @@ def process_event(param_dict: Dict) -> None:
 	if not start_time:
 		start_time = time_stamp
 
+	# Parse and append the callchain of the current sample into a stack.
+	stack = []
+	if param_dict['callchain']:
+		for call in param_dict['callchain']:
+			if 'sym' not in call:
+				continue
+			stack.append(f'{call["sym"]["name"]} (in {call["dso"]})')
+		if len(stack) != 0:
+			# Reverse the stack, as root come first and the leaf at the end.
+			stack = stack[::-1]
+
+	# During perf record if -g is not used, the callchain is not available.
+	# In that case, the symbol and dso are available in the event parameters.
+	else:
+		func = param_dict['symbol'] if 'symbol' in param_dict else '[unknown]'
+		dso = param_dict['dso'] if 'dso' in param_dict else '[unknown]'
+		stack.append(f'{func} (in {dso})')
+
+	# Add sample to the specific thread.
+	thread = tid_to_thread.get(tid)
+	if thread is None:
+		thread = Thread(comm=comm, pid=pid, tid=tid)
+		tid_to_thread[tid] = thread
+	thread._add_sample(comm=comm, stack=stack, time_ms=time_stamp)
+
 # Trace_end runs at the end and will be used to aggregate
 # the data into the final json object and print it out to stdout.
 def trace_end() -> None:
+	threads = [thread._to_json_dict() for thread in tid_to_thread.values()]
+
 	# Schema: https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L305
 	gecko_profile_with_meta = {
 		"meta": {
@@ -252,8 +301,7 @@ def trace_end() -> None:
 			"markerSchema": [],
 			},
 		"libs": [],
-		# threads will be implemented in later commits.
-		# "threads": threads,
+		"threads": threads,
 		"processes": [],
 		"pausedRanges": [],
 	}
-- 
2.34.1

