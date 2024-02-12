Return-Path: <linux-kernel+bounces-61992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0070B8519B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C141F23215
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47EA3D55F;
	Mon, 12 Feb 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="jtwatxbu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="afPdzl/w"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE1A3C492
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755718; cv=none; b=lEJJlPjXOMUICxIG9X9v3qrqsL6sO+s/p0bxjtZNKJYYlu88FgEHsStZzDKxSAQ81qYDGWbb3aqb9EDF5zoywsOWimhEYFh5Qu+QRGjtNDKfbrPvGCve38qJai/JCT9ji+vc3dp5YVtmTDawhbRyfP/qF/99Wd0XTZ9v8LK9FCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755718; c=relaxed/simple;
	bh=o/IDLf2oi6Qg1XbajGAPqAz3LKu3uXkBFzT7K7Hz3AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkj8z2+FYdIOpGPanwaXkjizJ7CiF9m8iW2404U7HiLGzqe2pHCMRUeNFM0qG/VUqk2c5IgltJympt/31fdVVGo3BL+NuEO6m/DVcFxHMlFWOM7ettAspOZHaTmqdaH8MgrsB69cuY6yjllDpG+K+bFMyyOuJIL9Ddp8v4v11Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=jtwatxbu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=afPdzl/w; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id B4EA05C0045;
	Mon, 12 Feb 2024 11:35:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 12 Feb 2024 11:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1707755715; x=1707842115; bh=olLqROIyqpY7Zf7udKwLJkzhBkxMJLzel8K
	572FqHrM=; b=jtwatxbu2FB6nKWyP/fincfHoJzs3A/lOqghTUCfK8J2wIPfn+T
	S7tgChnPEhCuIkTn2XGVynpfbrJbYfBthSX3ykoAKK9oXEIo/prqFZGwwIhjWTlQ
	DNiAK3a0QGpNnqYGofiADYaL3e5cw+rodaym6RLoCPDr063CCHWZwZDr5H0fYNnD
	kusC71OYg4vy8Qrx1Se+t2B1iGG0flCQFRyIsYt09qIRN+QvCsociw3VhV56xRxg
	GCatDpdKRwRmBvL4po67ti8E7H2pNkbA8w5j0No/3nLzsDIrIPlxJw16dwwZ9b6u
	7ayARCU+f14z6UEhgOqCrpd+9K11KKT3mog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1707755715; x=1707842115; bh=olLqROIyqpY7Zf7udKwLJkzhBkxMJLzel8K
	572FqHrM=; b=afPdzl/wbipcN9f++f1MwyUl2kN36DxNta5xjrdSb8dXrEsRFAo
	xo7OsCUgZeEhSpFbdtqCThXFVasVrxVTPPTEx2p6O1aYzM/hMXiyN6491K7ZZCNi
	O/qQnBk4YAOq3mPhYbIxNHgdfDYpVbbW0P7zBkY7gG2wrZ/jqzq18M6zGSJ87ydy
	LyBeVGF4OgDRheJ0g/q9ctcTHU9XVehqXAAeHd7xiR6mYjGSfW89E5oJsqxIdtqH
	6JD0gjjd0i1ONje2fLCfvuepRer/QnfmRNK2WzGLjKkQVckZFpU+t4Qw/G3FKwos
	3m5emENiTgMzi8qVjue2V0gKwyyKdS30I2A==
X-ME-Sender: <xms:w0jKZRpSB6dnkEKdDUnkLB33ZL1QDjZViNk712vOEOpUI5_sjxqtOQ>
    <xme:w0jKZTptzzWUoxcyGjbJMG7pFk6izhRrmrKHlmS_INQixwk37Ket1Kc-TxsRLHS6n
    axEXKWQZUawnsXFaA>
X-ME-Received: <xmr:w0jKZeP1SzrTgDgYcMosl4vjxQrR_sbJx6bxDM2k5D8d_gvSKSXO-EPzbpANubUbN-0gJSSbUruW9_7F79IemY5vzaS-511pHsJduXdssZwFN3PBJYQ3OVbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeejke
    etkeffleelkeduffdtfedvtdejjeeutdeutdetgeejgfevtdefudejkeeiveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:w0jKZc4Pad2PzK3KhwueX6eSQAv-AyYZakhxTiZiFA5VxpuOq2-MPA>
    <xmx:w0jKZQ6TGhzf57PoA4WqFe22mBDsqv59e1X0L6Hm7DGGpZ9-ZqROMg>
    <xmx:w0jKZUjNPQ0_w93fDfE6DaXSJ06UlqxaJDIPqRoh2oSbjS7Fc4PTJQ>
    <xmx:w0jKZdw1urYr7E5TADLKYp99Gaj07VU7JJvsWnnAACLMZvhaWlsIQQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 11:35:14 -0500 (EST)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	Yu Zhao <yuzhao@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rohan Puri <rohan.puri15@gmail.com>,
	Mcgrof Chamberlain <mcgrof@kernel.org>,
	Adam Manzanares <a.manzanares@samsung.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 1/3] mm/compaction: enable compacting >0 order folios.
Date: Mon, 12 Feb 2024 11:35:08 -0500
Message-ID: <20240212163510.859822-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212163510.859822-1-zi.yan@sent.com>
References: <20240212163510.859822-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

migrate_pages() supports >0 order folio migration and during compaction,
even if compaction_alloc() cannot provide >0 order free pages,
migrate_pages() can split the source page and try to migrate the base
pages from the split.  It can be a baseline and start point for adding
support for compacting >0 order folios.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Suggested-by: Huang Ying <ying.huang@intel.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Adam Manzanares <a.manzanares@samsung.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yin Fengwei <fengwei.yin@intel.com>
Cc: Yu Zhao <yuzhao@google.com>
---
 mm/compaction.c | 66 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index cc801ce099b4..aa6aad805c4d 100644
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
@@ -947,7 +962,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			valid_page = page;
 		}
 
-		if (PageHuge(page) && cc->alloc_contig) {
+		if (PageHuge(page)) {
+			/*
+			 * skip hugetlbfs if we are not compacting for pages
+			 * bigger than its order. THPs and other compound pages
+			 * are handled below.
+			 */
+			if (!cc->alloc_contig) {
+				const unsigned int order = compound_order(page);
+
+				if (order <= MAX_PAGE_ORDER) {
+					low_pfn += (1UL << order) - 1;
+					nr_scanned += (1UL << order) - 1;
+				}
+				goto isolate_fail;
+			}
+			/* for alloc_contig case */
 			if (locked) {
 				unlock_page_lruvec_irqrestore(locked, flags);
 				locked = NULL;
@@ -1008,21 +1038,24 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		}
 
 		/*
-		 * Regardless of being on LRU, compound pages such as THP and
-		 * hugetlbfs are not to be compacted unless we are attempting
-		 * an allocation much larger than the huge page size (eg CMA).
-		 * We can potentially save a lot of iterations if we skip them
-		 * at once. The check is racy, but we can consider only valid
-		 * values and the only danger is skipping too much.
+		 * Regardless of being on LRU, compound pages such as THP
+		 * (hugetlbfs is handled above) are not to be compacted unless
+		 * we are attempting an allocation larger than the compound
+		 * page size. We can potentially save a lot of iterations if we
+		 * skip them at once. The check is racy, but we can consider
+		 * only valid values and the only danger is skipping too much.
 		 */
 		if (PageCompound(page) && !cc->alloc_contig) {
 			const unsigned int order = compound_order(page);
 
-			if (likely(order <= MAX_PAGE_ORDER)) {
-				low_pfn += (1UL << order) - 1;
-				nr_scanned += (1UL << order) - 1;
+			/* Skip based on page order and compaction target order. */
+			if (skip_isolation_on_order(order, cc->order)) {
+				if (order <= MAX_PAGE_ORDER) {
+					low_pfn += (1UL << order) - 1;
+					nr_scanned += (1UL << order) - 1;
+				}
+				goto isolate_fail;
 			}
-			goto isolate_fail;
 		}
 
 		/*
@@ -1165,10 +1198,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			}
 
 			/*
-			 * folio become large since the non-locked check,
-			 * and it's on LRU.
+			 * Check LRU folio order under the lock
 			 */
-			if (unlikely(folio_test_large(folio) && !cc->alloc_contig)) {
+			if (unlikely(skip_isolation_on_order(folio_order(folio),
+							     cc->order) &&
+				     !cc->alloc_contig)) {
 				low_pfn += folio_nr_pages(folio) - 1;
 				nr_scanned += folio_nr_pages(folio) - 1;
 				folio_set_lru(folio);
@@ -1788,6 +1822,10 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	struct compact_control *cc = (struct compact_control *)data;
 	struct folio *dst;
 
+	/* this makes migrate_pages() split the source page and retry */
+	if (folio_test_large(src) > 0)
+		return NULL;
+
 	if (list_empty(&cc->freepages)) {
 		isolate_freepages(cc);
 
-- 
2.43.0


