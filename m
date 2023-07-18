Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3450275819D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjGRQCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjGRQCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:02:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB7EE47;
        Tue, 18 Jul 2023 09:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689696134; x=1721232134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b+DeZ+OCyoCHmI9m5HFUYJ01CoX39Nf1WDBzq10ijV8=;
  b=iHdR4TygYVdEctQKcoZIPgXfn1cG+z0OyBeQprNEwqN4GJJWM1S6bSXF
   H84vdSDyh8Q7U1EyPPyIJOBs5lq/lphhhXgd9zfmaEbfqSU8IoDR4cjqJ
   O4HOwgk2yu/XIKBRcxDsEOlEjjD6vwuung8SfGb8OWU1cnzJ/ed4Udbxt
   NxCA1eLR+YmM/4ez1HXw3ot+T1eCIUX5kI0uES+5lfpLr29r/u0nRMRYY
   YkZgp6uVojP9oJBburi7gMJ83udu+UGAanH7lOEDAJB0HGOKBR5KqWeo9
   wTRxW8YC6VA9Ue2ze3RByoYdaFa/nRrwIvAFNDI+HzRP2Qgdh/xAJ5RBV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="368886969"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="368886969"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 09:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="753379195"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="753379195"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2023 09:00:47 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLn82-0000hi-0u;
        Tue, 18 Jul 2023 16:00:46 +0000
Date:   Wed, 19 Jul 2023 00:00:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v2 1/3] gpio: bcm-kona: Make driver OF-independent
Message-ID: <202307182321.w0jEsUc4-lkp@intel.com>
References: <20230717141845.41415-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717141845.41415-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on brgl/gpio/for-next]
[also build test ERROR on linus/master v6.5-rc2 next-20230718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/gpio-bcm-kona-remove-unneeded-platform_set_drvdata-call/20230718-174129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230717141845.41415-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v2 1/3] gpio: bcm-kona: Make driver OF-independent
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230718/202307182321.w0jEsUc4-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230718/202307182321.w0jEsUc4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307182321.w0jEsUc4-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/gpio/gpio-bcm-kona.c: In function 'bcm_kona_gpio_set_debounce':
>> drivers/gpio/gpio-bcm-kona.c:266:17: error: implicit declaration of function 'dev_err' [-Werror=implicit-function-declaration]
     266 |                 dev_err(chip->parent, "Debounce value %u not in range\n",
         |                 ^~~~~~~
   drivers/gpio/gpio-bcm-kona.c: In function 'bcm_kona_gpio_probe':
>> drivers/gpio/gpio-bcm-kona.c:559:35: error: invalid use of undefined type 'struct platform_device'
     559 |         struct device *dev = &pdev->dev;
         |                                   ^~
>> drivers/gpio/gpio-bcm-kona.c:566:21: error: implicit declaration of function 'devm_kzalloc' [-Werror=implicit-function-declaration]
     566 |         kona_gpio = devm_kzalloc(dev, sizeof(*kona_gpio), GFP_KERNEL);
         |                     ^~~~~~~~~~~~
>> drivers/gpio/gpio-bcm-kona.c:566:19: warning: assignment to 'struct bcm_kona_gpio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     566 |         kona_gpio = devm_kzalloc(dev, sizeof(*kona_gpio), GFP_KERNEL);
         |                   ^
>> drivers/gpio/gpio-bcm-kona.c:572:15: error: implicit declaration of function 'platform_irq_count' [-Werror=implicit-function-declaration]
     572 |         ret = platform_irq_count(pdev);
         |               ^~~~~~~~~~~~~~~~~~
>> drivers/gpio/gpio-bcm-kona.c:577:24: error: implicit declaration of function 'dev_err_probe' [-Werror=implicit-function-declaration]
     577 |                 return dev_err_probe(dev, ret, "Couldn't determine GPIO banks\n");
         |                        ^~~~~~~~~~~~~
>> drivers/gpio/gpio-bcm-kona.c:586:28: error: implicit declaration of function 'devm_kcalloc' [-Werror=implicit-function-declaration]
     586 |         kona_gpio->banks = devm_kcalloc(dev,
         |                            ^~~~~~~~~~~~
>> drivers/gpio/gpio-bcm-kona.c:586:26: warning: assignment to 'struct bcm_kona_gpio_bank *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     586 |         kona_gpio->banks = devm_kcalloc(dev,
         |                          ^
   drivers/gpio/gpio-bcm-kona.c:594:9: error: implicit declaration of function 'platform_set_drvdata' [-Werror=implicit-function-declaration]
     594 |         platform_set_drvdata(pdev, kona_gpio);
         |         ^~~~~~~~~~~~~~~~~~~~
>> drivers/gpio/gpio-bcm-kona.c:607:31: error: implicit declaration of function 'devm_platform_ioremap_resource' [-Werror=implicit-function-declaration]
     607 |         kona_gpio->reg_base = devm_platform_ioremap_resource(pdev, 0);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpio/gpio-bcm-kona.c:607:29: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     607 |         kona_gpio->reg_base = devm_platform_ioremap_resource(pdev, 0);
         |                             ^
>> drivers/gpio/gpio-bcm-kona.c:616:29: error: implicit declaration of function 'platform_get_irq' [-Werror=implicit-function-declaration]
     616 |                 bank->irq = platform_get_irq(pdev, i);
         |                             ^~~~~~~~~~~~~~~~
>> drivers/gpio/gpio-bcm-kona.c:625:9: error: implicit declaration of function 'dev_info' [-Werror=implicit-function-declaration]
     625 |         dev_info(&pdev->dev, "Setting up Kona GPIO\n");
         |         ^~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:625:23: error: invalid use of undefined type 'struct platform_device'
     625 |         dev_info(&pdev->dev, "Setting up Kona GPIO\n");
         |                       ^~
   drivers/gpio/gpio-bcm-kona.c: At top level:
>> drivers/gpio/gpio-bcm-kona.c:651:15: error: variable 'bcm_kona_gpio_driver' has initializer but incomplete type
     651 | static struct platform_driver bcm_kona_gpio_driver = {
         |               ^~~~~~~~~~~~~~~
>> drivers/gpio/gpio-bcm-kona.c:652:10: error: 'struct platform_driver' has no member named 'driver'
     652 |         .driver = {
         |          ^~~~~~
>> drivers/gpio/gpio-bcm-kona.c:652:19: error: extra brace group at end of initializer
     652 |         .driver = {
         |                   ^
   drivers/gpio/gpio-bcm-kona.c:652:19: note: (near initialization for 'bcm_kona_gpio_driver')
>> drivers/gpio/gpio-bcm-kona.c:652:19: warning: excess elements in struct initializer
   drivers/gpio/gpio-bcm-kona.c:652:19: note: (near initialization for 'bcm_kona_gpio_driver')
>> drivers/gpio/gpio-bcm-kona.c:656:10: error: 'struct platform_driver' has no member named 'probe'
     656 |         .probe = bcm_kona_gpio_probe,
         |          ^~~~~
   drivers/gpio/gpio-bcm-kona.c:656:18: warning: excess elements in struct initializer
     656 |         .probe = bcm_kona_gpio_probe,
         |                  ^~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:656:18: note: (near initialization for 'bcm_kona_gpio_driver')
>> drivers/gpio/gpio-bcm-kona.c:658:1: warning: data definition has no type or storage class
     658 | builtin_platform_driver(bcm_kona_gpio_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpio/gpio-bcm-kona.c:658:1: error: type defaults to 'int' in declaration of 'builtin_platform_driver' [-Werror=implicit-int]
>> drivers/gpio/gpio-bcm-kona.c:658:1: warning: parameter names (without types) in function declaration
   drivers/gpio/gpio-bcm-kona.c:651:31: error: storage size of 'bcm_kona_gpio_driver' isn't known
     651 | static struct platform_driver bcm_kona_gpio_driver = {
         |                               ^~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:651:31: warning: 'bcm_kona_gpio_driver' defined but not used [-Wunused-variable]
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SM_GCC_8350
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
   Selected by [m]:
   - SM_VIDEOCC_8350 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   WARNING: unmet direct dependencies detected for SM_GCC_8450
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
   Selected by [m]:
   - SM_GPUCC_8450 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   - SM_VIDEOCC_8450 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   WARNING: unmet direct dependencies detected for SM_GCC_8550
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
   Selected by [m]:
   - SM_GPUCC_8550 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   - SM_VIDEOCC_8550 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]


vim +/dev_err +266 drivers/gpio/gpio-bcm-kona.c

757651e3d60e5b Markus Mayer     2013-09-10  253  
757651e3d60e5b Markus Mayer     2013-09-10  254  static int bcm_kona_gpio_set_debounce(struct gpio_chip *chip, unsigned gpio,
757651e3d60e5b Markus Mayer     2013-09-10  255  				      unsigned debounce)
757651e3d60e5b Markus Mayer     2013-09-10  256  {
757651e3d60e5b Markus Mayer     2013-09-10  257  	struct bcm_kona_gpio *kona_gpio;
757651e3d60e5b Markus Mayer     2013-09-10  258  	void __iomem *reg_base;
757651e3d60e5b Markus Mayer     2013-09-10  259  	u32 val, res;
757651e3d60e5b Markus Mayer     2013-09-10  260  	unsigned long flags;
757651e3d60e5b Markus Mayer     2013-09-10  261  
ba4a74485a32c1 Linus Walleij    2015-12-04  262  	kona_gpio = gpiochip_get_data(chip);
757651e3d60e5b Markus Mayer     2013-09-10  263  	reg_base = kona_gpio->reg_base;
757651e3d60e5b Markus Mayer     2013-09-10  264  	/* debounce must be 1-128ms (or 0) */
757651e3d60e5b Markus Mayer     2013-09-10  265  	if ((debounce > 0 && debounce < 1000) || debounce > 128000) {
58383c78425e4e Linus Walleij    2015-11-04 @266  		dev_err(chip->parent, "Debounce value %u not in range\n",
757651e3d60e5b Markus Mayer     2013-09-10  267  			debounce);
757651e3d60e5b Markus Mayer     2013-09-10  268  		return -EINVAL;
757651e3d60e5b Markus Mayer     2013-09-10  269  	}
757651e3d60e5b Markus Mayer     2013-09-10  270  
757651e3d60e5b Markus Mayer     2013-09-10  271  	/* calculate debounce bit value */
757651e3d60e5b Markus Mayer     2013-09-10  272  	if (debounce != 0) {
757651e3d60e5b Markus Mayer     2013-09-10  273  		/* Convert to ms */
757651e3d60e5b Markus Mayer     2013-09-10  274  		debounce /= 1000;
757651e3d60e5b Markus Mayer     2013-09-10  275  		/* find the MSB */
757651e3d60e5b Markus Mayer     2013-09-10  276  		res = fls(debounce) - 1;
757651e3d60e5b Markus Mayer     2013-09-10  277  		/* Check if MSB-1 is set (round up or down) */
757651e3d60e5b Markus Mayer     2013-09-10  278  		if (res > 0 && (debounce & BIT(res - 1)))
757651e3d60e5b Markus Mayer     2013-09-10  279  			res++;
757651e3d60e5b Markus Mayer     2013-09-10  280  	}
757651e3d60e5b Markus Mayer     2013-09-10  281  
757651e3d60e5b Markus Mayer     2013-09-10  282  	/* spin lock for read-modify-write of the GPIO register */
c69fcea57e9d2b Julia Cartwright 2017-03-09  283  	raw_spin_lock_irqsave(&kona_gpio->lock, flags);
757651e3d60e5b Markus Mayer     2013-09-10  284  
757651e3d60e5b Markus Mayer     2013-09-10  285  	val = readl(reg_base + GPIO_CONTROL(gpio));
757651e3d60e5b Markus Mayer     2013-09-10  286  	val &= ~GPIO_GPCTR0_DBR_MASK;
757651e3d60e5b Markus Mayer     2013-09-10  287  
757651e3d60e5b Markus Mayer     2013-09-10  288  	if (debounce == 0) {
757651e3d60e5b Markus Mayer     2013-09-10  289  		/* disable debounce */
757651e3d60e5b Markus Mayer     2013-09-10  290  		val &= ~GPIO_GPCTR0_DB_ENABLE_MASK;
757651e3d60e5b Markus Mayer     2013-09-10  291  	} else {
757651e3d60e5b Markus Mayer     2013-09-10  292  		val |= GPIO_GPCTR0_DB_ENABLE_MASK |
757651e3d60e5b Markus Mayer     2013-09-10  293  		    (res << GPIO_GPCTR0_DBR_SHIFT);
757651e3d60e5b Markus Mayer     2013-09-10  294  	}
757651e3d60e5b Markus Mayer     2013-09-10  295  
757651e3d60e5b Markus Mayer     2013-09-10  296  	writel(val, reg_base + GPIO_CONTROL(gpio));
757651e3d60e5b Markus Mayer     2013-09-10  297  
c69fcea57e9d2b Julia Cartwright 2017-03-09  298  	raw_spin_unlock_irqrestore(&kona_gpio->lock, flags);
757651e3d60e5b Markus Mayer     2013-09-10  299  
757651e3d60e5b Markus Mayer     2013-09-10  300  	return 0;
757651e3d60e5b Markus Mayer     2013-09-10  301  }
757651e3d60e5b Markus Mayer     2013-09-10  302  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
