Return-Path: <linux-kernel+bounces-32412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F0835B69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84391C21545
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A88A1643D;
	Mon, 22 Jan 2024 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2v3DQfn"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A56D1549F;
	Mon, 22 Jan 2024 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907463; cv=none; b=PurFz2/5y8f314VooCYT+Wbx2UAsQO4VJhdxQ9/PQVXrcHNu5dcDmgKEdlzu2Xc4EQK5EoI/ctA+plMNciCBILriQ0AhcY/L0t5/CSg7TWBUhR8mwZbV0+X1l1xsjcpnZkb4sIuHlvfekPdi4LhEIzaP95hOAZWaoUOKaYhDKkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907463; c=relaxed/simple;
	bh=GiCGWYYpI/zBmzmXTbTU7hU/gSeRqY9wIRiNhNMugk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHvQVQ14lbgALzqDWbGGrmhm3yzfD7a9k8PZhe+FXjnN7XPNcFBAhUnqMMklKcBEpYvkGyKnveMMwi83mDYT3VmxrN5UyEoTtw+RIAnyFFD63zVtMV4xZmFb8xq4Rgp4K7pudjc4p7RupmzYGTRh6VHxbdAssnQbOR9m6bjeYD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2v3DQfn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d51ba18e1bso25148275ad.0;
        Sun, 21 Jan 2024 23:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705907461; x=1706512261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZ5LQrtGOef2RhCQexh0DzGghwnp1zT6hJb7zIaDJYU=;
        b=j2v3DQfn5mK8AoWP+TzKsd6QnToH0h7yJH88PMANbvIy+ZnxB1HnmiZHe/lK9FvS++
         rxLMzyVNNb+bCDVjyAY4wiOCMnVZHM3efOSxeoWxCjkwAj4fUflqhH+0KbuDgsKHILWv
         cNv85NtKBoIc2ci74HqzB4trpAF39wBZPz+4n4e/yaxFfgvfQGUy7D7UkV3PTh92az6X
         qL1pJTlqs78SRV0SIqJVdGuvaV2s1VsWf/S8XfwXSor6kr3AnKVisXxXtLaMbILNgLSl
         wzoVAjCnBfR2WKFQJByvFsWA2jWsExnoFfSu2SeKqbaOQOhQIrlDogVVeks2SNvK4Tht
         FFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907461; x=1706512261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZ5LQrtGOef2RhCQexh0DzGghwnp1zT6hJb7zIaDJYU=;
        b=hLg5z8iXnZep8Gd4v4Pn1fG17Jrs6o1Fpl21Ol2z9+eaX/1q3PaPcZI74Zgc1kxuBX
         /A5f1R3mFgmeNUeuYL1SoFCsOUbOVc+1VAqYo+If+ge1G2RUK3W0kL1zTNnWajvbxs4Q
         pPZGtyfkRkEYRUJ07NLS68laXygt4Np64p1sV782iaaZVYZw7ugtf8duHFsker40kBHn
         ofXnOzescvy00Qvf5wh/3wHT6dqEdgl8niS0npmeIQYsAnNe4NjuJ25FEuLY+ZNFZYAg
         2uC0a0otLjGidndpVXVT+YNmRhomyWXOnKjE2eqdEUBcIarfnM7x6gI6uIo4yl7ENwog
         Ow/g==
X-Gm-Message-State: AOJu0YwEocY8rPhfsYqdMXWw9nI4xOmW2aeGaRbxnQs1+ckYACDlZ8g7
	NmZy5J847kZmokIwrs6iOwM1DDani2xZTxnPTpxHrWO/C8LrsEyn
X-Google-Smtp-Source: AGHT+IH8N/aRIYyc67Ff6jyaVTTxBKkJJGE87EtIPf5gzDu/V/a/IH1tcJTXnt029qA6gCu/mB7xrw==
X-Received: by 2002:a17:902:e852:b0:1d7:41b7:332b with SMTP id t18-20020a170902e85200b001d741b7332bmr3187637plg.14.1705907461571;
        Sun, 21 Jan 2024 23:11:01 -0800 (PST)
Received: from localhost.localdomain ([43.132.98.45])
        by smtp.googlemail.com with ESMTPSA id t10-20020a170902d28a00b001d72b3b0ee6sm3463365plc.248.2024.01.21.23.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 23:11:01 -0800 (PST)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ze Gao <zegao@tencent.com>
Subject: [PATCH v2 4/4] perf sched: Commit to evsel__taskstate() to parse task state info
Date: Mon, 22 Jan 2024 02:08:59 -0500
Message-ID: <20240122070859.1394479-6-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240122070859.1394479-2-zegao@tencent.com>
References: <20240122070859.1394479-2-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have evsel__taskstate() which no longer relies on the
hardcoded task state string and has good backward compatibility,
we have a good reason to use it.

Note TASK_STATE_TO_CHAR_STR and task bitmasks are useless now so
we remove them for good. And now we pass the state info back and
forth in a symbolic char which explains itself well instead.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 tools/perf/builtin-sched.c | 46 +++++++++-----------------------------
 1 file changed, 10 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index ced6fffe8110..f1d62f6b6cab 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -92,13 +92,6 @@ struct sched_atom {
 	struct task_desc	*wakee;
 };
 
-#define TASK_STATE_TO_CHAR_STR "RSDTtXZPI"
-
-/* task state bitmask, copied from include/linux/sched.h */
-#define TASK_RUNNING		0
-#define TASK_INTERRUPTIBLE	1
-#define TASK_UNINTERRUPTIBLE	2
-
 enum thread_state {
 	THREAD_SLEEPING = 0,
 	THREAD_WAIT_CPU,
@@ -255,7 +248,7 @@ struct thread_runtime {
 	u64 total_preempt_time;
 	u64 total_delay_time;
 
-	int last_state;
+	char last_state;
 
 	char shortname[3];
 	bool comm_changed;
@@ -425,7 +418,7 @@ static void add_sched_event_wakeup(struct perf_sched *sched, struct task_desc *t
 }
 
 static void add_sched_event_sleep(struct perf_sched *sched, struct task_desc *task,
-				  u64 timestamp, u64 task_state __maybe_unused)
+				  u64 timestamp, const char task_state __maybe_unused)
 {
 	struct sched_atom *event = get_new_event(task, timestamp);
 
@@ -849,7 +842,7 @@ static int replay_switch_event(struct perf_sched *sched,
 		   *next_comm  = evsel__strval(evsel, sample, "next_comm");
 	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
 		  next_pid = evsel__intval(evsel, sample, "next_pid");
-	const u64 prev_state = evsel__intval(evsel, sample, "prev_state");
+	const char prev_state = evsel__taskstate(evsel, sample, "prev_state");
 	struct task_desc *prev, __maybe_unused *next;
 	u64 timestamp0, timestamp = sample->time;
 	int cpu = sample->cpu;
@@ -1039,13 +1032,6 @@ static int thread_atoms_insert(struct perf_sched *sched, struct thread *thread)
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
@@ -1121,7 +1107,7 @@ static int latency_switch_event(struct perf_sched *sched,
 {
 	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
 		  next_pid = evsel__intval(evsel, sample, "next_pid");
-	const u64 prev_state = evsel__intval(evsel, sample, "prev_state");
+	const char prev_state = evsel__taskstate(evsel, sample, "prev_state");
 	struct work_atoms *out_events, *in_events;
 	struct thread *sched_out, *sched_in;
 	u64 timestamp0, timestamp = sample->time;
@@ -1157,7 +1143,7 @@ static int latency_switch_event(struct perf_sched *sched,
 			goto out_put;
 		}
 	}
-	if (add_sched_out_event(out_events, sched_out_state(prev_state), timestamp))
+	if (add_sched_out_event(out_events, prev_state, timestamp))
 		return -1;
 
 	in_events = thread_atoms_search(&sched->atom_root, sched_in, &sched->cmp_pid);
@@ -2022,24 +2008,12 @@ static void timehist_header(struct perf_sched *sched)
 	printf("\n");
 }
 
-static char task_state_char(struct thread *thread, int state)
-{
-	static const char state_to_char[] = TASK_STATE_TO_CHAR_STR;
-	unsigned bit = state ? ffs(state) : 0;
-
-	/* 'I' for idle */
-	if (thread__tid(thread) == 0)
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
+				  u64 t, const char state)
 {
 	struct thread_runtime *tr = thread__priv(thread);
 	const char *next_comm = evsel__strval(evsel, sample, "next_comm");
@@ -2080,7 +2054,7 @@ static void timehist_print_sample(struct perf_sched *sched,
 	print_sched_time(tr->dt_run, 6);
 
 	if (sched->show_state)
-		printf(" %5c ", task_state_char(thread, state));
+		printf(" %5c ", thread->tid == 0 ? 'I' : state);
 
 	if (sched->show_next) {
 		snprintf(nstr, sizeof(nstr), "next: %s[%d]", next_comm, next_pid);
@@ -2152,9 +2126,9 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
 		else if (r->last_time) {
 			u64 dt_wait = tprev - r->last_time;
 
-			if (r->last_state == TASK_RUNNING)
+			if (r->last_state == 'R')
 				r->dt_preempt = dt_wait;
-			else if (r->last_state == TASK_UNINTERRUPTIBLE)
+			else if (r->last_state == 'D')
 				r->dt_iowait = dt_wait;
 			else
 				r->dt_sleep = dt_wait;
@@ -2579,7 +2553,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 	struct thread_runtime *tr = NULL;
 	u64 tprev, t = sample->time;
 	int rc = 0;
-	int state = evsel__intval(evsel, sample, "prev_state");
+	const char state = evsel__taskstate(evsel, sample, "prev_state");
 
 	addr_location__init(&al);
 	if (machine__resolve(machine, &al, sample) < 0) {
-- 
2.41.0


