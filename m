Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916367BC11D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjJFVYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjJFVYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:24:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6791BBD
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696627476; x=1728163476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1Psy2C2aTvkgnSZqqjPhE9HbAlfK2qW6c1GRy7Acf/I=;
  b=QyTTbZ4dQaKgvXJpk1KKUh6tcEve2pTkvoKYhU66Jdq7VvHYEvpgkJME
   YSbCtWFaId89Kx+zHOb4MB8a372RySLU7hjtFPco7wvlSdVIT3qpNuOfr
   9FnCv90t/wTus/p+tXzfNld1AFliwGhWU7n2Xgdi2QV2mjj5eqN8VkCAC
   5jJ3i16c2PHwRQVUVDEmCwlneXmTgRHFNLh8eU3hhdr8zvFllHuk32M32
   NgPKts7Nsy+316dQT4MKt+pX0f5abe9qoCP/aclq69vJDf/F7ISZ9JZM9
   7IVN5cYbKWeywViFHFKYSswY2pTm/WLDNj8yQI1CmkM77NdqkYrlV1+qS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="363184793"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="363184793"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 14:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="752306985"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="752306985"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Oct 2023 14:24:33 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qosJD-0003fA-0Y;
        Fri, 06 Oct 2023 21:24:31 +0000
Date:   Sat, 7 Oct 2023 05:23:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: arch/mips/kvm/mmu.c:701:29: warning: variable 'old_pte' set but not
 used
Message-ID: <202310070530.aARZCSfh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   af95dc6fdc25e616051d0234aad638e15c02ec8f
commit: 0f78355c450835053fed85828c9d6526594c0921 KVM: MIPS: Enable KVM support for Loongson-3
date:   3 years, 4 months ago
config: mips-loongson3_defconfig (https://download.01.org/0day-ci/archive/20231007/202310070530.aARZCSfh-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070530.aARZCSfh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310070530.aARZCSfh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:6,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:18,
                    from include/linux/fs.h:15,
                    from include/linux/highmem.h:5,
                    from arch/mips/kvm/mmu.c:12:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1201:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1201 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1187:27: note: 'mem_section' declared here
    1187 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   arch/mips/kvm/mmu.c: In function 'kvm_mips_map_page':
>> arch/mips/kvm/mmu.c:701:29: warning: variable 'old_pte' set but not used [-Wunused-but-set-variable]
     701 |         pte_t *ptep, entry, old_pte;
         |                             ^~~~~~~
--
   In file included from include/linux/topology.h:33,
                    from include/linux/irq.h:19,
                    from include/asm-generic/hardirq.h:13,
                    from arch/mips/include/asm/hardirq.h:16,
                    from include/linux/hardirq.h:10,
                    from include/linux/kvm_host.h:7,
                    from arch/mips/kvm/loongson_ipi.c:11:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1201:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1201 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1187:27: note: 'mem_section' declared here
    1187 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   arch/mips/kvm/loongson_ipi.c: At top level:
>> arch/mips/kvm/loongson_ipi.c:190:6: warning: no previous prototype for 'kvm_init_loongson_ipi' [-Wmissing-prototypes]
     190 | void kvm_init_loongson_ipi(struct kvm *kvm)
         |      ^~~~~~~~~~~~~~~~~~~~~
--
>> arch/mips/kvm/emulate.c:274: warning: Function parameter or member 'out' not described in 'kvm_get_badinstr'
>> arch/mips/kvm/emulate.c:295: warning: Function parameter or member 'out' not described in 'kvm_get_badinstrp'
>> arch/mips/kvm/emulate.c:328: warning: Function parameter or member 'vcpu' not described in 'kvm_mips_ktime_to_count'
>> arch/mips/kvm/emulate.c:328: warning: Function parameter or member 'now' not described in 'kvm_mips_ktime_to_count'
   arch/mips/kvm/emulate.c:2376: warning: Function parameter or member 'vcpu' not described in 'kvm_mips_guest_exception_base'


vim +/old_pte +701 arch/mips/kvm/mmu.c

b5f1dd1ba4042bda James Hogan 2016-12-06  667  
06c158c96ed8909a James Hogan 2015-05-01  668  /**
06c158c96ed8909a James Hogan 2015-05-01  669   * kvm_mips_map_page() - Map a guest physical page.
06c158c96ed8909a James Hogan 2015-05-01  670   * @vcpu:		VCPU pointer.
06c158c96ed8909a James Hogan 2015-05-01  671   * @gpa:		Guest physical address of fault.
577ed7f71e9c37a4 James Hogan 2015-05-01  672   * @write_fault:	Whether the fault was due to a write.
06c158c96ed8909a James Hogan 2015-05-01  673   * @out_entry:		New PTE for @gpa (written on success unless NULL).
06c158c96ed8909a James Hogan 2015-05-01  674   * @out_buddy:		New PTE for @gpa's buddy (written on success unless
06c158c96ed8909a James Hogan 2015-05-01  675   *			NULL).
06c158c96ed8909a James Hogan 2015-05-01  676   *
06c158c96ed8909a James Hogan 2015-05-01  677   * Handle GPA faults by creating a new GPA mapping (or updating an existing
06c158c96ed8909a James Hogan 2015-05-01  678   * one).
06c158c96ed8909a James Hogan 2015-05-01  679   *
411740f5422a960c James Hogan 2016-12-13  680   * This takes care of marking pages young or dirty (idle/dirty page tracking),
411740f5422a960c James Hogan 2016-12-13  681   * asking KVM for the corresponding PFN, and creating a mapping in the GPA page
411740f5422a960c James Hogan 2016-12-13  682   * tables. Derived mappings (GVA page tables and TLBs) must be handled by the
411740f5422a960c James Hogan 2016-12-13  683   * caller.
06c158c96ed8909a James Hogan 2015-05-01  684   *
06c158c96ed8909a James Hogan 2015-05-01  685   * Returns:	0 on success, in which case the caller may use the @out_entry
06c158c96ed8909a James Hogan 2015-05-01  686   *		and @out_buddy PTEs to update derived mappings and resume guest
06c158c96ed8909a James Hogan 2015-05-01  687   *		execution.
06c158c96ed8909a James Hogan 2015-05-01  688   *		-EFAULT if there is no memory region at @gpa or a write was
06c158c96ed8909a James Hogan 2015-05-01  689   *		attempted to a read-only memory region. This is usually handled
06c158c96ed8909a James Hogan 2015-05-01  690   *		as an MMIO access.
06c158c96ed8909a James Hogan 2015-05-01  691   */
06c158c96ed8909a James Hogan 2015-05-01  692  static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
577ed7f71e9c37a4 James Hogan 2015-05-01  693  			     bool write_fault,
06c158c96ed8909a James Hogan 2015-05-01  694  			     pte_t *out_entry, pte_t *out_buddy)
06c158c96ed8909a James Hogan 2015-05-01  695  {
06c158c96ed8909a James Hogan 2015-05-01  696  	struct kvm *kvm = vcpu->kvm;
06c158c96ed8909a James Hogan 2015-05-01  697  	struct kvm_mmu_memory_cache *memcache = &vcpu->arch.mmu_page_cache;
06c158c96ed8909a James Hogan 2015-05-01  698  	gfn_t gfn = gpa >> PAGE_SHIFT;
06c158c96ed8909a James Hogan 2015-05-01  699  	int srcu_idx, err;
06c158c96ed8909a James Hogan 2015-05-01  700  	kvm_pfn_t pfn;
06c158c96ed8909a James Hogan 2015-05-01 @701  	pte_t *ptep, entry, old_pte;
411740f5422a960c James Hogan 2016-12-13  702  	bool writeable;
06c158c96ed8909a James Hogan 2015-05-01  703  	unsigned long prot_bits;
411740f5422a960c James Hogan 2016-12-13  704  	unsigned long mmu_seq;
403015b323a29747 James Hogan 2016-06-09  705  
411740f5422a960c James Hogan 2016-12-13  706  	/* Try the fast path to handle old / clean pages */
403015b323a29747 James Hogan 2016-06-09  707  	srcu_idx = srcu_read_lock(&kvm->srcu);
b5f1dd1ba4042bda James Hogan 2016-12-06  708  	err = _kvm_mips_map_page_fast(vcpu, gpa, write_fault, out_entry,
b5f1dd1ba4042bda James Hogan 2016-12-06  709  				      out_buddy);
b5f1dd1ba4042bda James Hogan 2016-12-06  710  	if (!err)
b5f1dd1ba4042bda James Hogan 2016-12-06  711  		goto out;
06c158c96ed8909a James Hogan 2015-05-01  712  
06c158c96ed8909a James Hogan 2015-05-01  713  	/* We need a minimum of cached pages ready for page table creation */
06c158c96ed8909a James Hogan 2015-05-01  714  	err = mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES,
06c158c96ed8909a James Hogan 2015-05-01  715  				     KVM_NR_MEM_OBJS);
06c158c96ed8909a James Hogan 2015-05-01  716  	if (err)
06c158c96ed8909a James Hogan 2015-05-01  717  		goto out;
06c158c96ed8909a James Hogan 2015-05-01  718  
411740f5422a960c James Hogan 2016-12-13  719  retry:
411740f5422a960c James Hogan 2016-12-13  720  	/*
411740f5422a960c James Hogan 2016-12-13  721  	 * Used to check for invalidations in progress, of the pfn that is
411740f5422a960c James Hogan 2016-12-13  722  	 * returned by pfn_to_pfn_prot below.
411740f5422a960c James Hogan 2016-12-13  723  	 */
411740f5422a960c James Hogan 2016-12-13  724  	mmu_seq = kvm->mmu_notifier_seq;
411740f5422a960c James Hogan 2016-12-13  725  	/*
411740f5422a960c James Hogan 2016-12-13  726  	 * Ensure the read of mmu_notifier_seq isn't reordered with PTE reads in
411740f5422a960c James Hogan 2016-12-13  727  	 * gfn_to_pfn_prot() (which calls get_user_pages()), so that we don't
411740f5422a960c James Hogan 2016-12-13  728  	 * risk the page we get a reference to getting unmapped before we have a
411740f5422a960c James Hogan 2016-12-13  729  	 * chance to grab the mmu_lock without mmu_notifier_retry() noticing.
411740f5422a960c James Hogan 2016-12-13  730  	 *
411740f5422a960c James Hogan 2016-12-13  731  	 * This smp_rmb() pairs with the effective smp_wmb() of the combination
411740f5422a960c James Hogan 2016-12-13  732  	 * of the pte_unmap_unlock() after the PTE is zapped, and the
411740f5422a960c James Hogan 2016-12-13  733  	 * spin_lock() in kvm_mmu_notifier_invalidate_<page|range_end>() before
411740f5422a960c James Hogan 2016-12-13  734  	 * mmu_notifier_seq is incremented.
411740f5422a960c James Hogan 2016-12-13  735  	 */
411740f5422a960c James Hogan 2016-12-13  736  	smp_rmb();
403015b323a29747 James Hogan 2016-06-09  737  
411740f5422a960c James Hogan 2016-12-13  738  	/* Slow path - ask KVM core whether we can access this GPA */
411740f5422a960c James Hogan 2016-12-13  739  	pfn = gfn_to_pfn_prot(kvm, gfn, write_fault, &writeable);
ba913e4f72fc9cfd James Hogan 2016-08-19  740  	if (is_error_noslot_pfn(pfn)) {
403015b323a29747 James Hogan 2016-06-09  741  		err = -EFAULT;
403015b323a29747 James Hogan 2016-06-09  742  		goto out;
403015b323a29747 James Hogan 2016-06-09  743  	}
403015b323a29747 James Hogan 2016-06-09  744  
06c158c96ed8909a James Hogan 2015-05-01  745  	spin_lock(&kvm->mmu_lock);
411740f5422a960c James Hogan 2016-12-13  746  	/* Check if an invalidation has taken place since we got pfn */
411740f5422a960c James Hogan 2016-12-13  747  	if (mmu_notifier_retry(kvm, mmu_seq)) {
411740f5422a960c James Hogan 2016-12-13  748  		/*
411740f5422a960c James Hogan 2016-12-13  749  		 * This can happen when mappings are changed asynchronously, but
411740f5422a960c James Hogan 2016-12-13  750  		 * also synchronously if a COW is triggered by
411740f5422a960c James Hogan 2016-12-13  751  		 * gfn_to_pfn_prot().
411740f5422a960c James Hogan 2016-12-13  752  		 */
411740f5422a960c James Hogan 2016-12-13  753  		spin_unlock(&kvm->mmu_lock);
411740f5422a960c James Hogan 2016-12-13  754  		kvm_release_pfn_clean(pfn);
411740f5422a960c James Hogan 2016-12-13  755  		goto retry;
411740f5422a960c James Hogan 2016-12-13  756  	}
06c158c96ed8909a James Hogan 2015-05-01  757  
b5f1dd1ba4042bda James Hogan 2016-12-06  758  	/* Ensure page tables are allocated */
06c158c96ed8909a James Hogan 2015-05-01  759  	ptep = kvm_mips_pte_for_gpa(kvm, memcache, gpa);
06c158c96ed8909a James Hogan 2015-05-01  760  
b5f1dd1ba4042bda James Hogan 2016-12-06  761  	/* Set up the PTE */
411740f5422a960c James Hogan 2016-12-13  762  	prot_bits = _PAGE_PRESENT | __READABLE | _page_cachable_default;
411740f5422a960c James Hogan 2016-12-13  763  	if (writeable) {
411740f5422a960c James Hogan 2016-12-13  764  		prot_bits |= _PAGE_WRITE;
b5f1dd1ba4042bda James Hogan 2016-12-06  765  		if (write_fault) {
b5f1dd1ba4042bda James Hogan 2016-12-06  766  			prot_bits |= __WRITEABLE;
b5f1dd1ba4042bda James Hogan 2016-12-06  767  			mark_page_dirty(kvm, gfn);
411740f5422a960c James Hogan 2016-12-13  768  			kvm_set_pfn_dirty(pfn);
411740f5422a960c James Hogan 2016-12-13  769  		}
b5f1dd1ba4042bda James Hogan 2016-12-06  770  	}
06c158c96ed8909a James Hogan 2015-05-01  771  	entry = pfn_pte(pfn, __pgprot(prot_bits));
06c158c96ed8909a James Hogan 2015-05-01  772  
b5f1dd1ba4042bda James Hogan 2016-12-06  773  	/* Write the PTE */
06c158c96ed8909a James Hogan 2015-05-01  774  	old_pte = *ptep;
06c158c96ed8909a James Hogan 2015-05-01  775  	set_pte(ptep, entry);
06c158c96ed8909a James Hogan 2015-05-01  776  
06c158c96ed8909a James Hogan 2015-05-01  777  	err = 0;
06c158c96ed8909a James Hogan 2015-05-01  778  	if (out_entry)
06c158c96ed8909a James Hogan 2015-05-01  779  		*out_entry = *ptep;
06c158c96ed8909a James Hogan 2015-05-01  780  	if (out_buddy)
06c158c96ed8909a James Hogan 2015-05-01  781  		*out_buddy = *ptep_buddy(ptep);
06c158c96ed8909a James Hogan 2015-05-01  782  
06c158c96ed8909a James Hogan 2015-05-01  783  	spin_unlock(&kvm->mmu_lock);
411740f5422a960c James Hogan 2016-12-13  784  	kvm_release_pfn_clean(pfn);
411740f5422a960c James Hogan 2016-12-13  785  	kvm_set_pfn_accessed(pfn);
403015b323a29747 James Hogan 2016-06-09  786  out:
403015b323a29747 James Hogan 2016-06-09  787  	srcu_read_unlock(&kvm->srcu, srcu_idx);
403015b323a29747 James Hogan 2016-06-09  788  	return err;
403015b323a29747 James Hogan 2016-06-09  789  }
403015b323a29747 James Hogan 2016-06-09  790  

:::::: The code at line 701 was first introduced by commit
:::::: 06c158c96ed8909a1d8696d4f953ca8a9ef55574 KVM: MIPS/MMU: Convert guest physical map to page table

:::::: TO: James Hogan <james.hogan@imgtec.com>
:::::: CC: James Hogan <james.hogan@imgtec.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
