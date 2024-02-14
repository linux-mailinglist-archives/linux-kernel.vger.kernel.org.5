Return-Path: <linux-kernel+bounces-66020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2248485557E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E771F268DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9969A141991;
	Wed, 14 Feb 2024 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="izcQoDo4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZQBnfXQD"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E1613EFE3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948279; cv=none; b=dRN9YPzdI7L+HZwJc0qfhlx+UWFjHg4ACkui9rUCNrkPeXXP5fozhi1WjpYl25Y5bHmabp/erbwdwYxNDtvKb78TwpbBeDbPjAkkWRF7uRzjt0WSV2ORlF6eE775++fUcqfJJ4Xc4vL9xlHRCRrNFwu/O7hSi4pP3q914HaNey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948279; c=relaxed/simple;
	bh=sT1m4xrlflxr+wpBQ5EhTVM2n7mryAIVqTcH9u/C28Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h3u1WRkLa9nz0x9vpEMGcvZaYmVlboE0EeCbLAXcIEQBFgpvneuWSRBBz3mBB8c9WxveLJI76EFg7lhpYing0Z6SqZi6Ntovfz7L21SDjwry+odtV6AZ4iOviVFqaVoteqavVfu7HB4njRQ0yuaAzjLJv1D/UnHVV6HgKfEtU5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=izcQoDo4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZQBnfXQD; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 5EE695C007A;
	Wed, 14 Feb 2024 17:04:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 14 Feb 2024 17:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm3; t=1707948275; x=
	1708034675; bh=FLwv36N4JKiq4wnyHVBcw5/XWap3P8OzOgvWGQunOZ4=; b=i
	zcQoDo4dVb0yycCv+BRx9EeG7896mK7MhSZ3igmQ11IbJYMyurNGCuaTEBYr+5S/
	Ord1k9Ktuyycdy7felSfHxKIEKlSM0SYznG3lDhxYKvD9M6qLjxghSVhnfF2BpFc
	Czqu6+Ew+x2ps9dnkqVtjyxmCB0Ms/0fr7y0ZjZDHAywbZYyCDS0JVUB+vyn3Ghq
	RBwnapx3lB+W9N+fgTly9ujjcqcvmRO9LsXRKe6eXWruZ7IsH850u/VOT3mIqbYC
	7K2TmUL+PfZBaPvj2BuZ+/NIedAJlRNwp3lD0k3u4VkKuybrpUEEBHd/SIRP9+HS
	N4vi/szRw6a/akX044qPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1707948275; x=1708034675; bh=F
	Lwv36N4JKiq4wnyHVBcw5/XWap3P8OzOgvWGQunOZ4=; b=ZQBnfXQDJLuKIZEpl
	uD/b1MHbh37U8esZHmFbeniuQaB8SnjjIA4bQEo8Q/ONYaHcS9saORCG1uT8bveT
	o27/XGx0Hlj+ZCdiXFVJLiluvpnFTqsn2AQGNoVP/UTSIk4eA95gnav7BC7rbbuY
	3C6iifMwqSevWS4pDTUOwqmeHV9oAldtSXTUcCoH83q1iIpwc/vY3uNfRvBAd1qB
	64lRE0/d6bqVdCQarGQrCZbpcxX+JXz+SW71h+VepGPaX3JvlBCEzzCXwtQ8Ylix
	eaC9RRWeF7QZB4JA2vGuf0S045V0/Bb++Mt1FErkosTtszlcwX8sIPtImBMEEF4f
	BW8WQ==
X-ME-Sender: <xms:8TjNZQ8vZxWO9w_NR00ECHuyiruLde9F2dCmMdwBaw1jyHKZleFGAg>
    <xme:8TjNZYufAH0QgRRfda40h6zWb-WkHKpFX6HXFh1l6L4jkHiwZb3aUHm6iJtXmbwzi
    RPJoBwoohns9QrDLA>
X-ME-Received: <xmr:8TjNZWAoH15E46tq2UVsz0-LUbYOKxRwipRgvsblfFPE6EvPXAY5DNsxQ6r1gQubdqpp1DeeOwUyTJrR1BOUYCyTuR0t00oQ-L8KHTHgk3IYfLFxmVrIQKId>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrgggtgfesthekredtredtjeenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepkefhle
    duhffhjedttdetudejtdeuieevueetuddtuedthffffffgueffhfegjeffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpfhholhhiohhsrdhmmhdptghomhhprggtthhiohhnrd
    hmmhdpshhplhhithdrmhhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:8TjNZQfd7c6-uMTUnK-PhZQyAfQu8cTYzf8OF8AH4DCDZ99Rhw12rg>
    <xmx:8TjNZVMqk-DQPSNFUTU5B_fBbBK-F38ddZZSd9Al-7Gb7bS_PQvVQg>
    <xmx:8TjNZakzGlaB-fMeqUbaUyO3zwE0cpW3T0V1J9yCPl91XbZ_-O5W8w>
    <xmx:8zjNZQEUwwbIPi_GiNC2wVu8Ykc70SKClJ7QLb6O_I3b2yu6cMa5BQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 17:04:32 -0500 (EST)
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
Subject: [PATCH v5 0/3] Enable >0 order folio memory compaction
Date: Wed, 14 Feb 2024 17:04:17 -0500
Message-ID: <20240214220420.1229173-1-zi.yan@sent.com>
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
mm-everything-2024-02-14-21-42.

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

Zi Yan (3):
  mm/compaction: enable compacting >0 order folios.
  mm/compaction: add support for >0 order folio memory compaction.
  mm/compaction: optimize >0 order folio compaction with free page
    split.

 mm/compaction.c | 228 +++++++++++++++++++++++++++++++++---------------
 mm/internal.h   |   4 +-
 mm/page_alloc.c |   6 ++
 3 files changed, 165 insertions(+), 73 deletions(-)

-- 
2.43.0


