Return-Path: <linux-kernel+bounces-50117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DC084747B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4EC296C17
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5711474D0;
	Fri,  2 Feb 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="v+j7jFd0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ab9ItWyz"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0577182BB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890579; cv=none; b=Vh/eeo9vUVaATxzB2ZSm0IpbdJnxjOo94kFkFo/+VM4cJQkZxhaYwnmqfYSQZVBd+qxV8qXD32dTzVY8kl7uY6NThqLp+C1fV4rtmTI08aNK9fxPaTltdNSd9m9nvJnuJ+QBWtx5i/WmGICwMeOmpxopwdBNNWa4Mqe72MCLZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890579; c=relaxed/simple;
	bh=9U1mw1yVdLk+BExwcI7S+DGgNlo8VhiS206YK4nSCvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ffRlq0R81Sksgu37oBfCLGYHwR//NmnFoqCdHFi8kb/Yk6wbI0d5z3coNKy3fnpw/smbTrsaOLEuPHgsujv6eELMnGN2K7A/qVdoAbW3vywSw81SlhBXLrNlloC5MBLBzwKK9hEC96824UokQVSd3PZsvtfBAmCJSWNaCZO7TZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=v+j7jFd0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ab9ItWyz; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id BC04B5C00D2;
	Fri,  2 Feb 2024 11:16:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 02 Feb 2024 11:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm3; t=1706890575; x=
	1706976975; bh=sbJRcJVhKwu3xlXdpvrqMPMBrNMkSAU2s2K/uCxEzpo=; b=v
	+j7jFd0c9xykrWBxQKHlC4Lqv0qDlusH0gSEzy613M7wiNQfNgJbMMliEDhadZ4D
	wznDUqevKp+erQefUvuQmR8nPV3azE5AOBEtIqZWSFOi9De/f+ODhs/dC7+L67WY
	DJza7+BsbL22h2J9kBBpm4Di1lFLOG1oleBrlf85ZzKsLEBcscTU8B7NbaW9kpVd
	0iwrzSqaxAQ3fd+qB5WZo7qBuyl74l5ffCJ35FRx0XSIopnKjvttFkI5027uCy6n
	fcwIjDYVM6lmy27TeH6pF2ZXxwVyYZ0W40gNcHorP4NDWeQkzPABKMpnW3ffWToa
	tqyGQEuVCAi8UZQGRauGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1706890575; x=1706976975; bh=s
	bJRcJVhKwu3xlXdpvrqMPMBrNMkSAU2s2K/uCxEzpo=; b=ab9ItWyzWsppQVL6B
	kO8yizKcNw9Lm/oTtpaUXiqXCNJfxb9arOTnXjqPyKrmwR5l9tSBHbk2S+E6K91A
	99Lw5ZxzXiqCzK23Dt2CH2sMDhmQtf56numXYBKZZO2mgJUKc/Xs774gY+ptKyDT
	5t/be3bkes1T1rjhy/BQ/Ayj5frlChhltWILSaixrwSrX40Psp5VA1oRxwY9t2d2
	irWpVI+4vbkHWfbRuanednL6+p18fyLueDomWY8ZS7fwsm4q4ffaQm701MjvzRoy
	xrfS/NbOVD/OC8va3EqfXH8ko+n+8oM5xZ2olY0L+6fVF3BMEbDkjA0WBxVBJMqL
	RliTg==
X-ME-Sender: <xms:TBW9ZVvEBg0dW1o8Cuq1ascnD1ic4KpJbONfVrzEeCXYqVn8D2BafQ>
    <xme:TBW9Zed4Jdb52ccDalelqPq5YAQgKoyCJNwRAJJP_F_KYTMb4gtXxRpuncE7yvLHH
    Gy7_l6OXaH-V1kkgA>
X-ME-Received: <xmr:TBW9ZYxc6JZxjwcCby0jjoRAEpGR2qCQzLsoYhCWO3TYlzb5LWvHib6f33-GFzEcMb0BH6zjhAG4OoU3gVcXlMGXVoWumWTTz_SDQxfWkNtDk9w8Flo6hybN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedugedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrgggtgfesthekredtredtjeenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepkefhle
    duhffhjedttdetudejtdeuieevueetuddtuedthffffffgueffhfegjeffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghdpfhholhhiohhsrdhmmhdptghomhhprggtthhiohhnrd
    hmmhdpshhplhhithdrmhhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepiihirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:TBW9ZcObCAJS52vSASK9qSYgP2XwmrVl9mEFla37meJuM5oNIehjgA>
    <xmx:TBW9ZV9Io4eTd5ZcqgcG1sw_h1MnFYFYX7OX6Na_z0o3OG4-vfYCIQ>
    <xmx:TBW9ZcXGBQ6tqs-zZC7-vcrW3BL32kIUYrN2Pgt_VsBRZ54yC_T-0g>
    <xmx:TxW9ZY1iqIoZ8jCEjHRhvgF7KGrU4haXx1pmeT9W_HWbYaNFP2OlYg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 11:16:11 -0500 (EST)
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
Subject: [PATCH v3 0/3] Enable >0 order folio memory compaction
Date: Fri,  2 Feb 2024 11:15:51 -0500
Message-ID: <20240202161554.565023-1-zi.yan@sent.com>
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
the prerequisitions for large folio support[1]. It includes the fix[4] for
V2 and is on top of mm-everything-2024-01-29-07-19.

I am aware of that split free pages is necessary for folio
migration in compaction, since if >0 order free pages are never split
and no order-0 free page is scanned, compaction will end prematurely due
to migration returns -ENOMEM. Free page split becomes a must instead of
an optimization.

lkp ncompare results for default LRU (-no-mglru) and CONFIG_LRU_GEN are
shown at the bottom (on a 8-CPU (Intel Xeon E5-2650 v4 @ 2.20GHz) 16G VM).
In sum, most of vm-scalability applications do not see performance change,
and the others see ~4% to ~26% performance boost under default LRU and
~2% to ~6% performance boost under CONFIG_LRU_GEN.


Changelog
===

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
Now all free pages are kept in a MAX_ORDER+1 array of page lists based
on their order without post allocation process. When migrate_pages() asks for
a new page, one of the free pages, based on the requested page order, is
then processed and given out.


Feel free to give comments and ask questions.

Thanks.

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



[1] https://lore.kernel.org/linux-mm/20230912162815.440749-1-zi.yan@sent.com/
[2] https://lore.kernel.org/linux-mm/20231113170157.280181-1-zi.yan@sent.com/
[3] https://lore.kernel.org/linux-mm/20240123034636.1095672-1-zi.yan@sent.com/
[4] https://lore.kernel.org/linux-mm/23BA8CC1-1014-4D09-9C33-938638E13C01@nvidia.com/

Zi Yan (3):
  mm/compaction: enable compacting >0 order folios.
  mm/compaction: add support for >0 order folio memory compaction.
  mm/compaction: optimize >0 order folio compaction with free page
    split.

 mm/compaction.c | 219 ++++++++++++++++++++++++++++++++++--------------
 mm/internal.h   |   9 +-
 mm/page_alloc.c |   6 ++
 3 files changed, 170 insertions(+), 64 deletions(-)

-- 
2.43.0


