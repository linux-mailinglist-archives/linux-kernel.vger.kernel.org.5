Return-Path: <linux-kernel+bounces-9590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A1F81C819
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB111C25149
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D073F1803A;
	Fri, 22 Dec 2023 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuBZ0SE8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45FB168BE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d0a679fca7so1038979b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703240649; x=1703845449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TmeNvQjyOn7MVyb9xd+5eOKYiNc8no2eFt793P8sn6s=;
        b=ZuBZ0SE8tHRCwX5jB7kLowB8qUZMm+WOeoBl4MjV6UyykT7OLY4x9Ix7jA3gIiw+hl
         nos6CKLfbk0l6zMX87cuzgze3z8RMQhm2ud1L9PPOA8zZuDfo91BJg3IkbhsWaG5Q3gz
         I5Jt9suR4BGqy1kf+nTx+UShAoEN9XUo2Jg/G8x1TpnOOyysn/LTBN/m9mpF7pd9hjqo
         JMs+jVFomaPbV5ogKF9WA52pncNEBOYRmQzKZhkd27tVz1aCbq2gPfMXChZ5ft6/+bAz
         VDHMIstPkhOXaQ3IvYi5Z2m5PIp7cBZqSG0ayvMCyw8ckA/oDso6UjmVQ8Vc5UXLGBMr
         dLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703240649; x=1703845449;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TmeNvQjyOn7MVyb9xd+5eOKYiNc8no2eFt793P8sn6s=;
        b=OORBLwZu7cdqLzyPfXcRi2ykeuqM8p6b/En2TA9K2DOB1epHS3O9cQeLMU4M+bWDMC
         f8ofN4GKgL7De3NrgTqe154peLUL0+IQ+vyKCZ257EhZ3619IdFpy0EcB6TZX19VXxGg
         CHGHo6K5quYwkyn3l5BQU6JPrubFhfyn8y09BzY03OC6OYezAgwzJHJm5yWBdbZwQGlt
         K5xkTgiX6GTVX7c6Kwk83UjodIqmq+zBdMkkXAFoGNhKSD//AZcTJ2vFZY/juSvP6Omr
         wLD7EHibqFXPZX2gU1D5pBfmCrkaokY19rHKPSCY1WV7hqSbemmVKFoZou203t4ihRnE
         XJng==
X-Gm-Message-State: AOJu0YzkVZ4mMRj5IcrIiehQqMSP3ZVkb9mAp0G1/Z9wFSSRO4dKp81H
	QMnl32LyU4Gv16lc0qLM1eY=
X-Google-Smtp-Source: AGHT+IFqSFyTsdaDJbnz34Tju5Rl8kxf/zGRHLlyWWOVYHMpESFATB5jFyXEKy/Qqs+cjCDyhnGHDQ==
X-Received: by 2002:aa7:8554:0:b0:6d8:bef3:4182 with SMTP id y20-20020aa78554000000b006d8bef34182mr721760pfn.1.1703240648841;
        Fri, 22 Dec 2023 02:24:08 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id gx1-20020a056a001e0100b006d9912e9a77sm364074pfb.6.2023.12.22.02.24.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Dec 2023 02:24:08 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 1/3] mm, lru_gen: batch update counters on againg
Date: Fri, 22 Dec 2023 18:22:53 +0800
Message-ID: <20231222102255.56993-2-ryncsn@gmail.com>
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

When lru_gen is aging, it will update mm counters page by page,
which causes a higher overhead if age happens frequently or there
are a lot of pages in one generation getting moved.
Optimize this by doing the counter update in batch.

Although most __mod_*_state has its own caches the overhead
is still observable.

Tested in a 4G memcg on a EPYC 7K62 with:

  memcached -u nobody -m 16384 -s /tmp/memcached.socket \
    -a 0766 -t 16 -B binary &

  memtier_benchmark -S /tmp/memcached.socket \
    -P memcache_binary -n allkeys \
    --key-minimum=1 --key-maximum=16000000 -d 1024 \
    --ratio=1:0 --key-pattern=P:P -c 2 -t 16 --pipeline 8 -x 6

Average result of 18 test runs:

Before: 44017.78 Ops/sec
After:  44687.08 Ops/sec (+1.5%)

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/vmscan.c | 64 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b4ca3563bcf4..e3b4797b9729 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3095,9 +3095,47 @@ static int folio_update_gen(struct folio *folio, int gen)
 	return ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
 }
 
+/*
+ * Update LRU gen in batch for each lru_gen LRU list. The batch is limited to
+ * each gen / type / zone level LRU. Batch is applied after finished or aborted
+ * scanning one LRU list.
+ */
+struct gen_update_batch {
+	int delta[MAX_NR_GENS];
+};
+
+static void lru_gen_update_batch(struct lruvec *lruvec, bool type, int zone,
+				 struct gen_update_batch *batch)
+{
+	int gen;
+	int promoted = 0;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	enum lru_list lru = type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
+
+	for (gen = 0; gen < MAX_NR_GENS; gen++) {
+		int delta = batch->delta[gen];
+
+		if (!delta)
+			continue;
+
+		WRITE_ONCE(lrugen->nr_pages[gen][type][zone],
+			   lrugen->nr_pages[gen][type][zone] + delta);
+
+		if (lru_gen_is_active(lruvec, gen))
+			promoted += delta;
+	}
+
+	if (promoted) {
+		__update_lru_size(lruvec, lru, zone, -promoted);
+		__update_lru_size(lruvec, lru + LRU_ACTIVE, zone, promoted);
+	}
+}
+
 /* protect pages accessed multiple times through file descriptors */
-static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
+static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio,
+			 bool reclaiming, struct gen_update_batch *batch)
 {
+	int delta = folio_nr_pages(folio);
 	int type = folio_is_file_lru(folio);
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
@@ -3120,7 +3158,8 @@ static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclai
 			new_flags |= BIT(PG_reclaim);
 	} while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
 
-	lru_gen_update_size(lruvec, folio, old_gen, new_gen);
+	batch->delta[old_gen] -= delta;
+	batch->delta[new_gen] += delta;
 
 	return new_gen;
 }
@@ -3663,6 +3702,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 {
 	int zone;
 	int remaining = MAX_LRU_BATCH;
+	struct gen_update_batch batch = { };
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
 
@@ -3681,12 +3721,15 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 			VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
 
-			new_gen = folio_inc_gen(lruvec, folio, false);
+			new_gen = folio_inc_gen(lruvec, folio, false, &batch);
 			list_move_tail(&folio->lru, &lrugen->folios[new_gen][type][zone]);
 
-			if (!--remaining)
+			if (!--remaining) {
+				lru_gen_update_batch(lruvec, type, zone, &batch);
 				return false;
+			}
 		}
+		lru_gen_update_batch(lruvec, type, zone, &batch);
 	}
 done:
 	reset_ctrl_pos(lruvec, type, true);
@@ -4197,7 +4240,7 @@ static int lru_gen_memcg_seg(struct lruvec *lruvec)
  ******************************************************************************/
 
 static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_control *sc,
-		       int tier_idx)
+		       int tier_idx, struct gen_update_batch *batch)
 {
 	bool success;
 	int gen = folio_lru_gen(folio);
@@ -4239,7 +4282,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	if (tier > tier_idx || refs == BIT(LRU_REFS_WIDTH)) {
 		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
-		gen = folio_inc_gen(lruvec, folio, false);
+		gen = folio_inc_gen(lruvec, folio, false, batch);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 
 		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
@@ -4249,7 +4292,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 
 	/* ineligible */
 	if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
-		gen = folio_inc_gen(lruvec, folio, false);
+		gen = folio_inc_gen(lruvec, folio, false, batch);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
 	}
@@ -4257,7 +4300,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	/* waiting for writeback */
 	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
 	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
-		gen = folio_inc_gen(lruvec, folio, true);
+		gen = folio_inc_gen(lruvec, folio, true, batch);
 		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
 	}
@@ -4323,6 +4366,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	for (i = MAX_NR_ZONES; i > 0; i--) {
 		LIST_HEAD(moved);
 		int skipped_zone = 0;
+		struct gen_update_batch batch = { };
 		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
 		struct list_head *head = &lrugen->folios[gen][type][zone];
 
@@ -4337,7 +4381,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 
 			scanned += delta;
 
-			if (sort_folio(lruvec, folio, sc, tier))
+			if (sort_folio(lruvec, folio, sc, tier, &batch))
 				sorted += delta;
 			else if (isolate_folio(lruvec, folio, sc)) {
 				list_add(&folio->lru, list);
@@ -4357,6 +4401,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 			skipped += skipped_zone;
 		}
 
+		lru_gen_update_batch(lruvec, type, zone, &batch);
+
 		if (!remaining || isolated >= MIN_LRU_BATCH)
 			break;
 	}
-- 
2.43.0


