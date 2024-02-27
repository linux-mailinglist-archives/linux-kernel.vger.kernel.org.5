Return-Path: <linux-kernel+bounces-84085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F5486A21F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26864B2AF29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1361150982;
	Tue, 27 Feb 2024 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVYTn6Tx"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFD4157E65
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071338; cv=none; b=lvBCPy6LOtkiIKApHm3/+EO+5vX3+aEg0K2s2Jlhh+18x2T01/nYt67qSFDkiVmYQMIyaSrSPOZdI3rI1kxA1UrSd2hKnICV78CcevLeVAI9B+RgzhpM9hqtjFaY7MTAHO/YgZvKEggPfYwM95dEZ24Drbc1YnzC690+BhwH2so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071338; c=relaxed/simple;
	bh=8uQDXFmaIiRJ6Hg6w6jtncylaSx91Lkrl/drWddSSDA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QYdjyO4yj/oPwRKxavFuCnrjj8dfXiQAJLHDnj6XnKmbGvmQlbP7xyXXKKiO4oBComBJAb8icv081mz/Obew9uMwiPB7WosgG4g+ggTcmz4YLZ7pKz7HYjB7dGYVy+4OtYyTwUqBzSyZzmI6e5wlxRcqsFtOqkuqbxgBZuDBc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GVYTn6Tx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608b648044fso88532087b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709071333; x=1709676133; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wba+QvoL7K11DwHxYWfqulLAN6tkIyxzlgcJ5v9C6VE=;
        b=GVYTn6TxJEypgiw8cYUM50IdLB0JV+gqF6e3HhFkS6L8+C1MR/h0xe1zfanAkOhtej
         /RKnakt//SLyy41x1YK/XOkYUP0Y5UQm6gOqIwL7r6jt0u1dXyFli6kENjVnjDTUmcQz
         6tov3X9oh+Jn+N3XfWdZg3DorBO8oFSadTK4L6pQ7dFaFwBkwHW40astGgPXLqHDzaQE
         qSiGmpFNd8A1tBq3yjzG20eJ4nKmtpvjdTty4iR1zy8OmnYotXCKRi4IRFgyMTg+JXP3
         VbrOmtHR+6gqVlnlDJuugOuqYixjYrJ4uvHei3NF3Pq6fe0STYgG6agjeMH2pDN3wJ71
         Tg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071333; x=1709676133;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wba+QvoL7K11DwHxYWfqulLAN6tkIyxzlgcJ5v9C6VE=;
        b=xKbKOt2Cl4PDBttCHjkYr/EorVkqAuTlm+U54yfyPuAED/q0+CEu9IR+SDCaK+6cML
         zj0DyTXPCQnXHYxKUAaREV48lknazUHCggDC5rbUIOSvaxeRvC1Kbpo4ho8Dk9J0WZRA
         1ChwlPSm4iTOBqsg3/zIgB0m/UYbN2sdQ6y5ZBdfM1Y6ICfqr42IAOjhlXuVjFm+nERh
         0Zr8oV5Urc85Qe8h6J3WmYfpfuhJAbCop3TMtJF+/O/rgGFqxuzZY99k5CyrtduDImTs
         PHNhtt0V3rwl8bePjiU7sWPxCbqSZ2umsQuiOQtosuH2whg779VrTTkqs3apVzH3VQZC
         5+WA==
X-Forwarded-Encrypted: i=1; AJvYcCWOFA3M7oRwg9gkTs/rDedynwAkD9tb0HpEcVqVp7AG6AxPG8OPDK7f9G3lrP/86U2G0a9e6tq+ssz/NrD78M092cE552xFVY1znLSW
X-Gm-Message-State: AOJu0YzzBohq0yzOdn9irMdL8zZywj7W8z4TK2A5xVwjWRhTk30afiRh
	iihD1WdrtHHxw+9VPkqbHO22X8+5eEZBhRYF2Ax7e+tlT0xTTpOLBHTM591uLad68qA2hpbUS/N
	TZWhPsg==
X-Google-Smtp-Source: AGHT+IG9T4R1x96rOSc+GuB8pVQ5WbQDpSUg8dTL0ZQ9ABn75erJ4LVziuD94ezEy2HRtYqUZJ3pa5OA7Cpe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ff1:8af6:9e1a:6382])
 (user=irogers job=sendgmr) by 2002:a81:6c56:0:b0:608:ba07:3093 with SMTP id
 h83-20020a816c56000000b00608ba073093mr780129ywc.1.1709071333554; Tue, 27 Feb
 2024 14:02:13 -0800 (PST)
Date: Tue, 27 Feb 2024 14:01:49 -0800
In-Reply-To: <20240227220150.3876198-1-irogers@google.com>
Message-Id: <20240227220150.3876198-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227220150.3876198-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v2 5/6] perf threads: Switch from rbtree to hashmap
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The rbtree provides a sorting on entries but this is unused. Switch to
using hashmap for O(1) rather than O(log n) find/insert/remove
complexity.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.c | 146 ++++++++++++--------------------------
 tools/perf/util/threads.h |   6 +-
 2 files changed, 47 insertions(+), 105 deletions(-)

diff --git a/tools/perf/util/threads.c b/tools/perf/util/threads.c
index d984ec939c7b..55923be53180 100644
--- a/tools/perf/util/threads.c
+++ b/tools/perf/util/threads.c
@@ -3,25 +3,30 @@
 #include "machine.h"
 #include "thread.h"
 
-struct thread_rb_node {
-	struct rb_node rb_node;
-	struct thread *thread;
-};
-
 static struct threads_table_entry *threads__table(struct threads *threads, pid_t tid)
 {
 	/* Cast it to handle tid == -1 */
 	return &threads->table[(unsigned int)tid % THREADS__TABLE_SIZE];
 }
 
+static size_t key_hash(long key, void *ctx __maybe_unused)
+{
+	/* The table lookup removes low bit entropy, but this is just ignored here. */
+	return key;
+}
+
+static bool key_equal(long key1, long key2, void *ctx __maybe_unused)
+{
+	return key1 == key2;
+}
+
 void threads__init(struct threads *threads)
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
 
-		table->entries = RB_ROOT_CACHED;
+		hashmap__init(&table->shard, key_hash, key_equal, NULL);
 		init_rwsem(&table->lock);
-		table->nr = 0;
 		table->last_match = NULL;
 	}
 }
@@ -32,6 +37,7 @@ void threads__exit(struct threads *threads)
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
 
+		hashmap__clear(&table->shard);
 		exit_rwsem(&table->lock);
 	}
 }
@@ -44,7 +50,7 @@ size_t threads__nr(struct threads *threads)
 		struct threads_table_entry *table = &threads->table[i];
 
 		down_read(&table->lock);
-		nr += table->nr;
+		nr += hashmap__size(&table->shard);
 		up_read(&table->lock);
 	}
 	return nr;
@@ -86,28 +92,13 @@ static void threads_table_entry__set_last_match(struct threads_table_entry *tabl
 struct thread *threads__find(struct threads *threads, pid_t tid)
 {
 	struct threads_table_entry *table  = threads__table(threads, tid);
-	struct rb_node **p;
-	struct thread *res = NULL;
+	struct thread *res;
 
 	down_read(&table->lock);
 	res = __threads_table_entry__get_last_match(table, tid);
-	if (res)
-		return res;
-
-	p = &table->entries.rb_root.rb_node;
-	while (*p != NULL) {
-		struct rb_node *parent = *p;
-		struct thread *th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
-
-		if (thread__tid(th) == tid) {
-			res = thread__get(th);
-			break;
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
+	if (!res) {
+		if (hashmap__find(&table->shard, tid, &res))
+			res = thread__get(res);
 	}
 	up_read(&table->lock);
 	if (res)
@@ -118,49 +109,25 @@ struct thread *threads__find(struct threads *threads, pid_t tid)
 struct thread *threads__findnew(struct threads *threads, pid_t pid, pid_t tid, bool *created)
 {
 	struct threads_table_entry *table  = threads__table(threads, tid);
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
 	struct thread *res = NULL;
-	struct thread_rb_node *nd;
-	bool leftmost = true;
 
 	*created = false;
 	down_write(&table->lock);
-	p = &table->entries.rb_root.rb_node;
-	while (*p != NULL) {
-		struct thread *th;
-
-		parent = *p;
-		th = rb_entry(parent, struct thread_rb_node, rb_node)->thread;
-
-		if (thread__tid(th) == tid) {
-			__threads_table_entry__set_last_match(table, th);
-			res = thread__get(th);
-			goto out_unlock;
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else {
-			leftmost = false;
-			p = &(*p)->rb_right;
-		}
-	}
-	nd = malloc(sizeof(*nd));
-	if (nd == NULL)
-		goto out_unlock;
 	res = thread__new(pid, tid);
-	if (!res)
-		free(nd);
-	else {
-		*created = true;
-		nd->thread = thread__get(res);
-		rb_link_node(&nd->rb_node, parent, p);
-		rb_insert_color_cached(&nd->rb_node, &table->entries, leftmost);
-		++table->nr;
-		__threads_table_entry__set_last_match(table, res);
+	if (res) {
+		if (hashmap__add(&table->shard, tid, res)) {
+			/* Add failed. Assume a race so find other entry. */
+			thread__put(res);
+			res = NULL;
+			if (hashmap__find(&table->shard, tid, &res))
+				res = thread__get(res);
+		} else {
+			res = thread__get(res);
+			*created = true;
+		}
+		if (res)
+			__threads_table_entry__set_last_match(table, res);
 	}
-out_unlock:
 	up_write(&table->lock);
 	return res;
 }
@@ -169,57 +136,32 @@ void threads__remove_all_threads(struct threads *threads)
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
-		struct rb_node *nd;
+		struct hashmap_entry *cur, *tmp;
+		size_t bkt;
 
 		down_write(&table->lock);
 		__threads_table_entry__set_last_match(table, NULL);
-		nd = rb_first_cached(&table->entries);
-		while (nd) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-
-			nd = rb_next(nd);
-			thread__put(trb->thread);
-			rb_erase_cached(&trb->rb_node, &table->entries);
-			RB_CLEAR_NODE(&trb->rb_node);
-			--table->nr;
+		hashmap__for_each_entry_safe((&table->shard), cur, tmp, bkt) {
+			struct thread *old_value;
 
-			free(trb);
+			hashmap__delete(&table->shard, cur->key, /*old_key=*/NULL, &old_value);
+			thread__put(old_value);
 		}
-		assert(table->nr == 0);
 		up_write(&table->lock);
 	}
 }
 
 void threads__remove(struct threads *threads, struct thread *thread)
 {
-	struct rb_node **p;
 	struct threads_table_entry *table  = threads__table(threads, thread__tid(thread));
-	pid_t tid = thread__tid(thread);
+	struct thread *old_value;
 
 	down_write(&table->lock);
 	if (table->last_match && RC_CHK_EQUAL(table->last_match, thread))
 		__threads_table_entry__set_last_match(table, NULL);
 
-	p = &table->entries.rb_root.rb_node;
-	while (*p != NULL) {
-		struct rb_node *parent = *p;
-		struct thread_rb_node *nd = rb_entry(parent, struct thread_rb_node, rb_node);
-		struct thread *th = nd->thread;
-
-		if (RC_CHK_EQUAL(th, thread)) {
-			thread__put(nd->thread);
-			rb_erase_cached(&nd->rb_node, &table->entries);
-			RB_CLEAR_NODE(&nd->rb_node);
-			--table->nr;
-			free(nd);
-			break;
-		}
-
-		if (tid < thread__tid(th))
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
-	}
+	hashmap__delete(&table->shard, thread__tid(thread), /*old_key=*/NULL, &old_value);
+	thread__put(old_value);
 	up_write(&table->lock);
 }
 
@@ -229,11 +171,11 @@ int threads__for_each_thread(struct threads *threads,
 {
 	for (int i = 0; i < THREADS__TABLE_SIZE; i++) {
 		struct threads_table_entry *table = &threads->table[i];
-		struct rb_node *nd;
+		struct hashmap_entry *cur;
+		size_t bkt;
 
-		for (nd = rb_first_cached(&table->entries); nd; nd = rb_next(nd)) {
-			struct thread_rb_node *trb = rb_entry(nd, struct thread_rb_node, rb_node);
-			int rc = fn(trb->thread, data);
+		hashmap__for_each_entry((&table->shard), cur, bkt) {
+			int rc = fn((struct thread *)cur->pvalue, data);
 
 			if (rc != 0)
 				return rc;
diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index ed67de627578..d03bd91a7769 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -2,7 +2,7 @@
 #ifndef __PERF_THREADS_H
 #define __PERF_THREADS_H
 
-#include <linux/rbtree.h>
+#include "hashmap.h"
 #include "rwsem.h"
 
 struct thread;
@@ -11,9 +11,9 @@ struct thread;
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-	struct rb_root_cached  entries;
+	/* Key is tid, value is struct thread. */
+	struct hashmap	       shard;
 	struct rw_semaphore    lock;
-	unsigned int	       nr;
 	struct thread	       *last_match;
 };
 
-- 
2.44.0.rc1.240.g4c46232300-goog


