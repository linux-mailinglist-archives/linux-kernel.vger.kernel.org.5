Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A87C7B5036
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbjJBKYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbjJBKYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:24:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BDF90
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696242288; x=1727778288;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZdCKscSqF5q2jG6/3MMBgpDg1VRd6fbXyMEO74FeRfc=;
  b=UMjc+wPs3CeWTMsAf113WkpbyIWRACxifUtyKHVm0D4P68Z4EtUNyTrU
   Ur4TySikoSIrWNJ+kA/18LxJU81aZQcsrtqpo+06Sm9hPUviSfRfMu+j9
   MuvZ8fgLEzQX0Wul4oxOjJT4opO6kGs+PGF94Cfzx3ngTu2eghumfWA8A
   d/3nzjBntuXKIovunxD1gvxDY1HElOr/gRjLNiJYoQRRDuheZaB6jN8q6
   n0b5n0ihTOd1H+zcS1eFdSDzdTOPrMEOHDdWs/xFNLEgemwj4/0y1XFF3
   +wC9C/FQe2ACfXaVGJnBJa0gfROve56raKxr9jMv+tWhLfbcFvuS+rBdS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="372965532"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="372965532"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 03:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="754013903"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="754013903"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 02 Oct 2023 03:24:47 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnG6X-0005wp-0V;
        Mon, 02 Oct 2023 10:24:45 +0000
Date:   Mon, 2 Oct 2023 18:24:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Subject: drivers/mtd/maps/vmu-flash.c:722:24: error: 'struct mtd_info' has no
 member named 'usecount'
Message-ID: <202310021816.G41lF9xc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
commit: 19bfa9ebebb5ec0695def57eb1d80de7e9cab369 mtd: use refcount to prevent corruption
date:   3 months ago
config: sh-randconfig-c034-20221009 (https://download.01.org/0day-ci/archive/20231002/202310021816.G41lF9xc-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231002/202310021816.G41lF9xc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310021816.G41lF9xc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/mtd/maps/vmu-flash.c:12:
   include/linux/maple.h:81:23: error: field 'dev' has incomplete type
      81 |         struct device dev;
         |                       ^~~
   include/linux/maple.h:86:30: error: field 'drv' has incomplete type
      86 |         struct device_driver drv;
         |                              ^~~
   drivers/mtd/maps/vmu-flash.c: In function 'vmu_can_unload':
>> drivers/mtd/maps/vmu-flash.c:722:24: error: 'struct mtd_info' has no member named 'usecount'
     722 |                 if (mtd->usecount > 0)
         |                        ^~
   In file included from include/linux/init.h:5,
                    from drivers/mtd/maps/vmu-flash.c:8:
   drivers/mtd/maps/vmu-flash.c: In function 'probe_maple_vmu':
   include/linux/compiler_types.h:338:27: error: expression in static assertion is not an integer
     338 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/maple.h:100:25: note: in expansion of macro 'container_of'
     100 | #define to_maple_dev(n) container_of(n, struct maple_device, dev)
         |                         ^~~~~~~~~~~~
   drivers/mtd/maps/vmu-flash.c:775:37: note: in expansion of macro 'to_maple_dev'
     775 |         struct maple_device *mdev = to_maple_dev(dev);
         |                                     ^~~~~~~~~~~~
   include/linux/compiler_types.h:338:27: error: expression in static assertion is not an integer
     338 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/maple.h:101:28: note: in expansion of macro 'container_of'
     101 | #define to_maple_driver(n) container_of(n, struct maple_driver, drv)
         |                            ^~~~~~~~~~~~
   drivers/mtd/maps/vmu-flash.c:776:37: note: in expansion of macro 'to_maple_driver'
     776 |         struct maple_driver *mdrv = to_maple_driver(dev->driver);
         |                                     ^~~~~~~~~~~~~~~
   drivers/mtd/maps/vmu-flash.c: In function 'remove_maple_vmu':
   include/linux/compiler_types.h:338:27: error: expression in static assertion is not an integer
     338 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/maple.h:100:25: note: in expansion of macro 'container_of'
     100 | #define to_maple_dev(n) container_of(n, struct maple_device, dev)
         |                         ^~~~~~~~~~~~
   drivers/mtd/maps/vmu-flash.c:787:37: note: in expansion of macro 'to_maple_dev'
     787 |         struct maple_device *mdev = to_maple_dev(dev);
         |                                     ^~~~~~~~~~~~


vim +722 drivers/mtd/maps/vmu-flash.c

47a72688fae729 Adrian McMenamin 2009-03-04  709  
47a72688fae729 Adrian McMenamin 2009-03-04  710  /* Callback to handle eccentricities of both mtd subsystem
47a72688fae729 Adrian McMenamin 2009-03-04  711   * and general flakyness of Dreamcast VMUs
47a72688fae729 Adrian McMenamin 2009-03-04  712   */
47a72688fae729 Adrian McMenamin 2009-03-04  713  static int vmu_can_unload(struct maple_device *mdev)
47a72688fae729 Adrian McMenamin 2009-03-04  714  {
47a72688fae729 Adrian McMenamin 2009-03-04  715  	struct memcard *card;
47a72688fae729 Adrian McMenamin 2009-03-04  716  	int x;
47a72688fae729 Adrian McMenamin 2009-03-04  717  	struct mtd_info *mtd;
47a72688fae729 Adrian McMenamin 2009-03-04  718  
47a72688fae729 Adrian McMenamin 2009-03-04  719  	card = maple_get_drvdata(mdev);
47a72688fae729 Adrian McMenamin 2009-03-04  720  	for (x = 0; x < card->partitions; x++) {
47a72688fae729 Adrian McMenamin 2009-03-04  721  		mtd = &((card->mtd)[x]);
47a72688fae729 Adrian McMenamin 2009-03-04 @722  		if (mtd->usecount > 0)
47a72688fae729 Adrian McMenamin 2009-03-04  723  			return 0;
47a72688fae729 Adrian McMenamin 2009-03-04  724  	}
47a72688fae729 Adrian McMenamin 2009-03-04  725  	return 1;
47a72688fae729 Adrian McMenamin 2009-03-04  726  }
47a72688fae729 Adrian McMenamin 2009-03-04  727  

:::::: The code at line 722 was first introduced by commit
:::::: 47a72688fae7298e1ad5fdc9bff7e04b6a549620 mtd: flash mapping support for Dreamcast VMU.

:::::: TO: Adrian McMenamin <adrian@newgolddream.dyndns.info>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
