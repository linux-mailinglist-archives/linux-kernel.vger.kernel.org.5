Return-Path: <linux-kernel+bounces-29475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1497830ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDD8B24D10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DA92562D;
	Wed, 17 Jan 2024 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eshbwn1b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B925627
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528405; cv=none; b=XSBRxl4Fd+s8r4nvJV+h6/FriyN9QGEFaUisdXfscCsjoKmHMXrK5h9rohezDlbmBQzne6mKD8HdYtVvorAWhWjjKBYYP8TB7eAsxGLAfPDbk0fs40bjQs2EECsLffgNNCPeKRxnQ4e47dXCta7CMmem+M3cZ96Cb2VpMFsjyRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528405; c=relaxed/simple;
	bh=f2Ra+sQ7t6rzUkTzQkWh4uqtScQNX1h8QkfWcqdRrm8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EfuLVrcIqehqcMbaebrRklKljbazGsVHBDUN+btt+sh/QWfSEbC9fYoySfZ7HCJHamM7v/HEcFeK1o/e6p5kcG7811+SRw6Kr42AyD8RVilkBxnJxPZJ60UIHCkzb1HxgX6PLW723MjnecFANJUUEHNFQwIXbA26VLNQlh8A2JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eshbwn1b; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705528403; x=1737064403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f2Ra+sQ7t6rzUkTzQkWh4uqtScQNX1h8QkfWcqdRrm8=;
  b=eshbwn1bfobxR2ZTro0mLbiVUXutZq4SJTDmeCpvLKeU2K7WR37Z2T06
   Bx3YtypcHyWnuaI3GO2A+mtQOTf5Jl9P+U9qtwBmpgzBo8ookGQ5oSGfP
   wArAm2KCieBdM3sN2SGSDC4Izb4YLbEZ6Yl9Q+fX4cA+AeAOR3D9OkH6Y
   HHNTL93ZTS95AW2p/bz22xI2sSd3f7YS6wQhe4rvGKTxU7aW6I0wOgJN0
   QDa+KkNe5pEggWd9aBukEY0YVOQ+w0VDmQHx1kIWdGKLUMBhCeLy5t72b
   ZydbPjxrFtvoYAUUkp/8pRLHnpFO8MHxLTxpEydu4GrzrdVBm2P0xY+q2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="13793943"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="13793943"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 13:53:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="818630909"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="818630909"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Jan 2024 13:53:20 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQDqX-0002Mm-1P;
	Wed, 17 Jan 2024 21:53:17 +0000
Date: Thu, 18 Jan 2024 05:52:21 +0800
From: kernel test robot <lkp@intel.com>
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, zokeefe@google.com,
	songmuchun@bytedance.com, linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH v1 1/2] mm/madvise: introduce MADV_TRY_COLLAPSE for
 attempted synchronous hugepage collapse
Message-ID: <202401180500.SKo0zynj-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240118/202401180500.SKo0zynj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240118/202401180500.SKo0zynj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401180500.SKo0zynj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/khugepaged.c: In function 'madvise_collapse':
>> mm/khugepaged.c:2784:28: warning: this statement may fall through [-Wimplicit-fallthrough=]
    2784 |                         if (cc->is_try) {
         |                            ^
   mm/khugepaged.c:2789:17: note: here
    2789 |                 case SCAN_PMD_NULL:
         |                 ^~~~


vim +2784 mm/khugepaged.c

  2702	
  2703	int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
  2704			     unsigned long start, unsigned long end, bool is_try)
  2705	{
  2706		struct collapse_control *cc;
  2707		struct mm_struct *mm = vma->vm_mm;
  2708		unsigned long hstart, hend, addr;
  2709		int thps = 0, last_fail = SCAN_FAIL;
  2710		bool mmap_locked = true;
  2711	
  2712		BUG_ON(vma->vm_start > start);
  2713		BUG_ON(vma->vm_end < end);
  2714	
  2715		*prev = vma;
  2716	
  2717		if (!thp_vma_allowable_order(vma, vma->vm_flags, false, false, false,
  2718					     PMD_ORDER))
  2719			return -EINVAL;
  2720	
  2721		cc = kmalloc(sizeof(*cc), GFP_KERNEL);
  2722		if (!cc)
  2723			return -ENOMEM;
  2724		cc->is_khugepaged = false;
  2725		cc->is_try = is_try;
  2726	
  2727		mmgrab(mm);
  2728		lru_add_drain_all();
  2729	
  2730		hstart = (start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
  2731		hend = end & HPAGE_PMD_MASK;
  2732	
  2733		for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
  2734			int result = SCAN_FAIL;
  2735	
  2736			if (!mmap_locked) {
  2737				cond_resched();
  2738				mmap_read_lock(mm);
  2739				mmap_locked = true;
  2740				result = hugepage_vma_revalidate(mm, addr, false, &vma,
  2741								 cc);
  2742				if (result  != SCAN_SUCCEED) {
  2743					last_fail = result;
  2744					goto out_nolock;
  2745				}
  2746	
  2747				hend = min(hend, vma->vm_end & HPAGE_PMD_MASK);
  2748			}
  2749			mmap_assert_locked(mm);
  2750			memset(cc->node_load, 0, sizeof(cc->node_load));
  2751			nodes_clear(cc->alloc_nmask);
  2752			if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
  2753				struct file *file = get_file(vma->vm_file);
  2754				pgoff_t pgoff = linear_page_index(vma, addr);
  2755	
  2756				mmap_read_unlock(mm);
  2757				mmap_locked = false;
  2758				result = hpage_collapse_scan_file(mm, addr, file, pgoff,
  2759								  cc);
  2760				fput(file);
  2761			} else {
  2762				result = hpage_collapse_scan_pmd(mm, vma, addr,
  2763								 &mmap_locked, cc);
  2764			}
  2765			if (!mmap_locked)
  2766				*prev = NULL;  /* Tell caller we dropped mmap_lock */
  2767	
  2768	handle_result:
  2769			switch (result) {
  2770			case SCAN_SUCCEED:
  2771			case SCAN_PMD_MAPPED:
  2772				++thps;
  2773				break;
  2774			case SCAN_PTE_MAPPED_HUGEPAGE:
  2775				BUG_ON(mmap_locked);
  2776				BUG_ON(*prev);
  2777				mmap_read_lock(mm);
  2778				result = collapse_pte_mapped_thp(mm, addr, true);
  2779				mmap_read_unlock(mm);
  2780				goto handle_result;
  2781			/* MADV_TRY_COLLAPSE: fail quickly */
  2782			case SCAN_ALLOC_HUGE_PAGE_FAIL:
  2783			case SCAN_CGROUP_CHARGE_FAIL:
> 2784				if (cc->is_try) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

