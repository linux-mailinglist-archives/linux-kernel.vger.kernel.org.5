Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4575D0FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGUR6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjGUR54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:57:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E85C6;
        Fri, 21 Jul 2023 10:57:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b895a06484so14394525ad.1;
        Fri, 21 Jul 2023 10:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689962274; x=1690567074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1iO7RitBOAvlss62RnOLeCZxiLAYet/53XRH4CXtEs4=;
        b=fk4/QypjmdJuNtT/XSQWq/OThPpb77MUTgvjBRHxD67xldmYNpy05v9T7YgvHEuWpu
         5XSBpOP2GIiov7r5bX3Rg6Kgr4vrF+8fjfT9AOGylJnNkgOc5Xgt+0Y49umgAjBKO57d
         KUP1zzqcOlzK6NvMAV5ZIJtodzkL8o34rYAVspbmWUhyuClhOqtyKu1nGveTXz6K90+g
         jX+KqSJX+biMbMChx4zDgFUQCy4UQekEGECC/1NbmGGKVJMATiSkLhnc3appKRGck5Bh
         lShpqU/fob8LI/leRGhFrUEYyncbJG7sJJK3n6gM35OHAPTiORBV4W71XBBREX1VP+r1
         TQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689962274; x=1690567074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iO7RitBOAvlss62RnOLeCZxiLAYet/53XRH4CXtEs4=;
        b=HToXT/VA+R5b0uiraAWwqJuyt2n2cnrR7xkdIvSSRKwCdC5h6L5pUN2SZPXWgmoZXC
         fZSDIGMMUNhLhKt0FQyVfMY6iELyvl3Pf09IudIzxEC6czFUchs0r7B8hcPpfbbdyzXD
         FTnDvP9TWGoUsEiPSppSq5C33Cty/jK+qPmZ5iCdADcGfTg8RqirZk1BNcg7r4FLmv9h
         dR5Xlxj1e0EK+Q+nHTg6Gbjvs+MGpDJ1kSqa38fZCn2t9HgqwghpJOxZSpFCwJXFGRow
         C2FPApZq740wAtq/BeKjiV0qmkf26CuPtwByg/1H6Rm3JTCx+hn1vLOI4/iI9G1dS2Bh
         GIMA==
X-Gm-Message-State: ABy/qLYZqmiV5obNO0OajFDQrwJmEm3yQa9Ne3GM7qFAuKYf5lCtBlEJ
        Vv8AIHbQUukS5L6Ed1Dznbo=
X-Google-Smtp-Source: APBJJlFUPIfP7vFuoI3K/1bdSxhM2cFG5kRveW1S9UN81JkNqXXy0YSoReJYH22GNJYJDueBR29WrQ==
X-Received: by 2002:a17:902:7c8a:b0:1b8:3cb8:7926 with SMTP id y10-20020a1709027c8a00b001b83cb87926mr2178182pll.23.1689962274096;
        Fri, 21 Jul 2023 10:57:54 -0700 (PDT)
Received: from yoga ([2400:1f00:13:cde2:d588:8109:e86b:839c])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902f68200b001b89536974bsm3787696plg.202.2023.07.21.10.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:57:53 -0700 (PDT)
Date:   Fri, 21 Jul 2023 23:27:46 +0530
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
Subject: [PATCH v5 7/8] perf scripts python: Add command execution for perf
 gecko script
Message-ID: <cbf03cda175ea3dd2c6cd87bd3f12d803446cb95.1689961706.git.anupnewsmail@gmail.com>
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

This will enable the execution of perf-gecko.py script
using record and report commands in perf script.
And this will be also reflected at "perf script -l" command.

For Example:
    perf script record perf-gecko
    perf script report perf-gecko

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/scripts/python/bin/perf-gecko-record | 2 ++
 tools/perf/scripts/python/bin/perf-gecko-report | 3 +++
 2 files changed, 5 insertions(+)
 create mode 100644 tools/perf/scripts/python/bin/perf-gecko-record
 create mode 100644 tools/perf/scripts/python/bin/perf-gecko-report

diff --git a/tools/perf/scripts/python/bin/perf-gecko-record b/tools/perf/scripts/python/bin/perf-gecko-record
new file mode 100644
index 000000000000..7df5a19c0163
--- /dev/null
+++ b/tools/perf/scripts/python/bin/perf-gecko-record
@@ -0,0 +1,2 @@
+#!/bin/bash
+perf record -g "$@"
diff --git a/tools/perf/scripts/python/bin/perf-gecko-report b/tools/perf/scripts/python/bin/perf-gecko-report
new file mode 100644
index 000000000000..6781313dc862
--- /dev/null
+++ b/tools/perf/scripts/python/bin/perf-gecko-report
@@ -0,0 +1,3 @@
+#!/bin/bash
+# description: create firefox gecko profile json format from perf.data
+perf script -s "$PERF_EXEC_PATH"/scripts/python/perf-gecko.py -- "$@"
-- 
2.34.1

