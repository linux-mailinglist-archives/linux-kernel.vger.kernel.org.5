Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702C7779778
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbjHKTCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjHKTCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:02:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF1630CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691780550; x=1723316550;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JdaqUTLG7J6Ii6jWft0njQju/Abk9Tc7rYP0zUbx81A=;
  b=eceyPsx/Z3KL6jXshXAB7mxoGcIIkzRcoK4rKbBLIAnwS6Cv4G/cajEQ
   krNXH2C73XfihCuLxKxcAsTMSjef8FnsWTs0mZ9+VDlwvUaJ05kdd/Db8
   l+BvHedciuK+y/xfA9q/SSa3jPpEvxmaxWIzNSGimLQXiQohhioZPMbyr
   ddT+YSG+06PqfdoQZxcD/jCV7NvlvZoPkjzijQolftKpjOX8FMwzup8cm
   5Z1mTOyEXcz2W0SkccsBllyfiUQ/Wk4qU0ctA0JnhPpu5A6VKXhZs/fK0
   mdUFSxw6s4+V/Hrq2vV1ivvrljyn3kKurIK3lajLVueTof7TpG3tH6YvR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="402719676"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="402719676"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 12:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="802768890"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="802768890"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2023 12:01:50 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUXOP-0007xk-0F;
        Fri, 11 Aug 2023 19:01:49 +0000
Date:   Sat, 12 Aug 2023 03:01:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nouveau_dmem.c:205:13: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202308120234.ile8pRGe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9106536c1aa37bcf60202ad93bb8b94bcd29f3f0
commit: d9b719394a1147614351961ac454589111c76e76 nouveau/dmem: refactor nouveau_dmem_fault_copy_one()
date:   10 months ago
config: x86_64-randconfig-r072-20230811 (https://download.01.org/0day-ci/archive/20230812/202308120234.ile8pRGe-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308120234.ile8pRGe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308120234.ile8pRGe-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/nouveau_dmem.c:205:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted vm_fault_t [usertype] ret @@     got int @@
   drivers/gpu/drm/nouveau/nouveau_dmem.c:205:13: sparse:     expected restricted vm_fault_t [usertype] ret
   drivers/gpu/drm/nouveau/nouveau_dmem.c:205:13: sparse:     got int
   drivers/gpu/drm/nouveau/nouveau_dmem.c:409:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:409:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:413:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:413:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:426:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:426:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:430:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:430:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:454:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:454:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:481:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:481:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:485:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:485:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:494:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:494:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:494:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:494:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:503:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:503:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:503:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:508:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:508:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:510:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/nouveau/nouveau_dmem.c:510:9: sparse: sparse: cast removes address space '__iomem' of expression

vim +205 drivers/gpu/drm/nouveau/nouveau_dmem.c

   161	
   162	static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
   163	{
   164		struct nouveau_drm *drm = page_to_drm(vmf->page);
   165		struct nouveau_dmem *dmem = drm->dmem;
   166		struct nouveau_fence *fence;
   167		struct nouveau_svmm *svmm;
   168		struct page *spage, *dpage;
   169		unsigned long src = 0, dst = 0;
   170		dma_addr_t dma_addr = 0;
   171		vm_fault_t ret = 0;
   172		struct migrate_vma args = {
   173			.vma		= vmf->vma,
   174			.start		= vmf->address,
   175			.end		= vmf->address + PAGE_SIZE,
   176			.src		= &src,
   177			.dst		= &dst,
   178			.pgmap_owner	= drm->dev,
   179			.flags		= MIGRATE_VMA_SELECT_DEVICE_PRIVATE,
   180		};
   181	
   182		/*
   183		 * FIXME what we really want is to find some heuristic to migrate more
   184		 * than just one page on CPU fault. When such fault happens it is very
   185		 * likely that more surrounding page will CPU fault too.
   186		 */
   187		if (migrate_vma_setup(&args) < 0)
   188			return VM_FAULT_SIGBUS;
   189		if (!args.cpages)
   190			return 0;
   191	
   192		spage = migrate_pfn_to_page(src);
   193		if (!spage || !(src & MIGRATE_PFN_MIGRATE))
   194			goto done;
   195	
   196		dpage = alloc_page_vma(GFP_HIGHUSER, vmf->vma, vmf->address);
   197		if (!dpage)
   198			goto done;
   199	
   200		dst = migrate_pfn(page_to_pfn(dpage));
   201	
   202		svmm = spage->zone_device_data;
   203		mutex_lock(&svmm->mutex);
   204		nouveau_svmm_invalidate(svmm, args.start, args.end);
 > 205		ret = nouveau_dmem_copy_one(drm, spage, dpage, &dma_addr);
   206		mutex_unlock(&svmm->mutex);
   207		if (ret) {
   208			ret = VM_FAULT_SIGBUS;
   209			goto done;
   210		}
   211	
   212		nouveau_fence_new(dmem->migrate.chan, false, &fence);
   213		migrate_vma_pages(&args);
   214		nouveau_dmem_fence_done(&fence);
   215		dma_unmap_page(drm->dev->dev, dma_addr, PAGE_SIZE, DMA_BIDIRECTIONAL);
   216	done:
   217		migrate_vma_finalize(&args);
   218		return ret;
   219	}
   220	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
