Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA267ACD8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 03:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjIYBXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 21:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjIYBXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 21:23:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AB2CA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 18:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695604994; x=1727140994;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6sVZRiotsmL00ZmOLHcutCwg4Dmv28OiRqrgLO8rcFA=;
  b=GZp/PrauBzo+d+J8ZQuWEh6l/VU3gqVQDGCneV60l04pAP+cU5eu6oYN
   UQm3YbAzhu/8jRRuDsj2lPCTQUPGIZOZ4UJgxxnPun+X7v81mBB7QwT2F
   Q6NmbTx1DLl6avE+C8qityyX2r9CCeXKnAZL8ZnhDwdy4LR3reilPHDiB
   jDC9UCHgAf8IeMfLIp2UUgDfhjdhQYJ2Eu6aDftkeBqItQK/R5ncHriiG
   LGJJXw6Jzo+jFiWta3A5KEmw0FaCGna5dNIOKnOY2AM+bqDrGJciU/d4D
   Qqw7P5Yi/hQkKdnXJ24QMSfloBs/cfVqOQ4MbeAFlZWt7GJjrbmqhwL/b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412075741"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="412075741"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 18:23:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="777491323"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="777491323"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 24 Sep 2023 18:23:11 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkaJa-0000j8-17;
        Mon, 25 Sep 2023 01:23:10 +0000
Date:   Mon, 25 Sep 2023 09:23:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: include/linux/kern_levels.h:5:25: warning: format '%lx' expects
 argument of type 'long unsigned int', but argument 2 has type 'unsigned int'
Message-ID: <202309250903.XNAjFuxy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6465e260f48790807eef06b583b38ca9789b6072
commit: 02a07872f84fc5fe61fa65310ff23bcad166a4f5 ASoC: dma-sh7760: cleanup a debug printk
date:   4 years, 9 months ago
config: sh-randconfig-r015-20221226 (https://download.01.org/0day-ci/archive/20230925/202309250903.XNAjFuxy-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230925/202309250903.XNAjFuxy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309250903.XNAjFuxy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:14,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from sound/soc/sh/dma-sh7760.c:13:
   sound/soc/sh/dma-sh7760.c: In function 'camelot_prepare':
>> include/linux/kern_levels.h:5:25: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'unsigned int' [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:136:24: note: in definition of macro 'no_printk'
     136 |                 printk(fmt, ##__VA_ARGS__);             \
         |                        ^~~
   include/linux/kern_levels.h:15:25: note: in expansion of macro 'KERN_SOH'
      15 | #define KERN_DEBUG      KERN_SOH "7"    /* debug-level messages */
         |                         ^~~~~~~~
   include/linux/printk.h:346:19: note: in expansion of macro 'KERN_DEBUG'
     346 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                   ^~~~~~~~~~
   sound/soc/sh/dma-sh7760.c:205:9: note: in expansion of macro 'pr_debug'
     205 |         pr_debug("PCM data: addr 0x%08lx len %d\n",
         |         ^~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

:::::: The code at line 5 was first introduced by commit
:::::: 04d2c8c83d0e3ac5f78aeede51babb3236200112 printk: convert the format for KERN_<LEVEL> to a 2 byte pattern

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
