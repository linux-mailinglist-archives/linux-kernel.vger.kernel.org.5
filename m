Return-Path: <linux-kernel+bounces-23983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C872282B4C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFFB1F2425C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1AE55C04;
	Thu, 11 Jan 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzfNPMQd"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC51554FB1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d409bcb0e7so31429775ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704998018; x=1705602818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2NX9KnQsza9Uz6QRxAoPzwzDEngTlQbn6WQFeW15RSs=;
        b=gzfNPMQdiBRCekSwFSY1SXSxbDWm3t1v+H8m4g/Zg1DPwTgTXQGPfA09VML3Oeh3WY
         jobFDlkdgNu7zeTaW83Y6r8tt8awrXBjKT+cyNVB191ntp313PqXx243G6L2Yh2p5b+K
         9Ag6qOciaurxgUzQPqFrvQru0kYSzKKQVf0NLTzJdGRCm7F4fN0FAP/tn5MH3UhBbf7t
         +5iBkWh4qPjtka/h1B0kHC13XygQ9LjpwU9DacUfpuamBVNT9CEVJdKmgJFk8o4v6/Ns
         TQOVrf9Zpbo0B2itUSMHdZ0935oVbrAXp3WFC9mZDK6IAXwB3al9UWGBhjVgDNNfOhcR
         ifvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998018; x=1705602818;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NX9KnQsza9Uz6QRxAoPzwzDEngTlQbn6WQFeW15RSs=;
        b=Q13ctGVoFMUVElSKmVWe5hz5teomTUktb0XuxXjejf9SY+o61uu+75fM2R+Q858zgA
         U0IlHnp1EqLYibR159qZu5Q8RUSbYkBEMNqtbLseYhzPFSz4NHmoh5wgOYsaLIvplrlH
         SLIh7+GTlWX+PrR5vDCCsYNi30elSikWQFW3mUFHlWVv2maRNQ5rZ8k7sABMraxbQUwx
         VT3Y/9uBUN1SCyKURHETx47ZN7X18dl1DIJI430jxmVMGLHwXTtuGKDf/sf6yuLyZlHp
         M0WbZ91e7nG7FrPK/QtZbPXFU014ncc65wra4lfc9aXQg6gsfKZ/oJjJ7QaZS3L4xorP
         pKxw==
X-Gm-Message-State: AOJu0YwjIK0gw92PTj0kve/oPFT1p7ldXZPMm/OQGW1IJFeK3qj66B1Q
	nhUES3LGeVc+hc+edvW9pQQ=
X-Google-Smtp-Source: AGHT+IHnDtOq2y94Dh8PFjaWgtWLEz5nVEvXR0aC1RzvZIlhpBXuXDqh89s31F4som1CtytG5C2rzA==
X-Received: by 2002:a17:902:6b82:b0:1d4:7685:90df with SMTP id p2-20020a1709026b8200b001d4768590dfmr161590plk.31.1704998018116;
        Thu, 11 Jan 2024 10:33:38 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id mf3-20020a170902fc8300b001d08e080042sm1483267plb.43.2024.01.11.10.33.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jan 2024 10:33:37 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	Chris Li <chrisl@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 1/3] mm, lru_gen: batch update counters on againg
Date: Fri, 12 Jan 2024 02:33:19 +0800
Message-ID: <20240111183321.19984-2-ryncsn@gmail.com>
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
index 4f9c854ce6cc..185d53607c7e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3113,9 +3113,47 @@ static int folio_update_gen(struct folio *folio, int gen)
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
+static void lru_gen_update_batch(struct lruvec *lruvec, int type, int zone,
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
@@ -3138,7 +3176,8 @@ static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclai
 			new_flags |= BIT(PG_reclaim);
 	} while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
 
-	lru_gen_update_size(lruvec, folio, old_gen, new_gen);
+	batch->delta[old_gen] -= delta;
+	batch->delta[new_gen] += delta;
 
 	return new_gen;
 }
@@ -3672,6 +3711,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 {
 	int zone;
 	int remaining = MAX_LRU_BATCH;
+	struct gen_update_batch batch = { };
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
 
@@ -3690,12 +3730,15 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
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
@@ -4215,7 +4258,7 @@ void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
  ******************************************************************************/
 
 static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_control *sc,
-		       int tier_idx)
+		       int tier_idx, struct gen_update_batch *batch)
 {
 	bool success;
 	int gen = folio_lru_gen(folio);
@@ -4257,7 +4300,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	if (tier > tier_idx || refs == BIT(LRU_REFS_WIDTH)) {
 		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
-		gen = folio_inc_gen(lruvec, folio, false);
+		gen = folio_inc_gen(lruvec, folio, false, batch);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 
 		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
@@ -4267,7 +4310,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 
 	/* ineligible */
 	if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
-		gen = folio_inc_gen(lruvec, folio, false);
+		gen = folio_inc_gen(lruvec, folio, false, batch);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
 	}
@@ -4275,7 +4318,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	/* waiting for writeback */
 	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
 	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
-		gen = folio_inc_gen(lruvec, folio, true);
+		gen = folio_inc_gen(lruvec, folio, true, batch);
 		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
 	}
@@ -4341,6 +4384,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	for (i = MAX_NR_ZONES; i > 0; i--) {
 		LIST_HEAD(moved);
 		int skipped_zone = 0;
+		struct gen_update_batch batch = { };
 		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
 		struct list_head *head = &lrugen->folios[gen][type][zone];
 
@@ -4355,7 +4399,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 
 			scanned += delta;
 
-			if (sort_folio(lruvec, folio, sc, tier))
+			if (sort_folio(lruvec, folio, sc, tier, &batch))
 				sorted += delta;
 			else if (isolate_folio(lruvec, folio, sc)) {
 				list_add(&folio->lru, list);
@@ -4375,6 +4419,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 			skipped += skipped_zone;
 		}
 
+		lru_gen_update_batch(lruvec, type, zone, &batch);
+
 		if (!remaining || isolated >= MIN_LRU_BATCH)
 			break;
 	}
-- 
2.43.0


