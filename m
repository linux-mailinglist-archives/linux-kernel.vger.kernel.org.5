Return-Path: <linux-kernel+bounces-132911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92764899BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 049FDB217A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7438A16C693;
	Fri,  5 Apr 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqLvIf+a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C91649D9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316951; cv=none; b=JuTd0pLDyo3Hmhq57Px0EJ7gclK3/63vXMeNT9D82KmSVaTcxNPdTJJaOsDFPg4d3PMwkVQaDUPT9shamBJUsIu1T0ZxgO2NW+tNCt8zSFCbD7D1gt8IiVpJk+8pYPJLT+QdaXidzh0lZ3mHxGOhzYSwHmvq/CyzT0p8vzriQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316951; c=relaxed/simple;
	bh=K7i60+sSZKMcg+5XCR700KMaSBu51hz4EyNyn5CxZG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+xMKX7wKyHgHFbiUP70BrHK0MDe+6gz5sHPIf7kmuvoV0PahYtlm56olOnam8yHPdwbUZEHACIw+lRvUyACRWZ46s+cvkEwur7BxgKrN26RBoZsHXFvA8J7QMpj6V/REPQKJOD8/JAwktklD+c+oov0it7S6ggM2Kdi7Zfb/9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqLvIf+a; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712316950; x=1743852950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K7i60+sSZKMcg+5XCR700KMaSBu51hz4EyNyn5CxZG4=;
  b=iqLvIf+adyLmU1aT50jqHc+4Rp8F4PovfGnwaV0TIu44TeY4JIWMI2e7
   8E9H0iP64SrD7PDJ9FY0rlA+szNxeXsWFpbwTbo4Btm7oxZG94gP+5g2G
   lv/0KfOCaLpEikmwgGMKaDmTa07MIuEN+LQOKaK4K9UDP8IraqqP9GW1w
   Ry+SSsD4u4eRkj5BU1h3fA/3BR/rHouoX+yKzTRRSHCEUvcKDD7HPi3JA
   ReyMkGdoE/EzXzFoX1RxMcAnyjwBUhHgnGl3yu2mvo8gFMK6ZuaQZfFzG
   JGxpl47RSzqbD54tlO6ePyJkVlqhVwwzlRUFo63SaIXdGnryHVgx48iA/
   w==;
X-CSE-ConnectionGUID: Rn22bozsQsetHIyfnkyo1A==
X-CSE-MsgGUID: VivPvDQETlWmif3ogkmsuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7489773"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7489773"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 04:35:49 -0700
X-CSE-ConnectionGUID: RimbYi2GQG6jWw/a34KdQg==
X-CSE-MsgGUID: EXGqfF/sS8OYTSgEDilWUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="42303288"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 05 Apr 2024 04:35:42 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rshrA-0002DC-1T;
	Fri, 05 Apr 2024 11:35:40 +0000
Date: Fri, 5 Apr 2024 19:34:20 +0800
From: kernel test robot <lkp@intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, rafael@kernel.org, peterz@infradead.org,
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
Message-ID: <202404051912.7Boy0XDE-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on efi/next]
[also build test ERROR on linus/master v6.9-rc2 next-20240405]
[cannot apply to tip/x86/core tip/master tip/x86/mm tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ashish-Kalra/efi-x86-skip-efi_arch_mem_reserve-in-case-of-kexec/20240405-071346
base:   https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git next
patch link:    https://lore.kernel.org/r/41db1ebbe58fb082dbe848f1c666ed23e83f1752.1712270976.git.ashish.kalra%40amd.com
patch subject: [PATCH v3 4/4] x86/snp: Convert shared memory back to private on kexec
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240405/202404051912.7Boy0XDE-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404051912.7Boy0XDE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404051912.7Boy0XDE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   ld: arch/x86/kernel/head64.o: in function `snp_kexec_unshare_mem':
>> head64.c:(.text+0x110): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/kernel/nmi.o: in function `snp_kexec_unshare_mem':
   nmi.c:(.text+0x820): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/kernel/probe_roms.o: in function `snp_kexec_unshare_mem':
   probe_roms.c:(.text+0x370): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/kernel/cpu/common.o: in function `snp_kexec_unshare_mem':
   common.c:(.text+0x530): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/kernel/cpu/amd.o: in function `snp_kexec_unshare_mem':
   amd.c:(.text+0x12b0): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/kernel/smpboot.o: in function `snp_kexec_unshare_mem':
   smpboot.c:(.text+0xfa0): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/kernel/crash.o: in function `snp_kexec_unshare_mem':
   crash.c:(.text+0xa0): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/mm/fault.o: in function `snp_kexec_unshare_mem':
   fault.c:(.text+0x1ce0): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/mm/extable.o: in function `snp_kexec_unshare_mem':
   extable.c:(.text+0x330): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: arch/x86/platform/efi/efi_64.o: in function `snp_kexec_unshare_mem':
   efi_64.c:(.text+0x160): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
   ld: drivers/iommu/amd/init.o: in function `snp_kexec_unshare_mem':
   init.c:(.text+0x15e0): multiple definition of `snp_kexec_unshare_mem'; arch/x86/realmode/init.o:init.c:(.text+0x10): first defined here
--
   In file included from arch/x86/realmode/init.c:12:
>> arch/x86/include/asm/sev.h:265:6: warning: no previous prototype for 'snp_kexec_unshare_mem' [-Wmissing-prototypes]
     265 | void snp_kexec_unshare_mem(void) {}
         |      ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/sev.h:266:13: warning: 'snp_kexec_stop_conversion' defined but not used [-Wunused-function]
     266 | static void snp_kexec_stop_conversion(bool crash) {}
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

