Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFD67DAA9A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 04:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjJ2Do5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 23:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2Doz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 23:44:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650ADC0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 20:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698551091; x=1730087091;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=85wMPL2uqOf5q59P0+uejAWZy7fKjuaP8kvR1uFbLUA=;
  b=VJl2GbIkCc/xAm67fd271LUhxLg8AcWJa0xSzFldnBAtXmcZdn3gvLim
   I6lxFv33bbvKWmfM3elN4f9iDb5sFzTXHEsbl40QawOfFaoiFKKNRQSgH
   wuIB+xtKIEbyV732GWCtB9tFShhXvBdaZNcGoXrdkxlTNcdT7DR0zzCTE
   PkQe4iCUTjDc+Bi0zW8hahKGP1T/O4VXE8FViGGKW8JFeip9yyD2lHBnw
   5lc1zAT8bNUB3KOSmJ/bgNzV7ooKOmkerndXwzoJDjLRM0p28xERld9NX
   ZLtENQRh+wNkVKAREobM7xO2AyzcIoh6m47saj+6/w0sUx7B79Q7P6SRe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="767965"
X-IronPort-AV: E=Sophos;i="6.03,260,1694761200"; 
   d="scan'208";a="767965"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 20:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="933474924"
X-IronPort-AV: E=Sophos;i="6.03,260,1694761200"; 
   d="scan'208";a="933474924"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Oct 2023 20:44:48 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwwjF-000CJ5-2c;
        Sun, 29 Oct 2023 03:44:45 +0000
Date:   Sun, 29 Oct 2023 11:44:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Karolina Stolarek <karolina.stolarek@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: drivers/gpu/drm/ttm/ttm_bo_util.c:318:38: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <202310291100.L4qywPt5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2af9b20dbb39f6ebf9b9b6c090271594627d818e
commit: e3912d09bf8ddd8e274118d4c9cc550d9665115d drm/ttm: Introduce KUnit test
date:   3 months ago
config: x86_64-randconfig-123-20231016 (https://download.01.org/0day-ci/archive/20231029/202310291100.L4qywPt5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231029/202310291100.L4qywPt5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310291100.L4qywPt5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/ttm/ttm_bo_util.c:318:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *virtual @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:318:38: sparse:     expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:318:38: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:321:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *virtual @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:321:38: sparse:     expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:321:38: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:324:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *virtual @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:324:38: sparse:     expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:324:38: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/ttm/ttm_bo_util.c:427:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *virtual @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:427:28: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:427:28: sparse:     got void *virtual

vim +318 drivers/gpu/drm/ttm/ttm_bo_util.c

ba4e7d973dd09b Thomas Hellstrom      2009-06-10  302  
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  303  static int ttm_bo_ioremap(struct ttm_buffer_object *bo,
82c5da6bf8b55a Jerome Glisse         2010-04-09  304  			  unsigned long offset,
82c5da6bf8b55a Jerome Glisse         2010-04-09  305  			  unsigned long size,
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  306  			  struct ttm_bo_kmap_obj *map)
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  307  {
d3116756a710e3 Christian König       2021-04-12  308  	struct ttm_resource *mem = bo->resource;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  309  
d3116756a710e3 Christian König       2021-04-12  310  	if (bo->resource->bus.addr) {
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  311  		map->bo_kmap_type = ttm_bo_map_premapped;
d3116756a710e3 Christian König       2021-04-12  312  		map->virtual = ((u8 *)bo->resource->bus.addr) + offset;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  313  	} else {
d3116756a710e3 Christian König       2021-04-12  314  		resource_size_t res = bo->resource->bus.offset + offset;
d3116756a710e3 Christian König       2021-04-12  315  
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  316  		map->bo_kmap_type = ttm_bo_map_iomap;
ce65b874001d75 Christian König       2020-09-30  317  		if (mem->bus.caching == ttm_write_combined)
d3116756a710e3 Christian König       2021-04-12 @318  			map->virtual = ioremap_wc(res, size);
b849bec29a991d Oak Zeng              2021-02-26  319  #ifdef CONFIG_X86
b849bec29a991d Oak Zeng              2021-02-26  320  		else if (mem->bus.caching == ttm_cached)
d3116756a710e3 Christian König       2021-04-12  321  			map->virtual = ioremap_cache(res, size);
b849bec29a991d Oak Zeng              2021-02-26  322  #endif
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  323  		else
d3116756a710e3 Christian König       2021-04-12  324  			map->virtual = ioremap(res, size);
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  325  	}
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  326  	return (!map->virtual) ? -ENOMEM : 0;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  327  }
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  328  
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  329  static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  330  			   unsigned long start_page,
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  331  			   unsigned long num_pages,
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  332  			   struct ttm_bo_kmap_obj *map)
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  333  {
d3116756a710e3 Christian König       2021-04-12  334  	struct ttm_resource *mem = bo->resource;
d0cef9fa4411eb Roger He              2017-12-21  335  	struct ttm_operation_ctx ctx = {
d0cef9fa4411eb Roger He              2017-12-21  336  		.interruptible = false,
d0cef9fa4411eb Roger He              2017-12-21  337  		.no_wait_gpu = false
d0cef9fa4411eb Roger He              2017-12-21  338  	};
62975d27d647a4 Christian König       2020-08-12  339  	struct ttm_tt *ttm = bo->ttm;
d0cef9fa4411eb Roger He              2017-12-21  340  	pgprot_t prot;
b1e5f172325547 Jerome Glisse         2011-11-02  341  	int ret;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  342  
62975d27d647a4 Christian König       2020-08-12  343  	BUG_ON(!ttm);
b1e5f172325547 Jerome Glisse         2011-11-02  344  
0a667b500703db Dave Airlie           2020-08-25  345  	ret = ttm_tt_populate(bo->bdev, ttm, &ctx);
b1e5f172325547 Jerome Glisse         2011-11-02  346  	if (ret)
b1e5f172325547 Jerome Glisse         2011-11-02  347  		return ret;
b1e5f172325547 Jerome Glisse         2011-11-02  348  
ce65b874001d75 Christian König       2020-09-30  349  	if (num_pages == 1 && ttm->caching == ttm_cached) {
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  350  		/*
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  351  		 * We're mapping a single page, and the desired
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  352  		 * page protection is consistent with the bo.
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  353  		 */
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  354  
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  355  		map->bo_kmap_type = ttm_bo_map_kmap;
b1e5f172325547 Jerome Glisse         2011-11-02  356  		map->page = ttm->pages[start_page];
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  357  		map->virtual = kmap(map->page);
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  358  	} else {
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  359  		/*
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  360  		 * We need to use vmap to get the desired page protection
af901ca181d92a André Goddard Rosa    2009-11-14  361  		 * or to make the buffer object look contiguous.
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  362  		 */
867bcecd6ae463 Christian König       2020-09-30  363  		prot = ttm_io_prot(bo, mem, PAGE_KERNEL);
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  364  		map->bo_kmap_type = ttm_bo_map_vmap;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  365  		map->virtual = vmap(ttm->pages + start_page, num_pages,
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  366  				    0, prot);
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  367  	}
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  368  	return (!map->virtual) ? -ENOMEM : 0;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  369  }
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  370  
a3185f91d0579b Christian König       2022-05-09  371  /**
a3185f91d0579b Christian König       2022-05-09  372   * ttm_bo_kmap
a3185f91d0579b Christian König       2022-05-09  373   *
a3185f91d0579b Christian König       2022-05-09  374   * @bo: The buffer object.
a3185f91d0579b Christian König       2022-05-09  375   * @start_page: The first page to map.
a3185f91d0579b Christian König       2022-05-09  376   * @num_pages: Number of pages to map.
a3185f91d0579b Christian König       2022-05-09  377   * @map: pointer to a struct ttm_bo_kmap_obj representing the map.
a3185f91d0579b Christian König       2022-05-09  378   *
a3185f91d0579b Christian König       2022-05-09  379   * Sets up a kernel virtual mapping, using ioremap, vmap or kmap to the
a3185f91d0579b Christian König       2022-05-09  380   * data in the buffer object. The ttm_kmap_obj_virtual function can then be
a3185f91d0579b Christian König       2022-05-09  381   * used to obtain a virtual address to the data.
a3185f91d0579b Christian König       2022-05-09  382   *
a3185f91d0579b Christian König       2022-05-09  383   * Returns
a3185f91d0579b Christian König       2022-05-09  384   * -ENOMEM: Out of memory.
a3185f91d0579b Christian König       2022-05-09  385   * -EINVAL: Invalid range.
a3185f91d0579b Christian König       2022-05-09  386   */
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  387  int ttm_bo_kmap(struct ttm_buffer_object *bo,
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  388  		unsigned long start_page, unsigned long num_pages,
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  389  		struct ttm_bo_kmap_obj *map)
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  390  {
82c5da6bf8b55a Jerome Glisse         2010-04-09  391  	unsigned long offset, size;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  392  	int ret;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  393  
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  394  	map->virtual = NULL;
82c5da6bf8b55a Jerome Glisse         2010-04-09  395  	map->bo = bo;
e3c92eb4a84fb0 Somalapuram Amaranath 2022-10-27  396  	if (num_pages > PFN_UP(bo->resource->size))
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  397  		return -EINVAL;
e3c92eb4a84fb0 Somalapuram Amaranath 2022-10-27  398  	if ((start_page + num_pages) > PFN_UP(bo->resource->size))
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  399  		return -EINVAL;
02b29caf18b3b0 Huang Rui             2018-08-15  400  
d3116756a710e3 Christian König       2021-04-12  401  	ret = ttm_mem_io_reserve(bo->bdev, bo->resource);
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  402  	if (ret)
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  403  		return ret;
d3116756a710e3 Christian König       2021-04-12  404  	if (!bo->resource->bus.is_iomem) {
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  405  		return ttm_bo_kmap_ttm(bo, start_page, num_pages, map);
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  406  	} else {
82c5da6bf8b55a Jerome Glisse         2010-04-09  407  		offset = start_page << PAGE_SHIFT;
82c5da6bf8b55a Jerome Glisse         2010-04-09  408  		size = num_pages << PAGE_SHIFT;
82c5da6bf8b55a Jerome Glisse         2010-04-09  409  		return ttm_bo_ioremap(bo, offset, size, map);
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  410  	}
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  411  }
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  412  EXPORT_SYMBOL(ttm_bo_kmap);
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  413  
a3185f91d0579b Christian König       2022-05-09  414  /**
a3185f91d0579b Christian König       2022-05-09  415   * ttm_bo_kunmap
a3185f91d0579b Christian König       2022-05-09  416   *
a3185f91d0579b Christian König       2022-05-09  417   * @map: Object describing the map to unmap.
a3185f91d0579b Christian König       2022-05-09  418   *
a3185f91d0579b Christian König       2022-05-09  419   * Unmaps a kernel map set up by ttm_bo_kmap.
a3185f91d0579b Christian König       2022-05-09  420   */
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  421  void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map)
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  422  {
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  423  	if (!map->virtual)
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  424  		return;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  425  	switch (map->bo_kmap_type) {
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  426  	case ttm_bo_map_iomap:
ba4e7d973dd09b Thomas Hellstrom      2009-06-10 @427  		iounmap(map->virtual);
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  428  		break;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  429  	case ttm_bo_map_vmap:
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  430  		vunmap(map->virtual);
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  431  		break;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  432  	case ttm_bo_map_kmap:
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  433  		kunmap(map->page);
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  434  		break;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  435  	case ttm_bo_map_premapped:
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  436  		break;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  437  	default:
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  438  		BUG();
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  439  	}
d3116756a710e3 Christian König       2021-04-12  440  	ttm_mem_io_free(map->bo->bdev, map->bo->resource);
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  441  	map->virtual = NULL;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  442  	map->page = NULL;
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  443  }
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  444  EXPORT_SYMBOL(ttm_bo_kunmap);
ba4e7d973dd09b Thomas Hellstrom      2009-06-10  445  

:::::: The code at line 318 was first introduced by commit
:::::: d3116756a710e3cd51293a9d58b525957ab7e784 drm/ttm: rename bo->mem and make it a pointer

:::::: TO: Christian König <christian.koenig@amd.com>
:::::: CC: Christian König <christian.koenig@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
