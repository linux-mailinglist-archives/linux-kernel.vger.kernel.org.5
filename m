Return-Path: <linux-kernel+bounces-1958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7A1815657
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F81F25895
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F91440F;
	Sat, 16 Dec 2023 02:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWgAyz3F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95A17E8
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702693380; x=1734229380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2kCa92XAYxWzEh96fiCPzEeGN5kYGI03vKtWt214LVc=;
  b=dWgAyz3FxB4qctDURYGVLmlZV1feCqTPz9NfGNkdMmpYpH8zPaY8MyD5
   5JB2wjnr7WY60F3r9zkdRzgHIuCURXmvBjR4jYbsVN1H32acRGwKcbG5o
   pSK0QTxD4g6xHAJAXcSi0koAi8bMtOlfb0873EQiORK6o2QcIPwiqwgg9
   zhZ0yrRSYyq2MhwZZ2JGRXj52GxEgFjydVSJn6kJyR47Kmf1ZsNu6Wf1d
   0WQS/sLlw3y7lWGAEQimhpbhUpszbPb1x8rpmR9VSuMrCgU/r45F8qrL4
   KnyP/KLGT2EREhufsPCtfY8xP4LvfEBwF3i856y2iiYnCS0F5+FQikTyY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="8773855"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="8773855"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 18:22:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="774953870"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="774953870"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Dec 2023 18:22:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEKKJ-00013G-2q;
	Sat, 16 Dec 2023 02:22:51 +0000
Date: Sat, 16 Dec 2023 10:21:52 +0800
From: kernel test robot <lkp@intel.com>
To: Maksim Davydov <davydov-max@yandex-team.ru>,
	linux-kernel@vger.kernel.org, x86@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davydov-max@yandex-team.ru, den-plotnikov@yandex-team.ru,
	tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: Re: [PATCH] x86/split_lock: add split lock counter
Message-ID: <202312161022.Qq2mFAa2-lkp@intel.com>
References: <20231215140113.57173-1-davydov-max@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215140113.57173-1-davydov-max@yandex-team.ru>

Hi Maksim,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on tip/master tip/sched/core linus/master tip/auto-latest v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maksim-Davydov/x86-split_lock-add-split-lock-counter/20231215-220639
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20231215140113.57173-1-davydov-max%40yandex-team.ru
patch subject: [PATCH] x86/split_lock: add split lock counter
config: hexagon-allnoconfig (https://download.01.org/0day-ci/archive/20231216/202312161022.Qq2mFAa2-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161022.Qq2mFAa2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161022.Qq2mFAa2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/proc/base.c:68:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from fs/proc/base.c:68:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from fs/proc/base.c:68:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> fs/proc/base.c:101:10: fatal error: 'asm/cpu.h' file not found
     101 | #include <asm/cpu.h>
         |          ^~~~~~~~~~~
   6 warnings and 1 error generated.


vim +101 fs/proc/base.c

    52	
    53	#include <linux/errno.h>
    54	#include <linux/time.h>
    55	#include <linux/proc_fs.h>
    56	#include <linux/stat.h>
    57	#include <linux/task_io_accounting_ops.h>
    58	#include <linux/init.h>
    59	#include <linux/capability.h>
    60	#include <linux/file.h>
    61	#include <linux/fdtable.h>
    62	#include <linux/generic-radix-tree.h>
    63	#include <linux/string.h>
    64	#include <linux/seq_file.h>
    65	#include <linux/namei.h>
    66	#include <linux/mnt_namespace.h>
    67	#include <linux/mm.h>
    68	#include <linux/swap.h>
    69	#include <linux/rcupdate.h>
    70	#include <linux/kallsyms.h>
    71	#include <linux/stacktrace.h>
    72	#include <linux/resource.h>
    73	#include <linux/module.h>
    74	#include <linux/mount.h>
    75	#include <linux/security.h>
    76	#include <linux/ptrace.h>
    77	#include <linux/printk.h>
    78	#include <linux/cache.h>
    79	#include <linux/cgroup.h>
    80	#include <linux/cpuset.h>
    81	#include <linux/audit.h>
    82	#include <linux/poll.h>
    83	#include <linux/nsproxy.h>
    84	#include <linux/oom.h>
    85	#include <linux/elf.h>
    86	#include <linux/pid_namespace.h>
    87	#include <linux/user_namespace.h>
    88	#include <linux/fs_struct.h>
    89	#include <linux/slab.h>
    90	#include <linux/sched/autogroup.h>
    91	#include <linux/sched/mm.h>
    92	#include <linux/sched/coredump.h>
    93	#include <linux/sched/debug.h>
    94	#include <linux/sched/stat.h>
    95	#include <linux/posix-timers.h>
    96	#include <linux/time_namespace.h>
    97	#include <linux/resctrl.h>
    98	#include <linux/cn_proc.h>
    99	#include <linux/ksm.h>
   100	#include <trace/events/oom.h>
 > 101	#include <asm/cpu.h>
   102	#include "internal.h"
   103	#include "fd.h"
   104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

