Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90876CD7F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjHBMtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbjHBMtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:49:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FDB2D78;
        Wed,  2 Aug 2023 05:49:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26830595676so4780327a91.2;
        Wed, 02 Aug 2023 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690980544; x=1691585344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEZCAX1WlrsUv3nMNvtTambxp2M6PKeC7k4D0cytuU4=;
        b=lPf1TobbUrw1GTawCUCLEnAAjBp8pdwI/dfI2qxVqSsOzmaDY1I+0giZV4UOon5Bwx
         aaQF4Ez1LU7MqaKaQztnoUUnCEOS3Eo9ITZInVOl3qTGyypRbi/2ozpnE5g9DTNgvFDR
         x4gMWe1eSGUT5rT+cmAb9/RzoegOd+IagpZUOpNOvR1AP1oyn7kGFJiuAVsO5611TxVZ
         0Qc1Ey/L3IONZ+w8KjzFyGeDwiU9z/JfUJmzka7SXLJFWahWxjGZBoIEnuI506kn4zoc
         UOIyu73yPY4qu+P4tWN2r0kNbC+L+GnMCrnAJNhvdYENrTKBF0XRIFiJEvenJCK2iEeU
         hJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980544; x=1691585344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEZCAX1WlrsUv3nMNvtTambxp2M6PKeC7k4D0cytuU4=;
        b=Pj0b3DTgqw67I7VUbLwPIRSOaDMesxzjgztKph26jTS07v7fXyxpxLH+p+9H+3V2sl
         bRVSPnqFOFN7SsWtUMvGJQyEMWDUPcpZPFkEFSYRNkmpzlLFrl5w1ivV57ina8/avrTD
         XuiuNCBG2g73w8oVyHmNsozH9MrENKkXIqikhAzuoaZSX+t39trq8079akrxo8xAIz5x
         er9BVzC/nZe+cQnzusnsxxRnY8Ap17OX/orEQ2MNdaYPpxx5AvKos73rOPWCaNBweLIl
         MRJt+umsaGmwmASIOj4RbZ+VFPTOgA6OFdY1cWZPs9te+sEEfF/VIj3XHeigtUFTNgTy
         2JLg==
X-Gm-Message-State: ABy/qLaPzKukVWihMC7q7QpC4wSgWTitabpugKDopXq1chY4KGwbF1HP
        yShPyyzeNNs+BmOiZffaW8I=
X-Google-Smtp-Source: APBJJlGftl2PkKq0eq43TPyeopbrmeE6yjbx1dGMvYwvR4LfmIUg0CnVtmtReUApbmQhzTFdPXV2pQ==
X-Received: by 2002:a17:90b:350b:b0:268:634f:61f2 with SMTP id ls11-20020a17090b350b00b00268634f61f2mr15998891pjb.17.1690980543891;
        Wed, 02 Aug 2023 05:49:03 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.17])
        by smtp.googlemail.com with ESMTPSA id x34-20020a17090a6c2500b00264044cca0fsm4811993pjj.1.2023.08.02.05.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 05:49:03 -0700 (PDT)
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
Subject: [RFC PATCH v5 4/7] sched, tracing: reorganize fields of switch event struct
Date:   Wed,  2 Aug 2023 08:47:27 -0400
Message-ID: <20230802124840.335638-5-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802124840.335638-1-zegao@tencent.com>
References: <20230802124840.335638-1-zegao@tencent.com>
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

