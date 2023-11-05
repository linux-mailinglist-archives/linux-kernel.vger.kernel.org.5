Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2507E1273
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 08:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjKEHaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 02:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjKEHa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 02:30:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA11FB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 00:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699169425; x=1730705425;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OuHa9eYEwxur9io2JhjEQ5Wx1lRqKdHZlpdk3/MrIK8=;
  b=imicWebW4VDAvg3qPgs37XsrPkSIiIMjtGZ+34jpVLmTw3ZGEUZU2A7r
   M1ZHlRLSEe9C7fd+VD6dyhgPs2R+KRYi4ZeUn47dUP21KbvAlCE3DOzwb
   JO0HzA06LGBJGcqCc2SfIBBMUSIBZxYWbzYLm9wGYmYKg3zM0MhZ7bbZT
   8jmHkq9xV5jLhbKFdyPQo7nuG/FXzF4GHVtuLR2ci5A/YYr1GQklvxaH3
   Eqp9y1z35VCDaejokvUqoebXlIr/Tv0rYakyI+EwKbTSQRX9K1mBbxGYt
   PlPTG1y27WFiRD0TQ5XMPSJvWoVe/QCbhPgkuejp7IphUUr4dSMa11QKG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="374162753"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="374162753"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 00:30:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="1009232418"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="1009232418"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2023 00:30:23 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzXaP-00059K-1A;
        Sun, 05 Nov 2023 07:30:21 +0000
Date:   Sun, 5 Nov 2023 15:29:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Purna Chandra Mandal <purna.mandal@microchip.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-pic32-sqi.c:749:34: warning: 'pic32_sqi_of_ids'
 defined but not used
Message-ID: <202311051543.C4ewiBWU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea6bf908d730b01bd264a8821159db9463c111c
commit: 3270ac230f660843a7f7d631746ee2c8ee63f347 spi: pic32-sqi: add SPI driver for PIC32 SQI controller.
date:   8 years ago
config: x86_64-buildonly-randconfig-001-20231101 (https://download.01.org/0day-ci/archive/20231105/202311051543.C4ewiBWU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051543.C4ewiBWU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051543.C4ewiBWU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/device.h:17,
                    from include/linux/dma-mapping.h:6,
                    from drivers/spi/spi-pic32-sqi.c:18:
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
   drivers/spi/spi-pic32-sqi.c: At top level:
>> drivers/spi/spi-pic32-sqi.c:749:34: warning: 'pic32_sqi_of_ids' defined but not used [-Wunused-const-variable=]
     749 | static const struct of_device_id pic32_sqi_of_ids[] = {
         |                                  ^~~~~~~~~~~~~~~~


vim +/pic32_sqi_of_ids +749 drivers/spi/spi-pic32-sqi.c

   748	
 > 749	static const struct of_device_id pic32_sqi_of_ids[] = {
   750		{.compatible = "microchip,pic32mzda-sqi",},
   751		{},
   752	};
   753	MODULE_DEVICE_TABLE(of, pic32_sqi_of_ids);
   754	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
