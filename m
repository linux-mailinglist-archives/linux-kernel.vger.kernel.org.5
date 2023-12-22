Return-Path: <linux-kernel+bounces-9591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 149F081C81B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE39288C23
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267F318636;
	Fri, 22 Dec 2023 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkBUT+4j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E1D18054
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-203fed05a31so1116439fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703240652; x=1703845452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gsAcvd86KuP2ISw06xLpP7WDqEO9VY9n54CovJHHIls=;
        b=EkBUT+4jVO5UYs3Cgaf5ikrKSKqM1Oknk/QO7sd1R+9evYo9hRvjSM4gUcGwIaf67Z
         KYNk/kK33+jPs/LfnTPRKvkUVFOoDtWL2q5g14lw+jEFaW7u8NCBu5dynJ3Tbh8UYQgN
         wdLA7wxYhzIyRGZFyQVMTgP64p3CDSmsr//2ZbfqIOM02ngsX20NqA13h3zTAaXvOYar
         PZIF7seYGGElVd0yIPEFQ4GlTvnjjM7LaBuAKcLF//y4Z/BnqGyiWRLayq+dHI+K7ZFT
         u6DZcnXKevdFgBlIfUg6IN23b5auMO7RMax7C+1J9tDmCW6jsz7bVUDMs89huYmKWy2o
         +FGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703240652; x=1703845452;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gsAcvd86KuP2ISw06xLpP7WDqEO9VY9n54CovJHHIls=;
        b=nJjMtva++m0JBfDBI/dtxuHxDFLQfP5V7JQ7hVlaD/9ZK1Rmud2leFXg9DuHu2soJx
         pJ3OX8f6VVED5aPVJotR+1iw6Y2BEbPo24RmfJj7Y/uY/Jya5fTK+TVBkqVqEeI9x3Fx
         MsEXi2QIZxhttWO3VMOd9ae5qknpMERmqYBzhuc0nr7/TQMhbUHUiyroCtpawS1CRcKI
         g9Z4FMJUstIhav9VRMZybrQRQu6BlCOiD782psM6nKjL7/65jiI3QTSaKPqrHK8oNRt1
         cBx+kBD+Yew5LEMHYl4MPbbTIDufUgJ5U3yiwoENeUyAoE1+LbaiAz30EdrlI39pFt44
         Qiew==
X-Gm-Message-State: AOJu0YzJ3zl1lMTyD9NPmNS+7dt+N1dGk6JNbnXqrmWS8y0j+3IjKHsh
	NC+KRHHxWIkVpULFgjQKYWI=
X-Google-Smtp-Source: AGHT+IFM08JVkja56Id51LMPVYml7/oIhHyVGlp94LC9R8zx3T0/LUwfVjdY7Ob42uuEZ9jE1hgJMg==
X-Received: by 2002:a05:6870:ce0b:b0:204:5455:c44b with SMTP id xc11-20020a056870ce0b00b002045455c44bmr41106oab.107.1703240651957;
        Fri, 22 Dec 2023 02:24:11 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id gx1-20020a056a001e0100b006d9912e9a77sm364074pfb.6.2023.12.22.02.24.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Dec 2023 02:24:11 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 2/3] mm, lru_gen: move pages in bulk when aging
Date: Fri, 22 Dec 2023 18:22:54 +0800
Message-ID: <20231222102255.56993-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222102255.56993-1-ryncsn@gmail.com>
References: <20231222102255.56993-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Another overhead of aging is page moving. Actually, in most cases,
pages are being moved to the same gen after folio_inc_gen is called,
especially the protected pages.  So it's better to move them in bulk.

This also has a good effect on LRU ordering. Currently when MGLRU
ages, it walks the LRU backward, and the protected pages are moved to
the tail of newer gen one by one, which reverses the order of pages in
LRU. Moving them in batches can help keep their order, only in a small
scope though due to the scan limit of MAX_LRU_BATCH pages.

After this commit, we can see a performance gain:

Tested in a 4G memcg on a EPYC 7K62 with:

  memcached -u nobody -m 16384 -s /tmp/memcached.socket \
    -a 0766 -t 16 -B binary &

  memtier_benchmark -S /tmp/memcached.socket \
    -P memcache_binary -n allkeys \
    --key-minimum=1 --key-maximum=16000000 -d 1024 \
    --ratio=1:0 --key-pattern=P:P -c 2 -t 16 --pipeline 8 -x 6

Average result of 18 test runs:

Before:           44017.78 Ops/sec
After patch 1-2:  44810.01 Ops/sec (+1.8%)

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/vmscan.c | 84 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 13 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e3b4797b9729..af1266129c1b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3102,9 +3102,46 @@ static int folio_update_gen(struct folio *folio, int gen)
  */
 struct gen_update_batch {
 	int delta[MAX_NR_GENS];
+	struct folio *head, *tail;
 };
 
-static void lru_gen_update_batch(struct lruvec *lruvec, bool type, int zone,
+static void inline lru_gen_inc_bulk_finish(struct lru_gen_folio *lrugen,
+					   int bulk_gen, bool type, int zone,
+					   struct gen_update_batch *batch)
+{
+	if (!batch->head)
+		return;
+
+	list_bulk_move_tail(&lrugen->folios[bulk_gen][type][zone],
+			    &batch->head->lru,
+			    &batch->tail->lru);
+
+	batch->head = NULL;
+}
+
+/*
+ * When aging, protected pages will go to the tail of the same higher
+ * gen, so the can be moved in batches. Besides reduced overhead, this
+ * also avoids changing their LRU order in a small scope.
+ */
+static void inline lru_gen_try_inc_bulk(struct lru_gen_folio *lrugen, struct folio *folio,
+					int bulk_gen, int gen, bool type, int zone,
+					struct gen_update_batch *batch)
+{
+	/*
+	 * If folio not moving to the bulk_gen, it's raced with promotion
+	 * so it need to go to the head of another LRU.
+	 */
+	if (bulk_gen != gen)
+		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
+
+	if (!batch->head)
+		batch->tail = folio;
+
+	batch->head = folio;
+}
+
+static void lru_gen_update_batch(struct lruvec *lruvec, int bulk_gen, bool type, int zone,
 				 struct gen_update_batch *batch)
 {
 	int gen;
@@ -3112,6 +3149,8 @@ static void lru_gen_update_batch(struct lruvec *lruvec, bool type, int zone,
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	enum lru_list lru = type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
 
+	lru_gen_inc_bulk_finish(lrugen, bulk_gen, type, zone, batch);
+
 	for (gen = 0; gen < MAX_NR_GENS; gen++) {
 		int delta = batch->delta[gen];
 
@@ -3705,6 +3744,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 	struct gen_update_batch batch = { };
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
+	int bulk_gen = (old_gen + 1) % MAX_NR_GENS;
 
 	if (type == LRU_GEN_ANON && !can_swap)
 		goto done;
@@ -3712,24 +3752,33 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 	/* prevent cold/hot inversion if force_scan is true */
 	for (zone = 0; zone < MAX_NR_ZONES; zone++) {
 		struct list_head *head = &lrugen->folios[old_gen][type][zone];
+		struct folio *prev = NULL;
 
-		while (!list_empty(head)) {
-			struct folio *folio = lru_to_folio(head);
+		if (!list_empty(head))
+			prev = lru_to_folio(head);
 
+		while (prev) {
+			struct folio *folio = prev;
 			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
 
+			if (unlikely(list_is_first(&folio->lru, head)))
+				prev = NULL;
+			else
+				prev = lru_to_folio(&folio->lru);
+
 			new_gen = folio_inc_gen(lruvec, folio, false, &batch);
-			list_move_tail(&folio->lru, &lrugen->folios[new_gen][type][zone]);
+			lru_gen_try_inc_bulk(lrugen, folio, bulk_gen, new_gen, type, zone, &batch);
 
 			if (!--remaining) {
-				lru_gen_update_batch(lruvec, type, zone, &batch);
+				lru_gen_update_batch(lruvec, bulk_gen, type, zone, &batch);
 				return false;
 			}
 		}
-		lru_gen_update_batch(lruvec, type, zone, &batch);
+
+		lru_gen_update_batch(lruvec, bulk_gen, type, zone, &batch);
 	}
 done:
 	reset_ctrl_pos(lruvec, type, true);
@@ -4240,7 +4289,7 @@ static int lru_gen_memcg_seg(struct lruvec *lruvec)
  ******************************************************************************/
 
 static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_control *sc,
-		       int tier_idx, struct gen_update_batch *batch)
+		       int tier_idx, int bulk_gen, struct gen_update_batch *batch)
 {
 	bool success;
 	int gen = folio_lru_gen(folio);
@@ -4283,7 +4332,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
 		gen = folio_inc_gen(lruvec, folio, false, batch);
-		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		lru_gen_try_inc_bulk(lrugen, folio, bulk_gen, gen, type, zone, batch);
 
 		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
 			   lrugen->protected[hist][type][tier - 1] + delta);
@@ -4293,7 +4342,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	/* ineligible */
 	if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
 		gen = folio_inc_gen(lruvec, folio, false, batch);
-		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		lru_gen_try_inc_bulk(lrugen, folio, bulk_gen, gen, type, zone, batch);
 		return true;
 	}
 
@@ -4367,11 +4416,16 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 		LIST_HEAD(moved);
 		int skipped_zone = 0;
 		struct gen_update_batch batch = { };
+		int bulk_gen = (gen + 1) % MAX_NR_GENS;
 		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
 		struct list_head *head = &lrugen->folios[gen][type][zone];
+		struct folio *prev = NULL;
 
-		while (!list_empty(head)) {
-			struct folio *folio = lru_to_folio(head);
+		if (!list_empty(head))
+			prev = lru_to_folio(head);
+
+		while (prev) {
+			struct folio *folio = prev;
 			int delta = folio_nr_pages(folio);
 
 			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
@@ -4380,8 +4434,12 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
 
 			scanned += delta;
+			if (unlikely(list_is_first(&folio->lru, head)))
+				prev = NULL;
+			else
+				prev = lru_to_folio(&folio->lru);
 
-			if (sort_folio(lruvec, folio, sc, tier, &batch))
+			if (sort_folio(lruvec, folio, sc, tier, bulk_gen, &batch))
 				sorted += delta;
 			else if (isolate_folio(lruvec, folio, sc)) {
 				list_add(&folio->lru, list);
@@ -4401,7 +4459,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 			skipped += skipped_zone;
 		}
 
-		lru_gen_update_batch(lruvec, type, zone, &batch);
+		lru_gen_update_batch(lruvec, bulk_gen, type, zone, &batch);
 
 		if (!remaining || isolated >= MIN_LRU_BATCH)
 			break;
-- 
2.43.0


