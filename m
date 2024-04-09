Return-Path: <linux-kernel+bounces-137633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60EA89E4D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E160E1C21C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF272158869;
	Tue,  9 Apr 2024 21:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4ur4G/Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1E15886D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697376; cv=none; b=sEx+1x8p2iJRtu3CpjTKY0cyViU2gt4NAKwufV/mFGmWB4ltpPTkWOcOffmtki58NyKwwcX8AMtFPWyq2EyUjE7LBw8QW1Pv8nibnPbzt2+3EdjxoQuyJGmIxXQgDVQRbnJoXrhFPKOLvVMcMKv5cVW5Msf0X3IM8fGSCKzom/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697376; c=relaxed/simple;
	bh=a6ygL+/fUwPck1ccv8s7ruzmTryeKbeD8k2zVjh+OOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPxSyAQByDleQfUx8hdLHdFyVRrTGV9u5wjHoPlp/K08nYuKdEDZMnAXHUjvIBrWB1QJ9M1wu/v7VaZsu8rGbha7SHKOj/q/wZqTnE2hfvEOlI/QLf9/DmPIfNQhuBTGr0nTbkkban77fm4+gH5nIwekkFHkyQ3TAgvBnma8rvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4ur4G/Z; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712697375; x=1744233375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a6ygL+/fUwPck1ccv8s7ruzmTryeKbeD8k2zVjh+OOM=;
  b=N4ur4G/Zm+0UQIR3Pp94ta2zMoLsWdad8I8GCKx76fWlVu7WurWjiNrI
   R3nM52wdMqvZMt0Wwdr5Kmt10LP0I2lQB9fdtCgJbEDNsgHLLBb9E1h3m
   MAUUbQZjZ6NAResCTY2FCdeJtMLN0YnvdhyBwFjqoU8M7M/Hprk31dSVa
   qFCeHI/yg/eQ2ZdXQFSRPmfUjDaWmd/lCO/gOe1IuJ6Sw4gEQ2m6J0DJM
   lf4C6v9xSMsitTi+ntCUpU4gL7VxQoyox81S+CE8DcOcq0HlKFaf16Q+i
   y0uoYQMhEXwXCc57OTw/vi2Cylj+uifzKf/T+Eh6r3l7IgQGUszP7yW56
   Q==;
X-CSE-ConnectionGUID: luVb+MPNTkW7wjUVEzKs1w==
X-CSE-MsgGUID: vwE4gwq3QuqqoWaM+2cYxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7907331"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7907331"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 14:16:06 -0700
X-CSE-ConnectionGUID: 2twYPn6RTra1WZAfOA0uwA==
X-CSE-MsgGUID: niUwqrdZQQy2XgiiTH0liw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20454084"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Apr 2024 14:16:02 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruIoy-0006W0-1c;
	Tue, 09 Apr 2024 21:16:00 +0000
Date: Wed, 10 Apr 2024 05:15:01 +0800
From: kernel test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, vbabka@suse.cz
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
	david@redhat.com, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mgorman@techsingularity.net,
	ying.huang@intel.com, ziy@nvidia.com
Subject: Re: [PATCH] mm: page_alloc: consolidate free page accounting fix 3
Message-ID: <202404100519.mVXXF6kV-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240410/202404100519.mVXXF6kV-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240410/202404100519.mVXXF6kV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404100519.mVXXF6kV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/page_alloc.c:808:54: error: too few arguments to function call, expected 4, have 3
     808 |                         account_freepages(zone, -(1 << order), migratetype);
         |                         ~~~~~~~~~~~~~~~~~                                 ^
   mm/page_alloc.c:645:20: note: 'account_freepages' declared here
     645 | static inline void account_freepages(struct page *page, struct zone *zone,
         |                    ^                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     646 |                                      int nr_pages, int migratetype)
         |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +808 mm/page_alloc.c

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

