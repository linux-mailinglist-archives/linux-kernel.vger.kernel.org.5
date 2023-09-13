Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C594B79F1FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjIMTYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjIMTYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:24:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2F7B7;
        Wed, 13 Sep 2023 12:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694633045; x=1726169045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JKUb9rL4FzUyXqKQxYbktD4DL6Zic8jMxxL3DCtChfE=;
  b=CVpz+bWK60Co1Dyl3SQfjTY9nefzJ5p7OiLphhGVI34e3NdMPurpQmx1
   2bggxqBKyFWdkNFxEmPUCFT1U61IATBY/ei2DBdU8I5/7wk+IA+7VUMoj
   wN2Lv7W8R7bj41S1BZSTJ/rY+BFNz3iEiPuNKi2cQi3limyZ92GfZg1nR
   D0kyei/G+LLA/qYsXhi+mVf816AcZAbbCS1J8Y+YjlZMF7kQV5iA6G2s1
   JiZHNS+CLcpnnVhW6VTDRb4V9dNUmmz/6Q9SM6GdIq4TQVvXfWxlE+ANf
   laDg7XkFFlItXcNT6rQnif/T1NcMz/QVZEplxeaRHe5CmYaJXXA1kiH31
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377673288"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="377673288"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 12:24:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="917962143"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="917962143"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Sep 2023 12:23:59 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgVSu-0000Vl-1z;
        Wed, 13 Sep 2023 19:23:56 +0000
Date:   Thu, 14 Sep 2023 03:23:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/5] gpiolib: provide gpiod_set_active_[low/high]()
Message-ID: <202309140338.TPkz7l7g-lkp@intel.com>
References: <20230913115001.23183-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913115001.23183-2-brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on mtd/nand/next linus/master ulf-hansson-mmc-mirror/next v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpiolib-provide-gpiod_set_active_-low-high/20230913-195053
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230913115001.23183-2-brgl%40bgdev.pl
patch subject: [PATCH 1/5] gpiolib: provide gpiod_set_active_[low/high]()
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20230914/202309140338.TPkz7l7g-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140338.TPkz7l7g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309140338.TPkz7l7g-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/smsc/smc91x.c:60:
   include/linux/gpio/consumer.h:505:1: error: expected ';', ',' or ')' before '{' token
     505 | {
         | ^
>> drivers/net/ethernet/smsc/smc91x.c:47:19: warning: 'version' defined but not used [-Wunused-const-variable=]
      47 | static const char version[] =
         |                   ^~~~~~~


vim +/version +47 drivers/net/ethernet/smsc/smc91x.c

^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16 @47  static const char version[] =
6389aa458ed995 drivers/net/ethernet/smsc/smc91x.c Ben Boeckel     2013-11-01  48  	"smc91x.c: v1.1, sep 22 2004 by Nicolas Pitre <nico@fluxnic.net>";
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  49  
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  50  /* Debugging level */
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  51  #ifndef SMC_DEBUG
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  52  #define SMC_DEBUG		0
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  53  #endif
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  54  
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  55  
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  56  #include <linux/module.h>
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  57  #include <linux/kernel.h>
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  58  #include <linux/sched.h>
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  59  #include <linux/delay.h>
c0e906a953f03c drivers/net/ethernet/smsc/smc91x.c Andy Shevchenko 2023-03-16 @60  #include <linux/gpio/consumer.h>
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  61  #include <linux/interrupt.h>
476c32c47a84fc drivers/net/smc91x.c               David Howells   2010-10-07  62  #include <linux/irq.h>
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  63  #include <linux/errno.h>
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  64  #include <linux/ioport.h>
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  65  #include <linux/crc32.h>
d052d1beff7069 drivers/net/smc91x.c               Russell King    2005-10-29  66  #include <linux/platform_device.h>
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  67  #include <linux/spinlock.h>
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  68  #include <linux/ethtool.h>
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  69  #include <linux/mii.h>
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  70  #include <linux/workqueue.h>
682a1694115ec1 drivers/net/smc91x.c               Thomas Chou     2011-01-25  71  #include <linux/of.h>
3f823c15d53dc7 drivers/net/ethernet/smsc/smc91x.c Tony Lindgren   2013-12-11  72  #include <linux/of_device.h>
^1da177e4c3f41 drivers/net/smc91x.c               Linus Torvalds  2005-04-16  73  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
