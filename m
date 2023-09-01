Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB37790085
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbjIAQKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343563AbjIAQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:10:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEC710FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693584604; x=1725120604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vBAktnUi0o0BHaeb5256ThaPz1rbiTdY7sYPaXZQ2kE=;
  b=QjYljGvX/8FBXij81NEQKqQvVPz7Vd+cFh2hycyi4qnFGyntmgbA5gsZ
   RHk09OxfT9Lgj8jtOwJZbofp4IK0+LNuRlzCJAtDTKK4cEYFOfZNVrqrB
   IfY4dH8pdglfIHYsglKF9eN43BlSCOBxHFnay0ga+y4WKIg1UrZxQ7Xpo
   DTwcRvOVRjYuS9iEUiNc4bzx1M58NYlTdYaYez6jW40b4f9eFx4ikDpLK
   WUyAqj6Mq4CLvLHQGuJzM/J73FEwnJxAPhtfl/0xY8af7LvtpfdOL4pG/
   zYtC/5qxJxQSLNZJmH0hZbZ3GUdWj8yGiLEBkoCVFXLNW5CEcGKzj/36x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356561708"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="356561708"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 09:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854762624"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="854762624"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2023 09:09:45 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qc6iN-0001Rd-25;
        Fri, 01 Sep 2023 16:09:43 +0000
Date:   Sat, 2 Sep 2023 00:09:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] regulator/core: remove regulator_init callback
Message-ID: <202309012355.YuIQ9kqC-lkp@intel.com>
References: <67b78825385762957b121db2c5d71b119517a7ce.1693431144.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67b78825385762957b121db2c5d71b119517a7ce.1693431144.git.mirq-linux@rere.qmqm.pl>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michał,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-regulator/for-next]
[also build test ERROR on linus/master v6.5 next-20230831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Micha-Miros-aw/regulator-core-_regulator_get-simplify-error-returns/20230831-065946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/67b78825385762957b121db2c5d71b119517a7ce.1693431144.git.mirq-linux%40rere.qmqm.pl
patch subject: [PATCH 6/9] regulator/core: remove regulator_init callback
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20230901/202309012355.YuIQ9kqC-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230901/202309012355.YuIQ9kqC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309012355.YuIQ9kqC-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/regulator/core.c: In function 'regulator_register':
>> drivers/regulator/core.c:5609:35: error: 'const struct regulator_init_data' has no member named 'regulator_init'
    5609 |         if (init_data && init_data->regulator_init) {
         |                                   ^~
   drivers/regulator/core.c:5610:32: error: 'const struct regulator_init_data' has no member named 'regulator_init'
    5610 |                 ret = init_data->regulator_init(rdev->reg_data);
         |                                ^~


vim +5609 drivers/regulator/core.c

d8ca7d184b33af Dmitry Osipenko          2019-06-24  5446  
414c70cb91c445 Liam Girdwood            2008-04-30  5447  /**
414c70cb91c445 Liam Girdwood            2008-04-30  5448   * regulator_register - register regulator
8f3cbcd6b44003 ChiYuan Huang            2022-12-06  5449   * @dev: the device that drive the regulator
69279fb9a95051 Mark Brown               2008-12-31  5450   * @regulator_desc: regulator to register
f47531b1aa86e0 Krzysztof Kozlowski      2015-01-12  5451   * @cfg: runtime configuration for regulator
414c70cb91c445 Liam Girdwood            2008-04-30  5452   *
414c70cb91c445 Liam Girdwood            2008-04-30  5453   * Called by regulator drivers to register a regulator.
0384618a79ccfa Axel Lin                 2013-01-03  5454   * Returns a valid pointer to struct regulator_dev on success
0384618a79ccfa Axel Lin                 2013-01-03  5455   * or an ERR_PTR() on error.
414c70cb91c445 Liam Girdwood            2008-04-30  5456   */
65f26846b90611 Mark Brown               2012-04-03  5457  struct regulator_dev *
8f3cbcd6b44003 ChiYuan Huang            2022-12-06  5458  regulator_register(struct device *dev,
8f3cbcd6b44003 ChiYuan Huang            2022-12-06  5459  		   const struct regulator_desc *regulator_desc,
1b3de223385d6b Krzysztof Kozlowski      2015-01-05  5460  		   const struct regulator_config *cfg)
414c70cb91c445 Liam Girdwood            2008-04-30  5461  {
c172708d38a401 Mark Brown               2012-04-04  5462  	const struct regulator_init_data *init_data;
1b3de223385d6b Krzysztof Kozlowski      2015-01-05  5463  	struct regulator_config *config = NULL;
72dca06f62c504 Aniroop Mathur           2014-12-28  5464  	static atomic_t regulator_no = ATOMIC_INIT(-1);
414c70cb91c445 Liam Girdwood            2008-04-30  5465  	struct regulator_dev *rdev;
0edb040d416ab3 Linus Walleij            2018-12-06  5466  	bool dangling_cfg_gpiod = false;
0edb040d416ab3 Linus Walleij            2018-12-06  5467  	bool dangling_of_gpiod = false;
a5766f11cfd3a0 Liam Girdwood            2008-10-10  5468  	int ret, i;
520fb178212d1d Christian Kohlschütter   2022-08-29  5469  	bool resolved_early = false;
414c70cb91c445 Liam Girdwood            2008-04-30  5470  
0edb040d416ab3 Linus Walleij            2018-12-06  5471  	if (cfg == NULL)
414c70cb91c445 Liam Girdwood            2008-04-30  5472  		return ERR_PTR(-EINVAL);
0edb040d416ab3 Linus Walleij            2018-12-06  5473  	if (cfg->ena_gpiod)
0edb040d416ab3 Linus Walleij            2018-12-06  5474  		dangling_cfg_gpiod = true;
0edb040d416ab3 Linus Walleij            2018-12-06  5475  	if (regulator_desc == NULL) {
0edb040d416ab3 Linus Walleij            2018-12-06  5476  		ret = -EINVAL;
0edb040d416ab3 Linus Walleij            2018-12-06  5477  		goto rinse;
0edb040d416ab3 Linus Walleij            2018-12-06  5478  	}
414c70cb91c445 Liam Girdwood            2008-04-30  5479  
8f3cbcd6b44003 ChiYuan Huang            2022-12-06  5480  	WARN_ON(!dev || !cfg->dev);
32c8fad438200b Mark Brown               2012-04-11  5481  
0edb040d416ab3 Linus Walleij            2018-12-06  5482  	if (regulator_desc->name == NULL || regulator_desc->ops == NULL) {
0edb040d416ab3 Linus Walleij            2018-12-06  5483  		ret = -EINVAL;
0edb040d416ab3 Linus Walleij            2018-12-06  5484  		goto rinse;
0edb040d416ab3 Linus Walleij            2018-12-06  5485  	}
414c70cb91c445 Liam Girdwood            2008-04-30  5486  
cd78dfc6c6e321 Diego Liziero            2009-04-14  5487  	if (regulator_desc->type != REGULATOR_VOLTAGE &&
0edb040d416ab3 Linus Walleij            2018-12-06  5488  	    regulator_desc->type != REGULATOR_CURRENT) {
0edb040d416ab3 Linus Walleij            2018-12-06  5489  		ret = -EINVAL;
0edb040d416ab3 Linus Walleij            2018-12-06  5490  		goto rinse;
0edb040d416ab3 Linus Walleij            2018-12-06  5491  	}
414c70cb91c445 Liam Girdwood            2008-04-30  5492  
476c2d83c7ffb2 Mark Brown               2010-12-10  5493  	/* Only one of each should be implemented */
476c2d83c7ffb2 Mark Brown               2010-12-10  5494  	WARN_ON(regulator_desc->ops->get_voltage &&
476c2d83c7ffb2 Mark Brown               2010-12-10  5495  		regulator_desc->ops->get_voltage_sel);
e8eef82b2c652d Mark Brown               2010-12-12  5496  	WARN_ON(regulator_desc->ops->set_voltage &&
e8eef82b2c652d Mark Brown               2010-12-12  5497  		regulator_desc->ops->set_voltage_sel);
476c2d83c7ffb2 Mark Brown               2010-12-10  5498  
476c2d83c7ffb2 Mark Brown               2010-12-10  5499  	/* If we're using selectors we must implement list_voltage. */
476c2d83c7ffb2 Mark Brown               2010-12-10  5500  	if (regulator_desc->ops->get_voltage_sel &&
476c2d83c7ffb2 Mark Brown               2010-12-10  5501  	    !regulator_desc->ops->list_voltage) {
0edb040d416ab3 Linus Walleij            2018-12-06  5502  		ret = -EINVAL;
0edb040d416ab3 Linus Walleij            2018-12-06  5503  		goto rinse;
476c2d83c7ffb2 Mark Brown               2010-12-10  5504  	}
e8eef82b2c652d Mark Brown               2010-12-12  5505  	if (regulator_desc->ops->set_voltage_sel &&
e8eef82b2c652d Mark Brown               2010-12-12  5506  	    !regulator_desc->ops->list_voltage) {
0edb040d416ab3 Linus Walleij            2018-12-06  5507  		ret = -EINVAL;
0edb040d416ab3 Linus Walleij            2018-12-06  5508  		goto rinse;
e8eef82b2c652d Mark Brown               2010-12-12  5509  	}
476c2d83c7ffb2 Mark Brown               2010-12-10  5510  
414c70cb91c445 Liam Girdwood            2008-04-30  5511  	rdev = kzalloc(sizeof(struct regulator_dev), GFP_KERNEL);
0edb040d416ab3 Linus Walleij            2018-12-06  5512  	if (rdev == NULL) {
0edb040d416ab3 Linus Walleij            2018-12-06  5513  		ret = -ENOMEM;
0edb040d416ab3 Linus Walleij            2018-12-06  5514  		goto rinse;
0edb040d416ab3 Linus Walleij            2018-12-06  5515  	}
d3c731564e09b6 Michał Mirosław          2020-08-12  5516  	device_initialize(&rdev->dev);
7111c6d1b31b42 Matti Vaittinen          2021-06-03  5517  	spin_lock_init(&rdev->err_lock);
414c70cb91c445 Liam Girdwood            2008-04-30  5518  
1b3de223385d6b Krzysztof Kozlowski      2015-01-05  5519  	/*
1b3de223385d6b Krzysztof Kozlowski      2015-01-05  5520  	 * Duplicate the config so the driver could override it after
1b3de223385d6b Krzysztof Kozlowski      2015-01-05  5521  	 * parsing init data.
1b3de223385d6b Krzysztof Kozlowski      2015-01-05  5522  	 */
1b3de223385d6b Krzysztof Kozlowski      2015-01-05  5523  	config = kmemdup(cfg, sizeof(*cfg), GFP_KERNEL);
1b3de223385d6b Krzysztof Kozlowski      2015-01-05  5524  	if (config == NULL) {
0edb040d416ab3 Linus Walleij            2018-12-06  5525  		ret = -ENOMEM;
d3c731564e09b6 Michał Mirosław          2020-08-12  5526  		goto clean;
1b3de223385d6b Krzysztof Kozlowski      2015-01-05  5527  	}
1b3de223385d6b Krzysztof Kozlowski      2015-01-05  5528  
bfa21a0dfe6915 Krzysztof Kozlowski      2015-01-05  5529  	init_data = regulator_of_get_init_data(dev, regulator_desc, config,
a0c7b164ad115e Mark Brown               2014-09-09  5530  					       &rdev->dev.of_node);
f8970d341eec73 Marco Felsch             2019-09-17  5531  
f8970d341eec73 Marco Felsch             2019-09-17  5532  	/*
f8970d341eec73 Marco Felsch             2019-09-17  5533  	 * Sometimes not all resources are probed already so we need to take
f8970d341eec73 Marco Felsch             2019-09-17  5534  	 * that into account. This happens most the time if the ena_gpiod comes
f8970d341eec73 Marco Felsch             2019-09-17  5535  	 * from a gpio extender or something else.
f8970d341eec73 Marco Felsch             2019-09-17  5536  	 */
f8970d341eec73 Marco Felsch             2019-09-17  5537  	if (PTR_ERR(init_data) == -EPROBE_DEFER) {
f8970d341eec73 Marco Felsch             2019-09-17  5538  		ret = -EPROBE_DEFER;
d3c731564e09b6 Michał Mirosław          2020-08-12  5539  		goto clean;
f8970d341eec73 Marco Felsch             2019-09-17  5540  	}
f8970d341eec73 Marco Felsch             2019-09-17  5541  
0edb040d416ab3 Linus Walleij            2018-12-06  5542  	/*
0edb040d416ab3 Linus Walleij            2018-12-06  5543  	 * We need to keep track of any GPIO descriptor coming from the
0edb040d416ab3 Linus Walleij            2018-12-06  5544  	 * device tree until we have handled it over to the core. If the
0edb040d416ab3 Linus Walleij            2018-12-06  5545  	 * config that was passed in to this function DOES NOT contain
0edb040d416ab3 Linus Walleij            2018-12-06  5546  	 * a descriptor, and the config after this call DOES contain
48f1b4efd67c92 Krzysztof Kozlowski      2019-01-08  5547  	 * a descriptor, we definitely got one from parsing the device
0edb040d416ab3 Linus Walleij            2018-12-06  5548  	 * tree.
0edb040d416ab3 Linus Walleij            2018-12-06  5549  	 */
0edb040d416ab3 Linus Walleij            2018-12-06  5550  	if (!cfg->ena_gpiod && config->ena_gpiod)
0edb040d416ab3 Linus Walleij            2018-12-06  5551  		dangling_of_gpiod = true;
a0c7b164ad115e Mark Brown               2014-09-09  5552  	if (!init_data) {
a0c7b164ad115e Mark Brown               2014-09-09  5553  		init_data = config->init_data;
a0c7b164ad115e Mark Brown               2014-09-09  5554  		rdev->dev.of_node = of_node_get(config->of_node);
a0c7b164ad115e Mark Brown               2014-09-09  5555  	}
a0c7b164ad115e Mark Brown               2014-09-09  5556  
f8702f9e4aa7b4 Dmitry Osipenko          2018-11-19  5557  	ww_mutex_init(&rdev->mutex, &regulator_ww_class);
c172708d38a401 Mark Brown               2012-04-04  5558  	rdev->reg_data = config->driver_data;
414c70cb91c445 Liam Girdwood            2008-04-30  5559  	rdev->owner = regulator_desc->owner;
414c70cb91c445 Liam Girdwood            2008-04-30  5560  	rdev->desc = regulator_desc;
3a4b0a07fa69cb Mark Brown               2012-05-08  5561  	if (config->regmap)
65b19ce6c22328 Mark Brown               2012-04-15  5562  		rdev->regmap = config->regmap;
52b84dac436a68 AnilKumar Ch             2012-09-07  5563  	else if (dev_get_regmap(dev, NULL))
3a4b0a07fa69cb Mark Brown               2012-05-08  5564  		rdev->regmap = dev_get_regmap(dev, NULL);
52b84dac436a68 AnilKumar Ch             2012-09-07  5565  	else if (dev->parent)
52b84dac436a68 AnilKumar Ch             2012-09-07  5566  		rdev->regmap = dev_get_regmap(dev->parent, NULL);
414c70cb91c445 Liam Girdwood            2008-04-30  5567  	INIT_LIST_HEAD(&rdev->consumer_list);
414c70cb91c445 Liam Girdwood            2008-04-30  5568  	INIT_LIST_HEAD(&rdev->list);
414c70cb91c445 Liam Girdwood            2008-04-30  5569  	BLOCKING_INIT_NOTIFIER_HEAD(&rdev->notifier);
da07ecd93b1968 Mark Brown               2011-09-11  5570  	INIT_DELAYED_WORK(&rdev->disable_work, regulator_disable_work);
414c70cb91c445 Liam Girdwood            2008-04-30  5571  
520fb178212d1d Christian Kohlschütter   2022-08-29  5572  	if (init_data && init_data->supply_regulator)
520fb178212d1d Christian Kohlschütter   2022-08-29  5573  		rdev->supply_name = init_data->supply_regulator;
520fb178212d1d Christian Kohlschütter   2022-08-29  5574  	else if (regulator_desc->supply_name)
520fb178212d1d Christian Kohlschütter   2022-08-29  5575  		rdev->supply_name = regulator_desc->supply_name;
daad134d66492a Krzysztof Adamski        2016-02-22  5576  
a5766f11cfd3a0 Liam Girdwood            2008-10-10  5577  	/* register with sysfs */
a5766f11cfd3a0 Liam Girdwood            2008-10-10  5578  	rdev->dev.class = &regulator_class;
0debed5b117d11 ChiYuan Huang            2022-12-14  5579  	rdev->dev.parent = config->dev;
72dca06f62c504 Aniroop Mathur           2014-12-28  5580  	dev_set_name(&rdev->dev, "regulator.%lu",
39138818a4f5c6 Aniroop Mathur           2014-12-29  5581  		    (unsigned long) atomic_inc_return(&regulator_no));
9177514ce34902 Vladimir Zapolskiy       2020-07-24  5582  	dev_set_drvdata(&rdev->dev, rdev);
414c70cb91c445 Liam Girdwood            2008-04-30  5583  
74f544c1fc0339 Mike Rapoport            2008-11-25  5584  	/* set regulator constraints */
9a8f5e07200dd8 Mark Brown               2011-11-29  5585  	if (init_data)
57a6ad482af256 Michał Mirosław          2020-11-13  5586  		rdev->constraints = kmemdup(&init_data->constraints,
57a6ad482af256 Michał Mirosław          2020-11-13  5587  					    sizeof(*rdev->constraints),
57a6ad482af256 Michał Mirosław          2020-11-13  5588  					    GFP_KERNEL);
57a6ad482af256 Michał Mirosław          2020-11-13  5589  	else
57a6ad482af256 Michał Mirosław          2020-11-13  5590  		rdev->constraints = kzalloc(sizeof(*rdev->constraints),
57a6ad482af256 Michał Mirosław          2020-11-13  5591  					    GFP_KERNEL);
57a6ad482af256 Michał Mirosław          2020-11-13  5592  	if (!rdev->constraints) {
57a6ad482af256 Michał Mirosław          2020-11-13  5593  		ret = -ENOMEM;
57a6ad482af256 Michał Mirosław          2020-11-13  5594  		goto wash;
57a6ad482af256 Michał Mirosław          2020-11-13  5595  	}
9a8f5e07200dd8 Mark Brown               2011-11-29  5596  
8a866d527ac044 Christian Kohlschütter   2022-08-18  5597  	if ((rdev->supply_name && !rdev->supply) &&
8a866d527ac044 Christian Kohlschütter   2022-08-18  5598  		(rdev->constraints->always_on ||
8a866d527ac044 Christian Kohlschütter   2022-08-18  5599  		 rdev->constraints->boot_on)) {
8a866d527ac044 Christian Kohlschütter   2022-08-18  5600  		ret = regulator_resolve_supply(rdev);
8a866d527ac044 Christian Kohlschütter   2022-08-18  5601  		if (ret)
8a866d527ac044 Christian Kohlschütter   2022-08-18  5602  			rdev_dbg(rdev, "unable to resolve supply early: %pe\n",
8a866d527ac044 Christian Kohlschütter   2022-08-18  5603  					 ERR_PTR(ret));
520fb178212d1d Christian Kohlschütter   2022-08-29  5604  
520fb178212d1d Christian Kohlschütter   2022-08-29  5605  		resolved_early = true;
8a866d527ac044 Christian Kohlschütter   2022-08-18  5606  	}
8a866d527ac044 Christian Kohlschütter   2022-08-18  5607  
8a866d527ac044 Christian Kohlschütter   2022-08-18  5608  	/* perform any regulator specific init */
9a8f5e07200dd8 Mark Brown               2011-11-29 @5609  	if (init_data && init_data->regulator_init) {
a5766f11cfd3a0 Liam Girdwood            2008-10-10  5610  		ret = init_data->regulator_init(rdev->reg_data);
4fca9545d17b99 David Brownell           2008-11-11  5611  		if (ret < 0)
520fb178212d1d Christian Kohlschütter   2022-08-29  5612  			goto wash;
414c70cb91c445 Liam Girdwood            2008-04-30  5613  	}
414c70cb91c445 Liam Girdwood            2008-04-30  5614  
541d052d721506 Linus Walleij            2019-01-29  5615  	if (config->ena_gpiod) {
daad134d66492a Krzysztof Adamski        2016-02-22  5616  		ret = regulator_ena_gpio_request(rdev, config);
daad134d66492a Krzysztof Adamski        2016-02-22  5617  		if (ret != 0) {
61aab5ad27d551 Michał Mirosław          2020-09-26  5618  			rdev_err(rdev, "Failed to request enable GPIO: %pe\n",
61aab5ad27d551 Michał Mirosław          2020-09-26  5619  				 ERR_PTR(ret));
520fb178212d1d Christian Kohlschütter   2022-08-29  5620  			goto wash;
daad134d66492a Krzysztof Adamski        2016-02-22  5621  		}
0edb040d416ab3 Linus Walleij            2018-12-06  5622  		/* The regulator core took over the GPIO descriptor */
0edb040d416ab3 Linus Walleij            2018-12-06  5623  		dangling_cfg_gpiod = false;
0edb040d416ab3 Linus Walleij            2018-12-06  5624  		dangling_of_gpiod = false;
daad134d66492a Krzysztof Adamski        2016-02-22  5625  	}
0178f3e28e2166 Mark Brown               2010-04-26  5626  
57a6ad482af256 Michał Mirosław          2020-11-13  5627  	ret = set_machine_constraints(rdev);
520fb178212d1d Christian Kohlschütter   2022-08-29  5628  	if (ret == -EPROBE_DEFER && !resolved_early) {
aea6cb99703e17 Michał Mirosław          2020-09-26  5629  		/* Regulator might be in bypass mode and so needs its supply
69b8821e293aa8 Shubhankar Kuranagatti   2021-04-20  5630  		 * to set the constraints
69b8821e293aa8 Shubhankar Kuranagatti   2021-04-20  5631  		 */
aea6cb99703e17 Michał Mirosław          2020-09-26  5632  		/* FIXME: this currently triggers a chicken-and-egg problem
aea6cb99703e17 Michał Mirosław          2020-09-26  5633  		 * when creating -SUPPLY symlink in sysfs to a regulator
69b8821e293aa8 Shubhankar Kuranagatti   2021-04-20  5634  		 * that is just being created
69b8821e293aa8 Shubhankar Kuranagatti   2021-04-20  5635  		 */
0917c9db23accb Michał Mirosław          2020-11-13  5636  		rdev_dbg(rdev, "will resolve supply early: %s\n",
0917c9db23accb Michał Mirosław          2020-11-13  5637  			 rdev->supply_name);
aea6cb99703e17 Michał Mirosław          2020-09-26  5638  		ret = regulator_resolve_supply(rdev);
aea6cb99703e17 Michał Mirosław          2020-09-26  5639  		if (!ret)
57a6ad482af256 Michał Mirosław          2020-11-13  5640  			ret = set_machine_constraints(rdev);
aea6cb99703e17 Michał Mirosław          2020-09-26  5641  		else
aea6cb99703e17 Michał Mirosław          2020-09-26  5642  			rdev_dbg(rdev, "unable to resolve supply early: %pe\n",
aea6cb99703e17 Michał Mirosław          2020-09-26  5643  				 ERR_PTR(ret));
aea6cb99703e17 Michał Mirosław          2020-09-26  5644  	}
45389c47526d1e Jon Hunter               2016-04-26  5645  	if (ret < 0)
45389c47526d1e Jon Hunter               2016-04-26  5646  		goto wash;
45389c47526d1e Jon Hunter               2016-04-26  5647  
f9503385b1877a Dmitry Osipenko          2018-10-05  5648  	ret = regulator_init_coupling(rdev);
f9503385b1877a Dmitry Osipenko          2018-10-05  5649  	if (ret < 0)
d3d64537c33956 Maciej Purski            2018-04-23  5650  		goto wash;
d3d64537c33956 Maciej Purski            2018-04-23  5651  
a5766f11cfd3a0 Liam Girdwood            2008-10-10  5652  	/* add consumers devices */
9a8f5e07200dd8 Mark Brown               2011-11-29  5653  	if (init_data) {
a5766f11cfd3a0 Liam Girdwood            2008-10-10  5654  		for (i = 0; i < init_data->num_consumer_supplies; i++) {
a5766f11cfd3a0 Liam Girdwood            2008-10-10  5655  			ret = set_consumer_device_supply(rdev,
40f9244f4da897 Mark Brown               2009-06-17  5656  				init_data->consumer_supplies[i].dev_name,
a5766f11cfd3a0 Liam Girdwood            2008-10-10  5657  				init_data->consumer_supplies[i].supply);
23c2f041efa891 Mark Brown               2011-02-24  5658  			if (ret < 0) {
23c2f041efa891 Mark Brown               2011-02-24  5659  				dev_err(dev, "Failed to set supply %s\n",
23c2f041efa891 Mark Brown               2011-02-24  5660  					init_data->consumer_supplies[i].supply);
d4033b54fc9122 Jani Nikula              2010-04-29  5661  				goto unset_supplies;
414c70cb91c445 Liam Girdwood            2008-04-30  5662  			}
23c2f041efa891 Mark Brown               2011-02-24  5663  		}
45389c47526d1e Jon Hunter               2016-04-26  5664  	}
5e3ca2b349b1e2 Javier Martinez Canillas 2016-03-23  5665  
fd086045559d90 Matthias Kaehlcke        2017-03-27  5666  	if (!rdev->desc->ops->get_voltage &&
fd086045559d90 Matthias Kaehlcke        2017-03-27  5667  	    !rdev->desc->ops->list_voltage &&
fd086045559d90 Matthias Kaehlcke        2017-03-27  5668  	    !rdev->desc->fixed_uV)
fd086045559d90 Matthias Kaehlcke        2017-03-27  5669  		rdev->is_switch = true;
fd086045559d90 Matthias Kaehlcke        2017-03-27  5670  
9177514ce34902 Vladimir Zapolskiy       2020-07-24  5671  	ret = device_add(&rdev->dev);
9177514ce34902 Vladimir Zapolskiy       2020-07-24  5672  	if (ret != 0)
c438b9d017362b Jon Hunter               2016-04-21  5673  		goto unset_supplies;
414c70cb91c445 Liam Girdwood            2008-04-30  5674  
1130e5b3ff4a7f Mark Brown               2010-12-21  5675  	rdev_init_debugfs(rdev);
5e3ca2b349b1e2 Javier Martinez Canillas 2016-03-23  5676  
f9503385b1877a Dmitry Osipenko          2018-10-05  5677  	/* try to resolve regulators coupling since a new one was registered */
f9503385b1877a Dmitry Osipenko          2018-10-05  5678  	mutex_lock(&regulator_list_mutex);
f9503385b1877a Dmitry Osipenko          2018-10-05  5679  	regulator_resolve_coupling(rdev);
f9503385b1877a Dmitry Osipenko          2018-10-05  5680  	mutex_unlock(&regulator_list_mutex);
f9503385b1877a Dmitry Osipenko          2018-10-05  5681  
5e3ca2b349b1e2 Javier Martinez Canillas 2016-03-23  5682  	/* try to resolve regulators supply since a new one was registered */
5e3ca2b349b1e2 Javier Martinez Canillas 2016-03-23  5683  	class_for_each_device(&regulator_class, NULL, NULL,
5e3ca2b349b1e2 Javier Martinez Canillas 2016-03-23  5684  			      regulator_register_resolve_supply);
1b3de223385d6b Krzysztof Kozlowski      2015-01-05  5685  	kfree(config);
a5766f11cfd3a0 Liam Girdwood            2008-10-10  5686  	return rdev;
4fca9545d17b99 David Brownell           2008-11-11  5687  
d4033b54fc9122 Jani Nikula              2010-04-29  5688  unset_supplies:
45389c47526d1e Jon Hunter               2016-04-26  5689  	mutex_lock(&regulator_list_mutex);
d4033b54fc9122 Jani Nikula              2010-04-29  5690  	unset_regulator_supplies(rdev);
d8ca7d184b33af Dmitry Osipenko          2019-06-24  5691  	regulator_remove_coupling(rdev);
45389c47526d1e Jon Hunter               2016-04-26  5692  	mutex_unlock(&regulator_list_mutex);
32165230eb6e62 Krzysztof Adamski        2016-02-24  5693  wash:
ba62319a42c50e Yang Yingliang           2022-12-02  5694  	regulator_put(rdev->supply);
26c2c997aa1a6c Dmitry Osipenko          2019-10-25  5695  	kfree(rdev->coupling_desc.coupled_rdevs);
45389c47526d1e Jon Hunter               2016-04-26  5696  	mutex_lock(&regulator_list_mutex);
32165230eb6e62 Krzysztof Adamski        2016-02-24  5697  	regulator_ena_gpio_free(rdev);
45389c47526d1e Jon Hunter               2016-04-26  5698  	mutex_unlock(&regulator_list_mutex);
5f4b204b6b8153 Zeng Heng                2022-11-16  5699  	put_device(&rdev->dev);
5f4b204b6b8153 Zeng Heng                2022-11-16  5700  	rdev = NULL;
4fca9545d17b99 David Brownell           2008-11-11  5701  clean:
0edb040d416ab3 Linus Walleij            2018-12-06  5702  	if (dangling_of_gpiod)
0edb040d416ab3 Linus Walleij            2018-12-06  5703  		gpiod_put(config->ena_gpiod);
5f4b204b6b8153 Zeng Heng                2022-11-16  5704  	if (rdev && rdev->dev.of_node)
5f4b204b6b8153 Zeng Heng                2022-11-16  5705  		of_node_put(rdev->dev.of_node);
5f4b204b6b8153 Zeng Heng                2022-11-16  5706  	kfree(rdev);
a2151374230820 Jon Hunter               2016-03-30  5707  	kfree(config);
0edb040d416ab3 Linus Walleij            2018-12-06  5708  rinse:
0edb040d416ab3 Linus Walleij            2018-12-06  5709  	if (dangling_cfg_gpiod)
0edb040d416ab3 Linus Walleij            2018-12-06  5710  		gpiod_put(cfg->ena_gpiod);
a2151374230820 Jon Hunter               2016-03-30  5711  	return ERR_PTR(ret);
414c70cb91c445 Liam Girdwood            2008-04-30  5712  }
a5766f11cfd3a0 Liam Girdwood            2008-10-10  5713  EXPORT_SYMBOL_GPL(regulator_register);
414c70cb91c445 Liam Girdwood            2008-04-30  5714  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
