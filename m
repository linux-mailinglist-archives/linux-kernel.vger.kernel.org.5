Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A932676AB97
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjHAJCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjHAJB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:01:57 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26301FC9;
        Tue,  1 Aug 2023 02:01:48 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-563c7aabf38so4324597a12.0;
        Tue, 01 Aug 2023 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690880508; x=1691485308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwyto1QFsZ2jeAqiVCVI7asIYgAtksL73lrshA0wpgo=;
        b=lIDBHFBLzSxp1aUAT4vFf2WIcvdBYXVTEUQJ5LuTg/1cEK7w0XPksFUvTLzZ0BwuSX
         4h3FgP9Jctoibtc1e6GfTumd9W+2zRF91sFdIu9SINOI7T3Z2gwLbKKxUT5D9y1Blm86
         kXuzE/BnL9/uLTShVTMOUcAQw61QV3yOvwPjs0nBxda2ciNLpXsYdRHaI9n5hnqOUraL
         HEchqUicHKhBBwCOGgxv5+b52EJHdyHqAEfrz/39CNJMAocXWISxjqAjmj/Ab/r5HGuB
         bpfUmBRGjAzeGK8cgZrj8QcLLu1Cnh42GCwNO8+eAxSDhBUaPMJGyTa0G0c0VUXLYaLQ
         amqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690880508; x=1691485308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwyto1QFsZ2jeAqiVCVI7asIYgAtksL73lrshA0wpgo=;
        b=H/RWsp2XBN1nh9gpOtYLU4n5+TPh9cSscBwoJAXumS2TNPFXr9QDrT8lo8pDa6mnOx
         nnRJJM+VF2Bb2ezV0jlfDnU+c1u7Wmaps1kX67DeZMUNHF3A3oig56/VkHDWtXWmNuP3
         sSHJSOegmZFmpBgFVojthRkfnthbzJyKzJbBMb5LAdDcj9xrakc9im0qtpJ+7OfAvPrN
         5Po3Dto4jZhUyduJpReekWvGPVQyxyTdwebORXOsYmcK0lHCjK3FWyvFYGCtu3s9D9PJ
         EK2R66E76tcI8Ai35sPADVW7jrgVOjthbjRz6we3XtqQb2wMl6UtuDJ22QBPA9K4y90w
         6s6w==
X-Gm-Message-State: ABy/qLYgZPS3dRTh8gAhdnWUWqnwJadztwNRcHppp+lrRzVjRW4WS/kf
        2vccLPLxDcZQkYhJn2CPhvbCSz/dughxcA==
X-Google-Smtp-Source: APBJJlGAMx9FctmI958cHsKiDCC6mhfuY35vspd5N962LCOAh9RlZF919nW0hnNKEMk/HXwUfpXrhQ==
X-Received: by 2002:a17:90a:a085:b0:268:535f:7c15 with SMTP id r5-20020a17090aa08500b00268535f7c15mr14611417pjp.0.1690880508158;
        Tue, 01 Aug 2023 02:01:48 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.20])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm1592523pjj.1.2023.08.01.02.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 02:01:47 -0700 (PDT)
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
Subject: [RFC PATCH v3 4/6] sched, tracing: reorganize fields of switch event struct
Date:   Tue,  1 Aug 2023 17:01:22 +0800
Message-Id: <20230801090124.8050-5-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230801090124.8050-1-zegao@tencent.com>
References: <20230801090124.8050-1-zegao@tencent.com>
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

Report priorities in 'short' and prev_state in 'int' to save
some buffer space. And also reorder the fields so that we take
struct alignment into consideration to make the record compact.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Ze Gao <zegao@tencent.com>
---
 include/trace/events/sched.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index e507901bcab8..36863ffb00c6 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -188,7 +188,7 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
 	     TP_ARGS(p));
 
 #ifdef CREATE_TRACE_POINTS
-static inline long __trace_sched_switch_state(bool preempt,
+static inline int __trace_sched_switch_state(bool preempt,
 					      unsigned int prev_state,
 					      struct task_struct *p)
 {
@@ -251,25 +251,25 @@ TRACE_EVENT(sched_switch,
 	TP_ARGS(preempt, prev, next, prev_state),
 
 	TP_STRUCT__entry(
-		__array(	char,	prev_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	prev_pid			)
-		__field(	int,	prev_prio			)
-		__field(	long,	prev_state			)
-		__field(	char,	prev_state_char			)
-		__array(	char,	next_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	next_pid			)
-		__field(	int,	next_prio			)
+		__field(	short,	prev_prio			)
+		__field(	short,	next_prio			)
+		__field(	int,	prev_state			)
+		__array(	char,	prev_comm,	TASK_COMM_LEN	)
+		__array(	char,	next_comm,	TASK_COMM_LEN	)
+		__field(	char,	prev_state_char			)
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
 		__entry->prev_pid		= prev->pid;
-		__entry->prev_prio		= prev->prio;
+		__entry->next_pid		= next->pid;
+		__entry->prev_prio		= (short) prev->prio;
+		__entry->next_prio		= (short) next->prio;
 		__entry->prev_state		= __trace_sched_switch_state(preempt, prev_state, prev);
 		__entry->prev_state_char	= __trace_sched_switch_state_char(preempt, prev_state, prev);
 		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
-		__entry->next_pid		= next->pid;
-		__entry->next_prio		= next->prio;
+		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
 		/* XXX SCHED_DEADLINE */
 	),
 
-- 
2.40.1

