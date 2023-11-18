Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669007EFDC6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 05:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjKREpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 23:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKREpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 23:45:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C398A10CE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 20:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700282698; x=1731818698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F0GA4gQJmsLJxgMIP0B2eggM2Q2Xv0DQU6ZJ84xNLlo=;
  b=nIA1BK9aYEB1Ls8t8X510GEIOPLNqihgfbsF/Xk5UGg+6lrrTMBEhpwe
   W/5j1Tlo1oARa5Bvh1aDmHHvw+dtQiVh9BgCTFvJ6Q47/22g/J5ak933x
   1tdB2PvAEJ06zUHjvXtUHjEpCvSE22smALxVTxhuKKzXOv/148R38/I7b
   BAByzNxx9DqvqvGHuonUHh2z2QOiakFd60jqashvEOBxSp9GJcbK5X0PE
   gCHjdoh86+E4jsZtLwgF4NbZTcnTmYlbO9/JjB4an+ET63kr+G1EVwfDT
   JvSxYFvoqAugQeLjzVG6/kP5CtNvvQe1x+M7OsAcXZWwkVlVUsXjoU+0Y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="390268794"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="390268794"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 20:44:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="13669016"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 17 Nov 2023 20:44:57 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4DCG-0003WY-1g;
        Sat, 18 Nov 2023 04:44:51 +0000
Date:   Sat, 18 Nov 2023 12:43:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Baluta <daniel.baluta@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: drivers/iio/magnetometer/bmc150_magn_spi.c:48:36: warning:
 'bmc150_magn_acpi_match' defined but not used
Message-ID: <202311181254.T7DGa79n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   791c8ab095f71327899023223940dd52257a4173
commit: 534536acdb25bae85a5333b7085837b3f1f72b73 iio: magn: bmc150: Introduce SPI support
date:   8 years ago
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231118/202311181254.T7DGa79n-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311181254.T7DGa79n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311181254.T7DGa79n-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/module.h:17,
                    from drivers/iio/magnetometer/bmc150_magn_spi.c:12:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:517:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     517 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:437:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     437 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
   drivers/iio/magnetometer/bmc150_magn_spi.c: At top level:
   drivers/iio/magnetometer/bmc150_magn_spi.c:49:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      49 |         {"BMC150B", 0},
         |         ^
   In file included from drivers/iio/magnetometer/bmc150_magn_spi.c:13:
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
   drivers/iio/magnetometer/bmc150_magn_spi.c:50:9: warning: missing initializer for field 'cls' of 'const struct acpi_device_id' [-Wmissing-field-initializers]
      50 |         {"BMC156B", 0},
         |         ^
   include/linux/mod_devicetable.h:192:15: note: 'cls' declared here
     192 |         __u32 cls;
         |               ^~~
>> drivers/iio/magnetometer/bmc150_magn_spi.c:48:36: warning: 'bmc150_magn_acpi_match' defined but not used [-Wunused-const-variable=]
      48 | static const struct acpi_device_id bmc150_magn_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~


vim +/bmc150_magn_acpi_match +48 drivers/iio/magnetometer/bmc150_magn_spi.c

    47	
  > 48	static const struct acpi_device_id bmc150_magn_acpi_match[] = {
    49		{"BMC150B", 0},
    50		{"BMC156B", 0},
    51		{},
    52	};
    53	MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
