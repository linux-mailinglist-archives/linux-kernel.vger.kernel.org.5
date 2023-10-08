Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D527BCBAB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 04:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344269AbjJHCIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 22:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHCIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 22:08:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ACA92
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 19:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696730925; x=1728266925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HyXXI6JtABP1sR+hdCxAiIXCjGu2h/ii26y/g2GA900=;
  b=egQDqUOGLGik6FqBdaQ0rxNnjDxM2RAlJsYCIm8+ftN/jQHorJMVxaP7
   N/A21ohshUhMCoJbaIEpz5qN94WJ4bXrjd21RFQ8OlS+uvYv6FMgu0dlL
   nLHb7TY8BD4HS5SPLagX6XeslMahfScfBDWv6Yln/m5sXx+nXvhNP+R50
   5NbmJ71uFtLl89F0xj0LakfAdpEkiOBmA7BkCWmwr9VHxbvKIQCHOYb4S
   1a73vwMQttMWxCagpS1SGnJZDlHP/GJZnWZxaLCX4zeyN5jk7k51zfJNR
   iiJ1vjgeh7auks3FEn4WnEHL0N/HFWOvFQjdb3KmfSstH1cPrD3JhnYam
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="382841742"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="382841742"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 19:08:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="787806974"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="787806974"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Oct 2023 19:08:43 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpJDk-00052X-2f;
        Sun, 08 Oct 2023 02:08:40 +0000
Date:   Sun, 8 Oct 2023 10:08:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nouveau_dmem.c:205:13: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202310081010.okVQwwej-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b9ddbb0cde2adcedda26045cc58f31316a492215
commit: d9b719394a1147614351961ac454589111c76e76 nouveau/dmem: refactor nouveau_dmem_fault_copy_one()
date:   12 months ago
config: x86_64-randconfig-123-20231008 (https://download.01.org/0day-ci/archive/20231008/202310081010.okVQwwej-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231008/202310081010.okVQwwej-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310081010.okVQwwej-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/nouveau_dmem.c:205:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted vm_fault_t [usertype] ret @@     got int @@
   drivers/gpu/drm/nouveau/nouveau_dmem.c:205:13: sparse:     expected restricted vm_fault_t [usertype] ret
   drivers/gpu/drm/nouveau/nouveau_dmem.c:205:13: sparse:     got int

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
