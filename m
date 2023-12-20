Return-Path: <linux-kernel+bounces-6344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C20081977B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 929C3B2565D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3BC156DD;
	Wed, 20 Dec 2023 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJc8iZId"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F3CA47
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5c641d55e27so254661a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703044866; x=1703649666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cCTRKeNQiBByqMOyIwmk53PSKP7NuCrv77vrh17FQc=;
        b=fJc8iZIdZl9HkdUI8BAL7NOgzOe0af+pva5Ybikv4pBZ9lxqL58p7k71TRUEdNo5yV
         Xfqqcyff0qQMxA3gwY3o4V8i/pCXINIbWpjCavnCerkYyINFlWT1Ggfddv0ridiPWRKL
         85V/CsSRQ1R7aswBSJl9lNP2cwa6/w+FESSMqIfUnan32aIfUc+0t/szzQdxbGPEtTur
         OT3IwjUH0ohu+aU23hcP3s8qI4XPzO8HkbJKbIB6PkolJDfVrXqH1w8Sy+ewhICrSsJx
         6dc/wunyZ29pfLBaon0IxLMpf0CkRBpAPf4oDLcnIhOFdbvWpg5oS0qDIBhy5K+eWnwv
         Afwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044866; x=1703649666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cCTRKeNQiBByqMOyIwmk53PSKP7NuCrv77vrh17FQc=;
        b=s45E4BgRj1jsAfZUP5voqV9vraEkp5v+Qj1XpKcGIPhzWc7jtTbGzcVmwkb+qDFq7T
         OC5PJATn5IZplAfTOnHpArZm6WxsHAArqMGDc6677qD9+sozNNtWu4c7FjrTOjv1JYQe
         KrFyDGgqlcX6fnYkSLmo0O5WzAjEkoyp3qn7FNjk4fuMMwgJdNCRMD4AzZTwiFic6Ohf
         vJIFLb3ulM+FHHiufC8JtkH6ix1Uo6F2fmovkY6BfKAZrCzgkFUcmoo8Mb7GCwq6wYsB
         wZg0eCuNuWbpKBYSGnemHHVdqAxQg/0r/hjsHP+ha+YVXhanvw58mLPBKedvw9W+dnpg
         toEw==
X-Gm-Message-State: AOJu0Yzc4vm3YSLFDgj7elg5NuOYA0wF4eWdyaTTukA5G4LcORr+7fNL
	zT+sh+TSi4PYHrPco3MgsHpZWVRNG0bt2q/6BCTC
X-Google-Smtp-Source: AGHT+IHYU/0G7sagoVSekEFuGUcJnQ8L1MXOFm+eeeUKkLV/+s3IqOp82O8n3cufSerNU23Vs7IVarCB10tYNg==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a63:e446:0:b0:5cd:9278:f8de with SMTP id
 i6-20020a63e446000000b005cd9278f8demr15130pgk.0.1703044866166; Tue, 19 Dec
 2023 20:01:06 -0800 (PST)
Date: Wed, 20 Dec 2023 04:00:35 +0000
In-Reply-To: <20231220040037.883811-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220040037.883811-1-kinseyho@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220040037.883811-3-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 2/4] mm/mglru: add CONFIG_LRU_GEN_WALKS_MMU
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, yuzhao@google.com, 
	Kinsey Ho <kinseyho@google.com>, Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Add CONFIG_LRU_GEN_WALKS_MMU such that if disabled, the code that
walks page tables to promote pages into the youngest generation will
not be built.

Also improves code readability by adding two helper functions
get_mm_state() and get_next_mm().

Signed-off-by: Kinsey Ho <kinseyho@google.com>
Co-developed-by: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memcontrol.h |   2 +-
 include/linux/mm_types.h   |  12 ++-
 include/linux/mmzone.h     |   2 +
 kernel/fork.c              |   2 +-
 mm/Kconfig                 |   4 +
 mm/vmscan.c                | 192 ++++++++++++++++++++++++-------------
 6 files changed, 139 insertions(+), 75 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5de775e6cdd9..20ff87f8e001 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -330,7 +330,7 @@ struct mem_cgroup {
 	struct deferred_split deferred_split_queue;
 #endif
 
-#ifdef CONFIG_LRU_GEN
+#ifdef CONFIG_LRU_GEN_WALKS_MMU
 	/* per-memcg mm_struct list */
 	struct lru_gen_mm_list mm_list;
 #endif
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a66534c78c4d..552fa2d11c57 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -958,7 +958,7 @@ struct mm_struct {
 		 */
 		unsigned long ksm_zero_pages;
 #endif /* CONFIG_KSM */
-#ifdef CONFIG_LRU_GEN
+#ifdef CONFIG_LRU_GEN_WALKS_MMU
 		struct {
 			/* this mm_struct is on lru_gen_mm_list */
 			struct list_head list;
@@ -973,7 +973,7 @@ struct mm_struct {
 			struct mem_cgroup *memcg;
 #endif
 		} lru_gen;
-#endif /* CONFIG_LRU_GEN */
+#endif /* CONFIG_LRU_GEN_WALKS_MMU */
 	} __randomize_layout;
 
 	/*
@@ -1011,6 +1011,10 @@ struct lru_gen_mm_list {
 	spinlock_t lock;
 };
 
+#endif /* CONFIG_LRU_GEN */
+
+#ifdef CONFIG_LRU_GEN_WALKS_MMU
+
 void lru_gen_add_mm(struct mm_struct *mm);
 void lru_gen_del_mm(struct mm_struct *mm);
 #ifdef CONFIG_MEMCG
@@ -1036,7 +1040,7 @@ static inline void lru_gen_use_mm(struct mm_struct *mm)
 	WRITE_ONCE(mm->lru_gen.bitmap, -1);
 }
 
-#else /* !CONFIG_LRU_GEN */
+#else /* !CONFIG_LRU_GEN_WALKS_MMU */
 
 static inline void lru_gen_add_mm(struct mm_struct *mm)
 {
@@ -1060,7 +1064,7 @@ static inline void lru_gen_use_mm(struct mm_struct *mm)
 {
 }
 
-#endif /* CONFIG_LRU_GEN */
+#endif /* CONFIG_LRU_GEN_WALKS_MMU */
 
 struct vma_iterator {
 	struct ma_state mas;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 2efd3be484fd..bc3f63ec4291 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -640,9 +640,11 @@ struct lruvec {
 #ifdef CONFIG_LRU_GEN
 	/* evictable pages divided into generations */
 	struct lru_gen_folio		lrugen;
+#ifdef CONFIG_LRU_GEN_WALKS_MMU
 	/* to concurrently iterate lru_gen_mm_list */
 	struct lru_gen_mm_state		mm_state;
 #endif
+#endif /* CONFIG_LRU_GEN */
 #ifdef CONFIG_MEMCG
 	struct pglist_data *pgdat;
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 93924392a5c3..56cf276432c8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2946,7 +2946,7 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 		get_task_struct(p);
 	}
 
-	if (IS_ENABLED(CONFIG_LRU_GEN) && !(clone_flags & CLONE_VM)) {
+	if (IS_ENABLED(CONFIG_LRU_GEN_WALKS_MMU) && !(clone_flags & CLONE_VM)) {
 		/* lock the task to synchronize with memcg migration */
 		task_lock(p);
 		lru_gen_add_mm(p->mm);
diff --git a/mm/Kconfig b/mm/Kconfig
index 8f8b02e9c136..c98076dec5fb 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1274,6 +1274,10 @@ config LRU_GEN_STATS
 	  from evicted generations for debugging purpose.
 
 	  This option has a per-memcg and per-node memory overhead.
+
+config LRU_GEN_WALKS_MMU
+	def_bool y
+	depends on LRU_GEN && ARCH_HAS_HW_PTE_YOUNG
 # }
 
 config ARCH_SUPPORTS_PER_VMA_LOCK
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b4ca3563bcf4..aa7ea09ffb4c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2671,13 +2671,14 @@ static void get_item_key(void *item, int *key)
 	key[1] = hash >> BLOOM_FILTER_SHIFT;
 }
 
-static bool test_bloom_filter(struct lruvec *lruvec, unsigned long seq, void *item)
+static bool test_bloom_filter(struct lru_gen_mm_state *mm_state, unsigned long seq,
+			      void *item)
 {
 	int key[2];
 	unsigned long *filter;
 	int gen = filter_gen_from_seq(seq);
 
-	filter = READ_ONCE(lruvec->mm_state.filters[gen]);
+	filter = READ_ONCE(mm_state->filters[gen]);
 	if (!filter)
 		return true;
 
@@ -2686,13 +2687,14 @@ static bool test_bloom_filter(struct lruvec *lruvec, unsigned long seq, void *it
 	return test_bit(key[0], filter) && test_bit(key[1], filter);
 }
 
-static void update_bloom_filter(struct lruvec *lruvec, unsigned long seq, void *item)
+static void update_bloom_filter(struct lru_gen_mm_state *mm_state, unsigned long seq,
+				void *item)
 {
 	int key[2];
 	unsigned long *filter;
 	int gen = filter_gen_from_seq(seq);
 
-	filter = READ_ONCE(lruvec->mm_state.filters[gen]);
+	filter = READ_ONCE(mm_state->filters[gen]);
 	if (!filter)
 		return;
 
@@ -2704,12 +2706,12 @@ static void update_bloom_filter(struct lruvec *lruvec, unsigned long seq, void *
 		set_bit(key[1], filter);
 }
 
-static void reset_bloom_filter(struct lruvec *lruvec, unsigned long seq)
+static void reset_bloom_filter(struct lru_gen_mm_state *mm_state, unsigned long seq)
 {
 	unsigned long *filter;
 	int gen = filter_gen_from_seq(seq);
 
-	filter = lruvec->mm_state.filters[gen];
+	filter = mm_state->filters[gen];
 	if (filter) {
 		bitmap_clear(filter, 0, BIT(BLOOM_FILTER_SHIFT));
 		return;
@@ -2717,13 +2719,15 @@ static void reset_bloom_filter(struct lruvec *lruvec, unsigned long seq)
 
 	filter = bitmap_zalloc(BIT(BLOOM_FILTER_SHIFT),
 			       __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
-	WRITE_ONCE(lruvec->mm_state.filters[gen], filter);
+	WRITE_ONCE(mm_state->filters[gen], filter);
 }
 
 /******************************************************************************
  *                          mm_struct list
  ******************************************************************************/
 
+#ifdef CONFIG_LRU_GEN_WALKS_MMU
+
 static struct lru_gen_mm_list *get_mm_list(struct mem_cgroup *memcg)
 {
 	static struct lru_gen_mm_list mm_list = {
@@ -2740,6 +2744,29 @@ static struct lru_gen_mm_list *get_mm_list(struct mem_cgroup *memcg)
 	return &mm_list;
 }
 
+static struct lru_gen_mm_state *get_mm_state(struct lruvec *lruvec)
+{
+	return &lruvec->mm_state;
+}
+
+static struct mm_struct *get_next_mm(struct lru_gen_mm_walk *walk)
+{
+	int key;
+	struct mm_struct *mm;
+	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
+	struct lru_gen_mm_state *mm_state = get_mm_state(walk->lruvec);
+
+	mm = list_entry(mm_state->head, struct mm_struct, lru_gen.list);
+	key = pgdat->node_id % BITS_PER_TYPE(mm->lru_gen.bitmap);
+
+	if (!walk->force_scan && !test_bit(key, &mm->lru_gen.bitmap))
+		return NULL;
+
+	clear_bit(key, &mm->lru_gen.bitmap);
+
+	return mmget_not_zero(mm) ? mm : NULL;
+}
+
 void lru_gen_add_mm(struct mm_struct *mm)
 {
 	int nid;
@@ -2755,10 +2782,11 @@ void lru_gen_add_mm(struct mm_struct *mm)
 
 	for_each_node_state(nid, N_MEMORY) {
 		struct lruvec *lruvec = get_lruvec(memcg, nid);
+		struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
 		/* the first addition since the last iteration */
-		if (lruvec->mm_state.tail == &mm_list->fifo)
-			lruvec->mm_state.tail = &mm->lru_gen.list;
+		if (mm_state->tail == &mm_list->fifo)
+			mm_state->tail = &mm->lru_gen.list;
 	}
 
 	list_add_tail(&mm->lru_gen.list, &mm_list->fifo);
@@ -2784,14 +2812,15 @@ void lru_gen_del_mm(struct mm_struct *mm)
 
 	for_each_node(nid) {
 		struct lruvec *lruvec = get_lruvec(memcg, nid);
+		struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
 		/* where the current iteration continues after */
-		if (lruvec->mm_state.head == &mm->lru_gen.list)
-			lruvec->mm_state.head = lruvec->mm_state.head->prev;
+		if (mm_state->head == &mm->lru_gen.list)
+			mm_state->head = mm_state->head->prev;
 
 		/* where the last iteration ended before */
-		if (lruvec->mm_state.tail == &mm->lru_gen.list)
-			lruvec->mm_state.tail = lruvec->mm_state.tail->next;
+		if (mm_state->tail == &mm->lru_gen.list)
+			mm_state->tail = mm_state->tail->next;
 	}
 
 	list_del_init(&mm->lru_gen.list);
@@ -2834,10 +2863,30 @@ void lru_gen_migrate_mm(struct mm_struct *mm)
 }
 #endif
 
+#else /* !CONFIG_LRU_GEN_WALKS_MMU */
+
+static struct lru_gen_mm_list *get_mm_list(struct mem_cgroup *memcg)
+{
+	return NULL;
+}
+
+static struct lru_gen_mm_state *get_mm_state(struct lruvec *lruvec)
+{
+	return NULL;
+}
+
+static struct mm_struct *get_next_mm(struct lru_gen_mm_walk *walk)
+{
+	return NULL;
+}
+
+#endif
+
 static void reset_mm_stats(struct lruvec *lruvec, struct lru_gen_mm_walk *walk, bool last)
 {
 	int i;
 	int hist;
+	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
 	lockdep_assert_held(&get_mm_list(lruvec_memcg(lruvec))->lock);
 
@@ -2845,44 +2894,20 @@ static void reset_mm_stats(struct lruvec *lruvec, struct lru_gen_mm_walk *walk,
 		hist = lru_hist_from_seq(walk->max_seq);
 
 		for (i = 0; i < NR_MM_STATS; i++) {
-			WRITE_ONCE(lruvec->mm_state.stats[hist][i],
-				   lruvec->mm_state.stats[hist][i] + walk->mm_stats[i]);
+			WRITE_ONCE(mm_state->stats[hist][i],
+				   mm_state->stats[hist][i] + walk->mm_stats[i]);
 			walk->mm_stats[i] = 0;
 		}
 	}
 
 	if (NR_HIST_GENS > 1 && last) {
-		hist = lru_hist_from_seq(lruvec->mm_state.seq + 1);
+		hist = lru_hist_from_seq(mm_state->seq + 1);
 
 		for (i = 0; i < NR_MM_STATS; i++)
-			WRITE_ONCE(lruvec->mm_state.stats[hist][i], 0);
+			WRITE_ONCE(mm_state->stats[hist][i], 0);
 	}
 }
 
-static bool should_skip_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
-{
-	int type;
-	unsigned long size = 0;
-	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
-	int key = pgdat->node_id % BITS_PER_TYPE(mm->lru_gen.bitmap);
-
-	if (!walk->force_scan && !test_bit(key, &mm->lru_gen.bitmap))
-		return true;
-
-	clear_bit(key, &mm->lru_gen.bitmap);
-
-	for (type = !walk->can_swap; type < ANON_AND_FILE; type++) {
-		size += type ? get_mm_counter(mm, MM_FILEPAGES) :
-			       get_mm_counter(mm, MM_ANONPAGES) +
-			       get_mm_counter(mm, MM_SHMEMPAGES);
-	}
-
-	if (size < MIN_LRU_BATCH)
-		return true;
-
-	return !mmget_not_zero(mm);
-}
-
 static bool iterate_mm_list(struct lruvec *lruvec, struct lru_gen_mm_walk *walk,
 			    struct mm_struct **iter)
 {
@@ -2891,7 +2916,7 @@ static bool iterate_mm_list(struct lruvec *lruvec, struct lru_gen_mm_walk *walk,
 	struct mm_struct *mm = NULL;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
-	struct lru_gen_mm_state *mm_state = &lruvec->mm_state;
+	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
 	/*
 	 * mm_state->seq is incremented after each iteration of mm_list. There
@@ -2929,11 +2954,7 @@ static bool iterate_mm_list(struct lruvec *lruvec, struct lru_gen_mm_walk *walk,
 			mm_state->tail = mm_state->head->next;
 			walk->force_scan = true;
 		}
-
-		mm = list_entry(mm_state->head, struct mm_struct, lru_gen.list);
-		if (should_skip_mm(mm, walk))
-			mm = NULL;
-	} while (!mm);
+	} while (!(mm = get_next_mm(walk)));
 done:
 	if (*iter || last)
 		reset_mm_stats(lruvec, walk, last);
@@ -2941,7 +2962,7 @@ static bool iterate_mm_list(struct lruvec *lruvec, struct lru_gen_mm_walk *walk,
 	spin_unlock(&mm_list->lock);
 
 	if (mm && first)
-		reset_bloom_filter(lruvec, walk->max_seq + 1);
+		reset_bloom_filter(mm_state, walk->max_seq + 1);
 
 	if (*iter)
 		mmput_async(*iter);
@@ -2956,7 +2977,7 @@ static bool iterate_mm_list_nowalk(struct lruvec *lruvec, unsigned long max_seq)
 	bool success = false;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
-	struct lru_gen_mm_state *mm_state = &lruvec->mm_state;
+	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
 	spin_lock(&mm_list->lock);
 
@@ -3469,6 +3490,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 	DECLARE_BITMAP(bitmap, MIN_LRU_BATCH);
 	unsigned long first = -1;
 	struct lru_gen_mm_walk *walk = args->private;
+	struct lru_gen_mm_state *mm_state = get_mm_state(walk->lruvec);
 
 	VM_WARN_ON_ONCE(pud_leaf(*pud));
 
@@ -3520,7 +3542,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &first);
 		}
 
-		if (!walk->force_scan && !test_bloom_filter(walk->lruvec, walk->max_seq, pmd + i))
+		if (!walk->force_scan && !test_bloom_filter(mm_state, walk->max_seq, pmd + i))
 			continue;
 
 		walk->mm_stats[MM_NONLEAF_FOUND]++;
@@ -3531,7 +3553,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 		walk->mm_stats[MM_NONLEAF_ADDED]++;
 
 		/* carry over to the next generation */
-		update_bloom_filter(walk->lruvec, walk->max_seq + 1, pmd + i);
+		update_bloom_filter(mm_state, walk->max_seq + 1, pmd + i);
 	}
 
 	walk_pmd_range_locked(pud, -1, vma, args, bitmap, &first);
@@ -3738,16 +3760,25 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec, bool can_swap)
 	return success;
 }
 
-static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
+static bool inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
+			bool can_swap, bool force_scan)
 {
+	bool success;
 	int prev, next;
 	int type, zone;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 restart:
+	if (max_seq < READ_ONCE(lrugen->max_seq))
+		return false;
+
 	spin_lock_irq(&lruvec->lru_lock);
 
 	VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
 
+	success = max_seq == lrugen->max_seq;
+	if (!success)
+		goto unlock;
+
 	for (type = ANON_AND_FILE - 1; type >= 0; type--) {
 		if (get_nr_gens(lruvec, type) != MAX_NR_GENS)
 			continue;
@@ -3791,8 +3822,10 @@ static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
 	WRITE_ONCE(lrugen->timestamps[next], jiffies);
 	/* make sure preceding modifications appear */
 	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
-
+unlock:
 	spin_unlock_irq(&lruvec->lru_lock);
+
+	return success;
 }
 
 static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
@@ -3802,14 +3835,16 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	struct lru_gen_mm_walk *walk;
 	struct mm_struct *mm = NULL;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
 	VM_WARN_ON_ONCE(max_seq > READ_ONCE(lrugen->max_seq));
 
+	if (!mm_state)
+		return inc_max_seq(lruvec, max_seq, can_swap, force_scan);
+
 	/* see the comment in iterate_mm_list() */
-	if (max_seq <= READ_ONCE(lruvec->mm_state.seq)) {
-		success = false;
-		goto done;
-	}
+	if (max_seq <= READ_ONCE(mm_state->seq))
+		return false;
 
 	/*
 	 * If the hardware doesn't automatically set the accessed bit, fallback
@@ -3839,8 +3874,10 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 			walk_mm(lruvec, mm, walk);
 	} while (mm);
 done:
-	if (success)
-		inc_max_seq(lruvec, can_swap, force_scan);
+	if (success) {
+		success = inc_max_seq(lruvec, max_seq, can_swap, force_scan);
+		WARN_ON_ONCE(!success);
+	}
 
 	return success;
 }
@@ -3964,6 +4001,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	struct mem_cgroup *memcg = folio_memcg(folio);
 	struct pglist_data *pgdat = folio_pgdat(folio);
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 	DEFINE_MAX_SEQ(lruvec);
 	int old_gen, new_gen = lru_gen_from_seq(max_seq);
 
@@ -4042,8 +4080,8 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	mem_cgroup_unlock_pages();
 
 	/* feedback from rmap walkers to page table walkers */
-	if (suitable_to_scan(i, young))
-		update_bloom_filter(lruvec, max_seq, pvmw->pmd);
+	if (mm_state && suitable_to_scan(i, young))
+		update_bloom_filter(mm_state, max_seq, pvmw->pmd);
 }
 
 /******************************************************************************
@@ -5219,6 +5257,7 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 	int type, tier;
 	int hist = lru_hist_from_seq(seq);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
 	for (tier = 0; tier < MAX_NR_TIERS; tier++) {
 		seq_printf(m, "            %10d", tier);
@@ -5244,6 +5283,9 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 		seq_putc(m, '\n');
 	}
 
+	if (!mm_state)
+		return;
+
 	seq_puts(m, "                      ");
 	for (i = 0; i < NR_MM_STATS; i++) {
 		const char *s = "      ";
@@ -5251,10 +5293,10 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 
 		if (seq == max_seq && NR_HIST_GENS == 1) {
 			s = "LOYNFA";
-			n = READ_ONCE(lruvec->mm_state.stats[hist][i]);
+			n = READ_ONCE(mm_state->stats[hist][i]);
 		} else if (seq != max_seq && NR_HIST_GENS > 1) {
 			s = "loynfa";
-			n = READ_ONCE(lruvec->mm_state.stats[hist][i]);
+			n = READ_ONCE(mm_state->stats[hist][i]);
 		}
 
 		seq_printf(m, " %10lu%c", n, s[i]);
@@ -5523,6 +5565,7 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
 	int i;
 	int gen, type, zone;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
 	lrugen->max_seq = MIN_NR_GENS + 1;
 	lrugen->enabled = lru_gen_enabled();
@@ -5533,7 +5576,8 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
 	for_each_gen_type_zone(gen, type, zone)
 		INIT_LIST_HEAD(&lrugen->folios[gen][type][zone]);
 
-	lruvec->mm_state.seq = MIN_NR_GENS;
+	if (mm_state)
+		mm_state->seq = MIN_NR_GENS;
 }
 
 #ifdef CONFIG_MEMCG
@@ -5552,28 +5596,38 @@ void lru_gen_init_pgdat(struct pglist_data *pgdat)
 
 void lru_gen_init_memcg(struct mem_cgroup *memcg)
 {
-	INIT_LIST_HEAD(&memcg->mm_list.fifo);
-	spin_lock_init(&memcg->mm_list.lock);
+	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
+
+	if (!mm_list)
+		return;
+
+	INIT_LIST_HEAD(&mm_list->fifo);
+	spin_lock_init(&mm_list->lock);
 }
 
 void lru_gen_exit_memcg(struct mem_cgroup *memcg)
 {
 	int i;
 	int nid;
+	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
 
-	VM_WARN_ON_ONCE(!list_empty(&memcg->mm_list.fifo));
+	VM_WARN_ON_ONCE(mm_list && !list_empty(&mm_list->fifo));
 
 	for_each_node(nid) {
 		struct lruvec *lruvec = get_lruvec(memcg, nid);
+		struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
 		VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
 					   sizeof(lruvec->lrugen.nr_pages)));
 
 		lruvec->lrugen.list.next = LIST_POISON1;
 
+		if (!mm_state)
+			continue;
+
 		for (i = 0; i < NR_BLOOM_FILTERS; i++) {
-			bitmap_free(lruvec->mm_state.filters[i]);
-			lruvec->mm_state.filters[i] = NULL;
+			bitmap_free(mm_state->filters[i]);
+			mm_state->filters[i] = NULL;
 		}
 	}
 }
-- 
2.43.0.472.g3155946c3a-goog


