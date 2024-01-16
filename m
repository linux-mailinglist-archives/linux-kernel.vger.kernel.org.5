Return-Path: <linux-kernel+bounces-28295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ABB82FCA4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E2D1C26CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7F22EB1D;
	Tue, 16 Jan 2024 21:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="McSdSeZi"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A11154A6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440455; cv=none; b=al7rAE+RA28bjga45Yq1vcCrji/F0okpcarVfnTfddFbWj8D2cg4kW/h5tP+iJoFbeBqtetdlzcEc0JaPnguOjNjMSPPs4vfTaFJNhdY5G2P1hSAUsLUtNpVbg4XCdG/PohRU7bLgszjukwxTy08mtg1AAvbghygDOEk+gg/YI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440455; c=relaxed/simple;
	bh=tTB1Chezho9b8AhhxeEGmrGzWtaHiHCg0jhnEGqHiRs=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VsUorA6psrEpy09hnZEYTW3XhuMA1zNVoG8W96aGHA9TA3Ch2UZ7i7z8vcawU78G1L53tUk6tqthD7VhXZC5iOVjsFSbN0AlDYEbRDJiqhcW7kKxZNY5fZKF+Yurpk2Yyn9B8S6KiyPbS2cYLgCJG5L0d0TGYqnI7wgRtuPcr9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=McSdSeZi; arc=none smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705440453; x=1736976453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tTB1Chezho9b8AhhxeEGmrGzWtaHiHCg0jhnEGqHiRs=;
  b=McSdSeZiluRo0rlswROsfaHY03rFZeqIIWcYNAAhAW8dE+9haKzu+p0U
   SrmBkcJB7mD5xdAoNlOFXDawbCnhw5bi1pWjD5+MnxDBHSo2yF6N8Z8KF
   GCMKXULa55YU8mmVhDBElkWKCI9fYzk+tSerTO71GRy0LRoIMJFifnfEU
   1wE7nc1Ei0u9en7OE1seuaVovMyKST//ZOXsS/z12Mi13fRtPJnMkmPFj
   abcy9AzBna+pSIHWDRmvADzsswa1tmGcxMEHVAH3MK+2nDSI8Po3Dxh07
   xwxIpNKccLT03BBjjvFM3Qfze6VgDgMMA5trOI4kICcHS5ZDnThc7KZdl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="486149250"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="486149250"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:27:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="787585730"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="787585730"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 16 Jan 2024 13:27:31 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPqy1-0001G6-04;
	Tue, 16 Jan 2024 21:27:29 +0000
Date: Wed, 17 Jan 2024 05:26:58 +0800
From: kernel test robot <lkp@intel.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	ryan.roberts@arm.com, Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm: memory: move mem_cgroup_charge() into
 alloc_anon_folio()
Message-ID: <202401170535.2TfJ7u74-lkp@intel.com>
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
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240117/202401170535.2TfJ7u74-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240117/202401170535.2TfJ7u74-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401170535.2TfJ7u74-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   mm/memory.c: In function 'alloc_anon_folio':
>> mm/memory.c:4223:31: error: 'vma' undeclared (first use in this function); did you mean 'vmf'?
    4223 |         return folio_prealloc(vma->vm_mm, vma, vmf->address, true);
         |                               ^~~
         |                               vmf
   mm/memory.c:4223:31: note: each undeclared identifier is reported only once for each function it appears in
>> mm/memory.c:4224:1: warning: control reaches end of non-void function [-Wreturn-type]
    4224 | }
         | ^


vim +4223 mm/memory.c

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
> 4224	}
  4225	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

