Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEB47CC8E5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbjJQQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjJQQbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:31:43 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A766FA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:31:41 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C0EFA320097F;
        Tue, 17 Oct 2023 12:31:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 17 Oct 2023 12:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1697560297; x=1697646697; bh=0w
        vr21T8TH7ZbDsGZ1CdyvPwondpshaJK0kYT+cScfw=; b=3yJnaArN4SOYAmO1fp
        K+rmCwdS25C4YRLbYb0xacBS/armI4TMiZSw+anRkphttaPnf81i/MUhL4bTV55z
        ravLE/h5yQ4iGHaa9q+lHzdu2UTcYuwOa32+huyKdw2QNSGWNr8o8KqCwbnbQLxE
        WDZFZsAAqo+2HbVXG7gsU8kKCxbgtuz298uj2xt0bbycxccYD7NyZFOAsPRqDawn
        Z6HlnGXzLQSwHv7rPotAhmldY4xVBkO3EzXyUvtYzWJPHtl497Z9PatJ1yJ3nY3J
        ubAJCG0ZFs1uHMiVak5L3GNe/sxDWg7xocktRhJJFZvNRUJHnUpSEAJ7q69xnCDx
        6xyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1697560297; x=1697646697; bh=0
        wvr21T8TH7ZbDsGZ1CdyvPwondpshaJK0kYT+cScfw=; b=unfNfFs2TOOscLvAF
        rtISXudCcuRuLCPnvkyTpJifO7QIISSb3fmEx9IHVybsZWcTf+QCy1nfKYraT5uP
        5sY0vQQytBofwThnmDC1UHIE2JCAHDIh1zxN6bWP9zwDhlqHEN/mwy+gSfyeYPM1
        zUEyKLpE7axpayZRP8cwKcUauSPCm/XR9NGvmH3E45hoZ3k1IK8ecXr+oRN18A0d
        Ia+cr/9I8OcTqW/pdRNBS7pwUihug/MyG94NZLIeW774ls2gIH92rUi9LKZNqy9Q
        0u4rqE+jFZKvLndXMnAUGVNHe/+14vPmt3jOBh8OFrCsnoBBFgFBkDx3cFa8q1bd
        kId/A==
X-ME-Sender: <xms:6LYuZQ3siAtrjT1HRccNInh1nf6mKCpdaFgP9fvBNHpbuc7UkSo1Iw>
    <xme:6LYuZbFLUheGIJ4O_yMXiGp2m39eJ4XBr7oCPgU753n2uFXvCZCby2ZMzMvg2Y4CF
    yrZ1xJ1-dIndeTMvQ>
X-ME-Received: <xmr:6LYuZY6Ylxqnd1MJhA99H1wVVnM7Nq9svGSzCyFf11nWSPj73OvuQUO5TH7fOj2Fzbn9_9bjl7R-gENv2-9MfYFm1hIFM24YfPSTXhh_W7ryNqFfYxM6RZG2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhgggfestdekredtredttdenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepffejueeife
    ejudejudfgiedtfeeltdfgueffhfdulefgtdekteekfeejheekhedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvghnth
    drtghomh
X-ME-Proxy: <xmx:6LYuZZ30ZpHAAdwgs6MKfWUFEp8cvsvOvTuniYm8BxMmRY-86q_fgg>
    <xmx:6LYuZTH5mktC-ibKy63JQiZA_rwg1ZvyRfY3jt7gaf4JjrRBHm5ojg>
    <xmx:6LYuZS-88CSgNSE4n83rGyCEHY27Wf9hdmC9lOTW7NQGmK7Q95-qWQ>
    <xmx:6bYuZY5u7YA6teCmWaFm1xu-uZJ7X6KKm9vh1mQCG-zyClFuOTkkmg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 12:31:36 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH v3 1/2] mm/migrate: correct nr_failed in migrate_pages_sync()
Date:   Tue, 17 Oct 2023 12:31:28 -0400
Message-ID: <20231017163129.2025214-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.42.0
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

nr_failed was missing the large folio splits from migrate_pages_batch()
and can cause a mismatch between migrate_pages() return value and the
number of not migrated pages, i.e., when the return value of
migrate_pages() is 0, there are still pages left in the from page list.
It will happen when a non-PMD THP large folio fails to migrate due to
-ENOMEM and is split successfully but not all the split pages are not
migrated, migrate_pages_batch() would return non-zero, but
astats.nr_thp_split = 0. nr_failed would be 0 and returned to the caller
of migrate_pages(), but the not migrated pages are left in the from page
list without being added back to LRU lists.

Fix it by adding a new nr_split counter for large folio splits and adding
it to nr_failed in migrate_page_sync() after migrate_pages_batch() is
done.

Fixes: 2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronously firstly")
Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/migrate.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c602bf6dec97..fc2e70b17704 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1495,6 +1495,7 @@ struct migrate_pages_stats {
 	int nr_thp_succeeded;	/* THP migrated successfully */
 	int nr_thp_failed;	/* THP failed to be migrated */
 	int nr_thp_split;	/* THP split before migrating */
+	int nr_split;	/* Large folio (include THP) split before migrating */
 };
 
 /*
@@ -1614,6 +1615,7 @@ static int migrate_pages_batch(struct list_head *from,
 	int nr_retry_pages = 0;
 	int pass = 0;
 	bool is_thp = false;
+	bool is_large = false;
 	struct folio *folio, *folio2, *dst = NULL, *dst2;
 	int rc, rc_saved = 0, nr_pages;
 	LIST_HEAD(unmap_folios);
@@ -1629,7 +1631,8 @@ static int migrate_pages_batch(struct list_head *from,
 		nr_retry_pages = 0;
 
 		list_for_each_entry_safe(folio, folio2, from, lru) {
-			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
+			is_large = folio_test_large(folio);
+			is_thp = is_large && folio_test_pmd_mappable(folio);
 			nr_pages = folio_nr_pages(folio);
 
 			cond_resched();
@@ -1649,6 +1652,7 @@ static int migrate_pages_batch(struct list_head *from,
 				stats->nr_thp_failed++;
 				if (!try_split_folio(folio, split_folios)) {
 					stats->nr_thp_split++;
+					stats->nr_split++;
 					continue;
 				}
 				stats->nr_failed_pages += nr_pages;
@@ -1677,11 +1681,12 @@ static int migrate_pages_batch(struct list_head *from,
 				nr_failed++;
 				stats->nr_thp_failed += is_thp;
 				/* Large folio NUMA faulting doesn't split to retry. */
-				if (folio_test_large(folio) && !nosplit) {
+				if (is_large && !nosplit) {
 					int ret = try_split_folio(folio, split_folios);
 
 					if (!ret) {
 						stats->nr_thp_split += is_thp;
+						stats->nr_split += is_large;
 						break;
 					} else if (reason == MR_LONGTERM_PIN &&
 						   ret == -EAGAIN) {
@@ -1827,6 +1832,7 @@ static int migrate_pages_sync(struct list_head *from, new_folio_t get_new_folio,
 	stats->nr_succeeded += astats.nr_succeeded;
 	stats->nr_thp_succeeded += astats.nr_thp_succeeded;
 	stats->nr_thp_split += astats.nr_thp_split;
+	stats->nr_split += astats.nr_split;
 	if (rc < 0) {
 		stats->nr_failed_pages += astats.nr_failed_pages;
 		stats->nr_thp_failed += astats.nr_thp_failed;
@@ -1834,7 +1840,11 @@ static int migrate_pages_sync(struct list_head *from, new_folio_t get_new_folio,
 		return rc;
 	}
 	stats->nr_thp_failed += astats.nr_thp_split;
-	nr_failed += astats.nr_thp_split;
+	/*
+	 * Do not count rc, as pages will be retried below.
+	 * Count nr_split only, since it includes nr_thp_split.
+	 */
+	nr_failed += astats.nr_split;
 	/*
 	 * Fall back to migrate all failed folios one by one synchronously. All
 	 * failed folios except split THPs will be retried, so their failure
-- 
2.42.0

