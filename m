Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3980880B54F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 17:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjLIQrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 11:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 11:47:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BBC10E6;
        Sat,  9 Dec 2023 08:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702140474; x=1733676474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9OrBcNRkexSFp7JpzEwrwcmu1QSQkInC3RedZZXvKF0=;
  b=ghP5WBioZBAVMi+R0lXzHl3v6WJigQygAK1LqAbszuKAde/+fz0ny75N
   JVwF1wc8QpmHIlJJflP5W8COkdlcl5vElmnonAXi4UNkgx6/TogsUfYzY
   h2/u/oClYaV1I4E4TmaUlXiKIq7a+39p40hYvdULexw7kHI5thUt7zkip
   MNDLho2Y1vWkeODk9kyaixTG3izdZF4VevzPU5eQGJzrCGaXYW8tYIIFq
   RW/avu0XRVZou18BYMBjTCl9ULfdtVU0BzjD1kGM2hdHmiLVnK+BEFNV/
   60dd2PemblHYCfutUrF3Q1DsoxUuuNmzw6HJd1l2Q5RNr1OElsvYsuIfg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480711480"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="480711480"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 08:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="838462061"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="838462061"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2023 08:47:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC0US-000Fdf-2R;
        Sat, 09 Dec 2023 16:47:44 +0000
Date:   Sun, 10 Dec 2023 00:46:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        mhocko@kernel.org, tj@kernel.org, ying.huang@intel.com,
        gregory.price@memverge.com, corbet@lwn.net, rakie.kim@sk.com,
        hyeongtak.ji@sk.com, honggyu.kim@sk.com, vtavarespetr@micron.com,
        peterz@infradead.org, jgroves@micron.com, ravis.opensrc@micron.com,
        sthanneeru@micron.com, emirakhur@micron.com, Hasan.Maruf@amd.com
Subject: Re: [PATCH v2 08/11] mm/mempolicy: add set_mempolicy2 syscall
Message-ID: <202312100003.aUR6uBvr-lkp@intel.com>
References: <20231209065931.3458-9-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209065931.3458-9-gregory.price@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on deller-parisc/for-next powerpc/next powerpc/fixes s390/features jcmvbkbc-xtensa/xtensa-for-next arnd-asm-generic/master linus/master v6.7-rc4]
[cannot apply to tip/x86/asm geert-m68k/for-next geert-m68k/for-linus next-20231208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-Price/mm-mempolicy-implement-the-sysfs-based-weighted_interleave-interface/20231209-150314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231209065931.3458-9-gregory.price%40memverge.com
patch subject: [PATCH v2 08/11] mm/mempolicy: add set_mempolicy2 syscall
config: arc-alldefconfig (https://download.01.org/0day-ci/archive/20231210/202312100003.aUR6uBvr-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312100003.aUR6uBvr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100003.aUR6uBvr-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from init/main.c:21:
>> include/linux/syscalls.h:825:43: warning: 'struct mpol_args' declared inside parameter list will not be visible outside of this definition or declaration
     825 | asmlinkage long sys_set_mempolicy2(struct mpol_args *args, size_t size,
         |                                           ^~~~~~~~~
--
   In file included from arch/arc/kernel/sys.c:3:
>> include/linux/syscalls.h:825:43: warning: 'struct mpol_args' declared inside parameter list will not be visible outside of this definition or declaration
     825 | asmlinkage long sys_set_mempolicy2(struct mpol_args *args, size_t size,
         |                                           ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
      29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
         |                                     ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:34:1: note: in expansion of macro '__SC_COMP'
      34 | __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[0]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
      29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
         |                                     ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:34:1: note: in expansion of macro '__SC_COMP'
      34 | __SC_COMP(__NR_io_setup, sys_io_setup, compat_sys_io_setup)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:36:1: note: in expansion of macro '__SYSCALL'
      36 | __SYSCALL(__NR_io_destroy, sys_io_destroy)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[1]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:36:1: note: in expansion of macro '__SYSCALL'
      36 | __SYSCALL(__NR_io_destroy, sys_io_destroy)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
      29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
         |                                     ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:38:1: note: in expansion of macro '__SC_COMP'
      38 | __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[2]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:29:37: note: in expansion of macro '__SYSCALL'
      29 | #define __SC_COMP(_nr, _sys, _comp) __SYSCALL(_nr, _sys)
         |                                     ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:38:1: note: in expansion of macro '__SC_COMP'
      38 | __SC_COMP(__NR_io_submit, sys_io_submit, compat_sys_io_submit)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:40:1: note: in expansion of macro '__SYSCALL'
      40 | __SYSCALL(__NR_io_cancel, sys_io_cancel)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[3]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:40:1: note: in expansion of macro '__SYSCALL'
      40 | __SYSCALL(__NR_io_cancel, sys_io_cancel)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:20:34: note: in expansion of macro '__SYSCALL'
      20 | #define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _32)
         |                                  ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:44:1: note: in expansion of macro '__SC_3264'
      44 | __SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[4]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:20:34: note: in expansion of macro '__SYSCALL'
      20 | #define __SC_3264(_nr, _32, _64) __SYSCALL(_nr, _32)
         |                                  ^~~~~~~~~
   include/uapi/asm-generic/unistd.h:44:1: note: in expansion of macro '__SC_3264'
      44 | __SC_3264(__NR_io_getevents, sys_io_getevents_time32, sys_io_getevents)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:48:1: note: in expansion of macro '__SYSCALL'
      48 | __SYSCALL(__NR_setxattr, sys_setxattr)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[5]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:48:1: note: in expansion of macro '__SYSCALL'
      48 | __SYSCALL(__NR_setxattr, sys_setxattr)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: warning: initialized field overwritten [-Woverride-init]
      13 | #define __SYSCALL(nr, call) [nr] = (call),
         |                                    ^
   include/uapi/asm-generic/unistd.h:50:1: note: in expansion of macro '__SYSCALL'
      50 | __SYSCALL(__NR_lsetxattr, sys_lsetxattr)
         | ^~~~~~~~~
   arch/arc/kernel/sys.c:13:36: note: (near initialization for 'sys_call_table[6]')
      13 | #define __SYSCALL(nr, call) [nr] = (call),
--
   In file included from kernel/time/hrtimer.c:30:
>> include/linux/syscalls.h:825:43: warning: 'struct mpol_args' declared inside parameter list will not be visible outside of this definition or declaration
     825 | asmlinkage long sys_set_mempolicy2(struct mpol_args *args, size_t size,
         |                                           ^~~~~~~~~
   kernel/time/hrtimer.c:120:35: warning: initialized field overwritten [-Woverride-init]
     120 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:120:35: note: (near initialization for 'hrtimer_clock_to_base_table[0]')
   kernel/time/hrtimer.c:121:35: warning: initialized field overwritten [-Woverride-init]
     121 |         [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:35: note: (near initialization for 'hrtimer_clock_to_base_table[1]')
   kernel/time/hrtimer.c:122:35: warning: initialized field overwritten [-Woverride-init]
     122 |         [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:35: note: (near initialization for 'hrtimer_clock_to_base_table[7]')
   kernel/time/hrtimer.c:123:35: warning: initialized field overwritten [-Woverride-init]
     123 |         [CLOCK_TAI]             = HRTIMER_BASE_TAI,
         |                                   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:35: note: (near initialization for 'hrtimer_clock_to_base_table[11]')
   kernel/time/hrtimer.c: In function '__run_hrtimer':
   kernel/time/hrtimer.c:1651:14: warning: variable 'expires_in_hardirq' set but not used [-Wunused-but-set-variable]
    1651 |         bool expires_in_hardirq;
         |              ^~~~~~~~~~~~~~~~~~
--
>> arc-elf-ld: arch/arc/kernel/sys.o:(.data+0x724): undefined reference to `sys_set_mempolicy2'
>> arc-elf-ld: arch/arc/kernel/sys.o:(.data+0x724): undefined reference to `sys_set_mempolicy2'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
