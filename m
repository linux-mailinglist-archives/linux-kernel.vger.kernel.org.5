Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B95F7FE87C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjK3FEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3FEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:04:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB8A10D7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 21:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701320690; x=1732856690;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YFovUzAK/1X615RUH6MDlgAHZSILM8GrgwzPxIyJFtw=;
  b=WVE75lPSbL+OLHTOnvvuzhbKpfA2R35j/3k0FwFzIFFyFytYDcwtg9v/
   rGz3YpABFi/eQjayfV7I1a9Ea3kkZdeeCFtu68aUZHBjgd1Msq5OwYi8V
   trf0j8Ry62If0C/koF1NBuBgfG0XPiAy5b0BDMs60PUmyvazTY4g7Ieh6
   bUmRtSDsQ97/WeTLip4xkorFJFiVTGLK3w5Y600UfhqJX2hzJxw2x280X
   ZguagvYHWwUMr0BwOVsi4JKwbAFH8TUNuAtCpdyhiIyW6FJbmRCZ9LsnA
   s902TyyjNl4HRJCtZZZNxSHB2tNH8pHpcUVLDCRTxj3n+ifUoqIKTkyuS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="396078911"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="396078911"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 21:04:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="745503684"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="745503684"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2023 21:04:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8ZED-0001OO-2v;
        Thu, 30 Nov 2023 05:04:45 +0000
Date:   Thu, 30 Nov 2023 13:03:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: drivers/platform/mips/rs780e-acpi.c:47:6: warning: no previous
 prototype for 'pm2_iowrite'
Message-ID: <202311301354.Ga1imV7I-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxun,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: 0cfd2440aa03ea3d4b04cc2565561cecadcb1257 MIPS: Loongson64: Make RS780E ACPI as a platform driver
date:   3 years, 7 months ago
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20231130/202311301354.Ga1imV7I-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311301354.Ga1imV7I-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311301354.Ga1imV7I-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/platform/mips/rs780e-acpi.c:35:6: warning: no previous prototype for 'pm_iowrite' [-Wmissing-prototypes]
      35 | void pm_iowrite(u8 reg, u8 value)
         |      ^~~~~~~~~~
   drivers/platform/mips/rs780e-acpi.c:41:4: warning: no previous prototype for 'pm_ioread' [-Wmissing-prototypes]
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


vim +/pm2_iowrite +47 drivers/platform/mips/rs780e-acpi.c

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

:::::: The code at line 47 was first introduced by commit
:::::: 9c057b3e02184b111d3392be75efc7c94f0fdf20 MIPS: Loongson-3: Add chipset ACPI platform driver

:::::: TO: Huacai Chen <chenhc@lemote.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
