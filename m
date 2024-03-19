Return-Path: <linux-kernel+bounces-107740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6AB88010B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68381C22062
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED587FBB7;
	Tue, 19 Mar 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="J0vcsUth";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X0tz1iv0"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ACB2E400
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863282; cv=none; b=L18S8kPNGpLvrxZQ+IcvqmYDBKzPHIm7FsHzUxRQRMYqYhvnbG9HWhcmqCJI7002j7gZ5soxt1E+lO1QZzjsqPEORMlDQQ2LYE1Hpv+vPxQsqPSPvobnIXABsT0Kf5k5u63S+bxlR7xDe8o/pFfUNWTHc009xui5Tt8JAx2SMPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863282; c=relaxed/simple;
	bh=Bc1T32A34DjgDza/Nbd7gpMv8tERceu8/EdVkXPeZ/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lz8QWDwwkS0bbMijQlBSlRHnhnGE2cfVjvJyAinPzFyWGLV+rtrJVyfGFhi0h2Z/hjrGtitHNBeFgGADLlizV42elHA4K2CiFjxBzDLpjFhE+V/jS9O2PU4yvndwnkJIw+nlJblmPk+v28nxXQhycvLmArErQ4KRXTWgL/DvVjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=J0vcsUth; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X0tz1iv0; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 790B21C000F7;
	Tue, 19 Mar 2024 11:47:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 19 Mar 2024 11:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm2; t=1710863277; x=
	1710949677; bh=nessaiOBTaNCwP7gjUOn86nFinuzdOOpq2kbEfd5EGw=; b=J
	0vcsUthTSQYrwXZb6x4NqkHmEFK8yNAKPH0eud1LI9GxXiA4y6Mh+lULGpL352Z8
	6Ck0j00psKFiBfpR6y/Bh48vki09ys+eSlehhtyprmArhs+X2kO+jALDpO/6bL8M
	gh6VuMoCSrFea8mcbIDfWqPsj4wHeqWAzMOu9tZMGKAH9LABV2ZI8tiDa1Dg/E98
	kgfdPdu/VF34hy/G/UDENvx3OPytMZpFr/ZZXG2zpjx0gA0JuKdjBEiM9L4YFlrg
	0DaYh6Wka0wt1j6NZvzLqcEMGGbbAN+iWBCZQndZazIOWHxy0ff04YvnO4TXRMG9
	qpsJ9p4WHuS+5616exHFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1710863277; x=1710949677; bh=n
	essaiOBTaNCwP7gjUOn86nFinuzdOOpq2kbEfd5EGw=; b=X0tz1iv04y3dkcwvP
	OLigajGJCLsEEzXoX99mR0e/P/WBdFXnAeyY8pqKsydTTcuSlQu1IQHo1zr0kvA+
	aoSO+AamEqs2vocidbud0M3pCfJQvdUMOakknueQcV+YAk6YaQCoNmaRTriJYkK1
	gub+QxUCMSoYPxzp6He5dTlfAHtqpzV+aDqdPs95DE0FVh74BKFI6PvcySUXKUu/
	mn6i0dQbUh4EqnjyCZuuo/ndrbhO86oed4bBUKAvIDN9pgxOwjJNfSLhioGKxzYg
	gzv3fm2x+oAuHGe68LnJX79hs2+sfce+KgOo+2xdk8SmBSMSBqfbvIE1LCBOsr84
	KBW+w==
X-ME-Sender: <xms:rLP5ZSM-qdF3yIUHvLUbGYH-VL4TgqmOd6-qbj1q1kteRjC4lUJdtw>
    <xme:rLP5ZQ8DHT2HdMEO80kMF1dy_KXMQ9rpHFWMO0h2enb8huBmXoMPM8mdss1-oeD6Q
    ptDhF3dmxunpyRxQg>
X-ME-Received: <xmr:rLP5ZZQfTuGBucvO-fyuxy8cFmy6Urd9zs14lj-Ny-1o0ZtjNzBS4PYUqLQ1gT5ey12wKI9pCsmr8jjZvdkG1kH_2yAcJZ48iM1RxCd2-jEPu9cPvuypTq6z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeetudevhe
    etheehieetiefhjeevjeeltdfgvdeiueeiudetffdtvedthfetvedtffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:rLP5ZSvW9dcktSUDDJ3SQJJb4DVoWtpym0mVf2cUmjyoemIWyNCLnQ>
    <xmx:rLP5ZaeW_se_tU8FTiKsocZtiUEm7h1zDVCEZJCOpkiJRvZIHsDjRg>
    <xmx:rLP5ZW3LmhfD6dx9NgWNRkEpEm5TnSxz5HIkUUwQESv43uD5vJuQsw>
    <xmx:rLP5Ze8cxqD-jRpES4m3QcyM9iNKjIUuVDA-UJ77rZ68cQcA8ZieyQ>
    <xmx:rbP5ZQ03f8EYYZuK_LRJqHT9vqyDjHqsbEdd18SVaEwFxGdWfQQONBzr9U0>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Mar 2024 11:47:56 -0400 (EDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mm/migrate: split source folio if it is on deferred split list
Date: Tue, 19 Mar 2024 11:47:53 -0400
Message-ID: <20240319154753.253262-1-zi.yan@sent.com>
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
 mm/huge_memory.c | 22 ------------------
 mm/internal.h    | 23 +++++++++++++++++++
 mm/migrate.c     | 60 +++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 72 insertions(+), 33 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9859aa4f7553..c6d4d0cdf4b3 100644
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
index d1c69119b24f..8fa36e84463a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1107,6 +1107,29 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmd,
 				   unsigned int flags);
 
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
+
+
 /*
  * mm/mmap.c
  */
diff --git a/mm/migrate.c b/mm/migrate.c
index 73a052a382f1..3fd58b267e37 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1654,25 +1654,63 @@ static int migrate_pages_batch(struct list_head *from,
 
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

base-commit: 384df0d61b071bb7a38ae63bae9b59d088335911
-- 
2.43.0


