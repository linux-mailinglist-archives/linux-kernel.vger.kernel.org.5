Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CF57588BE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjGRWwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGRWws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:52:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6FFEE;
        Tue, 18 Jul 2023 15:52:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666ed230c81so6299866b3a.0;
        Tue, 18 Jul 2023 15:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689720741; x=1692312741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AESNSKu76AwBKDmM6LgRhommsrTxqaO6oADrlXIeM64=;
        b=gvtye7OYtvyAywIXMhCIK07kjzJzgri2LsA/WZAVczuZuJQjAeR6DmBeDGBw5TGPqw
         r7RmWVBvLhlinXTGJeSmoyJN9i0604XOOq8vGBK2L8ddyOQ3rkkO8TenTR74Q8I4rWmq
         1R1GZzHyuQFQKGeH1ff5EERFFnXn0Hyvnw1x+J6Y+O7BZjwhcmYi+tTyjA5+UY2vtLfC
         zCKfkdCqrV6vtp9BX7rxe97zAXlbXiUI6oixBEV6EguOEB9Mg7ooV4bw+XUHmittbOCT
         xExiD/x5gxaPx4/zl20oBsKEQhz+YgWwyrL+MpUUeshIbvST1JFNKXU5WWu28ibEqx3N
         AxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720741; x=1692312741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AESNSKu76AwBKDmM6LgRhommsrTxqaO6oADrlXIeM64=;
        b=hHEcnZ0WR5/GE5oFMp5Y5BUwpTrmDTKDp2gIgNKzuoGMg1N9GI0s8a/BRMndrQ0TZU
         A8bPag2BjNM7coF3x+hIe+nPhJ15q4LCG0C1CCEcpAgqKbrPeDfImeCkKJzYDjt0yLKW
         gvxjEZj2xJD/VtVZZKwGK24R7dY5lLzpyKDKSFwPWkWgCdyPoacrE6dPQMuK/sE17cTo
         tQkx4JBoOOgSHJWZmSqVEhWDzSqpaG7CPUVDcnnRn9iw9O7HDiFvNhfaACNtqUEY9N2g
         UHs+YiwG/sb3jHSzvWaNtzFz0A4w0DZ48KJon1rLNVoFKp8Efnby/N2orz4SELZ7awF8
         JiEw==
X-Gm-Message-State: ABy/qLb0BFu9AcSVJiMYhp7GoAB09UsgfJnAEgtVSYXLc3UWHuHNt4fn
        TJgEVt920CKN9UcwxEAoiG8=
X-Google-Smtp-Source: APBJJlFv1a/dZKM9JVmWRbsLvfc2IoXCwZIL/wLdapRaYK1KM4xxmWOn/IR3cQz9bWwJ7Hq0+pK0Pw==
X-Received: by 2002:a05:6a20:12c9:b0:12e:c481:7072 with SMTP id v9-20020a056a2012c900b0012ec4817072mr914193pzg.37.1689720741264;
        Tue, 18 Jul 2023 15:52:21 -0700 (PDT)
Received: from yoga ([2400:1f00:13:be68:c61a:77e0:3624:e4f6])
        by smtp.gmail.com with ESMTPSA id a11-20020a637f0b000000b005633941a547sm1943769pgd.27.2023.07.18.15.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:52:20 -0700 (PDT)
Date:   Wed, 19 Jul 2023 04:22:13 +0530
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
Subject: [PATCH v4 6/6] perf scripts python: Implement add sample function
 and thread processing
Message-ID: <6771dcadf7507ad8916ba2398d22f873579b0505.1689718662.git.anupnewsmail@gmail.com>
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

The stack has been created for storing func and dso from the callchain.
The sample has been added to a specific thread. It first checks if the
thread exists in the Thread class. Then it call _add_sample function
which is responsible for appending a new entry to the samples list.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index ae69c0a4af13..9c4393787daa 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -156,6 +156,25 @@ class Thread:
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
@@ -234,9 +253,36 @@ def process_event(param_dict: Dict) -> None:
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
-- 
2.34.1

