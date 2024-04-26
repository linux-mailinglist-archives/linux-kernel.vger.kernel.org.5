Return-Path: <linux-kernel+bounces-160593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F5D8B3FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1084F283EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6C0D2F5;
	Fri, 26 Apr 2024 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="NLkCziXg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PwaakadR"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66918BA4B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158181; cv=none; b=irHrw6wmfMT0m6ocGKvZgDIp8P5r5ijxHd9ZZ4VIqq3YmQvNlfGYEIurorc+2tR/gx02lnRtTtCprScmnxQs3ehKsB8yIuMmt3TA+YN+uH82QDdmxjcAWHcOrDHM+ziM4KTeyPJNRjEiaRL9uW13xnEBYnT7UyqdYD+hCpqM2Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158181; c=relaxed/simple;
	bh=3LxM1ZYMz9FW2AbZPIhRcp32kvGT5HjeOXWn0685cQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XCtDLTIrULBKRvvl6lAPXh1LImEV86zMdb+8+P2hUK5yf3fpy9TcvBf9ZRgW8sNxmEkrjiwBLql40bY5OWpOoCDSVxAtZBttDO3cShaTCgboUZQUyLJQviLXA8n8NVdIVwwdPNajYqHD8VisrE6FDBFXKo/Z15S/vVRe7oTO5g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=NLkCziXg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PwaakadR; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id A0BF31C0015C;
	Fri, 26 Apr 2024 15:02:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 26 Apr 2024 15:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1714158177; x=1714244577; bh=u3Bdoo77C0
	6eP9MyEhIJVQSYXIKHj1xxukvATG+3jJo=; b=NLkCziXgYCGcc0B84MgzWd7zIW
	PpOJMhuiqf9N0PAKh1HHU42kUEZHVKTCMIFXtUZkctPYN0fT0rTE2pclov9JZuBT
	/8Rk6eYDBgVH4/1aeIibBhXJrzuWpVNOTxPqshaPyXOoDuPfBCdNOL9fCsvqklWg
	0K9cg6sy1WiN7jLLqG33rpRad+PABBZFRS6z31aUf62B+hQLUhKdlKkWWDEUJdk3
	WlesY5D3T6mhynXMd2g+eM8mrAv7KkCthWnKeVn6SvJ3Z+M7Dctbd0iyugXCN2Zo
	qBtWbmyTCvbSMIgaaqM/REMwXFi3Nf1VvJV9/54kVNjt/1tzM6gjjjHxHL2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1714158177; x=1714244577; bh=u3Bdoo77C06eP
	9MyEhIJVQSYXIKHj1xxukvATG+3jJo=; b=PwaakadRBqQi1SnA5G0sIKeUcPRcZ
	V/2UxUgFrxpU1U9Pd5J6mMOIfGyB4Ul/RVtdP6AAoQvjB2bO5g7kX0GkzDypB+0g
	fEUIiQ65lEGni40J5MVc6+X4YrEXKLZ/4/PZtz7IGJ30gozXILF5E/kyZL2g+w2c
	Gs2Mr9resHVQuE3Cz8TzahqeiRGIlM8AOtQFbYM0R8ZFibHUrc5AMGKeZ5rOS0Vm
	bmKOn3HRQYAo73kfURMOCfDcD3hf7g+M6DvwI6h/NyCH4PNnNEXzGpcmt4mOBIc+
	Kf0b1AbNT/8EHvlEK1g6vtNWmMJc8qrwTL0+uJDCv2da/wEx8Vd7dxmYA==
X-ME-Sender: <xms:YPorZsxE-kB2gZesW4Sf_VTQa24NVPIx9vL6Q0Cy5wLqsQLIUCCFJQ>
    <xme:YPorZgSvZCASUBdxTEuRGGWMGiY3ePvPsKS5cKPAFWv--EWkjVHbkmyj2D25Ap1wJ
    D7vh7ekuG0eR9-SIw>
X-ME-Received: <xmr:YPorZuV0LAdAvAbporKn9zmRCmnSvqKJLUtwj0WvziQ-ex34vXUwh6SBdAqQ0JhLhqocAva2QTfOcYvyTR5DLvomHhh-SE8Fxdpt5DT7jmzO3jkgKGpwPO58>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelledgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkfforhgggfestdekredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepffejue
    eifeejudejudfgiedtfeeltdfgueffhfdulefgtdekteekfeejheekhedtnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:YPorZqjv8pxnfRcSmmTDTO08PiwZ94m8NDBSIcZ56ud31u2Kq_KzMw>
    <xmx:YPorZuC-5PEy5gj04GRyIYhQkn6tSgdhx6n-iGAyBrm3AX4zDGcn1w>
    <xmx:YPorZrIhSTk_Tk9NHL4HmvA0PziceQgPZOsBOFl4PrPb3z96jDNIGg>
    <xmx:YPorZlDWHvczJY6cToC0R_RlKMN-GHQbijIM0fnm_DNFbtp3VOz5yw>
    <xmx:YforZi7JeELTDubHTN5zAOfwQOHPo2KMy7PYQ0sknshta49HHaX_c3xE>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Apr 2024 15:02:56 -0400 (EDT)
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
Subject: [PATCH v5] mm/rmap: do not add fully unmapped large folio to deferred split list
Date: Fri, 26 Apr 2024 15:02:53 -0400
Message-ID: <20240426190253.541419-1-zi.yan@sent.com>
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

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/rmap.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 2608c40dffad..a9bd64ebdd9a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1495,6 +1495,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
 	int last, nr = 0, nr_pmdmapped = 0;
+	bool partially_mapped = false;
 	enum node_stat_item idx;
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
@@ -1515,6 +1516,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 					nr++;
 			}
 		} while (page++, --nr_pages > 0);
+
+		partially_mapped = !!nr && !!atomic_read(mapped);
 		break;
 	case RMAP_LEVEL_PMD:
 		atomic_dec(&folio->_large_mapcount);
@@ -1532,6 +1535,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 				nr = 0;
 			}
 		}
+
+		partially_mapped = nr < nr_pmdmapped;
 		break;
 	}
 
@@ -1553,9 +1558,10 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		 * page of the folio is unmapped and at least one page
 		 * is still mapped.
 		 */
-		if (folio_test_large(folio) && folio_test_anon(folio))
-			if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
-				deferred_split_folio(folio);
+		if (folio_test_anon(folio) &&
+		    list_empty(&folio->_deferred_list) &&
+		    partially_mapped)
+			deferred_split_folio(folio);
 	}
 
 	/*

base-commit: 3dba658670af22074cc6f26dc92efe0013ac3359
-- 
2.43.0


