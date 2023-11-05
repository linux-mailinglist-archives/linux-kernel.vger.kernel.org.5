Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADEF7E157D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 18:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjKER2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 12:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjKER2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 12:28:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14187DD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 09:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699205299; x=1730741299;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wDCwqlVch+ojaiAx1S4djZX43XFw12GnoquKjf81qbY=;
  b=ebGm+tgr+lreLe2ne6fQ4zKMXtxelPnVhT9k/s5xm2OOYmfnDhRnj8wJ
   QhmMkZoPxOCU5IssEEGYJvh1FMDCWGyYZ+0KcOh8wfUpqyTz0XbOKfRVr
   cL/tv33KwD42LFFCoyrPmcKsCT2C6PKoDHz2kVSXZHpLEEbTAhpU2nJKh
   i0xleGvt9plj8dn/hFejeszmTxeYklhD7QtU7VYYGCGdlw6x07xC55t2X
   U1sqml66TE0OcUPv86bevhYvuw0M+MiZgDfo6sPupmjf5l9n9IaRqgEbC
   lcNR/nhp/JzWiKVt/xkRmsSsTT5AAHtm6bvlYBZBrdxl9tiXHr2FmMrrN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="392029083"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="392029083"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 09:28:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="738591940"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="738591940"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Nov 2023 09:28:16 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzgv0-0005fA-0q;
        Sun, 05 Nov 2023 17:28:14 +0000
Date:   Mon, 6 Nov 2023 01:27:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: include/linux/compiler_types.h:354:38: error: call to
 '__compiletime_assert_282' declared with attribute error: FIELD_PREP: value
 too large for the field
Message-ID: <202311060135.Q9eMnpCL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amelie,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: 1c32d6c37cc2a037e447e73f919d57e89ef4b571 dmaengine: stm32-dma: use bitfield helpers
date:   1 year, 2 months ago
config: i386-buildonly-randconfig-004-20231010 (https://download.01.org/0day-ci/archive/20231106/202311060135.Q9eMnpCL-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060135.Q9eMnpCL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060135.Q9eMnpCL-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:0:0:
   drivers/dma/stm32-dma.c: In function 'stm32_dma_prep_dma_memcpy':
>> include/linux/compiler_types.h:354:38: error: call to '__compiletime_assert_282' declared with attribute error: FIELD_PREP: value too large for the field
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                         ^
   include/linux/compiler_types.h:335:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler_types.h:354:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
      ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: in expansion of macro '__BF_FIELD_CHECK'
      __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
      ^~~~~~~~~~~~~~~~
   drivers/dma/stm32-dma.c:1237:4: note: in expansion of macro 'FIELD_PREP'
       FIELD_PREP(STM32_DMA_SCR_PBURST_MASK, dma_burst) |
       ^~~~~~~~~~


vim +/__compiletime_assert_282 +354 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  340  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  341  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  342  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  343  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  346   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  348   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  349   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  350   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  351   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  352   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  353  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @354  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  355  

:::::: The code at line 354 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
