Return-Path: <linux-kernel+bounces-7597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BF981AAB4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A96FBB22842
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645D1768E3;
	Wed, 20 Dec 2023 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glIkorBz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1D6F63B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703112393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFfPUjt3XA3pNIs6QrEG4XUFOfbPY73VNaCA30/uDMs=;
	b=glIkorBzHHm3wxLvNbj8Sq3yuZWs/IaAT+Jf+MP8778vd031IZC2ZVxPeRDdxrf0/hNi1m
	TiKXVnU/JcNq2aOi2zXYnlaGX5yDRYskfC2wSox/GhOgJRUn3BpMu8f6JFX4GAPv3t0uBG
	+flm0sv0E+1hjiKiEpNAOgPs83eqScc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-eYmFnTyfNBSFscisqBgv4Q-1; Wed, 20 Dec 2023 17:46:29 -0500
X-MC-Unique: eYmFnTyfNBSFscisqBgv4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC44F848C06;
	Wed, 20 Dec 2023 22:46:28 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0429440C6EB9;
	Wed, 20 Dec 2023 22:46:25 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 31/40] Documentation: stop referring to page_remove_rmap()
Date: Wed, 20 Dec 2023 23:44:55 +0100
Message-ID: <20231220224504.646757-32-david@redhat.com>
In-Reply-To: <20231220224504.646757-1-david@redhat.com>
References: <20231220224504.646757-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Refer to folio_remove_rmap_*() instaed.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/transhuge.rst       | 2 +-
 Documentation/mm/unevictable-lru.rst | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index 9a607059ea11c..cf81272a6b8b6 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -156,7 +156,7 @@ Partial unmap and deferred_split_folio()
 
 Unmapping part of THP (with munmap() or other way) is not going to free
 memory immediately. Instead, we detect that a subpage of THP is not in use
-in page_remove_rmap() and queue the THP for splitting if memory pressure
+in folio_remove_rmap_*() and queue the THP for splitting if memory pressure
 comes. Splitting will free up unused subpages.
 
 Splitting the page right away is not an option due to locking context in
diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
index 67f1338440a50..b6a07a26b10d5 100644
--- a/Documentation/mm/unevictable-lru.rst
+++ b/Documentation/mm/unevictable-lru.rst
@@ -486,7 +486,7 @@ munlock the pages if we're removing the last VM_LOCKED VMA that maps the pages.
 Before the unevictable/mlock changes, mlocking did not mark the pages in any
 way, so unmapping them required no processing.
 
-For each PTE (or PMD) being unmapped from a VMA, page_remove_rmap() calls
+For each PTE (or PMD) being unmapped from a VMA, folio_remove_rmap_*() calls
 munlock_vma_folio(), which calls munlock_folio() when the VMA is VM_LOCKED
 (unless it was a PTE mapping of a part of a transparent huge page).
 
@@ -511,7 +511,7 @@ userspace; truncation even unmaps and deletes any private anonymous pages
 which had been Copied-On-Write from the file pages now being truncated.
 
 Mlocked pages can be munlocked and deleted in this way: like with munmap(),
-for each PTE (or PMD) being unmapped from a VMA, page_remove_rmap() calls
+for each PTE (or PMD) being unmapped from a VMA, folio_remove_rmap_*() calls
 munlock_vma_folio(), which calls munlock_folio() when the VMA is VM_LOCKED
 (unless it was a PTE mapping of a part of a transparent huge page).
 
-- 
2.43.0


