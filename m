Return-Path: <linux-kernel+bounces-7318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1527581A590
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811791F2418F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978F74643B;
	Wed, 20 Dec 2023 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3fdusUW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636141A92
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703090904; x=1734626904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HaKTni1h/yjqjVfi4pHddVk5OjH7XnULnIt4yRHlChs=;
  b=l3fdusUWDTDUEbOm2JOKnkA3gghEaVF3gxdxHlsBfSFq9LsB3Cjf4TE2
   irf16NQxOIbzDzbkShICQobEjhr/XIVHL2XaZDt9GzGObtEAAHa7FbYqd
   7nLC2SWpLheKCKjEKGSQy7BCGUa4uP+CYqWVU69ghYRdLhFpK4vSuLs8y
   VMDM7jDO+9/dC1AnGGoAXUD/QdLAui3nFOm87xzqnB4RK2C33FzFMQrri
   ymdLKE+c8t7F7EhV3mrvm+UXdO/yKCDJzjBb+lpLPr/IJwf0Iza9vXcsE
   D3QopYgfb17iXbfoAjQSZAEpbHF7GurnCYXCWmDzMmcZeHdiDF3K0GVYl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="3076371"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="3076371"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 08:48:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="842337574"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="842337574"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Dec 2023 08:48:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFzk3-0007Cr-1F;
	Wed, 20 Dec 2023 16:48:19 +0000
Date: Thu, 21 Dec 2023 00:47:51 +0800
From: kernel test robot <lkp@intel.com>
To: Kinsey Ho <kinseyho@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, yuzhao@google.com,
	Kinsey Ho <kinseyho@google.com>,
	Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH mm-unstable v1 4/4] mm/mglru: remove
 CONFIG_TRANSPARENT_HUGEPAGE
Message-ID: <202312210042.xQEiqlEh-lkp@intel.com>
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
config: arm-randconfig-002-20231220 (https://download.01.org/0day-ci/archive/20231221/202312210042.xQEiqlEh-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231221/202312210042.xQEiqlEh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312210042.xQEiqlEh-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/vmscan.c: In function 'walk_pmd_range_locked':
>> mm/vmscan.c:3455:21: error: implicit declaration of function 'pmd_dirty'; did you mean 'pte_dirty'? [-Werror=implicit-function-declaration]
    3455 |                 if (pmd_dirty(pmd[i]) && !folio_test_dirty(folio) &&
         |                     ^~~~~~~~~
         |                     pte_dirty
   cc1: some warnings being treated as errors


vim +3455 mm/vmscan.c

bd74fdaea146029 Yu Zhao        2022-09-18  3394  
b5ff4133617d0ec T.J. Alumbaugh 2023-01-18  3395  static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area_struct *vma,
b5ff4133617d0ec T.J. Alumbaugh 2023-01-18  3396  				  struct mm_walk *args, unsigned long *bitmap, unsigned long *first)
bd74fdaea146029 Yu Zhao        2022-09-18  3397  {
bd74fdaea146029 Yu Zhao        2022-09-18  3398  	int i;
bd74fdaea146029 Yu Zhao        2022-09-18  3399  	pmd_t *pmd;
bd74fdaea146029 Yu Zhao        2022-09-18  3400  	spinlock_t *ptl;
bd74fdaea146029 Yu Zhao        2022-09-18  3401  	struct lru_gen_mm_walk *walk = args->private;
bd74fdaea146029 Yu Zhao        2022-09-18  3402  	struct mem_cgroup *memcg = lruvec_memcg(walk->lruvec);
bd74fdaea146029 Yu Zhao        2022-09-18  3403  	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
bd74fdaea146029 Yu Zhao        2022-09-18  3404  	int old_gen, new_gen = lru_gen_from_seq(walk->max_seq);
bd74fdaea146029 Yu Zhao        2022-09-18  3405  
bd74fdaea146029 Yu Zhao        2022-09-18  3406  	VM_WARN_ON_ONCE(pud_leaf(*pud));
bd74fdaea146029 Yu Zhao        2022-09-18  3407  
bd74fdaea146029 Yu Zhao        2022-09-18  3408  	/* try to batch at most 1+MIN_LRU_BATCH+1 entries */
b5ff4133617d0ec T.J. Alumbaugh 2023-01-18  3409  	if (*first == -1) {
b5ff4133617d0ec T.J. Alumbaugh 2023-01-18  3410  		*first = addr;
b5ff4133617d0ec T.J. Alumbaugh 2023-01-18  3411  		bitmap_zero(bitmap, MIN_LRU_BATCH);
bd74fdaea146029 Yu Zhao        2022-09-18  3412  		return;
bd74fdaea146029 Yu Zhao        2022-09-18  3413  	}
bd74fdaea146029 Yu Zhao        2022-09-18  3414  
b5ff4133617d0ec T.J. Alumbaugh 2023-01-18  3415  	i = addr == -1 ? 0 : pmd_index(addr) - pmd_index(*first);
bd74fdaea146029 Yu Zhao        2022-09-18  3416  	if (i && i <= MIN_LRU_BATCH) {
bd74fdaea146029 Yu Zhao        2022-09-18  3417  		__set_bit(i - 1, bitmap);
bd74fdaea146029 Yu Zhao        2022-09-18  3418  		return;
bd74fdaea146029 Yu Zhao        2022-09-18  3419  	}
bd74fdaea146029 Yu Zhao        2022-09-18  3420  
b5ff4133617d0ec T.J. Alumbaugh 2023-01-18  3421  	pmd = pmd_offset(pud, *first);
bd74fdaea146029 Yu Zhao        2022-09-18  3422  
bd74fdaea146029 Yu Zhao        2022-09-18  3423  	ptl = pmd_lockptr(args->mm, pmd);
bd74fdaea146029 Yu Zhao        2022-09-18  3424  	if (!spin_trylock(ptl))
bd74fdaea146029 Yu Zhao        2022-09-18  3425  		goto done;
bd74fdaea146029 Yu Zhao        2022-09-18  3426  
bd74fdaea146029 Yu Zhao        2022-09-18  3427  	arch_enter_lazy_mmu_mode();
bd74fdaea146029 Yu Zhao        2022-09-18  3428  
bd74fdaea146029 Yu Zhao        2022-09-18  3429  	do {
bd74fdaea146029 Yu Zhao        2022-09-18  3430  		unsigned long pfn;
bd74fdaea146029 Yu Zhao        2022-09-18  3431  		struct folio *folio;
b5ff4133617d0ec T.J. Alumbaugh 2023-01-18  3432  
b5ff4133617d0ec T.J. Alumbaugh 2023-01-18  3433  		/* don't round down the first address */
b5ff4133617d0ec T.J. Alumbaugh 2023-01-18  3434  		addr = i ? (*first & PMD_MASK) + i * PMD_SIZE : *first;
bd74fdaea146029 Yu Zhao        2022-09-18  3435  
bd74fdaea146029 Yu Zhao        2022-09-18  3436  		pfn = get_pmd_pfn(pmd[i], vma, addr);
bd74fdaea146029 Yu Zhao        2022-09-18  3437  		if (pfn == -1)
bd74fdaea146029 Yu Zhao        2022-09-18  3438  			goto next;
bd74fdaea146029 Yu Zhao        2022-09-18  3439  
bd74fdaea146029 Yu Zhao        2022-09-18  3440  		if (!pmd_trans_huge(pmd[i])) {
bd02df412cbb9a6 T.J. Alumbaugh 2023-05-22  3441  			if (should_clear_pmd_young())
bd74fdaea146029 Yu Zhao        2022-09-18  3442  				pmdp_test_and_clear_young(vma, addr, pmd + i);
bd74fdaea146029 Yu Zhao        2022-09-18  3443  			goto next;
bd74fdaea146029 Yu Zhao        2022-09-18  3444  		}
bd74fdaea146029 Yu Zhao        2022-09-18  3445  
bd74fdaea146029 Yu Zhao        2022-09-18  3446  		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
bd74fdaea146029 Yu Zhao        2022-09-18  3447  		if (!folio)
bd74fdaea146029 Yu Zhao        2022-09-18  3448  			goto next;
bd74fdaea146029 Yu Zhao        2022-09-18  3449  
bd74fdaea146029 Yu Zhao        2022-09-18  3450  		if (!pmdp_test_and_clear_young(vma, addr, pmd + i))
bd74fdaea146029 Yu Zhao        2022-09-18  3451  			goto next;
bd74fdaea146029 Yu Zhao        2022-09-18  3452  
bd74fdaea146029 Yu Zhao        2022-09-18  3453  		walk->mm_stats[MM_LEAF_YOUNG]++;
bd74fdaea146029 Yu Zhao        2022-09-18  3454  
bd74fdaea146029 Yu Zhao        2022-09-18 @3455  		if (pmd_dirty(pmd[i]) && !folio_test_dirty(folio) &&
bd74fdaea146029 Yu Zhao        2022-09-18  3456  		    !(folio_test_anon(folio) && folio_test_swapbacked(folio) &&
bd74fdaea146029 Yu Zhao        2022-09-18  3457  		      !folio_test_swapcache(folio)))
bd74fdaea146029 Yu Zhao        2022-09-18  3458  			folio_mark_dirty(folio);
bd74fdaea146029 Yu Zhao        2022-09-18  3459  
bd74fdaea146029 Yu Zhao        2022-09-18  3460  		old_gen = folio_update_gen(folio, new_gen);
bd74fdaea146029 Yu Zhao        2022-09-18  3461  		if (old_gen >= 0 && old_gen != new_gen)
bd74fdaea146029 Yu Zhao        2022-09-18  3462  			update_batch_size(walk, folio, old_gen, new_gen);
bd74fdaea146029 Yu Zhao        2022-09-18  3463  next:
bd74fdaea146029 Yu Zhao        2022-09-18  3464  		i = i > MIN_LRU_BATCH ? 0 : find_next_bit(bitmap, MIN_LRU_BATCH, i) + 1;
bd74fdaea146029 Yu Zhao        2022-09-18  3465  	} while (i <= MIN_LRU_BATCH);
bd74fdaea146029 Yu Zhao        2022-09-18  3466  
bd74fdaea146029 Yu Zhao        2022-09-18  3467  	arch_leave_lazy_mmu_mode();
bd74fdaea146029 Yu Zhao        2022-09-18  3468  	spin_unlock(ptl);
bd74fdaea146029 Yu Zhao        2022-09-18  3469  done:
b5ff4133617d0ec T.J. Alumbaugh 2023-01-18  3470  	*first = -1;
bd74fdaea146029 Yu Zhao        2022-09-18  3471  }
bd74fdaea146029 Yu Zhao        2022-09-18  3472  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

