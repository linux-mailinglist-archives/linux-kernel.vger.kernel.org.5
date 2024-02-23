Return-Path: <linux-kernel+bounces-77754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53198609C9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EFE288458
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D16D10A2A;
	Fri, 23 Feb 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R107QGsI"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B074910A01
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708661861; cv=none; b=dxwq4RnbIAyvu9Jnl/EhV/xS1d1F9biOvymuBNLyy9xX/YBE9vgp87nhYmiXhvorWpn4Gh2A0UnXL3YfHgDud2IhrXxgh1I6frP4qEMExJUUr6yUByLqp54LW17+xRbobtp1p6qK51R2/EMJm2Yb+BbLhLjAxwqmILspS8+b348=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708661861; c=relaxed/simple;
	bh=lBGBnghS4F7tZXGu+GMAmAoN/xklFqNUk5MgFHyDgjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jpdh/3LKH4DdXMy4MOalVajUU4MvKSRhBjTtePTbudhxZkQdWPl5nQNDz579Sm5Bsp/2LmUIsgqAIZMX8YHxf42MSBSuuM5ReOzHGt0R7np6OTOr5wHHxHoSibPS9d0W5H8vf87NcgG9RVag0Kto1epDdV5uH60LhD9SKZ69Vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R107QGsI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc0e5b223eso3083955ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708661859; x=1709266659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+9+uMP+Bu3TiyfCDkgIe0O8ZamRmCynrJ5soRd+G7M=;
        b=R107QGsI7MYqSy62d1RynQasOMKAO1i5ABtIHOddvCI0gLyOepqBtPyI1OOUpiNodk
         7S5fP02l74zeVvbC5Iw23yAVcvYoAJJ6t2xDt+sVdWrwl8hQ6rp9vqZlMIeUQwHFCGrj
         uHadkSg9i2CToKaNsY+jnbUSZcDGB8KzALgqdYdGrIgnOKpFbaLXG7SgbAmImvdwCrW/
         UvTiOLwjtroqmrnwX9ZIRTY02QuasoYGzW0A33Ae9BhbFU6qQWDf3A4PBb4kKjpPz5ox
         etAmg8CzYtVAVyLODwL8Vq+zcPxbhnmR8tBJARiInQ62i07MqgSXIroqYgUdNGjgX3Us
         RHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708661859; x=1709266659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+9+uMP+Bu3TiyfCDkgIe0O8ZamRmCynrJ5soRd+G7M=;
        b=Jpy4vt12dV7KrG4sLo5vI4GL3hHblsZ9mnvZFi7Cg9QZLl+i1N4LK1EPqE4XI9K7Y9
         areU7y2xef2UI2pg9SonPATDAZPJeKJ3F2XuIw/+46ZeTYjQuNGTYnDesa/9uQWD3A1k
         NGVUkO8VdnYyuN4wJMgE5MpzdfLSP+z+7ihJ8OtAgVBXyu05j3Az4E5mcU+7sVYlJjri
         G1gz5xgTvDNp4S6Hfncsd9reiEJ31jyl7Yue74xLPIRhQte9XD7Xm2WW0VY4CaISooxL
         DMlxTnLlh90X7ElsaDkKOldkIfitmJnWNt1FpunJPmfAnIwbzvu3x6ctsxDcq00l4t80
         ZBJg==
X-Gm-Message-State: AOJu0Yx4iPijAjLvyTaOF1oQkbXTA2yaDCG/ihnKqr4LykvowlDVSQM+
	WQhIcRL+RPE3AjXr2Zb3omTJEw0OkQ9eep87q0Wc/Vv3wEJ+oHvg+sRJYfcplQ4=
X-Google-Smtp-Source: AGHT+IEahzpjoCO4rsyjoYfjCIEkVvOSN5zx8vrEST2Nrht65jVZw1Eqx6UK2Bu6waRNM6E1tEjp/w==
X-Received: by 2002:a17:902:be0a:b0:1dc:6373:3cc with SMTP id r10-20020a170902be0a00b001dc637303ccmr652610pls.50.1708661858923;
        Thu, 22 Feb 2024 20:17:38 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:5a27:dbae:d10:c2d6])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b001dbb06b6133sm10662054pld.127.2024.02.22.20.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 20:17:38 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	minchan@kernel.org,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC] mm: madvise: pageout: ignore references rather than clearing young
Date: Fri, 23 Feb 2024 17:15:50 +1300
Message-Id: <20240223041550.77157-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

While doing MADV_PAGEOUT, the current code will clear PTE young
so that vmscan won't read young flags to allow the reclamation
of madvised folios to go ahead.
It seems we can do it by directly ignoring references, thus we
can remove tlb flush in madvise and rmap overhead in vmscan.

Regarding the side effect, in the original code, if a parallel
thread runs side by side to access the madvised memory with the
thread doing madvise, folios will get a chance to be re-activated
by vmscan. But with the patch, they will still be reclaimed. But
this behaviour doing PAGEOUT and doing access at the same time is
quite silly like DoS. So probably, we don't need to care.

A microbench as below has shown 6% decrement on the latency of
MADV_PAGEOUT,

 #define PGSIZE 4096
 main()
 {
 	int i;
 #define SIZE 512*1024*1024
 	volatile long *p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

 	for (i = 0; i < SIZE/sizeof(long); i += PGSIZE / sizeof(long))
 		p[i] =  0x11;

 	madvise(p, SIZE, MADV_PAGEOUT);
 }

w/o patch                    w/ patch
root@10:~# time ./a.out      root@10:~# time ./a.out
real	0m49.634s            real   0m46.334s
user	0m0.637s             user   0m0.648s
sys	0m47.434s            sys    0m44.265s

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/damon/paddr.c |  2 +-
 mm/internal.h    |  2 +-
 mm/madvise.c     |  8 ++++----
 mm/vmscan.c      | 12 +++++++-----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 081e2a325778..5e6dc312072c 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -249,7 +249,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 put_folio:
 		folio_put(folio);
 	}
-	applied = reclaim_pages(&folio_list);
+	applied = reclaim_pages(&folio_list, false);
 	cond_resched();
 	return applied * PAGE_SIZE;
 }
diff --git a/mm/internal.h b/mm/internal.h
index 93e229112045..36c11ea41f47 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -868,7 +868,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long);
 
 extern void set_pageblock_order(void);
-unsigned long reclaim_pages(struct list_head *folio_list);
+unsigned long reclaim_pages(struct list_head *folio_list, bool ignore_references);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
 /* The ALLOC_WMARK bits are used as an index to zone->watermark */
diff --git a/mm/madvise.c b/mm/madvise.c
index abde3edb04f0..44a498c94158 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -386,7 +386,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			return 0;
 		}
 
-		if (pmd_young(orig_pmd)) {
+		if (!pageout && pmd_young(orig_pmd)) {
 			pmdp_invalidate(vma, addr, pmd);
 			orig_pmd = pmd_mkold(orig_pmd);
 
@@ -410,7 +410,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
-			reclaim_pages(&folio_list);
+			reclaim_pages(&folio_list, true);
 		return 0;
 	}
 
@@ -490,7 +490,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
 
-		if (pte_young(ptent)) {
+		if (!pageout && pte_young(ptent)) {
 			ptent = ptep_get_and_clear_full(mm, addr, pte,
 							tlb->fullmm);
 			ptent = pte_mkold(ptent);
@@ -524,7 +524,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		pte_unmap_unlock(start_pte, ptl);
 	}
 	if (pageout)
-		reclaim_pages(&folio_list);
+		reclaim_pages(&folio_list, true);
 	cond_resched();
 
 	return 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 402c290fbf5a..ba2f37f46a73 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2102,7 +2102,8 @@ static void shrink_active_list(unsigned long nr_to_scan,
 }
 
 static unsigned int reclaim_folio_list(struct list_head *folio_list,
-				      struct pglist_data *pgdat)
+				      struct pglist_data *pgdat,
+				      bool ignore_references)
 {
 	struct reclaim_stat dummy_stat;
 	unsigned int nr_reclaimed;
@@ -2115,7 +2116,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.no_demotion = 1,
 	};
 
-	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, false);
+	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, ignore_references);
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
@@ -2125,7 +2126,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 	return nr_reclaimed;
 }
 
-unsigned long reclaim_pages(struct list_head *folio_list)
+unsigned long reclaim_pages(struct list_head *folio_list, bool ignore_references)
 {
 	int nid;
 	unsigned int nr_reclaimed = 0;
@@ -2147,11 +2148,12 @@ unsigned long reclaim_pages(struct list_head *folio_list)
 			continue;
 		}
 
-		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid),
+						   ignore_references);
 		nid = folio_nid(lru_to_folio(folio_list));
 	} while (!list_empty(folio_list));
 
-	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid), ignore_references);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
-- 
2.34.1


