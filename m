Return-Path: <linux-kernel+bounces-87933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2A186DB30
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB06283776
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182551C2C;
	Fri,  1 Mar 2024 05:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="20uIoqtE"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A7537F0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709271423; cv=none; b=Qk3g4iX68vefml2MOLGEjJnVT2twNBj9kAs7xMA1fnblJxXdRIRXJUB5ZTuUQXboxwC8GUWLnA1+f22waVryIEgfuZ1FDyCToPlsviXhubBxLGA8W9RXHMIVmxhZJ+c0XAQfKFr4tGcD43c15Rm8QTf7VF0VL1zHGvpFsiud9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709271423; c=relaxed/simple;
	bh=fBqMdgvBqvnAASN42/FlvI+/RXHkBdraQJ/XUtdnEI0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=e8P+g6wfvrYWkeS7KnqArE/Igujv+cwYLECS4usibdge7cKnkVcopPEO2Vnx48N2iIOAj8GdH/eXRcmC5gn2qB49Rg1pJPFp3feI8efd9gJaeP4mHhKYPoBtdHyfiTl3EO4zev8hsiEJVAboXWs2pQ3PQvhQ++x8MF8GGds88F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=20uIoqtE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so2986939276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709271421; x=1709876221; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yj/vjiBWUOYkXpVUJ7tJ/QYC18JIl7FM2VJjItok3Cs=;
        b=20uIoqtEdLVwH+SH8ZxBPQ7FRu6fI9GkAKR9aNsJ02ebh/7o5oiRHK5jF73gBjaUDA
         IeuSkQkRoQladik3h/BY+YQppf/B5NJ2fZ2dVfrPRTaKG9MlvZfLbkZ7w5T+pSx7pbTh
         thMNTKFKJziDC3DCqK9MbubSabryixtoyRCOloLdrQbJ93C93aIbJBk8bk3JwjM1v3j2
         /s1L36ssMu9w6bw/8wBjyukND9CGlsqhkMV5qeZ0lezyJhV/TLVsMqPYloiBPY9PTnLR
         VnSxI7zDVro2TjDno+mxTqxc/K/yY3mMAG86JmaD9iVuFWLpYGrPQglFQMFlX19yNKur
         FPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709271421; x=1709876221;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yj/vjiBWUOYkXpVUJ7tJ/QYC18JIl7FM2VJjItok3Cs=;
        b=PMm6BkMPBQ3ALxq1b9EEPuSAUWnLuIaQI4DGkO7Yf4SvMdA6BYwhbqaKS79sjWcEGB
         G/Vuvkj4CeU6db4D4xHx8FArEGfQF9BZGu7wrFbJ1gx/oDXoJ3djORmVW2+xIYMllO3b
         zC14JIl2Cj6ltsHRN1uhLZVDwK/oP6wvDjEC0wj4zTzXRqX+SvO5lWSD26nIMeFGZzhM
         wxf9Hq6G9DnC84zw00GweT4AfP1X4QuL/nML6qJk9hz49hmOwWICD4NGPl2IoWmhAEEK
         yZALskzAaNU/dgh35063gPf7cLKVZ8Vw5ce0/GT592APEsOKTN1UiVVQuQtxmh/wObia
         iEfA==
X-Forwarded-Encrypted: i=1; AJvYcCWcLfGJBDHjgjVYcnNKY/y9G2BRQImvqLTnKjhFmQA0g2GGhcPDLuDPGdnb3K/liJsVkXFHXwgpH8e3TxD/oa1kheTTViDyboIMpr73
X-Gm-Message-State: AOJu0YxJNOSZOueDeaM+aXO68l1cATEc2H03qfvGXwLEjK/WT35oB04q
	akIm8kC2H2iatX2rzBDcYoH2doKJE5wxlMzlcA5j3zi/pA3Oo35Jc9UyjczxEwRCoZ4a5dEBOzn
	ensvY5w==
X-Google-Smtp-Source: AGHT+IEaHoc5FS/aXnmu4l9AbUxfirmqvnksQO/BwYEX8z8lTz4eIYHpeD6QiKMzA0tuN9nBMiaFEJaOLd4t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:100a:b0:dc7:5aad:8965 with SMTP
 id w10-20020a056902100a00b00dc75aad8965mr157192ybt.0.1709271420887; Thu, 29
 Feb 2024 21:37:00 -0800 (PST)
Date: Thu, 29 Feb 2024 21:36:42 -0800
In-Reply-To: <20240301053646.1449657-1-irogers@google.com>
Message-Id: <20240301053646.1449657-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301053646.1449657-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v4 4/7] perf machine: Move machine's threads into its own abstraction
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move thread_rb_node into the machine.c file. This hides the
implementation of threads from the rest of the code allowing for it to
be refactored.

Locking discipline is tightened up in this change. As the lock is now
encapsulated in threads, the findnew function requires holding it (as
it already did in machine). Rather than do conditionals with locks
based on whether the thread should be created (which could potentially
be error prone with a read lock match with a write unlock), have a
separate threads__find that won't create the thread and only holds the
read lock. This effectively duplicates the findnew logic, with the
existing findnew logic only operating under a write lock assuming
creation is necessary as a previous find failed. The creation may
still fail with the write lock due to another thread. The duplication
is removed in a later next patch that delegates the implementation to
hashtable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_lock_contention.c |   4 +-
 tools/perf/util/machine.c             | 408 ++++++++++++++------------
 tools/perf/util/machine.h             |  26 +-
 tools/perf/util/thread.c              |   2 +-
 tools/perf/util/thread.h              |   6 -
 5 files changed, 243 insertions(+), 203 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 3549180c7885..b4cb3fe5cc25 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -328,7 +328,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 
 		/* do not update idle comm which contains CPU number */
 		if (pid) {
-			struct thread *t = __machine__findnew_thread(machine, /*pid=*/-1, pid);
+			struct thread *t = machine__findnew_thread(machine, /*pid=*/-1, pid);
 
 			if (t == NULL)
 				return name;
@@ -422,7 +422,7 @@ int lock_contention_read(struct lock_contention *con)
 	account_end_timestamp(con);
 
 	if (con->aggr_mode == LOCK_AGGR_TASK) {
-		struct thread *idle = __machine__findnew_thread(machine,
+		struct thread *idle = machine__findnew_thread(machine,
 								/*pid=*/0,
 								/*tid=*/0);
 		thread__set_comm(idle, "swapper", /*timestamp=*/0);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e072b2115b64..224b53b4bfe2 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -43,8 +43,16 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
-static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
-				     struct thread *th, bool lock);
+struct thread_rb_node {
+	struct rb_node rb_node;
+	struct thread *thread;
+};
+
+static struct threads_table_entry *threads__table(struct threads *threads, pid_t tid)
+{
+	/* Cast it to handle tid == -1 */
+	return &threads->table[(unsigned int)tid % THREADS__TABLE_SIZE];
+}
 
 static struct dso *machine__kernel_dso(struct machine *machine)
 {
@@ -58,35 +66,18 @@ static void dsos__init(struct dsos *dsos)
 	init_rwsem(&dsos->lock);
 }
 
-static void machine__threads_init(struct machine *machine)
+void threads__init(struct threads *threads)
 {
-	int i;
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
 
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
-		threads->entries = RB_ROOT_CACHED;
-		init_rwsem(&threads->lock);
-		threads->nr = 0;
-		threads->last_match = NULL;
+		table->entries = RB_ROOT_CACHED;
+		init_rwsem(&table->lock);
+		table->nr = 0;
+		table->last_match = NULL;
 	}
 }
 
-static int thread_rb_node__cmp_tid(const void *key, const struct rb_node *nd)
-{
-	int to_find = (int) *((pid_t *)key);
-
-	return to_find - (int)thread__tid(rb_entry(nd, struct thread_rb_node, rb_node)->thread);
-}
-
-static struct thread_rb_node *thread_rb_node__find(const struct thread *th,
-						   struct rb_root *tree)
-{
-	pid_t to_find = thread__tid(th);
-	struct rb_node *nd = rb_find(&to_find, tree, thread_rb_node__cmp_tid);
-
-	return rb_entry(nd, struct thread_rb_node, rb_node);
-}
-
 static int machine__set_mmap_name(struct machine *machine)
 {
 	if (machine__is_host(machine))
@@ -120,7 +111,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	RB_CLEAR_NODE(&machine->rb_node);
 	dsos__init(&machine->dsos);
 
-	machine__threads_init(machine);
+	threads__init(&machine->threads);
 
 	machine->vdso_info = NULL;
 	machine->env = NULL;
@@ -219,29 +210,51 @@ static void dsos__exit(struct dsos *dsos)
 	exit_rwsem(&dsos->lock);
 }
 
-void machine__delete_threads(struct machine *machine)
+static void __threads_table_entry__set_last_match(struct threads_table_entry *table,
+						  struct thread *th);
+
+void threads__remove_all_threads(struct threads *threads)
 {
-	struct rb_node *nd;
-	int i;
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+		struct rb_node *nd;
 
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
-		down_write(&threads->lock);
-		nd = rb_first_cached(&threads->entries);
+		down_write(&table->lock);
+		__threads_table_entry__set_last_match(table, NULL);
+		nd = rb_first_cached(&table->entries);
 		while (nd) {
 			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
 
 			nd = rb_next(nd);
-			__machine__remove_thread(machine, trb, trb->thread, false);
+			thread__put(trb->thread);
+			rb_erase_cached(&trb->rb_node, &table->entries);
+			RB_CLEAR_NODE(&trb->rb_node);
+			--table->nr;
+
+			free(trb);
 		}
-		up_write(&threads->lock);
+		assert(table->nr == 0);
+		up_write(&table->lock);
 	}
 }
 
-void machine__exit(struct machine *machine)
+void machine__delete_threads(struct machine *machine)
 {
-	int i;
+	threads__remove_all_threads(&machine->threads);
+}
+
+void threads__exit(struct threads *threads)
+{
+	threads__remove_all_threads(threads);
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+
+		exit_rwsem(&table->lock);
+	}
+}
 
+void machine__exit(struct machine *machine)
+{
 	if (machine == NULL)
 		return;
 
@@ -254,12 +267,7 @@ void machine__exit(struct machine *machine)
 	zfree(&machine->current_tid);
 	zfree(&machine->kallsyms_filename);
 
-	machine__delete_threads(machine);
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		struct threads *threads = &machine->threads[i];
-
-		exit_rwsem(&threads->lock);
-	}
+	threads__exit(&machine->threads);
 }
 
 void machine__delete(struct machine *machine)
@@ -526,7 +534,7 @@ static void machine__update_thread_pid(struct machine *machine,
 	if (thread__pid(th) == thread__tid(th))
 		return;
 
-	leader = __machine__findnew_thread(machine, thread__pid(th), thread__pid(th));
+	leader = machine__findnew_thread(machine, thread__pid(th), thread__pid(th));
 	if (!leader)
 		goto out_err;
 
@@ -565,78 +573,88 @@ static void machine__update_thread_pid(struct machine *machine,
  * so most of the time we dont have to look up
  * the full rbtree:
  */
-static struct thread*
-__threads__get_last_match(struct threads *threads, struct machine *machine,
-			  int pid, int tid)
+static struct thread *__threads_table_entry__get_last_match(struct threads_table_entry *table,
+							    pid_t tid)
 {
-	struct thread *th;
+	struct thread *th, *res = NULL;
 
-	th = threads->last_match;
+	th = table->last_match;
 	if (th != NULL) {
-		if (thread__tid(th) == tid) {
-			machine__update_thread_pid(machine, th, pid);
-			return thread__get(th);
-		}
-		thread__put(threads->last_match);
-		threads->last_match = NULL;
+		if (thread__tid(th) == tid)
+			res = thread__get(th);
 	}
-
-	return NULL;
+	return res;
 }
 
-static struct thread*
-threads__get_last_match(struct threads *threads, struct machine *machine,
-			int pid, int tid)
+static void __threads_table_entry__set_last_match(struct threads_table_entry *table,
+						  struct thread *th)
 {
-	struct thread *th = NULL;
-
-	if (perf_singlethreaded)
-		th = __threads__get_last_match(threads, machine, pid, tid);
-
-	return th;
+	thread__put(table->last_match);
+	table->last_match = thread__get(th);
 }
 
-static void
-__threads__set_last_match(struct threads *threads, struct thread *th)
+static void threads_table_entry__set_last_match(struct threads_table_entry *table,
+						struct thread *th)
 {
-	thread__put(threads->last_match);
-	threads->last_match = thread__get(th);
+	down_write(&table->lock);
+	__threads_table_entry__set_last_match(table, th);
+	up_write(&table->lock);
 }
 
-static void
-threads__set_last_match(struct threads *threads, struct thread *th)
+struct thread *threads__find(struct threads *threads, pid_t tid)
 {
-	if (perf_singlethreaded)
-		__threads__set_last_match(threads, th);
+	struct threads_table_entry *table  = threads__table(threads, tid);
+	struct rb_node **p;
+	struct thread *res = NULL;
+
+	down_read(&table->lock);
+	res = __threads_table_entry__get_last_match(table, tid);
+	if (res)
+		return res;
+
+	p = &table->entries.rb_root.rb_node;
+	while (*p != NULL) {
+		struct rb_node *parent = *p;
+		struct thread *th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
+
+		if (thread__tid(th) == tid) {
+			res = thread__get(th);
+			break;
+		}
+
+		if (tid < thread__tid(th))
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	up_read(&table->lock);
+	if (res)
+		threads_table_entry__set_last_match(table, res);
+	return res;
 }
 
-/*
- * Caller must eventually drop thread->refcnt returned with a successful
- * lookup/new thread inserted.
- */
-static struct thread *____machine__findnew_thread(struct machine *machine,
-						  struct threads *threads,
-						  pid_t pid, pid_t tid,
-						  bool create)
+struct thread *threads__findnew(struct threads *threads, pid_t pid, pid_t tid, bool *created)
 {
-	struct rb_node **p = &threads->entries.rb_root.rb_node;
+	struct threads_table_entry *table  = threads__table(threads, tid);
+	struct rb_node **p;
 	struct rb_node *parent = NULL;
-	struct thread *th;
+	struct thread *res = NULL;
 	struct thread_rb_node *nd;
 	bool leftmost = true;
 
-	th = threads__get_last_match(threads, machine, pid, tid);
-	if (th)
-		return th;
-
+	*created = false;
+	down_write(&table->lock);
+	p = &table->entries.rb_root.rb_node;
 	while (*p != NULL) {
+		struct thread *th;
+
 		parent = *p;
 		th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
 
 		if (thread__tid(th) == tid) {
-			threads__set_last_match(threads, th);
-			machine__update_thread_pid(machine, th, pid);
-			return thread__get(th);
+			__threads_table_entry__set_last_match(table, th);
+			res = thread__get(th);
+			goto out_unlock;
 		}
 
 		if (tid < thread__tid(th))
@@ -646,74 +664,76 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 			leftmost = false;
 		}
 	}
+	nd = malloc(sizeof(*nd));
+	if (nd == NULL)
+		goto out_unlock;
+	res = thread__new(pid, tid);
+	if (!res)
+		free(nd);
+	else {
+		*created = true;
+		nd->thread = thread__get(res);
+		rb_link_node(&nd->rb_node, parent, p);
+		rb_insert_color_cached(&nd->rb_node, &table->entries, leftmost);
+		++table->nr;
+		__threads_table_entry__set_last_match(table, res);
+	}
+out_unlock:
+	up_write(&table->lock);
+	return res;
+}
 
-	if (!create)
-		return NULL;
-
-	th = thread__new(pid, tid);
-	if (th == NULL)
-		return NULL;
+/*
+ * Caller must eventually drop thread->refcnt returned with a successful
+ * lookup/new thread inserted.
+ */
+static struct thread *__machine__findnew_thread(struct machine *machine,
+						pid_t pid,
+						pid_t tid,
+						bool create)
+{
+	struct thread *th = threads__find(&machine->threads, tid);
+	bool created;
 
-	nd = malloc(sizeof(*nd));
-	if (nd == NULL) {
-		thread__put(th);
-		return NULL;
+	if (th) {
+		machine__update_thread_pid(machine, th, pid);
+		return th;
 	}
-	nd->thread = th;
 
-	rb_link_node(&nd->rb_node, parent, p);
-	rb_insert_color_cached(&nd->rb_node, &threads->entries, leftmost);
-	/*
-	 * We have to initialize maps separately after rb tree is updated.
-	 *
-	 * The reason is that we call machine__findnew_thread within
-	 * thread__init_maps to find the thread leader and that would screwed
-	 * the rb tree.
-	 */
-	if (thread__init_maps(th, machine)) {
-		pr_err("Thread init failed thread %d\n", pid);
-		rb_erase_cached(&nd->rb_node, &threads->entries);
-		RB_CLEAR_NODE(&nd->rb_node);
-		free(nd);
-		thread__put(th);
+	if (!create)
 		return NULL;
-	}
-	/*
-	 * It is now in the rbtree, get a ref
-	 */
-	threads__set_last_match(threads, th);
-	++threads->nr;
 
-	return thread__get(th);
-}
+	th = threads__findnew(&machine->threads, pid, tid, &created);
+	if (created) {
+		/*
+		 * We have to initialize maps separately after rb tree is
+		 * updated.
+		 *
+		 * The reason is that we call machine__findnew_thread within
+		 * thread__init_maps to find the thread leader and that would
+		 * screwed the rb tree.
+		 */
+		if (thread__init_maps(th, machine)) {
+			pr_err("Thread init failed thread %d\n", pid);
+			threads__remove(&machine->threads, th);
+			thread__put(th);
+			return NULL;
+		}
+	} else
+		machine__update_thread_pid(machine, th, pid);
 
-struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid)
-{
-	return ____machine__findnew_thread(machine, machine__threads(machine, tid), pid, tid, true);
+	return th;
 }
 
-struct thread *machine__findnew_thread(struct machine *machine, pid_t pid,
-				       pid_t tid)
+struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid)
 {
-	struct threads *threads = machine__threads(machine, tid);
-	struct thread *th;
-
-	down_write(&threads->lock);
-	th = __machine__findnew_thread(machine, pid, tid);
-	up_write(&threads->lock);
-	return th;
+	return __machine__findnew_thread(machine, pid, tid, /*create=*/true);
 }
 
 struct thread *machine__find_thread(struct machine *machine, pid_t pid,
 				    pid_t tid)
 {
-	struct threads *threads = machine__threads(machine, tid);
-	struct thread *th;
-
-	down_read(&threads->lock);
-	th =  ____machine__findnew_thread(machine, threads, pid, tid, false);
-	up_read(&threads->lock);
-	return th;
+	return __machine__findnew_thread(machine, pid, tid, /*create=*/false);
 }
 
 /*
@@ -1127,13 +1147,17 @@ static int machine_fprintf_cb(struct thread *thread, void *data)
 	return 0;
 }
 
-static size_t machine__threads_nr(const struct machine *machine)
+size_t threads__nr(struct threads *threads)
 {
 	size_t nr = 0;
 
-	for (int i = 0; i < THREADS__TABLE_SIZE; i++)
-		nr += machine->threads[i].nr;
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
 
+		down_read(&table->lock);
+		nr += table->nr;
+		up_read(&table->lock);
+	}
 	return nr;
 }
 
@@ -1143,7 +1167,7 @@ size_t machine__fprintf(struct machine *machine, FILE *fp)
 		.fp = fp,
 		.printed = 0,
 	};
-	size_t ret = fprintf(fp, "Threads: %zu\n", machine__threads_nr(machine));
+	size_t ret = fprintf(fp, "Threads: %zu\n", threads__nr(&machine->threads));
 
 	machine__for_each_thread(machine, machine_fprintf_cb, &args);
 	return ret + args.printed;
@@ -2069,36 +2093,42 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 	return 0;
 }
 
-static void __machine__remove_thread(struct machine *machine, struct thread_rb_node *nd,
-				     struct thread *th, bool lock)
+void threads__remove(struct threads *threads, struct thread *thread)
 {
-	struct threads *threads = machine__threads(machine, thread__tid(th));
-
-	if (!nd)
-		nd = thread_rb_node__find(th, &threads->entries.rb_root);
+	struct rb_node **p;
+	struct threads_table_entry *table  = threads__table(threads, thread__tid(thread));
+	pid_t tid = thread__tid(thread);
 
-	if (threads->last_match && RC_CHK_EQUAL(threads->last_match, th))
-		threads__set_last_match(threads, NULL);
+	down_write(&table->lock);
+	if (table->last_match && RC_CHK_EQUAL(table->last_match, thread))
+		__threads_table_entry__set_last_match(table, NULL);
 
-	if (lock)
-		down_write(&threads->lock);
-
-	BUG_ON(refcount_read(thread__refcnt(th)) == 0);
-
-	thread__put(nd->thread);
-	rb_erase_cached(&nd->rb_node, &threads->entries);
-	RB_CLEAR_NODE(&nd->rb_node);
-	--threads->nr;
-
-	free(nd);
+	p = &table->entries.rb_root.rb_node;
+	while (*p != NULL) {
+		struct rb_node *parent = *p;
+		struct thread_rb_node *nd = rb_entry(parent, struct thread_rb_node, rb_node);
+		struct thread *th = nd->thread;
+
+		if (RC_CHK_EQUAL(th, thread)) {
+			thread__put(nd->thread);
+			rb_erase_cached(&nd->rb_node, &table->entries);
+			RB_CLEAR_NODE(&nd->rb_node);
+			--table->nr;
+			free(nd);
+			break;
+		}
 
-	if (lock)
-		up_write(&threads->lock);
+		if (tid < thread__tid(th))
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	up_write(&table->lock);
 }
 
 void machine__remove_thread(struct machine *machine, struct thread *th)
 {
-	return __machine__remove_thread(machine, NULL, th, true);
+	return threads__remove(&machine->threads, th);
 }
 
 int machine__process_fork_event(struct machine *machine, union perf_event *event,
@@ -3228,27 +3258,35 @@ int thread__resolve_callchain(struct thread *thread,
 	return ret;
 }
 
-int machine__for_each_thread(struct machine *machine,
-			     int (*fn)(struct thread *thread, void *p),
-			     void *priv)
+int threads__for_each_thread(struct threads *threads,
+			     int (*fn)(struct thread *thread, void *data),
+			     void *data)
 {
-	struct threads *threads;
-	struct rb_node *nd;
-	int rc = 0;
-	int i;
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+		struct rb_node *nd;
 
-	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
-		threads = &machine->threads[i];
-		for (nd = rb_first_cached(&threads->entries); nd;
-		     nd = rb_next(nd)) {
+		down_read(&table->lock);
+		for (nd = rb_first_cached(&table->entries); nd; nd = rb_next(nd)) {
 			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
+			int rc = fn(trb->thread, data);
 
-			rc = fn(trb->thread, priv);
-			if (rc != 0)
+			if (rc != 0) {
+				up_read(&table->lock);
 				return rc;
+			}
 		}
+		up_read(&table->lock);
 	}
-	return rc;
+	return 0;
+
+}
+
+int machine__for_each_thread(struct machine *machine,
+			     int (*fn)(struct thread *thread, void *p),
+			     void *priv)
+{
+	return threads__for_each_thread(&machine->threads, fn, priv);
 }
 
 int machines__for_each_thread(struct machines *machines,
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index b738ce84817b..5b425b70140e 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -31,13 +31,28 @@ struct vdso_info;
 #define THREADS__TABLE_BITS	8
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
-struct threads {
+struct threads_table_entry {
 	struct rb_root_cached  entries;
 	struct rw_semaphore    lock;
 	unsigned int	       nr;
 	struct thread	       *last_match;
 };
 
+struct threads {
+	struct threads_table_entry table[THREADS__TABLE_SIZE];
+};
+
+void threads__init(struct threads *threads);
+void threads__exit(struct threads *threads);
+size_t threads__nr(struct threads *threads);
+struct thread *threads__find(struct threads *threads, pid_t tid);
+struct thread *threads__findnew(struct threads *threads, pid_t pid, pid_t tid, bool *created);
+void threads__remove_all_threads(struct threads *threads);
+void threads__remove(struct threads *threads, struct thread *thread);
+int threads__for_each_thread(struct threads *threads,
+			     int (*fn)(struct thread *thread, void *data),
+			     void *data);
+
 struct machine {
 	struct rb_node	  rb_node;
 	pid_t		  pid;
@@ -48,7 +63,7 @@ struct machine {
 	char		  *root_dir;
 	char		  *mmap_name;
 	char		  *kallsyms_filename;
-	struct threads    threads[THREADS__TABLE_SIZE];
+	struct threads    threads;
 	struct vdso_info  *vdso_info;
 	struct perf_env   *env;
 	struct dsos	  dsos;
@@ -69,12 +84,6 @@ struct machine {
 	bool		  trampolines_mapped;
 };
 
-static inline struct threads *machine__threads(struct machine *machine, pid_t tid)
-{
-	/* Cast it to handle tid == -1 */
-	return &machine->threads[(unsigned int)tid % THREADS__TABLE_SIZE];
-}
-
 /*
  * The main kernel (vmlinux) map
  */
@@ -220,7 +229,6 @@ bool machine__is(struct machine *machine, const char *arch);
 bool machine__normalized_is(struct machine *machine, const char *arch);
 int machine__nr_cpus_avail(struct machine *machine);
 
-struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 
 struct dso *machine__findnew_dso_id(struct machine *machine, const char *filename, struct dso_id *id);
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index c59ab4d79163..1aa8962dcf52 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -26,7 +26,7 @@ int thread__init_maps(struct thread *thread, struct machine *machine)
 	if (pid == thread__tid(thread) || pid == -1) {
 		thread__set_maps(thread, maps__new(machine));
 	} else {
-		struct thread *leader = __machine__findnew_thread(machine, pid, pid);
+		struct thread *leader = machine__findnew_thread(machine, pid, pid);
 
 		if (leader) {
 			thread__set_maps(thread, maps__get(thread__maps(leader)));
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index df344262eaee..8b4a3c69bad1 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -3,7 +3,6 @@
 #define __PERF_THREAD_H
 
 #include <linux/refcount.h>
-#include <linux/rbtree.h>
 #include <linux/list.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -29,11 +28,6 @@ struct lbr_stitch {
 	struct callchain_cursor_node	*prev_lbr_cursor;
 };
 
-struct thread_rb_node {
-	struct rb_node rb_node;
-	struct thread *thread;
-};
-
 DECLARE_RC_STRUCT(thread) {
 	/** @maps: mmaps associated with this thread. */
 	struct maps		*maps;
-- 
2.44.0.278.ge034bb2e1d-goog


