Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441167B4663
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjJAIyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbjJAIyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:54:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4B0B3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696150438; x=1727686438;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hVkYWwJyGmJLbWbft/MBc/f9/S+8dPStItnunDA38wM=;
  b=PnL4KtJeJ+uYPHANljIS3bAV/Xkn2XmnXbNoOCBOytSTF+3+fwuhRvMC
   /fOPLCucz/f80cHp+Qm17x27qGJL/NQrASPIpjAlnODQIaJa/LAn5TXkH
   EbzUGZCDz+//qRz3oXmlNRx3OkQoFZU5BBX44ksRGUY4AVeTvOPQRmnQi
   dDyMJoZFac1qp0eWYKgSdefnsKRcam1rlPoKp7EvBRDyEg0LnCba+wFY4
   HOWAiibwsy45h6UBcrRvgFma5rkOvs6TOFyB8D/ti0CvvsCxbHyI4VMh+
   ZkdalzFNx7+YhEeHtlZUd2BiGp4qQ+YtF56TQtV5RvJyjMjxhvOscY6O9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="361885666"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="361885666"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 01:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="779674299"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="779674299"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 01 Oct 2023 01:53:55 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmsD2-0004vY-2w;
        Sun, 01 Oct 2023 08:53:52 +0000
Date:   Sun, 1 Oct 2023 16:53:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     WANG Xuerui <git@xen0n.name>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: include/linux/build_bug.h:16:51: error: bit-field '<anonymous>'
 width not an integer constant
Message-ID: <202310011601.XXYEwt2d-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e402b08634b398e9feb94902c7adcf05bb8ba47d
commit: 3f301dc292eb122eff61b8b2906e519154b0327f LoongArch: Replace -ffreestanding with finer-grained -fno-builtin's
date:   5 weeks ago
config: loongarch-loongson3_defconfig (https://download.01.org/0day-ci/archive/20231001/202310011601.XXYEwt2d-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231001/202310011601.XXYEwt2d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310011601.XXYEwt2d-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/percpu.h:13,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from sound/pci/bt87x.c:11:
   arch/loongarch/include/asm/percpu.h:20:4: error: #error compiler support for the model attribute is necessary when a recent assembler is used
      20 | #  error compiler support for the model attribute is necessary when a recent assembler is used
         |    ^~~~~
   In file included from include/linux/init.h:5,
                    from sound/pci/bt87x.c:10:
>> include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:231:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     231 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:56:59: note: in expansion of macro '__must_be_array'
      56 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:517:20: note: in expansion of macro 'ARRAY_SIZE'
     517 |         = { .max = ARRAY_SIZE(array), .num = nump,                      \
         |                    ^~~~~~~~~~
   include/linux/moduleparam.h:501:9: note: in expansion of macro 'module_param_array_named'
     501 |         module_param_array_named(name, name, type, nump, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   sound/pci/bt87x.c:33:1: note: in expansion of macro 'module_param_array'
      33 | module_param_array(index, int, NULL, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> sound/pci/bt87x.c:27:12: warning: 'index' defined but not used [-Wunused-variable]
      27 | static int index[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = -2}; /* Exclude the first card */
         |            ^~~~~
--
   In file included from include/linux/irqflags.h:18,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from sound/usb/card.c:26:
   arch/loongarch/include/asm/percpu.h:20:4: error: #error compiler support for the model attribute is necessary when a recent assembler is used
      20 | #  error compiler support for the model attribute is necessary when a recent assembler is used
         |    ^~~~~
   In file included from include/linux/bits.h:21,
                    from include/linux/bitops.h:6,
                    from sound/usb/card.c:23:
>> include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:231:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     231 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:56:59: note: in expansion of macro '__must_be_array'
      56 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   include/linux/moduleparam.h:517:20: note: in expansion of macro 'ARRAY_SIZE'
     517 |         = { .max = ARRAY_SIZE(array), .num = nump,                      \
         |                    ^~~~~~~~~~
   include/linux/moduleparam.h:501:9: note: in expansion of macro 'module_param_array_named'
     501 |         module_param_array_named(name, name, type, nump, perm)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   sound/usb/card.c:81:1: note: in expansion of macro 'module_param_array'
      81 | module_param_array(index, int, NULL, 0444);
         | ^~~~~~~~~~~~~~~~~~
>> sound/usb/card.c:63:12: warning: 'index' defined but not used [-Wunused-variable]
      63 | static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;      /* Index 0-MAX */
         |            ^~~~~


vim +16 include/linux/build_bug.h

bc6245e5efd70c Ian Abbott       2017-07-10   6  
bc6245e5efd70c Ian Abbott       2017-07-10   7  #ifdef __CHECKER__
bc6245e5efd70c Ian Abbott       2017-07-10   8  #define BUILD_BUG_ON_ZERO(e) (0)
bc6245e5efd70c Ian Abbott       2017-07-10   9  #else /* __CHECKER__ */
bc6245e5efd70c Ian Abbott       2017-07-10  10  /*
bc6245e5efd70c Ian Abbott       2017-07-10  11   * Force a compilation error if condition is true, but also produce a
8788994376d84d Rikard Falkeborn 2019-12-04  12   * result (of value 0 and type int), so the expression can be used
bc6245e5efd70c Ian Abbott       2017-07-10  13   * e.g. in a structure initializer (or where-ever else comma expressions
bc6245e5efd70c Ian Abbott       2017-07-10  14   * aren't permitted).
bc6245e5efd70c Ian Abbott       2017-07-10  15   */
8788994376d84d Rikard Falkeborn 2019-12-04 @16  #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
527edbc18a70e7 Masahiro Yamada  2019-01-03  17  #endif /* __CHECKER__ */
527edbc18a70e7 Masahiro Yamada  2019-01-03  18  

:::::: The code at line 16 was first introduced by commit
:::::: 8788994376d84d627450fd0d67deb6a66ddf07d7 linux/build_bug.h: change type to int

:::::: TO: Rikard Falkeborn <rikard.falkeborn@gmail.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
