Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DD379D647
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbjILQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236704AbjILQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:28:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5407E1703
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:28:34 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BEFC75C0208;
        Tue, 12 Sep 2023 12:28:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 12 Sep 2023 12:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1694536113; x=1694622513; bh=9vQ7qsdQ+RP7SfzfLEPFzsLiQiKEomD6WH+
        2Rhu3mcA=; b=ZpTUQyvbyV86YCj8+3kbPP+syFXBrGgx3+Nr/1LDYo3RlD0TEfe
        z+DgnttaQrSQLsdQ4bk6O9orX5XPfxFqTZ5TIm91hxMMdPnE3IsZTfH4DHuh3zDq
        E3O3SG4nLzshPZr/boNkN5n4z6/qYeUaFnu5FNV0M24VVvKIYs4CtQSlclzSnY0d
        AIifFKGP9lCkVhsJm8c2RS8kedtIot0h00/dra5EBUjL+ShKp0CTPWrL6B0k87JY
        bzIxO3VlxRN522MYC0/aMnxR74xaE4HTxQsiTrqv/Xw2Ov/p5QcdW7qdyEeCipCm
        KHJihqMxfqb/dNjpf/IEbzw0MQGzNwpGJcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694536113; x=1694622513; bh=9vQ7qsdQ+RP7SfzfLEPFzsLiQiKEomD6WH+
        2Rhu3mcA=; b=OcdsQuOPW/n5J3Tv/jrZYHO7ACqUAqPO7cbR7NEnnUDNby5cBmt
        JIGBbEHQLathe3cIGoaYPVMirFM/uLUyoUq+o43WBp+VoyJSBlSxaEDX7wFgUwjU
        7PKImSoNiYSUVemuQHP05u0C2kiuWUOukrIZyNnPcw4lXe+oKXQssqXns0Yvqcht
        jaY9VPsQozSigm0SAXnGBNoHYUmzfyky8yFUf5BSER69qJHhxTyg730gi5yIRr1c
        x02bDfPEObCnoFRelAypAvUUOJ3LyXZmVRgFSNleq6x1Con7O286zDl7qMZHw3Nw
        81eOQDT9HRCb3DXw602USF4Ju5VtkNZvj6Q==
X-ME-Sender: <xms:sZEAZSghKws85WAXIw3NWcaRsHCzuqX_pxXhcRtudm-oY483jFx62A>
    <xme:sZEAZTAq_QnnB1eEZ_N0P6bK3nYvGKKEDh0Ykn8goNVGVolSchKvi3W7ZI9z5zTLc
    GOqzm5wP9aOYVannw>
X-ME-Received: <xmr:sZEAZaFuUjCDCdXhoLrEoS2vR1Fjbl8Dvo4r_1mgeR6xqOxgw8ZCW0tXy62QzIgPQpQ7OzuQEUlHIt7RVdIwb1pSWDQe80MaufrQStEwIUf5AflIBr2b7srW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepge
    eghedugfduuddvleehheetgeeltdetieevuefhffevkefhveeufeeiieejgedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:sZEAZbQszYGHQC0jNctIlCI8yitOAhXf1TpJzAwojp9JgSJQyIWWNQ>
    <xmx:sZEAZfyEuSTQ2EBDjALsmJM5noc-FzdkcxCaFGf7pPwHkWESKLltCg>
    <xmx:sZEAZZ6jrvGQSMiGakx8AdP0KNUSWvnMKGjdquX6uw3nOdCEQ90X-A>
    <xmx:sZEAZcgPqnfhJQoyf_xomkTTFhqW2NfLucWefXLYWEViPv-VT6D4oA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Sep 2023 12:28:32 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH 1/4] mm/compaction: add support for >0 order folio memory compaction.
Date:   Tue, 12 Sep 2023 12:28:12 -0400
Message-Id: <20230912162815.440749-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230912162815.440749-1-zi.yan@sent.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Before, memory compaction only migrates order-0 folios and skips >0 order
folios. This commit adds support for >0 order folio compaction by keeping
isolated free pages at their original size without splitting them into
order-0 pages and using them directly during migration process.

What is different from the prior implementation:
1. All isolated free pages are kept in a MAX_ORDER+1 array of page lists,
   where each page list stores free pages in the same order.
2. All free pages are not post_alloc_hook() processed nor buddy pages,
   although their orders are stored in first page's private like buddy
   pages.
3. During migration, in new page allocation time (i.e., in
   compaction_alloc()), free pages are then processed by post_alloc_hook().
   When migration fails and a new page is returned (i.e., in
   compaction_free()), free pages are restored by reversing the
   post_alloc_hook() operations.

Step 3 is done for a latter optimization that splitting and/or merging free
pages during compaction becomes easier.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 108 +++++++++++++++++++++++++++++++++++++++---------
 mm/internal.h   |   7 +++-
 2 files changed, 94 insertions(+), 21 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 01ba298739dd..868e92e55d27 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -107,6 +107,44 @@ static void split_map_pages(struct list_head *list)
 	list_splice(&tmp_list, list);
 }
=20
+static unsigned long release_free_list(struct free_list *freepages)
+{
+	int order;
+	unsigned long high_pfn =3D 0;
+
+	for (order =3D 0; order <=3D MAX_ORDER; order++) {
+		struct page *page, *next;
+
+		list_for_each_entry_safe(page, next, &freepages[order].pages, lru) {
+			unsigned long pfn =3D page_to_pfn(page);
+
+			list_del(&page->lru);
+			/*
+			 * Convert free pages into post allocation pages, so
+			 * that we can free them via __free_page.
+			 */
+			post_alloc_hook(page, order, __GFP_MOVABLE);
+			__free_pages(page, order);
+			if (pfn > high_pfn)
+				high_pfn =3D pfn;
+		}
+	}
+	return high_pfn;
+}
+
+static void sort_free_pages(struct list_head *src, struct free_list *dst)
+{
+	unsigned int order;
+	struct page *page, *next;
+
+	list_for_each_entry_safe(page, next, src, lru) {
+		order =3D buddy_order(page);
+
+		list_move(&page->lru, &dst[order].pages);
+		dst[order].nr_free++;
+	}
+}
+
 #ifdef CONFIG_COMPACTION
 bool PageMovable(struct page *page)
 {
@@ -1422,6 +1460,7 @@ fast_isolate_around(struct compact_control *cc, unsig=
ned long pfn)
 {
 	unsigned long start_pfn, end_pfn;
 	struct page *page;
+	LIST_HEAD(freelist);
=20
 	/* Do not search around if there are enough pages already */
 	if (cc->nr_freepages >=3D cc->nr_migratepages)
@@ -1439,7 +1478,8 @@ fast_isolate_around(struct compact_control *cc, unsig=
ned long pfn)
 	if (!page)
 		return;
=20
-	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false=
);
+	isolate_freepages_block(cc, &start_pfn, end_pfn, &freelist, 1, false);
+	sort_free_pages(&freelist, cc->freepages);
=20
 	/* Skip this pageblock in the future as it's full or nearly full */
 	if (start_pfn =3D=3D end_pfn && !cc->no_set_skip_hint)
@@ -1568,7 +1608,7 @@ static void fast_isolate_freepages(struct compact_con=
trol *cc)
 				nr_scanned +=3D nr_isolated - 1;
 				total_isolated +=3D nr_isolated;
 				cc->nr_freepages +=3D nr_isolated;
-				list_add_tail(&page->lru, &cc->freepages);
+				list_add_tail(&page->lru, &cc->freepages[order].pages);
 				count_compact_events(COMPACTISOLATED, nr_isolated);
 			} else {
 				/* If isolation fails, abort the search */
@@ -1642,13 +1682,13 @@ static void isolate_freepages(struct compact_contro=
l *cc)
 	unsigned long isolate_start_pfn; /* exact pfn we start at */
 	unsigned long block_end_pfn;	/* end of current pageblock */
 	unsigned long low_pfn;	     /* lowest pfn scanner is able to scan */
-	struct list_head *freelist =3D &cc->freepages;
 	unsigned int stride;
+	LIST_HEAD(freelist);
=20
 	/* Try a small search of the free lists for a candidate */
 	fast_isolate_freepages(cc);
 	if (cc->nr_freepages)
-		goto splitmap;
+		return;
=20
 	/*
 	 * Initialise the free scanner. The starting point is where we last
@@ -1708,7 +1748,8 @@ static void isolate_freepages(struct compact_control =
*cc)
=20
 		/* Found a block suitable for isolating free pages from. */
 		nr_isolated =3D isolate_freepages_block(cc, &isolate_start_pfn,
-					block_end_pfn, freelist, stride, false);
+					block_end_pfn, &freelist, stride, false);
+		sort_free_pages(&freelist, cc->freepages);
=20
 		/* Update the skip hint if the full pageblock was scanned */
 		if (isolate_start_pfn =3D=3D block_end_pfn)
@@ -1749,10 +1790,6 @@ static void isolate_freepages(struct compact_control=
 *cc)
 	 * and the loop terminated due to isolate_start_pfn < low_pfn
 	 */
 	cc->free_pfn =3D isolate_start_pfn;
-
-splitmap:
-	/* __isolate_free_page() does not map the pages */
-	split_map_pages(freelist);
 }
=20
 /*
@@ -1763,18 +1800,21 @@ static struct folio *compaction_alloc(struct folio =
*src, unsigned long data)
 {
 	struct compact_control *cc =3D (struct compact_control *)data;
 	struct folio *dst;
+	int order =3D folio_order(src);
=20
-	if (list_empty(&cc->freepages)) {
+	if (!cc->freepages[order].nr_free) {
 		isolate_freepages(cc);
-
-		if (list_empty(&cc->freepages))
+		if (!cc->freepages[order].nr_free)
 			return NULL;
 	}
=20
-	dst =3D list_entry(cc->freepages.next, struct folio, lru);
+	dst =3D list_first_entry(&cc->freepages[order].pages, struct folio, lru);
+	cc->freepages[order].nr_free--;
 	list_del(&dst->lru);
-	cc->nr_freepages--;
-
+	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
+	if (order)
+		prep_compound_page(&dst->page, order);
+	cc->nr_freepages -=3D 1 << order;
 	return dst;
 }
=20
@@ -1786,9 +1826,34 @@ static struct folio *compaction_alloc(struct folio *=
src, unsigned long data)
 static void compaction_free(struct folio *dst, unsigned long data)
 {
 	struct compact_control *cc =3D (struct compact_control *)data;
+	int order =3D folio_order(dst);
+	struct page *page =3D &dst->page;
=20
-	list_add(&dst->lru, &cc->freepages);
-	cc->nr_freepages++;
+	if (order) {
+		int i;
+
+		page[1].flags &=3D ~PAGE_FLAGS_SECOND;
+		for (i =3D 1; i < (1 << order); i++) {
+			page[i].mapping =3D NULL;
+			clear_compound_head(&page[i]);
+			page[i].flags &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
+		}
+
+	}
+	/* revert post_alloc_hook() operations */
+	page->mapping =3D NULL;
+	page->flags &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
+	set_page_count(page, 0);
+	page_mapcount_reset(page);
+	reset_page_owner(page, order);
+	page_table_check_free(page, order);
+	arch_free_page(page, order);
+	set_page_private(page, order);
+	INIT_LIST_HEAD(&dst->lru);
+
+	list_add(&dst->lru, &cc->freepages[order].pages);
+	cc->freepages[order].nr_free++;
+	cc->nr_freepages +=3D 1 << order;
 }
=20
 /* possible outcome of isolate_migratepages */
@@ -2412,6 +2477,7 @@ compact_zone(struct compact_control *cc, struct captu=
re_control *capc)
 	const bool sync =3D cc->mode !=3D MIGRATE_ASYNC;
 	bool update_cached;
 	unsigned int nr_succeeded =3D 0;
+	int order;
=20
 	/*
 	 * These counters track activities during zone compaction.  Initialize
@@ -2421,7 +2487,10 @@ compact_zone(struct compact_control *cc, struct capt=
ure_control *capc)
 	cc->total_free_scanned =3D 0;
 	cc->nr_migratepages =3D 0;
 	cc->nr_freepages =3D 0;
-	INIT_LIST_HEAD(&cc->freepages);
+	for (order =3D 0; order <=3D MAX_ORDER; order++) {
+		INIT_LIST_HEAD(&cc->freepages[order].pages);
+		cc->freepages[order].nr_free =3D 0;
+	}
 	INIT_LIST_HEAD(&cc->migratepages);
=20
 	cc->migratetype =3D gfp_migratetype(cc->gfp_mask);
@@ -2607,7 +2676,7 @@ compact_zone(struct compact_control *cc, struct captu=
re_control *capc)
 	 * so we don't leave any returned pages behind in the next attempt.
 	 */
 	if (cc->nr_freepages > 0) {
-		unsigned long free_pfn =3D release_freepages(&cc->freepages);
+		unsigned long free_pfn =3D release_free_list(cc->freepages);
=20
 		cc->nr_freepages =3D 0;
 		VM_BUG_ON(free_pfn =3D=3D 0);
@@ -2626,7 +2695,6 @@ compact_zone(struct compact_control *cc, struct captu=
re_control *capc)
=20
 	trace_mm_compaction_end(cc, start_pfn, end_pfn, sync, ret);
=20
-	VM_BUG_ON(!list_empty(&cc->freepages));
 	VM_BUG_ON(!list_empty(&cc->migratepages));
=20
 	return ret;
diff --git a/mm/internal.h b/mm/internal.h
index 8c90e966e9f8..f5c691bb5c1c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -465,6 +465,11 @@ int split_free_page(struct page *free_page,
 /*
  * in mm/compaction.c
  */
+
+struct free_list {
+	struct list_head	pages;
+	unsigned long		nr_free;
+};
 /*
  * compact_control is used to track pages being migrated and the free pages
  * they are being migrated to during memory compaction. The free_pfn starts
@@ -473,7 +478,7 @@ int split_free_page(struct page *free_page,
  * completes when free_pfn <=3D migrate_pfn
  */
 struct compact_control {
-	struct list_head freepages;	/* List of free pages to migrate to */
+	struct free_list freepages[MAX_ORDER + 1];	/* List of free pages to migra=
te to */
 	struct list_head migratepages;	/* List of pages being migrated */
 	unsigned int nr_freepages;	/* Number of isolated free pages */
 	unsigned int nr_migratepages;	/* Number of pages to migrate */
--=20
2.40.1

