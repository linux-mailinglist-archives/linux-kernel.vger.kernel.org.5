Return-Path: <linux-kernel+bounces-86176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13C986C0B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C722888E1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C22836B0A;
	Thu, 29 Feb 2024 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IY4qbCRo"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87601446C9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188392; cv=none; b=LzCWbAknsdFlJ8jC6dKN0JYE6X/fn9UVK1Hyfq5GpE10ILbPU2ACLhcGz9iPeXwR4g6YBKa5ntsYUMFiHwyL2M6414fl/RVhdqM928cS9EhA4NgSNxS3IQNtNgm8kRs2XSKoLz3sFnEB3bBxKAVBo4XRweYlXh16A3hJ2iHELs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188392; c=relaxed/simple;
	bh=gHFeIibfkee+Lj08lHjIrlKGGCYxpVSxPhBka+CmMEA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kZgkWCyYS0ht889mr2eioPLg/IlJbuJ+Jxv7m01jp/UAvVOfqk+oMeT+TVSFzTM3GAXy70qDM+SngaB+I7GGyh64jK6yyxYS8POXKRUHL6t9apvbzalYePMuo2mEyYfmg825feOkrd1MtrKYBFHGbjUIe/GKOhWY1DIN+1GDntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IY4qbCRo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6087ffdac8cso8752017b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709188389; x=1709793189; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8VQY322jdwwX/8Cmv7X0ShLKhsaVmRjGE9HT8Sz4rY=;
        b=IY4qbCRo87ZT06xZZXCB4Tz84c29oTkCQB//bLbzTwL3iKobjBcRGHCEg6uEqjdgZd
         EQh0ucrnsZl5kssLCh/Q2WMyHyChZqKO3kSQyRK2UsFkSF49fF3NmduwJM/RMrhX2OYX
         trA/yvUCF5U61jamJHHOOrFAY4YbljH+uZaxqkteu5kKUjMQThLk4dyhdOgiW9ThAOzW
         l3n56ksv2r/lATh0hPE4DQSyBoP5fHJskyJUI5JtCG4BdnuvlO1BaWCknQh7v+92lF7M
         4bZvgd8+Es60hDqTOiPJph1L9dcrpk+H67MxvvwKRRcRqj4TMTNmTTs/hxjBrahw45Vl
         RzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709188389; x=1709793189;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8VQY322jdwwX/8Cmv7X0ShLKhsaVmRjGE9HT8Sz4rY=;
        b=xAmIxHSC7RC5Yn7zrMqI73Im6f/cZ9hJQ5JJtvhIEIkJd/NY2h+M5ZMIs0xKBYbmX2
         M4AZWP06O4qSZVeojegLacIJ9vBfaORqtXjLl05OVDX2Pn+GRVXXSWgfh9y+sJ7gm7ky
         3zgWTW5f+JDctQgxJPY1GJEQ4tNw/bDUWxnVhLTd8RA5ctT7CTYZJuKlfwRfqRSNs06W
         rDfuP9Nen8M5OrHKBUSnZgwUrgD1/vje5tS2SD64WFDMHl0rlmOUehAX/0YIIQ2cNDGh
         XDQVcq5OoVZFo5yVBXuEsr0eRLNzquZ/Dpp/cGbLMdsg8N/3a9DZq2c8PLDX8Iy4gC50
         Bq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxJoi+FlACPeOewjTPJ+luP1GbYATvsR+A4/8UUFIFbuBSv/SSXwBWJzGwQFhW2u1HHt7RMOXkkbOGr2NTX5dhd1O1XQ9DyHPiSxGF
X-Gm-Message-State: AOJu0YwlWgMLltyPTimxD61ZH5EF5urXdrDSxbrdPxPcn+WkdbBYS4WE
	eBp+YzjRvdgUB8jpilKDEeCaohTLC8iQfuQ6SnlEMr86EngiyXnlAQtZ11ebkzokGEii2PW44Pe
	vTHRvpA==
X-Google-Smtp-Source: AGHT+IG9JgmAjA4bG2bi7KvJflBUaddLXOtOM2dwmmqj3y1DpV1ZW9IHYStnPsjgJNMdHZKQIhUN9ScrjncH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a81:9953:0:b0:608:321d:62f8 with SMTP id
 q80-20020a819953000000b00608321d62f8mr319298ywg.7.1709188389665; Wed, 28 Feb
 2024 22:33:09 -0800 (PST)
Date: Wed, 28 Feb 2024 22:32:50 -0800
In-Reply-To: <20240229063253.561838-1-irogers@google.com>
Message-Id: <20240229063253.561838-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229063253.561838-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 4/7] perf machine: Move machine's threads into its own abstraction
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
 tools/perf/util/machine.c             | 402 ++++++++++++++------------
 tools/perf/util/machine.h             |  26 +-
 tools/perf/util/thread.c              |   2 +-
 tools/perf/util/thread.h              |   6 -
 5 files changed, 238 insertions(+), 202 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 31ff19afc20c..e631127a655f 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -210,7 +210,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 
 		/* do not update idle comm which contains CPU number */
 		if (pid) {
-			struct thread *t = __machine__findnew_thread(machine, /*pid=*/-1, pid);
+			struct thread *t = machine__findnew_thread(machine, /*pid=*/-1, pid);
 
 			if (t == NULL)
 				return name;
@@ -302,7 +302,7 @@ int lock_contention_read(struct lock_contention *con)
 		return -1;
 
 	if (con->aggr_mode == LOCK_AGGR_TASK) {
-		struct thread *idle = __machine__findnew_thread(machine,
+		struct thread *idle = machine__findnew_thread(machine,
 								/*pid=*/0,
 								/*tid=*/0);
 		thread__set_comm(idle, "swapper", /*timestamp=*/0);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e072b2115b64..d161f5932efa 100644
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
 
+void threads__exit(struct threads *threads)
+{
+	threads__remove_all_threads(threads);
+	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
+		struct threads_table_entry *table = &threads->table[i];
+
+		exit_rwsem(&table->lock);
+	}
+}
+
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
-
-	if (threads->last_match && RC_CHK_EQUAL(threads->last_match, th))
-		threads__set_last_match(threads, NULL);
-
-	if (lock)
-		down_write(&threads->lock);
-
-	BUG_ON(refcount_read(thread__refcnt(th)) == 0);
+	struct rb_node **p;
+	struct threads_table_entry *table  = threads__table(threads, thread__tid(thread));
+	pid_t tid = thread__tid(thread);
 
-	thread__put(nd->thread);
-	rb_erase_cached(&nd->rb_node, &threads->entries);
-	RB_CLEAR_NODE(&nd->rb_node);
-	--threads->nr;
+	down_write(&table->lock);
+	if (table->last_match && RC_CHK_EQUAL(table->last_match, thread))
+		__threads_table_entry__set_last_match(table, NULL);
 
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
@@ -3228,27 +3258,31 @@ int thread__resolve_callchain(struct thread *thread,
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
+		for (nd = rb_first_cached(&table->entries); nd; nd = rb_next(nd)) {
 			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
+			int rc = fn(trb->thread, data);
 
-			rc = fn(trb->thread, priv);
 			if (rc != 0)
 				return rc;
 		}
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


