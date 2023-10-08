Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE157BCF28
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbjJHPsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 11:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344819AbjJHPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 11:48:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283CAA6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 08:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696780087; x=1728316087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tVvqiNfxHr+TlOa0za4ipTl5ebhIBn6pg4NCzWQYEbk=;
  b=UQ18lW1USGnohvf492leAf1YZN1I1JQiZ95Zvn7VDStjUCKNe0R/zeVg
   3Ph500wNycAmN5DodUiJhGQY0fGG0j8LtxgmXQcDGZ4XUPYCIlAem0J65
   cFwMkw6DBXDt6WlDvwsxgng+9JGMS8FIH9nl200KuXdgOkegx8MfFvYKB
   bFwasDFNbBk2MB15nbP6pBDnopTbX9ZM5uCL7ntYkG69bepIfze7Oo1Ab
   B0Ayd67pUH+hke3YScR+3orkhtpLSdednXJnHyU/qiMZcvNmXgAPKW52k
   zgDsKaVG82RL6lVMajs2J23JC/l74w8e5JgWGv5YAksnWFAQIN07G3Um1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="386850184"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="386850184"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 08:48:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="843444880"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="843444880"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Oct 2023 08:48:03 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpW0f-0005Wf-1m;
        Sun, 08 Oct 2023 15:48:01 +0000
Date:   Sun, 8 Oct 2023 23:47:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "brookxu.cn" <brookxu.cn@gmail.com>, bsingharora@gmail.com,
        juri.lelli@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] delayacct: convert task->delays to a object
Message-ID: <202310082358.5mUe4Xjy-lkp@intel.com>
References: <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi brookxu.cn,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v6.6-rc4 next-20231006]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/brookxu-cn/delayacct-introduce-delayacct_enabled-to-simplify-implement/20231008-185144
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu%40shopee.com
patch subject: [PATCH 2/3] delayacct: convert task->delays to a object
config: arm64-randconfig-003-20231008 (https://download.01.org/0day-ci/archive/20231008/202310082358.5mUe4Xjy-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231008/202310082358.5mUe4Xjy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310082358.5mUe4Xjy-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kasan.h:33,
                    from include/linux/slab.h:180,
                    from include/linux/delayacct.h:62,
                    from include/linux/sched.h:40,
                    from arch/arm64/include/asm/mte.h:16,
                    from arch/arm64/include/asm/pgtable.h:12,
                    from arch/arm64/include/asm/vmalloc.h:5,
                    from include/linux/vmalloc.h:13,
                    from mm/vmalloc.c:11:
   include/linux/pgtable.h: In function 'pte_offset_kernel':
   include/linux/pgtable.h:94:25: error: implicit declaration of function 'pmd_page_vaddr'; did you mean 'pgd_page_vaddr'? [-Werror=implicit-function-declaration]
      94 |         return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
         |                         ^~~~~~~~~~~~~~
         |                         pgd_page_vaddr
   include/linux/pgtable.h:94:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
      94 |         return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
         |                ^
   include/linux/pgtable.h: In function 'pmd_offset':
   include/linux/pgtable.h:123:16: error: implicit declaration of function 'pud_pgtable'; did you mean 'p4d_pgtable'? [-Werror=implicit-function-declaration]
     123 |         return pud_pgtable(*pud) + pmd_index(address);
         |                ^~~~~~~~~~~
         |                p4d_pgtable
   include/linux/pgtable.h:123:34: warning: returning 'long unsigned int' from a function with return type 'pmd_t *' makes pointer from integer without a cast [-Wint-conversion]
     123 |         return pud_pgtable(*pud) + pmd_index(address);
         |                ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
   include/linux/pgtable.h: In function 'virt_to_kpte':
   include/linux/pgtable.h:177:16: error: implicit declaration of function 'pmd_none'; did you mean 'p4d_none'? [-Werror=implicit-function-declaration]
     177 |         return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
         |                ^~~~~~~~
         |                p4d_none
   In file included from arch/arm64/include/asm/kasan.h:10,
                    from arch/arm64/include/asm/processor.h:40,
                    from include/asm-generic/qrwlock.h:18,
                    from ./arch/arm64/include/generated/asm/qrwlock.h:1,
                    from arch/arm64/include/asm/spinlock.h:9,
                    from include/linux/spinlock.h:95,
                    from include/linux/vmalloc.h:5:
   include/linux/pgtable.h: In function 'pte_next_pfn':
   include/linux/pgtable.h:213:45: error: 'PFN_PTE_SHIFT' undeclared (first use in this function); did you mean 'CONT_PTE_SHIFT'?
     213 |         return __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
         |                                             ^~~~~~~~~~~~~
   arch/arm64/include/asm/pgtable-types.h:25:37: note: in definition of macro '__pte'
      25 | #define __pte(x)        ((pte_t) { (x) } )
         |                                     ^
   include/linux/pgtable.h:213:45: note: each undeclared identifier is reported only once for each function it appears in
     213 |         return __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
         |                                             ^~~~~~~~~~~~~
   arch/arm64/include/asm/pgtable-types.h:25:37: note: in definition of macro '__pte'
      25 | #define __pte(x)        ((pte_t) { (x) } )
         |                                     ^
   include/linux/pgtable.h: In function 'set_ptes':
   include/linux/pgtable.h:238:17: error: implicit declaration of function 'set_pte'; did you mean 'set_ptes'? [-Werror=implicit-function-declaration]
     238 |                 set_pte(ptep, pte);
         |                 ^~~~~~~
         |                 set_ptes
   include/linux/pgtable.h: In function 'ptep_test_and_clear_young':
   include/linux/pgtable.h:302:14: error: implicit declaration of function 'pte_young'; did you mean 'pmd_young'? [-Werror=implicit-function-declaration]
     302 |         if (!pte_young(pte))
         |              ^~~~~~~~~
         |              pmd_young
   include/linux/pgtable.h:305:55: error: implicit declaration of function 'pte_mkold' [-Werror=implicit-function-declaration]
     305 |                 set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
         |                                                       ^~~~~~~~~
   include/linux/pgtable.h:247:66: note: in definition of macro 'set_pte_at'
     247 | #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
         |                                                                  ^~~
   include/linux/pgtable.h:305:55: error: incompatible type for argument 4 of 'set_ptes'
     305 |                 set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
         |                                                       ^~~~~~~~~~~~~~
         |                                                       |
         |                                                       int
   include/linux/pgtable.h:247:66: note: in definition of macro 'set_pte_at'
     247 | #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
         |                                                                  ^~~
   include/linux/pgtable.h:232:36: note: expected 'pte_t' but argument is of type 'int'
     232 |                 pte_t *ptep, pte_t pte, unsigned int nr)
         |                              ~~~~~~^~~
   include/linux/pgtable.h: In function 'pmdp_test_and_clear_young':
>> include/linux/pgtable.h:321:17: error: implicit declaration of function 'set_pmd_at'; did you mean 'set_pte_at'? [-Werror=implicit-function-declaration]
     321 |                 set_pmd_at(vma->vm_mm, address, pmdp, pmd_mkold(pmd));
         |                 ^~~~~~~~~~
         |                 set_pte_at
>> include/linux/pgtable.h:321:55: error: implicit declaration of function 'pmd_mkold' [-Werror=implicit-function-declaration]
     321 |                 set_pmd_at(vma->vm_mm, address, pmdp, pmd_mkold(pmd));
         |                                                       ^~~~~~~~~
   include/linux/pgtable.h: In function 'ptep_get_and_clear':
   include/linux/pgtable.h:402:9: error: implicit declaration of function 'pte_clear'; did you mean 'p4d_clear'? [-Werror=implicit-function-declaration]
     402 |         pte_clear(mm, address, ptep);
         |         ^~~~~~~~~
         |         p4d_clear
   include/linux/pgtable.h: In function 'pmdp_huge_get_and_clear':
>> include/linux/pgtable.h:505:9: error: implicit declaration of function 'pmd_clear'; did you mean 'p4d_clear'? [-Werror=implicit-function-declaration]
     505 |         pmd_clear(pmdp);
         |         ^~~~~~~~~
         |         p4d_clear
   include/linux/pgtable.h: In function 'pudp_huge_get_and_clear':
>> include/linux/pgtable.h:518:9: error: implicit declaration of function 'pud_clear'; did you mean 'p4d_clear'? [-Werror=implicit-function-declaration]
     518 |         pud_clear(pudp);
         |         ^~~~~~~~~
         |         p4d_clear
   include/linux/pgtable.h: In function 'pte_mkwrite':
   include/linux/pgtable.h:605:16: error: implicit declaration of function 'pte_mkwrite_novma'; did you mean 'pte_mkwrite'? [-Werror=implicit-function-declaration]
     605 |         return pte_mkwrite_novma(pte);
         |                ^~~~~~~~~~~~~~~~~
         |                pte_mkwrite
   include/linux/pgtable.h:605:16: error: incompatible types when returning type 'int' but 'pte_t' was expected
     605 |         return pte_mkwrite_novma(pte);
         |                ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/pgtable.h: In function 'pmd_mkwrite':
>> include/linux/pgtable.h:612:16: error: implicit declaration of function 'pmd_mkwrite_novma'; did you mean 'pmd_mkwrite'? [-Werror=implicit-function-declaration]
     612 |         return pmd_mkwrite_novma(pmd);
         |                ^~~~~~~~~~~~~~~~~
         |                pmd_mkwrite
>> include/linux/pgtable.h:612:16: error: incompatible types when returning type 'int' but 'pmd_t' was expected
     612 |         return pmd_mkwrite_novma(pmd);
         |                ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/pgtable.h: In function 'ptep_set_wrprotect':
   include/linux/pgtable.h:621:39: error: implicit declaration of function 'pte_wrprotect'; did you mean 'ptep_set_wrprotect'? [-Werror=implicit-function-declaration]
     621 |         set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
         |                                       ^~~~~~~~~~~~~
   include/linux/pgtable.h:247:66: note: in definition of macro 'set_pte_at'
     247 | #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
         |                                                                  ^~~
   include/linux/pgtable.h:621:39: error: incompatible type for argument 4 of 'set_ptes'
     621 |         set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
         |                                       ^~~~~~~~~~~~~~~~~~~~~~
         |                                       |
         |                                       int
   include/linux/pgtable.h:247:66: note: in definition of macro 'set_pte_at'
     247 | #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
         |                                                                  ^~~
   include/linux/pgtable.h:232:36: note: expected 'pte_t' but argument is of type 'int'
     232 |                 pte_t *ptep, pte_t pte, unsigned int nr)
         |                              ~~~~~~^~~
   include/linux/pgtable.h: In function 'pmdp_set_wrprotect':
>> include/linux/pgtable.h:647:39: error: implicit declaration of function 'pmd_wrprotect'; did you mean 'pmdp_set_wrprotect'? [-Werror=implicit-function-declaration]
     647 |         set_pmd_at(mm, address, pmdp, pmd_wrprotect(old_pmd));
         |                                       ^~~~~~~~~~~~~
         |                                       pmdp_set_wrprotect
   include/linux/pgtable.h: In function 'pud_none_or_clear_bad':
   include/linux/pgtable.h:1015:13: error: implicit declaration of function 'pud_none'; did you mean 'p4d_none'? [-Werror=implicit-function-declaration]
    1015 |         if (pud_none(*pud))
         |             ^~~~~~~~
         |             p4d_none
   In file included from include/linux/export.h:5,
                    from include/linux/linkage.h:7,
                    from include/linux/preempt.h:10,
                    from include/linux/spinlock.h:56:
   include/linux/pgtable.h:1017:22: error: implicit declaration of function 'pud_bad'; did you mean 'p4d_bad'? [-Werror=implicit-function-declaration]
    1017 |         if (unlikely(pud_bad(*pud))) {
         |                      ^~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/pgtable.h: In function 'pmd_none_or_clear_bad':
   include/linux/pgtable.h:1028:22: error: implicit declaration of function 'pmd_bad'; did you mean 'p4d_bad'? [-Werror=implicit-function-declaration]
    1028 |         if (unlikely(pmd_bad(*pmd))) {
         |                      ^~~~~~~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   In file included from arch/arm64/include/asm/pgtable.h:14:
   arch/arm64/include/asm/pgtable-prot.h: At top level:
   arch/arm64/include/asm/pgtable-prot.h:85: warning: "PAGE_KERNEL_RO" redefined
      85 | #define PAGE_KERNEL_RO          __pgprot(_PAGE_KERNEL_RO)
         | 
   include/linux/pgtable.h:1539: note: this is the location of the previous definition
    1539 | # define PAGE_KERNEL_RO PAGE_KERNEL
         | 
   arch/arm64/include/asm/pgtable-prot.h:87: warning: "PAGE_KERNEL_EXEC" redefined
      87 | #define PAGE_KERNEL_EXEC        __pgprot(_PAGE_KERNEL_EXEC)
         | 
   include/linux/pgtable.h:1543: note: this is the location of the previous definition
    1543 | # define PAGE_KERNEL_EXEC PAGE_KERNEL
         | 
>> arch/arm64/include/asm/pgtable.h:42: warning: "flush_pmd_tlb_range" redefined
      42 | #define flush_pmd_tlb_range(vma, addr, end)     \
         | 
   include/linux/pgtable.h:1498: note: this is the location of the previous definition
    1498 | #define flush_pmd_tlb_range(vma, addr, end)     flush_tlb_range(vma, addr, end)
         | 
>> arch/arm64/include/asm/pgtable.h:44: warning: "flush_pud_tlb_range" redefined
      44 | #define flush_pud_tlb_range(vma, addr, end)     \
         | 
   include/linux/pgtable.h:1499: note: this is the location of the previous definition
    1499 | #define flush_pud_tlb_range(vma, addr, end)     flush_tlb_range(vma, addr, end)
         | 
   arch/arm64/include/asm/pgtable.h:60: warning: "flush_tlb_fix_spurious_fault" redefined
      60 | #define flush_tlb_fix_spurious_fault(vma, address, ptep) do { } while (0)
         | 
   include/linux/pgtable.h:935: note: this is the location of the previous definition
     935 | #define flush_tlb_fix_spurious_fault(vma, address, ptep) flush_tlb_page(vma, address)
         | 
   arch/arm64/include/asm/pgtable.h:143: warning: "pte_accessible" redefined
     143 | #define pte_accessible(mm, pte) \
         | 
   include/linux/pgtable.h:931: note: this is the location of the previous definition
     931 | # define pte_accessible(mm, pte)        ((void)(pte), 1)
         | 
   arch/arm64/include/asm/pgtable.h:153: warning: "pte_access_permitted" redefined
     153 | #define pte_access_permitted(pte, write) \
         | 
   include/linux/pgtable.h:767: note: this is the location of the previous definition
     767 | #define pte_access_permitted(pte, write) \
         | 
   arch/arm64/include/asm/pgtable.h:155: warning: "pmd_access_permitted" redefined
     155 | #define pmd_access_permitted(pmd, write) \
         | 
   include/linux/pgtable.h:772: note: this is the location of the previous definition
     772 | #define pmd_access_permitted(pmd, write) \
         | 
   arch/arm64/include/asm/pgtable.h:157: warning: "pud_access_permitted" redefined
     157 | #define pud_access_permitted(pud, write) \
         | 
   include/linux/pgtable.h:777: note: this is the location of the previous definition
     777 | #define pud_access_permitted(pud, write) \
         | 
   arch/arm64/include/asm/pgtable.h:184:21: error: conflicting types for 'pte_mkwrite_novma'; have 'pte_t(pte_t)'
     184 | static inline pte_t pte_mkwrite_novma(pte_t pte)
         |                     ^~~~~~~~~~~~~~~~~
   include/linux/pgtable.h:605:16: note: previous implicit declaration of 'pte_mkwrite_novma' with type 'int()'
     605 |         return pte_mkwrite_novma(pte);
         |                ^~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/pgtable.h:209:21: error: conflicting types for 'pte_wrprotect'; have 'pte_t(pte_t)'
     209 | static inline pte_t pte_wrprotect(pte_t pte)
         |                     ^~~~~~~~~~~~~
   include/linux/pgtable.h:621:39: note: previous implicit declaration of 'pte_wrprotect' with type 'int()'
     621 |         set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
         |                                       ^~~~~~~~~~~~~
   include/linux/pgtable.h:247:66: note: in definition of macro 'set_pte_at'
     247 | #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
         |                                                                  ^~~
   arch/arm64/include/asm/pgtable.h:223:21: error: conflicting types for 'pte_mkold'; have 'pte_t(pte_t)'
     223 | static inline pte_t pte_mkold(pte_t pte)
         |                     ^~~~~~~~~
   include/linux/pgtable.h:305:55: note: previous implicit declaration of 'pte_mkold' with type 'int()'
     305 |                 set_pte_at(vma->vm_mm, address, ptep, pte_mkold(pte));
         |                                                       ^~~~~~~~~
   include/linux/pgtable.h:247:66: note: in definition of macro 'set_pte_at'
     247 | #define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
         |                                                                  ^~~
   arch/arm64/include/asm/pgtable.h:264:20: warning: conflicting types for 'set_pte'; have 'void(pte_t *, pte_t)'
     264 | static inline void set_pte(pte_t *ptep, pte_t pte)
         |                    ^~~~~~~
   arch/arm64/include/asm/pgtable.h:264:20: error: static declaration of 'set_pte' follows non-static declaration
   include/linux/pgtable.h:238:17: note: previous implicit declaration of 'set_pte' with type 'void(pte_t *, pte_t)'
     238 |                 set_pte(ptep, pte);
         |                 ^~~~~~~
   arch/arm64/include/asm/pgtable.h:349:20: error: redefinition of 'set_ptes'
     349 | static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
         |                    ^~~~~~~~
   include/linux/pgtable.h:231:20: note: previous definition of 'set_ptes' with type 'void(struct mm_struct *, long unsigned int,  pte_t *, pte_t,  unsigned int)'
     231 | static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
         |                    ^~~~~~~~
>> arch/arm64/include/asm/pgtable.h:534:20: warning: conflicting types for 'set_pmd_at'; have 'void(struct mm_struct *, long unsigned int,  pmd_t *, pmd_t)'
     534 | static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
         |                    ^~~~~~~~~~
>> arch/arm64/include/asm/pgtable.h:534:20: error: static declaration of 'set_pmd_at' follows non-static declaration
   include/linux/pgtable.h:321:17: note: previous implicit declaration of 'set_pmd_at' with type 'void(struct mm_struct *, long unsigned int,  pmd_t *, pmd_t)'
     321 |                 set_pmd_at(vma->vm_mm, address, pmdp, pmd_mkold(pmd));
         |                 ^~~~~~~~~~
   arch/arm64/include/asm/pgtable.h:557: warning: "pgprot_nx" redefined
     557 | #define pgprot_nx(prot) \
         | 
   include/linux/pgtable.h:1099: note: this is the location of the previous definition
    1099 | #define pgprot_nx(prot) (prot)
         | 
   arch/arm64/include/asm/pgtable.h:563: warning: "pgprot_noncached" redefined
     563 | #define pgprot_noncached(prot) \
         | 
   include/linux/pgtable.h:1103: note: this is the location of the previous definition
    1103 | #define pgprot_noncached(prot)  (prot)
         | 
   arch/arm64/include/asm/pgtable.h:565: warning: "pgprot_writecombine" redefined
     565 | #define pgprot_writecombine(prot) \
         | 
   include/linux/pgtable.h:1107: note: this is the location of the previous definition
    1107 | #define pgprot_writecombine pgprot_noncached
         | 
   arch/arm64/include/asm/pgtable.h:567: warning: "pgprot_device" redefined
     567 | #define pgprot_device(prot) \
         | 
   include/linux/pgtable.h:1115: note: this is the location of the previous definition
    1115 | #define pgprot_device pgprot_noncached
         | 
   arch/arm64/include/asm/pgtable.h:571: warning: "pgprot_mhp" redefined
     571 | #define pgprot_mhp      pgprot_tagged
         | 
   include/linux/pgtable.h:1119: note: this is the location of the previous definition
    1119 | #define pgprot_mhp(prot)        (prot)
         | 
   arch/arm64/include/asm/pgtable.h:595: warning: "pmd_leaf" redefined
     595 | #define pmd_leaf(pmd)           (pmd_present(pmd) && !pmd_table(pmd))
         | 
   include/linux/pgtable.h:1634: note: this is the location of the previous definition
    1634 | #define pmd_leaf(x)     0
         | 
   arch/arm64/include/asm/pgtable.h:598: warning: "pmd_leaf_size" redefined
     598 | #define pmd_leaf_size(pmd)      (pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
         | 
   include/linux/pgtable.h:1647: note: this is the location of the previous definition
    1647 | #define pmd_leaf_size(x) PMD_SIZE
         | 
   arch/arm64/include/asm/pgtable.h:599: warning: "pte_leaf_size" redefined
     599 | #define pte_leaf_size(pte)      (pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
         | 
   include/linux/pgtable.h:1650: note: this is the location of the previous definition
    1650 | #define pte_leaf_size(x) PAGE_SIZE
         | 
>> arch/arm64/include/asm/pgtable.h:643:20: warning: conflicting types for 'pmd_clear'; have 'void(pmd_t *)'
     643 | static inline void pmd_clear(pmd_t *pmdp)
         |                    ^~~~~~~~~
>> arch/arm64/include/asm/pgtable.h:643:20: error: static declaration of 'pmd_clear' follows non-static declaration
   include/linux/pgtable.h:505:9: note: previous implicit declaration of 'pmd_clear' with type 'void(pmd_t *)'
     505 |         pmd_clear(pmdp);
         |         ^~~~~~~~~
   arch/arm64/include/asm/pgtable.h:653:29: error: conflicting types for 'pmd_page_vaddr'; have 'long unsigned int(pmd_t)'
     653 | static inline unsigned long pmd_page_vaddr(pmd_t pmd)
         |                             ^~~~~~~~~~~~~~
   include/linux/pgtable.h:94:25: note: previous implicit declaration of 'pmd_page_vaddr' with type 'int()'
      94 |         return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
         |                         ^~~~~~~~~~~~~~
   arch/arm64/include/asm/pgtable.h:684: warning: "pud_leaf" redefined
     684 | #define pud_leaf(pud)           (pud_present(pud) && !pud_table(pud))
         | 
   include/linux/pgtable.h:1631: note: this is the location of the previous definition
    1631 | #define pud_leaf(x)     0
         | 
>> arch/arm64/include/asm/pgtable.h:706:20: warning: conflicting types for 'pud_clear'; have 'void(pud_t *)'
     706 | static inline void pud_clear(pud_t *pudp)
         |                    ^~~~~~~~~
>> arch/arm64/include/asm/pgtable.h:706:20: error: static declaration of 'pud_clear' follows non-static declaration
   include/linux/pgtable.h:518:9: note: previous implicit declaration of 'pud_clear' with type 'void(pud_t *)'
     518 |         pud_clear(pudp);
         |         ^~~~~~~~~
   arch/arm64/include/asm/pgtable.h:716:22: error: conflicting types for 'pud_pgtable'; have 'pmd_t *(pud_t)'
     716 | static inline pmd_t *pud_pgtable(pud_t pud)
         |                      ^~~~~~~~~~~
   include/linux/pgtable.h:123:16: note: previous implicit declaration of 'pud_pgtable' with type 'int()'
     123 |         return pud_pgtable(*pud) + pmd_index(address);
         |                ^~~~~~~~~~~
>> arch/arm64/include/asm/pgtable.h:844:19: error: static declaration of 'pmdp_set_access_flags' follows non-static declaration
     844 | static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
         |                   ^~~~~~~~~~~~~~~~~~~~~
   include/linux/pgtable.h:257:12: note: previous declaration of 'pmdp_set_access_flags' with type 'int(struct vm_area_struct *, long unsigned int,  pmd_t *, pmd_t,  int)'
     257 | extern int pmdp_set_access_flags(struct vm_area_struct *vma,
         |            ^~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/pgtable.h:898:19: error: redefinition of 'ptep_test_and_clear_young'
     898 | static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pgtable.h:296:19: note: previous definition of 'ptep_test_and_clear_young' with type 'int(struct vm_area_struct *, long unsigned int,  pte_t *)'
     296 | static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/pgtable.h:906:19: error: static declaration of 'ptep_clear_flush_young' follows non-static declaration
     906 | static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/pgtable.h:336:5: note: previous declaration of 'ptep_clear_flush_young' with type 'int(struct vm_area_struct *, long unsigned int,  pte_t *)'
     336 | int ptep_clear_flush_young(struct vm_area_struct *vma,
         |     ^~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/include/asm/pgtable.h:928:19: error: redefinition of 'pmdp_test_and_clear_young'
     928 | static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pgtable.h:312:19: note: previous definition of 'pmdp_test_and_clear_young' with type 'int(struct vm_area_struct *, long unsigned int,  pmd_t *)'
     312 | static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/pgtable.h:937:21: error: redefinition of 'ptep_get_and_clear'
     937 | static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
         |                     ^~~~~~~~~~~~~~~~~~
   include/linux/pgtable.h:397:21: note: previous definition of 'ptep_get_and_clear' with type 'pte_t(struct mm_struct *, long unsigned int,  pte_t *)'
     397 | static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
         |                     ^~~~~~~~~~~~~~~~~~
>> arch/arm64/include/asm/pgtable.h:949:21: error: redefinition of 'pmdp_huge_get_and_clear'
     949 | static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/pgtable.h:499:21: note: previous definition of 'pmdp_huge_get_and_clear' with type 'pmd_t(struct mm_struct *, long unsigned int,  pmd_t *)'
     499 | static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/pgtable.h:965:20: error: redefinition of 'ptep_set_wrprotect'
     965 | static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
         |                    ^~~~~~~~~~~~~~~~~~
   include/linux/pgtable.h:618:20: note: previous definition of 'ptep_set_wrprotect' with type 'void(struct mm_struct *, long unsigned int,  pte_t *)'
     618 | static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
         |                    ^~~~~~~~~~~~~~~~~~
>> arch/arm64/include/asm/pgtable.h:980:20: error: redefinition of 'pmdp_set_wrprotect'
     980 | static inline void pmdp_set_wrprotect(struct mm_struct *mm,
         |                    ^~~~~~~~~~~~~~~~~~
   include/linux/pgtable.h:643:20: note: previous definition of 'pmdp_set_wrprotect' with type 'void(struct mm_struct *, long unsigned int,  pmd_t *)'
     643 | static inline void pmdp_set_wrprotect(struct mm_struct *mm,
         |                    ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
..


vim +321 include/linux/pgtable.h

e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  309  
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  310  #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
eed9a328aa1ae6 include/linux/pgtable.h       Yu Zhao          2022-09-18  311  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  312  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  313  					    unsigned long address,
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  314  					    pmd_t *pmdp)
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  315  {
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  316  	pmd_t pmd = *pmdp;
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  317  	int r = 1;
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  318  	if (!pmd_young(pmd))
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  319  		r = 0;
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  320  	else
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13 @321  		set_pmd_at(vma->vm_mm, address, pmdp, pmd_mkold(pmd));
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  322  	return r;
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  323  }
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  324  #else
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  325  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  326  					    unsigned long address,
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  327  					    pmd_t *pmdp)
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  328  {
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  329  	BUILD_BUG();
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  330  	return 0;
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  331  }
eed9a328aa1ae6 include/linux/pgtable.h       Yu Zhao          2022-09-18  332  #endif /* CONFIG_TRANSPARENT_HUGEPAGE || CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG */
^1da177e4c3f41 include/asm-generic/pgtable.h Linus Torvalds   2005-04-16  333  #endif
^1da177e4c3f41 include/asm-generic/pgtable.h Linus Torvalds   2005-04-16  334  
^1da177e4c3f41 include/asm-generic/pgtable.h Linus Torvalds   2005-04-16  335  #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  336  int ptep_clear_flush_young(struct vm_area_struct *vma,
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  337  			   unsigned long address, pte_t *ptep);
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  338  #endif
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  339  
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  340  #ifndef __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  341  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  342  extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  343  				  unsigned long address, pmd_t *pmdp);
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  344  #else
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  345  /*
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  346   * Despite relevant to THP only, this API is called from generic rmap code
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  347   * under PageTransHuge(), hence needs a dummy implementation for !THP
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  348   */
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  349  static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  350  					 unsigned long address, pmd_t *pmdp)
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  351  {
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  352  	BUILD_BUG();
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  353  	return 0;
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  354  }
bd5e88ad72b26e include/asm-generic/pgtable.h Vineet Gupta     2015-07-09  355  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
^1da177e4c3f41 include/asm-generic/pgtable.h Linus Torvalds   2005-04-16  356  #endif
^1da177e4c3f41 include/asm-generic/pgtable.h Linus Torvalds   2005-04-16  357  
4aaf269c768dba include/linux/pgtable.h       Juergen Gross    2022-11-23  358  #ifndef arch_has_hw_nonleaf_pmd_young
4aaf269c768dba include/linux/pgtable.h       Juergen Gross    2022-11-23  359  /*
4aaf269c768dba include/linux/pgtable.h       Juergen Gross    2022-11-23  360   * Return whether the accessed bit in non-leaf PMD entries is supported on the
4aaf269c768dba include/linux/pgtable.h       Juergen Gross    2022-11-23  361   * local CPU.
4aaf269c768dba include/linux/pgtable.h       Juergen Gross    2022-11-23  362   */
4aaf269c768dba include/linux/pgtable.h       Juergen Gross    2022-11-23  363  static inline bool arch_has_hw_nonleaf_pmd_young(void)
4aaf269c768dba include/linux/pgtable.h       Juergen Gross    2022-11-23  364  {
4aaf269c768dba include/linux/pgtable.h       Juergen Gross    2022-11-23  365  	return IS_ENABLED(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG);
4aaf269c768dba include/linux/pgtable.h       Juergen Gross    2022-11-23  366  }
4aaf269c768dba include/linux/pgtable.h       Juergen Gross    2022-11-23  367  #endif
4aaf269c768dba include/linux/pgtable.h       Juergen Gross    2022-11-23  368  
e1fd09e3d1dd4a include/linux/pgtable.h       Yu Zhao          2022-09-18  369  #ifndef arch_has_hw_pte_young
e1fd09e3d1dd4a include/linux/pgtable.h       Yu Zhao          2022-09-18  370  /*
e1fd09e3d1dd4a include/linux/pgtable.h       Yu Zhao          2022-09-18  371   * Return whether the accessed bit is supported on the local CPU.
e1fd09e3d1dd4a include/linux/pgtable.h       Yu Zhao          2022-09-18  372   *
e1fd09e3d1dd4a include/linux/pgtable.h       Yu Zhao          2022-09-18  373   * This stub assumes accessing through an old PTE triggers a page fault.
e1fd09e3d1dd4a include/linux/pgtable.h       Yu Zhao          2022-09-18  374   * Architectures that automatically set the access bit should overwrite it.
e1fd09e3d1dd4a include/linux/pgtable.h       Yu Zhao          2022-09-18  375   */
e1fd09e3d1dd4a include/linux/pgtable.h       Yu Zhao          2022-09-18  376  static inline bool arch_has_hw_pte_young(void)
e1fd09e3d1dd4a include/linux/pgtable.h       Yu Zhao          2022-09-18  377  {
e1fd09e3d1dd4a include/linux/pgtable.h       Yu Zhao          2022-09-18  378  	return false;
e1fd09e3d1dd4a include/linux/pgtable.h       Yu Zhao          2022-09-18  379  }
e1fd09e3d1dd4a include/linux/pgtable.h       Yu Zhao          2022-09-18  380  #endif
e1fd09e3d1dd4a include/linux/pgtable.h       Yu Zhao          2022-09-18  381  
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  382  #ifndef arch_check_zapped_pte
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  383  static inline void arch_check_zapped_pte(struct vm_area_struct *vma,
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  384  					 pte_t pte)
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  385  {
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  386  }
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  387  #endif
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  388  
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  389  #ifndef arch_check_zapped_pmd
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  390  static inline void arch_check_zapped_pmd(struct vm_area_struct *vma,
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  391  					 pmd_t pmd)
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  392  {
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  393  }
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  394  #endif
e5136e876581ba include/linux/pgtable.h       Rick Edgecombe   2023-06-12  395  
^1da177e4c3f41 include/asm-generic/pgtable.h Linus Torvalds   2005-04-16  396  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  397  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  398  				       unsigned long address,
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  399  				       pte_t *ptep)
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  400  {
c33c794828f212 include/linux/pgtable.h       Ryan Roberts     2023-06-12  401  	pte_t pte = ptep_get(ptep);
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  402  	pte_clear(mm, address, ptep);
aa232204c46894 include/linux/pgtable.h       Kemeng Shi       2023-07-14  403  	page_table_check_pte_clear(mm, pte);
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  404  	return pte;
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  405  }
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  406  #endif
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  407  
de8c8e52836d00 include/linux/pgtable.h       Tong Tiangen     2022-05-12  408  static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
de8c8e52836d00 include/linux/pgtable.h       Tong Tiangen     2022-05-12  409  			      pte_t *ptep)
de8c8e52836d00 include/linux/pgtable.h       Tong Tiangen     2022-05-12  410  {
de8c8e52836d00 include/linux/pgtable.h       Tong Tiangen     2022-05-12  411  	ptep_get_and_clear(mm, addr, ptep);
de8c8e52836d00 include/linux/pgtable.h       Tong Tiangen     2022-05-12  412  }
de8c8e52836d00 include/linux/pgtable.h       Tong Tiangen     2022-05-12  413  
6ca297d4784625 include/linux/pgtable.h       Peter Zijlstra   2022-10-21  414  #ifdef CONFIG_GUP_GET_PXX_LOW_HIGH
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  415  /*
93b3037a148275 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  416   * For walking the pagetables without holding any locks.  Some architectures
93b3037a148275 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  417   * (eg x86-32 PAE) cannot load the entries atomically without using expensive
93b3037a148275 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  418   * instructions.  We are guaranteed that a PTE will only either go from not
93b3037a148275 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  419   * present to present, or present to not present -- it will not switch to a
93b3037a148275 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  420   * completely different present page without a TLB flush inbetween; which we
93b3037a148275 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  421   * are blocking by holding interrupts off.
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  422   *
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  423   * Setting ptes from not present to present goes:
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  424   *
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  425   *   ptep->pte_high = h;
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  426   *   smp_wmb();
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  427   *   ptep->pte_low = l;
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  428   *
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  429   * And present to not present goes:
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  430   *
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  431   *   ptep->pte_low = 0;
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  432   *   smp_wmb();
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  433   *   ptep->pte_high = 0;
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  434   *
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  435   * We must ensure here that the load of pte_low sees 'l' IFF pte_high sees 'h'.
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  436   * We load pte_high *after* loading pte_low, which ensures we don't see an older
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  437   * value of pte_high.  *Then* we recheck pte_low, which ensures that we haven't
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  438   * picked up a changed pte high. We might have gotten rubbish values from
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  439   * pte_low and pte_high, but we are guaranteed that pte_low will not have the
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  440   * present bit set *unless* it is 'l'. Because get_user_pages_fast() only
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  441   * operates on present ptes we're safe.
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  442   */
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  443  static inline pte_t ptep_get_lockless(pte_t *ptep)
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  444  {
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  445  	pte_t pte;
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  446  
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  447  	do {
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  448  		pte.pte_low = ptep->pte_low;
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  449  		smp_rmb();
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  450  		pte.pte_high = ptep->pte_high;
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  451  		smp_rmb();
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  452  	} while (unlikely(pte.pte_low != ptep->pte_low));
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  453  
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  454  	return pte;
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  455  }
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  456  #define ptep_get_lockless ptep_get_lockless
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  457  
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  458  #if CONFIG_PGTABLE_LEVELS > 2
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  459  static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  460  {
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  461  	pmd_t pmd;
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  462  
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  463  	do {
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  464  		pmd.pmd_low = pmdp->pmd_low;
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  465  		smp_rmb();
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  466  		pmd.pmd_high = pmdp->pmd_high;
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  467  		smp_rmb();
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  468  	} while (unlikely(pmd.pmd_low != pmdp->pmd_low));
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  469  
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  470  	return pmd;
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  471  }
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  472  #define pmdp_get_lockless pmdp_get_lockless
146b42e07494e4 include/linux/pgtable.h       Hugh Dickins     2023-07-11  473  #define pmdp_get_lockless_sync() tlb_remove_table_sync_one()
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  474  #endif /* CONFIG_PGTABLE_LEVELS > 2 */
6ca297d4784625 include/linux/pgtable.h       Peter Zijlstra   2022-10-21  475  #endif /* CONFIG_GUP_GET_PXX_LOW_HIGH */
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  476  
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  477  /*
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  478   * We require that the PTE can be read atomically.
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  479   */
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  480  #ifndef ptep_get_lockless
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  481  static inline pte_t ptep_get_lockless(pte_t *ptep)
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  482  {
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  483  	return ptep_get(ptep);
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  484  }
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  485  #endif
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  486  
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  487  #ifndef pmdp_get_lockless
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  488  static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  489  {
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  490  	return pmdp_get(pmdp);
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  491  }
146b42e07494e4 include/linux/pgtable.h       Hugh Dickins     2023-07-11  492  static inline void pmdp_get_lockless_sync(void)
146b42e07494e4 include/linux/pgtable.h       Hugh Dickins     2023-07-11  493  {
146b42e07494e4 include/linux/pgtable.h       Hugh Dickins     2023-07-11  494  }
024d232ae4fcd7 include/linux/pgtable.h       Peter Zijlstra   2020-11-26  495  #endif
2a4a06da8a4b93 include/linux/pgtable.h       Peter Zijlstra   2020-11-13  496  
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  497  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
a00cc7d9dd93d6 include/asm-generic/pgtable.h Matthew Wilcox   2017-02-24  498  #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
8809aa2d28d741 include/asm-generic/pgtable.h Aneesh Kumar K.V 2015-06-24  499  static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  500  					    unsigned long address,
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  501  					    pmd_t *pmdp)
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  502  {
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  503  	pmd_t pmd = *pmdp;
de8c8e52836d00 include/linux/pgtable.h       Tong Tiangen     2022-05-12  504  
2d28a2275c21d0 include/asm-generic/pgtable.h Catalin Marinas  2012-10-08 @505  	pmd_clear(pmdp);
1831414cd729a3 include/linux/pgtable.h       Kemeng Shi       2023-07-14  506  	page_table_check_pmd_clear(mm, pmd);
de8c8e52836d00 include/linux/pgtable.h       Tong Tiangen     2022-05-12  507  
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  508  	return pmd;
49b24d6b41c576 include/asm-generic/pgtable.h Nicolas Kaiser   2011-06-15  509  }
a00cc7d9dd93d6 include/asm-generic/pgtable.h Matthew Wilcox   2017-02-24  510  #endif /* __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR */
a00cc7d9dd93d6 include/asm-generic/pgtable.h Matthew Wilcox   2017-02-24  511  #ifndef __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR
a00cc7d9dd93d6 include/asm-generic/pgtable.h Matthew Wilcox   2017-02-24  512  static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
a00cc7d9dd93d6 include/asm-generic/pgtable.h Matthew Wilcox   2017-02-24  513  					    unsigned long address,
a00cc7d9dd93d6 include/asm-generic/pgtable.h Matthew Wilcox   2017-02-24  514  					    pud_t *pudp)
a00cc7d9dd93d6 include/asm-generic/pgtable.h Matthew Wilcox   2017-02-24  515  {
a00cc7d9dd93d6 include/asm-generic/pgtable.h Matthew Wilcox   2017-02-24  516  	pud_t pud = *pudp;
a00cc7d9dd93d6 include/asm-generic/pgtable.h Matthew Wilcox   2017-02-24  517  
a00cc7d9dd93d6 include/asm-generic/pgtable.h Matthew Wilcox   2017-02-24 @518  	pud_clear(pudp);
931c38e16499a0 include/linux/pgtable.h       Kemeng Shi       2023-07-14  519  	page_table_check_pud_clear(mm, pud);
de8c8e52836d00 include/linux/pgtable.h       Tong Tiangen     2022-05-12  520  
a00cc7d9dd93d6 include/asm-generic/pgtable.h Matthew Wilcox   2017-02-24  521  	return pud;
a00cc7d9dd93d6 include/asm-generic/pgtable.h Matthew Wilcox   2017-02-24  522  }
a00cc7d9dd93d6 include/asm-generic/pgtable.h Matthew Wilcox   2017-02-24  523  #endif /* __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR */
e2cda322648122 include/asm-generic/pgtable.h Andrea Arcangeli 2011-01-13  524  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
^1da177e4c3f41 include/asm-generic/pgtable.h Linus Torvalds   2005-04-16  525  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
