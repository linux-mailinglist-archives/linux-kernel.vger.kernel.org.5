Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1EB7C75CF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjJLSZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjJLSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:25:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E07CBE;
        Thu, 12 Oct 2023 11:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697135120; x=1728671120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pCoD8VVc4mx2EK9m+93aT7SQ/LlSgOGMWEkCYGHDxz4=;
  b=OooG8IrXxR9ZOr4czkVAKCi9SQJIZhFqwa+cnNSgQMsTGsfPRte/N+5y
   5HRuU96Nogu7EnnCGwTnKV5IW2787u3iP6CuELYxzxBx57/GBF4tPjxyg
   aq4i+K+eRq2dCQ55uyi0PaZ2eSFCe/t5B2PndMVDN+2NUCMoMZWcX/JZC
   +rsNdkrKQEbf8LrL9y+RTVu7jshP3HXL+E3cLRlR+BZrdo/JLLNajTznJ
   Qzuoail405Katym6GP7qKAmnTFn0atvtUFThmthbwQSAjvxaBsbsFZLyE
   mGf0o4N0PJ0RUTXU1hwWQVPGJGUw7Eoy1p45ajZcrZrUdgU0bU8VPsXc+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449202275"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="449202275"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 11:25:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="824713225"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="824713225"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Oct 2023 11:25:18 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qr0N1-0003jZ-2x;
        Thu, 12 Oct 2023 18:25:15 +0000
Date:   Fri, 13 Oct 2023 02:24:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joey Jiao <quic_jiangenj@quicinc.com>,
        linux-modules@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        quic_jiangenj@quicinc.com, Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
Message-ID: <202310130236.lYbPy0lh-lkp@intel.com>
References: <20231011074438.6098-1-quic_jiangenj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011074438.6098-1-quic_jiangenj@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joey,

kernel test robot noticed the following build errors:

[auto build test ERROR on mcgrof/modules-next]
[also build test ERROR on linus/master v6.6-rc5 next-20231012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joey-Jiao/module-Add-CONFIG_MODULE_LOAD_IN_SEQUENCE-option/20231011-154640
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
patch link:    https://lore.kernel.org/r/20231011074438.6098-1-quic_jiangenj%40quicinc.com
patch subject: [PATCH v2] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231013/202310130236.lYbPy0lh-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231013/202310130236.lYbPy0lh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310130236.lYbPy0lh-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/module/main.c:14:
   In file included from include/linux/trace_events.h:9:
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
   In file included from kernel/module/main.c:14:
   In file included from include/linux/trace_events.h:9:
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
   In file included from kernel/module/main.c:14:
   In file included from include/linux/trace_events.h:9:
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
>> kernel/module/main.c:2628:1: error: function definition is not allowed here
    2628 | {
         | ^
   kernel/module/main.c:2637:1: error: function definition is not allowed here
    2637 | {
         | ^
   kernel/module/main.c:2659:1: error: function definition is not allowed here
    2659 | {
         | ^
   kernel/module/main.c:2702:1: error: function definition is not allowed here
    2702 | {
         | ^
   kernel/module/main.c:2723:1: error: function definition is not allowed here
    2723 | {
         | ^
   kernel/module/main.c:2756:1: error: function definition is not allowed here
    2756 | {
         | ^
   kernel/module/main.c:2775:1: error: function definition is not allowed here
    2775 | {
         | ^
   kernel/module/main.c:2794:1: error: function definition is not allowed here
    2794 | {
         | ^
   kernel/module/main.c:2831:1: error: function definition is not allowed here
    2831 | {
         | ^
>> kernel/module/main.c:3039:1: error: function declared in block scope cannot have 'static' storage class
    3039 | SYSCALL_DEFINE3(init_module, void __user *, umod,
         | ^
   include/linux/syscalls.h:221:36: note: expanded from macro 'SYSCALL_DEFINE3'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:230:2: note: expanded from macro 'SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:247:2: note: expanded from macro '__SYSCALL_DEFINEx'
     247 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |         ^
   kernel/module/main.c:3039:1: error: function definition is not allowed here
   include/linux/syscalls.h:221:36: note: expanded from macro 'SYSCALL_DEFINE3'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:230:2: note: expanded from macro 'SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:250:2: note: expanded from macro '__SYSCALL_DEFINEx'
     250 |         {                                                               \
         |         ^
   kernel/module/main.c:3041:1: error: function definition is not allowed here
    3041 | {
         | ^
   kernel/module/main.c:3074:1: error: function definition is not allowed here
    3074 | {
         | ^
   kernel/module/main.c:3105:1: error: function definition is not allowed here
    3105 | {
         | ^
   kernel/module/main.c:3125:1: error: function definition is not allowed here
    3125 | {
         | ^
   kernel/module/main.c:3153:1: error: function definition is not allowed here
    3153 | {
         | ^
   kernel/module/main.c:3170:1: error: function declared in block scope cannot have 'static' storage class
    3170 | SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
         | ^
   include/linux/syscalls.h:221:36: note: expanded from macro 'SYSCALL_DEFINE3'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:230:2: note: expanded from macro 'SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:247:2: note: expanded from macro '__SYSCALL_DEFINEx'
     247 |         static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
         |         ^
   kernel/module/main.c:3170:1: error: function definition is not allowed here
   include/linux/syscalls.h:221:36: note: expanded from macro 'SYSCALL_DEFINE3'
     221 | #define SYSCALL_DEFINE3(name, ...) SYSCALL_DEFINEx(3, _##name, __VA_ARGS__)
         |                                    ^
   include/linux/syscalls.h:230:2: note: expanded from macro 'SYSCALL_DEFINEx'
     230 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^
   include/linux/syscalls.h:250:2: note: expanded from macro '__SYSCALL_DEFINEx'
     250 |         {                                                               \
         |         ^
   kernel/module/main.c:3171:1: error: function definition is not allowed here
    3171 | {
         | ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   12 warnings and 20 errors generated.


vim +2628 kernel/module/main.c

34e1169d996ab1 kernel/module.c Kees Cook 2012-10-16  2626  
34e1169d996ab1 kernel/module.c Kees Cook 2012-10-16  2627  static int may_init_module(void)
34e1169d996ab1 kernel/module.c Kees Cook 2012-10-16 @2628  {
34e1169d996ab1 kernel/module.c Kees Cook 2012-10-16  2629  	if (!capable(CAP_SYS_MODULE) || modules_disabled)
34e1169d996ab1 kernel/module.c Kees Cook 2012-10-16  2630  		return -EPERM;
34e1169d996ab1 kernel/module.c Kees Cook 2012-10-16  2631  
34e1169d996ab1 kernel/module.c Kees Cook 2012-10-16  2632  	return 0;
34e1169d996ab1 kernel/module.c Kees Cook 2012-10-16  2633  }
34e1169d996ab1 kernel/module.c Kees Cook 2012-10-16  2634  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
