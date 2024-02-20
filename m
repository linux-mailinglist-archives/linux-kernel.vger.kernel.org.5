Return-Path: <linux-kernel+bounces-73514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5815485C3A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB841B23F94
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1627E12F5AC;
	Tue, 20 Feb 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="IBCxnz5k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jiSueTP2"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A54D1292FD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453966; cv=none; b=lCq4m7TrcSOIpPbmJv2tvSw8PDb3hyV4QpHMjDBQmt0Hs5YxM9tsxDCeBjRm+IJfQffna4Gq0p06THPrj+FSa0FbSfyah4MnyoRhjpMDmYJh0XX39A0jUfWAMPWrH2Omu4ZOMbMJ5klnBVCg3aTVC1maWTAXgeuTjWRpwJqpHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453966; c=relaxed/simple;
	bh=HhOvTaFPif92cm6vV+oSKDGsnXOY2r1rAN3bwiOwq/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpRIW/wVumZT9te2cIEFKLsAQZb50qfklcaAIv/mVXy8LcPvUhrGJHRkQWWkXykEbUadY8DnOw9YnT/M9HLGIjKadNfDW+C4rmFjSmcdN+O7Qd+kk0Uqy7g5ijV5OaOREJ6AcXmPgx7j+p76APGTfjsO5PJkTkGJvuNj38Ezu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=IBCxnz5k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jiSueTP2; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 8B5B03200A4D;
	Tue, 20 Feb 2024 13:32:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 20 Feb 2024 13:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1708453962; x=1708540362; bh=VthfB9xHWXamr5LNX5aI7SP9sOuq2T7O1Uc
	OskPjsOI=; b=IBCxnz5kEzrcnVVh8byadrCYLGeY+gCPJu4KYwlIh6EYBa+DLmh
	DVgGL5okBSyRGQJM8oS2cHgWVRx3A/VIJsXjlm3/Q8xVAl81p8ZTP/MDsKI2ilKg
	j1Ao/xGia5AXXNoAg2GqbL8XA2QOpbmWkUYhgoERs1srQZHv3C2sJWikcSOgJwz/
	+rJtvtpe0YpSvNLJwH2TfKlclX3dzkRoKZiE4kGoAG4IF8+gMNdMFu8x2Hi8ckn9
	gW/FXHoVwtF++TWclK+cV7TKWHLboYQV2MVqYg/G0zDsRVdgwpivGy01VjhcrLvX
	Bh05vMbRhOlvB5aLeaXKrxXzQ4cKhU/uynQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1708453962; x=1708540362; bh=VthfB9xHWXamr5LNX5aI7SP9sOuq2T7O1Uc
	OskPjsOI=; b=jiSueTP2NFAW16xmDieh0jQv1EMcSklBlVsdVriYGBp7o94Ggcq
	fl0/Y10zf0QltMFk5nK18Kf7eVAmp5HMBYWlwcMMrbzm2fCsUiP4W6EWAgsjePP1
	pugKuaGP0Dg72DLTzagqAwEVofFHzqE8dUqb7Ia413zAYAzGmQ/RmNmNMqu80iK8
	dpyfuQmLBOu24LqQBr77Xce4SnEjXhA2bFEF/1r0RToVXdwMDXckGJibLq+U8kYX
	/vNtbBD9Is8Z+R/sn+DyixhqNPCqW9vOfAJ/u/DEMTKXT0EFLnPVqCUjBp/RfVJ4
	2jWosqtyzTbBoRRq+5SVmMelvVS5BbOYhzg==
X-ME-Sender: <xms:SfDUZVpsBPHjVIkSY7XQmRVXAzr2i5xjWLZB1w1jctnRyZheGqYK1g>
    <xme:SfDUZXoaKc_RLl7oEh-Vr4IrPoswIji0o_nnHuN55IgUQb_QoO1Tyj2m84qx-llkX
    IdNe4nxARM4roOOCQ>
X-ME-Received: <xmr:SfDUZSM6Ik6blHU6ANObj_svZgdkzriQD51l71_Fua_YXz4zTeoybFXOz_Vxvt6S9jtueG6P4TVhfJewD0kGzZS31CpxkX7kCFPCEZkbXaLKNgs85NSM_f9u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrgggtgfesthekredtredtjeenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepje
    ekteekffelleekudfftdefvddtjeejuedtuedtteegjefgvedtfedujeekieevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:SfDUZQ6f9TtJqP9u--u6m7rQDdiWfKrttFVUtvsdzj_rIaEj0ciMCw>
    <xmx:SfDUZU4RpzX0PH9YVRb-EI0f2-8vKFoYpP9_NR4giK7mloDZO57nOg>
    <xmx:SfDUZYgOfQrlx8w2H9oOuaymHGLqZXj_DExH-8HmvXdg9CD71WpSPA>
    <xmx:SvDUZRxMDtYSsOQbC9VLrjSNTgwcQQK2AYKpnJz7c0BXBEevb4bDZQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 13:32:41 -0500 (EST)
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
Subject: [PATCH v7 2/4] mm/compaction: enable compacting >0 order folios.
Date: Tue, 20 Feb 2024 13:32:18 -0500
Message-ID: <20240220183220.1451315-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220183220.1451315-1-zi.yan@sent.com>
References: <20240220183220.1451315-1-zi.yan@sent.com>
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
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Yu Zhao <yuzhao@google.com>
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
---
 mm/compaction.c | 101 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 25 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index ccd447282665..6509fab27be9 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -40,9 +40,22 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
 {
 	count_vm_events(item, delta);
 }
+
+/*
+ * order == -1 is expected when compacting proactively via
+ * 1. /proc/sys/vm/compact_memory
+ * 2. /sys/devices/system/node/nodex/compact
+ * 3. /proc/sys/vm/compaction_proactiveness
+ */
+static inline bool is_via_compact_memory(int order)
+{
+	return order == -1;
+}
+
 #else
 #define count_compact_event(item) do { } while (0)
 #define count_compact_events(item, delta) do { } while (0)
+static inline bool is_via_compact_memory(int order) { return false; }
 #endif
 
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
@@ -816,6 +829,32 @@ static bool too_many_isolated(struct compact_control *cc)
 	return too_many;
 }
 
+/**
+ * skip_isolation_on_order() - determine when to skip folio isolation based on
+ *			       folio order and compaction target order
+ * @order:		to-be-isolated folio order
+ * @target_order:	compaction target order
+ *
+ * This avoids unnecessary folio isolations during compaction.
+ */
+static bool skip_isolation_on_order(int order, int target_order)
+{
+	/*
+	 * Unless we are performing global compaction (i.e.,
+	 * is_via_compact_memory), skip any folios that are larger than the
+	 * target order: we wouldn't be here if we'd have a free folio with
+	 * the desired target_order, so migrating this folio would likely fail
+	 * later.
+	 */
+	if (!is_via_compact_memory(target_order) && order >= target_order)
+		return true;
+	/*
+	 * We limit memory compaction to pageblocks and won't try
+	 * creating free blocks of memory that are larger than that.
+	 */
+	return order >= pageblock_order;
+}
+
 /**
  * isolate_migratepages_block() - isolate all migrate-able pages within
  *				  a single pageblock
@@ -947,7 +986,22 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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
@@ -1008,21 +1062,24 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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
@@ -1165,10 +1222,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
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
@@ -1788,6 +1846,10 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	struct compact_control *cc = (struct compact_control *)data;
 	struct folio *dst;
 
+	/* this makes migrate_pages() split the source page and retry */
+	if (folio_test_large(src))
+		return NULL;
+
 	if (list_empty(&cc->freepages)) {
 		isolate_freepages(cc);
 
@@ -2090,17 +2152,6 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 	return cc->nr_migratepages ? ISOLATE_SUCCESS : ISOLATE_NONE;
 }
 
-/*
- * order == -1 is expected when compacting proactively via
- * 1. /proc/sys/vm/compact_memory
- * 2. /sys/devices/system/node/nodex/compact
- * 3. /proc/sys/vm/compaction_proactiveness
- */
-static inline bool is_via_compact_memory(int order)
-{
-	return order == -1;
-}
-
 /*
  * Determine whether kswapd is (or recently was!) running on this node.
  *
-- 
2.43.0


