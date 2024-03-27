Return-Path: <linux-kernel+bounces-120202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A825688D45E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D551F3B497
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F28208BB;
	Wed, 27 Mar 2024 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioBubraX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA132033A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505116; cv=none; b=oxSD19C4LiSaJcBwR4heOZvSNoF/eMYCgyP00EBO9YYn2XXIR3/ooZ+cVx6Vc3wKTX7ysC5uIuPNMl9s9J2KaqcEPcEuVzsC/NLIrvU5yjIzkJC74rxmQcvjrun6fzaUsdkdX+C/WmNhsCYAM6a6CuLLoGe6oOxyEpSNc1nnE84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505116; c=relaxed/simple;
	bh=KNmTlJTRGy6Bojm7LfbS2Dlqybz3qxOHveKiVBO4lDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JiNNf0bLDHmYz4u+9Hc49LGXQJh4Hzjt4YzBrvSef+t47bU810fzoBnfsR2JmsnF1ijnkdysJ9OzORhyeWTNq5zAX/GS3jRirhwfmaXXpqmhl3IOsRrdV1WGxhj8Oa00jDzQZ/OhpOOIn2/77Do8prNFYeCkOjADQDcVTv5VFL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ioBubraX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711505115; x=1743041115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KNmTlJTRGy6Bojm7LfbS2Dlqybz3qxOHveKiVBO4lDA=;
  b=ioBubraXYpthJKrHlxBjpAHQUuZYlFocartKlaslOPKGrF4ShY1VsDBL
   ufl+Djis+izmY/OVQzd1ZNb4VmjS1ty4RWyNLrSqpRYGQaQ7QbBDfQ5tV
   TSUMwptEJoCaVPI8L3/aZstAEuKWE8JfoFfK3hPa8KCWFJ/ORnIItQnN7
   /4POZtUxD7k4Ru7EMYUSvOFsCm5UQfWFG5UOZyAOG2HXGPIsZGKSwkzWy
   Tp4+Ffcwc3FMmz5a5L/0TPWX2vI8H4z32Xc3i96QcBwK44m81VrJZpUpI
   /YMMl4tBvhADEJoW5kCjkbWZFBpWobgotPFijL/d8PkozdiMF+vlX6je/
   Q==;
X-CSE-ConnectionGUID: AJ7n7UlgTz6O6xqEWfOmmg==
X-CSE-MsgGUID: dJlYVp7WS5y4/UXYM+ExRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="18017529"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="18017529"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 19:05:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="39245072"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Mar 2024 19:05:09 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpIf5-0000do-2S;
	Wed, 27 Mar 2024 02:05:07 +0000
Date: Wed, 27 Mar 2024 10:05:04 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] arm64: mm: Don't remap pgtables for allocate vs
 populate
Message-ID: <202403270906.zFGZ2FXl-lkp@intel.com>
References: <20240326101448.3453626-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326101448.3453626-3-ryan.roberts@arm.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.9-rc1 next-20240326]
[cannot apply to arm64/for-next/core arm-perf/for-next/perf arm/for-next arm/fixes kvmarm/next soc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/arm64-mm-Don-t-remap-pgtables-per-cont-pte-pmd-block/20240326-181754
base:   linus/master
patch link:    https://lore.kernel.org/r/20240326101448.3453626-3-ryan.roberts%40arm.com
patch subject: [PATCH v1 2/3] arm64: mm: Don't remap pgtables for allocate vs populate
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240327/202403270906.zFGZ2FXl-lkp@intel.com/config)
compiler: gcc-12 (Ubuntu 12.3.0-9ubuntu2) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240327/202403270906.zFGZ2FXl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403270906.zFGZ2FXl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/mm.h:29,
                    from include/linux/memcontrol.h:21,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/x86/kernel/asm-offsets.c:14:
>> include/linux/pgtable.h:87:29: error: redefinition of 'p4d_index'
      87 | static inline unsigned long p4d_index(unsigned long address)
         |                             ^~~~~~~~~
   In file included from arch/x86/include/asm/tlbflush.h:16,
                    from arch/x86/include/asm/uaccess.h:17,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:13,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/compat.h:17,
                    from arch/x86/include/asm/ia32.h:7,
                    from arch/x86/include/asm/elf.h:10,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from include/crypto/aria.h:22,
                    from arch/x86/kernel/asm-offsets.c:10:
   arch/x86/include/asm/pgtable.h:1134:29: note: previous definition of 'p4d_index' with type 'long unsigned int(long unsigned int)'
    1134 | static inline unsigned long p4d_index(unsigned long address)
         |                             ^~~~~~~~~
   make[3]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1197: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/p4d_index +87 include/linux/pgtable.h

    85	
    86	#ifndef p4d_index
  > 87	static inline unsigned long p4d_index(unsigned long address)
    88	{
    89		return (address >> P4D_SHIFT) & (PTRS_PER_P4D - 1);
    90	}
    91	#define p4d_index p4d_index
    92	#endif
    93	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

