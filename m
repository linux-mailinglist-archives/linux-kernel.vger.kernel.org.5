Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2828280B84E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 02:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjLJBUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 20:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLJBUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 20:20:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BD4D0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 17:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702171215; x=1733707215;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aGvzfT9spUsqBH0TtiFd9nyLofG3wdVzD2aGdzuxnfc=;
  b=iKZSPJmn7LW5hOzbDfWZM9tNmtLWUVn6NNaQTKQSwQURU0L29/TTattD
   8IMYvo0LcRcYruL07vrLGg+KO6kdW6LzR8Iy980W7GpVYvXcHc1fRQErs
   /djFeURczVYPn4I8PfDpipRTj+43x2r4AbPnoXiQkPpPY8WU1julm5CJb
   eeOX66vj4dgIdqhRT6fMpT9hxUiG3AP0Zy+kXFVWmx7N0Wpx10LRKqyoG
   pJJkJXVaD4qQRjDFWbv9chz+/iDuB6SD9+0BNC2hV8STn+/Tk4d8aIpWq
   1Mlj9K4a/DsdAoczCgXOpmgRrYxbhFVdGHZU2swlYgERZY5ZTETjS5FAH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480724282"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="480724282"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 17:20:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="890612241"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="890612241"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 09 Dec 2023 17:20:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC8UN-000GDp-2E;
        Sun, 10 Dec 2023 01:20:11 +0000
Date:   Sun, 10 Dec 2023 09:19:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: arch/alpha/kernel/io.c:425:46: sparse: sparse: cast removes address
 space '__iomem' of expression
Message-ID: <202312100904.XepiU7RJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21b73ffcc62ab772bc06e3e90bd87eff5e9e8ed4
commit: d15155824c5014803d91b829736d249c500bdda6 linux/compiler.h: Split into compiler.h and compiler_types.h
date:   6 years ago
config: alpha-randconfig-r113-20231116 (https://download.01.org/0day-ci/archive/20231210/202312100904.XepiU7RJ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231210/202312100904.XepiU7RJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100904.XepiU7RJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/alpha/kernel/io.c:620:14: sparse: sparse: multiple definitions for function 'ioport_map'
   arch/alpha/kernel/io.c: note: in included file:
   arch/alpha/include/asm/io.h:276:28: sparse:  the previous one is here
   arch/alpha/kernel/io.c:625:6: sparse: sparse: multiple definitions for function 'ioport_unmap'
   arch/alpha/include/asm/io.h:281:20: sparse:  the previous one is here
>> arch/alpha/kernel/io.c:425:46: sparse: sparse: cast removes address space '__iomem' of expression
   arch/alpha/kernel/io.c:436:46: sparse: sparse: cast removes address space '__iomem' of expression
   arch/alpha/kernel/io.c:447:46: sparse: sparse: cast removes address space '__iomem' of expression
   arch/alpha/kernel/io.c:480:29: sparse: sparse: cast removes address space '__iomem' of expression
   arch/alpha/kernel/io.c:491:29: sparse: sparse: cast removes address space '__iomem' of expression
   arch/alpha/kernel/io.c:502:29: sparse: sparse: cast removes address space '__iomem' of expression
   arch/alpha/kernel/io.c:531:28: sparse: sparse: cast removes address space '__iomem' of expression
   arch/alpha/kernel/io.c:538:29: sparse: sparse: cast removes address space '__iomem' of expression
   arch/alpha/kernel/io.c:545:29: sparse: sparse: cast removes address space '__iomem' of expression
   In file included from include/linux/workqueue.h:8,
                    from include/linux/srcu.h:34,
                    from include/linux/notifier.h:15,
                    from include/linux/memory_hotplug.h:6,
                    from include/linux/mmzone.h:779,
                    from include/linux/gfp.h:5,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:22,
                    from include/linux/module.h:13,
                    from arch/alpha/kernel/io.c:8:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:178:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     178 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                              ^
   include/linux/timer.h:143:39: note: in definition of macro '__setup_timer'
     143 |                 (_timer)->function = (_fn);                             32-      |                                       ^~~
   arch/alpha/kernel/io.c: At top level:
   arch/alpha/kernel/io.c:590:1: warning: no previous prototype for 'scr_memcpyw' [-Wmissing-prototypes]
     590 | scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
         | ^~~~~~~~~~~

vim +/__iomem +425 arch/alpha/kernel/io.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  414  
^1da177e4c3f41 Linus Torvalds 2005-04-16  415  
^1da177e4c3f41 Linus Torvalds 2005-04-16  416  /*
^1da177e4c3f41 Linus Torvalds 2005-04-16  417   * Copy data from IO memory space to "real" memory space.
^1da177e4c3f41 Linus Torvalds 2005-04-16  418   * This needs to be optimized.
^1da177e4c3f41 Linus Torvalds 2005-04-16  419   */
^1da177e4c3f41 Linus Torvalds 2005-04-16  420  void memcpy_fromio(void *to, const volatile void __iomem *from, long count)
^1da177e4c3f41 Linus Torvalds 2005-04-16  421  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  422  	/* Optimize co-aligned transfers.  Everything else gets handled
^1da177e4c3f41 Linus Torvalds 2005-04-16  423  	   a byte at a time. */
^1da177e4c3f41 Linus Torvalds 2005-04-16  424  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @425  	if (count >= 8 && ((u64)to & 7) == ((u64)from & 7)) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  426  		count -= 8;
^1da177e4c3f41 Linus Torvalds 2005-04-16  427  		do {
^1da177e4c3f41 Linus Torvalds 2005-04-16  428  			*(u64 *)to = __raw_readq(from);
^1da177e4c3f41 Linus Torvalds 2005-04-16  429  			count -= 8;
^1da177e4c3f41 Linus Torvalds 2005-04-16  430  			to += 8;
^1da177e4c3f41 Linus Torvalds 2005-04-16  431  			from += 8;
^1da177e4c3f41 Linus Torvalds 2005-04-16  432  		} while (count >= 0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  433  		count += 8;
^1da177e4c3f41 Linus Torvalds 2005-04-16  434  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  435  
^1da177e4c3f41 Linus Torvalds 2005-04-16  436  	if (count >= 4 && ((u64)to & 3) == ((u64)from & 3)) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  437  		count -= 4;
^1da177e4c3f41 Linus Torvalds 2005-04-16  438  		do {
^1da177e4c3f41 Linus Torvalds 2005-04-16  439  			*(u32 *)to = __raw_readl(from);
^1da177e4c3f41 Linus Torvalds 2005-04-16  440  			count -= 4;
^1da177e4c3f41 Linus Torvalds 2005-04-16  441  			to += 4;
^1da177e4c3f41 Linus Torvalds 2005-04-16  442  			from += 4;
^1da177e4c3f41 Linus Torvalds 2005-04-16  443  		} while (count >= 0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  444  		count += 4;
^1da177e4c3f41 Linus Torvalds 2005-04-16  445  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  446  
^1da177e4c3f41 Linus Torvalds 2005-04-16  447  	if (count >= 2 && ((u64)to & 1) == ((u64)from & 1)) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  448  		count -= 2;
^1da177e4c3f41 Linus Torvalds 2005-04-16  449  		do {
^1da177e4c3f41 Linus Torvalds 2005-04-16  450  			*(u16 *)to = __raw_readw(from);
^1da177e4c3f41 Linus Torvalds 2005-04-16  451  			count -= 2;
^1da177e4c3f41 Linus Torvalds 2005-04-16  452  			to += 2;
^1da177e4c3f41 Linus Torvalds 2005-04-16  453  			from += 2;
^1da177e4c3f41 Linus Torvalds 2005-04-16  454  		} while (count >= 0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  455  		count += 2;
^1da177e4c3f41 Linus Torvalds 2005-04-16  456  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  457  
^1da177e4c3f41 Linus Torvalds 2005-04-16  458  	while (count > 0) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  459  		*(u8 *) to = __raw_readb(from);
^1da177e4c3f41 Linus Torvalds 2005-04-16  460  		count--;
^1da177e4c3f41 Linus Torvalds 2005-04-16  461  		to++;
^1da177e4c3f41 Linus Torvalds 2005-04-16  462  		from++;
^1da177e4c3f41 Linus Torvalds 2005-04-16  463  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  464  	mb();
^1da177e4c3f41 Linus Torvalds 2005-04-16  465  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  466  

:::::: The code at line 425 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
