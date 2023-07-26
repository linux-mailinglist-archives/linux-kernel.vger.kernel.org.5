Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C802676360D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjGZMQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjGZMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:16:37 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDB310F6;
        Wed, 26 Jul 2023 05:16:35 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3464c774f23so30945965ab.1;
        Wed, 26 Jul 2023 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690373795; x=1690978595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNtS9F3WTNQE3HkYohBKkdu8+BM/TX/VXbV+TW+htq8=;
        b=JDgd3f78clfCjnhOza+o4KM7mE7U7JJXcZPDO6I+F5KHhmnche6Fu+P1BIrzPyj7rw
         VZPW4B+n19JC+Xc9SvSmJkKmHaUlMbTBBQroCIU645dx+8XPnHp9Hpb334uueMjH9UBg
         J+x9/Pts58rKtA1B3ElJrj34ReusbA47AljbgwX7/ZO3Qj+2jO5r9xuy/o7Yf2LlRbAF
         WiCny5ApTLDgZ99KZC4++dgMijymsaGoesFv6Vegkr+au3GmLNRbECFYa1/227o5S26z
         CVgirl4WRdDNcKUpU8xsNrF6FnaGtulvkpQdQ8Ncb/djvhyitButfXYUfInPbRE0AH0O
         2nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690373795; x=1690978595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNtS9F3WTNQE3HkYohBKkdu8+BM/TX/VXbV+TW+htq8=;
        b=SWcXPyEfU7XYJ4z8Grvctv+AWPyYhG9A3UVQMRFv3lg3/PkAAZ4aUJ3mjmrPTJ4rq2
         s4MavVV+O25o9eu2AT36f8GP/hgXL/vLAeer+3AzqN+uuQQbRhmLO9C1DcsReilxUefB
         CFPnCsKVg/VHyBnMv6E4bY+gReYoxZlzAlrtWJanO0UfOVGvmb5nnYK1lwCabsBpU/7m
         +DjKEXtkI4yR68U0xO89KN1rAqAHhBcqNO3f+JA/q2plIiX2VmUA379DoJceTlDZpL22
         Ed3vGuB0Ls04xWfkh/PrDcxSmMmYMsB0FSkWruaTVXNWfqHwLB5sBL6VhtomsLsfthXv
         Qheg==
X-Gm-Message-State: ABy/qLaniIItj9NR5ibXOtbnJuKQg9ns0wgbGTMyfWaTdG/aTfKsC9cE
        FoF/DTgZ6jTjCMONHtcCtY8=
X-Google-Smtp-Source: APBJJlG6c1z+CkusDB+L0vw/xEMbf2SJ2s759KnIa3516NN53tLp0ztmHEnXwSdrixF4HGOYAjVl3A==
X-Received: by 2002:a92:c56d:0:b0:348:b07e:fd9e with SMTP id b13-20020a92c56d000000b00348b07efd9emr2096579ilj.16.1690373795086;
        Wed, 26 Jul 2023 05:16:35 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.25])
        by smtp.googlemail.com with ESMTPSA id ms19-20020a17090b235300b00263f446d432sm1172880pjb.43.2023.07.26.05.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:16:34 -0700 (PDT)
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
Subject: [RFC PATCH v2 2/3] perf sched: use the new prev_state_char instead in tracepoint sched_switch
Date:   Wed, 26 Jul 2023 20:16:17 +0800
Message-Id: <20230726121618.19198-3-zegao@tencent.com>
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

Since the sched_switch tracepoint introduces a new variable to
report sched-out task state in symbolic char, we switch to use
that instead to spare from knowing internal implementations
in kernel.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/builtin-sched.c | 57 +++++++-------------------------------
 1 file changed, 10 insertions(+), 47 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cc4ba506e119..e3b31d526bc8 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -92,24 +92,6 @@ struct sched_atom {
 	struct task_desc	*wakee;
 };
 
-#define TASK_STATE_TO_CHAR_STR "RSDTtZXxKWP"
-
-/* task state bitmask, copied from include/linux/sched.h */
-#define TASK_RUNNING		0
-#define TASK_INTERRUPTIBLE	1
-#define TASK_UNINTERRUPTIBLE	2
-#define __TASK_STOPPED		4
-#define __TASK_TRACED		8
-/* in tsk->exit_state */
-#define EXIT_DEAD		16
-#define EXIT_ZOMBIE		32
-#define EXIT_TRACE		(EXIT_ZOMBIE | EXIT_DEAD)
-/* in tsk->state again */
-#define TASK_DEAD		64
-#define TASK_WAKEKILL		128
-#define TASK_WAKING		256
-#define TASK_PARKED		512
-
 enum thread_state {
 	THREAD_SLEEPING = 0,
 	THREAD_WAIT_CPU,
@@ -266,7 +248,7 @@ struct thread_runtime {
 	u64 total_preempt_time;
 	u64 total_delay_time;
 
-	int last_state;
+	char last_state;
 
 	char shortname[3];
 	bool comm_changed;
@@ -436,7 +418,7 @@ static void add_sched_event_wakeup(struct perf_sched *sched, struct task_desc *t
 }
 
 static void add_sched_event_sleep(struct perf_sched *sched, struct task_desc *task,
-				  u64 timestamp, u64 task_state __maybe_unused)
+				  u64 timestamp, char task_state __maybe_unused)
 {
 	struct sched_atom *event = get_new_event(task, timestamp);
 
@@ -860,7 +842,7 @@ static int replay_switch_event(struct perf_sched *sched,
 		   *next_comm  = evsel__strval(evsel, sample, "next_comm");
 	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
 		  next_pid = evsel__intval(evsel, sample, "next_pid");
-	const u64 prev_state = evsel__intval(evsel, sample, "prev_state");
+	const char prev_state = evsel__intval(evsel, sample, "prev_state_char");
 	struct task_desc *prev, __maybe_unused *next;
 	u64 timestamp0, timestamp = sample->time;
 	int cpu = sample->cpu;
@@ -1050,13 +1032,6 @@ static int thread_atoms_insert(struct perf_sched *sched, struct thread *thread)
 	return 0;
 }
 
-static char sched_out_state(u64 prev_state)
-{
-	const char *str = TASK_STATE_TO_CHAR_STR;
-
-	return str[prev_state];
-}
-
 static int
 add_sched_out_event(struct work_atoms *atoms,
 		    char run_state,
@@ -1132,7 +1107,7 @@ static int latency_switch_event(struct perf_sched *sched,
 {
 	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
 		  next_pid = evsel__intval(evsel, sample, "next_pid");
-	const u64 prev_state = evsel__intval(evsel, sample, "prev_state");
+	const char prev_state = evsel__intval(evsel, sample, "prev_state_char");
 	struct work_atoms *out_events, *in_events;
 	struct thread *sched_out, *sched_in;
 	u64 timestamp0, timestamp = sample->time;
@@ -1168,7 +1143,7 @@ static int latency_switch_event(struct perf_sched *sched,
 			goto out_put;
 		}
 	}
-	if (add_sched_out_event(out_events, sched_out_state(prev_state), timestamp))
+	if (add_sched_out_event(out_events, prev_state, timestamp))
 		return -1;
 
 	in_events = thread_atoms_search(&sched->atom_root, sched_in, &sched->cmp_pid);
@@ -2026,24 +2001,12 @@ static void timehist_header(struct perf_sched *sched)
 	printf("\n");
 }
 
-static char task_state_char(struct thread *thread, int state)
-{
-	static const char state_to_char[] = TASK_STATE_TO_CHAR_STR;
-	unsigned bit = state ? ffs(state) : 0;
-
-	/* 'I' for idle */
-	if (thread->tid == 0)
-		return 'I';
-
-	return bit < sizeof(state_to_char) - 1 ? state_to_char[bit] : '?';
-}
-
 static void timehist_print_sample(struct perf_sched *sched,
 				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  struct addr_location *al,
 				  struct thread *thread,
-				  u64 t, int state)
+				  u64 t, char state)
 {
 	struct thread_runtime *tr = thread__priv(thread);
 	const char *next_comm = evsel__strval(evsel, sample, "next_comm");
@@ -2084,7 +2047,7 @@ static void timehist_print_sample(struct perf_sched *sched,
 	print_sched_time(tr->dt_run, 6);
 
 	if (sched->show_state)
-		printf(" %5c ", task_state_char(thread, state));
+		printf(" %5c ", thread->tid == 0 ? 'I' : state);
 
 	if (sched->show_next) {
 		snprintf(nstr, sizeof(nstr), "next: %s[%d]", next_comm, next_pid);
@@ -2156,9 +2119,9 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
 		else if (r->last_time) {
 			u64 dt_wait = tprev - r->last_time;
 
-			if (r->last_state == TASK_RUNNING)
+			if (r->last_state == 'R' || r->last_state == 'p')
 				r->dt_preempt = dt_wait;
-			else if (r->last_state == TASK_UNINTERRUPTIBLE)
+			else if (r->last_state == 'D')
 				r->dt_iowait = dt_wait;
 			else
 				r->dt_sleep = dt_wait;
@@ -2575,7 +2538,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 	struct thread_runtime *tr = NULL;
 	u64 tprev, t = sample->time;
 	int rc = 0;
-	int state = evsel__intval(evsel, sample, "prev_state");
+	char state = evsel__intval(evsel, sample, "prev_state_char");
 
 	if (machine__resolve(machine, &al, sample) < 0) {
 		pr_err("problem processing %d event. skipping it\n",
-- 
2.40.1

