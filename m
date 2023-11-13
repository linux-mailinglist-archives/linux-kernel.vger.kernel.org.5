Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D627EA199
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjKMRC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMRCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:02:22 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88833D63
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 09:02:18 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 010A05C01B7;
        Mon, 13 Nov 2023 12:02:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 13 Nov 2023 12:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to; s=
        fm3; t=1699894937; x=1699981337; bh=urfl5JZUWyqykmUphyjWYkdFE+ba
        fcBTkV8p8IuqwbA=; b=7HB3Wyi+1gRLdhpQriK/kyewm4aYNjtRZ2nu3IH7+wuu
        2vsuB2HaPHYBy0ZZNHffjdKm+Sly7mnILjLxEcbrEPUIyF+rOoVwGNzTna0apkfD
        +EW9ORilVpQXmX2xDBPplisCDSM6hxnR/ESebHQJ6wGq7s6Wfa16M452P3I/ZqxV
        44GnQKHspiQ8jZvk0d9h1oQ26cWjEqJ05V+obJDPgAoah0aDRtom2EVauTJ3i+HK
        4JGcZ2r5vJF5Sjh/u2MK74H/Oun9AVv642CvBvYM0DwxwydVFu79uudd6FMdYddk
        dssWmmhtQpq619UGwR9+6re/dTW1KB+yuYUH6GFVMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1699894937; x=1699981337; bh=urfl5JZUWyqykmUphyjWYkdFE+ba
        fcBTkV8p8IuqwbA=; b=TPd9+CccOdaGln4m8Tv8Duuxgf3e4Y8CQUAu137jPias
        LNS4P77nwQiCkh+2T11QwQgTHwXDMnrq1QN5d4NfoFs5pfxymEeMCH8LoxstLNNI
        mQF0karJJx7sg01u/LW5NDMXRTFVlSLOSMY7Oi7lrQWPOkSK3h5Duf34/2SI67TG
        W50qOEvqFUkbhtEHm+DxZJj/xueyu647kqMFBk0eqyYuq81C9B0skpBnBf0+5HIv
        dnk7GRsJ9KdEsJTihPFSZ3s8sd6ixsQOzQUVrsLJ6zWqPlnzz2EgvdrtMfSeKRH/
        QpipWEiZpRAoigZs0yBHRGyaNzrsvlUA3k7VQQ5G5g==
X-ME-Sender: <xms:mFZSZUXRPw94915iFnyGV86pA12aODb-ZC_mXUoFmX0ZyDUKJkeG4w>
    <xme:mFZSZYk0wt38ZFtonX7Kn-kH0AfxlG9CdHhJ7fWoElbKmX91qJIbSrf3rAQHffqq0
    r1QqoahyobE85GPDw>
X-ME-Received: <xmr:mFZSZYbMjxo3DM_CCrl41nvbu9s1nKYicFzOATweZadGvPm0I3KZEdRYzbT7QkHHAVYBrdFhZNPO6988I1qE9jQx0EGRW3LW6UQ7XKCgWlc7j4MPD1bYRI7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeftddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:mFZSZTXlZYXEP8eWD7M5LnlA7F0hAzUqg6TOEdz6ipe_a4j9fcfxbw>
    <xmx:mFZSZen5b9e83ci6BH4jEFwDRzO-F4ZlpVKN-IEYiEG2cfibSj27Ag>
    <xmx:mFZSZYda50bz-NApEG0XiDr-sjO08K97VeijHoLkP9TtsDuOheaaaw>
    <xmx:mVZSZdfBYSpbmvTLCmQOkkon1bFrhDxRfJZd-xgMg28wnmDQflqJbQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Nov 2023 12:02:15 -0500 (EST)
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
Subject: [PATCH v1 1/4] mm/compaction: enable compacting >0 order folios.
Date:   Mon, 13 Nov 2023 12:01:54 -0500
Message-ID: <20231113170157.280181-2-zi.yan@sent.com>
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

migrate_pages() supports >0 order folio migration and during compaction,
even if compaction_alloc() cannot provide >0 order free pages,
migrate_pages() can split the source page and try to migrate the base pages
from the split. It can be a baseline and start point for adding support for
compacting >0 order folios.

Suggested-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/compaction.c | 57 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 15 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 01ba298739dd..5217dd35b493 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -816,6 +816,21 @@ static bool too_many_isolated(struct compact_control *cc)
 	return too_many;
 }
 
+/*
+ * 1. if the page order is larger than or equal to target_order (i.e.,
+ * cc->order and when it is not -1 for global compaction), skip it since
+ * target_order already indicates no free page with larger than target_order
+ * exists and later migrating it will most likely fail;
+ *
+ * 2. compacting > pageblock_order pages does not improve memory fragmentation,
+ * skip them;
+ */
+static bool skip_isolation_on_order(int order, int target_order)
+{
+	return (target_order != -1 && order >= target_order) ||
+		order >= pageblock_order;
+}
+
 /**
  * isolate_migratepages_block() - isolate all migrate-able pages within
  *				  a single pageblock
@@ -1009,7 +1024,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		/*
 		 * Regardless of being on LRU, compound pages such as THP and
 		 * hugetlbfs are not to be compacted unless we are attempting
-		 * an allocation much larger than the huge page size (eg CMA).
+		 * an allocation larger than the compound page size.
 		 * We can potentially save a lot of iterations if we skip them
 		 * at once. The check is racy, but we can consider only valid
 		 * values and the only danger is skipping too much.
@@ -1017,11 +1032,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		if (PageCompound(page) && !cc->alloc_contig) {
 			const unsigned int order = compound_order(page);
 
-			if (likely(order <= MAX_ORDER)) {
-				low_pfn += (1UL << order) - 1;
-				nr_scanned += (1UL << order) - 1;
+			/*
+			 * Skip based on page order and compaction target order
+			 * and skip hugetlbfs pages.
+			 */
+			if (skip_isolation_on_order(order, cc->order) ||
+			    PageHuge(page)) {
+				if (order <= MAX_ORDER) {
+					low_pfn += (1UL << order) - 1;
+					nr_scanned += (1UL << order) - 1;
+				}
+				goto isolate_fail;
 			}
-			goto isolate_fail;
 		}
 
 		/*
@@ -1144,17 +1166,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 					goto isolate_abort;
 				}
 			}
+		}
 
-			/*
-			 * folio become large since the non-locked check,
-			 * and it's on LRU.
-			 */
-			if (unlikely(folio_test_large(folio) && !cc->alloc_contig)) {
-				low_pfn += folio_nr_pages(folio) - 1;
-				nr_scanned += folio_nr_pages(folio) - 1;
-				folio_set_lru(folio);
-				goto isolate_fail_put;
-			}
+		/*
+		 * Check LRU folio order under the lock
+		 */
+		if (unlikely(skip_isolation_on_order(folio_order(folio),
+						     cc->order) &&
+			     !cc->alloc_contig)) {
+			low_pfn += folio_nr_pages(folio) - 1;
+			nr_scanned += folio_nr_pages(folio) - 1;
+			folio_set_lru(folio);
+			goto isolate_fail_put;
 		}
 
 		/* The folio is taken off the LRU */
@@ -1764,6 +1787,10 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	struct compact_control *cc = (struct compact_control *)data;
 	struct folio *dst;
 
+	/* this makes migrate_pages() split the source page and retry */
+	if (folio_order(src) > 0)
+		return NULL;
+
 	if (list_empty(&cc->freepages)) {
 		isolate_freepages(cc);
 
-- 
2.42.0

