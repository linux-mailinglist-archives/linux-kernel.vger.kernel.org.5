Return-Path: <linux-kernel+bounces-23984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A5582B4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85C71F23C91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC6655C37;
	Thu, 11 Jan 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSd6NJ4t"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055555C0A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d51ba18e1bso46461065ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704998021; x=1705602821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ooTkGE2rW3pIuHvnebpbhiU0Zel5DUvb4P5ZSh1D2Dw=;
        b=FSd6NJ4t8g8M+s9wMQHcm9TSrwgpulq1tTGlz4IxxllxgYGC2pct+Z46b+3chvYKdB
         IYcTxNU+xus1+rBu79MRyjjhV77oXMsW38poWpPpxWkj7EDuGZw7vtjwGsGx+dfETfx4
         oqqvMHP+kHU1cXqeEMytXAMZ2nW7RVYCbYHYZbgm232xOiZsvrHpXxCV1l9v6bXxk391
         ee1OvMxoGTkw/lxBrTeupz9lQNehVFCBU8HZYe0sRh4OU4HEHVfVH80qQVuWX3unC5B1
         x0sSyvKwDU10LUgjRdpIa+qTRMfeCqbVIHzORJJhaim+kBLsQA6wMsjxb3QphQCNENS6
         Q0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998021; x=1705602821;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooTkGE2rW3pIuHvnebpbhiU0Zel5DUvb4P5ZSh1D2Dw=;
        b=CsEpJ9TYATPvfnwu5TQPSwc3Inro9IB7WnZkhZrsr8iDxs+E4VMfWg3/0UfmhJ1bX+
         r4MJPzJKrPjPeLryHOwxG9/MmCtF7IibC/ZbGwvCc2WFXA2qz/FDVtnIJGxMCRO3v49l
         izSAcKLyBZgxDs7WGhTMgKSb84Mso20nEUlgn0BXa2XGXDdjIuSJ99NAUBazcn3IHX9R
         4QDPGfJdc98OS7wyQDWCqrJJRmKsSLDci0qvPrPvcUbV6GWpeGaht+hC8xDwWIH7QoIy
         Y564IusARyGrGNNPSaPH8ccBcdzDnpo3X2py+A0XYp+jctdTuezjZebhHsiHH8PVO1Rk
         U7wA==
X-Gm-Message-State: AOJu0YwAMOTek0NROCvBXO325OmDniXyI6oZkHarR654nnjvZ+gJCJwi
	O4cQquiXCC2FWAtXIZZxLdM=
X-Google-Smtp-Source: AGHT+IEDHbwlcQ2ocO41xF0rCg4oiBOl0m3y0fRQIMYq2UBZBjcvr8e3NyI9T83Xh8KcFvM5suVFWw==
X-Received: by 2002:a17:902:690c:b0:1d4:1b4e:ebf5 with SMTP id j12-20020a170902690c00b001d41b4eebf5mr171681plk.10.1704998020964;
        Thu, 11 Jan 2024 10:33:40 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id mf3-20020a170902fc8300b001d08e080042sm1483267plb.43.2024.01.11.10.33.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jan 2024 10:33:40 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	Chris Li <chrisl@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 2/3] mm, lru_gen: move pages in bulk when aging
Date: Fri, 12 Jan 2024 02:33:20 +0800
Message-ID: <20240111183321.19984-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111183321.19984-1-ryncsn@gmail.com>
References: <20240111183321.19984-1-ryncsn@gmail.com>
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

This also has a good effect on LRU order. Currently when MGLRU
ages, it walks the LRU backwards, and the protected pages are moved to
the tail of newer gen one by one, which actually reverses the order of
pages in LRU. Moving them in batches can help keep their order, only
in a small scope though, due to the scan limit of MAX_LRU_BATCH pages.

After this commit, we can see a slight performance gain (with
CONFIG_DEBUG_LIST=n):

Test 1: of memcached in a 4G memcg on a EPYC 7K62 with:

  memcached -u nobody -m 16384 -s /tmp/memcached.socket \
    -a 0766 -t 16 -B binary &

  memtier_benchmark -S /tmp/memcached.socket \
    -P memcache_binary -n allkeys \
    --key-minimum=1 --key-maximum=16000000 -d 1024 \
    --ratio=1:0 --key-pattern=P:P -c 2 -t 16 --pipeline 8 -x 6

Average result of 18 test runs:

Before:           44017.78 Ops/sec
After patch 1-2:  44810.01 Ops/sec (+1.8%)

Test 2: MySQL in 6G memcg with:

  echo 'set GLOBAL innodb_buffer_pool_size=16106127360;' | \
    mysql -u USER -h localhost --password=PASS

  sysbench /usr/share/sysbench/oltp_read_only.lua \
    --mysql-user=USER --mysql-password=PASS --mysql-db=sb\
    --tables=48 --table-size=2000000 --threads=16 --time=1800\
    --report-interval=5 run

QPS of 6 test runs:

Before:
134126.83
134352.13
134045.19
133985.12
134787.47
134554.43

After patch 1-2 (+0.4%):
134913.38
134695.35
134891.31
134662.66
135090.32
134901.14

Only about 10% CPU time is spent in kernel space for MySQL test so the
improvement is very trivial.

There could be a higher performance gain when pages are getting
protected aggressively.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/vmscan.c | 84 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 13 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 185d53607c7e..57b6549946c3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3120,9 +3120,46 @@ static int folio_update_gen(struct folio *folio, int gen)
  */
 struct gen_update_batch {
 	int delta[MAX_NR_GENS];
+	struct folio *head, *tail;
 };
 
-static void lru_gen_update_batch(struct lruvec *lruvec, int type, int zone,
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
+static inline void lru_gen_try_inc_bulk(struct lru_gen_folio *lrugen, struct folio *folio,
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
+static void lru_gen_update_batch(struct lruvec *lruvec, int bulk_gen, int type, int zone,
 				 struct gen_update_batch *batch)
 {
 	int gen;
@@ -3130,6 +3167,8 @@ static void lru_gen_update_batch(struct lruvec *lruvec, int type, int zone,
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	enum lru_list lru = type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
 
+	lru_gen_inc_bulk_finish(lrugen, bulk_gen, type, zone, batch);
+
 	for (gen = 0; gen < MAX_NR_GENS; gen++) {
 		int delta = batch->delta[gen];
 
@@ -3714,6 +3753,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 	struct gen_update_batch batch = { };
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
+	int bulk_gen = (old_gen + 1) % MAX_NR_GENS;
 
 	if (type == LRU_GEN_ANON && !can_swap)
 		goto done;
@@ -3721,24 +3761,33 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
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
@@ -4258,7 +4307,7 @@ void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
  ******************************************************************************/
 
 static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_control *sc,
-		       int tier_idx, struct gen_update_batch *batch)
+		       int tier_idx, int bulk_gen, struct gen_update_batch *batch)
 {
 	bool success;
 	int gen = folio_lru_gen(folio);
@@ -4301,7 +4350,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
 		gen = folio_inc_gen(lruvec, folio, false, batch);
-		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		lru_gen_try_inc_bulk(lrugen, folio, bulk_gen, gen, type, zone, batch);
 
 		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
 			   lrugen->protected[hist][type][tier - 1] + delta);
@@ -4311,7 +4360,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	/* ineligible */
 	if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
 		gen = folio_inc_gen(lruvec, folio, false, batch);
-		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		lru_gen_try_inc_bulk(lrugen, folio, bulk_gen, gen, type, zone, batch);
 		return true;
 	}
 
@@ -4385,11 +4434,16 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
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
@@ -4398,8 +4452,12 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
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
@@ -4419,7 +4477,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 			skipped += skipped_zone;
 		}
 
-		lru_gen_update_batch(lruvec, type, zone, &batch);
+		lru_gen_update_batch(lruvec, bulk_gen, type, zone, &batch);
 
 		if (!remaining || isolated >= MIN_LRU_BATCH)
 			break;
-- 
2.43.0


