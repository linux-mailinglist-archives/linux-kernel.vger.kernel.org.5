Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E877EA19A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjKMRC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjKMRCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:02:25 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47135D5E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:02:21 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AF85C5C01CA;
        Mon, 13 Nov 2023 12:02:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 13 Nov 2023 12:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to; s=
        fm3; t=1699894940; x=1699981340; bh=yXmXVOGVZ9680hBEB/GXlWgTDZKy
        cYZ6tcV4N4qWe34=; b=6vZ8QSc5QsL+6Ml1Z9LRB0cZF70TtpXwf0wyPq0Vvt36
        vEKafKHGGxfNnO5VceD8pNj/FAwzvZZqm6QmaRS6E+VjbCMzODG7DZyvEj+746fp
        v7mbvCfnX73MXHwG/gfU1uJ4c4jR7eFswj9UuxhdTdV657W5gaOWSni6KXMmJXR0
        uWklL13+NBaLhfKZnXXS3d+m4IYS5Se2IbX/2IfxlA1ORTA1/3Pxo8HoqJChEQvh
        ihYpzv0BWbk1SUTCfz40WtaNteTyaFLRHygdQAMxe5pXoDkV5F9h38jmpE4wZn7c
        Ws0N2doWqP8MoV3+9nau3c+u/msF8ghl7gUShR4Piw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1699894940; x=1699981340; bh=yXmXVOGVZ9680hBEB/GXlWgTDZKy
        cYZ6tcV4N4qWe34=; b=c4J28ZKitV8uAiFK6mlaD3Ie8/ukVuhMfqrVrig4P1nV
        +2b06RMcbpVGKQO+RIwvJZhc3QlcnlussY5xmK4gzfbns64/sOnEYm/EK0oWQw+u
        z+YuWFLqs+L+WXoPqmmTWK5FJxjd2WWaFrHNibVK+ow/TSrb6zhCazOyvH+WtRQ0
        bdHY3m/1KteYv5CXZoDuyFBpnwJks05HvG/mosADk5lgh3ITxWRW8HmlYlPacoog
        HpLiI5rCRSkeqQm9VyIS753xeyNtzee3qwEY9GoSJFcXJ5AhJBfYHwnCs2e8Nymf
        jsm575obZbfzng0EFN/aH2WMWGD/g7uQPAHaygMGxA==
X-ME-Sender: <xms:mlZSZZ-8zBi47NMvcEis2g1aWFZ8vpai1EGx97wsW9Es_Xh3gs9KbQ>
    <xme:mlZSZdtFLY1JIKRbvl0eNfn-2axQRaT4KbPZZdza1KkukUnypGc81sWwEjWtd-tcl
    Z9m4SSiBrrAghm-pw>
X-ME-Received: <xmr:mlZSZXDYTRB7T0lg0bQVPwNqjmnPcuAxy9B4aVmvmBWDFxMsixiOlwfX-wHrphcWGsqQWJR6llWo_HnyxkcHCZ9nK6M2YsM2UH5qwou8c7V-a4PhWdnjp4W7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeftddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:m1ZSZdczvc35IT__HPyx37FyS7OQ-k_dW8uvrT0YmqDD2D2H6XpqSQ>
    <xmx:m1ZSZeMAmg46quGe5iTQXuVqLWPyv4PqGotVt9rYtrqxJHTEgpe0AA>
    <xmx:m1ZSZfnuiMBZLQYZXFSlZSJoe1aK1cAPd3iPwcY4aFId2kh_Mj9N_A>
    <xmx:nFZSZZFwb_C7Ps2hCUVilmOV0srM4hPW1KGAYvE_rA2u0Ff5R23LuQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Nov 2023 12:02:18 -0500 (EST)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v1 2/4] mm/compaction: add support for >0 order folio memory compaction.
Date:   Mon, 13 Nov 2023 12:01:55 -0500
Message-ID: <20231113170157.280181-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231113170157.280181-1-zi.yan@sent.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 mm/compaction.c | 160 ++++++++++++++++++++++++++++++------------------
 mm/internal.h   |   7 ++-
 2 files changed, 108 insertions(+), 59 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 5217dd35b493..ec6b5cc7e907 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -66,45 +66,64 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
 #define COMPACTION_HPAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
 #endif
 
-static unsigned long release_freepages(struct list_head *freelist)
+static void init_page_list(struct page_list *p)
 {
-	struct page *page, *next;
-	unsigned long high_pfn = 0;
-
-	list_for_each_entry_safe(page, next, freelist, lru) {
-		unsigned long pfn = page_to_pfn(page);
-		list_del(&page->lru);
-		__free_page(page);
-		if (pfn > high_pfn)
-			high_pfn = pfn;
-	}
-
-	return high_pfn;
+	INIT_LIST_HEAD(&p->pages);
+	p->nr_pages = 0;
 }
 
-static void split_map_pages(struct list_head *list)
+static void split_map_pages(struct page_list *freepages)
 {
 	unsigned int i, order, nr_pages;
 	struct page *page, *next;
 	LIST_HEAD(tmp_list);
 
-	list_for_each_entry_safe(page, next, list, lru) {
-		list_del(&page->lru);
+	for (order = 0; order <= MAX_ORDER; order++) {
+		freepages[order].nr_pages = 0;
+
+		list_for_each_entry_safe(page, next, &freepages[order].pages, lru) {
+			list_del(&page->lru);
 
-		order = page_private(page);
-		nr_pages = 1 << order;
+			nr_pages = 1 << order;
 
-		post_alloc_hook(page, order, __GFP_MOVABLE);
-		if (order)
-			split_page(page, order);
+			post_alloc_hook(page, order, __GFP_MOVABLE);
+			if (order)
+				split_page(page, order);
 
-		for (i = 0; i < nr_pages; i++) {
-			list_add(&page->lru, &tmp_list);
-			page++;
+			for (i = 0; i < nr_pages; i++) {
+				list_add(&page->lru, &tmp_list);
+				page++;
+			}
+			freepages[order].nr_pages += nr_pages;
 		}
+		list_splice(&tmp_list, &freepages[order].pages);
 	}
+}
 
-	list_splice(&tmp_list, list);
+static unsigned long release_free_list(struct page_list *freepages)
+{
+	int order;
+	unsigned long high_pfn = 0;
+
+	for (order = 0; order <= MAX_ORDER; order++) {
+		struct page *page, *next;
+
+		list_for_each_entry_safe(page, next, &freepages[order].pages, lru) {
+			unsigned long pfn = page_to_pfn(page);
+
+			list_del(&page->lru);
+			/*
+			 * Convert free pages into post allocation pages, so
+			 * that we can free them via __free_page.
+			 */
+			post_alloc_hook(page, order, __GFP_MOVABLE);
+			__free_pages(page, order);
+			if (pfn > high_pfn)
+				high_pfn = pfn;
+		}
+		freepages[order].nr_pages = 0;
+	}
+	return high_pfn;
 }
 
 #ifdef CONFIG_COMPACTION
@@ -583,7 +602,7 @@ static bool compact_unlock_should_abort(spinlock_t *lock,
 static unsigned long isolate_freepages_block(struct compact_control *cc,
 				unsigned long *start_pfn,
 				unsigned long end_pfn,
-				struct list_head *freelist,
+				struct page_list *freelist,
 				unsigned int stride,
 				bool strict)
 {
@@ -657,7 +676,8 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 		nr_scanned += isolated - 1;
 		total_isolated += isolated;
 		cc->nr_freepages += isolated;
-		list_add_tail(&page->lru, freelist);
+		list_add_tail(&page->lru, &freelist[order].pages);
+		freelist[order].nr_pages++;
 
 		if (!strict && cc->nr_migratepages <= cc->nr_freepages) {
 			blockpfn += isolated;
@@ -722,7 +742,11 @@ isolate_freepages_range(struct compact_control *cc,
 			unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long isolated, pfn, block_start_pfn, block_end_pfn;
-	LIST_HEAD(freelist);
+	int order;
+	struct page_list tmp_freepages[MAX_ORDER + 1];
+
+	for (order = 0; order <= MAX_ORDER; order++)
+		init_page_list(&tmp_freepages[order]);
 
 	pfn = start_pfn;
 	block_start_pfn = pageblock_start_pfn(pfn);
@@ -753,7 +777,7 @@ isolate_freepages_range(struct compact_control *cc,
 			break;
 
 		isolated = isolate_freepages_block(cc, &isolate_start_pfn,
-					block_end_pfn, &freelist, 0, true);
+					block_end_pfn, tmp_freepages, 0, true);
 
 		/*
 		 * In strict mode, isolate_freepages_block() returns 0 if
@@ -770,15 +794,15 @@ isolate_freepages_range(struct compact_control *cc,
 		 */
 	}
 
-	/* __isolate_free_page() does not map the pages */
-	split_map_pages(&freelist);
-
 	if (pfn < end_pfn) {
 		/* Loop terminated early, cleanup. */
-		release_freepages(&freelist);
+		release_free_list(tmp_freepages);
 		return 0;
 	}
 
+	/* __isolate_free_page() does not map the pages */
+	split_map_pages(tmp_freepages);
+
 	/* We don't use freelists for anything. */
 	return pfn;
 }
@@ -1462,7 +1486,7 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
 	if (!page)
 		return;
 
-	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1, false);
+	isolate_freepages_block(cc, &start_pfn, end_pfn, cc->freepages, 1, false);
 
 	/* Skip this pageblock in the future as it's full or nearly full */
 	if (start_pfn == end_pfn && !cc->no_set_skip_hint)
@@ -1591,7 +1615,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 				nr_scanned += nr_isolated - 1;
 				total_isolated += nr_isolated;
 				cc->nr_freepages += nr_isolated;
-				list_add_tail(&page->lru, &cc->freepages);
+				list_add_tail(&page->lru, &cc->freepages[order].pages);
 				count_compact_events(COMPACTISOLATED, nr_isolated);
 			} else {
 				/* If isolation fails, abort the search */
@@ -1665,13 +1689,12 @@ static void isolate_freepages(struct compact_control *cc)
 	unsigned long isolate_start_pfn; /* exact pfn we start at */
 	unsigned long block_end_pfn;	/* end of current pageblock */
 	unsigned long low_pfn;	     /* lowest pfn scanner is able to scan */
-	struct list_head *freelist = &cc->freepages;
 	unsigned int stride;
 
 	/* Try a small search of the free lists for a candidate */
 	fast_isolate_freepages(cc);
 	if (cc->nr_freepages)
-		goto splitmap;
+		return;
 
 	/*
 	 * Initialise the free scanner. The starting point is where we last
@@ -1731,7 +1754,7 @@ static void isolate_freepages(struct compact_control *cc)
 
 		/* Found a block suitable for isolating free pages from. */
 		nr_isolated = isolate_freepages_block(cc, &isolate_start_pfn,
-					block_end_pfn, freelist, stride, false);
+					block_end_pfn, cc->freepages, stride, false);
 
 		/* Update the skip hint if the full pageblock was scanned */
 		if (isolate_start_pfn == block_end_pfn)
@@ -1772,10 +1795,6 @@ static void isolate_freepages(struct compact_control *cc)
 	 * and the loop terminated due to isolate_start_pfn < low_pfn
 	 */
 	cc->free_pfn = isolate_start_pfn;
-
-splitmap:
-	/* __isolate_free_page() does not map the pages */
-	split_map_pages(freelist);
 }
 
 /*
@@ -1786,23 +1805,22 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 {
 	struct compact_control *cc = (struct compact_control *)data;
 	struct folio *dst;
+	int order = folio_order(src);
 
-	/* this makes migrate_pages() split the source page and retry */
-	if (folio_order(src) > 0)
-		return NULL;
-
-	if (list_empty(&cc->freepages)) {
+	if (!cc->freepages[order].nr_pages) {
 		isolate_freepages(cc);
-
-		if (list_empty(&cc->freepages))
+		if (!cc->freepages[order].nr_pages)
 			return NULL;
 	}
 
-	dst = list_entry(cc->freepages.next, struct folio, lru);
+	dst = list_first_entry(&cc->freepages[order].pages, struct folio, lru);
+	cc->freepages[order].nr_pages--;
 	list_del(&dst->lru);
-	cc->nr_freepages--;
-
-	return dst;
+	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
+	if (order)
+		prep_compound_page(&dst->page, order);
+	cc->nr_freepages -= 1 << order;
+	return page_rmappable_folio(&dst->page);
 }
 
 /*
@@ -1813,9 +1831,34 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 static void compaction_free(struct folio *dst, unsigned long data)
 {
 	struct compact_control *cc = (struct compact_control *)data;
+	int order = folio_order(dst);
+	struct page *page = &dst->page;
+
+	if (order) {
+		int i;
 
-	list_add(&dst->lru, &cc->freepages);
-	cc->nr_freepages++;
+		page[1].flags &= ~PAGE_FLAGS_SECOND;
+		for (i = 1; i < (1 << order); i++) {
+			page[i].mapping = NULL;
+			clear_compound_head(&page[i]);
+			page[i].flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+		}
+
+	}
+	/* revert post_alloc_hook() operations */
+	page->mapping = NULL;
+	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	set_page_count(page, 0);
+	page_mapcount_reset(page);
+	reset_page_owner(page, order);
+	page_table_check_free(page, order);
+	arch_free_page(page, order);
+	set_page_private(page, order);
+	INIT_LIST_HEAD(&dst->lru);
+
+	list_add(&dst->lru, &cc->freepages[order].pages);
+	cc->freepages[order].nr_pages++;
+	cc->nr_freepages += 1 << order;
 }
 
 /* possible outcome of isolate_migratepages */
@@ -2439,6 +2482,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	const bool sync = cc->mode != MIGRATE_ASYNC;
 	bool update_cached;
 	unsigned int nr_succeeded = 0;
+	int order;
 
 	/*
 	 * These counters track activities during zone compaction.  Initialize
@@ -2448,7 +2492,8 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	cc->total_free_scanned = 0;
 	cc->nr_migratepages = 0;
 	cc->nr_freepages = 0;
-	INIT_LIST_HEAD(&cc->freepages);
+	for (order = 0; order <= MAX_ORDER; order++)
+		init_page_list(&cc->freepages[order]);
 	INIT_LIST_HEAD(&cc->migratepages);
 
 	cc->migratetype = gfp_migratetype(cc->gfp_mask);
@@ -2634,7 +2679,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	 * so we don't leave any returned pages behind in the next attempt.
 	 */
 	if (cc->nr_freepages > 0) {
-		unsigned long free_pfn = release_freepages(&cc->freepages);
+		unsigned long free_pfn = release_free_list(cc->freepages);
 
 		cc->nr_freepages = 0;
 		VM_BUG_ON(free_pfn == 0);
@@ -2653,7 +2698,6 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	trace_mm_compaction_end(cc, start_pfn, end_pfn, sync, ret);
 
-	VM_BUG_ON(!list_empty(&cc->freepages));
 	VM_BUG_ON(!list_empty(&cc->migratepages));
 
 	return ret;
diff --git a/mm/internal.h b/mm/internal.h
index 8450562744cf..46c8bb94ecbb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -473,6 +473,11 @@ int split_free_page(struct page *free_page,
 /*
  * in mm/compaction.c
  */
+
+struct page_list {
+	struct list_head	pages;
+	unsigned long		nr_pages;
+};
 /*
  * compact_control is used to track pages being migrated and the free pages
  * they are being migrated to during memory compaction. The free_pfn starts
@@ -481,7 +486,7 @@ int split_free_page(struct page *free_page,
  * completes when free_pfn <= migrate_pfn
  */
 struct compact_control {
-	struct list_head freepages;	/* List of free pages to migrate to */
+	struct page_list freepages[MAX_ORDER + 1];	/* List of free pages to migrate to */
 	struct list_head migratepages;	/* List of pages being migrated */
 	unsigned int nr_freepages;	/* Number of isolated free pages */
 	unsigned int nr_migratepages;	/* Number of pages to migrate */
-- 
2.42.0

