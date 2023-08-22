Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8218784CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjHVW0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjHVW0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:26:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72E2CD9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692743194; x=1724279194;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/nUhKEi/fBYzKkURoZWSb/wFRFPAD0iy0hEcZ6Slxew=;
  b=PhqZcLD8tjsZZBTRpwwpl5U//JZrBNK85S/9a94Xusz5o0hA5ac9KD4m
   ZYzCIiiFE0OcqKGW0FhYgR6DCBSZokv6G3ppmzkHFnkznh9bt2VB7nfwz
   Va2ZoE5l9+icOIuD5ItKNMGkReJgJE/mgj/JkvbrJWZq8jhBXohR7JTY4
   zRPSdO+Qy3+HD2Hjex9+2EOPTR3wHOa18azQKc+7PxwdXKla34Pc++MGR
   okPoPLb+zNElodmVB5REMs2hG8F50rmDTSFowCCm8UPyVBh6lHJuoeAtU
   +nmrp7pzq5xOC6/m1PbdFgAtKQS71iU3Ddq6Ytpmf1YJqa32488gQ/7UI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="364192808"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364192808"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 15:26:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="983047595"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="983047595"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 22 Aug 2023 15:26:31 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYZpX-0000a1-0X;
        Tue, 22 Aug 2023 22:26:31 +0000
Date:   Wed, 23 Aug 2023 06:25:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rohan McLure <rmclure@linux.ibm.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/media/dvb-frontends/dib0090.c:2542:12: warning: stack frame
 size (2080) exceeds limit (2048) in 'dib0090_set_params'
Message-ID: <202308230658.YWtkC9Oz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rohan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89bf6209cad66214d3774dac86b6bbf2aec6a30d
commit: 6f0926c00565a91f3bd7ca1aa05db307daed5e0f powerpc/kcsan: Add KCSAN Support
date:   6 months ago
config: powerpc64-randconfig-r032-20230823 (https://download.01.org/0day-ci/archive/20230823/202308230658.YWtkC9Oz-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308230658.YWtkC9Oz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308230658.YWtkC9Oz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:47:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(insl, (unsigned long p, void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:207:1: note: expanded from here
   __do_insl
   ^
   arch/powerpc/include/asm/io.h:579:56: note: expanded from macro '__do_insl'
   #define __do_insl(p, b, n)      readsl((PCI_IO_ADDR)_IO_BASE+(p), (b), (n))
                                          ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/media/dvb-frontends/dib0090.c:15:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:49:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsb, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:211:1: note: expanded from here
   __do_outsb
   ^
   arch/powerpc/include/asm/io.h:580:58: note: expanded from macro '__do_outsb'
   #define __do_outsb(p, b, n)     writesb((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/media/dvb-frontends/dib0090.c:15:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:51:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsw, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:215:1: note: expanded from here
   __do_outsw
   ^
   arch/powerpc/include/asm/io.h:581:58: note: expanded from macro '__do_outsw'
   #define __do_outsw(p, b, n)     writesw((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
   In file included from drivers/media/dvb-frontends/dib0090.c:15:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:26:
   In file included from include/linux/kernel_stat.h:9:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:640:
   arch/powerpc/include/asm/io-defs.h:53:1: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   DEF_PCI_AC_NORET(outsl, (unsigned long p, const void *b, unsigned long c),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/include/asm/io.h:637:3: note: expanded from macro 'DEF_PCI_AC_NORET'
                   __do_##name al;                                 \
                   ^~~~~~~~~~~~~~
   <scratch space>:219:1: note: expanded from here
   __do_outsl
   ^
   arch/powerpc/include/asm/io.h:582:58: note: expanded from macro '__do_outsl'
   #define __do_outsl(p, b, n)     writesl((PCI_IO_ADDR)_IO_BASE+(p),(b),(n))
                                           ~~~~~~~~~~~~~~~~~~~~~^
>> drivers/media/dvb-frontends/dib0090.c:2542:12: warning: stack frame size (2080) exceeds limit (2048) in 'dib0090_set_params' [-Wframe-larger-than]
   static int dib0090_set_params(struct dvb_frontend *fe)
              ^
   1997/2080 (96.01%) spills, 83/2080 (3.99%) variables
   13 warnings generated.


vim +/dib0090_set_params +2542 drivers/media/dvb-frontends/dib0090.c

03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2541  
14d24d148c7521 drivers/media/dvb/frontends/dib0090.c Mauro Carvalho Chehab 2011-12-24 @2542  static int dib0090_set_params(struct dvb_frontend *fe)
03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2543  {
03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2544  	struct dib0090_state *state = fe->tuner_priv;
28fafca78797be drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2011-01-04  2545  	u32 ret;
03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2546  
03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2547  	state->tune_state = CT_TUNER_START;
03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2548  
03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2549  	do {
03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2550  		ret = dib0090_tune(fe);
0de04ca1dc0bd3 drivers/media/dvb-frontends/dib0090.c Mauro Carvalho Chehab 2014-07-04  2551  		if (ret == FE_CALLBACK_TIME_NEVER)
03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2552  			break;
0de04ca1dc0bd3 drivers/media/dvb-frontends/dib0090.c Mauro Carvalho Chehab 2014-07-04  2553  
0de04ca1dc0bd3 drivers/media/dvb-frontends/dib0090.c Mauro Carvalho Chehab 2014-07-04  2554  		/*
0de04ca1dc0bd3 drivers/media/dvb-frontends/dib0090.c Mauro Carvalho Chehab 2014-07-04  2555  		 * Despite dib0090_tune returns time at a 0.1 ms range,
0de04ca1dc0bd3 drivers/media/dvb-frontends/dib0090.c Mauro Carvalho Chehab 2014-07-04  2556  		 * the actual sleep time depends on CONFIG_HZ. The worse case
0de04ca1dc0bd3 drivers/media/dvb-frontends/dib0090.c Mauro Carvalho Chehab 2014-07-04  2557  		 * is when CONFIG_HZ=100. In such case, the minimum granularity
0de04ca1dc0bd3 drivers/media/dvb-frontends/dib0090.c Mauro Carvalho Chehab 2014-07-04  2558  		 * is 10ms. On some real field tests, the tuner sometimes don't
0de04ca1dc0bd3 drivers/media/dvb-frontends/dib0090.c Mauro Carvalho Chehab 2014-07-04  2559  		 * lock when this timer is lower than 10ms. So, enforce a 10ms
0de04ca1dc0bd3 drivers/media/dvb-frontends/dib0090.c Mauro Carvalho Chehab 2014-07-04  2560  		 * granularity and use usleep_range() instead of msleep().
0de04ca1dc0bd3 drivers/media/dvb-frontends/dib0090.c Mauro Carvalho Chehab 2014-07-04  2561  		 */
0de04ca1dc0bd3 drivers/media/dvb-frontends/dib0090.c Mauro Carvalho Chehab 2014-07-04  2562  		ret = 10 * (ret + 99)/100;
0de04ca1dc0bd3 drivers/media/dvb-frontends/dib0090.c Mauro Carvalho Chehab 2014-07-04  2563  		usleep_range(ret * 1000, (ret + 1) * 1000);
03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2564  	} while (state->tune_state != CT_TUNER_STOP);
03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2565  
03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2566  	return 0;
03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2567  }
03245a5ee69a5f drivers/media/dvb/frontends/dib0090.c Olivier Grenie        2009-12-04  2568  

:::::: The code at line 2542 was first introduced by commit
:::::: 14d24d148c7521b2b88b396652e36f55d061e195 [media] tuners: remove dvb_frontend_parameters from set_params()

:::::: TO: Mauro Carvalho Chehab <mchehab@redhat.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
