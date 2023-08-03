Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9107C76E340
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbjHCIga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjHCIfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:35:52 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7DA49C6;
        Thu,  3 Aug 2023 01:34:22 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686f94328a4so498256b3a.0;
        Thu, 03 Aug 2023 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691051662; x=1691656462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0HdtzsFcjnqSdu/wYrTNOMyr6MBczTrPpq1JjS0aQuU=;
        b=bvzOt9N9PavmgNAUpqv4e90H16xE0kky0Os1Ek66hmep4AupnWFsmqa/mc1hkmpE76
         nHJD+HhSCZ/BIXsWOAqWfZUOnOBeSgJCrcB45QPui6tXJbEpdgFeVgOOi7D9Fa/5mj5R
         gbsx+zeXXhyIssnhvVgNGyE3peH6rPboTd10T9faUOxsMQo96B5zthcdOTYFlDScV7sd
         R3dVR2Gtl9AlrtWj5xEBznX2DRDZhzaXYFzP6JzD3S8hMzRS06VP234vqEZAmceBhLIW
         oQUqHR+mLU788kOBo+eZEfqH2Shug4aErvIWbq0OS/e4inDmHw3d5o4qmZoUr6WpKCnU
         jUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691051662; x=1691656462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HdtzsFcjnqSdu/wYrTNOMyr6MBczTrPpq1JjS0aQuU=;
        b=a3kutjqstP6so6i0a9mcnuVbQGlhoBNREKjV085IrBpc+qe471wip9hLNcyJ8lEvJd
         eE2kYbJRmJ6fzXNYlUyUBALdwBEgy5KdrmAg6udfs6UGpiSsbkPEj1nuoZ4+pGE94Uv/
         LurbiQyj2dWABzzIHBTxzFnEQPRFhFS0CSVN5maura71sbg9k0ebJOWKu5d7fFAf1ekB
         4m5CGK+mIsae8kvtpwHhe51hXMbNfjal1zzxhWkweGomrcWAXQOuo+WA9mHKXchkLzB/
         zL3vUCRSjMHH3IQUTyN5AZWfswKkLbSbZfCVVzGja8Lj9qk84t3HntG4Q+5KhgX3BmOf
         Ea4A==
X-Gm-Message-State: ABy/qLalBxbxEX2nxlCx7XgiAhI0oIhSok3aOxJuy2VzUCNfylWBt8Ss
        PaX6tQYNjrkAGumQ/ZZ54jc=
X-Google-Smtp-Source: APBJJlFfjhMzPsL1kKhmUxZIkcUM1AEwsveFOcTC8U4Q3rX7jhzLLmCNA/DAjkJRI1XxDa1DkS4lzw==
X-Received: by 2002:a05:6a00:1394:b0:666:c1ae:3b87 with SMTP id t20-20020a056a00139400b00666c1ae3b87mr27782851pfg.12.1691051661854;
        Thu, 03 Aug 2023 01:34:21 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.googlemail.com with ESMTPSA id r6-20020a63b106000000b00563feb7113dsm12541876pgf.91.2023.08.03.01.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:34:21 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v6 0/5] fix task state report from sched tracepoint
Date:   Thu,  3 Aug 2023 04:33:47 -0400
Message-ID: <20230803083352.1585-1-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 6th attempt to fix the report task state issue in sched
tracepint, you can check out previous discussions here:

v1: https://lore.kernel.org/linux-trace-kernel/20230725072254.32045-1-zegao@tencent.com
v2: https://lore.kernel.org/linux-trace-kernel/20230726121618.19198-1-zegao@tencent.com
v3: https://lore.kernel.org/linux-trace-kernel/20230801090124.8050-1-zegao@tencent.com
v4: https://lore.kernel.org/linux-trace-kernel/20230802121116.324604-1-zegao@tencent.com 
v5: https://lore.kernel.org/linux-trace-kernel/20230802124840.335638-1-zegao@tencent.com

Against v5, fix some code style and change to report prev_state
in 'short'; also send libtraceevent patches seperately to
linux-trace-devel@vger.kernel.org.

Note PATCH 1-3 are the normal fixes and cleanup whereas PATCH 4-5
introduce new changes.

--

FYI, this series are designed not to break anything now and still do the 
1-1 correspondence int-char mapping for each distinct task state we want to
report, and thus will not lose any details intended for debug purposes. Of
course, this might be compromised because of bugs introduced due to my
stupidity. So your sage comments are very important and appreciated!

--

In the status quo, we should see three different outcomes of the reported
sched-out task state from perf-script, perf-sched-timehist, and Tp_printk
of tracepoint sched_switch.  And it's not hard to figure out that the
former two are built upon the third one, and the reason why we see this
inconsistency is that the former two does not catch up with the internal
change of reported task state definitions as the kernel evolves.

IMHO, exporting internal representations of task state in the tracepoint
sched_switch is not a good practice and not encouraged at all, which can
easily break userspace tools that relies on it. Especially when tracepoints
are massively used in many observability tools nowadays due to its stable
nature, which makes them no longer used for debug only purpose and we
should be careful to decide what ought to be reported to userspace and what
ought not.

Therefore, to fix the issues mentioned above for good, I proposed to add
a new variable to report task state in sched_switch with a symbolic char
along with the old hardcoded value, and save the further processing of
userspace tools and spare them from knowing implementation details in the
kernel.

After this patch seires, we report 'RSDTtXZPI' the same as in procfs, plus
a 'p' which denotes PREEMP_ACTIVE and is used for sched_switch tracepoint
only.

Reviews welcome!

Regards,
Ze

Ze Gao (5):
  perf sched: sync state char array with the kernel
  perf sched: reorganize sched-out task state report code
  sched, tracing: reorganize fields of switch event struct
  sched, tracing: add to report task state in symbolic chars
  perf sched: prefer to use prev_state_char introduced in sched_switch

 include/trace/events/sched.h | 70 +++++++++++++++++-------------
 tools/perf/builtin-sched.c   | 83 +++++++++++++++++-------------------
 2 files changed, 78 insertions(+), 75 deletions(-)

-- 
2.41.0

