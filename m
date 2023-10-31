Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F467DC4EA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjJaDi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJaDiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:38:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C7EB3;
        Mon, 30 Oct 2023 20:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698723503; x=1730259503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F8GDi1EX8bU9UvI6orKS0N+PBl8cmuL30fdUKmURp+I=;
  b=PUvzfSJ1xmITFwC4dVZA0AFNblEhPnDtaHGTBZw3++p1wmGeXAake9MZ
   VDAW9qOdy9rcRcQ68NR9flocSUZvChxPKXw0u/ZDS8D//lDG/G10XLIUs
   eTNR7RwVz7Ho+gAkVqDv6wQB2d4jMpC/tYQexbyPILxZA2Y8l24p0tdbd
   LEDJ71qc2lHKznkJ5OyEfqQuR+70Mf+v7HMexaH22v+/lWg3v1+5EgyYk
   nM62P6hk6IVoAfHO+sw+rWKei7/KmD89TqSWEm3yqARqfcvAA8fvQCsqC
   67Jj1LdDG5TXvuIFSgnx4aF3DZ5vqBEZZkzs7d4iVT6FArz+d5ZDt0i60
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="392071614"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="392071614"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 20:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="1711171"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 30 Oct 2023 20:38:19 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxfa4-000DnL-12;
        Tue, 31 Oct 2023 03:38:16 +0000
Date:   Tue, 31 Oct 2023 11:38:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Artur Weber <aweber.kernel@gmail.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH 4/6] mfd: bcm590xx: Add compatible for BCM59054
Message-ID: <202310311110.QsKHR6Ap-lkp@intel.com>
References: <20231030-bcm59054-v1-4-3517f980c1e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030-bcm59054-v1-4-3517f980c1e3@gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artur,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1]

url:    https://github.com/intel-lab-lkp/linux/commits/Artur-Weber/dt-bindings-mfd-brcm-bcm59056-Convert-to-YAML/20231031-040046
base:   05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
patch link:    https://lore.kernel.org/r/20231030-bcm59054-v1-4-3517f980c1e3%40gmail.com
patch subject: [PATCH 4/6] mfd: bcm590xx: Add compatible for BCM59054
config: loongarch-randconfig-001-20231031 (https://download.01.org/0day-ci/archive/20231031/202310311110.QsKHR6Ap-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310311110.QsKHR6Ap-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310311110.QsKHR6Ap-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mfd/bcm590xx.c: In function 'bcm590xx_i2c_probe':
>> drivers/mfd/bcm590xx.c:53:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      53 |         bcm590xx->device_type = (unsigned int)of_device_get_match_data(bcm590xx->dev);
         |                                 ^


vim +53 drivers/mfd/bcm590xx.c

    39	
    40	static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
    41	{
    42		struct bcm590xx *bcm590xx;
    43		int ret;
    44	
    45		bcm590xx = devm_kzalloc(&i2c_pri->dev, sizeof(*bcm590xx), GFP_KERNEL);
    46		if (!bcm590xx)
    47			return -ENOMEM;
    48	
    49		i2c_set_clientdata(i2c_pri, bcm590xx);
    50		bcm590xx->dev = &i2c_pri->dev;
    51		bcm590xx->i2c_pri = i2c_pri;
    52	
  > 53		bcm590xx->device_type = (unsigned int)of_device_get_match_data(bcm590xx->dev);
    54	
    55		bcm590xx->regmap_pri = devm_regmap_init_i2c(i2c_pri,
    56							 &bcm590xx_regmap_config_pri);
    57		if (IS_ERR(bcm590xx->regmap_pri)) {
    58			ret = PTR_ERR(bcm590xx->regmap_pri);
    59			dev_err(&i2c_pri->dev, "primary regmap init failed: %d\n", ret);
    60			return ret;
    61		}
    62	
    63		/* Secondary I2C slave address is the base address with A(2) asserted */
    64		bcm590xx->i2c_sec = i2c_new_dummy_device(i2c_pri->adapter,
    65						  i2c_pri->addr | BIT(2));
    66		if (IS_ERR(bcm590xx->i2c_sec)) {
    67			dev_err(&i2c_pri->dev, "failed to add secondary I2C device\n");
    68			return PTR_ERR(bcm590xx->i2c_sec);
    69		}
    70		i2c_set_clientdata(bcm590xx->i2c_sec, bcm590xx);
    71	
    72		bcm590xx->regmap_sec = devm_regmap_init_i2c(bcm590xx->i2c_sec,
    73							&bcm590xx_regmap_config_sec);
    74		if (IS_ERR(bcm590xx->regmap_sec)) {
    75			ret = PTR_ERR(bcm590xx->regmap_sec);
    76			dev_err(&bcm590xx->i2c_sec->dev,
    77				"secondary regmap init failed: %d\n", ret);
    78			goto err;
    79		}
    80	
    81		ret = devm_mfd_add_devices(&i2c_pri->dev, -1, bcm590xx_devs,
    82					   ARRAY_SIZE(bcm590xx_devs), NULL, 0, NULL);
    83		if (ret < 0) {
    84			dev_err(&i2c_pri->dev, "failed to add sub-devices: %d\n", ret);
    85			goto err;
    86		}
    87	
    88		return 0;
    89	
    90	err:
    91		i2c_unregister_device(bcm590xx->i2c_sec);
    92		return ret;
    93	}
    94	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
