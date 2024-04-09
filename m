Return-Path: <linux-kernel+bounces-137643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D9089E4EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EFF1C21CC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688B7158A09;
	Tue,  9 Apr 2024 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e83aJcZs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57775158878
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697970; cv=none; b=k3Od/3dOt1Dmyug2UuOTfjgLESCtc7SYbo2gl+5CgwVkIAgikUAF2Cln0ooJBRrRe+doGsIiY4junzn+74nfQflbDBHd7IPTNrlQfxJCmWPIjiyWgDw73lO/vrYEe4LcViNKvdVmMYHVbJ46cCCWV9H5F3s6eUoH3ZFBavzQlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697970; c=relaxed/simple;
	bh=MFUk7Q9DxQTw0mb3PytFtmo806xH8/pvPs/dX/4GHK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+sE9Gvi/7UWuATLIdZE1A8ey4YdqW2X0/hjMmts8CpxWoVNyXlUanzlNm51cFwWnSiwqx1/Df/ZVLmtC7uh/SfnfMQHajpR8aafhC5h5vG+0O9v4TL6kjjznotWimSF2jpF190GYhptLq76HAQhoq/WHWAPoVR5VLkQGe7kQw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e83aJcZs; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712697968; x=1744233968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MFUk7Q9DxQTw0mb3PytFtmo806xH8/pvPs/dX/4GHK4=;
  b=e83aJcZsIN+obney+phJav3yQpt5E2vsGLp0/MyQVaivDRGJCIbaiEqj
   p27RHwRj6FHw46prdq2bGWdLX/tfvCCKjeGQQaTO+UopnVbe+t3g418QC
   NiuO5pUoMxe09RZxRW9vJG+rBOqeoqIt4trr0eVNLLrXJ3LqCTs7IEfBz
   +tkTy0HMLGIe4mLBIcKPTR3AcQZlCqfeLOkcJ7wQmmSITV4k4m1mtkUlm
   +TsqF1zkG/jKfVTzaqk/W8ZOfLYxL7PJ7g80YaA33aCLnL34m8MS7Yz9G
   cCoy/zmp0kdHEAn8igxYN8d1YlEV318wafYhxgNd6a8aDJnTQi+YaxnM8
   Q==;
X-CSE-ConnectionGUID: c/60H8L9SN6tSZp9IhGNyw==
X-CSE-MsgGUID: jW2kDvZNSwKKWOzbdnqFtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8263512"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8263512"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 14:26:07 -0700
X-CSE-ConnectionGUID: 3fcwSMP5SCCrJQ5i+fjp0g==
X-CSE-MsgGUID: 4dkKLevxRam9bt9qC4DHcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25146249"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 09 Apr 2024 14:26:04 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruIye-0006WY-2h;
	Tue, 09 Apr 2024 21:26:00 +0000
Date: Wed, 10 Apr 2024 05:25:14 +0800
From: kernel test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, vbabka@suse.cz
Cc: oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com, david@redhat.com, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mgorman@techsingularity.net, ying.huang@intel.com, ziy@nvidia.com
Subject: Re: [PATCH] mm: page_alloc: consolidate free page accounting fix 3
Message-ID: <202404100551.aq0YQFuT-lkp@intel.com>
References: <a2a48baca69f103aa431fd201f8a06e3b95e203d.1712648441.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2a48baca69f103aa431fd201f8a06e3b95e203d.1712648441.git.baolin.wang@linux.alibaba.com>

Hi Baolin,

kernel test robot noticed the following build errors:



url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20240409-154935/Johannes-Weiner/mm-page_alloc-remove-pcppage-migratetype-caching/20240321-020814
base:   the 10th patch of https://lore.kernel.org/r/20240320180429.678181-11-hannes%40cmpxchg.org
patch link:    https://lore.kernel.org/r/a2a48baca69f103aa431fd201f8a06e3b95e203d.1712648441.git.baolin.wang%40linux.alibaba.com
patch subject: [PATCH] mm: page_alloc: consolidate free page accounting fix 3
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240410/202404100551.aq0YQFuT-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404100551.aq0YQFuT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404100551.aq0YQFuT-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   mm/page_alloc.c: In function '__free_one_page':
>> mm/page_alloc.c:808:43: error: passing argument 1 of 'account_freepages' from incompatible pointer type [-Werror=incompatible-pointer-types]
     808 |                         account_freepages(zone, -(1 << order), migratetype);
         |                                           ^~~~
         |                                           |
         |                                           struct zone *
   mm/page_alloc.c:645:51: note: expected 'struct page *' but argument is of type 'struct zone *'
     645 | static inline void account_freepages(struct page *page, struct zone *zone,
         |                                      ~~~~~~~~~~~~~^~~~
>> mm/page_alloc.c:808:49: warning: passing argument 2 of 'account_freepages' makes pointer from integer without a cast [-Wint-conversion]
     808 |                         account_freepages(zone, -(1 << order), migratetype);
         |                                                 ^~~~~~~~~~~~~
         |                                                 |
         |                                                 int
   mm/page_alloc.c:645:70: note: expected 'struct zone *' but argument is of type 'int'
     645 | static inline void account_freepages(struct page *page, struct zone *zone,
         |                                                         ~~~~~~~~~~~~~^~~~
>> mm/page_alloc.c:808:25: error: too few arguments to function 'account_freepages'
     808 |                         account_freepages(zone, -(1 << order), migratetype);
         |                         ^~~~~~~~~~~~~~~~~
   mm/page_alloc.c:645:20: note: declared here
     645 | static inline void account_freepages(struct page *page, struct zone *zone,
         |                    ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/account_freepages +808 mm/page_alloc.c

   759	
   760	/*
   761	 * Freeing function for a buddy system allocator.
   762	 *
   763	 * The concept of a buddy system is to maintain direct-mapped table
   764	 * (containing bit values) for memory blocks of various "orders".
   765	 * The bottom level table contains the map for the smallest allocatable
   766	 * units of memory (here, pages), and each level above it describes
   767	 * pairs of units from the levels below, hence, "buddies".
   768	 * At a high level, all that happens here is marking the table entry
   769	 * at the bottom level available, and propagating the changes upward
   770	 * as necessary, plus some accounting needed to play nicely with other
   771	 * parts of the VM system.
   772	 * At each level, we keep a list of pages, which are heads of continuous
   773	 * free pages of length of (1 << order) and marked with PageBuddy.
   774	 * Page's order is recorded in page_private(page) field.
   775	 * So when we are allocating or freeing one, we can derive the state of the
   776	 * other.  That is, if we allocate a small block, and both were
   777	 * free, the remainder of the region must be split into blocks.
   778	 * If a block is freed, and its buddy is also free, then this
   779	 * triggers coalescing into a block of larger size.
   780	 *
   781	 * -- nyc
   782	 */
   783	
   784	static inline void __free_one_page(struct page *page,
   785			unsigned long pfn,
   786			struct zone *zone, unsigned int order,
   787			int migratetype, fpi_t fpi_flags)
   788	{
   789		struct capture_control *capc = task_capc(zone);
   790		unsigned long buddy_pfn = 0;
   791		unsigned long combined_pfn;
   792		struct page *buddy;
   793		bool to_tail;
   794	
   795		VM_BUG_ON(!zone_is_initialized(zone));
   796		VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
   797	
   798		VM_BUG_ON(migratetype == -1);
   799		VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
   800		VM_BUG_ON_PAGE(bad_range(zone, page), page);
   801	
   802		account_freepages(page, zone, 1 << order, migratetype);
   803	
   804		while (order < MAX_PAGE_ORDER) {
   805			int buddy_mt = migratetype;
   806	
   807			if (compaction_capture(capc, page, order, migratetype)) {
 > 808				account_freepages(zone, -(1 << order), migratetype);
   809				return;
   810			}
   811	
   812			buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
   813			if (!buddy)
   814				goto done_merging;
   815	
   816			if (unlikely(order >= pageblock_order)) {
   817				/*
   818				 * We want to prevent merge between freepages on pageblock
   819				 * without fallbacks and normal pageblock. Without this,
   820				 * pageblock isolation could cause incorrect freepage or CMA
   821				 * accounting or HIGHATOMIC accounting.
   822				 */
   823				buddy_mt = get_pfnblock_migratetype(buddy, buddy_pfn);
   824	
   825				if (migratetype != buddy_mt &&
   826				    (!migratetype_is_mergeable(migratetype) ||
   827				     !migratetype_is_mergeable(buddy_mt)))
   828					goto done_merging;
   829			}
   830	
   831			/*
   832			 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
   833			 * merge with it and move up one order.
   834			 */
   835			if (page_is_guard(buddy))
   836				clear_page_guard(zone, buddy, order);
   837			else
   838				__del_page_from_free_list(buddy, zone, order, buddy_mt);
   839	
   840			if (unlikely(buddy_mt != migratetype)) {
   841				/*
   842				 * Match buddy type. This ensures that an
   843				 * expand() down the line puts the sub-blocks
   844				 * on the right freelists.
   845				 */
   846				set_pageblock_migratetype(buddy, migratetype);
   847			}
   848	
   849			combined_pfn = buddy_pfn & pfn;
   850			page = page + (combined_pfn - pfn);
   851			pfn = combined_pfn;
   852			order++;
   853		}
   854	
   855	done_merging:
   856		set_buddy_order(page, order);
   857	
   858		if (fpi_flags & FPI_TO_TAIL)
   859			to_tail = true;
   860		else if (is_shuffle_order(order))
   861			to_tail = shuffle_pick_tail();
   862		else
   863			to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
   864	
   865		__add_to_free_list(page, zone, order, migratetype, to_tail);
   866	
   867		/* Notify page reporting subsystem of freed page */
   868		if (!(fpi_flags & FPI_SKIP_REPORT_NOTIFY))
   869			page_reporting_notify_free(order);
   870	}
   871	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

