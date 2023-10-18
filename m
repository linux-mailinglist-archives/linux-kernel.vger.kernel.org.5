Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA937CDB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjJRMRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJRMRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:17:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D1298
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697631462; x=1729167462;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dHkoLIfxnYUWY2Iox3++2sra/kbJ6jFmxl4MQYmTP6k=;
  b=Tkv++MTYugSwgmtCJ9Gyxc023dJ2Opp0ICYml0KD5jI/JsWu1M+3ZDHa
   ha6Hszh2QdjGzomIEcP1rUJQLxEANmYDxQHyZgpVgUkGMmr52cCVKOJG/
   INxOCxjuC/Xs2WDuujFK0oHup15lORbho5HI3B4Fj6VJghWdJfGob7rR+
   4+Hq737YFS81UgElBYx3twMlqzk32Vf92IIx+mH2n86463SzXNC1f97rZ
   dADdrO26KVDzeymJPFOND1nNkQeKW24V27RPtBw8Fy7DDXUZxb5momSUA
   hKxYmvJ+wSVQWokfZnkHIQgXsF0FQU0mOdAxJmpPnsqN4xhcbTB7mU/gJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7550788"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="7550788"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 05:17:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="4520992"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Oct 2023 05:17:44 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt5UY-0000Kq-0d;
        Wed, 18 Oct 2023 12:17:38 +0000
Date:   Wed, 18 Oct 2023 20:16:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/kernel/hibernate.c:29:40: warning: array subscript -1 is
 outside array bounds of 'const void[2147483647]'
Message-ID: <202310182007.8ziiRe0j-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: a9ff6961601d9aa0c42b6eb7d850371f31b1f5e6 ARM: mm: Make virt_to_pfn() a static inline
date:   5 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20231018/202310182007.8ziiRe0j-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310182007.8ziiRe0j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310182007.8ziiRe0j-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm/kernel/hibernate.c: In function 'pfn_is_nosave':
>> arch/arm/kernel/hibernate.c:29:40: warning: array subscript -1 is outside array bounds of 'const void[2147483647]' [-Warray-bounds=]
      29 |         unsigned long nosave_end_pfn = virt_to_pfn(&__nosave_end - 1);
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/sections.h:5,
                    from include/linux/interrupt.h:21,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/arm/kernel/hibernate.c:18:
   include/asm-generic/sections.h:59:45: note: at offset -1 into object '__nosave_end' of size [0, 2147483647]
      59 | extern __visible const void __nosave_begin, __nosave_end;
         |                                             ^~~~~~~~~~~~


vim +29 arch/arm/kernel/hibernate.c

603fb42a66499a Sebastian Capella 2014-03-25  25  
603fb42a66499a Sebastian Capella 2014-03-25  26  int pfn_is_nosave(unsigned long pfn)
603fb42a66499a Sebastian Capella 2014-03-25  27  {
603fb42a66499a Sebastian Capella 2014-03-25  28  	unsigned long nosave_begin_pfn = virt_to_pfn(&__nosave_begin);
603fb42a66499a Sebastian Capella 2014-03-25 @29  	unsigned long nosave_end_pfn = virt_to_pfn(&__nosave_end - 1);
603fb42a66499a Sebastian Capella 2014-03-25  30  
603fb42a66499a Sebastian Capella 2014-03-25  31  	return (pfn >= nosave_begin_pfn) && (pfn <= nosave_end_pfn);
603fb42a66499a Sebastian Capella 2014-03-25  32  }
603fb42a66499a Sebastian Capella 2014-03-25  33  

:::::: The code at line 29 was first introduced by commit
:::::: 603fb42a66499ab353466c7afa3d38beea20a8a9 ARM: 8011/1: ARM hibernation / suspend-to-disk

:::::: TO: Sebastian Capella <sebastian.capella@linaro.org>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
