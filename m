Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648AB79E4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbjIMK2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjIMK23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:28:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFA519B6;
        Wed, 13 Sep 2023 03:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694600905; x=1726136905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BOm7IybDAePeWd4TLpHqIfUxkm0hIFIrRWXa31Z5Nis=;
  b=F23BHJmf145ATC4Q8X0mTTw7o5wV2wZOmxyCt9jv1zD+LO9k9pBjeKWY
   P01QGG7gRtx5IzTkFEXZh6EHR0cuvwqLuXE3Bct8lCo6UWu0LwJ/Wp5zy
   aGRTk7jTt1pOwC8ECAYp+22eKaUBm/LSftclGYtgaLac+PoZBogz26Upw
   bt3xyvoiG/Zt63ixyonJbZVvr0xMCLjltrDALfIlhK7MLObbh1Ab7CEWd
   MGDKi3D3j55+ur6imyZZThYCqdpZ/vIsx7yWifAo1d0XVtu3SMhwEJvfl
   SX2iDhXOILANZ8Vs1panmmnROiwYYLFyW3fhvlYvJbJZbOQxqzsdBUokq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="363652640"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="363652640"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:28:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="917773493"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="917773493"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Sep 2023 03:28:22 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgN6Z-0000Oh-2V;
        Wed, 13 Sep 2023 10:28:19 +0000
Date:   Wed, 13 Sep 2023 18:28:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>, broonie@kernel.org,
        zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     oe-kbuild-all@lists.linux.dev,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3] regulator (max5970): Add hwmon support
Message-ID: <202309131847.4GIyTQIO-lkp@intel.com>
References: <20230911113647.1259204-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911113647.1259204-1-naresh.solanki@9elements.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

kernel test robot noticed the following build errors:

[auto build test ERROR on 41f02a383ac652f1a0b5538c5901b7ec93e37290]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/regulator-max5970-Add-hwmon-support/20230912-072321
base:   41f02a383ac652f1a0b5538c5901b7ec93e37290
patch link:    https://lore.kernel.org/r/20230911113647.1259204-1-naresh.solanki%409elements.com
patch subject: [PATCH v3] regulator (max5970): Add hwmon support
config: i386-randconfig-062-20230913 (https://download.01.org/0day-ci/archive/20230913/202309131847.4GIyTQIO-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131847.4GIyTQIO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131847.4GIyTQIO-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/regulator/max5970-regulator.o: in function `max597x_regulator_probe':
>> drivers/regulator/max5970-regulator.c:606: undefined reference to `devm_hwmon_device_register_with_info'


vim +606 drivers/regulator/max5970-regulator.c

   541	
   542	static int max597x_regulator_probe(struct platform_device *pdev)
   543	{
   544		struct max5970_data *max597x;
   545		struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
   546		struct max5970_regulator *data;
   547		struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
   548		struct regulator_config config = { };
   549		struct regulator_dev *rdev;
   550		struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
   551		struct device *hwmon_dev;
   552		int num_switches;
   553		int ret, i;
   554	
   555		if (!regmap)
   556			return -EPROBE_DEFER;
   557	
   558		max597x = devm_kzalloc(&i2c->dev, sizeof(struct max5970_data), GFP_KERNEL);
   559		if (!max597x)
   560			return -ENOMEM;
   561	
   562		i2c_set_clientdata(i2c, max597x);
   563	
   564		if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
   565			max597x->num_switches = MAX5978_NUM_SWITCHES;
   566		else if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5970"))
   567			max597x->num_switches = MAX5970_NUM_SWITCHES;
   568		else
   569			return -ENODEV;
   570	
   571		i2c_set_clientdata(i2c, max597x);
   572		num_switches = max597x->num_switches;
   573	
   574		for (i = 0; i < num_switches; i++) {
   575			data =
   576			    devm_kzalloc(&i2c->dev, sizeof(struct max5970_regulator),
   577					 GFP_KERNEL);
   578			if (!data)
   579				return -ENOMEM;
   580	
   581			data->num_switches = num_switches;
   582			data->regmap = regmap;
   583	
   584			ret = max597x_adc_range(regmap, i, &max597x->irng[i], &max597x->mon_rng[i]);
   585			if (ret < 0)
   586				return ret;
   587	
   588			data->irng = max597x->irng[i];
   589			data->mon_rng = max597x->mon_rng[i];
   590	
   591			config.dev = &i2c->dev;
   592			config.driver_data = (void *)data;
   593			config.regmap = data->regmap;
   594			rdev = devm_regulator_register(&i2c->dev,
   595						       &regulators[i], &config);
   596			if (IS_ERR(rdev)) {
   597				dev_err(&i2c->dev, "failed to register regulator %s\n",
   598					regulators[i].name);
   599				return PTR_ERR(rdev);
   600			}
   601			rdevs[i] = rdev;
   602			max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
   603		}
   604	
   605		if (IS_ENABLED(CONFIG_HWMON)) {
 > 606			hwmon_dev = devm_hwmon_device_register_with_info(&i2c->dev, "max5970", max597x,
   607									 &max5970_chip_info, NULL);
   608			if (IS_ERR(hwmon_dev)) {
   609				return dev_err_probe(&i2c->dev, PTR_ERR(hwmon_dev),
   610						     "Unable to register hwmon device\n");
   611			}
   612		}
   613	
   614		if (i2c->irq) {
   615			ret =
   616			    max597x_setup_irq(&i2c->dev, i2c->irq, rdevs, num_switches,
   617					      data);
   618			if (ret) {
   619				dev_err(&i2c->dev, "IRQ setup failed");
   620				return ret;
   621			}
   622		}
   623	
   624		return ret;
   625	}
   626	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
