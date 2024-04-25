Return-Path: <linux-kernel+bounces-159190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843398B2A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B1A1F21F03
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07593155398;
	Thu, 25 Apr 2024 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="Qz4mbo7F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E6SjiYRr"
Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56EA37143
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079504; cv=none; b=D4d535RXPpAazMFRymni4U55qPJDXcMErzThXJaIDKUOwnEhJYqfN8Ombic9Z5BdP3jWzWTnU/huc3EEiHrDK2jp0upwUMy4/SSwRXoUyWNilOcdHJLzxknxj2FSSp48duoawPsmvl1kBfAQj9MzRd/PbtxS0f3cTuFXrXiDr3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079504; c=relaxed/simple;
	bh=GyqMvJXAfaiti7K97yMzFKkzr6iZHTZA68RRpahYJX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYP97yBHLGQef4SilG+MmLhtK/G3l2ODwBHydhr+z2lg6PPk3zjQ6Ro7+Tv4MVvAJDvNVfijsccvjwj4h9y6RNZLWkys6VJMVMiwiSf2tdZ4FVPpCLURgzAkr2NsGMSfI0jup3igtifNfJEfR1gBhGRXIqI0RoUbdYbR3tLh/tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=Qz4mbo7F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E6SjiYRr; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1C804180010A;
	Thu, 25 Apr 2024 17:11:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Apr 2024 17:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1714079500; x=1714165900; bh=iGwfXom4e7
	yCPiqRGg7li8EHLijwecEGUquGPFC+5WI=; b=Qz4mbo7FRm3b3kQ6kdzfBqIyIB
	ZUSMsl012WSYgD353Z6ow2o+nGTIfmDa/Kpnj1jrdVNIBZW7cOzc5rFk4OLQd9Kc
	sSdw10UyXSDdqm3qpJV3eloNEmOJC1Jzu7ic51yxZiTK2ccMisHf5O0Z8KFI+Wzz
	l4TwGnAyLXx77B6eTgABlblfbwCdFH6dbWhdbsl/Lg9CDnmJwqQXIBqD5VSneYuk
	opmuH6RxlTO+/snV4v4HvkdE7t0YutQMeY0gUg1vxCUFADgcwRnLbtFynKDP1OyL
	znKzrn8Ac1mCsD2ZGGu/BcVH7OR1jq9AO5LlJLJT3KSTmAGkpGU3UPdBQ87Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1714079500; x=1714165900; bh=iGwfXom4e7yCP
	iqRGg7li8EHLijwecEGUquGPFC+5WI=; b=E6SjiYRrFB34PrHMNhJYrxrZXCMFj
	JeG1NC9YAjvWrJmrlxkMwUGpaBEjHEyYdOHJ37Mj2GKEmd0jgYBglVtZRSf9GRdy
	6uO0QxGQLxuGA9T82gythsIbEtuLfwfGQM1ZUFt3EWfdvp8chADb5rLjTp+AK8bD
	Z+pBm1kHZ5z5v5dx119Ph4qKixzha5rZvN4ltGwJqEI6ivWKQgCPLJwCZpufGoN4
	X6j+cxfviwe95dWJ+S2vni6W4rnZgJPiEioAppz5CSlM2++rtJh41L+b1yH5NuYJ
	Y8QnIWoz+IxfzX22nFmx5Ttf5fGN2zhvFOeh+IhY1NJWLCS8zngpz5xLg==
X-ME-Sender: <xms:DMcqZkzmQzi4XNV-1wAHrIz-KfVYTqOUBaLFxAEU6xUJ-u1PXVWO5w>
    <xme:DMcqZoRy13P_lQF3mcLMS6bGJvQzfn5MHWE2q4X5HKjvHSe4a3LBDAZ1SGph9-pOB
    _MJBFNajD__BE0wWw>
X-ME-Received: <xmr:DMcqZmWyruSSPAfBUUcEimapbQcabmYQa6m-3fGXhH7U1XyykkiJ0eXOWfTbUTftGr_bRGN1ydaFf-Y3Jgrh4i7g_E6S9eJjfouODabDLac6wACjE6n93CMp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkfforhgggfestdekredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepffejue
    eifeejudejudfgiedtfeeltdfgueffhfdulefgtdekteekfeejheekhedtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:DMcqZigfqKIDRtlBEtIUzv8M6d_NriLkhVcteYmkZzxDhyGEhRPtjg>
    <xmx:DMcqZmD4tvJyHAayy_1EQgf_vwpvnlcVUn3zrUmaOhUc3zEFXmXVeg>
    <xmx:DMcqZjKddHQMku1zSHZZNF8WAAKlxl-tkd3sIAcIV6sEtdb28vy1cQ>
    <xmx:DMcqZtBrlxN65lchZRrvnFmo41ndxA8oZoNCr4vzi6s3lKwgTRCRig>
    <xmx:DMcqZq5iTCo9IU6DhlZoJibq8mZbWJMybygjgieR7W_brpmZYVO4SfM7>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 17:11:39 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <21cnbao@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Lance Yang <ioworker0@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] mm/rmap: do not add fully unmapped large folio to deferred split list
Date: Thu, 25 Apr 2024 17:11:36 -0400
Message-ID: <20240425211136.486184-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

In __folio_remove_rmap(), a large folio is added to deferred split list
if any page in a folio loses its final mapping. But it is possible that
the folio is fully unmapped and adding it to deferred split list is
unnecessary.

For PMD-mapped THPs, that was not really an issue, because removing the
last PMD mapping in the absence of PTE mappings would not have added the
folio to the deferred split queue.

However, for PTE-mapped THPs, which are now more prominent due to mTHP,
they are always added to the deferred split queue. One side effect
is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can be
unintentionally increased, making it look like there are many partially
mapped folios -- although the whole folio is fully unmapped stepwise.

Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THPs
where possible starting from commit b06dc281aa99 ("mm/rmap: introduce
folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-mapped
folio is unmapped in one go and can avoid being added to deferred split
list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will still be
noise when we cannot batch-unmap a complete PTE-mapped folio in one go
-- or where this type of batching is not implemented yet, e.g., migration.

To avoid the unnecessary addition, folio->_nr_pages_mapped is checked
to tell if the whole folio is unmapped. If the folio is already on
deferred split list, it will be skipped, too.

Note: commit 98046944a159 ("mm: huge_memory: add the missing
folio_test_pmd_mappable() for THP split statistics") tried to exclude
mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does not
fix the above issue. A fully unmapped PTE-mapped order-9 THP was still
added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().

Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/rmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index a7913a454028..220ad8a83589 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		 * page of the folio is unmapped and at least one page
 		 * is still mapped.
 		 */
-		if (folio_test_large(folio) && folio_test_anon(folio))
-			if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
-				deferred_split_folio(folio);
+		if (folio_test_large(folio) && folio_test_anon(folio) &&
+		    list_empty(&folio->_deferred_list) &&
+		    ((level == RMAP_LEVEL_PTE && atomic_read(mapped)) ||
+		     (level == RMAP_LEVEL_PMD && nr < nr_pmdmapped)))
+			deferred_split_folio(folio);
 	}
 
 	/*

base-commit: 66313c66dd90e8711a8b63fc047ddfc69c53636a
-- 
2.43.0


