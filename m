Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF587588B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjGRWst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGRWsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:48:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF384EC;
        Tue, 18 Jul 2023 15:48:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-55c993e26ffso2433620a12.0;
        Tue, 18 Jul 2023 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689720514; x=1692312514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1d8swg9Y9ZixZmusx5ZmXbxt99Xqol7znCwCmQSk3ZI=;
        b=emwJY9ZJECLmBaafe7jMvIHAr4sMp56GWkOkD7dQZL5tAOkKbIVuBc5y7+2hvJD5ZC
         SScNluQBdVqrXU8XA0q5rXinV8EaBkL4x9F83xoAmn/kx2+LcNhCFghJVdly7VCbGlwN
         8HCR4Gdqoy74YVjuRkik+yCbDi9/QQwRkVnUgbv9gA5na23PcLR0YLBCDT1wetrDr1c0
         qVNappH1/hxsd6g85MH1Gctgw1CZvKwUKqGwG2LGdBHwN23rNY4pZdI/vEW7MWBpIpWt
         kTm2Umi602swO+e+Ye72G0Sjoa+2Q5/56UGa6oTsayuOyc9fKa2mTzFxPvQQRQN1czE8
         xLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689720514; x=1692312514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1d8swg9Y9ZixZmusx5ZmXbxt99Xqol7znCwCmQSk3ZI=;
        b=NTUrLlri4JASAN2goQRF1D7ovF9DPpCGdphH7Mx7SNUf0MorAAWdUJzZ+gwjheeynq
         bXdZA2nBBx1gwc41jNKKbly/PoDw9zeavPOby4nTcTjQFqyCtN3kF1dz4hNzX5Ux4Tp+
         /rETyYkMabMxwu+rQn2kjKcZ3qPAAFyGBLLsR2UuEL2Au38DwjtKmBVpGRuyZR1nVB8F
         GXlZ1vqM1wl/lFEqE7ta2P2Ody2susU7Ak06IsAolU2C3N96Ums5YAt1pue2FnRriaEN
         xvmza0vAanSTQAHf2WBg+n9JxAQDPuvF/OPqNvM91dudRGt8UPWpsMludXjnwHM6FlMd
         JaeQ==
X-Gm-Message-State: ABy/qLbM6yZm5qugN9rGUVttb/tiyHNT20wtgwkEQLHlQ5SU9Tduh88G
        TXSHr0uylGmo0lFeneo8x4g=
X-Google-Smtp-Source: APBJJlEr9VeGDpzg3TrHyG+9650W/M65MuPWS5iwlfcndUVKOal5WfoaF32Bn8dB3y9BpmI1dyGKSg==
X-Received: by 2002:a05:6a20:3955:b0:12f:dce2:b385 with SMTP id r21-20020a056a20395500b0012fdce2b385mr4062572pzg.10.1689720514171;
        Tue, 18 Jul 2023 15:48:34 -0700 (PDT)
Received: from yoga ([2400:1f00:13:be68:c61a:77e0:3624:e4f6])
        by smtp.gmail.com with ESMTPSA id u21-20020aa78395000000b0065434edd521sm1959826pfm.196.2023.07.18.15.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:48:33 -0700 (PDT)
Date:   Wed, 19 Jul 2023 04:18:26 +0530
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
Subject: [PATCH v4 2/6] perf scripts python: Extact necessary information
 from process event
Message-ID: <feeadb6d460a2fa30eb866f2b1eb9e5e0a818ad5.1689718662.git.anupnewsmail@gmail.com>
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

The script takes in a sample event dictionary(param_dict) and retrieves
relevant data such as time stamp, PID, TID, and comm for each event.
Also start time is defined as a global variable as it need to be passed
to trace_end for gecko meta information field creation.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../perf/scripts/python/firefox-gecko-converter.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 63ecaf1abee8..bfc8c2b026bf 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -20,10 +20,22 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 from perf_trace_context import *
 from Core import *
 
+# start_time is intialiazed only once for the all event traces.
+start_time = None
+
 # Uses perf script python interface to parse each
 # event and store the data in the thread builder.
 def process_event(param_dict: Dict) -> None:
-	pass
+	global start_time
+	global tid_to_thread
+	time_stamp = (param_dict['sample']['time'] // 1000) / 1000
+	pid = param_dict['sample']['pid']
+	tid = param_dict['sample']['tid']
+	comm = param_dict['comm']
+
+	# Start time is the time of the first sample
+	if not start_time:
+		start_time = time_stamp
 
 # Trace_end runs at the end and will be used to aggregate
 # the data into the final json object and print it out to stdout.
-- 
2.34.1

