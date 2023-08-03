Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44A276E342
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjHCIgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbjHCIgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:36:21 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D8611F;
        Thu,  3 Aug 2023 01:34:51 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-56ca1eebcd7so444841eaf.0;
        Thu, 03 Aug 2023 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691051690; x=1691656490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coQVZUIdITCOzeysZQXt4l056xN3FXYmzJxiupx3WHw=;
        b=od4Z3nXkFb2ruxjbXhUVYjA7VEjNrqjYqVRfIWS4yENSZ8YyawxHk2gFaODut66GXi
         QMTLtpTHRHlLrjWPtfIvFQi0PbNH0B5RIBnQtyj/b4q1EaH4jEMdWhjpA4b7nxqrQBKR
         QBoQg/tsr5ZgXitzUD83Z/iYAnREuTa6EyqFtthFCk/sclpqULlSbCgD4SZPEpTA4nME
         x2Ot8A/KIsWlmnExXdAoZcEb2erX23ziDZa7TXn0KIEqzR8QHyjyAVqquyHz16YiTggQ
         teiKO3JIyKUoxwD8raxR2CHSTK6MtBT1MwQcvh3G4fEHzDD1ctomVvlGYFKs36QoZJ70
         BeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691051690; x=1691656490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coQVZUIdITCOzeysZQXt4l056xN3FXYmzJxiupx3WHw=;
        b=YMw8VeSAqm1Yg2Cau3mhyQ60YlI4Cb5f0jq/RD6nfjhWrMuBS77CRy43ZDJ3c4ewnX
         qVwGezDkvW38hR9H3lagIZT1E4XsZsOhUkmSMPNTYy4dUe0qRqJbmE0J049/RhTYMry1
         cOt6c7h1+LskQAw9Yp1DhQuNaBmc0q/bqrHTIxmxs7JGbGpHUWbjFUmwIDldzge1FVWJ
         5yrcE4HTuS9cY/G82t+SF8HGWNY6iCQemcA963szCsdwdlPQjrCquWcpAIN85wZjsYhT
         73ZFlxUN146E203bBQCB9b0DpVu1sSTXo74IQhILEXP8mmLwPrgQsMKGY2VSqvbBa96t
         QyGA==
X-Gm-Message-State: ABy/qLYAsoeZZtRfcdRk55lVHCMBzDo834tbVDtA9TevKd7En9bqeEHB
        jMQpggKlUmF5Mwj6K1a23wY=
X-Google-Smtp-Source: APBJJlHosJbEqlQ3cDjlkkUfsBBDb5wexf21fjSkUspd2mRuPIJnNNYq68K+T1TXDUL/mzDY3dU5iA==
X-Received: by 2002:a05:6358:e499:b0:139:d226:b361 with SMTP id by25-20020a056358e49900b00139d226b361mr8646644rwb.31.1691051690070;
        Thu, 03 Aug 2023 01:34:50 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.googlemail.com with ESMTPSA id r6-20020a63b106000000b00563feb7113dsm12541876pgf.91.2023.08.03.01.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:34:49 -0700 (PDT)
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
Subject: [RFC PATCH v6 3/5] sched, tracing: reorganize fields of switch event struct
Date:   Thu,  3 Aug 2023 04:33:50 -0400
Message-ID: <20230803083352.1585-4-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803083352.1585-1-zegao@tencent.com>
References: <20230803083352.1585-1-zegao@tencent.com>
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

Report prioritiy and prev_state in 'short' to save some buffer
space. And also reorder the fields so that we take struct
alignment into consideration to make the record compact.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Ze Gao <zegao@tencent.com>
---
 include/trace/events/sched.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..43492daefa6f 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -187,14 +187,14 @@ DEFINE_EVENT(sched_wakeup_template, sched_wakeup_new,
 	     TP_ARGS(p));
 
 #ifdef CREATE_TRACE_POINTS
-static inline long __trace_sched_switch_state(bool preempt,
+static inline short __trace_sched_switch_state(bool preempt,
 					      unsigned int prev_state,
 					      struct task_struct *p)
 {
 	unsigned int state;
 
 #ifdef CONFIG_SCHED_DEBUG
-	BUG_ON(p != current);
+	WARN_ON_ONCE(p != current);
 #endif /* CONFIG_SCHED_DEBUG */
 
 	/*
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
+		__array(	char,	prev_comm,	TASK_COMM_LEN	)
+		__array(	char,	next_comm,	TASK_COMM_LEN	)
+		__field(	short,	prev_state			)
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
 		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
-		__entry->next_pid	= next->pid;
-		__entry->next_prio	= next->prio;
+		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+		__entry->prev_state		= __trace_sched_switch_state(preempt, prev_state, prev);
 		/* XXX SCHED_DEADLINE */
 	),
 
-- 
2.41.0

