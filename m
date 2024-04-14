Return-Path: <linux-kernel+bounces-144215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7928A433D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620DE1C208E8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B33134721;
	Sun, 14 Apr 2024 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTCtlugD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5EF134433
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713106416; cv=none; b=Y3iRAQpy91U4jhLUGSi3zTfHJsVTmorQf4Juf3ZL4YZvKw5gp0bdIkSgknZldV/asF52ONySAFPRpVNbyLqoKZXvZokzxGNMWxAc9enwct8GPXOVtpLxah9hOyArHWBTUAFJOpuJgcUdHYVws1ZhyR14x7fQyvOBC6S6iRd3mC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713106416; c=relaxed/simple;
	bh=dc2BRQbVC9BZmatk9BsweMIc/fK3bYIdjkKFh7Vd9NM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FZvYdcf9f8sw1COgVJy3scO2NoLU1LRRv2/8dgusmu+zFaJImOFppYwE2Qetr4MfrKccTpaQXsE6EXorptklWT2CiS0PKFpnzjcT9PutJbDXzLuaqf+d6jk5PnyncAJYA7Q1Rs55xCXPJ4Fy0c839byyjyd36rl04RAlETMFROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTCtlugD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713106414; x=1744642414;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dc2BRQbVC9BZmatk9BsweMIc/fK3bYIdjkKFh7Vd9NM=;
  b=OTCtlugDT8/TsH8Stg+sB8i+WbOTtENziCLZqkWczTDGk+MSZljpaW14
   DkaXoc6UTbwbY3GjqyyewCClVgOlCOX9s6av5dBmAKv/eKSLt/eVa31HD
   ah/A186Ey9YtSbpYpGDvm0CMVF26cKMwBKGNSf5671phrsHlZHiS0GNKB
   OrcOlfB5dxlDZVSTzY/Bmr1xPkGRxuEhr8nGmTWeeUm4lT5oX6lVvIVI0
   Lw27y2W04Gcnjp11IFuX6jkQvmZsEZI7nsrrHjFumb3i/JNxs7gP7R2EM
   sjRi8t+um+guPDGkKNIZVy736ylT2ayWYRwuKtpLfX7XGF5FjINBU2oMw
   w==;
X-CSE-ConnectionGUID: Rv90J9/nRaKPkYyybDVssA==
X-CSE-MsgGUID: 1b401epqQTyKcF09J+znxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11043"; a="12344182"
X-IronPort-AV: E=Sophos;i="6.07,201,1708416000"; 
   d="scan'208";a="12344182"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 07:53:33 -0700
X-CSE-ConnectionGUID: NXV/s47/QuiDGSJXbhJp3Q==
X-CSE-MsgGUID: eIRfE6e3RC2T8bEKx7SerQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,201,1708416000"; 
   d="scan'208";a="22100673"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 14 Apr 2024 07:53:32 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rw1EW-0003dk-2j;
	Sun, 14 Apr 2024 14:53:28 +0000
Date: Sun, 14 Apr 2024 22:52:58 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: arch/alpha/include/asm/page.h:9:25: error: 'CONFIG_PAGE_SHIFT'
 undeclared; did you mean 'CONFIG_HAVE_PCI'?
Message-ID: <202404142258.3CWV3f05-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7efd0a74039fb6b584be2cb91c1d0ef0bd796ee1
commit: 5394f1e9b687bcf26595cabf83483e568676128d arch: define CONFIG_PAGE_SIZE_*KB on all architectures
date:   6 weeks ago
config: alpha-randconfig-r016-20220816 (https://download.01.org/0day-ci/archive/20240414/202404142258.3CWV3f05-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240414/202404142258.3CWV3f05-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404142258.3CWV3f05-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/thread_info.h:60,
                    from include/asm-generic/current.h:6,
                    from ./arch/alpha/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/alpha/kernel/asm-offsets.c:10:
   arch/alpha/include/asm/thread_info.h:43: warning: "current_thread_info" redefined
      43 | #define current_thread_info()  __current_thread_info
         | 
   include/linux/thread_info.h:24: note: this is the location of the previous definition
      24 | #define current_thread_info() ((struct thread_info *)current)
         | 
   In file included from include/linux/shm.h:6,
                    from include/linux/sched.h:23:
   include/asm-generic/getorder.h: In function 'get_order':
>> arch/alpha/include/asm/page.h:9:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_HAVE_PCI'?
       9 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/asm-generic/getorder.h:33:48: note: in expansion of macro 'PAGE_SHIFT'
      33 |                         return BITS_PER_LONG - PAGE_SHIFT;
         |                                                ^~~~~~~~~~
   arch/alpha/include/asm/page.h:9:25: note: each undeclared identifier is reported only once for each function it appears in
       9 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/asm-generic/getorder.h:33:48: note: in expansion of macro 'PAGE_SHIFT'
      33 |                         return BITS_PER_LONG - PAGE_SHIFT;
         |                                                ^~~~~~~~~~
   In file included from include/linux/sched.h:38:
   include/linux/mm_types_task.h: At top level:
   include/linux/mm_types_task.h:16:10: fatal error: asm/tlbbatch.h: No such file or directory
      16 | #include <asm/tlbbatch.h>
         |          ^~~~~~~~~~~~~~~~
   compilation terminated.
   make[3]: *** [scripts/Makefile.build:116: arch/alpha/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1199: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +9 arch/alpha/include/asm/page.h

     7	
     8	/* PAGE_SHIFT determines the page size */
   > 9	#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
    10	#define PAGE_SIZE	(_AC(1,UL) << PAGE_SHIFT)
    11	#define PAGE_MASK	(~(PAGE_SIZE-1))
    12	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

