Return-Path: <linux-kernel+bounces-24342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC6482BB50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C0E1F25782
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC38C5B5D9;
	Fri, 12 Jan 2024 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWG4VulK"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445CB1B288
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705041369; x=1736577369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fKRsDn8W4tQGJ3IWNeAiK08VDkkQjZ2SeTZwpMxnKZs=;
  b=bWG4VulK9DN3G2aLax3/gZ7seuQWmH7ly4fVb/szXK0BHiKpErc/clcx
   hj7BcmH3qVsULqHDxhJ0TVb1zcFkITJDKKGxZlR/bIrRiJsG6Y56Lo07H
   Clcog7YhDfNV+ZbukFHmvTHEkfu/Wssh+LfU5lYyInfXPRZ+1svyuvMnp
   05EV91M67abDjj2v6IebKcTxZonNYQnVYxQkkuHWzai7WwZO2U7/n34wJ
   +RV0e1wndmqD8EGFzLd+0v0Tv+XUgRBhHbPxDiWR3sAuT2b30/Jynqood
   95Kvg81hp2d4iL8wU1g9hgDWWPflLF+wV1y3/n3XAGLGMPbu9XWyghdgM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="397975962"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="397975962"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 22:36:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="956022351"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="956022351"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2024 22:36:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOB98-0009AC-1C;
	Fri, 12 Jan 2024 06:36:02 +0000
Date: Fri, 12 Jan 2024 14:35:42 +0800
From: kernel test robot <lkp@intel.com>
To: Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org,
	dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, mawupeng1@huawei.com, bp@suse.de, mingo@redhat.com
Subject: Re: [PATCH v3 2/3] x86/mm/pat: Cleanup unused parameter in
 follow_phys
Message-ID: <202401121454.wuRFNxQE-lkp@intel.com>
References: <20240111120929.2694440-3-mawupeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111120929.2694440-3-mawupeng1@huawei.com>

Hi Wupeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on tip/x86/mm tip/master linus/master v6.7 next-20240111]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wupeng-Ma/x86-mm-pat-Move-follow_phys-to-pat-related-file/20240111-201305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240111120929.2694440-3-mawupeng1%40huawei.com
patch subject: [PATCH v3 2/3] x86/mm/pat: Cleanup unused parameter in follow_phys
config: i386-alldefconfig (https://download.01.org/0day-ci/archive/20240112/202401121454.wuRFNxQE-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121454.wuRFNxQE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401121454.wuRFNxQE-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/mm/pat/memtype.c: In function 'follow_phys':
>> arch/x86/mm/pat/memtype.c:972:1: warning: label 'unlock' defined but not used [-Wunused-label]
     972 | unlock:
         | ^~~~~~


vim +/unlock +972 arch/x86/mm/pat/memtype.c

5899329b19100c arch/x86/mm/pat.c         venkatesh.pallipadi@intel.com 2008-12-18  952  
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  953  static int follow_phys(struct vm_area_struct *vma,
76b476f1ffb4bf arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  954  		unsigned long address,  unsigned long *prot,
76b476f1ffb4bf arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  955  		resource_size_t *phys)
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  956  {
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  957  	int ret = -EINVAL;
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  958  	pte_t *ptep, pte;
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  959  	spinlock_t *ptl;
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  960  
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  961  	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  962  		goto out;
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  963  
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  964  	if (follow_pte(vma->vm_mm, address, &ptep, &ptl))
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  965  		goto out;
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  966  	pte = ptep_get(ptep);
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  967  
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  968  	*prot = pgprot_val(pte_pgprot(pte));
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  969  	*phys = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  970  
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  971  	ret = 0;
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11 @972  unlock:
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  973  	pte_unmap_unlock(ptep, ptl);
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  974  out:
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  975  	return ret;
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  976  }
b4e07d9667b7ae arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  977  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

