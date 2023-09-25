Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA0E7AD8A1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjIYNJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjIYNJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:09:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3780383
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695647355; x=1727183355;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+lOzy4MNxa6dvWFgmjo3SH802I/gRLOjlvBI3i2diVo=;
  b=VFxCe7RHXJOj8icwTW36Uhu9toMF/qfsusCOevAGjFO37SfdnTuwxxYT
   CFa8sUt4RI/5FyZlRgsqt+5Q+mrEYEeevgXjCQn7sQowfNSUoDjW4pijC
   dQ+0RzhFC4bXGakQ6yAAlfG7We2rzy4ahxneL5r4lyg+dh0kwq3/veNsk
   RAVW1MQkJzDO+SQ0fX03BRoTkI/Gr/bfV+zyYGI0U1fXDh9Gq7K/SOFD+
   8tNoTUSgDPiG9a1RXyCzKMCGUHSNBFlQ/gxbw0mSScyRCnZyoh+mLJjUB
   VOt/NmKnJ2miFpO/pwZIxQ89lflVnlG8BhH01AaQghtjbUmnFiR2NOqFM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412174776"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="412174776"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 06:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="697968293"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="697968293"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Sep 2023 06:09:12 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qklKo-0001XF-1C;
        Mon, 25 Sep 2023 13:09:10 +0000
Date:   Mon, 25 Sep 2023 21:08:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/platform/mips/rs780e-acpi.c:35:6: warning: no previous
 prototype for 'pm_iowrite'
Message-ID: <202309252145.ivuYn1BU-lkp@intel.com>
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

Hi Jiaxun,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6465e260f48790807eef06b583b38ca9789b6072
commit: 0cfd2440aa03ea3d4b04cc2565561cecadcb1257 MIPS: Loongson64: Make RS780E ACPI as a platform driver
date:   3 years, 5 months ago
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20230925/202309252145.ivuYn1BU-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230925/202309252145.ivuYn1BU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309252145.ivuYn1BU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/mips/rs780e-acpi.c:35:6: warning: no previous prototype for 'pm_iowrite' [-Wmissing-prototypes]
      35 | void pm_iowrite(u8 reg, u8 value)
         |      ^~~~~~~~~~
>> drivers/platform/mips/rs780e-acpi.c:41:4: warning: no previous prototype for 'pm_ioread' [-Wmissing-prototypes]
      41 | u8 pm_ioread(u8 reg)
         |    ^~~~~~~~~
>> drivers/platform/mips/rs780e-acpi.c:47:6: warning: no previous prototype for 'pm2_iowrite' [-Wmissing-prototypes]
      47 | void pm2_iowrite(u8 reg, u8 value)
         |      ^~~~~~~~~~~
>> drivers/platform/mips/rs780e-acpi.c:53:4: warning: no previous prototype for 'pm2_ioread' [-Wmissing-prototypes]
      53 | u8 pm2_ioread(u8 reg)
         |    ^~~~~~~~~~
   drivers/platform/mips/rs780e-acpi.c:72:6: warning: no previous prototype for 'acpi_registers_setup' [-Wmissing-prototypes]
      72 | void acpi_registers_setup(void)
         |      ^~~~~~~~~~~~~~~~~~~~


vim +/pm_iowrite +35 drivers/platform/mips/rs780e-acpi.c

9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  34  
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29 @35  void pm_iowrite(u8 reg, u8 value)
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  36  {
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  37  	pmio_write_index(PM_INDEX, reg, value);
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  38  }
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  39  EXPORT_SYMBOL(pm_iowrite);
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  40  
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29 @41  u8 pm_ioread(u8 reg)
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  42  {
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  43  	return pmio_read_index(PM_INDEX, reg);
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  44  }
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  45  EXPORT_SYMBOL(pm_ioread);
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  46  
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29 @47  void pm2_iowrite(u8 reg, u8 value)
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  48  {
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  49  	pmio_write_index(PM2_INDEX, reg, value);
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  50  }
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  51  EXPORT_SYMBOL(pm2_iowrite);
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  52  
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29 @53  u8 pm2_ioread(u8 reg)
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  54  {
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  55  	return pmio_read_index(PM2_INDEX, reg);
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  56  }
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  57  EXPORT_SYMBOL(pm2_ioread);
9c057b3e02184b drivers/platform/mips/acpi_init.c Huacai Chen 2015-03-29  58  

:::::: The code at line 35 was first introduced by commit
:::::: 9c057b3e02184b111d3392be75efc7c94f0fdf20 MIPS: Loongson-3: Add chipset ACPI platform driver

:::::: TO: Huacai Chen <chenhc@lemote.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
