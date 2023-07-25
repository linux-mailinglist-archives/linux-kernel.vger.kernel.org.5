Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E917760BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjGYH1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjGYH02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:26:28 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3AC1BCD;
        Tue, 25 Jul 2023 00:23:13 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-345d3c10bdfso20959025ab.2;
        Tue, 25 Jul 2023 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690269793; x=1690874593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmUBsd+tZoS42f/xnaNOMHrSi2QJyg5RglNDqx3WC8U=;
        b=b+FqgXu3l472HbqYYF78SuQCousvxZV9bEimo83Y49v2vCNc6f77H0cbp6sp01GFSj
         FNUL/KAHGErJyWk0tJFIZXGsPJ4v4Wj4Yr/rpeygp3Igsq+vCEvVvQ22usgVLm6GGW7S
         vU0rgPdrPJHbxBn+RLmT/kPIHC/YcfLan681ZovoTyYTwefSQVIQySOVQT5Wc70wIdGM
         Rhj0H5HU4JARsulx9/QQFrwfOwfUxDzwB4Ay3yg9K7I5FELdilsKkdvvPt1FIaMDJNh6
         0SVnru76z8/pyUFUQunET5WbloIDngd5Qy4d5GerjgTzs7AYvCA0XIrf7U6rc8d8Op/Z
         VXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690269793; x=1690874593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmUBsd+tZoS42f/xnaNOMHrSi2QJyg5RglNDqx3WC8U=;
        b=Vuwipw2NxKSqd/MIKmXmOS+ZpIHwis6Kxy6BJ69TdCegZyP121lBtZPj/OBkJqry3V
         dF0xJUaPZEudfVF6Y9zACJ55lUhvZ27jM6Rl90eOHUN3deFGz0QGcp/+/BUKlCu8DJjl
         34zpsm8GZSBl7MmTMM62ims80M1F+iA5OzrG5q/1lHaVcQMh1oaM3IxT3536ZDi8x8vJ
         461gkeMme9BLDhC8dQu0fPAJKvbiPl0I8tJv5bTUXytnIyrMNEZPbxUWhYzYBxntrtW8
         3r/LUcqkcUts02xgWI+dYMYoARg8cgqgqqiZkGe/2fPH2bBLL7WroeuXozWmOqU13R6c
         4seQ==
X-Gm-Message-State: ABy/qLYZXnsDTxFJbXC/5A0DDw7kr6bIdb7bmTvGlU8haoBmd/Tjvanm
        GEeJKZP43qLeCUUSnZ9HS4A=
X-Google-Smtp-Source: APBJJlFW/6z6OfUR9BTv/F6iIA3ht/bvYqzBeh26zr0CYG9HyhTMho52YB1UZ+0wHMW92XuBUN+RdA==
X-Received: by 2002:a05:6e02:12cf:b0:345:d58d:9ade with SMTP id i15-20020a056e0212cf00b00345d58d9ademr2766206ilm.3.1690269793087;
        Tue, 25 Jul 2023 00:23:13 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.82])
        by smtp.googlemail.com with ESMTPSA id d12-20020a63734c000000b0055acfd94c20sm9863908pgn.35.2023.07.25.00.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:23:12 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH 2/3] perf sched: sync with latest sched_switch tracepoint definition
Date:   Tue, 25 Jul 2023 15:22:53 +0800
Message-Id: <20230725072254.32045-3-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230725072254.32045-1-zegao@tencent.com>
References: <20230725072254.32045-1-zegao@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since tracepoint sched_switch changes its reported task state type,
update the parsing logic accordingly.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/builtin-sched.c | 55 +++++++-------------------------------
 1 file changed, 9 insertions(+), 46 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cc4ba506e119..b92f376fdd9a 100644
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
@@ -860,7 +842,7 @@ static int replay_switch_event(struct perf_sched *sched,
 		   *next_comm  = evsel__strval(evsel, sample, "next_comm");
 	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
 		  next_pid = evsel__intval(evsel, sample, "next_pid");
-	const u64 prev_state = evsel__intval(evsel, sample, "prev_state");
+	const char prev_state = evsel__intval(evsel, sample, "prev_state");
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
+	const char prev_state = evsel__intval(evsel, sample, "prev_state");
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
+	char state = evsel__intval(evsel, sample, "prev_state");
 
 	if (machine__resolve(machine, &al, sample) < 0) {
 		pr_err("problem processing %d event. skipping it\n",
-- 
2.40.1

