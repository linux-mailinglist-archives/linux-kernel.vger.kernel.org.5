Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EC27FB997
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbjK1LpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbjK1LpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:45:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426A6D62;
        Tue, 28 Nov 2023 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701171918; x=1732707918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7qYyCP8MhKknRBAyUu6IhgiQV29YDWwg8zFyW7waXmY=;
  b=XqjEpgkcfCC/B82th3XBoW0FhUG10EVmqnsFPzZnbVmZtmKEix/Jzzia
   iL3y24NGDvo8J3q6L+56BFEoTKr3L2M1Q0K2wA4uL+t+XcaGy/3ViOKZo
   kfxrat3e9WWWmSCJZnoUZzfIEFz4iOSP7KREeFp2ZUWzKjASIdJa1R/3C
   h2/ZL4VXTmPGs6WNBTTTElSnsrTaxM7GJXi0X+QiuqU+kmY22NkmIHuCE
   /SpIjSOQINYKBwcvoYs+bXxCJaFR/fsgckIYXA/ZOcATY+YJqHDck9IlW
   dqpNfPq4JTl17Zq/YD1i8W0hm6Xm15bhm9I3Eo7De4+TIMOvoAeIW2MPf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="391777739"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="391777739"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 03:45:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="772281741"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="772281741"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Nov 2023 03:45:15 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r7wWe-0007WJ-3D;
        Tue, 28 Nov 2023 11:45:13 +0000
Date:   Tue, 28 Nov 2023 19:45:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
        reibax@gmail.com, davem@davemloft.net, rrameshbabu@nvidia.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maheshb@google.com, maimon.sagi@gmail.com
Subject: Re: [PATCH v2] posix-timers: add multi_clock_gettime system call
Message-ID: <202311281817.puU0ujYG-lkp@intel.com>
References: <20231127153901.6399-1-maimon.sagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127153901.6399-1-maimon.sagi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on tip/timers/core linus/master v6.7-rc3]
[cannot apply to tip/x86/asm next-20231128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Maimon/posix-timers-add-multi_clock_gettime-system-call/20231128-000215
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20231127153901.6399-1-maimon.sagi%40gmail.com
patch subject: [PATCH v2] posix-timers: add multi_clock_gettime system call
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20231128/202311281817.puU0ujYG-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231128/202311281817.puU0ujYG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311281817.puU0ujYG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/time/posix-timers.c:13:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from kernel/time/posix-timers.c:13:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/time/posix-timers.c:13:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> kernel/time/posix-timers.c:1429:1: warning: stack frame size (2040) exceeds limit (1024) in '__se_sys_multi_clock_gettime' [-Wframe-larger-than]
    1429 | SYSCALL_DEFINE1(multi_clock_gettime, struct __ptp_multi_clock_get __user *, ptp_multi_clk_get)
         | ^
   include/linux/syscalls.h:219:36: note: expanded from macro 'SYSCALL_DEFINE1'
     219 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:230:2: note: expanded from macro 'SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:249:18: note: expanded from macro '__SYSCALL_DEFINEx'
     249 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
         |                         ^
   <scratch space>:122:1: note: expanded from here
     122 | __se_sys_multi_clock_gettime
         | ^
>> kernel/time/posix-timers.c:1460:1: warning: stack frame size (2040) exceeds limit (1024) in '__se_sys_multi_clock_gettime32' [-Wframe-larger-than]
    1460 | SYSCALL_DEFINE1(multi_clock_gettime32, struct __ptp_multi_clock_get32 __user *, ptp_multi_clk_get)
         | ^
   include/linux/syscalls.h:219:36: note: expanded from macro 'SYSCALL_DEFINE1'
     219 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:230:2: note: expanded from macro 'SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:249:18: note: expanded from macro '__SYSCALL_DEFINEx'
     249 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
         |                         ^
   <scratch space>:147:1: note: expanded from here
     147 | __se_sys_multi_clock_gettime32
         | ^
   14 warnings generated.


vim +/__se_sys_multi_clock_gettime +1429 kernel/time/posix-timers.c

  1428	
> 1429	SYSCALL_DEFINE1(multi_clock_gettime, struct __ptp_multi_clock_get __user *, ptp_multi_clk_get)
  1430	{
  1431		const struct k_clock *kc;
  1432		struct timespec64 kernel_tp;
  1433		struct __ptp_multi_clock_get multi_clk_get;
  1434		int error;
  1435		unsigned int i, j;
  1436	
  1437		if (copy_from_user(&multi_clk_get, ptp_multi_clk_get, sizeof(multi_clk_get)))
  1438			return -EFAULT;
  1439	
  1440		if (multi_clk_get.n_samples > MULTI_PTP_MAX_SAMPLES)
  1441			return -EINVAL;
  1442		if (multi_clk_get.n_clocks > MULTI_PTP_MAX_CLOCKS)
  1443			return -EINVAL;
  1444	
  1445		for (j = 0; j < multi_clk_get.n_samples; j++) {
  1446			for (i = 0; i < multi_clk_get.n_clocks; i++) {
  1447				kc = clockid_to_kclock(multi_clk_get.clkid_arr[i]);
  1448				if (!kc)
  1449					return -EINVAL;
  1450				error = kc->clock_get_timespec(multi_clk_get.clkid_arr[i], &kernel_tp);
  1451				if (!error && put_timespec64(&kernel_tp, (struct __kernel_timespec __user *)
  1452							     &ptp_multi_clk_get->ts[j][i]))
  1453					error = -EFAULT;
  1454			}
  1455		}
  1456	
  1457		return error;
  1458	}
  1459	
> 1460	SYSCALL_DEFINE1(multi_clock_gettime32, struct __ptp_multi_clock_get32 __user *, ptp_multi_clk_get)
  1461	{
  1462		const struct k_clock *kc;
  1463		struct timespec64 kernel_tp;
  1464		struct __ptp_multi_clock_get multi_clk_get;
  1465		int error;
  1466		unsigned int i, j;
  1467	
  1468		if (copy_from_user(&multi_clk_get, ptp_multi_clk_get, sizeof(multi_clk_get)))
  1469			return -EFAULT;
  1470	
  1471		if (multi_clk_get.n_samples > MULTI_PTP_MAX_SAMPLES)
  1472			return -EINVAL;
  1473		if (multi_clk_get.n_clocks > MULTI_PTP_MAX_CLOCKS)
  1474			return -EINVAL;
  1475	
  1476		for (j = 0; j < multi_clk_get.n_samples; j++) {
  1477			for (i = 0; i < multi_clk_get.n_clocks; i++) {
  1478				kc = clockid_to_kclock(multi_clk_get.clkid_arr[i]);
  1479				if (!kc)
  1480					return -EINVAL;
  1481				error = kc->clock_get_timespec(multi_clk_get.clkid_arr[i], &kernel_tp);
  1482				if (!error && put_old_timespec32(&kernel_tp, (struct old_timespec32 __user *)
  1483								&ptp_multi_clk_get->ts[j][i]))
  1484					error = -EFAULT;
  1485			}
  1486		}
  1487	
  1488		return error;
  1489	}
  1490	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
