Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93E7DE626
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjKASpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjKASpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:45:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1ECA6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698864302; x=1730400302;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=26F5Myr2doa7tyw8aGLvTs4+ONGqTCVhpxq+5JLHqlI=;
  b=WNPLEGwGg8tcBCkYBjLvXqohjoCNUJKSWDYK1JZWPrxznba0NAzQZzYR
   w/gNhU3erXJx9BsQCx4pQHodzg/lW4+2z/3Aj5uhS0Lft/e/gUp0B4kjc
   TCQbvfW/XdUgYjIRxN/USarPCDXbTHkLPVlbCbsikiDxG/YaxV9dAqg7w
   L8wcynlhD1peYZ9WVDtr6+JufnEu51+EjqzfC3eQazQpm+GXGdgAxKsJI
   3QiMGnLrLPv0nvKeP72+0SPW+Me7JRQ+sV4EA2kode87s+Fb6ZdIafxJt
   0VCDWpZZwGyvrl0t7P5HoBX9Tg2FijTQ8NWAEEZqNAHcuEiUyA5RGKc1D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="392434180"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="392434180"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 11:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="2255054"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 01 Nov 2023 11:45:01 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyGD4-0000uJ-1c;
        Wed, 01 Nov 2023 18:44:58 +0000
Date:   Thu, 2 Nov 2023 02:44:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/power/snapshot.c:467: warning: Function parameter or member
 'ca' not described in 'add_rtree_block'
Message-ID: <202311020228.AhqTBuwn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8bc9e6515183935fa0cccaf67455c439afe4982b
commit: 7db54bfe44a662c8f2c10277bccfa02c2f4c719c LoongArch: Add hibernation (ACPI S4) support
date:   11 months ago
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20231102/202311020228.AhqTBuwn-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311020228.AhqTBuwn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311020228.AhqTBuwn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/power/snapshot.c:467: warning: Function parameter or member 'zone' not described in 'add_rtree_block'
   kernel/power/snapshot.c:467: warning: Function parameter or member 'gfp_mask' not described in 'add_rtree_block'
   kernel/power/snapshot.c:467: warning: Function parameter or member 'safe_needed' not described in 'add_rtree_block'
>> kernel/power/snapshot.c:467: warning: Function parameter or member 'ca' not described in 'add_rtree_block'
   kernel/power/snapshot.c:540: warning: Function parameter or member 'gfp_mask' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:540: warning: Function parameter or member 'safe_needed' not described in 'create_zone_bm_rtree'
>> kernel/power/snapshot.c:540: warning: Function parameter or member 'ca' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:540: warning: Function parameter or member 'start' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:540: warning: Function parameter or member 'end' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:575: warning: Function parameter or member 'zone' not described in 'free_zone_bm_rtree'
   kernel/power/snapshot.c:575: warning: Function parameter or member 'clear_nosave_free' not described in 'free_zone_bm_rtree'
   kernel/power/snapshot.c:682: warning: Function parameter or member 'bm' not described in 'memory_bm_create'
>> kernel/power/snapshot.c:682: warning: Function parameter or member 'gfp_mask' not described in 'memory_bm_create'
   kernel/power/snapshot.c:682: warning: Function parameter or member 'safe_needed' not described in 'memory_bm_create'
>> kernel/power/snapshot.c:724: warning: Function parameter or member 'clear_nosave_free' not described in 'memory_bm_free'
   kernel/power/snapshot.c:746: warning: Function parameter or member 'bm' not described in 'memory_bm_find_bit'
>> kernel/power/snapshot.c:746: warning: Function parameter or member 'pfn' not described in 'memory_bm_find_bit'
   kernel/power/snapshot.c:746: warning: Function parameter or member 'addr' not described in 'memory_bm_find_bit'
   kernel/power/snapshot.c:746: warning: Function parameter or member 'bit_nr' not described in 'memory_bm_find_bit'
   kernel/power/snapshot.c:986: warning: Function parameter or member 'start_pfn' not described in 'register_nosave_region'
   kernel/power/snapshot.c:986: warning: Function parameter or member 'end_pfn' not described in 'register_nosave_region'
   kernel/power/snapshot.c:1258: warning: Function parameter or member 'zone' not described in 'saveable_highmem_page'
   kernel/power/snapshot.c:1258: warning: Function parameter or member 'pfn' not described in 'saveable_highmem_page'
   kernel/power/snapshot.c:1322: warning: Function parameter or member 'zone' not described in 'saveable_page'
   kernel/power/snapshot.c:1322: warning: Function parameter or member 'pfn' not described in 'saveable_page'
   kernel/power/snapshot.c:1393: warning: Function parameter or member 'dst' not described in 'safe_copy_page'
   kernel/power/snapshot.c:1393: warning: Function parameter or member 's_page' not described in 'safe_copy_page'
   kernel/power/snapshot.c:1606: warning: Function parameter or member 'x' not described in '__fraction'
   kernel/power/snapshot.c:1606: warning: Function parameter or member 'multiplier' not described in '__fraction'
   kernel/power/snapshot.c:1606: warning: Function parameter or member 'base' not described in '__fraction'
   kernel/power/snapshot.c:1897: warning: Function parameter or member 'nr_highmem' not described in 'count_pages_for_highmem'
   kernel/power/snapshot.c:1915: warning: Function parameter or member 'nr_pages' not described in 'enough_free_mem'
   kernel/power/snapshot.c:1915: warning: Function parameter or member 'nr_highmem' not described in 'enough_free_mem'
   kernel/power/snapshot.c:1938: warning: Function parameter or member 'safe_needed' not described in 'get_highmem_buffer'
   kernel/power/snapshot.c:1951: warning: Function parameter or member 'bm' not described in 'alloc_highmem_pages'
   kernel/power/snapshot.c:1951: warning: Function parameter or member 'nr_highmem' not described in 'alloc_highmem_pages'
   kernel/power/snapshot.c:1986: warning: Function parameter or member 'copy_bm' not described in 'swsusp_alloc'
   kernel/power/snapshot.c:1986: warning: Function parameter or member 'nr_pages' not described in 'swsusp_alloc'
   kernel/power/snapshot.c:1986: warning: Function parameter or member 'nr_highmem' not described in 'swsusp_alloc'
   kernel/power/snapshot.c:2199: warning: Function parameter or member 'bm' not described in 'mark_unsafe_pages'
   kernel/power/snapshot.c:2234: warning: Function parameter or member 'info' not described in 'load_header'
   kernel/power/snapshot.c:2388: warning: Function parameter or member 'page' not described in 'get_highmem_page_buffer'
   kernel/power/snapshot.c:2388: warning: Function parameter or member 'ca' not described in 'get_highmem_page_buffer'
   kernel/power/snapshot.c:2573: warning: Function parameter or member 'bm' not described in 'get_buffer'
   kernel/power/snapshot.c:2573: warning: Function parameter or member 'ca' not described in 'get_buffer'
   kernel/power/snapshot.c:2697: warning: Function parameter or member 'handle' not described in 'snapshot_write_finalize'


vim +467 kernel/power/snapshot.c

f469f02dc6fa67 Joerg Roedel      2014-07-21  457  
ef96f639ea6634 Rafael J. Wysocki 2016-07-06  458  /**
ef96f639ea6634 Rafael J. Wysocki 2016-07-06  459   * add_rtree_block - Add a new leave node to the radix tree.
f469f02dc6fa67 Joerg Roedel      2014-07-21  460   *
f469f02dc6fa67 Joerg Roedel      2014-07-21  461   * The leave nodes need to be allocated in order to keep the leaves
f469f02dc6fa67 Joerg Roedel      2014-07-21  462   * linked list in order. This is guaranteed by the zone->blocks
f469f02dc6fa67 Joerg Roedel      2014-07-21  463   * counter.
f469f02dc6fa67 Joerg Roedel      2014-07-21  464   */
f469f02dc6fa67 Joerg Roedel      2014-07-21  465  static int add_rtree_block(struct mem_zone_bm_rtree *zone, gfp_t gfp_mask,
f469f02dc6fa67 Joerg Roedel      2014-07-21  466  			   int safe_needed, struct chain_allocator *ca)
f469f02dc6fa67 Joerg Roedel      2014-07-21 @467  {
f469f02dc6fa67 Joerg Roedel      2014-07-21  468  	struct rtree_node *node, *block, **dst;
f469f02dc6fa67 Joerg Roedel      2014-07-21  469  	unsigned int levels_needed, block_nr;
f469f02dc6fa67 Joerg Roedel      2014-07-21  470  	int i;
f469f02dc6fa67 Joerg Roedel      2014-07-21  471  
f469f02dc6fa67 Joerg Roedel      2014-07-21  472  	block_nr = zone->blocks;
f469f02dc6fa67 Joerg Roedel      2014-07-21  473  	levels_needed = 0;
f469f02dc6fa67 Joerg Roedel      2014-07-21  474  
f469f02dc6fa67 Joerg Roedel      2014-07-21  475  	/* How many levels do we need for this block nr? */
f469f02dc6fa67 Joerg Roedel      2014-07-21  476  	while (block_nr) {
f469f02dc6fa67 Joerg Roedel      2014-07-21  477  		levels_needed += 1;
f469f02dc6fa67 Joerg Roedel      2014-07-21  478  		block_nr >>= BM_RTREE_LEVEL_SHIFT;
f469f02dc6fa67 Joerg Roedel      2014-07-21  479  	}
f469f02dc6fa67 Joerg Roedel      2014-07-21  480  
f469f02dc6fa67 Joerg Roedel      2014-07-21  481  	/* Make sure the rtree has enough levels */
f469f02dc6fa67 Joerg Roedel      2014-07-21  482  	for (i = zone->levels; i < levels_needed; i++) {
f469f02dc6fa67 Joerg Roedel      2014-07-21  483  		node = alloc_rtree_node(gfp_mask, safe_needed, ca,
f469f02dc6fa67 Joerg Roedel      2014-07-21  484  					&zone->nodes);
f469f02dc6fa67 Joerg Roedel      2014-07-21  485  		if (!node)
f469f02dc6fa67 Joerg Roedel      2014-07-21  486  			return -ENOMEM;
f469f02dc6fa67 Joerg Roedel      2014-07-21  487  
f469f02dc6fa67 Joerg Roedel      2014-07-21  488  		node->data[0] = (unsigned long)zone->rtree;
f469f02dc6fa67 Joerg Roedel      2014-07-21  489  		zone->rtree = node;
f469f02dc6fa67 Joerg Roedel      2014-07-21  490  		zone->levels += 1;
f469f02dc6fa67 Joerg Roedel      2014-07-21  491  	}
f469f02dc6fa67 Joerg Roedel      2014-07-21  492  
f469f02dc6fa67 Joerg Roedel      2014-07-21  493  	/* Allocate new block */
f469f02dc6fa67 Joerg Roedel      2014-07-21  494  	block = alloc_rtree_node(gfp_mask, safe_needed, ca, &zone->leaves);
f469f02dc6fa67 Joerg Roedel      2014-07-21  495  	if (!block)
f469f02dc6fa67 Joerg Roedel      2014-07-21  496  		return -ENOMEM;
f469f02dc6fa67 Joerg Roedel      2014-07-21  497  
f469f02dc6fa67 Joerg Roedel      2014-07-21  498  	/* Now walk the rtree to insert the block */
f469f02dc6fa67 Joerg Roedel      2014-07-21  499  	node = zone->rtree;
f469f02dc6fa67 Joerg Roedel      2014-07-21  500  	dst = &zone->rtree;
f469f02dc6fa67 Joerg Roedel      2014-07-21  501  	block_nr = zone->blocks;
f469f02dc6fa67 Joerg Roedel      2014-07-21  502  	for (i = zone->levels; i > 0; i--) {
f469f02dc6fa67 Joerg Roedel      2014-07-21  503  		int index;
f469f02dc6fa67 Joerg Roedel      2014-07-21  504  
f469f02dc6fa67 Joerg Roedel      2014-07-21  505  		if (!node) {
f469f02dc6fa67 Joerg Roedel      2014-07-21  506  			node = alloc_rtree_node(gfp_mask, safe_needed, ca,
f469f02dc6fa67 Joerg Roedel      2014-07-21  507  						&zone->nodes);
f469f02dc6fa67 Joerg Roedel      2014-07-21  508  			if (!node)
f469f02dc6fa67 Joerg Roedel      2014-07-21  509  				return -ENOMEM;
f469f02dc6fa67 Joerg Roedel      2014-07-21  510  			*dst = node;
f469f02dc6fa67 Joerg Roedel      2014-07-21  511  		}
f469f02dc6fa67 Joerg Roedel      2014-07-21  512  
f469f02dc6fa67 Joerg Roedel      2014-07-21  513  		index = block_nr >> ((i - 1) * BM_RTREE_LEVEL_SHIFT);
f469f02dc6fa67 Joerg Roedel      2014-07-21  514  		index &= BM_RTREE_LEVEL_MASK;
f469f02dc6fa67 Joerg Roedel      2014-07-21  515  		dst = (struct rtree_node **)&((*dst)->data[index]);
f469f02dc6fa67 Joerg Roedel      2014-07-21  516  		node = *dst;
f469f02dc6fa67 Joerg Roedel      2014-07-21  517  	}
f469f02dc6fa67 Joerg Roedel      2014-07-21  518  
f469f02dc6fa67 Joerg Roedel      2014-07-21  519  	zone->blocks += 1;
f469f02dc6fa67 Joerg Roedel      2014-07-21  520  	*dst = block;
f469f02dc6fa67 Joerg Roedel      2014-07-21  521  
f469f02dc6fa67 Joerg Roedel      2014-07-21  522  	return 0;
f469f02dc6fa67 Joerg Roedel      2014-07-21  523  }
f469f02dc6fa67 Joerg Roedel      2014-07-21  524  
f469f02dc6fa67 Joerg Roedel      2014-07-21  525  static void free_zone_bm_rtree(struct mem_zone_bm_rtree *zone,
f469f02dc6fa67 Joerg Roedel      2014-07-21  526  			       int clear_nosave_free);
f469f02dc6fa67 Joerg Roedel      2014-07-21  527  
ef96f639ea6634 Rafael J. Wysocki 2016-07-06  528  /**
ef96f639ea6634 Rafael J. Wysocki 2016-07-06  529   * create_zone_bm_rtree - Create a radix tree for one zone.
f469f02dc6fa67 Joerg Roedel      2014-07-21  530   *
f469f02dc6fa67 Joerg Roedel      2014-07-21  531   * Allocated the mem_zone_bm_rtree structure and initializes it.
f469f02dc6fa67 Joerg Roedel      2014-07-21  532   * This function also allocated and builds the radix tree for the
f469f02dc6fa67 Joerg Roedel      2014-07-21  533   * zone.
f469f02dc6fa67 Joerg Roedel      2014-07-21  534   */
efd5a85242e996 Rafael J. Wysocki 2016-07-06  535  static struct mem_zone_bm_rtree *create_zone_bm_rtree(gfp_t gfp_mask,
efd5a85242e996 Rafael J. Wysocki 2016-07-06  536  						      int safe_needed,
f469f02dc6fa67 Joerg Roedel      2014-07-21  537  						      struct chain_allocator *ca,
efd5a85242e996 Rafael J. Wysocki 2016-07-06  538  						      unsigned long start,
efd5a85242e996 Rafael J. Wysocki 2016-07-06  539  						      unsigned long end)
f469f02dc6fa67 Joerg Roedel      2014-07-21 @540  {
f469f02dc6fa67 Joerg Roedel      2014-07-21  541  	struct mem_zone_bm_rtree *zone;
f469f02dc6fa67 Joerg Roedel      2014-07-21  542  	unsigned int i, nr_blocks;
f469f02dc6fa67 Joerg Roedel      2014-07-21  543  	unsigned long pages;
f469f02dc6fa67 Joerg Roedel      2014-07-21  544  
f469f02dc6fa67 Joerg Roedel      2014-07-21  545  	pages = end - start;
f469f02dc6fa67 Joerg Roedel      2014-07-21  546  	zone  = chain_alloc(ca, sizeof(struct mem_zone_bm_rtree));
f469f02dc6fa67 Joerg Roedel      2014-07-21  547  	if (!zone)
f469f02dc6fa67 Joerg Roedel      2014-07-21  548  		return NULL;
f469f02dc6fa67 Joerg Roedel      2014-07-21  549  
f469f02dc6fa67 Joerg Roedel      2014-07-21  550  	INIT_LIST_HEAD(&zone->nodes);
f469f02dc6fa67 Joerg Roedel      2014-07-21  551  	INIT_LIST_HEAD(&zone->leaves);
f469f02dc6fa67 Joerg Roedel      2014-07-21  552  	zone->start_pfn = start;
f469f02dc6fa67 Joerg Roedel      2014-07-21  553  	zone->end_pfn = end;
f469f02dc6fa67 Joerg Roedel      2014-07-21  554  	nr_blocks = DIV_ROUND_UP(pages, BM_BITS_PER_BLOCK);
f469f02dc6fa67 Joerg Roedel      2014-07-21  555  
f469f02dc6fa67 Joerg Roedel      2014-07-21  556  	for (i = 0; i < nr_blocks; i++) {
f469f02dc6fa67 Joerg Roedel      2014-07-21  557  		if (add_rtree_block(zone, gfp_mask, safe_needed, ca)) {
f469f02dc6fa67 Joerg Roedel      2014-07-21  558  			free_zone_bm_rtree(zone, PG_UNSAFE_CLEAR);
f469f02dc6fa67 Joerg Roedel      2014-07-21  559  			return NULL;
f469f02dc6fa67 Joerg Roedel      2014-07-21  560  		}
f469f02dc6fa67 Joerg Roedel      2014-07-21  561  	}
f469f02dc6fa67 Joerg Roedel      2014-07-21  562  
f469f02dc6fa67 Joerg Roedel      2014-07-21  563  	return zone;
f469f02dc6fa67 Joerg Roedel      2014-07-21  564  }
f469f02dc6fa67 Joerg Roedel      2014-07-21  565  

:::::: The code at line 467 was first introduced by commit
:::::: f469f02dc6fa67f6c6a7d91400d08b9339147aed PM / Hibernate: Create a Radix-Tree to store memory bitmap

:::::: TO: Joerg Roedel <jroedel@suse.de>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
