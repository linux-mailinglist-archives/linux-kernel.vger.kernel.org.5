Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D087A622D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjISMKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjISMJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:09:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11989F2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695125390; x=1726661390;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S8i8itQGJqKpxJliklCeAW0NKlbEdeRcl9HzsESsjrQ=;
  b=DAyMlnE1WJ5X9P5xgoT6S0T2q42lr7myAXVTyQJBNdF9k64KRgmj+j/s
   SBGs04OJMVFEbc4dg8sqUP1QcnYsRc9Bp8nmQOJsvF462HPSF9AjJ2K3o
   jYuPO2ncliPY1Y1KF7GX9Wy0ut6hgfzRlBvnsMDblEnv78w0FrAganxTo
   LJjn7rHGWe+KQzHmvp31nXQwNXuk6pw5IZSh5f3jv/Y8aOMt6Z8Po251o
   tw45HN9nAI3d/9jpfqK7Zx6pramX30oHyzmGYI/czSKnZ7HoY+SYn2l3Y
   IgqYEeAydIA3N92msXX6PwHNbBcUucwVfrSUe7igmV9z9U+lLqe6ex8II
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="379825874"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="379825874"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 05:09:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="861519279"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="861519279"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 19 Sep 2023 05:09:47 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiZXz-0007Kb-38;
        Tue, 19 Sep 2023 12:09:44 +0000
Date:   Tue, 19 Sep 2023 20:09:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0 is
 outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned
 int[]'}
Message-ID: <202309192013.vI4DKHmw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf0f715623872823a72e451243bbf555d10d032
commit: f1a43aadb5a690e141a3b6700e2a40c1d4dbe088 watchdog: Enable COMPILE_TEST for more drivers
date:   5 weeks ago
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230919/202309192013.vI4DKHmw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309192013.vI4DKHmw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309192013.vI4DKHmw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/io_mm.h:25,
                    from arch/m68k/include/asm/io.h:8,
                    from include/linux/io.h:13,
                    from drivers/watchdog/machzwd.c:39:
   In function 'zf_set_timer',
       inlined from 'zf_timer_on' at drivers/watchdog/machzwd.c:218:2:
>> arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned int[]'} [-Warray-bounds=]
      91 |         __w = ((*(__force volatile u16 *) ((_addr & 0xFFFF0000UL) + ((__v >> 8)<<1)))); \
         |         ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/io_mm.h:228:20: note: in expansion of macro 'rom_out_le16'
     228 |                  : rom_out_le16(isa_itw(port), (val)))
         |                    ^~~~~~~~~~~~
   arch/m68k/include/asm/io_mm.h:356:42: note: in expansion of macro 'isa_rom_outw'
     356 | #define outw(val, port) ((port) < 1024 ? isa_rom_outw((val), (port)) : out_le16((port), (val)))
         |                                          ^~~~~~~~~~~~
   drivers/watchdog/machzwd.c:74:53: note: in expansion of macro 'outw'
      74 | #define zf_writew(port, data)  { outb(port, INDEX); outw(data, DATA_W); }
         |                                                     ^~~~
   drivers/watchdog/machzwd.c:173:17: note: in expansion of macro 'zf_writew'
     173 |                 zf_writew(COUNTER_1, new);
         |                 ^~~~~~~~~
   In function 'zf_timer_on':
   cc1: note: source object is likely at address zero
   In function 'zf_set_timer',
       inlined from 'zf_timer_on' at drivers/watchdog/machzwd.c:218:2:
   arch/m68k/include/asm/raw_io.h:87:13: warning: array subscript 0 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned int[]'} [-Warray-bounds=]
      87 |         __w = ((*(__force volatile u16 *) ((_addr & 0xFFFF0000UL) + ((__v & 0xFF)<<1)))); \
         |         ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/io_mm.h:227:20: note: in expansion of macro 'rom_out_be16'
     227 |         (ISA_SEX ? rom_out_be16(isa_itw(port), (val))   \
         |                    ^~~~~~~~~~~~
   arch/m68k/include/asm/io_mm.h:356:42: note: in expansion of macro 'isa_rom_outw'
     356 | #define outw(val, port) ((port) < 1024 ? isa_rom_outw((val), (port)) : out_le16((port), (val)))
         |                                          ^~~~~~~~~~~~
   drivers/watchdog/machzwd.c:74:53: note: in expansion of macro 'outw'
      74 | #define zf_writew(port, data)  { outb(port, INDEX); outw(data, DATA_W); }
         |                                                     ^~~~
   drivers/watchdog/machzwd.c:173:17: note: in expansion of macro 'zf_writew'
     173 |                 zf_writew(COUNTER_1, new);
         |                 ^~~~~~~~~
   In function 'zf_timer_on':
   cc1: note: source object is likely at address zero


vim +91 arch/m68k/include/asm/raw_io.h

^1da177e4c3f41 include/asm-m68k/raw_io.h      Linus Torvalds     2005-04-16  49  
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  50  /*
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  51   * Atari ROM port (cartridge port) ISA adapter, used for the EtherNEC NE2000
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  52   * network card driver.
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  53   * The ISA adapter connects address lines A9-A13 to ISA address lines A0-A4,
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  54   * and hardwires the rest of the ISA addresses for a base address of 0x300.
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  55   *
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  56   * Data lines D8-D15 are connected to ISA data lines D0-D7 for reading.
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  57   * For writes, address lines A1-A8 are latched to ISA data lines D0-D7
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  58   * (meaning the bit pattern on A1-A8 can be read back as byte).
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  59   *
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  60   * Read and write operations are distinguished by the base address used:
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  61   * reads are from the ROM A side range, writes are through the B side range
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  62   * addresses (A side base + 0x10000).
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  63   *
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  64   * Reads and writes are byte only.
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  65   *
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  66   * 16 bit reads and writes are necessary for the NetUSBee adapter's USB
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  67   * chipset - 16 bit words are read straight off the ROM port while 16 bit
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  68   * reads are split into two byte writes. The low byte is latched to the
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  69   * NetUSBee buffer by a read from the _read_ window (with the data pattern
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  70   * asserted as A1-A8 address pattern). The high byte is then written to the
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  71   * write range as usual, completing the write cycle.
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  72   */
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  73  
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  74  #if defined(CONFIG_ATARI_ROM_ISA)
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  75  #define rom_in_8(addr) \
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  76  	({ u16 __v = (*(__force volatile u16 *) (addr)); __v >>= 8; __v; })
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  77  #define rom_in_be16(addr) \
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  78  	({ u16 __v = (*(__force volatile u16 *) (addr)); __v; })
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  79  #define rom_in_le16(addr) \
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  80  	({ u16 __v = le16_to_cpu(*(__force volatile u16 *) (addr)); __v; })
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  81  
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  82  #define rom_out_8(addr, b)	\
30b5e6ef4a32ea arch/m68k/include/asm/raw_io.h Geert Uytterhoeven 2022-05-20  83  	(void)({u8 __maybe_unused __w, __v = (b);  u32 _addr = ((u32) (addr)); \
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  84  	__w = ((*(__force volatile u8 *)  ((_addr | 0x10000) + (__v<<1)))); })
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  85  #define rom_out_be16(addr, w)	\
30b5e6ef4a32ea arch/m68k/include/asm/raw_io.h Geert Uytterhoeven 2022-05-20  86  	(void)({u16 __maybe_unused __w, __v = (w); u32 _addr = ((u32) (addr)); \
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  87  	__w = ((*(__force volatile u16 *) ((_addr & 0xFFFF0000UL) + ((__v & 0xFF)<<1)))); \
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  88  	__w = ((*(__force volatile u16 *) ((_addr | 0x10000) + ((__v >> 8)<<1)))); })
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  89  #define rom_out_le16(addr, w)	\
30b5e6ef4a32ea arch/m68k/include/asm/raw_io.h Geert Uytterhoeven 2022-05-20  90  	(void)({u16 __maybe_unused __w, __v = (w); u32 _addr = ((u32) (addr)); \
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06 @91  	__w = ((*(__force volatile u16 *) ((_addr & 0xFFFF0000UL) + ((__v >> 8)<<1)))); \
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  92  	__w = ((*(__force volatile u16 *) ((_addr | 0x10000) + ((__v & 0xFF)<<1)))); })
84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  93  

:::::: The code at line 91 was first introduced by commit
:::::: 84b16b7b0d5c818fadc731a69965dc76dce0c91e m68k/atari: ROM port ISA adapter support

:::::: TO: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
:::::: CC: Geert Uytterhoeven <geert@linux-m68k.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
