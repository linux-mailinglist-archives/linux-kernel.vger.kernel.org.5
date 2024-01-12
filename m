Return-Path: <linux-kernel+bounces-24596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2F782BEBD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F901F2548D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AB25B5D7;
	Fri, 12 Jan 2024 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fq4nAbmg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2027B58229
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705056606; x=1736592606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jBcbNO/emXMnFd8vU5REf/lVFMfe1N3qhJIffw/+PT0=;
  b=fq4nAbmgLqXPtUM2QrpXjBXdTK/1xhYm8vmAVDvySLdbWs36VLPVy0ax
   Kbus7Sb/zEC2jbxcL7LiTcVSuIDt5/1WWO2dSYUVeoANlhM63Q9fyGpYJ
   fYQHfJF0+YaD4pGU9Dtzpu85uH+cULDnnsghL3eiX3NpoUZvvEAkUncMu
   RCMvh7piJ65P9pxpQNvwFf2Lx4Km0HlxfKN8LOEwJFQKqQyYWp+cSi4Ex
   Xc1NLX6+vYXMbnDikKVYh7dxEHBnwZhZZh9bSVyK0x2/Uqa1ZDTk2I3vk
   fkdRMfm/3Y36/V+s3qk8bGPIziEZaAYB9X8u/B1+DDoqMe/TWRt19T/0+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="6505412"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="6505412"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 02:50:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="759093869"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="759093869"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2024 02:50:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOF6t-0009LA-2e;
	Fri, 12 Jan 2024 10:49:59 +0000
Date: Fri, 12 Jan 2024 18:49:50 +0800
From: kernel test robot <lkp@intel.com>
To: Wupeng Ma <mawupeng1@huawei.com>, akpm@linux-foundation.org,
	dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org, mawupeng1@huawei.com,
	bp@suse.de, mingo@redhat.com
Subject: Re: [PATCH v3 2/3] x86/mm/pat: Cleanup unused parameter in
 follow_phys
Message-ID: <202401121839.yeX0qcR8-lkp@intel.com>
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
[also build test WARNING on tip/x86/mm tip/master linus/master v6.7 next-20240112]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wupeng-Ma/x86-mm-pat-Move-follow_phys-to-pat-related-file/20240111-201305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240111120929.2694440-3-mawupeng1%40huawei.com
patch subject: [PATCH v3 2/3] x86/mm/pat: Cleanup unused parameter in follow_phys
config: i386-buildonly-randconfig-002-20240112 (https://download.01.org/0day-ci/archive/20240112/202401121839.yeX0qcR8-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121839.yeX0qcR8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401121839.yeX0qcR8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/mm/pat/memtype.c:973:2: error: call to undeclared function 'kunmap_local'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     973 |         pte_unmap_unlock(ptep, ptl);
         |         ^
   include/linux/mm.h:2965:2: note: expanded from macro 'pte_unmap_unlock'
    2965 |         pte_unmap(pte);                                 \
         |         ^
   include/linux/pgtable.h:103:2: note: expanded from macro 'pte_unmap'
     103 |         kunmap_local((pte));    \
         |         ^
>> arch/x86/mm/pat/memtype.c:972:1: warning: unused label 'unlock' [-Wunused-label]
     972 | unlock:
         | ^~~~~~~
   1 warning and 1 error generated.


vim +/unlock +972 arch/x86/mm/pat/memtype.c

5899329b19100c0 arch/x86/mm/pat.c         venkatesh.pallipadi@intel.com 2008-12-18  952  
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  953  static int follow_phys(struct vm_area_struct *vma,
76b476f1ffb4bf1 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  954  		unsigned long address,  unsigned long *prot,
76b476f1ffb4bf1 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  955  		resource_size_t *phys)
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  956  {
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  957  	int ret = -EINVAL;
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  958  	pte_t *ptep, pte;
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  959  	spinlock_t *ptl;
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  960  
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  961  	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  962  		goto out;
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  963  
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  964  	if (follow_pte(vma->vm_mm, address, &ptep, &ptl))
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  965  		goto out;
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  966  	pte = ptep_get(ptep);
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  967  
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  968  	*prot = pgprot_val(pte_pgprot(pte));
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  969  	*phys = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  970  
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  971  	ret = 0;
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11 @972  unlock:
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11 @973  	pte_unmap_unlock(ptep, ptl);
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  974  out:
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  975  	return ret;
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  976  }
b4e07d9667b7ae8 arch/x86/mm/pat/memtype.c Ma Wupeng                     2024-01-11  977  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

