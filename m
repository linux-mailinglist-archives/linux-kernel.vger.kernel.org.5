Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1FE7ECB07
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjKOTNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjKOTN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:13:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E009A12C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700075605; x=1731611605;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ifYVWvscdRK6V99rtfowEQkzuyNJ5E9DWdsc6q5+VBg=;
  b=gaAR1jINQcVHsZK5JZXYWJ/+1S7hKq7rTmT3nyimNJFbH0h/BspB4lRP
   9slyHiT0qVImaDWncAppm0y5YzO51NWlEwnQ25MggyHzeEVJHs5vcN29k
   U4QlpI6ViYByUHmh6Tk9Wv77uIgQnez1yN3KiJb8Zn4fua5k+1IYb3WWS
   7c1lkgdPvvQH27+w28dltXDmiDe7Sn5gbiYkK0m1+S6xdbhVTFiPLhmJH
   JmmYmLPyCoJgYdTk0BYeLwmrDESLJ8HUNqAxlTCoGoUx1nejgCg0+ahuk
   PHBe9vIk3sXpeenBZ1pmoY6LlHF88rBYg4lY/5cuklpdjNCgjZDXtwiJo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="455226650"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="455226650"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 11:13:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="6263087"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 15 Nov 2023 11:13:23 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3LKC-0000jm-2v;
        Wed, 15 Nov 2023 19:13:20 +0000
Date:   Thu, 16 Nov 2023 03:12:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>
Subject: net/core/page_pool.c:590:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202311160339.DbhaH8LX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: ff4e538c8c3e675a15e1e49509c55951832e0451 page_pool: add a lockdep check for recycling in hardirq
date:   3 months ago
config: loongarch-randconfig-r133-20231107 (https://download.01.org/0day-ci/archive/20231116/202311160339.DbhaH8LX-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231116/202311160339.DbhaH8LX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160339.DbhaH8LX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got unsigned int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *
>> net/core/page_pool.c:590:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   net/core/page_pool.c:590:9: sparse:     expected void *ptr
   net/core/page_pool.c:590:9: sparse:     got int [noderef] __percpu *

vim +590 net/core/page_pool.c

   579	
   580	/* If the page refcnt == 1, this will try to recycle the page.
   581	 * if PP_FLAG_DMA_SYNC_DEV is set, we'll try to sync the DMA area for
   582	 * the configured size min(dma_sync_size, pool->max_len).
   583	 * If the page refcnt != 1, then the page will be returned to memory
   584	 * subsystem.
   585	 */
   586	static __always_inline struct page *
   587	__page_pool_put_page(struct page_pool *pool, struct page *page,
   588			     unsigned int dma_sync_size, bool allow_direct)
   589	{
 > 590		lockdep_assert_no_hardirq();
   591	
   592		/* This allocator is optimized for the XDP mode that uses
   593		 * one-frame-per-page, but have fallbacks that act like the
   594		 * regular page allocator APIs.
   595		 *
   596		 * refcnt == 1 means page_pool owns page, and can recycle it.
   597		 *
   598		 * page is NOT reusable when allocated when system is under
   599		 * some pressure. (page_is_pfmemalloc)
   600		 */
   601		if (likely(page_ref_count(page) == 1 && !page_is_pfmemalloc(page))) {
   602			/* Read barrier done in page_ref_count / READ_ONCE */
   603	
   604			if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
   605				page_pool_dma_sync_for_device(pool, page,
   606							      dma_sync_size);
   607	
   608			if (allow_direct && in_softirq() &&
   609			    page_pool_recycle_in_cache(page, pool))
   610				return NULL;
   611	
   612			/* Page found as candidate for recycling */
   613			return page;
   614		}
   615		/* Fallback/non-XDP mode: API user have elevated refcnt.
   616		 *
   617		 * Many drivers split up the page into fragments, and some
   618		 * want to keep doing this to save memory and do refcnt based
   619		 * recycling. Support this use case too, to ease drivers
   620		 * switching between XDP/non-XDP.
   621		 *
   622		 * In-case page_pool maintains the DMA mapping, API user must
   623		 * call page_pool_put_page once.  In this elevated refcnt
   624		 * case, the DMA is unmapped/released, as driver is likely
   625		 * doing refcnt based recycle tricks, meaning another process
   626		 * will be invoking put_page.
   627		 */
   628		recycle_stat_inc(pool, released_refcnt);
   629		page_pool_return_page(pool, page);
   630	
   631		return NULL;
   632	}
   633	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
