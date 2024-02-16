Return-Path: <linux-kernel+bounces-69011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE06785836B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4337DB254D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A5E131724;
	Fri, 16 Feb 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="FZDfBj5s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JN2VGths"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6D433987
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103090; cv=none; b=R5P26V2ud/4XTjptrqliyYuy/RosaHPhGMEbBhoXn0d2TN+vkwNMjAjWpDMoz+rbsZ0LnCWL+gJMpwCX/nvwIj1x37fvWqhYrvrKSKNFGuzc+DKI+9sSPH3sQ9jc37iLvui39eK/q7J5ghd9+wIPcJEzUMNQhLTyu440tFLEQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103090; c=relaxed/simple;
	bh=ub6pqJApu3aHhSCW8ZP49OQ/OImP8xXZtrj2SLi+MBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SQRoytH9aKUNRaanoa0M8lpiTy4jugjllA67yKG6+PflgjnTaqOhysuoHYf3SvRniHIO24+11kijQOx6Hi9a/Z4OBoJiw6yrBC97jWH8lqX/JJEftfLuGo7IhQldZfK6YxQGtJruNCGX1QEOqC7re9IX3dXz+kMxk6iyDbPiAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=FZDfBj5s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JN2VGths; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 113095C003F;
	Fri, 16 Feb 2024 12:04:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 16 Feb 2024 12:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1708103087; x=
	1708189487; bh=ZH53TYSgqNLH2t7OXmnHBSODgAGrqTB8UB8RRzsq1uM=; b=F
	ZDfBj5sgL8sgcGN4il/GLNbtHrmWPLHRJpMnsPvygDN1X8dD4nsC5i5QWH/V9zo9
	wH2xpyuIrhxWiOImM4agTRiKVYfs1u4lmGbgZgUl2s0Z89OSwX9PbMo+iAveQE5/
	HajGEHiaMIMPH5DTK2Y79Zot5vXR6EX/rz1J06U9L2SNj7Q4Ff5DCHneH7sg4KSG
	2+cUnOIsYlAmigLCDnueiTqRlHZ5B8i2yZXZhwrgBJJTfM1YuH7XD2Gdvq/gmnTn
	76uwkuQuhG49HGl+OmlMrzha5AAzOy70oCFNoVpq80+QQ69vsUbi7X6im9Q6+cMd
	iu/ktFJq/G8eGSm+DeTag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1708103087; x=1708189487; bh=Z
	H53TYSgqNLH2t7OXmnHBSODgAGrqTB8UB8RRzsq1uM=; b=JN2VGthsx20KKIlYf
	9fqzmltovz9Bm4ed1Yy7kQ3IvxGjwWzRP48F5WU9JTeIE5pn22nvoPwaIu0Vdzs3
	7gi3nSit/os/8jvQ7wxIDT7tNELfMHgIrNze/29pBgbg7F/vBbQII/DkpFEPn1Yi
	CDTXPuKyAiX9qyF+jTb4f24qsaqTzxvZfLx0rLLlNqJLOYoHfm/FALOewdOTUGkt
	rh8Z6+zVwcm2kMc/2nLN5SwV4wEJlYd+YgusvaKA1wlAPkw4onKsT+D6wqMKERzo
	ffxEsEHqwAmX2s7Yr0phMx/nsQycFFjyaGfIZKeT1j31HoCqPKNSREs0/1WPaUv0
	YL8cw==
X-ME-Sender: <xms:qpXPZa6HPh-c1AF64CJp2oTpQgepg0CKyGUVmDw1Ayeao10pKUfD3w>
    <xme:qpXPZT415LtHl6zeDHFAUaum970X0PC1uUY4UjvtMprnM6KYUQo9TwvPIZvgYaK8y
    ruAF7IFb_7apuTQ_Q>
X-ME-Received: <xmr:qpXPZZe3iNhadhySCWIG-wpVvZP1ub5xXqJI7aFZ-maiSAaJIshUoqrzemQoFjEbk5_UJyPwdkWSmDOdwOeaouGNO-e3S9Ji2buQ0u8IBUMHd32ARSnjEDvR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkfforhggtgfgsehtkeertdertdejnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeekhfelud
    fhhfejtddttedujedtueeiveeutedutdeutdfhffffgfeufffhgeejffenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdhfohhlihhoshdrmhhmpdgtohhmphgrtghtihhonhdrmh
    hmpdhsphhlihhtrdhmmhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:qpXPZXJBP33woB6L5OkHCPS_ZzYH0EN4jabbUl2C4FWnp0e42EBvAw>
    <xmx:qpXPZeINF5Z9Adidw5cuoOK56L4Hg1nH3C7YWutsFnaKTrGr4gZqAw>
    <xmx:qpXPZYyRiOdRwvdDPjOLor42GHmJSWB4dpenyeq82HnwagUsHs0vog>
    <xmx:r5XPZTC0plhXSZT-ytjmeZRwweQTscAKCqUl3jgfld-3bwjBNgPlYw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 12:04:41 -0500 (EST)
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
Subject: [PATCH v6 0/4] Enable >0 order folio memory compaction
Date: Fri, 16 Feb 2024 12:04:28 -0500
Message-ID: <20240216170432.1268753-1-zi.yan@sent.com>
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

Hi all,

This patchset enables >0 order folio memory compaction, which is one of
the prerequisitions for large folio support[1]. It is on top of
mm-everything-2024-02-16-01-35.

I am aware of that split free pages is necessary for folio
migration in compaction, since if >0 order free pages are never split
and no order-0 free page is scanned, compaction will end prematurely due
to migration returns -ENOMEM. Free page split becomes a must instead of
an optimization.

lkp ncompare results (on a 8-CPU (Intel Xeon E5-2650 v4 @2.20GHz) 16G VM)
for default LRU (-no-mglru) and CONFIG_LRU_GEN are shown at the bottom,
copied from V3[4].
In sum, most of vm-scalability applications do not see performance
change, and the others see ~4% to ~26% performance boost under default LRU
and ~2% to ~6% performance boost under CONFIG_LRU_GEN.


Changelog
===

From V5 [6]
1. Removed unused parameter in prepare_free_pages() and used it instead
of my old prepare_free_pages_fpi_none() (per Vlastimil Babka).

2. Removed unnecessary INIT_LIST_HEAD() in compaction_free()
(per Vlastimil Babka).

3. Fixed cc->nr_migratepages update in compaction_free()
(per Vlastimil Babka).


From V4 [5]:
1. Refactored code in compaction_alloc() in Patch 3 (per Yu Zhao).


From V3 [4]:
1. Restructured isolate_migratepages_block() to minimize PageHuge() use
in Patch 1 (per Vlastimil Babka).

2. Used folio_put_testzero() instead of folio_set_count() to properly
handle free pages in compaction_free() (per Vlastimil Babka).

3. Simplified code to use struct list_head instead of a new struct page_list
(per Vlastimil Babka).

4. Restructured compaction_alloc() code to reduce indentation and
increase readability (per Vlastimil Babka).


From V2 [3]:
1. Added missing free page count in fast isolation path. This fixed the
weird performance outcome.


From V1 [2]:
1. Used folio_test_large() instead of folio_order() > 0. (per Matthew
Wilcox)

2. Fixed code rebase error. (per Baolin Wang)

3. Used list_split_init() instead of list_split(). (per Ryan Boberts)

4. Added free_pages_prepare_fpi_none() to avoid duplicate free page code
in compaction_free().

5. Dropped source page order sorting patch.


From RFC [1]:
1. Enabled >0 order folio compaction in the first patch by splitting all
to-be-migrated folios. (per Huang, Ying)

2. Stopped isolating compound pages with order greater than cc->order
to avoid wasting effort, since cc->order gives a hint that no free pages
with order greater than it exist, thus migrating the compound pages will fail.
(per Baolin Wang)

3. Retained the folio check within lru lock. (per Baolin Wang)

4. Made isolate_freepages_block() generate order-sorted multi lists.
(per Johannes Weiner)

Overview
===

To support >0 order folio compaction, the patchset changes how free pages used
for migration are kept during compaction. Free pages used to be split into
order-0 pages that are post allocation processed (i.e., PageBuddy flag cleared,
page order stored in page->private is zeroed, and page reference is set to 1).
Now all free pages are kept in a NR_PAGE_ORDER array of page lists based
on their order without post allocation process. When migrate_pages() asks for
a new page, one of the free pages, based on the requested page order, is
then processed and given out. And THP <2MB would need this feature.


Feel free to give comments and ask questions.

Thanks.

[1] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/
[2] https://lore.kernel.org/linux-mm/20231113170157.280181-1-zi.yan@sent.com/
[3] https://lore.kernel.org/linux-mm/20240123034636.1095672-1-zi.yan@sent.com/
[4] https://lore.kernel.org/linux-mm/20240202161554.565023-1-zi.yan@sent.com/
[5] https://lore.kernel.org/linux-mm/20240212163510.859822-1-zi.yan@sent.com/
[6] https://lore.kernel.org/linux-mm/20240214220420.1229173-1-zi.yan@sent.com/


Hi Andrew,

Baolin's patch on nr_migratepages was based on this one, a better fixup
for it might be below. Since before my patchset, compaction only deals with
order-0 pages.

diff --git a/mm/compaction.c b/mm/compaction.c
index 01ec85cfd623f..e60135e2019d6 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1798,7 +1798,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
 	dst = list_entry(cc->freepages.next, struct folio, lru);
 	list_del(&dst->lru);
 	cc->nr_freepages--;
-	cc->nr_migratepages -= 1 << order;
+	cc->nr_migratepages--;
 
 	return dst;
 }
@@ -1814,7 +1814,7 @@ static void compaction_free(struct folio *dst, unsigned long data)
 
 	list_add(&dst->lru, &cc->freepages);
 	cc->nr_freepages++;
-	cc->nr_migratepages += 1 << order;
+	cc->nr_migratepages++;
 }


vm-scalability results on CONFIG_LRU_GEN
===

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19+
  6.8.0-rc1-split-folio-in-compaction+
  6.8.0-rc1-folio-migration-in-compaction+
  6.8.0-rc1-folio-migration-free-page-split+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  15107616            +3.2%   15590339            +1.3%   15297619            +3.0%   15567998        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19+
  6.8.0-rc1-split-folio-in-compaction+
  6.8.0-rc1-folio-migration-in-compaction+
  6.8.0-rc1-folio-migration-free-page-split+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  12611785            +1.8%   12832919            +0.9%   12724223            +1.6%   12812682        vm-scalability.throughput


=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19+
  6.8.0-rc1-split-folio-in-compaction+
  6.8.0-rc1-folio-migration-in-compaction+
  6.8.0-rc1-folio-migration-free-page-split+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   9833393            +5.7%   10390190            +3.0%   10126606            +5.9%   10408804        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19+
  6.8.0-rc1-split-folio-in-compaction+
  6.8.0-rc1-folio-migration-in-compaction+
  6.8.0-rc1-folio-migration-free-page-split+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   7034709 ±  3%      +2.9%    7241429            +3.2%    7256680 ±  2%      +3.9%    7308375        vm-scalability.throughput



vm-scalability results on default LRU (with -no-mglru suffix)
===

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
  6.8.0-rc1-split-folio-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-free-page-split-no-mglru+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  14401491            +3.7%   14940270            +2.4%   14748626            +4.0%   14975716        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
  6.8.0-rc1-split-folio-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-free-page-split-no-mglru+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  11407497            +5.1%   11989632            -0.5%   11349272            +4.8%   11957423        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq-mt/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
  6.8.0-rc1-split-folio-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-free-page-split-no-mglru+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
  11348474            +3.3%   11719453            -1.2%   11208759            +3.7%   11771926        vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
  6.8.0-rc1-split-folio-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-free-page-split-no-mglru+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   8065614 ±  3%      +7.7%    8686626 ±  2%      +5.0%    8467577 ±  4%     +11.8%    9016077 ±  2%  vm-scalability.throughput

=========================================================================================
compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
  gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalability

commit: 
  6.8.0-rc1-mm-everything-2024-01-29-07-19-no-mglru+
  6.8.0-rc1-split-folio-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-in-compaction-no-mglru+
  6.8.0-rc1-folio-migration-free-page-split-no-mglru+

6.8.0-rc1-mm-eve 6.8.0-rc1-split-folio-in-co 6.8.0-rc1-folio-migration-i 6.8.0-rc1-folio-migration-f 
---------------- --------------------------- --------------------------- --------------------------- 
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \  
   6438422 ±  2%     +27.5%    8206734 ±  2%     +10.6%    7118390           +26.2%    8127192 ±  4%  vm-scalability.throughput

Zi Yan (4):
  mm/page_alloc: remove unused fpi_flags in free_pages_prepare()
  mm/compaction: enable compacting >0 order folios.
  mm/compaction: add support for >0 order folio memory compaction.
  mm/compaction: optimize >0 order folio compaction with free page
    split.

 mm/compaction.c | 225 ++++++++++++++++++++++++++++++++----------------
 mm/internal.h   |   4 +-
 mm/page_alloc.c |  12 +--
 3 files changed, 162 insertions(+), 79 deletions(-)

-- 
2.43.0


