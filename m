Return-Path: <linux-kernel+bounces-6343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F1D819779
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6B91F25778
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AAB13ACD;
	Wed, 20 Dec 2023 04:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vclXodO9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC2125BC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d3e38ba362so6849445ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703044868; x=1703649668; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eq0C6POTAn+zScnOr/3HnKmDnLhtNh9lvwfd8Bw3a74=;
        b=vclXodO9JJaBo0qFKvwHDdyJbC826Ubcielk0dMd+V7wHdNN2LgBIWEVMLeG7CtbeN
         f1eTbC45FNoV/81yi9G8COtiUcTy/RJUSL5T8FUg5G1LD/4amhAYXQx8Id2RYYPeHpAA
         /VOOjnfqWBZr4g5PCurrhzZTexm/+L1+j3XMJovYSDAt08XGqepS7BwzDbeFZQAsFN8x
         7VtuTXTgCrWpitedSx4v2K9Y1artfixlZf2X+9+iK5b9Ln/VP8QP0YkN/ns9oPen2A6u
         rnq5867jIB232mmR34vszdF2OYlaI7EVaa81TQXombBsMSYqj+2tnLz/cyLDFnxlmUrz
         ZZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044868; x=1703649668;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eq0C6POTAn+zScnOr/3HnKmDnLhtNh9lvwfd8Bw3a74=;
        b=JhhB+aezBqikwQWz3vlJ0/Ki16wxVao0cxUw2FvrybozH6URJLnp19ixPpSpx21r1f
         gSPMq2fOwkqiB7VUs4meSl7GFW+0tjiZgL7FmB3zG+oHUwss8ogqEoqc3Fe3J4FYXfon
         zhiadDVzAAB8SX9uiRxod5tPHeP8p8rgOQMU8OqmU2NvU8tLrDGY/zV4knUQ3IbuKJQT
         /MVfvO5jLtUqyCJP0FQZFRBsVTj4xZ/Ch71RhEseqIn6Rlp6mXDZ9inWq1YU0N55ySoX
         Ny4E3MI669GG08FwwxEu2W07uJ0cwe9gr0yOinesna0+ONe0hOO1Ghk2PHUZliJfC8DC
         YMdA==
X-Gm-Message-State: AOJu0YyXRxvanwJ265uPODWGqmhG9bniwMYCv2ZJrA7Kg2wA1xSitEiu
	85bou80KTwRqKTJRcYXar/ROeYX0enUrtg==
X-Google-Smtp-Source: AGHT+IFw1vEkJJpIi86Do9JxyCADTTgRM4GLYShWKflMJBWEy3GPXOkGRtGigv0iyLhVif8Ba25+md3ePJCUmA==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:aa7:8486:0:b0:6d8:a6fd:dc98 with SMTP id
 u6-20020aa78486000000b006d8a6fddc98mr88954pfn.6.1703044868243; Tue, 19 Dec
 2023 20:01:08 -0800 (PST)
Date: Wed, 20 Dec 2023 04:00:36 +0000
In-Reply-To: <20231220040037.883811-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220040037.883811-1-kinseyho@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220040037.883811-4-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 3/4] mm/mglru: remove CONFIG_MEMCG
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, yuzhao@google.com, 
	Kinsey Ho <kinseyho@google.com>, Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Remove CONFIG_MEMCG in a refactoring to improve code readability at
the cost of a few bytes in struct lru_gen_folio per node when
CONFIG_MEMCG=n.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
Co-developed-by: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
---
 include/linux/mm_types.h |  4 ---
 include/linux/mmzone.h   | 26 ++--------------
 mm/vmscan.c              | 67 +++++++++++++---------------------------
 3 files changed, 23 insertions(+), 74 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 552fa2d11c57..55b7121809ff 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1017,9 +1017,7 @@ struct lru_gen_mm_list {
 
 void lru_gen_add_mm(struct mm_struct *mm);
 void lru_gen_del_mm(struct mm_struct *mm);
-#ifdef CONFIG_MEMCG
 void lru_gen_migrate_mm(struct mm_struct *mm);
-#endif
 
 static inline void lru_gen_init_mm(struct mm_struct *mm)
 {
@@ -1050,11 +1048,9 @@ static inline void lru_gen_del_mm(struct mm_struct *mm)
 {
 }
 
-#ifdef CONFIG_MEMCG
 static inline void lru_gen_migrate_mm(struct mm_struct *mm)
 {
 }
-#endif
 
 static inline void lru_gen_init_mm(struct mm_struct *mm)
 {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index bc3f63ec4291..28665e1b8475 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -440,14 +440,12 @@ struct lru_gen_folio {
 	atomic_long_t refaulted[NR_HIST_GENS][ANON_AND_FILE][MAX_NR_TIERS];
 	/* whether the multi-gen LRU is enabled */
 	bool enabled;
-#ifdef CONFIG_MEMCG
 	/* the memcg generation this lru_gen_folio belongs to */
 	u8 gen;
 	/* the list segment this lru_gen_folio belongs to */
 	u8 seg;
 	/* per-node lru_gen_folio list for global reclaim */
 	struct hlist_nulls_node list;
-#endif
 };
 
 enum {
@@ -493,11 +491,6 @@ struct lru_gen_mm_walk {
 	bool force_scan;
 };
 
-void lru_gen_init_lruvec(struct lruvec *lruvec);
-void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
-
-#ifdef CONFIG_MEMCG
-
 /*
  * For each node, memcgs are divided into two generations: the old and the
  * young. For each generation, memcgs are randomly sharded into multiple bins
@@ -555,6 +548,8 @@ struct lru_gen_memcg {
 };
 
 void lru_gen_init_pgdat(struct pglist_data *pgdat);
+void lru_gen_init_lruvec(struct lruvec *lruvec);
+void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
 
 void lru_gen_init_memcg(struct mem_cgroup *memcg);
 void lru_gen_exit_memcg(struct mem_cgroup *memcg);
@@ -563,19 +558,6 @@ void lru_gen_offline_memcg(struct mem_cgroup *memcg);
 void lru_gen_release_memcg(struct mem_cgroup *memcg);
 void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid);
 
-#else /* !CONFIG_MEMCG */
-
-#define MEMCG_NR_GENS	1
-
-struct lru_gen_memcg {
-};
-
-static inline void lru_gen_init_pgdat(struct pglist_data *pgdat)
-{
-}
-
-#endif /* CONFIG_MEMCG */
-
 #else /* !CONFIG_LRU_GEN */
 
 static inline void lru_gen_init_pgdat(struct pglist_data *pgdat)
@@ -590,8 +572,6 @@ static inline void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 {
 }
 
-#ifdef CONFIG_MEMCG
-
 static inline void lru_gen_init_memcg(struct mem_cgroup *memcg)
 {
 }
@@ -616,8 +596,6 @@ static inline void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
 {
 }
 
-#endif /* CONFIG_MEMCG */
-
 #endif /* CONFIG_LRU_GEN */
 
 struct lruvec {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index aa7ea09ffb4c..351a0b5043c0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4097,13 +4097,6 @@ enum {
 	MEMCG_LRU_YOUNG,
 };
 
-#ifdef CONFIG_MEMCG
-
-static int lru_gen_memcg_seg(struct lruvec *lruvec)
-{
-	return READ_ONCE(lruvec->lrugen.seg);
-}
-
 static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 {
 	int seg;
@@ -4150,6 +4143,8 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	spin_unlock_irqrestore(&pgdat->memcg_lru.lock, flags);
 }
 
+#ifdef CONFIG_MEMCG
+
 void lru_gen_online_memcg(struct mem_cgroup *memcg)
 {
 	int gen;
@@ -4217,18 +4212,11 @@ void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
 	struct lruvec *lruvec = get_lruvec(memcg, nid);
 
 	/* see the comment on MEMCG_NR_GENS */
-	if (lru_gen_memcg_seg(lruvec) != MEMCG_LRU_HEAD)
+	if (READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_HEAD)
 		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_HEAD);
 }
 
-#else /* !CONFIG_MEMCG */
-
-static int lru_gen_memcg_seg(struct lruvec *lruvec)
-{
-	return 0;
-}
-
-#endif
+#endif /* CONFIG_MEMCG */
 
 /******************************************************************************
  *                          the eviction
@@ -4776,7 +4764,7 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 
 	if (mem_cgroup_below_low(NULL, memcg)) {
 		/* see the comment on MEMCG_NR_GENS */
-		if (lru_gen_memcg_seg(lruvec) != MEMCG_LRU_TAIL)
+		if (READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_TAIL)
 			return MEMCG_LRU_TAIL;
 
 		memcg_memory_event(memcg, MEMCG_LOW);
@@ -4799,12 +4787,10 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 		return 0;
 
 	/* one retry if offlined or too small */
-	return lru_gen_memcg_seg(lruvec) != MEMCG_LRU_TAIL ?
+	return READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_TAIL ?
 	       MEMCG_LRU_TAIL : MEMCG_LRU_YOUNG;
 }
 
-#ifdef CONFIG_MEMCG
-
 static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	int op;
@@ -4896,20 +4882,6 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	blk_finish_plug(&plug);
 }
 
-#else /* !CONFIG_MEMCG */
-
-static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
-{
-	BUILD_BUG();
-}
-
-static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
-{
-	BUILD_BUG();
-}
-
-#endif
-
 static void set_initial_priority(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	int priority;
@@ -5560,6 +5532,18 @@ static const struct file_operations lru_gen_ro_fops = {
  *                          initialization
  ******************************************************************************/
 
+void lru_gen_init_pgdat(struct pglist_data *pgdat)
+{
+	int i, j;
+
+	spin_lock_init(&pgdat->memcg_lru.lock);
+
+	for (i = 0; i < MEMCG_NR_GENS; i++) {
+		for (j = 0; j < MEMCG_NR_BINS; j++)
+			INIT_HLIST_NULLS_HEAD(&pgdat->memcg_lru.fifo[i][j], i);
+	}
+}
+
 void lru_gen_init_lruvec(struct lruvec *lruvec)
 {
 	int i;
@@ -5582,18 +5566,6 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
 
 #ifdef CONFIG_MEMCG
 
-void lru_gen_init_pgdat(struct pglist_data *pgdat)
-{
-	int i, j;
-
-	spin_lock_init(&pgdat->memcg_lru.lock);
-
-	for (i = 0; i < MEMCG_NR_GENS; i++) {
-		for (j = 0; j < MEMCG_NR_BINS; j++)
-			INIT_HLIST_NULLS_HEAD(&pgdat->memcg_lru.fifo[i][j], i);
-	}
-}
-
 void lru_gen_init_memcg(struct mem_cgroup *memcg)
 {
 	struct lru_gen_mm_list *mm_list = get_mm_list(memcg);
@@ -5653,14 +5625,17 @@ late_initcall(init_lru_gen);
 
 static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
+	BUILD_BUG();
 }
 
 static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
+	BUILD_BUG();
 }
 
 static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
+	BUILD_BUG();
 }
 
 #endif /* CONFIG_LRU_GEN */
-- 
2.43.0.472.g3155946c3a-goog


