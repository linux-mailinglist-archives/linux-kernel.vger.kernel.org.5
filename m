Return-Path: <linux-kernel+bounces-108328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A43880937
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9487C1F24764
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4027490;
	Wed, 20 Mar 2024 01:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="MZgnlphE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vaMgqZNG"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64E7464
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710899126; cv=none; b=UE+kUweNGwi7Jeg8qCOKP1x7AJamot7vn7MWYPINfyvH5E/m0tgSmj94/py2MscL+kXE496Wz+0UySJKTQgy2BBypbG6iJFjMPZ8efajaUOxhV1AeqhGfGVTjhfwTVA9yHy5Y52Nfc04bbaojTO7A4P+KkD6SkI+ynoZsg76ECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710899126; c=relaxed/simple;
	bh=Hr+AikhkC1pDqOhI1uyGIhBY7nBLv2Fwzn0O/Au6RXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oNt6e+W2xJBEhwPHYBtxNBIL5DjkxkoN4/N1F0D6A3CeHjOj+01xLune6HszNipQh3YwlDIUNuULQAuR72BpIeWwj9yDJsT+JhymY2Dnrv/HBlBqcKbCbKTOW4KrVig5B5goo/AluuS3Qc75028NS2GizypmkSUMgMsv9M9mI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=MZgnlphE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vaMgqZNG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8B156114011F;
	Tue, 19 Mar 2024 21:45:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 19 Mar 2024 21:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm2; t=1710899123; x=
	1710985523; bh=OllGBd/e2P4hWoSOipzEy0ACyR7T+q17LVRPTxf0DMQ=; b=M
	ZgnlphEblWkAjWrxCxWUh6gDkJ5GAShRjT40ftx3ETe8GbZ0T7ZpKNkw8VkB8WH1
	rfcXw6cW5XxutEDJBKUBvHQphk+w3I5bpnuAqN6v3fh4Slg3IzsCs2T80b5PaLJv
	6TG3ADK1rCUdlWx5GD8ugznonTzm0Zea/8hu+m8JJ0ZVOipdO3qJRFSuf5Cr8yuW
	OCtCBkp+LMGYKABMJNs2/eWnRR6vFxJTZIFOrcaj+mIfDF/79uXURqxbMM/G2bdG
	r46AZ6xBsM6TXwRpM3O2SluGTbwRbLezWpBcL/ND9yrBeEV7RxLk3fblNULCFBMg
	oQRSFsrs60o0C9EeRZbYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1710899123; x=1710985523; bh=O
	llGBd/e2P4hWoSOipzEy0ACyR7T+q17LVRPTxf0DMQ=; b=vaMgqZNGFpNqXGQoF
	y1LPPJaBw97LhzZ7VLVWAAYKoc96ems8x6Y+b5r0zig/5T/XYml4QJLFmubuKTTc
	/n4vLq12ylEYTomaJEK76+lBXv2+zdNd/+2P8bWLv55q+U790AB+gDBHIQY293J5
	zeU7DdSUK5xPMXyXOes5WwqzwLNvsWkCvO9OrEFc/iBVQoTUhRaeqokz1yjuRQH8
	Y5EyKcc/3XTdnKgfQ3XzHilAfxSVljDzqPzjRe3uRfFqf4aoX7kvv6jl+lNC1WAY
	DKKkTZ3AihZd4RprQ0aJ4u57Dc6EsicRnXuwXIWSXDgJjy0xWtYeIOK4tDLFfQUq
	x8ipg==
X-ME-Sender: <xms:sj_6ZXLix5MeLF_RYg-5rhDlIh6r-i2ks6kz4hKT06meNNig9GnWTw>
    <xme:sj_6ZbLym2ZBzhPS5GxGiFv4xr2eRsHZ_BqZ1izA6OmzGnvhfjOAp6n19V2IS0Jme
    GYNgashXLW5EX-wDQ>
X-ME-Received: <xmr:sj_6ZfuZ6tsCrOFEriVaXlonXOqC-SRjG3-lRQkAe_d9HFg6FsBHW7lyEBWmDpUyIbhkOweDfS4v6iBwzmCmDRf-zTzMQGxixjMBiUdMhykxUjaeiz-Ehf4u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledvgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetudevhe
    etheehieetiefhjeevjeeltdfgvdeiueeiudetffdtvedthfetvedtffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:sj_6ZQZ-gkuOQE1v94irufeUD9XNV35gXTqeZI8EnVYwPMOYghmPqQ>
    <xmx:sj_6ZebQlAGBbXQyngjl60WLZvhYWiEmvGSkzoLnDWx0tHFHfZZf4Q>
    <xmx:sj_6ZUAy-ugFOfFkQ5vk66lUrPbAqAVk_T7oHVXV4bhbA3gYO7_O_Q>
    <xmx:sj_6ZcZ2SkGP2ZP6w19D47HFqmKttLR_YONvFGk6jmofyc9XJKL-5w>
    <xmx:sz_6ZWq9bud7HmL6KWiKrCpHT_N8IrCziq92sZ90cfPlFLMa7dUl0Q>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 21:45:22 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Yin, Fengwei" <fengwei.yin@intel.com>,
	SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] mm/migrate: split source folio if it is on deferred split list
Date: Tue, 19 Mar 2024 21:45:11 -0400
Message-ID: <20240320014511.306128-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
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

If the source folio is on deferred split list, it is likely some subpages
are not used. Split it before migration to avoid migrating unused subpages.

Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")
did not check if a THP is on deferred split list before migration, thus,
the destination THP is never put on deferred split list even if the source
THP might be. The opportunity of reclaiming free pages in a partially
mapped THP during deferred list scanning is lost, but no other harmful
consequence is present[1].

From v3:
1. Guarded deferred list code behind CONFIG_TRANSPARENT_HUGEPAGE to avoid
   compilation error (per SeongJae Park).

From v2:
1. Split the source folio instead of migrating it (per Matthew Wilcox)[2].

From v1:
1. Used dst to get correct deferred split list after migration
   (per Ryan Roberts).

[1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C817C@nvidia.com/
[2]: https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infradead.org/

Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 22 -----------------
 mm/internal.h    | 25 +++++++++++++++++++
 mm/migrate.c     | 62 +++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 76 insertions(+), 33 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b40bd9f3ead5..c77cedf45f3a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -766,28 +766,6 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 	return pmd;
 }
 
-#ifdef CONFIG_MEMCG
-static inline
-struct deferred_split *get_deferred_split_queue(struct folio *folio)
-{
-	struct mem_cgroup *memcg = folio_memcg(folio);
-	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
-
-	if (memcg)
-		return &memcg->deferred_split_queue;
-	else
-		return &pgdat->deferred_split_queue;
-}
-#else
-static inline
-struct deferred_split *get_deferred_split_queue(struct folio *folio)
-{
-	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
-
-	return &pgdat->deferred_split_queue;
-}
-#endif
-
 void folio_prep_large_rmappable(struct folio *folio)
 {
 	if (!folio || !folio_test_large(folio))
diff --git a/mm/internal.h b/mm/internal.h
index 85c3db43454d..56cf2051cb88 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1106,6 +1106,31 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmd,
 				   unsigned int flags);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#ifdef CONFIG_MEMCG
+static inline
+struct deferred_split *get_deferred_split_queue(struct folio *folio)
+{
+	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
+
+	if (memcg)
+		return &memcg->deferred_split_queue;
+	else
+		return &pgdat->deferred_split_queue;
+}
+#else
+static inline
+struct deferred_split *get_deferred_split_queue(struct folio *folio)
+{
+	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
+
+	return &pgdat->deferred_split_queue;
+}
+#endif
+#endif
+
+
 /*
  * mm/mmap.c
  */
diff --git a/mm/migrate.c b/mm/migrate.c
index 73a052a382f1..e80cb0f46342 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1654,25 +1654,65 @@ static int migrate_pages_batch(struct list_head *from,
 
 			/*
 			 * Large folio migration might be unsupported or
-			 * the allocation might be failed so we should retry
-			 * on the same folio with the large folio split
+			 * the folio is on deferred split list so we should
+			 * retry on the same folio with the large folio split
 			 * to normal folios.
 			 *
 			 * Split folios are put in split_folios, and
 			 * we will migrate them after the rest of the
 			 * list is processed.
 			 */
-			if (!thp_migration_supported() && is_thp) {
-				nr_failed++;
-				stats->nr_thp_failed++;
-				if (!try_split_folio(folio, split_folios)) {
-					stats->nr_thp_split++;
-					stats->nr_split++;
+			if (is_thp) {
+				bool is_on_deferred_list = false;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+				/*
+				 * Check without taking split_queue_lock to
+				 * reduce locking overheads. The worst case is
+				 * that if the folio is put on the deferred
+				 * split list after the check, it will be
+				 * migrated and not put back on the list.
+				 * The migrated folio will not be split
+				 * via shrinker during memory pressure.
+				 */
+				if (!data_race(list_empty(&folio->_deferred_list))) {
+					struct deferred_split *ds_queue;
+					unsigned long flags;
+
+					ds_queue =
+						get_deferred_split_queue(folio);
+					spin_lock_irqsave(&ds_queue->split_queue_lock,
+							  flags);
+					/*
+					 * Only check if the folio is on
+					 * deferred split list without removing
+					 * it. Since the folio can be on
+					 * deferred_split_scan() local list and
+					 * removing it can cause the local list
+					 * corruption. Folio split process
+					 * below can handle it with the help of
+					 * folio_ref_freeze().
+					 */
+					is_on_deferred_list =
+						!list_empty(&folio->_deferred_list);
+					spin_unlock_irqrestore(&ds_queue->split_queue_lock,
+							       flags);
+				}
+#endif
+				if (!thp_migration_supported() ||
+						is_on_deferred_list) {
+					nr_failed++;
+					stats->nr_thp_failed++;
+					if (!try_split_folio(folio,
+							     split_folios)) {
+						stats->nr_thp_split++;
+						stats->nr_split++;
+						continue;
+					}
+					stats->nr_failed_pages += nr_pages;
+					list_move_tail(&folio->lru, ret_folios);
 					continue;
 				}
-				stats->nr_failed_pages += nr_pages;
-				list_move_tail(&folio->lru, ret_folios);
-				continue;
 			}
 
 			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
-- 
2.43.0


