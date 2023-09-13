Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5551679F14B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjIMSmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjIMSmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:42:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43677A3;
        Wed, 13 Sep 2023 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694630523; x=1726166523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ySvBneYbyUTIYVjc9ntDNQZxLyrK/wDV6Bnw1fCxoOQ=;
  b=iLBeNq7csY0tfP2Jcz6HFJuwckwRwOC8ocI+P0pGFZJf1EDog99ava/a
   YG4Jg84CYX0ljZyNt6dKU6zWB/XKsyCVW7txi4VmFa621oO091CV4fZkV
   9WrrDj4O0qh+uGHLjhybu8Wsgo9txwnHXHCjzzBwISPzw4sKu+0KnmNIi
   7GRtu3ob56JQ6CCjf5HACafxXiXvNVvV7F61lbK2BTl+BLsfINFUl1IXT
   TBZz5O4V10b7qiTX7ml86VuT0+HJoMtQZpjYF6vIZI55aLwOdbtqEzu0e
   z4X03IMJ4DuuMdWIAuU7YqhdYcIlQWu7F74avY0FFq0Qn3vZBMgHGoV1O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377663165"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="377663165"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="991040387"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="991040387"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Sep 2023 11:41:57 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgUoF-0000T3-0O;
        Wed, 13 Sep 2023 18:41:55 +0000
Date:   Thu, 14 Sep 2023 02:41:19 +0800
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
Message-ID: <202309140219.EH2Y6r52-lkp@intel.com>
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
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20230914/202309140219.EH2Y6r52-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140219.EH2Y6r52-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309140219.EH2Y6r52-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/nvmem-provider.h:15,
                    from include/linux/rtc.h:18,
                    from include/linux/mc146818rtc.h:15,
                    from drivers/block/floppy.c:183:
   include/linux/gpio/consumer.h:505:1: error: expected ';', ',' or ')' before '{' token
     505 | {
         | ^
>> drivers/block/floppy.c:165:12: warning: 'print_unex' defined but not used [-Wunused-variable]
     165 | static int print_unex = 1;
         |            ^~~~~~~~~~


vim +/print_unex +165 drivers/block/floppy.c

87f530d8f17336 Joe Perches            2010-03-10  163  
^1da177e4c3f41 Linus Torvalds         2005-04-16  164  /* do print messages for unexpected interrupts */
^1da177e4c3f41 Linus Torvalds         2005-04-16 @165  static int print_unex = 1;
^1da177e4c3f41 Linus Torvalds         2005-04-16  166  #include <linux/module.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  167  #include <linux/sched.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  168  #include <linux/fs.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  169  #include <linux/kernel.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  170  #include <linux/timer.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  171  #include <linux/workqueue.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  172  #include <linux/fdreg.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  173  #include <linux/fd.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  174  #include <linux/hdreg.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  175  #include <linux/errno.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  176  #include <linux/slab.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  177  #include <linux/mm.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  178  #include <linux/bio.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  179  #include <linux/string.h>
50297cbf07427b Marcelo Feitoza Parisi 2006-03-28  180  #include <linux/jiffies.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  181  #include <linux/fcntl.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  182  #include <linux/delay.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16 @183  #include <linux/mc146818rtc.h>	/* CMOS defines */
^1da177e4c3f41 Linus Torvalds         2005-04-16  184  #include <linux/ioport.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  185  #include <linux/interrupt.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  186  #include <linux/init.h>
b81e0c2372e65e Christoph Hellwig      2021-09-20  187  #include <linux/major.h>
d052d1beff7069 Russell King           2005-10-29  188  #include <linux/platform_device.h>
83f9ef463bcb4b Scott James Remnant    2009-04-02  189  #include <linux/mod_devicetable.h>
b1c82b5c55851b Jes Sorensen           2006-03-23  190  #include <linux/mutex.h>
d49375434ec011 Joe Perches            2010-03-10  191  #include <linux/io.h>
d49375434ec011 Joe Perches            2010-03-10  192  #include <linux/uaccess.h>
0cc15d03bcccdf Andi Kleen             2012-07-02  193  #include <linux/async.h>
229b53c9bf4e11 Al Viro                2017-06-27  194  #include <linux/compat.h>
^1da177e4c3f41 Linus Torvalds         2005-04-16  195  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
