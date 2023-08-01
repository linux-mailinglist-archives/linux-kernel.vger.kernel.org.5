Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635A576AB92
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjHAJBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjHAJBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:01:37 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8511724;
        Tue,  1 Aug 2023 02:01:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-563de62f861so3209487a12.1;
        Tue, 01 Aug 2023 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690880493; x=1691485293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HlJW6u1sZOpuT6avef9gnRgQCJ0eGQk1LzPcuYEotVk=;
        b=UkLe+vQfHPi6Wc95/4hjftuk9iRk0jhNEqE3orIUoIVTRtaq15v09ltRjCB54SdA72
         /gIQuQe2oD1/LUYD24wcG47jUuUX+NRG46UQ+Y5vh+WF4CbgcEfaOtGrOXC3cYZPuTBx
         9OBrnOABp0paIPvr3GSYR5flJvHO/Wlal9m498QMG/gb96gPv3bjon/eqEAqmCSRpuEi
         YDjJCE/cLf1By1SUpt5/z7anXxpm0pzPZDmj2imFyCXZgps3CAvXMReQuvj1HAZ4jGw+
         6vnkHg3/KLATxw7y4SuX18pCcfZPMwp745oUhzSHHP1O0LsIoXi1bVxGexeELj89Fw34
         D+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880493; x=1691485293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlJW6u1sZOpuT6avef9gnRgQCJ0eGQk1LzPcuYEotVk=;
        b=SklzSp5u27uy5l3TK7SCddnXujAm3q+oXjokgTfLk27fX3OecsXfOnzGoLij8Mpm8L
         BQsWk3WbcvSoVoPuGcLQTobeMSakJXUw/OYYlkCl+Z45f8Tkj3swhbKdiFtbBhQ2jAFl
         +AxL1A0jX353MOBna1bvXFEeF92th+Opdh/EiD2oKWaPlbj6He1HH2s/A63zZeILUu5X
         uesx6juhljQggchk31wezibxUNKMJ5OEUKNIMDhvbEf0YatVV6aA7T648kx/RREAHAjR
         6t8I+mpx7zbNuXqVDPccyTAf/uTtMuePLO5/6vZt3ikElQO1cPqeSWXglirunBU9G6q9
         E8fw==
X-Gm-Message-State: ABy/qLZh6nvaNqHEqmgEDSGN8UMk3/8KDKJHY+6/W8+qw0PT9ZpHCKLr
        HrbUZ9pMcKatP/UC4UBxd58=
X-Google-Smtp-Source: APBJJlF29a/YZq0gOiHwz58dkyP7GeqsFipTwefGHmApUHrxK1n3p3/gbYCZjjmiNXXWcJhV+gmQSg==
X-Received: by 2002:a17:90b:f10:b0:268:b0b:a084 with SMTP id br16-20020a17090b0f1000b002680b0ba084mr10823169pjb.46.1690880492742;
        Tue, 01 Aug 2023 02:01:32 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.20])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm1592523pjj.1.2023.08.01.02.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:01:32 -0700 (PDT)
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
Subject: [RFC PATCH v3 0/6] add to report task state in symbolic chars from sched tracepoint
Date:   Tue,  1 Aug 2023 17:01:18 +0800
Message-Id: <20230801090124.8050-1-zegao@tencent.com>
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

This is the 3rd attempt to fix the report task state issue in sched
tracepint, you can check out previous discussions here:

v1: https://lore.kernel.org/linux-trace-kernel/20230725072254.32045-1-zegao@tencent.com
v2: https://lore.kernel.org/linux-trace-kernel/20230726121618.19198-1-zegao@tencent.com

FYI, this series are designed not to break anything now and still do the 
1-1 correspondence int-char mapping for each distinct task state we want to
report, and thus will not lose any details intended for debug purposes. Of
course, this might be compromised because of bugs introduced due to my
stupidity. So your sage comments are very important and appreciated!


diff from v2:
1. reorder to condense sched_switch record structure
2. fallback to older method to maintain backward compatibility
   for perf/libtraceevent
3. split housekeeping work into separate ones for readability

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
  sched, tracing: add to report task state in symbolic chars
  sched, tracing: reorganize fields of switch event struct
  perf sched: prefer to use prev_state_char introduced in sched_switch

 include/trace/events/sched.h | 68 +++++++++++++++++-------------
 tools/perf/builtin-sched.c   | 82 ++++++++++++++++--------------------
 2 files changed, 76 insertions(+), 74 deletions(-)

Ze Gao (1):
  libtraceevent: prefer to use prev_state_char introduced in
    sched_switch

 plugins/plugin_sched_switch.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.40.1

