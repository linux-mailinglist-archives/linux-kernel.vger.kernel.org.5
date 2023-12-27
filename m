Return-Path: <linux-kernel+bounces-11812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3192B81EBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E73A2835EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67E95251;
	Wed, 27 Dec 2023 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RATYnzM8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13243C24
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703649545; x=1735185545;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=3QqcW5GZlKbgkMMujG/NbpfadY6DxeD381BQIfAdEck=;
  b=RATYnzM8Ve+heaY8bP8ceWVRZrS0G223UfP65y1SsZHQHtgXCyHlrnHl
   hNGPgS/pW7U9b1K7keZRMcCU/9oaN1JBRoTKDARvATtJ34IRWI6kSnoQ5
   ZrtYnA1qR0fgngSlY0uu0EzBGogDrXY+foVfdkiHcuGDQ/J0aa2KgoQOv
   eo/qEndZyff+NaQB+AGkOm65DhXgAvuH6BpyihV4kQynH2YA0Dt7Pv/so
   yDNaR+JG963+nRfXtznplfk40+991xFYm4oEwnnrFS0oq2bZC1GMDssya
   cQhHqtzTgu0ZMiV6P6qcMUTkizmh+Cqh+ENl31WroKEC7+mpmGN3NExG3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="427575940"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="427575940"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 19:59:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="771326296"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="771326296"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Dec 2023 19:59:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIL4N-000F3J-2h;
	Wed, 27 Dec 2023 03:59:00 +0000
Date: Wed, 27 Dec 2023 11:58:34 +0800
From: kernel test robot <lkp@intel.com>
To: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: kernel/power/snapshot.c:982: warning: Function parameter or member
 'start_pfn' not described in 'register_nosave_region'
Message-ID: <202312271114.jpz92bN9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
commit: 33569ef3c754a82010f266b7b938a66a3ccf90a4 PM: hibernate: Remove register_nosave_region_late()
date:   1 year, 11 months ago
config: x86_64-randconfig-x066-20230529 (https://download.01.org/0day-ci/archive/20231227/202312271114.jpz92bN9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231227/202312271114.jpz92bN9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312271114.jpz92bN9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/power/snapshot.c:330: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Data types related to memory bitmaps.
   kernel/power/snapshot.c:438: warning: Function parameter or member 'gfp_mask' not described in 'alloc_rtree_node'
   kernel/power/snapshot.c:438: warning: Function parameter or member 'safe_needed' not described in 'alloc_rtree_node'
   kernel/power/snapshot.c:438: warning: Function parameter or member 'ca' not described in 'alloc_rtree_node'
   kernel/power/snapshot.c:438: warning: Function parameter or member 'list' not described in 'alloc_rtree_node'
   kernel/power/snapshot.c:463: warning: Function parameter or member 'zone' not described in 'add_rtree_block'
   kernel/power/snapshot.c:463: warning: Function parameter or member 'gfp_mask' not described in 'add_rtree_block'
   kernel/power/snapshot.c:463: warning: Function parameter or member 'safe_needed' not described in 'add_rtree_block'
   kernel/power/snapshot.c:463: warning: Function parameter or member 'ca' not described in 'add_rtree_block'
   kernel/power/snapshot.c:536: warning: Function parameter or member 'gfp_mask' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:536: warning: Function parameter or member 'safe_needed' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:536: warning: Function parameter or member 'ca' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:536: warning: Function parameter or member 'start' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:536: warning: Function parameter or member 'end' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:571: warning: Function parameter or member 'zone' not described in 'free_zone_bm_rtree'
   kernel/power/snapshot.c:571: warning: Function parameter or member 'clear_nosave_free' not described in 'free_zone_bm_rtree'
   kernel/power/snapshot.c:678: warning: Function parameter or member 'bm' not described in 'memory_bm_create'
   kernel/power/snapshot.c:678: warning: Function parameter or member 'gfp_mask' not described in 'memory_bm_create'
   kernel/power/snapshot.c:678: warning: Function parameter or member 'safe_needed' not described in 'memory_bm_create'
   kernel/power/snapshot.c:720: warning: Function parameter or member 'clear_nosave_free' not described in 'memory_bm_free'
   kernel/power/snapshot.c:742: warning: Function parameter or member 'bm' not described in 'memory_bm_find_bit'
   kernel/power/snapshot.c:742: warning: Function parameter or member 'pfn' not described in 'memory_bm_find_bit'
   kernel/power/snapshot.c:742: warning: Function parameter or member 'addr' not described in 'memory_bm_find_bit'
   kernel/power/snapshot.c:742: warning: Function parameter or member 'bit_nr' not described in 'memory_bm_find_bit'
   kernel/power/snapshot.c:916: warning: expecting prototype for memory_bm_rtree_next_pfn(). Prototype was for memory_bm_next_pfn() instead
>> kernel/power/snapshot.c:982: warning: Function parameter or member 'start_pfn' not described in 'register_nosave_region'
>> kernel/power/snapshot.c:982: warning: Function parameter or member 'end_pfn' not described in 'register_nosave_region'
   kernel/power/snapshot.c:1254: warning: Function parameter or member 'zone' not described in 'saveable_highmem_page'
   kernel/power/snapshot.c:1254: warning: Function parameter or member 'pfn' not described in 'saveable_highmem_page'
   kernel/power/snapshot.c:1318: warning: Function parameter or member 'zone' not described in 'saveable_page'
   kernel/power/snapshot.c:1318: warning: Function parameter or member 'pfn' not described in 'saveable_page'
   kernel/power/snapshot.c:1389: warning: Function parameter or member 'dst' not described in 'safe_copy_page'
   kernel/power/snapshot.c:1389: warning: Function parameter or member 's_page' not described in 'safe_copy_page'
   kernel/power/snapshot.c:1602: warning: Function parameter or member 'x' not described in '__fraction'
   kernel/power/snapshot.c:1602: warning: Function parameter or member 'multiplier' not described in '__fraction'
   kernel/power/snapshot.c:1602: warning: Function parameter or member 'base' not described in '__fraction'
   kernel/power/snapshot.c:1893: warning: Function parameter or member 'nr_highmem' not described in 'count_pages_for_highmem'
   kernel/power/snapshot.c:1911: warning: Function parameter or member 'nr_pages' not described in 'enough_free_mem'
   kernel/power/snapshot.c:1911: warning: Function parameter or member 'nr_highmem' not described in 'enough_free_mem'
   kernel/power/snapshot.c:1934: warning: Function parameter or member 'safe_needed' not described in 'get_highmem_buffer'
   kernel/power/snapshot.c:1947: warning: Function parameter or member 'bm' not described in 'alloc_highmem_pages'
   kernel/power/snapshot.c:1947: warning: Function parameter or member 'nr_highmem' not described in 'alloc_highmem_pages'
   kernel/power/snapshot.c:1947: warning: expecting prototype for alloc_highmem_image_pages(). Prototype was for alloc_highmem_pages() instead
   kernel/power/snapshot.c:1982: warning: Function parameter or member 'copy_bm' not described in 'swsusp_alloc'
   kernel/power/snapshot.c:1982: warning: Function parameter or member 'nr_pages' not described in 'swsusp_alloc'
   kernel/power/snapshot.c:1982: warning: Function parameter or member 'nr_highmem' not described in 'swsusp_alloc'
   kernel/power/snapshot.c:2195: warning: Function parameter or member 'bm' not described in 'mark_unsafe_pages'
   kernel/power/snapshot.c:2230: warning: Function parameter or member 'info' not described in 'load_header'
   kernel/power/snapshot.c:2230: warning: expecting prototype for load header(). Prototype was for load_header() instead
   kernel/power/snapshot.c:2384: warning: Function parameter or member 'page' not described in 'get_highmem_page_buffer'
   kernel/power/snapshot.c:2384: warning: Function parameter or member 'ca' not described in 'get_highmem_page_buffer'
   kernel/power/snapshot.c:2569: warning: Function parameter or member 'bm' not described in 'get_buffer'
   kernel/power/snapshot.c:2569: warning: Function parameter or member 'ca' not described in 'get_buffer'
   kernel/power/snapshot.c:2693: warning: Function parameter or member 'handle' not described in 'snapshot_write_finalize'


vim +982 kernel/power/snapshot.c

307c5971c972ef Rafael J. Wysocki  2016-06-29   974  
74dfd666de861c Rafael J. Wysocki  2007-05-06   975  /**
ef96f639ea6634 Rafael J. Wysocki  2016-07-06   976   * register_nosave_region - Register a region of unsaveable memory.
ef96f639ea6634 Rafael J. Wysocki  2016-07-06   977   *
ef96f639ea6634 Rafael J. Wysocki  2016-07-06   978   * Register a range of page frames the contents of which should not be saved
ef96f639ea6634 Rafael J. Wysocki  2016-07-06   979   * during hibernation (to be used in the early initialization code).
74dfd666de861c Rafael J. Wysocki  2007-05-06   980   */
33569ef3c754a8 Amadeusz Sławiński 2022-01-19   981  void __init register_nosave_region(unsigned long start_pfn, unsigned long end_pfn)
74dfd666de861c Rafael J. Wysocki  2007-05-06  @982  {
74dfd666de861c Rafael J. Wysocki  2007-05-06   983  	struct nosave_region *region;
74dfd666de861c Rafael J. Wysocki  2007-05-06   984  
74dfd666de861c Rafael J. Wysocki  2007-05-06   985  	if (start_pfn >= end_pfn)
74dfd666de861c Rafael J. Wysocki  2007-05-06   986  		return;
74dfd666de861c Rafael J. Wysocki  2007-05-06   987  
74dfd666de861c Rafael J. Wysocki  2007-05-06   988  	if (!list_empty(&nosave_regions)) {
74dfd666de861c Rafael J. Wysocki  2007-05-06   989  		/* Try to extend the previous region (they should be sorted) */
74dfd666de861c Rafael J. Wysocki  2007-05-06   990  		region = list_entry(nosave_regions.prev,
74dfd666de861c Rafael J. Wysocki  2007-05-06   991  					struct nosave_region, list);
74dfd666de861c Rafael J. Wysocki  2007-05-06   992  		if (region->end_pfn == start_pfn) {
74dfd666de861c Rafael J. Wysocki  2007-05-06   993  			region->end_pfn = end_pfn;
74dfd666de861c Rafael J. Wysocki  2007-05-06   994  			goto Report;
74dfd666de861c Rafael J. Wysocki  2007-05-06   995  		}
74dfd666de861c Rafael J. Wysocki  2007-05-06   996  	}
74dfd666de861c Rafael J. Wysocki  2007-05-06   997  	/* This allocation cannot fail */
7e1c4e27928e5f Mike Rapoport      2018-10-30   998  	region = memblock_alloc(sizeof(struct nosave_region),
7e1c4e27928e5f Mike Rapoport      2018-10-30   999  				SMP_CACHE_BYTES);
8a7f97b902f4fb Mike Rapoport      2019-03-11  1000  	if (!region)
8a7f97b902f4fb Mike Rapoport      2019-03-11  1001  		panic("%s: Failed to allocate %zu bytes\n", __func__,
8a7f97b902f4fb Mike Rapoport      2019-03-11  1002  		      sizeof(struct nosave_region));
74dfd666de861c Rafael J. Wysocki  2007-05-06  1003  	region->start_pfn = start_pfn;
74dfd666de861c Rafael J. Wysocki  2007-05-06  1004  	region->end_pfn = end_pfn;
74dfd666de861c Rafael J. Wysocki  2007-05-06  1005  	list_add_tail(&region->list, &nosave_regions);
74dfd666de861c Rafael J. Wysocki  2007-05-06  1006   Report:
64ec72a1ece37d Joe Perches        2017-09-27  1007  	pr_info("Registered nosave memory: [mem %#010llx-%#010llx]\n",
cd38ca854de15b Bjorn Helgaas      2013-06-03  1008  		(unsigned long long) start_pfn << PAGE_SHIFT,
cd38ca854de15b Bjorn Helgaas      2013-06-03  1009  		((unsigned long long) end_pfn << PAGE_SHIFT) - 1);
74dfd666de861c Rafael J. Wysocki  2007-05-06  1010  }
74dfd666de861c Rafael J. Wysocki  2007-05-06  1011  

:::::: The code at line 982 was first introduced by commit
:::::: 74dfd666de861c97d47bdbd892f6d21b801d0247 swsusp: do not use page flags

:::::: TO: Rafael J. Wysocki <rjw@sisk.pl>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

