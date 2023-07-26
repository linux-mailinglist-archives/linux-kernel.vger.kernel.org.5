Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1CC763609
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjGZMQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGZMQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:16:28 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4D819A7;
        Wed, 26 Jul 2023 05:16:28 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-55ae2075990so3578900a12.0;
        Wed, 26 Jul 2023 05:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690373787; x=1690978587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/SfUH6qagd9RztYevRFo2Q3j6jWs29w7wHJ0ZcNrWE=;
        b=GmigUXHNKivEF+qJWOpYMSidwpXidWB/BVuh8qbB8lwRsTqUReNT9UUAdrL9YB5pff
         ASxe6g2NoBplCcNWZUumZT20q+Ood/JVVApgHUyhnz37V7fKpZCDWAMyGQ6xkyspP/Pz
         yEJw8sCXmFLiSZnQs2uw09KO3AFO5rF33dHntIqg/Ci56bl8fnnbltducGEWhBrMKdnz
         OvbdgPl/6Jt4P9Ok2arH86Zo3k4a0rY/IJQVvmpB+YY9t6IcFnz4u3oln39B0xIQcLrz
         rxHx8zAcLMx+GRSP1Gpu2oNzGjkTAUFNRhU8DLDvhHPehy5+ZE6zKkcpEQzdQKJd4yKH
         7+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690373787; x=1690978587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/SfUH6qagd9RztYevRFo2Q3j6jWs29w7wHJ0ZcNrWE=;
        b=ByouSNpscg6VNGH4TjPaAnw4pjQkGd4B7U55Vm4GuP230h1x/8VE0YKORo0NjpN+4N
         dfQmw2njFixVa8NlUVonRqN3flaFw2jtOVEj7MxSGhde6Nr7+XCc8JbFmPwPlOOghQHP
         f/0KQGoDR5YdRmAwk8bJeMLzn4lckAAM17+kCkuBTWX9l7V8sFJfMxRF17oVe0SHK619
         ZHIiJ2Hk7zJgGyaFm5uQSuMU2hpG4bUiUsaW6A1K58+tBCvzjc8DFIQSijwV0MFcza0M
         quu4Du3iGRzxBrHsmN5N4jxpL+O9AgQ8dYNFcXe08mlaBNjTlxqOMFBPSagjYanov8Ja
         7nDQ==
X-Gm-Message-State: ABy/qLb5aGfbEiZM+HOXomQ5ghqfvm79RdsaqTsxvI1Nk5c2AS2oeTy1
        DnydbJd9GXM6kjY/Kyc5BbY=
X-Google-Smtp-Source: APBJJlGE0q1zijcsm7so+mrQdJMlrjbBFw0rQBqydLkJfjQS/xtrxblvyRxdlJYD/eaC3oi36/W6iA==
X-Received: by 2002:a17:90a:408f:b0:263:3386:9da8 with SMTP id l15-20020a17090a408f00b0026333869da8mr1155414pjg.49.1690373787347;
        Wed, 26 Jul 2023 05:16:27 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.25])
        by smtp.googlemail.com with ESMTPSA id ms19-20020a17090b235300b00263f446d432sm1172880pjb.43.2023.07.26.05.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:16:26 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v2 0/3] report task state in symbolic chars from sched tracepoint
Date:   Wed, 26 Jul 2023 20:16:15 +0800
Message-Id: <20230726121618.19198-1-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
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


This is the 2nd attempt to fix the report task state issue in sched
tracepint, here is the first version:

https://lore.kernel.org/linux-trace-kernel/20230725072254.32045-1-zegao@tencent.com

Against v1, add a new var to report task state in symbolic char instead
of replacing the old one and to not to break anything.

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

Therefore, to fix the issues mentioned above for good, instead of choosing
I proposed to add a new variable to report task state in sched_switch with
a symbolic character along with the old hardcoded value, and save the
further processing of userspace tools and spare them from knowing
implementation details in the kernel.

After this patch seires, we report 'RSDTtXZPI' the same as in procfs, plus
a 'p' which denotes PREEMP_ACTIVE and is used for sched_switch tracepoint only.

Reviews welcome!

Regards,

Ze

Ze Gao (2):
  sched, tracing: add to report task state in symbolic chars
  perf sched: use the new prev_state_char instead in tracepoint
    sched_switch

 include/trace/events/sched.h | 60 +++++++++++++++++++++---------------
 tools/perf/builtin-sched.c   | 57 ++++++----------------------------
 2 files changed, 45 insertions(+), 72 deletions(-)

Ze Gao (1):
  libtraceevent: use the new prev_state_char instead in tracepoint
    sched_switch

 plugins/plugin_sched_switch.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

-- 
2.40.1

