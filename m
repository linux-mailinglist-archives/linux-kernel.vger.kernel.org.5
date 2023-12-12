Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255C280ECB5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376406AbjLLNAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjLLNAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:00:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61C5A8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702386043; x=1733922043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TL3Vvvn9Ep8tuIBSuAGbTOWc2Hr/dT/tex3ZVwZ0XAQ=;
  b=k0HZlq34rVvFrFA2NbHti7z5YywqwBwFJfBLqTEGm+L+9dK59jE2OcrW
   yvsui/HqzNQrbXvEKle2rHm4w/S0tITh10whU8UsoiJh2Qq0g/td+f4tF
   9W1AwN18hIyvbKqC3xaxvKiYCIAaFL8n79tv9HqUEFtQt3NjHWcwSIrvC
   xyBnWl9i6BL41abJQYJuLzLX5Yx3WdaI8XwJSEMmEnEmYCwDxAsV3q5sT
   TknIffp+ZKuRedpYRpq3XxyaAr0QQhmikE/elYlNsZAtH9ABjT/qDjKAk
   BUITLvyR4ky9JYY3zs2XhJEK8rXtad3Fwvpix3ihQucVXsDfyj7Cs0YP5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1954238"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1954238"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 05:00:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="777094271"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="777094271"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Dec 2023 05:00:41 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rD2NL-000JBX-00;
        Tue, 12 Dec 2023 13:00:39 +0000
Date:   Tue, 12 Dec 2023 21:00:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/vmscan.c:6425:(.text+0xa14e): relocation truncated to fit:
 R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
Message-ID: <202312122050.SSKuN78K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26aff849438cebcd05f1a647390c4aa700d5c0f1
commit: 1bc545bff45ce9eefc176ccf663074462a209cb6 mm/vmscan: fix root proactive reclaim unthrottling unbalanced node
date:   6 months ago
config: csky-randconfig-r025-20230521 (https://download.01.org/0day-ci/archive/20231212/202312122050.SSKuN78K-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231212/202312122050.SSKuN78K-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312122050.SSKuN78K-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/vmscan.o: in function `should_continue_reclaim':
>> mm/vmscan.c:6425:(.text+0xa14e): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   mm/vmscan.c:6429:(.text+0xa164): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   mm/vmscan.o: in function `arch_atomic_long_read':
   include/linux/atomic/atomic-long.h:541:(.text+0xa184): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   mm/vmscan.o: in function `shrink_node':
   mm/vmscan.c:6599:(.text+0xa198): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   mm/vmscan.c:6571:(.text+0xa1e0): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   mm/vmscan.o: in function `generic_atomic_or':
>> include/asm-generic/atomic.h:108:(.text+0xa236): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   include/asm-generic/atomic.h:108:(.text+0xa240): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   include/asm-generic/atomic.h:108:(.text+0xa24a): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   mm/vmscan.o: in function `balance_pgdat':
   mm/vmscan.c:7376:(.text+0xa25c): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   mm/vmscan.c:7385:(.text+0xa276): relocation truncated to fit: R_CKCORE_PCREL_IMM16BY4 against `__jump_table'
   mm/vmscan.o: in function `set_task_reclaim_state':
   mm/vmscan.c:512:(.text+0xa29e): additional relocation overflows omitted from the output
   pahole: .tmp_vmlinux.btf: Invalid argument
   .btf.vmlinux.bin.o: file not recognized: file format not recognized


vim +6425 mm/vmscan.c

23b9da55c5b0fe Mel Gorman            2012-05-29  6385  
3e7d344970673c Mel Gorman            2011-01-13  6386  /*
23b9da55c5b0fe Mel Gorman            2012-05-29  6387   * Reclaim/compaction is used for high-order allocation requests. It reclaims
23b9da55c5b0fe Mel Gorman            2012-05-29  6388   * order-0 pages before compacting the zone. should_continue_reclaim() returns
23b9da55c5b0fe Mel Gorman            2012-05-29  6389   * true if more pages should be reclaimed such that when the page allocator
df3a45f9d8ee41 Qiwu Chen             2020-06-03  6390   * calls try_to_compact_pages() that it will have enough free pages to succeed.
23b9da55c5b0fe Mel Gorman            2012-05-29  6391   * It will give up earlier than that if there is difficulty reclaiming pages.
3e7d344970673c Mel Gorman            2011-01-13  6392   */
a9dd0a83104c01 Mel Gorman            2016-07-28  6393  static inline bool should_continue_reclaim(struct pglist_data *pgdat,
3e7d344970673c Mel Gorman            2011-01-13  6394  					unsigned long nr_reclaimed,
3e7d344970673c Mel Gorman            2011-01-13  6395  					struct scan_control *sc)
3e7d344970673c Mel Gorman            2011-01-13  6396  {
3e7d344970673c Mel Gorman            2011-01-13  6397  	unsigned long pages_for_compaction;
3e7d344970673c Mel Gorman            2011-01-13  6398  	unsigned long inactive_lru_pages;
a9dd0a83104c01 Mel Gorman            2016-07-28  6399  	int z;
3e7d344970673c Mel Gorman            2011-01-13  6400  
3e7d344970673c Mel Gorman            2011-01-13  6401  	/* If not in reclaim/compaction mode, stop */
9e3b2f8cd340e1 Konstantin Khlebnikov 2012-05-29  6402  	if (!in_reclaim_compaction(sc))
3e7d344970673c Mel Gorman            2011-01-13  6403  		return false;
3e7d344970673c Mel Gorman            2011-01-13  6404  
3e7d344970673c Mel Gorman            2011-01-13  6405  	/*
5ee04716c46ce5 Vlastimil Babka       2019-09-23  6406  	 * Stop if we failed to reclaim any pages from the last SWAP_CLUSTER_MAX
5ee04716c46ce5 Vlastimil Babka       2019-09-23  6407  	 * number of pages that were scanned. This will return to the caller
5ee04716c46ce5 Vlastimil Babka       2019-09-23  6408  	 * with the risk reclaim/compaction and the resulting allocation attempt
5ee04716c46ce5 Vlastimil Babka       2019-09-23  6409  	 * fails. In the past we have tried harder for __GFP_RETRY_MAYFAIL
5ee04716c46ce5 Vlastimil Babka       2019-09-23  6410  	 * allocations through requiring that the full LRU list has been scanned
5ee04716c46ce5 Vlastimil Babka       2019-09-23  6411  	 * first, by assuming that zero delta of sc->nr_scanned means full LRU
5ee04716c46ce5 Vlastimil Babka       2019-09-23  6412  	 * scan, but that approximation was wrong, and there were corner cases
5ee04716c46ce5 Vlastimil Babka       2019-09-23  6413  	 * where always a non-zero amount of pages were scanned.
2876592f231d43 Mel Gorman            2011-02-25  6414  	 */
2876592f231d43 Mel Gorman            2011-02-25  6415  	if (!nr_reclaimed)
2876592f231d43 Mel Gorman            2011-02-25  6416  		return false;
3e7d344970673c Mel Gorman            2011-01-13  6417  
3e7d344970673c Mel Gorman            2011-01-13  6418  	/* If compaction would go ahead or the allocation would succeed, stop */
a9dd0a83104c01 Mel Gorman            2016-07-28  6419  	for (z = 0; z <= sc->reclaim_idx; z++) {
a9dd0a83104c01 Mel Gorman            2016-07-28  6420  		struct zone *zone = &pgdat->node_zones[z];
6aa303defb7454 Mel Gorman            2016-09-01  6421  		if (!managed_zone(zone))
a9dd0a83104c01 Mel Gorman            2016-07-28  6422  			continue;
a9dd0a83104c01 Mel Gorman            2016-07-28  6423  
e8606320e9af97 Johannes Weiner       2023-05-19  6424  		/* Allocation can already succeed, nothing to do */
e8606320e9af97 Johannes Weiner       2023-05-19 @6425  		if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
e8606320e9af97 Johannes Weiner       2023-05-19  6426  				      sc->reclaim_idx, 0))
e8606320e9af97 Johannes Weiner       2023-05-19  6427  			return false;
e8606320e9af97 Johannes Weiner       2023-05-19  6428  
3cf04937529020 Johannes Weiner       2023-06-02  6429  		if (compaction_suitable(zone, sc->order, sc->reclaim_idx))
3e7d344970673c Mel Gorman            2011-01-13  6430  			return false;
3e7d344970673c Mel Gorman            2011-01-13  6431  	}
1c6c15971e4709 Hillf Danton          2019-09-23  6432  
1c6c15971e4709 Hillf Danton          2019-09-23  6433  	/*
1c6c15971e4709 Hillf Danton          2019-09-23  6434  	 * If we have not reclaimed enough pages for compaction and the
1c6c15971e4709 Hillf Danton          2019-09-23  6435  	 * inactive lists are large enough, continue reclaiming
1c6c15971e4709 Hillf Danton          2019-09-23  6436  	 */
1c6c15971e4709 Hillf Danton          2019-09-23  6437  	pages_for_compaction = compact_gap(sc->order);
1c6c15971e4709 Hillf Danton          2019-09-23  6438  	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
a2a36488a61cef Keith Busch           2021-09-02  6439  	if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
1c6c15971e4709 Hillf Danton          2019-09-23  6440  		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
1c6c15971e4709 Hillf Danton          2019-09-23  6441  
5ee04716c46ce5 Vlastimil Babka       2019-09-23  6442  	return inactive_lru_pages > pages_for_compaction;
a9dd0a83104c01 Mel Gorman            2016-07-28  6443  }
3e7d344970673c Mel Gorman            2011-01-13  6444  

:::::: The code at line 6425 was first introduced by commit
:::::: e8606320e9af9774fd879e71c940fc9e5fd9b901 mm: compaction: refactor __compaction_suitable()

:::::: TO: Johannes Weiner <hannes@cmpxchg.org>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
