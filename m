Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E0C776CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjHIXQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHIXQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:16:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6947BE72
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691623012; x=1723159012;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HNKBP666DL6t8y3TnABE3cOca4ZFuvZyz5JOpviaUTM=;
  b=XDD2pXjnWWSD+egXYGxM0KzIZaRhCdriCZbhs3ibAEeIQBSn42/MhPl2
   Mkx2smRqAu1+G0CY7pufyKKAwXFVcGjqdQjGwCSvdUn9WYR+fm0SuyTof
   gBSHO48TprhpMVUDcun9EBc/+oytlEHohqAPy1M+hD9yXDEflGKgchJm+
   xBgkmW6kRcpq9Gd0iC/87hPFEwXGy6rJTs430a9SsuzzljlsE7wgXKv8I
   xyzyKEXyrlYc88mAV4N6TrYnag+yOlgJHvwqkZLluFdk5QSD1+xsTTMrk
   NnqSODrQ9mNwP2NM4gJsMJBy+RguCy+U43V3Sn15t8Rfk4tSxHCvg9P+w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="356218415"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="356218415"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 16:16:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="725570181"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="725570181"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Aug 2023 16:16:49 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTsQ4-0006Tq-1G;
        Wed, 09 Aug 2023 23:16:48 +0000
Date:   Thu, 10 Aug 2023 07:16:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/net/arcnet/com20020.c:74:7: warning: performing pointer
 arithmetic on a null pointer has undefined behavior
Message-ID: <202308100724.x7jQq1ty-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cacc6e22932f373a91d7be55a9b992dc77f4c59b
commit: 9cc205e3c17d5716da7ebb7fa0c985555e95d009 RISC-V: Make port I/O string accessors actually work
date:   10 months ago
config: riscv-randconfig-r012-20230810 (https://download.01.org/0day-ci/archive/20230810/202308100724.x7jQq1ty-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230810/202308100724.x7jQq1ty-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308100724.x7jQq1ty-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:751:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
   #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   In file included from drivers/net/arcnet/com20020.c:37:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:759:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insl(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
   #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   In file included from drivers/net/arcnet/com20020.c:37:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:768:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsb(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
   #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   In file included from drivers/net/arcnet/com20020.c:37:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:777:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
   #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   In file included from drivers/net/arcnet/com20020.c:37:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:786:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsl(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
   #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   In file included from drivers/net/arcnet/com20020.c:37:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1134:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> drivers/net/arcnet/com20020.c:74:7: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
                arcnet_insb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:389:2: note: expanded from macro 'arcnet_insb'
           insb((addr) + BUS_ALIGN * (offset), buffer, count)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:104:53: note: expanded from macro 'insb'
   #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   drivers/net/arcnet/arcdevice.h:103:3: note: expanded from macro 'TIME'
                   call;                                                   \
                   ^~~~
>> drivers/net/arcnet/com20020.c:74:7: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
                arcnet_insb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:389:2: note: expanded from macro 'arcnet_insb'
           insb((addr) + BUS_ALIGN * (offset), buffer, count)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:104:53: note: expanded from macro 'insb'
   #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
                                            ~~~~~~~~~~ ^
   drivers/net/arcnet/arcdevice.h:110:3: note: expanded from macro 'TIME'
                   call;                                                   \
                   ^~~~
   drivers/net/arcnet/com20020.c:88:7: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
                arcnet_outsb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:391:2: note: expanded from macro 'arcnet_outsb'
           outsb((addr) + BUS_ALIGN * (offset), buffer, count)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
   #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   drivers/net/arcnet/arcdevice.h:103:3: note: expanded from macro 'TIME'
                   call;                                                   \
                   ^~~~
   drivers/net/arcnet/com20020.c:88:7: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
                arcnet_outsb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/arcnet/arcdevice.h:391:2: note: expanded from macro 'arcnet_outsb'
           outsb((addr) + BUS_ALIGN * (offset), buffer, count)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
   #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
                                              ~~~~~~~~~~ ^
   drivers/net/arcnet/arcdevice.h:110:3: note: expanded from macro 'TIME'
                   call;                                                   \
                   ^~~~
   17 warnings generated.


vim +74 drivers/net/arcnet/com20020.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  61  
^1da177e4c3f41 Linus Torvalds 2005-04-16  62  static void com20020_copy_from_card(struct net_device *dev, int bufnum,
^1da177e4c3f41 Linus Torvalds 2005-04-16  63  				    int offset, void *buf, int count)
^1da177e4c3f41 Linus Torvalds 2005-04-16  64  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  65  	int ioaddr = dev->base_addr, ofs = 512 * bufnum + offset;
^1da177e4c3f41 Linus Torvalds 2005-04-16  66  
^1da177e4c3f41 Linus Torvalds 2005-04-16  67  	/* set up the address register */
0fec65130b9f11 Joe Perches    2015-05-05  68  	arcnet_outb((ofs >> 8) | RDDATAflag | AUTOINCflag,
0fec65130b9f11 Joe Perches    2015-05-05  69  		    ioaddr, COM20020_REG_W_ADDR_HI);
0fec65130b9f11 Joe Perches    2015-05-05  70  	arcnet_outb(ofs & 0xff, ioaddr, COM20020_REG_W_ADDR_LO);
^1da177e4c3f41 Linus Torvalds 2005-04-16  71  
^1da177e4c3f41 Linus Torvalds 2005-04-16  72  	/* copy the data */
0fec65130b9f11 Joe Perches    2015-05-05  73  	TIME(dev, "insb", count,
0fec65130b9f11 Joe Perches    2015-05-05 @74  	     arcnet_insb(ioaddr, COM20020_REG_RW_MEMDATA, buf, count));
^1da177e4c3f41 Linus Torvalds 2005-04-16  75  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  76  

:::::: The code at line 74 was first introduced by commit
:::::: 0fec65130b9f11a73d74f47025491f97f82ba070 arcnet: com20020: Use arcnet_<I/O> routines

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Michael Grzeschik <m.grzeschik@pengutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
