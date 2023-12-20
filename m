Return-Path: <linux-kernel+bounces-7521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C0D81A940
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763A6282DA7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3B84AF63;
	Wed, 20 Dec 2023 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2HQct+w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE1F22066
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703111938; x=1734647938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xXyMG+LIry2D+7Ad77K6/jmOofy2abZHY3ud6DtDnC4=;
  b=W2HQct+wXvBSBkMLPB7CGn4ErY6Js6v2aT0aoSyyFsskEfe2S6SPOUlK
   wUIfCAG6nuZM/pu+EbptFvOMO8pYm0/dOilnZti2Wl4qABSTk7i9i4NSk
   YypYqJFtJQfxB9CMNPSY6ZaUkaS1q7dTtA6a/XZvAd/1KVyC87oE1OV+F
   2eiKqGFlfTMdxmHpJ8+bQhuZnfqy4Gih9szE7TIfI2aJYzxN+IgWzfD2v
   31BlfLBQUqUZRYd3v8Y7k1Dt6kz6t6vNm2knWW51q7kDKTj0urFS8vzsP
   /eAw1dpoq5OxOvtc4nXQ+nXwL7n5DfmaXTaZ4RgSzeYiDWnZ6pzUJVaot
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="3112592"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="3112592"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 14:38:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="18110937"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 20 Dec 2023 14:38:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rG5DH-0007bB-0R;
	Wed, 20 Dec 2023 22:38:51 +0000
Date: Thu, 21 Dec 2023 06:38:31 +0800
From: kernel test robot <lkp@intel.com>
To: Kinsey Ho <kinseyho@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, yuzhao@google.com,
	Kinsey Ho <kinseyho@google.com>,
	Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH mm-unstable v1 4/4] mm/mglru: remove
 CONFIG_TRANSPARENT_HUGEPAGE
Message-ID: <202312210606.1Etqz3M4-lkp@intel.com>
References: <20231220040037.883811-5-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220040037.883811-5-kinseyho@google.com>

Hi Kinsey,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kinsey-Ho/mm-mglru-add-CONFIG_ARCH_HAS_HW_PTE_YOUNG/20231220-120318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231220040037.883811-5-kinseyho%40google.com
patch subject: [PATCH mm-unstable v1 4/4] mm/mglru: remove CONFIG_TRANSPARENT_HUGEPAGE
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20231221/202312210606.1Etqz3M4-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 7022a24771c8404f847abb226735a3ae21794426)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231221/202312210606.1Etqz3M4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312210606.1Etqz3M4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/vmscan.c:19:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from mm/vmscan.c:19:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from mm/vmscan.c:19:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> mm/vmscan.c:3455:7: error: call to undeclared function 'pmd_dirty'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3455 |                 if (pmd_dirty(pmd[i]) && !folio_test_dirty(folio) &&
         |                     ^
   mm/vmscan.c:3455:7: note: did you mean 'pte_dirty'?
   arch/hexagon/include/asm/pgtable.h:282:19: note: 'pte_dirty' declared here
     282 | static inline int pte_dirty(pte_t pte)
         |                   ^
   6 warnings and 1 error generated.


vim +/pmd_dirty +3455 mm/vmscan.c

bd74fdaea14602 Yu Zhao        2022-09-18  3394  
b5ff4133617d0e T.J. Alumbaugh 2023-01-18  3395  static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area_struct *vma,
b5ff4133617d0e T.J. Alumbaugh 2023-01-18  3396  				  struct mm_walk *args, unsigned long *bitmap, unsigned long *first)
bd74fdaea14602 Yu Zhao        2022-09-18  3397  {
bd74fdaea14602 Yu Zhao        2022-09-18  3398  	int i;
bd74fdaea14602 Yu Zhao        2022-09-18  3399  	pmd_t *pmd;
bd74fdaea14602 Yu Zhao        2022-09-18  3400  	spinlock_t *ptl;
bd74fdaea14602 Yu Zhao        2022-09-18  3401  	struct lru_gen_mm_walk *walk = args->private;
bd74fdaea14602 Yu Zhao        2022-09-18  3402  	struct mem_cgroup *memcg = lruvec_memcg(walk->lruvec);
bd74fdaea14602 Yu Zhao        2022-09-18  3403  	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
bd74fdaea14602 Yu Zhao        2022-09-18  3404  	int old_gen, new_gen = lru_gen_from_seq(walk->max_seq);
bd74fdaea14602 Yu Zhao        2022-09-18  3405  
bd74fdaea14602 Yu Zhao        2022-09-18  3406  	VM_WARN_ON_ONCE(pud_leaf(*pud));
bd74fdaea14602 Yu Zhao        2022-09-18  3407  
bd74fdaea14602 Yu Zhao        2022-09-18  3408  	/* try to batch at most 1+MIN_LRU_BATCH+1 entries */
b5ff4133617d0e T.J. Alumbaugh 2023-01-18  3409  	if (*first == -1) {
b5ff4133617d0e T.J. Alumbaugh 2023-01-18  3410  		*first = addr;
b5ff4133617d0e T.J. Alumbaugh 2023-01-18  3411  		bitmap_zero(bitmap, MIN_LRU_BATCH);
bd74fdaea14602 Yu Zhao        2022-09-18  3412  		return;
bd74fdaea14602 Yu Zhao        2022-09-18  3413  	}
bd74fdaea14602 Yu Zhao        2022-09-18  3414  
b5ff4133617d0e T.J. Alumbaugh 2023-01-18  3415  	i = addr == -1 ? 0 : pmd_index(addr) - pmd_index(*first);
bd74fdaea14602 Yu Zhao        2022-09-18  3416  	if (i && i <= MIN_LRU_BATCH) {
bd74fdaea14602 Yu Zhao        2022-09-18  3417  		__set_bit(i - 1, bitmap);
bd74fdaea14602 Yu Zhao        2022-09-18  3418  		return;
bd74fdaea14602 Yu Zhao        2022-09-18  3419  	}
bd74fdaea14602 Yu Zhao        2022-09-18  3420  
b5ff4133617d0e T.J. Alumbaugh 2023-01-18  3421  	pmd = pmd_offset(pud, *first);
bd74fdaea14602 Yu Zhao        2022-09-18  3422  
bd74fdaea14602 Yu Zhao        2022-09-18  3423  	ptl = pmd_lockptr(args->mm, pmd);
bd74fdaea14602 Yu Zhao        2022-09-18  3424  	if (!spin_trylock(ptl))
bd74fdaea14602 Yu Zhao        2022-09-18  3425  		goto done;
bd74fdaea14602 Yu Zhao        2022-09-18  3426  
bd74fdaea14602 Yu Zhao        2022-09-18  3427  	arch_enter_lazy_mmu_mode();
bd74fdaea14602 Yu Zhao        2022-09-18  3428  
bd74fdaea14602 Yu Zhao        2022-09-18  3429  	do {
bd74fdaea14602 Yu Zhao        2022-09-18  3430  		unsigned long pfn;
bd74fdaea14602 Yu Zhao        2022-09-18  3431  		struct folio *folio;
b5ff4133617d0e T.J. Alumbaugh 2023-01-18  3432  
b5ff4133617d0e T.J. Alumbaugh 2023-01-18  3433  		/* don't round down the first address */
b5ff4133617d0e T.J. Alumbaugh 2023-01-18  3434  		addr = i ? (*first & PMD_MASK) + i * PMD_SIZE : *first;
bd74fdaea14602 Yu Zhao        2022-09-18  3435  
bd74fdaea14602 Yu Zhao        2022-09-18  3436  		pfn = get_pmd_pfn(pmd[i], vma, addr);
bd74fdaea14602 Yu Zhao        2022-09-18  3437  		if (pfn == -1)
bd74fdaea14602 Yu Zhao        2022-09-18  3438  			goto next;
bd74fdaea14602 Yu Zhao        2022-09-18  3439  
bd74fdaea14602 Yu Zhao        2022-09-18  3440  		if (!pmd_trans_huge(pmd[i])) {
bd02df412cbb9a T.J. Alumbaugh 2023-05-22  3441  			if (should_clear_pmd_young())
bd74fdaea14602 Yu Zhao        2022-09-18  3442  				pmdp_test_and_clear_young(vma, addr, pmd + i);
bd74fdaea14602 Yu Zhao        2022-09-18  3443  			goto next;
bd74fdaea14602 Yu Zhao        2022-09-18  3444  		}
bd74fdaea14602 Yu Zhao        2022-09-18  3445  
bd74fdaea14602 Yu Zhao        2022-09-18  3446  		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
bd74fdaea14602 Yu Zhao        2022-09-18  3447  		if (!folio)
bd74fdaea14602 Yu Zhao        2022-09-18  3448  			goto next;
bd74fdaea14602 Yu Zhao        2022-09-18  3449  
bd74fdaea14602 Yu Zhao        2022-09-18  3450  		if (!pmdp_test_and_clear_young(vma, addr, pmd + i))
bd74fdaea14602 Yu Zhao        2022-09-18  3451  			goto next;
bd74fdaea14602 Yu Zhao        2022-09-18  3452  
bd74fdaea14602 Yu Zhao        2022-09-18  3453  		walk->mm_stats[MM_LEAF_YOUNG]++;
bd74fdaea14602 Yu Zhao        2022-09-18  3454  
bd74fdaea14602 Yu Zhao        2022-09-18 @3455  		if (pmd_dirty(pmd[i]) && !folio_test_dirty(folio) &&
bd74fdaea14602 Yu Zhao        2022-09-18  3456  		    !(folio_test_anon(folio) && folio_test_swapbacked(folio) &&
bd74fdaea14602 Yu Zhao        2022-09-18  3457  		      !folio_test_swapcache(folio)))
bd74fdaea14602 Yu Zhao        2022-09-18  3458  			folio_mark_dirty(folio);
bd74fdaea14602 Yu Zhao        2022-09-18  3459  
bd74fdaea14602 Yu Zhao        2022-09-18  3460  		old_gen = folio_update_gen(folio, new_gen);
bd74fdaea14602 Yu Zhao        2022-09-18  3461  		if (old_gen >= 0 && old_gen != new_gen)
bd74fdaea14602 Yu Zhao        2022-09-18  3462  			update_batch_size(walk, folio, old_gen, new_gen);
bd74fdaea14602 Yu Zhao        2022-09-18  3463  next:
bd74fdaea14602 Yu Zhao        2022-09-18  3464  		i = i > MIN_LRU_BATCH ? 0 : find_next_bit(bitmap, MIN_LRU_BATCH, i) + 1;
bd74fdaea14602 Yu Zhao        2022-09-18  3465  	} while (i <= MIN_LRU_BATCH);
bd74fdaea14602 Yu Zhao        2022-09-18  3466  
bd74fdaea14602 Yu Zhao        2022-09-18  3467  	arch_leave_lazy_mmu_mode();
bd74fdaea14602 Yu Zhao        2022-09-18  3468  	spin_unlock(ptl);
bd74fdaea14602 Yu Zhao        2022-09-18  3469  done:
b5ff4133617d0e T.J. Alumbaugh 2023-01-18  3470  	*first = -1;
bd74fdaea14602 Yu Zhao        2022-09-18  3471  }
bd74fdaea14602 Yu Zhao        2022-09-18  3472  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

