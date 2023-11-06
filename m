Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09E77E2FCE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjKFWZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjKFWZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:25:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F381BC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699309535; x=1730845535;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+4d5drTIDaPguILI2PkdxVhWFA/kQkPvxSWrmCmdX10=;
  b=GEdUMDfHXCJ9mI1PkVubWI9sNuJKLUGM0v15nIgpWkyoZycz44tbRuuq
   ApB9aTJJVb2kDMhyPO4osRgKIAjW4UyJzPdkfbL1wXuc77WzsF92hnv4S
   5AZbpukjiMz4hG2x6KSdbaT0D9pl0V7WPypt2LndElNzplu0IvAgWJNPL
   PRwZ7Mgwn0xdkez7l0L6evgJXTztiVgjbHCHUO9Nxe0a0p3c3CNvgj1Os
   uGAseTfQEhNusNKgZsq3UmNdamz1WaGOeU3XRkQRqVa25hgsIy0m66YZh
   aKKEvkJYmylnKe0ysvRFMj+WCwQ4J4grmg0CEAfY/LQPG4dnu7x8du+/b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475618834"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="475618834"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 14:25:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="712341281"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="712341281"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Nov 2023 14:25:33 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r082F-0006lc-0B;
        Mon, 06 Nov 2023 22:25:31 +0000
Date:   Tue, 7 Nov 2023 06:25:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/usb/gadget/udc/omap_udc.c:110:19: warning: 'driver_desc'
 defined but not used
Message-ID: <202311070616.6TJr86vx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: 250c1a694ff304e5d69e74ab32755eddcc2b8f65 ARM: pxa: convert to multiplatform
date:   1 year, 6 months ago
config: arm-randconfig-r035-20230201 (https://download.01.org/0day-ci/archive/20231107/202311070616.6TJr86vx-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311070616.6TJr86vx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311070616.6TJr86vx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/gadget/udc/omap_udc.c: In function 'omap_udc_pio_irq':
   drivers/usb/gadget/udc/omap_udc.c:1915:37: warning: variable 'stat' set but not used [-Wunused-but-set-variable]
    1915 |                                 int stat;
         |                                     ^~~~
   At top level:
>> drivers/usb/gadget/udc/omap_udc.c:110:19: warning: 'driver_desc' defined but not used [-Wunused-const-variable=]
     110 | static const char driver_desc[] = DRIVER_DESC;
         |                   ^~~~~~~~~~~


vim +/driver_desc +110 drivers/usb/gadget/udc/omap_udc.c

^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  107  
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  108  
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  109  static const char driver_name[] = "omap_udc";
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16 @110  static const char driver_desc[] = DRIVER_DESC;
^1da177e4c3f41 drivers/usb/gadget/omap_udc.c Linus Torvalds 2005-04-16  111  

:::::: The code at line 110 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
