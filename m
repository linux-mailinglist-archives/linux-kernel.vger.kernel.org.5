Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A4175D0F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjGURxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGURxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:53:05 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF37930FF;
        Fri, 21 Jul 2023 10:53:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8c81e36c0so14427965ad.0;
        Fri, 21 Jul 2023 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689961984; x=1690566784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A1RiRnvnMArXfVpix0hW+f3JNZG15Z2XChwYa5/rmSo=;
        b=TfKlTxX027tRdN9RfbVC7IopGOQlZK4NK3P0KOWj1Ku5LE58tSJYd9+NcX+y2LX29W
         i8/n3gMI8lE+IwCgCcCmD0a7b0tiOds2uYLP6S3tnfUGO3WhsTwwZvciRFuQQbvIaua7
         bWyZ6xp24gsP7GJZgulFgvGSsYZ9smh8e8cqXsSPN24C7Gffg0uujyqL7/zNwQvvtUvQ
         vqBqFmss4FN6j+mPBl+NPU6rdFZfog1dRiEhif+yutgBtj7BrUX1hIgmZcPS1dDIj55U
         4wajEIrOyXmYQFEfHeLJ5vDXMuh0u7w1gvXrrjreFOVYJRkPpD33iUfIq0rqYrq9xZ82
         xMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689961984; x=1690566784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1RiRnvnMArXfVpix0hW+f3JNZG15Z2XChwYa5/rmSo=;
        b=PFm2AM9UpMBs2OCKH1PkBgd6NNgyk5uh9SYwYAU4Gj6RyZhpBCK08rQZOAaAb3RT2d
         vzcUpyF6XKF0OEqvCnL+lRAR4aqgSkno3uS9PHdxh2K5UROrSkt5kHNWYh0aEeuvwCBi
         JXWWTKxOi/AuLwq+1DwKvieVVjByI+Sd68w9sKFkpFPFlPi6XffazJwZGtV/vbr8rZsA
         MNGaCTjb9h7O3cqEyx2yWbEZookEIt1ONd+T1+uae1UVe7WOQsf0n4cjSuvTnArH7Qge
         yZNFCdtszeJ372i44ynuKpwgaNs8vengrJ8SAQhdYb5SoGIYOuOMb1ary6vSIQq5Ht1c
         3RJQ==
X-Gm-Message-State: ABy/qLbEzXlhdJNlSwCnf7BcZK2teqYSy5c00H8xzB3gbHBwDSpDR1Ax
        8v2JPdsQ6Gov78st544u8ks=
X-Google-Smtp-Source: APBJJlEV38qs7BKGBnXiq6gJDaCRnA1mJ/AqGfGT4hWDW4u7Yv2a6XM3grp785Wq5k65ltG03cDwcg==
X-Received: by 2002:a17:902:b7cb:b0:1b8:af5e:853f with SMTP id v11-20020a170902b7cb00b001b8af5e853fmr2039271plz.24.1689961984107;
        Fri, 21 Jul 2023 10:53:04 -0700 (PDT)
Received: from yoga ([2400:1f00:13:cde2:d588:8109:e86b:839c])
        by smtp.gmail.com with ESMTPSA id jh20-20020a170903329400b001b87c1c762fsm3805059plb.123.2023.07.21.10.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:53:03 -0700 (PDT)
Date:   Fri, 21 Jul 2023 23:22:56 +0530
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
Subject: [PATCH v5 2/8] perf scripts python: Extact necessary information
 from process event
Message-ID: <19910fefcfe4be03cd5c2aa3fec11d3f86c0381b.1689961706.git.anupnewsmail@gmail.com>
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

The script takes in a sample event dictionary(param_dict) and retrieves
relevant data such as time stamp, PID, TID, and comm for each event.
Also start time is defined as a global variable as it need to be passed
to trace_end for gecko meta information field creation.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/scripts/python/perf-gecko.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/perf-gecko.py b/tools/perf/scripts/python/perf-gecko.py
index 4e651adb6395..02849d3c9e81 100644
--- a/tools/perf/scripts/python/perf-gecko.py
+++ b/tools/perf/scripts/python/perf-gecko.py
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

