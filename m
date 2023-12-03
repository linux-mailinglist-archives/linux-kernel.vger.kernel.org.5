Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0422802142
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjLCGbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbjLCGbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:31:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AA8F4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701585109; x=1733121109;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HkToBunISyj5JMG7HEqZU79bB4Zu9OidjjTuWFNXMNs=;
  b=hcZGqTc2IiLNF8NWw3I77jMEB28VkmiwhcG7i0h/OR75AsHqkFwtmCfD
   PxzizCJ3uEAkSyYE4GpVoTW+KQAydU2wC199279gT7/CkHoEtmoip+BEq
   IfK12enmBV54NHRaPXv8KIF83yjYZzsi7Ac9KggBcT4r6B5VXSemBtYdv
   +BCoYzLOkFm9CKegHRJ+vwj7X6DYdjyBUMUNTonaI0JTNDNbSILz7zUHn
   kg5JCZbKsyqD44L+bYpW+tvursAznRf8IR5PAV1duio+D39NtwWKLqBVM
   vTiRdoyBOd6skHMgJmVK7pAJoCUwDR99dJRXpIoEStthU9a0+R880VZL3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="15180368"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="15180368"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:31:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="943556087"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="943556087"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2023 22:31:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9g11-0006KZ-31;
        Sun, 03 Dec 2023 06:31:43 +0000
Date:   Sun, 3 Dec 2023 14:31:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Subject: drivers/mtd/maps/vmu-flash.c:722:24: error: 'struct mtd_info' has no
 member named 'usecount'
Message-ID: <202312022315.79twVRZw-lkp@intel.com>
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

Hi Tomas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: 19bfa9ebebb5ec0695def57eb1d80de7e9cab369 mtd: use refcount to prevent corruption
date:   5 months ago
config: sh-randconfig-c034-20221009 (https://download.01.org/0day-ci/archive/20231202/202312022315.79twVRZw-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231202/202312022315.79twVRZw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312022315.79twVRZw-lkp@intel.com/

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
