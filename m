Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC3C76CC60
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbjHBMMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjHBML4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:11:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91372D7B;
        Wed,  2 Aug 2023 05:11:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bb7b8390e8so42036255ad.2;
        Wed, 02 Aug 2023 05:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690978301; x=1691583101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A56hq21QDHutjmlsgYiCNksVDWHMEJru0EKZ0qnQsm8=;
        b=n3Fh/1G/jOeXdtg68kIR9ZBYRGKFax3mlHfOidugyA695m2zqgO5mbpqiXdGYSHYXI
         yHekuRo90hIwLhSpa6FVeD17JR1QSvtaTjNv955Ou7ygGTBAadw01lS2o5nzy0BHcEs4
         pcMydd1VKO4YvnmpuwycOelDmHEYTFnERZlMQF7r7nBpeWrygj/0oZFuebY/Y9nc5eHS
         ueJU8zHnVig7A5/bYW016eAXkRwPCB3rYTnswo+htRWXYM2t1nCxlhZ9cQWCtxSbNrUu
         2YiOCISGpUih35t8wYiPMpGGA+QVSfRTfW3bRoW20ew3csNgVhzkVx39nvVG5fvHpYEt
         vZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690978301; x=1691583101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A56hq21QDHutjmlsgYiCNksVDWHMEJru0EKZ0qnQsm8=;
        b=gQ8T2d8AwycydDhUyUmAU0S3anRIMw5fJsrsZRNQfZeLR/ntcfQMYG7oPltGYIjOv+
         UjoLlU8KCcxUTU5uByeS5EhnD3xgyFiyAPoyD9GGrgv1Zo0axD0y3oDeevUej07BALtK
         zkcOqn+qJ/AccPPHBpvYg4lMBQY1wUkYtoZ85HSi+bG8QV9EYnrOYncfD45aVoL8mVxx
         uArVbABSlM6cazXGln+ZQmwruGhetcXWMLr73tzaOiK9GnqLmiMEEkwb58L0NWU2faCc
         WFVD+dKUJOPJWqaQy+/f8SGvFSrm7rhbnUKngXpsltnq3PTQy8ybE9azmCOUNNi2y7q3
         JCgQ==
X-Gm-Message-State: ABy/qLavUnb2tefcvA6DU+8DVpava4p/9gdwsiE6IqakMn/UlSAAEzyY
        fhIx/0T3uU1++Dsb/vRVeWE=
X-Google-Smtp-Source: APBJJlHSutY8Z8P1gqU6TnI0PmTKekTk+2jyp5wm95qcckf/GvYnC9q3He3m6uZ4sMlDpWjh3Q2M9g==
X-Received: by 2002:a17:903:2301:b0:1b8:9f6a:39de with SMTP id d1-20020a170903230100b001b89f6a39demr15067440plh.65.1690978301071;
        Wed, 02 Aug 2023 05:11:41 -0700 (PDT)
Received: from localhost.localdomain ([43.132.98.115])
        by smtp.googlemail.com with ESMTPSA id kx14-20020a170902f94e00b001b890009634sm12293173plb.139.2023.08.02.05.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:11:40 -0700 (PDT)
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
        linux-trace-devel@vger.kernel.org, Ze Gao <zegao2021@gmail.com>,
        Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH v4 4/7] sched, tracing: reorganize fields of switch event struct
Date:   Wed,  2 Aug 2023 08:09:59 -0400
Message-ID: <20230802121116.324604-5-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802121116.324604-1-zegao@tencent.com>
References: <20230802121116.324604-1-zegao@tencent.com>
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

From: Ze Gao <zegao2021@gmail.com>

Report priorities in 'short' and prev_state in 'int' to save
some buffer space. And also reorder the fields so that we take
struct alignment into consideration to make the record compact.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Ze Gao <zegao@tencent.com>
---
 include/trace/events/sched.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..7d34db20b2c6 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -187,7 +187,7 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
 	     TP_ARGS(p));
 
 #ifdef CREATE_TRACE_POINTS
-static inline long __trace_sched_switch_state(bool preempt,
+static inline int __trace_sched_switch_state(bool preempt,
 					      unsigned int prev_state,
 					      struct task_struct *p)
 {
@@ -229,23 +229,23 @@ TRACE_EVENT(sched_switch,
 	TP_ARGS(preempt, prev, next, prev_state),
 
 	TP_STRUCT__entry(
-		__array(	char,	prev_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	prev_pid			)
-		__field(	int,	prev_prio			)
-		__field(	long,	prev_state			)
-		__array(	char,	next_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	next_pid			)
-		__field(	int,	next_prio			)
+		__field(	short,	prev_prio			)
+		__field(	short,	next_prio			)
+		__field(	int,	prev_state			)
+		__array(	char,	prev_comm,	TASK_COMM_LEN	)
+		__array(	char,	next_comm,	TASK_COMM_LEN	)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
-		__entry->prev_pid	= prev->pid;
-		__entry->prev_prio	= prev->prio;
-		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
+		__entry->prev_pid		= prev->pid;
+		__entry->next_pid		= next->pid;
+		__entry->prev_prio		= (short) prev->prio;
+		__entry->next_prio		= (short) next->prio;
+		__entry->prev_state		= __trace_sched_switch_state(preempt, prev_state, prev);
 		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
-		__entry->next_pid	= next->pid;
-		__entry->next_prio	= next->prio;
+		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
 		/* XXX SCHED_DEADLINE */
 	),
 
-- 
2.41.0

