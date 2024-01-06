Return-Path: <linux-kernel+bounces-18546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5CE825F08
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 10:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C541283DEF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D6F63BA;
	Sat,  6 Jan 2024 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwJ0fHN/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C70C63AC
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704534022; x=1736070022;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zb/Y4q0vX7rJj+VsLRIe4g01p7UiMdDlU1hEh/KHgQQ=;
  b=XwJ0fHN/QJPR6w/4LCKvGRXi9j04Hq4eu1UnkIj1A2pGrs6W5d8Vm8W6
   dCDMjPrftX7T8piuKDkliaNEx3AMAUHHNpYIifh9ayWu+KKQeqsi6cXJI
   KkZ1aXvXC++pIu/uyAhTR3ZpcgqN8BzZCzBinuJIUG3EkBG6Yhsmhz5EI
   egPCha8fky1ZlaBdZIAbagDPXZgy3sJZULFX1+1nFX+QrcXLY0Kut7yuI
   jx7O8Xtkkj/Jss8FV+F54ieOl9hJOnSn8OHJgB6gQbdbOT4o2o1LLMjzC
   AKy1tRHZMCBOHB2ZQmAXPT3Ndhyo7ph3ro0BC9ch0yhwVBg5fRiiE5iPH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="377136802"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="377136802"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 01:40:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="851348524"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="851348524"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2024 01:40:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM3A9-0002I8-25;
	Sat, 06 Jan 2024 09:40:17 +0000
Date: Sat, 6 Jan 2024 17:40:16 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: arch/alpha/include/asm/core_t2.h:587:23: warning: no previous
 prototype for 't2_ioread64'
Message-ID: <202401061736.yM5FZ2oV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: e19d4ebc536dadb607fe305fdaf48218d3e32d7c alpha: add full ioread64/iowrite64 implementation
date:   1 year, 3 months ago
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240106/202401061736.yM5FZ2oV-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401061736.yM5FZ2oV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401061736.yM5FZ2oV-lkp@intel.com/

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
>> arch/alpha/include/asm/core_t2.h:587:23: warning: no previous prototype for 't2_ioread64' [-Wmissing-prototypes]
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
>> arch/alpha/include/asm/jensen.h:207:22: warning: no previous prototype for 'jensen_outq' [-Wmissing-prototypes]
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
>> arch/alpha/include/asm/jensen.h:329:22: warning: no previous prototype for 'jensen_iowrite64' [-Wmissing-prototypes]
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


vim +/t2_ioread64 +587 arch/alpha/include/asm/core_t2.h

   582	
   583	/* New-style ioread interface.  The mmio routines are so ugly for T2 that
   584	   it doesn't make sense to merge the pio and mmio routines.  */
   585	
   586	#define IOPORT(OS, NS)							\
 > 587	__EXTERN_INLINE u##NS t2_ioread##NS(const void __iomem *xaddr)		\
   588	{									\
   589		if (t2_is_mmio(xaddr))						\
   590			return t2_read##OS(xaddr);				\
   591		else								\
   592			return t2_in##OS((unsigned long)xaddr - T2_IO);		\
   593	}									\
 > 594	__EXTERN_INLINE void t2_iowrite##NS(u##NS b, void __iomem *xaddr)	\
   595	{									\
   596		if (t2_is_mmio(xaddr))						\
   597			t2_write##OS(b, xaddr);					\
   598		else								\
   599			t2_out##OS(b, (unsigned long)xaddr - T2_IO);		\
   600	}
   601	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

