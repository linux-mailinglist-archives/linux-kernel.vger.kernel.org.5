Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C892376CD7A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjHBMtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjHBMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:49:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751382D62;
        Wed,  2 Aug 2023 05:48:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bba54f7eefso6138055ad.1;
        Wed, 02 Aug 2023 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690980529; x=1691585329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSMxQO4QLj11rFq0SZ8NCKoM/Fqrwq/JbOlu6Igg0B4=;
        b=h12faQrs/apclZ0PmxedI4aMnqe5yovVFOUP3c+TErQ6AnmeuL4TjkByvqCZV4oP4i
         BntZP9A1zwZH5xvMLspXQZwvJtA2uxPjmkpk/c82KS+erzHy9ZC2Ncz/vZa7L+4dDACA
         2fbnFwMh5vd2h1t3xk7RK7IKRTPsSmpD6sSUGTZi1FUAoWjy3wqwzn8xjiM1Hn2my0ll
         15vQQZAE96/bbbETKYBO3U7NuZK980M3tZNXOKJAgSWxJtFlNIqhjBWy2DQNc2GDnCSc
         hOgYwrjGyKoI3wynvIGHOsQQO6ux984N0r3YSuaDLkBGM0rlbyyp2OIZpK6isJ1jI10n
         JC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980529; x=1691585329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSMxQO4QLj11rFq0SZ8NCKoM/Fqrwq/JbOlu6Igg0B4=;
        b=bG+ndrkhYXfSI5mgkJ2ePMzhMUhiao84Bt08+tAK8EeHG6qcu1CzPshCqDItPAy3aS
         IsIf+K6Y0dZw8yz6mER0/oSDW2C/IdWmFm5fETF9eVwBXsnzWIOCN6ySxvuhb6OOZTnl
         Wqzav+42QEzQAx0GL9LmcfGwOa8PNEah9yTS+V0+kZ8DlzIUlmSPMNUgIy1wrll88lsG
         1ZJZNDQ928kIthn/eTEqo/ntFHYJzNUutx9v2tbVlXcyqxydr/+YWHQTGgYadLVGizWH
         pJCNr61PLXBmjBV+2eOvnzT5MIXgNeth4esbiM0JWZnM2ehJjpkjXmdaI4OqlPesOgo2
         kQAQ==
X-Gm-Message-State: ABy/qLZWxJVaRcc7UuQ75cLA+XfFzmTwrlkJtj6pz4S5FDyXln8CHsmq
        tSMLotn0tNxjG6MnuZj4u38=
X-Google-Smtp-Source: APBJJlGqiFEDeXrHpz/RMBL2cv+N5gAw/hBk7Ool/YUVwwJ+tm22LDsg6wRpYdv/0HKIK6jGiGI9Vw==
X-Received: by 2002:a17:90a:8c96:b0:263:eb0e:5681 with SMTP id b22-20020a17090a8c9600b00263eb0e5681mr19375118pjo.3.1690980527682;
        Wed, 02 Aug 2023 05:48:47 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm4811993pjj.1.2023.08.02.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:48:47 -0700 (PDT)
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
        linux-trace-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v5 0/7] fix task state report from sched tracepoint
Date:   Wed,  2 Aug 2023 08:47:23 -0400
Message-ID: <20230802124840.335638-1-zegao@tencent.com>
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

This is the 5th attempt to fix the report task state issue in sched
tracepint, you can check out previous discussions here:

v1: https://lore.kernel.org/linux-trace-kernel/20230725072254.32045-1-zegao@tencent.com
v2: https://lore.kernel.org/linux-trace-kernel/20230726121618.19198-1-zegao@tencent.com
v3: https://lore.kernel.org/linux-trace-kernel/20230801090124.8050-1-zegao@tencent.com
v4: sorry for my stupid copy-paste, which makes patch broken and cannot be applied

Against v3, reorganize commits so that they can be cherry-picked
individually if people indeed have strong opinion over this change.

Note PATCH 1-4 are the normal fixes and cleanup whereas PATCH 5-7
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

--

Ze Gao (5):
  perf sched: sync state char array with the kernel
  perf sched: reorganize sched-out task state report code
  sched, tracing: reorganize fields of switch event struct
  sched, tracing: add to report task state in symbolic chars
  perf sched: prefer to use prev_state_char introduced in sched_switch

 include/trace/events/sched.h | 68 +++++++++++++++++-------------
 tools/perf/builtin-sched.c   | 82 ++++++++++++++++--------------------
 2 files changed, 76 insertions(+), 74 deletions(-)

Ze Gao (2):
  libtraceevent: sync state char array with the kernel
  libtraceevent: prefer to use prev_state_char introduced in
    sched_switch

 plugins/plugin_sched_switch.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.41.0

