Return-Path: <linux-kernel+bounces-132915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD67899BFF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324021F2398C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8860C16C69A;
	Fri,  5 Apr 2024 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBA4z7sD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B4216C68D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317011; cv=none; b=b2vWSnmUprdo70D4nZTqt9bTZgm0HYlFNM7YVJlvauLzPijOSxJt4mKZ0baSJv7Hr9h/HDj8gEH/wrTvFMn05IQa1zkhlktHK0atJnCknXv388+UDo6S8NUOaL9Y4NCsC88Qim0KArrhxzlCyrGdOe3paFCE9ZIA5iAZGiuliPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317011; c=relaxed/simple;
	bh=Sg12EAx3ICVX5lOqralz4pA5DQW+y0y4c7gHeCPwJD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWLvRjihJSbZrDO6uxgDHCrX06XMi4Mm3MpuSa7fq27ia/hQoaSzbeDGWuD3tSc4Wqc2NOMiaGuIdigF53HECKnnXca0uTVX/cYhFQAK/buA1eU1LF5o+tNE/608UFq70SF38qr6OsQr3hUNBY1OElkAxNQElPOp728nn0hdlH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBA4z7sD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712317010; x=1743853010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sg12EAx3ICVX5lOqralz4pA5DQW+y0y4c7gHeCPwJD4=;
  b=mBA4z7sDqkYCvNhKr1+dRFu0J/WbKMsV5V78kawYWXhjwcbz5N35fRS1
   FiZNVTxdwcGABOP2dcsOm6Tf09InRQaBLK+J2zoQwVveYkU0VNBHhtptX
   cOe9jNmvap9cJGjvv8Z7sLYO/Ph9I+a29pbLlcAQTqLspvWo6XnWS2P9R
   qSxRQF5QjJcUyt2DZxsaCxkhZs4TtqOWZqy2Kr30JfIrA/jOA9O+7Id2m
   qIbwtFAhuQVHd0GkPKVUI1jVFwqda0YcC+AQJjGy6fCZNqr6yGpoyJUCq
   4+Md+J0dqujr6UeEOWGa/N266nfAnv0rCJEv0k4KAUNuD4/5y9OdC1ksG
   w==;
X-CSE-ConnectionGUID: J7LfPHFeQ1OTaF8wZjc61w==
X-CSE-MsgGUID: MKL0mrlJT/u1I8lbf9vERg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7875567"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7875567"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 04:36:49 -0700
X-CSE-ConnectionGUID: FdXcbv0BS7OEke4j78pCPw==
X-CSE-MsgGUID: /HKD6oOtRniCRwO9R7X0qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="56602327"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Apr 2024 04:36:43 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rshs8-0002DT-1p;
	Fri, 05 Apr 2024 11:36:40 +0000
Date: Fri, 5 Apr 2024 19:36:17 +0800
From: kernel test robot <lkp@intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, rafael@kernel.org,
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com, michael.roth@amd.com, seanjc@google.com,
	kai.huang@intel.com, bhe@redhat.com,
	kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] x86/snp: Convert shared memory back to private on
 kexec
Message-ID: <202404051917.mk4DoDkI-lkp@intel.com>
References: <41db1ebbe58fb082dbe848f1c666ed23e83f1752.1712270976.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41db1ebbe58fb082dbe848f1c666ed23e83f1752.1712270976.git.ashish.kalra@amd.com>

Hi Ashish,

kernel test robot noticed the following build warnings:

[auto build test WARNING on efi/next]
[also build test WARNING on linus/master v6.9-rc2 next-20240405]
[cannot apply to tip/x86/core tip/master tip/x86/mm tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ashish-Kalra/efi-x86-skip-efi_arch_mem_reserve-in-case-of-kexec/20240405-071346
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/41db1ebbe58fb082dbe848f1c666ed23e83f1752.1712270976.git.ashish.kalra%40amd.com
patch subject: [PATCH v3 4/4] x86/snp: Convert shared memory back to private on kexec
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240405/202404051917.mk4DoDkI-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404051917.mk4DoDkI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404051917.mk4DoDkI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/kernel/sev.c:1006:14: error: call to undeclared function 'pte_decrypted'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1006 |                 if (pte && pte_decrypted(*pte) && !pte_none(*pte)) {
         |                            ^
   arch/x86/kernel/sev.c:1035:16: error: call to undeclared function 'pte_decrypted'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1035 |                 if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
         |                              ^
>> arch/x86/kernel/sev.c:1025:16: warning: variable 'size' set but not used [-Wunused-but-set-variable]
    1025 |         unsigned long size;
         |                       ^
   arch/x86/kernel/sev.c:1056:7: error: call to undeclared function 'stop_memory_enc_conversion'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1056 |         if (!stop_memory_enc_conversion(wait_for_lock))
         |              ^
   1 warning and 3 errors generated.


vim +/size +1025 arch/x86/kernel/sev.c

  1021	
  1022	static void unshare_all_bss_decrypted_memory(void)
  1023	{
  1024		unsigned long vaddr, vaddr_end;
> 1025		unsigned long size;
  1026		unsigned int level;
  1027		unsigned int npages;
  1028		pte_t *pte;
  1029	
  1030		vaddr = (unsigned long)__start_bss_decrypted;
  1031		vaddr_end = (unsigned long)__start_bss_decrypted_unused;
  1032		npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
  1033		for (; vaddr < vaddr_end; vaddr += PAGE_SIZE) {
  1034			pte = lookup_address(vaddr, &level);
  1035			if (!pte || !pte_decrypted(*pte) || pte_none(*pte))
  1036				continue;
  1037	
  1038			size = page_level_size(level);
  1039			set_pte_enc(pte, level, (void *)vaddr);
  1040		}
  1041		vaddr = (unsigned long)__start_bss_decrypted;
  1042		snp_set_memory_private(vaddr, npages);
  1043	}
  1044	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

