Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408137B44C8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 02:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjJAAII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 20:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjJAAIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 20:08:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43570BD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 17:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696118884; x=1727654884;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iVIL1zSIBrkMRxQ+z3Akbkyw5DGNTM/4weSJUkd4SBI=;
  b=kNYPPLSoPomWcxkvK1wB/jtks+KcmkSObr82hOD55BgES+VHz/LOD9OP
   1smIPS99A8U/nVu793zS5W4pfj/IfhVifKH6ZX23Zfj16+eMtXkt8IS4m
   yrKpWAXyWUZhdBuINpKdeeEb1+Vu6sf5V5hqmYpn2oikpWrU13YjFepa1
   zJ96yHPtGDueKF2LYfxb/+/hCDjLne5TRBPYdo5leHGNU/qNy+6930zsa
   LDpw2ETjsaaV7tt42WntDJ81435rkpY6I7XP+HVwNuzCh9BMXpiiOy4yN
   aNCb1Km5zobumqLCbnfdx5hP7GyriyvU9RQk4R5tpJSLSRllCqrTn9++0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="382389761"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="382389761"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 17:08:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="726913305"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="726913305"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Sep 2023 17:08:02 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmk07-0004az-2U;
        Sun, 01 Oct 2023 00:07:59 +0000
Date:   Sun, 1 Oct 2023 08:07:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kalle Valo <quic_kvalo@quicinc.com>
Subject: include/linux/compiler_types.h:397:45: error: call to
 '__compiletime_assert_460' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(vring->va[0]) != 32
Message-ID: <202310010730.tcSX6KvJ-lkp@intel.com>
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
head:   3b517966c5616ac011081153482a5ba0e91b17ff
commit: 1ad8237e971630c66a1a6194491e0837b64d00e0 wifi: wil6210: fix fortify warnings
date:   9 weeks ago
config: arm-buildonly-randconfig-r003-20220914 (https://download.01.org/0day-ci/archive/20231001/202310010730.tcSX6KvJ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231001/202310010730.tcSX6KvJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310010730.tcSX6KvJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/net/wireless/ath/wil6210/txrx.c: In function 'wil_vring_alloc':
>> include/linux/compiler_types.h:397:45: error: call to '__compiletime_assert_460' declared with attribute error: BUILD_BUG_ON failed: sizeof(vring->va[0]) != 32
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:378:25: note: in definition of macro '__compiletime_assert'
     378 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/wil6210/txrx.c:118:9: note: in expansion of macro 'BUILD_BUG_ON'
     118 |         BUILD_BUG_ON(sizeof(vring->va[0]) != 32);
         |         ^~~~~~~~~~~~
--
   In file included from <command-line>:
   drivers/net/wireless/ath/wil6210/txrx_edma.c: In function 'wil_ring_alloc_desc_ring':
>> include/linux/compiler_types.h:397:45: error: call to '__compiletime_assert_452' declared with attribute error: BUILD_BUG_ON failed: sizeof(ring->va[0]) != 32
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:378:25: note: in definition of macro '__compiletime_assert'
     378 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
     397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/net/wireless/ath/wil6210/txrx_edma.c:381:9: note: in expansion of macro 'BUILD_BUG_ON'
     381 |         BUILD_BUG_ON(sizeof(ring->va[0]) != 32);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_460 +397 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  383  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  384  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  385  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  386  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  387  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  388   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  389   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  390   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  391   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  392   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  393   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  394   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  395   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  396  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @397  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  398  

:::::: The code at line 397 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
