Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA9776360C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjGZMQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjGZMQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:16:33 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B2F10F6;
        Wed, 26 Jul 2023 05:16:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-268541d2947so285847a91.3;
        Wed, 26 Jul 2023 05:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690373791; x=1690978591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7C0SBBUXP7O5XpijSeSyahi4TrgeBmdTgGvodmmzYM=;
        b=XzMmYD4oHTLISgh06EvMKIHnqyDaAepCtWmGauT3Qzqyb7kZLLWqYfYbB4Pm7yav9d
         je6i3VWhEw6JUGHj+xZR2N5681313IbwF2AMc/szvtVKYHys/kusZbo8o0Y42jGY/8rJ
         Momphh63sD5VKFa2RGMHrQWJVyhqP+tejBn5Ciet8SlRYk8LVWjk0MWa6nQXRaFJrs68
         KPe+6J5dANx1jE+NccjEXdLgUKBlCyrfMYb/6Gy4n4sdhsfgJ5yiMxd29fFaO671ryeT
         N7O8pn2YOw0BNB1O3ZT5jR0b2VEFqVJHzxzg9+9PHrTEOws8ULVd7x5TmjMtxXNAqqfx
         g00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690373791; x=1690978591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7C0SBBUXP7O5XpijSeSyahi4TrgeBmdTgGvodmmzYM=;
        b=iFdVTIvWPgVLYv++RKfW7uKonQIJjwKv7ja36vcsV57gvArqnV6r657rigULFvivCw
         8EMeaM9pokIvBQeCMM5/iXnOSJI7ZqElwF+QatYA26V3wRAJLPKuQdxKTe1JtkDXSAQR
         42IJKnwoch45o0zDxC8Ykk9qtaELTN33hl4KNd4YTThuZhidgnh1aUA62jB8r5Ke2qRY
         PO67CiZai37knZGQ90vEAfDsf0k5yvuQoI7Jg2c6MyDThC/iuKg06zUKMgOAoj/JXCli
         k6B5Pz4n08QPF0n6x5my0ht+scRYupOWrfZDwqDUVaMmDd1MnNtzAj6Ue6sgh26IQ07e
         yxNA==
X-Gm-Message-State: ABy/qLYz+OkkXWiCvlw2/09ww/pGUYQqTSOjf8yrx1TGPYknC5Vm/F54
        ogEZ486eJNgt+W6AbI3ReJI=
X-Google-Smtp-Source: APBJJlFPvsWN5escZL4T61sXRxRP6pt3wd53DBOmWtJCu0YtL1ojSt6nONVrv047Sx2zgvhHDjVHYA==
X-Received: by 2002:a17:90b:3b81:b0:263:f435:ef2d with SMTP id pc1-20020a17090b3b8100b00263f435ef2dmr1326501pjb.10.1690373791215;
        Wed, 26 Jul 2023 05:16:31 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.25])
        by smtp.googlemail.com with ESMTPSA id ms19-20020a17090b235300b00263f446d432sm1172880pjb.43.2023.07.26.05.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:16:30 -0700 (PDT)
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
Subject: [RFC PATCH v2 1/3] sched, tracing: add to report task state in symbolic chars
Date:   Wed, 26 Jul 2023 20:16:16 +0800
Message-Id: <20230726121618.19198-2-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726121618.19198-1-zegao@tencent.com>
References: <20230726121618.19198-1-zegao@tencent.com>
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

Internal representations of task state are likely to be changed or
ordered, and reporting them to userspace without exporting them as
part of API is not a good choice, which can easily break a userspace
observability tool as kernel evolves. For example, perf suffers from
this and still reports wrong states by this patch.

OTOH, some masqueraded state like TASK_REPORT_IDLE and TASK_REPORT_MAX
are also reported inadvertently, which confuses things even more.

So add a new variable in company with the old raw value to report task
state in symbolic char, which is self-explaining and no further
translation is needed, and also report priorities in 'short' to save
some buffer space.  Of course this does not break any userspace tool.

Note for PREEMPT_ACTIVE, we introduce 'p' to report it and use the old
conventions for the rest.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 include/trace/events/sched.h | 60 +++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..0fcf68f49e45 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -6,6 +6,7 @@
 #define _TRACE_SCHED_H
 
 #include <linux/kthread.h>
+#include <linux/sched.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
@@ -214,6 +215,27 @@ static inline long __trace_sched_switch_state(bool preempt,
 
 	return state ? (1 << (state - 1)) : state;
 }
+
+static inline char __trace_sched_switch_state_char(bool preempt,
+						   unsigned int prev_state,
+						   struct task_struct *p)
+{
+	long state;
+
+#ifdef CONFIG_SCHED_DEBUG
+	BUG_ON(p != current);
+#endif /* CONFIG_SCHED_DEBUG */
+
+	/*
+	 * For PREEMPT_ACTIVE, we introduce 'p' to report it and use the old
+	 * conventions for the rest.
+	 */
+	if (preempt)
+		return 'p';
+
+	state = __task_state_index(prev_state, p->exit_state);
+	return task_index_to_char(state);
+}
 #endif /* CREATE_TRACE_POINTS */
 
 /*
@@ -231,41 +253,29 @@ TRACE_EVENT(sched_switch,
 	TP_STRUCT__entry(
 		__array(	char,	prev_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	prev_pid			)
-		__field(	int,	prev_prio			)
-		__field(	long,	prev_state			)
+		__field(	short,	prev_prio			)
+		__field(	int,	prev_state			)
+		__field(	char,	prev_state_char			)
 		__array(	char,	next_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	next_pid			)
-		__field(	int,	next_prio			)
+		__field(	short,	next_prio			)
 	),
 
 	TP_fast_assign(
 		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
-		__entry->prev_pid	= prev->pid;
-		__entry->prev_prio	= prev->prio;
-		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
+		__entry->prev_pid		= prev->pid;
+		__entry->prev_prio		= (short) prev->prio;
+		__entry->prev_state		= __trace_sched_switch_state(preempt, prev_state, prev);
+		__entry->prev_state_char	= __trace_sched_switch_state_char(preempt, prev_state, prev);
 		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
-		__entry->next_pid	= next->pid;
-		__entry->next_prio	= next->prio;
+		__entry->next_pid		= next->pid;
+		__entry->next_prio		= (short) next->prio;
 		/* XXX SCHED_DEADLINE */
 	),
 
-	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d",
-		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
-
-		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
-		  __print_flags(__entry->prev_state & (TASK_REPORT_MAX - 1), "|",
-				{ TASK_INTERRUPTIBLE, "S" },
-				{ TASK_UNINTERRUPTIBLE, "D" },
-				{ __TASK_STOPPED, "T" },
-				{ __TASK_TRACED, "t" },
-				{ EXIT_DEAD, "X" },
-				{ EXIT_ZOMBIE, "Z" },
-				{ TASK_PARKED, "P" },
-				{ TASK_DEAD, "I" }) :
-		  "R",
-
-		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
-		__entry->next_comm, __entry->next_pid, __entry->next_prio)
+	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%c ==> next_comm=%s next_pid=%d next_prio=%d",
+		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio, __entry->prev_state_char, __entry->next_comm,
+		__entry->next_pid, __entry->next_prio)
 );
 
 /*
-- 
2.40.1

