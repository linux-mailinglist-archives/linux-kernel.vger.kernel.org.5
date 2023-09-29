Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A0C7B3B56
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjI2Ul5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjI2Ul4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:41:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F16C1AE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696020113; x=1727556113;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dR7SUYn2jYKCo8MxOXStEXnxyfIRE39PjK8d61aXcDs=;
  b=f4iRcO+CpSZs71/YDTsAgOvAWAFyYdUGzwUbzw1UrEWH3cEKMfCNhJul
   hPLC9d4ehkmLe0RDARzD619PuB+MskrZB1cVy+sE3yFGqetLWc8q+Uk2f
   ggvm9ZS1Cvik7hyEYenRPC60KQNBv2Oo3vq5VQRo0od+0VJv5lWAfryu0
   75/C0mypWyWjuL5iUJAectt4zWZWIrZlfnSuIlncyx9vTKgN8GccZE5J3
   M9Wtv8JlX+lrosmPOwJvhqiWMXl27iwIw77kFBMGa19gbIp8TFmTX3r/V
   REyUq1zUPqn5tw0QnVFXZDxl4Vwcxj0iSklgouItQ/bbW/CAjwx/sX8BU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="382280476"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="382280476"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:08:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="785186197"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="785186197"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 29 Sep 2023 13:08:31 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmJmm-0003Cr-1s;
        Fri, 29 Sep 2023 20:08:28 +0000
Date:   Sat, 30 Sep 2023 04:07:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: arch/arm/mach-sa1100/pm.c:122:12: warning: no previous prototype for
 function 'sa11x0_pm_init'
Message-ID: <202309300341.lmOXFhDS-lkp@intel.com>
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

Hi Nathan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c84724ccb1a9f6eaf727ded49dd7e22ac62cc5b
commit: 5eb6e280432ddc9b755193552f3a070da8d7455c ARM: 9289/1: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer
date:   8 months ago
config: arm-collie_defconfig (https://download.01.org/0day-ci/archive/20230930/202309300341.lmOXFhDS-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309300341.lmOXFhDS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309300341.lmOXFhDS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/mach-sa1100/pm.c:122:12: warning: no previous prototype for function 'sa11x0_pm_init' [-Wmissing-prototypes]
     122 | int __init sa11x0_pm_init(void)
         |            ^
   arch/arm/mach-sa1100/pm.c:122:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     122 | int __init sa11x0_pm_init(void)
         | ^
         | static 
   1 warning generated.
--
>> drivers/gpio/gpio-sa1100.c:309:13: warning: no previous prototype for function 'sa1100_init_gpio' [-Wmissing-prototypes]
     309 | void __init sa1100_init_gpio(void)
         |             ^
   drivers/gpio/gpio-sa1100.c:309:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     309 | void __init sa1100_init_gpio(void)
         | ^
         | static 
   1 warning generated.
--
>> drivers/pcmcia/pxa2xx_sharpsl.c:206:5: warning: no previous prototype for function 'pcmcia_collie_init' [-Wmissing-prototypes]
     206 | int pcmcia_collie_init(struct device *dev)
         |     ^
   drivers/pcmcia/pxa2xx_sharpsl.c:206:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     206 | int pcmcia_collie_init(struct device *dev)
         | ^
         | static 
   1 warning generated.
--
>> drivers/video/fbdev/sa1100fb.c:1219:12: warning: no previous prototype for function 'sa1100fb_init' [-Wmissing-prototypes]
    1219 | int __init sa1100fb_init(void)
         |            ^
   drivers/video/fbdev/sa1100fb.c:1219:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1219 | int __init sa1100fb_init(void)
         | ^
         | static 
   1 warning generated.


vim +/sa11x0_pm_init +122 arch/arm/mach-sa1100/pm.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  121  
7fea1ba58e61c1 Shawn Guo      2012-04-26 @122  int __init sa11x0_pm_init(void)

:::::: The code at line 122 was first introduced by commit
:::::: 7fea1ba58e61c17fb59dfc50c408945f307addc6 ARM: sa1100: use machine specific hook for late init

:::::: TO: Shawn Guo <shawn.guo@linaro.org>
:::::: CC: Shawn Guo <shawn.guo@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
