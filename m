Return-Path: <linux-kernel+bounces-166508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9731B8B9BA6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F64283EC1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE73513C660;
	Thu,  2 May 2024 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="TQy9HzT3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W0/TJGy/"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8360283CCE
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656569; cv=none; b=S3BL54cwcW58E5awClJJ64666nWySXXbUXJMmtaS9JfQES20x25nBn27yXgGs0jpxyrEmYMKVu4OGj7rkjYqnunablS169z7GrN5/yyco9b4OsWf6u6ZK9ismFEf4AGMRahDD7leSUUH9Dwbe3/lp4eSoER4X8QcFieIXqpdw5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656569; c=relaxed/simple;
	bh=a2ZuJqadCEYdq2UhqFwgLpomA1VNzpeA+WRedgtm0Hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiHueAyNyCS6xEuG5YOYZ9JSX8kgtQPWeeqJuS9ZtBEY/2F2JC+E+7Cy5AubcN8tVFhDpe73uVJeAOFYm2BuBc3jDT08YA+6QqJBm55NuI2zXLVx/PpRcwASW705MokuUwrGmCPFIgykUi6a0hNlsemLzvkfH3mFWUpb0uAJM2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=TQy9HzT3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W0/TJGy/; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id D627C1C0013B;
	Thu,  2 May 2024 09:29:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 02 May 2024 09:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1714656565; x=1714742965; bh=TQdtp9gQ6B
	LDd977+sCpOX4jKxONWblKEhEd4WgTehk=; b=TQy9HzT3sNGOc9O+5R3BXvhfWm
	mp8PPjtg43ZF4gJ/rP1agU+usQmXl2wHiuW1J7X14hARufAR8WPzoR5HlN/5G8uo
	vokgdxFjRXJZOC4xmHzV09EB7WKSV0yhnikYp59D08hWl8rKur9TsKE9aKiUgKPj
	3BoWFXtagEputhToRTM/1FjlT2Lp6ysyFFuzJw7WjxU0qQyOvMABPTnDHtTUK0e9
	kFuxyB0oau+fPYgRAkVKgNM69TJITc+OwVIcfHx6R3Jj9Zn2m65K8b1w3Pes7K/7
	RoxZJERX2SXi1s9ur4rxqSxhKq9X2i1LKxIOkzhbznttJskF6CikwvFFTMMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1714656565; x=1714742965; bh=TQdtp9gQ6BLDd
	977+sCpOX4jKxONWblKEhEd4WgTehk=; b=W0/TJGy/zhCXq4uG8tdXhnZ9ObBAc
	pWpimSkr58lUKNgVCj6Kq6vmEm/Qj0+O2v/xSR+otlLGhQzkwlFiVRJR6JNTI/3t
	QONuGLHOkWt09if4FXHmdBf9tBfnm9uvfvpjIQivEZnPpjw0G6sXTIdWOgMo7fvs
	ZWJe/eCc5G0ZeS4rgpSK3VUBCX0qs30DMMheyzeaD1DZpTUlnvxkuuuU03kqYv9o
	e9575nfcFYzBbzjKPEXfmV1pAAbNL55ZlsnaZiP86NFQHdLjeNgCUithbhffZ13j
	oZhQy0I5tiszOesIA0Wk/0xOq613CPqvkQ64IsopGHgxw2XqPmuJvM6Qw==
X-ME-Sender: <xms:NZUzZjh1EQyJnapiYayK9IamgY-FU5PnURVVYw3O4UJos0gw94hGiQ>
    <xme:NZUzZgBVVbrkwcZNi-qCNkvsKB1Q06rxp4otmJzF0ZqsIE0xUIeT710jN4MfZlljF
    9eTnnpZYhmRXDUoeQ>
X-ME-Received: <xmr:NZUzZjGJE1QpuS5qHDdS_3n_pT1r-e1Bv6ynT8wroZVnlaiLNXbl0ui2JxMVv2rtK7f_u5MzHjxcxh2W3lyqyBJZFuZSn28LyPK6V8K0mQdMh5n2VbUSePij>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeffjeeuie
    efjedujedugfeitdefledtgfeufffhudelgfdtkeetkeefjeehkeehtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnh
    htrdgtohhm
X-ME-Proxy: <xmx:NZUzZgTcopV2RaLEIc58EEJqVfvcXj49abeJ84naop14wAjaIuU2UQ>
    <xmx:NZUzZgwK949v3rVpXnNjFestoo0Ppt5U5A25EimhkDW7hYfqS82ifA>
    <xmx:NZUzZm6rLGv62frGBG5XYweBwoRueIkNMyNDbFsEdqxYoDCz7Jh_FA>
    <xmx:NZUzZlxjD6S_pUvBiTEl03mB7Nkd9BHxbtE0Q1VWRXt9E7STnHiNIQ>
    <xmx:NZUzZq51HLyckmwQJf7bgpg3000yJLwZALFd1L8vSoi8kf-LeQd4uh0j>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 09:29:24 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Lance Yang <ioworker0@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>
Subject: [PATCH v6] mm/rmap: do not add fully unmapped large folio to deferred split list
Date: Thu,  2 May 2024 09:28:51 -0400
Message-ID: <20240502132852.862138-1-zi.yan@sent.com>
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
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Lance Yang <ioworker0@gmail.com>
---
 mm/rmap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 7cdb53380199..d5af687e2ad8 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1494,6 +1494,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
 	int last, nr = 0, nr_pmdmapped = 0;
+	bool partially_mapped = false;
 	enum node_stat_item idx;
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
@@ -1514,6 +1515,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 					nr++;
 			}
 		} while (page++, --nr_pages > 0);
+
+		partially_mapped = nr && atomic_read(mapped);
 		break;
 	case RMAP_LEVEL_PMD:
 		atomic_dec(&folio->_large_mapcount);
@@ -1531,6 +1534,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 				nr = 0;
 			}
 		}
+
+		partially_mapped = nr < nr_pmdmapped;
 		break;
 	}
 
@@ -1551,10 +1556,12 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		 * Queue anon large folio for deferred split if at least one
 		 * page of the folio is unmapped and at least one page
 		 * is still mapped.
+		 *
+		 * Check partially_mapped first to ensure it is a large folio.
 		 */
-		if (folio_test_large(folio) && folio_test_anon(folio))
-			if (level == RMAP_LEVEL_PTE || nr < nr_pmdmapped)
-				deferred_split_folio(folio);
+		if (folio_test_anon(folio) && partially_mapped &&
+		    list_empty(&folio->_deferred_list))
+			deferred_split_folio(folio);
 	}
 
 	/*
-- 
2.43.0


