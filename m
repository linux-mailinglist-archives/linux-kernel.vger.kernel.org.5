Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE493805C0C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjLERNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjLERNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:13:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9251AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701796388; x=1733332388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C50b1hT9bdPKWty71s+6Tz72a9faiyJW59kqfSxsWSc=;
  b=P5f24KUjyk6MmQKpwFv9Kea+ZU0+C9o402NBsgyR5X5SFMP4jI+JDYyG
   oipNtowuopfuveLSE2Q5s5v+mi1pxwMDCjeAhglF7XMv5guGx5W/EkCY8
   gymseOYHT6VK3h23qAP5kdCgcvLl1ReOf8b+vCoeotT1Ti39AZq59ZLqQ
   k6YERvMzEDNwTKOOJ51j9gTliDwQT31fsKy/9Fl3x6KOssg5lU0XwzYnf
   KnfitODGdT9eYAwmMlvnDOugg579m82xenycPsLIk3SqwZ/N8/5hXjlGY
   8VHr2NI+sbIcf3B9rQl3OGBnp8FEXPQ2Uq23YuZIQvYsK8v/YaqmSvRC0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="373377336"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="373377336"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:13:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="770987840"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="770987840"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 05 Dec 2023 09:13:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAYyl-0009Qq-2N;
        Tue, 05 Dec 2023 17:13:03 +0000
Date:   Wed, 6 Dec 2023 01:12:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haoran Liu <liuhaoran14@163.com>, support.opensource@diasemi.com
Cc:     oe-kbuild-all@lists.linux.dev, lee@kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: Re: [PATCH] [mfd] da9052: Add error handling for spi_setup in
 da9052_spi_probe
Message-ID: <202312060001.AnSLILR4-lkp@intel.com>
References: <20231203052125.37334-1-liuhaoran14@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203052125.37334-1-liuhaoran14@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haoran,

kernel test robot noticed the following build errors:

[auto build test ERROR on lee-mfd/for-mfd-next]
[also build test ERROR on lee-leds/for-leds-next lee-mfd/for-mfd-fixes linus/master v6.7-rc4 next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haoran-Liu/da9052-Add-error-handling-for-spi_setup-in-da9052_spi_probe/20231203-132410
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20231203052125.37334-1-liuhaoran14%40163.com
patch subject: [PATCH] [mfd] da9052: Add error handling for spi_setup in da9052_spi_probe
config: x86_64-randconfig-123-20231203 (https://download.01.org/0day-ci/archive/20231206/202312060001.AnSLILR4-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060001.AnSLILR4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060001.AnSLILR4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mfd/da9052-spi.c:25:6: error: redefinition of 'ret'
           int ret;
               ^
   drivers/mfd/da9052-spi.c:22:6: note: previous definition is here
           int ret;
               ^
   1 error generated.


vim +/ret +25 drivers/mfd/da9052-spi.c

    18	
    19	static int da9052_spi_probe(struct spi_device *spi)
    20	{
    21		struct regmap_config config;
    22		int ret;
    23		const struct spi_device_id *id = spi_get_device_id(spi);
    24		struct da9052 *da9052;
  > 25		int ret;
    26	
    27		da9052 = devm_kzalloc(&spi->dev, sizeof(struct da9052), GFP_KERNEL);
    28		if (!da9052)
    29			return -ENOMEM;
    30	
    31		spi->mode = SPI_MODE_0;
    32		spi->bits_per_word = 8;
    33		ret = spi_setup(spi);
    34		if (ret) {
    35			dev_err(&spi->dev, "spi_setup failed: %d\n", ret);
    36			return ret;
    37		}
    38	
    39		da9052->dev = &spi->dev;
    40		da9052->chip_irq = spi->irq;
    41	
    42		spi_set_drvdata(spi, da9052);
    43	
    44		config = da9052_regmap_config;
    45		config.read_flag_mask = 1;
    46		config.reg_bits = 7;
    47		config.pad_bits = 1;
    48		config.val_bits = 8;
    49		config.use_single_read = true;
    50		config.use_single_write = true;
    51	
    52		da9052->regmap = devm_regmap_init_spi(spi, &config);
    53		if (IS_ERR(da9052->regmap)) {
    54			ret = PTR_ERR(da9052->regmap);
    55			dev_err(&spi->dev, "Failed to allocate register map: %d\n",
    56				ret);
    57			return ret;
    58		}
    59	
    60		return da9052_device_init(da9052, id->driver_data);
    61	}
    62	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
