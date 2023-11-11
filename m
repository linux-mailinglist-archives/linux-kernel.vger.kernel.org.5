Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CBC7E8B29
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 15:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjKKOPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 09:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKKOPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 09:15:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05473C05
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 06:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699712135; x=1731248135;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5CEEfEIychYF5x2qkMMhB3HgC0jduqvP974BRGIngU0=;
  b=h5QKyNifUP57uCCacpEqlf2HB9oz8gszjKXj/dytNKGYm7yTwc1bpccq
   D0cd88tX7uOic3Tn3R3uS86psLxzDrxM/Du1tIdEkdPcokWK7t2fymM/E
   0SVhYc60+m3Uoz0Qn/Z4s7evOZDxhiiOKomA7JvfSrBtMemlllYIPEjhP
   5F/4dQe8ppzTp5K9bRwNkgQ1o5rSAuec5fIH3DB49K42y2+d/rPvrIuQy
   NddovKKEAoL7v+V1ld7S9XuXL8HJSYNvH9j+RoKRU94r+e4XSDjDftf11
   oN6LZzE/pG7O4EVan0wx+LlwmNlJsy3BgSRpY+4TseXDm8ovS8D/xBRbH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="394182646"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="394182646"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 06:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="907662152"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="907662152"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Nov 2023 06:15:32 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1olm-000AV3-1F;
        Sat, 11 Nov 2023 14:15:30 +0000
Date:   Sat, 11 Nov 2023 22:14:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Juergen Gross <jgross@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: mm/memory.c:546:9: sparse: sparse: incompatible types in conditional
 expression (different base types):
Message-ID: <202311112212.e0L5bYF8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: fdc0269e8958a1ec95b8ac685c1d372c24c60faa x86/paravirt: Move the Xen-only pv_mmu_ops under the PARAVIRT_XXL umbrella
date:   5 years ago
config: x86_64-randconfig-x014-20230805 (https://download.01.org/0day-ci/archive/20231111/202311112212.e0L5bYF8-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311112212.e0L5bYF8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311112212.e0L5bYF8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   mm/memory.c:4731:22: sparse: sparse: cast removes address space '<asn:1>' of expression
>> mm/memory.c:546:9: sparse: sparse: incompatible types in conditional expression (different base types):
>> mm/memory.c:546:9: sparse:    void
>> mm/memory.c:546:9: sparse:    int
   mm/memory.o: warning: objtool: fault_around_bytes_set()+0x7a: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: print_bad_pte()+0xa4: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: __follow_pte_pmd()+0x72: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: wp_page_copy()+0x1076: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: do_set_pmd()+0x5ab: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: free_pgd_range()+0x13b: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: remap_pte_range()+0x2f2: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: do_anonymous_page()+0xd06: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: unmap_page_range()+0x92: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: alloc_set_pte()+0xa3a: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: remap_pfn_range()+0x275: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: apply_to_page_range()+0x8f: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: copy_page_range()+0x1bd: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: __get_locked_pte()+0x64: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: insert_pfn()+0x53e: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: insert_page()+0x4f7: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: __handle_mm_fault()+0x23f: sibling call from callable instruction with modified stack frame
   mm/memory.o: warning: objtool: print_vma_addr()+0x12e: sibling call from callable instruction with modified stack frame
--
>> mm/pgtable-generic.c:23:9: sparse: sparse: incompatible types in conditional expression (different base types):
>> mm/pgtable-generic.c:23:9: sparse:    void
>> mm/pgtable-generic.c:23:9: sparse:    int

vim +546 mm/memory.c

c2febafc67734a Kirill A. Shutemov 2017-03-09  516  
c2febafc67734a Kirill A. Shutemov 2017-03-09  517  static inline void free_p4d_range(struct mmu_gather *tlb, pgd_t *pgd,
c2febafc67734a Kirill A. Shutemov 2017-03-09  518  				unsigned long addr, unsigned long end,
c2febafc67734a Kirill A. Shutemov 2017-03-09  519  				unsigned long floor, unsigned long ceiling)
c2febafc67734a Kirill A. Shutemov 2017-03-09  520  {
c2febafc67734a Kirill A. Shutemov 2017-03-09  521  	p4d_t *p4d;
c2febafc67734a Kirill A. Shutemov 2017-03-09  522  	unsigned long next;
c2febafc67734a Kirill A. Shutemov 2017-03-09  523  	unsigned long start;
c2febafc67734a Kirill A. Shutemov 2017-03-09  524  
c2febafc67734a Kirill A. Shutemov 2017-03-09  525  	start = addr;
c2febafc67734a Kirill A. Shutemov 2017-03-09  526  	p4d = p4d_offset(pgd, addr);
c2febafc67734a Kirill A. Shutemov 2017-03-09  527  	do {
c2febafc67734a Kirill A. Shutemov 2017-03-09  528  		next = p4d_addr_end(addr, end);
c2febafc67734a Kirill A. Shutemov 2017-03-09  529  		if (p4d_none_or_clear_bad(p4d))
c2febafc67734a Kirill A. Shutemov 2017-03-09  530  			continue;
c2febafc67734a Kirill A. Shutemov 2017-03-09  531  		free_pud_range(tlb, p4d, addr, next, floor, ceiling);
c2febafc67734a Kirill A. Shutemov 2017-03-09  532  	} while (p4d++, addr = next, addr != end);
c2febafc67734a Kirill A. Shutemov 2017-03-09  533  
e0da382c92626a Hugh Dickins       2005-04-19  534  	start &= PGDIR_MASK;
e0da382c92626a Hugh Dickins       2005-04-19  535  	if (start < floor)
e0da382c92626a Hugh Dickins       2005-04-19  536  		return;
e0da382c92626a Hugh Dickins       2005-04-19  537  	if (ceiling) {
e0da382c92626a Hugh Dickins       2005-04-19  538  		ceiling &= PGDIR_MASK;
e0da382c92626a Hugh Dickins       2005-04-19  539  		if (!ceiling)
e0da382c92626a Hugh Dickins       2005-04-19  540  			return;
^1da177e4c3f41 Linus Torvalds     2005-04-16  541  	}
e0da382c92626a Hugh Dickins       2005-04-19  542  	if (end - 1 > ceiling - 1)
e0da382c92626a Hugh Dickins       2005-04-19  543  		return;
e0da382c92626a Hugh Dickins       2005-04-19  544  
c2febafc67734a Kirill A. Shutemov 2017-03-09  545  	p4d = p4d_offset(pgd, start);
e0da382c92626a Hugh Dickins       2005-04-19 @546  	pgd_clear(pgd);
c2febafc67734a Kirill A. Shutemov 2017-03-09  547  	p4d_free_tlb(tlb, p4d, start);
^1da177e4c3f41 Linus Torvalds     2005-04-16  548  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  549  

:::::: The code at line 546 was first introduced by commit
:::::: e0da382c92626ad1d7f4b7527d19b80104d67a83 [PATCH] freepgt: free_pgtables use vma list

:::::: TO: Hugh Dickins <hugh@veritas.com>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org.(none)>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
