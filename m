Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9579D7B2568
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjI1SjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1SjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:39:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8257BF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695926339; x=1727462339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SRt0ApsPLAejTe4DqWKL3dO8veOZGbj20kTrfbpeBR0=;
  b=d05n0hM9nKavEDGIUh+YOI9ANOrBjiq8S+gSadardZWW8/kHA58JHD2h
   1ADia9jwrVDfnx+4ZfZaWdemcf2xZtgV/RyfGlu0ncpKUAI8gqCqtOVGn
   eGI25Vu0dVPv1r68IAqUE7wVh4JDMsIaDLXEwZ1l2Z7WEKqvR9NCvYpu/
   oHjK7a++fKH4uKRpx9SPj6iQxPECnjKk/IpkgBY1hghNIE59GfGHm2ZYq
   EyaTlVngWMOoRdjV/OXxe57o6etoGTIbnb5QfopSqGioZtESCWFE+81H5
   3/0F4ebNxbTC6HshTSPIDlXGgg4OSXW6Ev6yt8jPK6xREUH2Q3F8Omq4K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="468427171"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="468427171"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="840005518"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="840005518"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Sep 2023 11:34:21 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlvq6-0001nx-2p;
        Thu, 28 Sep 2023 18:34:18 +0000
Date:   Fri, 29 Sep 2023 02:33:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Ene <sebastianene@google.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kernel-team@android.com,
        will@kernel.org, ryan.roberts@arm.com, mark.rutland@arm.com,
        maz@kernel.org, vdonnefort@google.com,
        Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH 01/11] KVM: arm64: Add snap shooting the host stage-2
 pagetables
Message-ID: <202309290210.m6jkiTXx-lkp@intel.com>
References: <20230927112517.2631674-2-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927112517.2631674-2-sebastianene@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on kvmarm/next linus/master v6.6-rc3 next-20230928]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Ene/KVM-arm64-Add-snap-shooting-the-host-stage-2-pagetables/20230927-192734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230927112517.2631674-2-sebastianene%40google.com
patch subject: [PATCH 01/11] KVM: arm64: Add snap shooting the host stage-2 pagetables
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20230929/202309290210.m6jkiTXx-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309290210.m6jkiTXx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309290210.m6jkiTXx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm64/kvm/hyp/nvhe/mem_protect.c: In function '__pkvm_host_stage2_prepare_copy':
>> arch/arm64/kvm/hyp/nvhe/mem_protect.c:335:13: warning: variable 'nr_pages' set but not used [-Wunused-but-set-variable]
     335 |         u64 nr_pages;
         |             ^~~~~~~~


vim +/nr_pages +335 arch/arm64/kvm/hyp/nvhe/mem_protect.c

   326	
   327	int __pkvm_host_stage2_prepare_copy(struct kvm_pgtable_snapshot *snapshot)
   328	{
   329		size_t required_pgd_len;
   330		struct kvm_pgtable_mm_ops mm_ops = {0};
   331		struct kvm_pgtable *to_pgt, *from_pgt = &host_mmu.pgt;
   332		struct kvm_hyp_memcache *memcache = &snapshot->mc;
   333		int ret;
   334		void *pgd;
 > 335		u64 nr_pages;
   336	
   337		required_pgd_len = kvm_pgtable_stage2_pgd_size(host_mmu.arch.vtcr);
   338		if (snapshot->pgd_len < required_pgd_len)
   339			return -ENOMEM;
   340	
   341		to_pgt = &snapshot->pgtable;
   342		nr_pages = snapshot->pgd_len / PAGE_SIZE;
   343		pgd = kern_hyp_va(snapshot->pgd_hva);
   344	
   345		hyp_spin_lock(&snapshot_pool_lock);
   346		hyp_pool_init(&snapshot_pool, hyp_virt_to_pfn(pgd),
   347			      required_pgd_len / PAGE_SIZE, 0);
   348	
   349		mm_ops.zalloc_pages_exact	= snapshot_zalloc_pages_exact;
   350		mm_ops.zalloc_page		= snapshot_zalloc_page;
   351		mm_ops.free_pages_exact		= snapshot_s2_free_pages_exact;
   352		mm_ops.get_page			= snapshot_get_page;
   353		mm_ops.phys_to_virt		= hyp_phys_to_virt;
   354		mm_ops.virt_to_phys		= hyp_virt_to_phys;
   355		mm_ops.page_count		= hyp_page_count;
   356	
   357		to_pgt->ia_bits		= from_pgt->ia_bits;
   358		to_pgt->start_level	= from_pgt->start_level;
   359		to_pgt->flags		= from_pgt->flags;
   360		to_pgt->mm_ops		= &mm_ops;
   361	
   362		host_lock_component();
   363		ret = kvm_pgtable_stage2_copy(to_pgt, from_pgt, memcache);
   364		host_unlock_component();
   365	
   366		hyp_spin_unlock(&snapshot_pool_lock);
   367	
   368		return ret;
   369	}
   370	#endif /* CONFIG_NVHE_EL2_DEBUG */
   371	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
