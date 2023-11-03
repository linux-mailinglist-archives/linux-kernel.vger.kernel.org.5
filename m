Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDEB7E04D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377853AbjKCOl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjKCOlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:41:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878FED4F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699022478; x=1730558478;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5E/j57dPqBLSAdMRJocP0UlIgIDA8LBzXWYfkIBAHNk=;
  b=hVv4AsNJpJvKEy0HVtjTkBCMcxQnt7PObHfdS2T8lC0os6bay/8vP8Rn
   n3pS5v2qi/M26t9h2vOOvuYLvHwhcRNi1ov0O2uy/GTxWC1C4q4WZpfXR
   mUSdUj4tBbSkc0vMy7Vr0n54QvRMa2bvyUDO85YFNGCPh05G88mZwLt8R
   0TL+IhwT4sIpu9lmqOBoLaeBmgeYWpud4H6tyS1eSfJFZe6kHSQeerPBQ
   vfcm/ZWBrJCu6mSE0CTvpDDsZi/MwajGk4Zkoe/T2RgzDiYSFucab8nPD
   xGCHW8vVKv2FD0iit1zI35sf07MAmgXJTkIPLg3zizy8ieCfPoVfIBeze
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="387844444"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="387844444"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 07:41:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="765260428"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="765260428"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Nov 2023 07:41:16 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyvMI-0002ao-1E;
        Fri, 03 Nov 2023 14:41:14 +0000
Date:   Fri, 3 Nov 2023 22:40:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: arch/alpha/include/asm/core_t2.h:594:22: warning: no previous
 prototype for 't2_iowrite64'
Message-ID: <202311032258.9xJLwa3U-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f6f76a6a29f36d2f3e4510d0bde5046672f6924
commit: e19d4ebc536dadb607fe305fdaf48218d3e32d7c alpha: add full ioread64/iowrite64 implementation
date:   1 year, 1 month ago
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20231103/202311032258.9xJLwa3U-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311032258.9xJLwa3U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311032258.9xJLwa3U-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/alpha/kernel/core_t2.c:15:
   arch/alpha/include/asm/core_t2.h:465:20: warning: no previous prototype for 't2_readb' [-Wmissing-prototypes]
     465 | __EXTERN_INLINE u8 t2_readb(const volatile void __iomem *xaddr)
         |                    ^~~~~~~~
   arch/alpha/include/asm/core_t2.h:476:21: warning: no previous prototype for 't2_readw' [-Wmissing-prototypes]
     476 | __EXTERN_INLINE u16 t2_readw(const volatile void __iomem *xaddr)
         |                     ^~~~~~~~
   arch/alpha/include/asm/core_t2.h:491:21: warning: no previous prototype for 't2_readl' [-Wmissing-prototypes]
     491 | __EXTERN_INLINE u32 t2_readl(const volatile void __iomem *xaddr)
         |                     ^~~~~~~~
   arch/alpha/include/asm/core_t2.h:502:21: warning: no previous prototype for 't2_readq' [-Wmissing-prototypes]
     502 | __EXTERN_INLINE u64 t2_readq(const volatile void __iomem *xaddr)
         |                     ^~~~~~~~
   arch/alpha/include/asm/core_t2.h:515:22: warning: no previous prototype for 't2_writeb' [-Wmissing-prototypes]
     515 | __EXTERN_INLINE void t2_writeb(u8 b, volatile void __iomem *xaddr)
         |                      ^~~~~~~~~
   arch/alpha/include/asm/core_t2.h:526:22: warning: no previous prototype for 't2_writew' [-Wmissing-prototypes]
     526 | __EXTERN_INLINE void t2_writew(u16 b, volatile void __iomem *xaddr)
         |                      ^~~~~~~~~
   arch/alpha/include/asm/core_t2.h:541:22: warning: no previous prototype for 't2_writel' [-Wmissing-prototypes]
     541 | __EXTERN_INLINE void t2_writel(u32 b, volatile void __iomem *xaddr)
         |                      ^~~~~~~~~
   arch/alpha/include/asm/core_t2.h:550:22: warning: no previous prototype for 't2_writeq' [-Wmissing-prototypes]
     550 | __EXTERN_INLINE void t2_writeq(u64 b, volatile void __iomem *xaddr)
         |                      ^~~~~~~~~
   arch/alpha/include/asm/core_t2.h:562:31: warning: no previous prototype for 't2_ioportmap' [-Wmissing-prototypes]
     562 | __EXTERN_INLINE void __iomem *t2_ioportmap(unsigned long addr)
         |                               ^~~~~~~~~~~~
   arch/alpha/include/asm/core_t2.h:567:31: warning: no previous prototype for 't2_ioremap' [-Wmissing-prototypes]
     567 | __EXTERN_INLINE void __iomem *t2_ioremap(unsigned long addr,
         |                               ^~~~~~~~~~
   arch/alpha/include/asm/core_t2.h:573:21: warning: no previous prototype for 't2_is_ioaddr' [-Wmissing-prototypes]
     573 | __EXTERN_INLINE int t2_is_ioaddr(unsigned long addr)
         |                     ^~~~~~~~~~~~
   arch/alpha/include/asm/core_t2.h:578:21: warning: no previous prototype for 't2_is_mmio' [-Wmissing-prototypes]
     578 | __EXTERN_INLINE int t2_is_mmio(const volatile void __iomem *addr)
         |                     ^~~~~~~~~~
   arch/alpha/include/asm/core_t2.h:587:23: warning: no previous prototype for 't2_ioread8' [-Wmissing-prototypes]
     587 | __EXTERN_INLINE u##NS t2_ioread##NS(const void __iomem *xaddr)          \
         |                       ^~~~~~~~~
   arch/alpha/include/asm/core_t2.h:602:1: note: in expansion of macro 'IOPORT'
     602 | IOPORT(b, 8)
         | ^~~~~~
   arch/alpha/include/asm/core_t2.h:594:22: warning: no previous prototype for 't2_iowrite8' [-Wmissing-prototypes]
     594 | __EXTERN_INLINE void t2_iowrite##NS(u##NS b, void __iomem *xaddr)       \
         |                      ^~~~~~~~~~
   arch/alpha/include/asm/core_t2.h:602:1: note: in expansion of macro 'IOPORT'
     602 | IOPORT(b, 8)
         | ^~~~~~
   arch/alpha/include/asm/core_t2.h:587:23: warning: no previous prototype for 't2_ioread16' [-Wmissing-prototypes]
     587 | __EXTERN_INLINE u##NS t2_ioread##NS(const void __iomem *xaddr)          \
         |                       ^~~~~~~~~
   arch/alpha/include/asm/core_t2.h:603:1: note: in expansion of macro 'IOPORT'
     603 | IOPORT(w, 16)
         | ^~~~~~
   arch/alpha/include/asm/core_t2.h:594:22: warning: no previous prototype for 't2_iowrite16' [-Wmissing-prototypes]
     594 | __EXTERN_INLINE void t2_iowrite##NS(u##NS b, void __iomem *xaddr)       \
         |                      ^~~~~~~~~~
   arch/alpha/include/asm/core_t2.h:603:1: note: in expansion of macro 'IOPORT'
     603 | IOPORT(w, 16)
         | ^~~~~~
   arch/alpha/include/asm/core_t2.h:587:23: warning: no previous prototype for 't2_ioread32' [-Wmissing-prototypes]
     587 | __EXTERN_INLINE u##NS t2_ioread##NS(const void __iomem *xaddr)          \
         |                       ^~~~~~~~~
   arch/alpha/include/asm/core_t2.h:604:1: note: in expansion of macro 'IOPORT'
     604 | IOPORT(l, 32)
         | ^~~~~~
   arch/alpha/include/asm/core_t2.h:594:22: warning: no previous prototype for 't2_iowrite32' [-Wmissing-prototypes]
     594 | __EXTERN_INLINE void t2_iowrite##NS(u##NS b, void __iomem *xaddr)       \
         |                      ^~~~~~~~~~
   arch/alpha/include/asm/core_t2.h:604:1: note: in expansion of macro 'IOPORT'
     604 | IOPORT(l, 32)
         | ^~~~~~
   arch/alpha/include/asm/core_t2.h:587:23: warning: no previous prototype for 't2_ioread64' [-Wmissing-prototypes]
     587 | __EXTERN_INLINE u##NS t2_ioread##NS(const void __iomem *xaddr)          \
         |                       ^~~~~~~~~
   arch/alpha/include/asm/core_t2.h:605:1: note: in expansion of macro 'IOPORT'
     605 | IOPORT(q, 64)
         | ^~~~~~
>> arch/alpha/include/asm/core_t2.h:594:22: warning: no previous prototype for 't2_iowrite64' [-Wmissing-prototypes]
     594 | __EXTERN_INLINE void t2_iowrite##NS(u##NS b, void __iomem *xaddr)       \
         |                      ^~~~~~~~~~
   arch/alpha/include/asm/core_t2.h:605:1: note: in expansion of macro 'IOPORT'
     605 | IOPORT(q, 64)
         | ^~~~~~
   In file included from arch/alpha/kernel/core_t2.c:14:
   arch/alpha/include/asm/core_t2.h:614:33: warning: no previous prototype for 't2_iounmap' [-Wmissing-prototypes]
     614 | #define __IO_PREFIX             t2
         |                                 ^~
   arch/alpha/include/asm/io.h:137:25: note: in definition of macro '_IO_CONCAT'
     137 | #define _IO_CONCAT(a,b) a ## _ ## b
         |                         ^
   arch/alpha/include/asm/io_trivial.h:141:22: note: in expansion of macro 'IO_CONCAT'
     141 | __EXTERN_INLINE void IO_CONCAT(__IO_PREFIX,iounmap)(volatile void __iomem *a)
         |                      ^~~~~~~~~
   arch/alpha/include/asm/io_trivial.h:141:32: note: in expansion of macro '__IO_PREFIX'
     141 | __EXTERN_INLINE void IO_CONCAT(__IO_PREFIX,iounmap)(volatile void __iomem *a)
         |                                ^~~~~~~~~~~
--
   In file included from arch/alpha/kernel/sys_jensen.c:12:
   arch/alpha/include/asm/jensen.h:92:22: warning: no previous prototype for 'jensen_set_hae' [-Wmissing-prototypes]
      92 | __EXTERN_INLINE void jensen_set_hae(unsigned long addr)
         |                      ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:115:30: warning: no previous prototype for 'jensen_local_inb' [-Wmissing-prototypes]
     115 | __EXTERN_INLINE unsigned int jensen_local_inb(unsigned long addr)
         |                              ^~~~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:120:22: warning: no previous prototype for 'jensen_local_outb' [-Wmissing-prototypes]
     120 | __EXTERN_INLINE void jensen_local_outb(u8 b, unsigned long addr)
         |                      ^~~~~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:126:30: warning: no previous prototype for 'jensen_bus_inb' [-Wmissing-prototypes]
     126 | __EXTERN_INLINE unsigned int jensen_bus_inb(unsigned long addr)
         |                              ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:135:22: warning: no previous prototype for 'jensen_bus_outb' [-Wmissing-prototypes]
     135 | __EXTERN_INLINE void jensen_bus_outb(u8 b, unsigned long addr)
         |                      ^~~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:155:20: warning: no previous prototype for 'jensen_inb' [-Wmissing-prototypes]
     155 | __EXTERN_INLINE u8 jensen_inb(unsigned long addr)
         |                    ^~~~~~~~~~
   arch/alpha/include/asm/jensen.h:163:22: warning: no previous prototype for 'jensen_outb' [-Wmissing-prototypes]
     163 | __EXTERN_INLINE void jensen_outb(u8 b, unsigned long addr)
         |                      ^~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:171:21: warning: no previous prototype for 'jensen_inw' [-Wmissing-prototypes]
     171 | __EXTERN_INLINE u16 jensen_inw(unsigned long addr)
         |                     ^~~~~~~~~~
   arch/alpha/include/asm/jensen.h:181:21: warning: no previous prototype for 'jensen_inl' [-Wmissing-prototypes]
     181 | __EXTERN_INLINE u32 jensen_inl(unsigned long addr)
         |                     ^~~~~~~~~~
>> arch/alpha/include/asm/jensen.h:187:21: warning: no previous prototype for 'jensen_inq' [-Wmissing-prototypes]
     187 | __EXTERN_INLINE u64 jensen_inq(unsigned long addr)
         |                     ^~~~~~~~~~
   arch/alpha/include/asm/jensen.h:193:22: warning: no previous prototype for 'jensen_outw' [-Wmissing-prototypes]
     193 | __EXTERN_INLINE void jensen_outw(u16 b, unsigned long addr)
         |                      ^~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:200:22: warning: no previous prototype for 'jensen_outl' [-Wmissing-prototypes]
     200 | __EXTERN_INLINE void jensen_outl(u32 b, unsigned long addr)
         |                      ^~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:207:22: warning: no previous prototype for 'jensen_outq' [-Wmissing-prototypes]
     207 | __EXTERN_INLINE void jensen_outq(u64 b, unsigned long addr)
         |                      ^~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:218:20: warning: no previous prototype for 'jensen_readb' [-Wmissing-prototypes]
     218 | __EXTERN_INLINE u8 jensen_readb(const volatile void __iomem *xaddr)
         |                    ^~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:230:21: warning: no previous prototype for 'jensen_readw' [-Wmissing-prototypes]
     230 | __EXTERN_INLINE u16 jensen_readw(const volatile void __iomem *xaddr)
         |                     ^~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:242:21: warning: no previous prototype for 'jensen_readl' [-Wmissing-prototypes]
     242 | __EXTERN_INLINE u32 jensen_readl(const volatile void __iomem *xaddr)
         |                     ^~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:250:21: warning: no previous prototype for 'jensen_readq' [-Wmissing-prototypes]
     250 | __EXTERN_INLINE u64 jensen_readq(const volatile void __iomem *xaddr)
         |                     ^~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:263:22: warning: no previous prototype for 'jensen_writeb' [-Wmissing-prototypes]
     263 | __EXTERN_INLINE void jensen_writeb(u8 b, volatile void __iomem *xaddr)
         |                      ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:271:22: warning: no previous prototype for 'jensen_writew' [-Wmissing-prototypes]
     271 | __EXTERN_INLINE void jensen_writew(u16 b, volatile void __iomem *xaddr)
         |                      ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:279:22: warning: no previous prototype for 'jensen_writel' [-Wmissing-prototypes]
     279 | __EXTERN_INLINE void jensen_writel(u32 b, volatile void __iomem *xaddr)
         |                      ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:287:22: warning: no previous prototype for 'jensen_writeq' [-Wmissing-prototypes]
     287 | __EXTERN_INLINE void jensen_writeq(u64 b, volatile void __iomem *xaddr)
         |                      ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:297:31: warning: no previous prototype for 'jensen_ioportmap' [-Wmissing-prototypes]
     297 | __EXTERN_INLINE void __iomem *jensen_ioportmap(unsigned long addr)
         |                               ^~~~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:302:31: warning: no previous prototype for 'jensen_ioremap' [-Wmissing-prototypes]
     302 | __EXTERN_INLINE void __iomem *jensen_ioremap(unsigned long addr,
         |                               ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:308:21: warning: no previous prototype for 'jensen_is_ioaddr' [-Wmissing-prototypes]
     308 | __EXTERN_INLINE int jensen_is_ioaddr(unsigned long addr)
         |                     ^~~~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:313:21: warning: no previous prototype for 'jensen_is_mmio' [-Wmissing-prototypes]
     313 | __EXTERN_INLINE int jensen_is_mmio(const volatile void __iomem *addr)
         |                     ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:322:23: warning: no previous prototype for 'jensen_ioread8' [-Wmissing-prototypes]
     322 | __EXTERN_INLINE u##NS jensen_ioread##NS(const void __iomem *xaddr)      \
         |                       ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:337:1: note: in expansion of macro 'IOPORT'
     337 | IOPORT(b, 8)
         | ^~~~~~
   arch/alpha/include/asm/jensen.h:329:22: warning: no previous prototype for 'jensen_iowrite8' [-Wmissing-prototypes]
     329 | __EXTERN_INLINE void jensen_iowrite##NS(u##NS b, void __iomem *xaddr)   \
         |                      ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:337:1: note: in expansion of macro 'IOPORT'
     337 | IOPORT(b, 8)
         | ^~~~~~
   arch/alpha/include/asm/jensen.h:322:23: warning: no previous prototype for 'jensen_ioread16' [-Wmissing-prototypes]
     322 | __EXTERN_INLINE u##NS jensen_ioread##NS(const void __iomem *xaddr)      \
         |                       ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:338:1: note: in expansion of macro 'IOPORT'
     338 | IOPORT(w, 16)
         | ^~~~~~
   arch/alpha/include/asm/jensen.h:329:22: warning: no previous prototype for 'jensen_iowrite16' [-Wmissing-prototypes]
     329 | __EXTERN_INLINE void jensen_iowrite##NS(u##NS b, void __iomem *xaddr)   \
         |                      ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:338:1: note: in expansion of macro 'IOPORT'
     338 | IOPORT(w, 16)
         | ^~~~~~
   arch/alpha/include/asm/jensen.h:322:23: warning: no previous prototype for 'jensen_ioread32' [-Wmissing-prototypes]
     322 | __EXTERN_INLINE u##NS jensen_ioread##NS(const void __iomem *xaddr)      \
         |                       ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:339:1: note: in expansion of macro 'IOPORT'
     339 | IOPORT(l, 32)
         | ^~~~~~
   arch/alpha/include/asm/jensen.h:329:22: warning: no previous prototype for 'jensen_iowrite32' [-Wmissing-prototypes]
     329 | __EXTERN_INLINE void jensen_iowrite##NS(u##NS b, void __iomem *xaddr)   \
         |                      ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:339:1: note: in expansion of macro 'IOPORT'
     339 | IOPORT(l, 32)
         | ^~~~~~
>> arch/alpha/include/asm/jensen.h:322:23: warning: no previous prototype for 'jensen_ioread64' [-Wmissing-prototypes]
     322 | __EXTERN_INLINE u##NS jensen_ioread##NS(const void __iomem *xaddr)      \
         |                       ^~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:340:1: note: in expansion of macro 'IOPORT'
     340 | IOPORT(q, 64)
         | ^~~~~~
   arch/alpha/include/asm/jensen.h:329:22: warning: no previous prototype for 'jensen_iowrite64' [-Wmissing-prototypes]
     329 | __EXTERN_INLINE void jensen_iowrite##NS(u##NS b, void __iomem *xaddr)   \
         |                      ^~~~~~~~~~~~~~
   arch/alpha/include/asm/jensen.h:340:1: note: in expansion of macro 'IOPORT'
     340 | IOPORT(q, 64)
         | ^~~~~~
   In file included from arch/alpha/kernel/sys_jensen.c:11:
   arch/alpha/include/asm/jensen.h:348:33: warning: no previous prototype for 'jensen_iounmap' [-Wmissing-prototypes]
     348 | #define __IO_PREFIX             jensen
         |                                 ^~~~~~
   arch/alpha/include/asm/io.h:137:25: note: in definition of macro '_IO_CONCAT'
     137 | #define _IO_CONCAT(a,b) a ## _ ## b
         |                         ^
   arch/alpha/include/asm/io_trivial.h:141:22: note: in expansion of macro 'IO_CONCAT'
     141 | __EXTERN_INLINE void IO_CONCAT(__IO_PREFIX,iounmap)(volatile void __iomem *a)
         |                      ^~~~~~~~~
   arch/alpha/include/asm/io_trivial.h:141:32: note: in expansion of macro '__IO_PREFIX'
     141 | __EXTERN_INLINE void IO_CONCAT(__IO_PREFIX,iounmap)(volatile void __iomem *a)
         |                                ^~~~~~~~~~~


vim +/t2_iowrite64 +594 arch/alpha/include/asm/core_t2.h

^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  582  
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  583  /* New-style ioread interface.  The mmio routines are so ugly for T2 that
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  584     it doesn't make sense to merge the pio and mmio routines.  */
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  585  
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  586  #define IOPORT(OS, NS)							\
e19d4ebc536dad arch/alpha/include/asm/core_t2.h Arnd Bergmann  2022-10-03  587  __EXTERN_INLINE u##NS t2_ioread##NS(const void __iomem *xaddr)		\
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  588  {									\
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  589  	if (t2_is_mmio(xaddr))						\
5ae0b6c704877d include/asm-alpha/core_t2.h      Jay Estabrook  2007-06-01  590  		return t2_read##OS(xaddr);				\
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  591  	else								\
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  592  		return t2_in##OS((unsigned long)xaddr - T2_IO);		\
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  593  }									\
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16 @594  __EXTERN_INLINE void t2_iowrite##NS(u##NS b, void __iomem *xaddr)	\
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  595  {									\
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  596  	if (t2_is_mmio(xaddr))						\
5ae0b6c704877d include/asm-alpha/core_t2.h      Jay Estabrook  2007-06-01  597  		t2_write##OS(b, xaddr);					\
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  598  	else								\
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  599  		t2_out##OS(b, (unsigned long)xaddr - T2_IO);		\
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  600  }
^1da177e4c3f41 include/asm-alpha/core_t2.h      Linus Torvalds 2005-04-16  601  

:::::: The code at line 594 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
