Return-Path: <linux-kernel+bounces-29591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8376F831088
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D60FEB21C31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A3F2CA9;
	Thu, 18 Jan 2024 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hz/9guMg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA64F28F5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705537948; cv=none; b=OyD2dPLDsg80pW6g7vZlNUWYnZhjZONvgZP48JXV73HPtgTK1DF4IogCaWEDQbRQYVEGZQkdx0g7oq8DoRY+GvjjT7LMXcOcFQ8udeFU0Q+uVnTzbBmlayZPuht+sXPp1Hfizp1QyFb6/JbZq3s6XddBbx2I+dIeUs7r7UgAdlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705537948; c=relaxed/simple;
	bh=OLJJoAAnmlKlvt/BI3ahclq+8BqJWZ/nmmpxLUo264k=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b6F4mZcjGIo6kKh8r+Dn5khNUNO8TD9CAuk0bg+H5bFGogFAmtuLnHSh8+oyTKbkldH/UP1oFT+4zJKRLT1gpFaByL/Alaz3Xi669J27Vvbtgs5ygh2po8FVcrqxOmOmerVSoEb2ByLiE8sntqZSnAtd98OQcssLWhDJ6n3KIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hz/9guMg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705537946; x=1737073946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OLJJoAAnmlKlvt/BI3ahclq+8BqJWZ/nmmpxLUo264k=;
  b=Hz/9guMghJtEzErc8FVC8MZ4ZrbFVJWkqtMYkYaKybW1Ut4SeU0E0UcQ
   5PI+zdw3DUTIuzulFvfR6v8/mCczeTCJiXqyItJS5AUAkXllPUYNcFaWw
   uiLjkJp2Vph5tzA79hGMwvz4vhyOm4Okup9OfdvjiZGGEPL7DL9nJhhJJ
   7pWDvepBerVxt1GxKxPCnk8dz9u8NsABue2a4QcX67HIwGg5m3Fhc5h/A
   TKb0AdOa0Cn2lnzQJytMZLIF6V3dFdwkBZh44w3KXGBD1J9e0s+iNfAmZ
   ugyOa/gbAinTkHS/XdJhvlzadYBwQYqSnORC6zVBWdCxvB8NP9Q751fJ5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="13664138"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="13664138"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 16:32:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="1031494524"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="1031494524"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2024 16:32:22 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQGKS-0002SQ-1q;
	Thu, 18 Jan 2024 00:32:20 +0000
Date: Thu, 18 Jan 2024 08:32:10 +0800
From: kernel test robot <lkp@intel.com>
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, zokeefe@google.com,
	songmuchun@bytedance.com, linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH v1 1/2] mm/madvise: introduce MADV_TRY_COLLAPSE for
 attempted synchronous hugepage collapse
Message-ID: <202401180810.sR4s25PR-lkp@intel.com>
References: <20240117050217.43610-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117050217.43610-1-ioworker0@gmail.com>

Hi Lance,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Lance-Yang/mm-madvise-add-MADV_TRY_COLLAPSE-to-process_madvise/20240117-130450
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240117050217.43610-1-ioworker0%40gmail.com
patch subject: [PATCH v1 1/2] mm/madvise: introduce MADV_TRY_COLLAPSE for attempted synchronous hugepage collapse
config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20240118/202401180810.sR4s25PR-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240118/202401180810.sR4s25PR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401180810.sR4s25PR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/khugepaged.c:2789:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    2789 |                 case SCAN_PMD_NULL:
         |                 ^
   mm/khugepaged.c:2789:3: note: insert '__attribute__((fallthrough));' to silence this warning
    2789 |                 case SCAN_PMD_NULL:
         |                 ^
         |                 __attribute__((fallthrough)); 
   mm/khugepaged.c:2789:3: note: insert 'break;' to avoid fall-through
    2789 |                 case SCAN_PMD_NULL:
         |                 ^
         |                 break; 
   1 warning generated.


vim +2789 mm/khugepaged.c

7d8faaf155454f Zach O'Keefe 2022-07-06  2702  
7d8faaf155454f Zach O'Keefe 2022-07-06  2703  int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
a37dacf95f1857 Lance Yang   2024-01-17  2704  		     unsigned long start, unsigned long end, bool is_try)
7d8faaf155454f Zach O'Keefe 2022-07-06  2705  {
7d8faaf155454f Zach O'Keefe 2022-07-06  2706  	struct collapse_control *cc;
7d8faaf155454f Zach O'Keefe 2022-07-06  2707  	struct mm_struct *mm = vma->vm_mm;
7d8faaf155454f Zach O'Keefe 2022-07-06  2708  	unsigned long hstart, hend, addr;
7d8faaf155454f Zach O'Keefe 2022-07-06  2709  	int thps = 0, last_fail = SCAN_FAIL;
7d8faaf155454f Zach O'Keefe 2022-07-06  2710  	bool mmap_locked = true;
7d8faaf155454f Zach O'Keefe 2022-07-06  2711  
7d8faaf155454f Zach O'Keefe 2022-07-06  2712  	BUG_ON(vma->vm_start > start);
7d8faaf155454f Zach O'Keefe 2022-07-06  2713  	BUG_ON(vma->vm_end < end);
7d8faaf155454f Zach O'Keefe 2022-07-06  2714  
7d8faaf155454f Zach O'Keefe 2022-07-06  2715  	*prev = vma;
7d8faaf155454f Zach O'Keefe 2022-07-06  2716  
3485b88390b0af Ryan Roberts 2023-12-07  2717  	if (!thp_vma_allowable_order(vma, vma->vm_flags, false, false, false,
3485b88390b0af Ryan Roberts 2023-12-07  2718  				     PMD_ORDER))
7d8faaf155454f Zach O'Keefe 2022-07-06  2719  		return -EINVAL;
7d8faaf155454f Zach O'Keefe 2022-07-06  2720  
7d8faaf155454f Zach O'Keefe 2022-07-06  2721  	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
7d8faaf155454f Zach O'Keefe 2022-07-06  2722  	if (!cc)
7d8faaf155454f Zach O'Keefe 2022-07-06  2723  		return -ENOMEM;
7d8faaf155454f Zach O'Keefe 2022-07-06  2724  	cc->is_khugepaged = false;
a37dacf95f1857 Lance Yang   2024-01-17  2725  	cc->is_try = is_try;
7d8faaf155454f Zach O'Keefe 2022-07-06  2726  
7d8faaf155454f Zach O'Keefe 2022-07-06  2727  	mmgrab(mm);
7d8faaf155454f Zach O'Keefe 2022-07-06  2728  	lru_add_drain_all();
7d8faaf155454f Zach O'Keefe 2022-07-06  2729  
7d8faaf155454f Zach O'Keefe 2022-07-06  2730  	hstart = (start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
7d8faaf155454f Zach O'Keefe 2022-07-06  2731  	hend = end & HPAGE_PMD_MASK;
7d8faaf155454f Zach O'Keefe 2022-07-06  2732  
7d8faaf155454f Zach O'Keefe 2022-07-06  2733  	for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
7d8faaf155454f Zach O'Keefe 2022-07-06  2734  		int result = SCAN_FAIL;
7d8faaf155454f Zach O'Keefe 2022-07-06  2735  
7d8faaf155454f Zach O'Keefe 2022-07-06  2736  		if (!mmap_locked) {
7d8faaf155454f Zach O'Keefe 2022-07-06  2737  			cond_resched();
7d8faaf155454f Zach O'Keefe 2022-07-06  2738  			mmap_read_lock(mm);
7d8faaf155454f Zach O'Keefe 2022-07-06  2739  			mmap_locked = true;
34488399fa08fa Zach O'Keefe 2022-09-22  2740  			result = hugepage_vma_revalidate(mm, addr, false, &vma,
34488399fa08fa Zach O'Keefe 2022-09-22  2741  							 cc);
7d8faaf155454f Zach O'Keefe 2022-07-06  2742  			if (result  != SCAN_SUCCEED) {
7d8faaf155454f Zach O'Keefe 2022-07-06  2743  				last_fail = result;
7d8faaf155454f Zach O'Keefe 2022-07-06  2744  				goto out_nolock;
7d8faaf155454f Zach O'Keefe 2022-07-06  2745  			}
4d24de9425f75f Yang Shi     2022-09-14  2746  
52dc031088f00e Zach O'Keefe 2022-12-24  2747  			hend = min(hend, vma->vm_end & HPAGE_PMD_MASK);
7d8faaf155454f Zach O'Keefe 2022-07-06  2748  		}
7d8faaf155454f Zach O'Keefe 2022-07-06  2749  		mmap_assert_locked(mm);
7d8faaf155454f Zach O'Keefe 2022-07-06  2750  		memset(cc->node_load, 0, sizeof(cc->node_load));
e031ff96b334a0 Yang Shi     2022-11-08  2751  		nodes_clear(cc->alloc_nmask);
34488399fa08fa Zach O'Keefe 2022-09-22  2752  		if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
34488399fa08fa Zach O'Keefe 2022-09-22  2753  			struct file *file = get_file(vma->vm_file);
34488399fa08fa Zach O'Keefe 2022-09-22  2754  			pgoff_t pgoff = linear_page_index(vma, addr);
34488399fa08fa Zach O'Keefe 2022-09-22  2755  
34488399fa08fa Zach O'Keefe 2022-09-22  2756  			mmap_read_unlock(mm);
34488399fa08fa Zach O'Keefe 2022-09-22  2757  			mmap_locked = false;
34488399fa08fa Zach O'Keefe 2022-09-22  2758  			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
7d2c4385c3417c Zach O'Keefe 2022-07-06  2759  							  cc);
34488399fa08fa Zach O'Keefe 2022-09-22  2760  			fput(file);
34488399fa08fa Zach O'Keefe 2022-09-22  2761  		} else {
34488399fa08fa Zach O'Keefe 2022-09-22  2762  			result = hpage_collapse_scan_pmd(mm, vma, addr,
34488399fa08fa Zach O'Keefe 2022-09-22  2763  							 &mmap_locked, cc);
34488399fa08fa Zach O'Keefe 2022-09-22  2764  		}
7d8faaf155454f Zach O'Keefe 2022-07-06  2765  		if (!mmap_locked)
7d8faaf155454f Zach O'Keefe 2022-07-06  2766  			*prev = NULL;  /* Tell caller we dropped mmap_lock */
7d8faaf155454f Zach O'Keefe 2022-07-06  2767  
34488399fa08fa Zach O'Keefe 2022-09-22  2768  handle_result:
7d8faaf155454f Zach O'Keefe 2022-07-06  2769  		switch (result) {
7d8faaf155454f Zach O'Keefe 2022-07-06  2770  		case SCAN_SUCCEED:
7d8faaf155454f Zach O'Keefe 2022-07-06  2771  		case SCAN_PMD_MAPPED:
7d8faaf155454f Zach O'Keefe 2022-07-06  2772  			++thps;
7d8faaf155454f Zach O'Keefe 2022-07-06  2773  			break;
34488399fa08fa Zach O'Keefe 2022-09-22  2774  		case SCAN_PTE_MAPPED_HUGEPAGE:
34488399fa08fa Zach O'Keefe 2022-09-22  2775  			BUG_ON(mmap_locked);
34488399fa08fa Zach O'Keefe 2022-09-22  2776  			BUG_ON(*prev);
1043173eb5eb35 Hugh Dickins 2023-07-11  2777  			mmap_read_lock(mm);
34488399fa08fa Zach O'Keefe 2022-09-22  2778  			result = collapse_pte_mapped_thp(mm, addr, true);
1043173eb5eb35 Hugh Dickins 2023-07-11  2779  			mmap_read_unlock(mm);
34488399fa08fa Zach O'Keefe 2022-09-22  2780  			goto handle_result;
a37dacf95f1857 Lance Yang   2024-01-17  2781  		/* MADV_TRY_COLLAPSE: fail quickly */
a37dacf95f1857 Lance Yang   2024-01-17  2782  		case SCAN_ALLOC_HUGE_PAGE_FAIL:
a37dacf95f1857 Lance Yang   2024-01-17  2783  		case SCAN_CGROUP_CHARGE_FAIL:
a37dacf95f1857 Lance Yang   2024-01-17  2784  			if (cc->is_try) {
a37dacf95f1857 Lance Yang   2024-01-17  2785  				last_fail = result;
a37dacf95f1857 Lance Yang   2024-01-17  2786  				goto out_maybelock;
a37dacf95f1857 Lance Yang   2024-01-17  2787  			}
7d8faaf155454f Zach O'Keefe 2022-07-06  2788  		/* Whitelisted set of results where continuing OK */
7d8faaf155454f Zach O'Keefe 2022-07-06 @2789  		case SCAN_PMD_NULL:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

