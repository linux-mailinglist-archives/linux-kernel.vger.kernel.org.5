Return-Path: <linux-kernel+bounces-28382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE9C82FDCF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E486C1C23D09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF84067C65;
	Tue, 16 Jan 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxAbaKKF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E21DA29
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705448500; cv=none; b=ebZyvNbegsJV3WhwG7FUttWywt0zA3zGZ+mv+aw45fFd8TrqjRivooD+mtZD13Joo1skYgNd5otSrlDJeU+k4QMahUZaewsUMwnO8d4mQFK5DF0nRUfBIq5R9ilXd60g7rK71rdGhSQ3AwWAiSReEVfRGZny2vJc69Rgify5LCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705448500; c=relaxed/simple;
	bh=W72U7S1Jt5TV+GwwBd0uYWUfAkSSUDs+SxFcWOvvgpA=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KZmSEZJI927aw7bVVn1WgsWBBt1h/XmtdAF6ZS0SKo8MKt9fkY3Hqq8oBspWhtjj7a7vc70w91diEckDlOb/g96/piOi7+qFXJFUpYILmW3V05s2ZkC3QiTLsvM/iyThgFGFxcDpUSlAUkHu5pbycfomL4X2eZgf5nQ3f0iFZ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxAbaKKF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705448499; x=1736984499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W72U7S1Jt5TV+GwwBd0uYWUfAkSSUDs+SxFcWOvvgpA=;
  b=MxAbaKKFFz1964iZbk1ZSpLXx/tYzNz9K68PMfmtcqbk60F+hv7IF4dN
   /jabgaXl+Y5sdLzIX70BY8g78JCHBB+HcdJUhugX4/M8O6i0ZcRkkZnr0
   9rykhu05KmPJivEVvrSwIM2seq7lhJOvRR+f4I0/aNy7WBN91y/1jPeZB
   EKcSTichDBwwof/uKzH1fb7Qv+YZGh/idhphBoQUCViy+x8K/Pbl5aadd
   8pT8/BRVrC+7EgkXXEGtiEZPc+gOWIPV7FQSZrWQQnJgoli8HmRr59lTe
   M74J1qAz4oZCJ2u+lNcflprtNdr2FnXwWR03eVMs3+AEdbzhHSQWCTz+X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6778022"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="6778022"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 15:41:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="874641224"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="874641224"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2024 15:41:35 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPt3l-0001MV-1H;
	Tue, 16 Jan 2024 23:41:33 +0000
Date: Wed, 17 Jan 2024 07:41:27 +0800
From: kernel test robot <lkp@intel.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	ryan.roberts@arm.com, Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm: memory: move mem_cgroup_charge() into
 alloc_anon_folio()
Message-ID: <202401170708.XjVa9Trj-lkp@intel.com>
References: <20240116071302.2282230-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116071302.2282230-1-wangkefeng.wang@huawei.com>

Hi Kefeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/mm-memory-move-mem_cgroup_charge-into-alloc_anon_folio/20240116-151640
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240116071302.2282230-1-wangkefeng.wang%40huawei.com
patch subject: [PATCH] mm: memory: move mem_cgroup_charge() into alloc_anon_folio()
config: i386-buildonly-randconfig-002-20240116 (https://download.01.org/0day-ci/archive/20240117/202401170708.XjVa9Trj-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240117/202401170708.XjVa9Trj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401170708.XjVa9Trj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/memory.c:4223:24: error: use of undeclared identifier 'vma'
    4223 |         return folio_prealloc(vma->vm_mm, vma, vmf->address, true);
         |                               ^
   mm/memory.c:4223:36: error: use of undeclared identifier 'vma'
    4223 |         return folio_prealloc(vma->vm_mm, vma, vmf->address, true);
         |                                           ^
   2 errors generated.


vim +/vma +4223 mm/memory.c

  4153	
  4154	static struct folio *alloc_anon_folio(struct vm_fault *vmf)
  4155	{
  4156	#ifdef CONFIG_TRANSPARENT_HUGEPAGE
  4157		struct vm_area_struct *vma = vmf->vma;
  4158		unsigned long orders;
  4159		struct folio *folio;
  4160		unsigned long addr;
  4161		pte_t *pte;
  4162		gfp_t gfp;
  4163		int order;
  4164	
  4165		/*
  4166		 * If uffd is active for the vma we need per-page fault fidelity to
  4167		 * maintain the uffd semantics.
  4168		 */
  4169		if (unlikely(userfaultfd_armed(vma)))
  4170			goto fallback;
  4171	
  4172		/*
  4173		 * Get a list of all the (large) orders below PMD_ORDER that are enabled
  4174		 * for this vma. Then filter out the orders that can't be allocated over
  4175		 * the faulting address and still be fully contained in the vma.
  4176		 */
  4177		orders = thp_vma_allowable_orders(vma, vma->vm_flags, false, true, true,
  4178						  BIT(PMD_ORDER) - 1);
  4179		orders = thp_vma_suitable_orders(vma, vmf->address, orders);
  4180	
  4181		if (!orders)
  4182			goto fallback;
  4183	
  4184		pte = pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
  4185		if (!pte)
  4186			return ERR_PTR(-EAGAIN);
  4187	
  4188		/*
  4189		 * Find the highest order where the aligned range is completely
  4190		 * pte_none(). Note that all remaining orders will be completely
  4191		 * pte_none().
  4192		 */
  4193		order = highest_order(orders);
  4194		while (orders) {
  4195			addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
  4196			if (pte_range_none(pte + pte_index(addr), 1 << order))
  4197				break;
  4198			order = next_order(&orders, order);
  4199		}
  4200	
  4201		pte_unmap(pte);
  4202	
  4203		/* Try allocating the highest of the remaining orders. */
  4204		gfp = vma_thp_gfp_mask(vma);
  4205		while (orders) {
  4206			addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
  4207			folio = vma_alloc_folio(gfp, order, vma, addr, true);
  4208			if (folio) {
  4209				if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
  4210					folio_put(folio);
  4211					goto next;
  4212				}
  4213				folio_throttle_swaprate(folio, gfp);
  4214				clear_huge_page(&folio->page, vmf->address, 1 << order);
  4215				return folio;
  4216			}
  4217	next:
  4218			order = next_order(&orders, order);
  4219		}
  4220	
  4221	fallback:
  4222	#endif
> 4223		return folio_prealloc(vma->vm_mm, vma, vmf->address, true);
  4224	}
  4225	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

