Return-Path: <linux-kernel+bounces-99475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89E98788F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6531E281293
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B524D54FAA;
	Mon, 11 Mar 2024 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="o6K2G/DJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g++Kpc02"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42C71E884
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185809; cv=none; b=WLZ490iXvhL3RxwskKv2+ZjwykV/ku1ckE4vJh+WeQWHLfLEKY0QGN5SJLfRhYhp9KpIiHkVzhyWFoEb1R+sa3bvujTC8pOdXKCEKEpXTbJwBuLm0/vhhcZ8+zd9szlZ0+Jt5oSPAyluf2rwomi4I1bQaH8OJTrWHI5QmFuLZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185809; c=relaxed/simple;
	bh=oA81BqaKSjba3CwENuBFCYqFjtfgxiRczieDtv4LSF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V7ceb5bMpRMZ1csyS3h1jNV606N20GwYA4tMNi550Fpa9GYsiNBx2ZgyhgpvkLJsyy0nHFVNyblfdf2nlO3w0uwttpsSQQ+KQv1xCQCZcLhG86L9LLFx0PpjFgg15aEytLw+BMaSrX4BVnTGWtiPghaA5QaczldcyWc0G1KO3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=o6K2G/DJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g++Kpc02; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id B846113800D1;
	Mon, 11 Mar 2024 15:36:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Mar 2024 15:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1710185805; x=
	1710272205; bh=dGukwC2LyuCQ/OI2VLjd+cSQB2fydh8T1EPdNGlVsRE=; b=o
	6K2G/DJ5LagUkehXa5ADJ7WTPVdfVXlGzW2zy+eGBuGT6QI2MrSS0DmIJn69D7Cw
	+U/fWwj6XXBsxVjME6kwoaYXXUc3yXOWNFGnWl+URrl0jFzHr2rbIBsFgeTFZMpb
	g2GSHEQ8SGOXEmeB8lvEeGD2x4+R/EFfeFIdQFqh7cYrbNKHib5guFDk/M1OE8Oh
	IdYyhOLDCzt2LatWJYDas/wIP79UMrU84p5wx9xUR6L+HpI65mGIFJ56Pw5CSyp+
	40AovbgNjugSsAj9YyiAcBvjBBddy7GPgN6IO3m/eJt/LmVPgTu8hTJ0gZ26Xd4f
	UynonsCZwZNFoQz19mPBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1710185805; x=1710272205; bh=d
	GukwC2LyuCQ/OI2VLjd+cSQB2fydh8T1EPdNGlVsRE=; b=g++Kpc02SIO1PTbw1
	vrCWbW/5SB1UYIaHipoExzoYFFHrfFpVPVxC2zEca0hKPnjp1c3TzL0Tptxk0+bd
	TYlGQoRNGFTpC9pUMdgr4iWUv3oWK2DtzlfZYzSL1eE0tG3NbytjUzIuoQaowXEQ
	AHrZJttHIIdLc0cANlxUvpjQCtYOWi/jXT2DiAdUoh7LD01tIMFrU1w8sTvn7pbj
	ANE8VfsXm2YOKmIGgGppdkSNoCHL4oDxNHO21tkLMqpfvrPdrZKje+DgjvdSdY7X
	wiSNqIWES8cdOhKNS5BiUT5ULqxIu4izmtUEYZqf2BjsdvgHLctAWl5wuM5wcLWA
	arRTg==
X-ME-Sender: <xms:TF3vZc9fgCd95c_ooxAQmQiodwPWX9Z-dmApGjQLzRuadEuQuYEujA>
    <xme:TF3vZUvhhkTAkzYcFWGAVz2rMBHI0cP9HzXpAOrHSw6kN8YWlBtRyj0CXzGz_7ikT
    lJ2DfWHnuXbj5pNGg>
X-ME-Received: <xmr:TF3vZSCnWw4k7Pf7-k6hVbIPPeBpPSQG5V2ncJ45pw7m-woyaiLqqXvLc1giJR3LiLyOiGSzxCauRXSHW-dpLaKkqbAqnRI2u89hHIFaP0tJPjLoIsmWiz-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrgggtgfesthekredtredtjeenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteduve
    ehteehheeiteeihfejveejledtgfdvieeuiedutefftdevtdfhteevtdffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:TF3vZcdUkIt5dCsduemOcSAmJQyyHYXP6Ly4uW4Oz-RuptfeS8b-bA>
    <xmx:TF3vZROnVg5CQb8AmUaBUDKrH2lUD6HGpr-NCLmFkEsq7WzMB653Ng>
    <xmx:TF3vZWnRavW-TLq2F_WzvTPjQ0_i1c1aeY7Nmnytv6qxSXY4OTpjRQ>
    <xmx:TV3vZUo1kLehLivRLFh4XerLjzuqDRU2CpSL_9-UufH9FvCK2c88yg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 15:36:44 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/migrate: put dest folio on deferred split list if source was there.
Date: Mon, 11 Mar 2024 15:36:41 -0400
Message-ID: <20240311193641.133981-1-zi.yan@sent.com>
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

Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")
did not check if a THP is on deferred split list before migration, thus,
the destination THP is never put on deferred split list even if the source
THP might be. The opportunity of reclaiming free pages in a partially
mapped THP during deferred list scanning is lost, but no other harmful
consequence is present[1]. Checking source folio deferred split list
status before page unmapped and add destination folio to the list if
source was after migration.

[1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C817C@nvidia.com/

Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 22 ----------------------
 mm/internal.h    | 23 +++++++++++++++++++++++
 mm/migrate.c     | 26 +++++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 23 deletions(-)

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
index 73a052a382f1..84ba1c65d20d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -20,6 +20,7 @@
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 #include <linux/mm_inline.h>
+#include <linux/mmzone.h>
 #include <linux/nsproxy.h>
 #include <linux/ksm.h>
 #include <linux/rmap.h>
@@ -1037,7 +1038,10 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 enum {
 	PAGE_WAS_MAPPED = BIT(0),
 	PAGE_WAS_MLOCKED = BIT(1),
-	PAGE_OLD_STATES = PAGE_WAS_MAPPED | PAGE_WAS_MLOCKED,
+	PAGE_WAS_ON_DEFERRED_LIST = BIT(2),
+	PAGE_OLD_STATES = PAGE_WAS_MAPPED |
+			  PAGE_WAS_MLOCKED |
+			  PAGE_WAS_ON_DEFERRED_LIST,
 };
 
 static void __migrate_folio_record(struct folio *dst,
@@ -1168,6 +1172,17 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		folio_lock(src);
 	}
 	locked = true;
+	if (folio_test_large_rmappable(src) &&
+		!list_empty(&src->_deferred_list)) {
+		struct deferred_split *ds_queue = get_deferred_split_queue(src);
+
+		spin_lock(&ds_queue->split_queue_lock);
+		ds_queue->split_queue_len--;
+		list_del_init(&src->_deferred_list);
+		spin_unlock(&ds_queue->split_queue_lock);
+		old_page_state |= PAGE_WAS_ON_DEFERRED_LIST;
+	}
+
 	if (folio_test_mlocked(src))
 		old_page_state |= PAGE_WAS_MLOCKED;
 
@@ -1307,6 +1322,15 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	if (old_page_state & PAGE_WAS_MAPPED)
 		remove_migration_ptes(src, dst, false);
 
+	if (old_page_state & PAGE_WAS_ON_DEFERRED_LIST) {
+		struct deferred_split *ds_queue = get_deferred_split_queue(src);
+
+		spin_lock(&ds_queue->split_queue_lock);
+		ds_queue->split_queue_len++;
+		list_add(&dst->_deferred_list, &ds_queue->split_queue);
+		spin_unlock(&ds_queue->split_queue_lock);
+	}
+
 out_unlock_both:
 	folio_unlock(dst);
 	set_page_owner_migrate_reason(&dst->page, reason);
-- 
2.43.0


