Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81540758587
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGRT2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGRT14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:27:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46538198E;
        Tue, 18 Jul 2023 12:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689708475; x=1721244475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WFmOv1NhHPyYrPP4KStlPTHig8yPHia7F/pgr2dspf8=;
  b=TAiSNtGOH1RsjqX/HpC2yIPvcG3PW9qCKv6jQFCGiihJOFu8m/+u2TsQ
   K9PB6FvUdbHhtc+zQ0QRB1Ub7vc54E4ET4ln4buVvX/BHAOoldVzhNFpx
   bc+puN6Z+FZQPmmemqxdihiGS97XmssRt9KqDpRQDkq5O5SQiqX4SUY3+
   l5z2zbpVO17tbWPdztr6HQZbQW7qurl6PxhO0Jkf36iUz7k0QJdriEp4W
   rTYCc/rW5Q2sW/X5AS1ub7es5RGyIM6i4/A/+1EBJ00PTFBXuPZOgKcMh
   Oidq/OjUIeRqDJ8X97yHje9LwdKlIQbkvHjfcIxoEyngPkgcUDYkvM5E/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="432476666"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="432476666"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 12:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="753441698"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="753441698"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Jul 2023 12:27:51 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLqMO-0003qo-2l;
        Tue, 18 Jul 2023 19:27:49 +0000
Date:   Wed, 19 Jul 2023 03:27:29 +0800
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
Subject: Re: [PATCH v2 3/3] gpio: bcm-kona: Drop unused pdev member in
 private data structure
Message-ID: <202307190321.eqsdDbky-lkp@intel.com>
References: <20230717141845.41415-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717141845.41415-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on linus/master v6.5-rc2 next-20230718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/gpio-bcm-kona-remove-unneeded-platform_set_drvdata-call/20230718-174129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230717141845.41415-3-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v2 3/3] gpio: bcm-kona: Drop unused pdev member in private data structure
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230719/202307190321.eqsdDbky-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307190321.eqsdDbky-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307190321.eqsdDbky-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpio/gpio-bcm-kona.c: In function 'bcm_kona_gpio_set_debounce':
   drivers/gpio/gpio-bcm-kona.c:265:17: error: implicit declaration of function 'dev_err' [-Werror=implicit-function-declaration]
     265 |                 dev_err(chip->parent, "Debounce value %u not in range\n",
         |                 ^~~~~~~
   drivers/gpio/gpio-bcm-kona.c: At top level:
>> drivers/gpio/gpio-bcm-kona.c:556:39: warning: 'struct platform_device' declared inside parameter list will not be visible outside of this definition or declaration
     556 | static int bcm_kona_gpio_probe(struct platform_device *pdev)
         |                                       ^~~~~~~~~~~~~~~
   drivers/gpio/gpio-bcm-kona.c: In function 'bcm_kona_gpio_probe':
   drivers/gpio/gpio-bcm-kona.c:558:35: error: invalid use of undefined type 'struct platform_device'
     558 |         struct device *dev = &pdev->dev;
         |                                   ^~
   drivers/gpio/gpio-bcm-kona.c:565:21: error: implicit declaration of function 'devm_kzalloc' [-Werror=implicit-function-declaration]
     565 |         kona_gpio = devm_kzalloc(dev, sizeof(*kona_gpio), GFP_KERNEL);
         |                     ^~~~~~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:565:19: warning: assignment to 'struct bcm_kona_gpio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     565 |         kona_gpio = devm_kzalloc(dev, sizeof(*kona_gpio), GFP_KERNEL);
         |                   ^
   drivers/gpio/gpio-bcm-kona.c:571:15: error: implicit declaration of function 'platform_irq_count' [-Werror=implicit-function-declaration]
     571 |         ret = platform_irq_count(pdev);
         |               ^~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:576:24: error: implicit declaration of function 'dev_err_probe' [-Werror=implicit-function-declaration]
     576 |                 return dev_err_probe(dev, ret, "Couldn't determine GPIO banks\n");
         |                        ^~~~~~~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:585:28: error: implicit declaration of function 'devm_kcalloc' [-Werror=implicit-function-declaration]
     585 |         kona_gpio->banks = devm_kcalloc(dev,
         |                            ^~~~~~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:585:26: warning: assignment to 'struct bcm_kona_gpio_bank *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     585 |         kona_gpio->banks = devm_kcalloc(dev,
         |                          ^
   drivers/gpio/gpio-bcm-kona.c:604:31: error: implicit declaration of function 'devm_platform_ioremap_resource' [-Werror=implicit-function-declaration]
     604 |         kona_gpio->reg_base = devm_platform_ioremap_resource(pdev, 0);
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:604:29: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     604 |         kona_gpio->reg_base = devm_platform_ioremap_resource(pdev, 0);
         |                             ^
   drivers/gpio/gpio-bcm-kona.c:613:29: error: implicit declaration of function 'platform_get_irq' [-Werror=implicit-function-declaration]
     613 |                 bank->irq = platform_get_irq(pdev, i);
         |                             ^~~~~~~~~~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:622:9: error: implicit declaration of function 'dev_info' [-Werror=implicit-function-declaration]
     622 |         dev_info(&pdev->dev, "Setting up Kona GPIO\n");
         |         ^~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:622:23: error: invalid use of undefined type 'struct platform_device'
     622 |         dev_info(&pdev->dev, "Setting up Kona GPIO\n");
         |                       ^~
   drivers/gpio/gpio-bcm-kona.c: At top level:
   drivers/gpio/gpio-bcm-kona.c:648:15: error: variable 'bcm_kona_gpio_driver' has initializer but incomplete type
     648 | static struct platform_driver bcm_kona_gpio_driver = {
         |               ^~~~~~~~~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:649:10: error: 'struct platform_driver' has no member named 'driver'
     649 |         .driver = {
         |          ^~~~~~
   drivers/gpio/gpio-bcm-kona.c:649:19: error: extra brace group at end of initializer
     649 |         .driver = {
         |                   ^
   drivers/gpio/gpio-bcm-kona.c:649:19: note: (near initialization for 'bcm_kona_gpio_driver')
   drivers/gpio/gpio-bcm-kona.c:649:19: warning: excess elements in struct initializer
   drivers/gpio/gpio-bcm-kona.c:649:19: note: (near initialization for 'bcm_kona_gpio_driver')
   drivers/gpio/gpio-bcm-kona.c:653:10: error: 'struct platform_driver' has no member named 'probe'
     653 |         .probe = bcm_kona_gpio_probe,
         |          ^~~~~
   drivers/gpio/gpio-bcm-kona.c:653:18: warning: excess elements in struct initializer
     653 |         .probe = bcm_kona_gpio_probe,
         |                  ^~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:653:18: note: (near initialization for 'bcm_kona_gpio_driver')
   drivers/gpio/gpio-bcm-kona.c:655:1: warning: data definition has no type or storage class
     655 | builtin_platform_driver(bcm_kona_gpio_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:655:1: error: type defaults to 'int' in declaration of 'builtin_platform_driver' [-Werror=implicit-int]
   drivers/gpio/gpio-bcm-kona.c:655:1: warning: parameter names (without types) in function declaration
   drivers/gpio/gpio-bcm-kona.c:648:31: error: storage size of 'bcm_kona_gpio_driver' isn't known
     648 | static struct platform_driver bcm_kona_gpio_driver = {
         |                               ^~~~~~~~~~~~~~~~~~~~
   drivers/gpio/gpio-bcm-kona.c:648:31: warning: 'bcm_kona_gpio_driver' defined but not used [-Wunused-variable]
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


vim +556 drivers/gpio/gpio-bcm-kona.c

757651e3d60e5b Markus Mayer                     2013-09-10  555  
757651e3d60e5b Markus Mayer                     2013-09-10 @556  static int bcm_kona_gpio_probe(struct platform_device *pdev)
757651e3d60e5b Markus Mayer                     2013-09-10  557  {
757651e3d60e5b Markus Mayer                     2013-09-10  558  	struct device *dev = &pdev->dev;
757651e3d60e5b Markus Mayer                     2013-09-10  559  	struct bcm_kona_gpio_bank *bank;
757651e3d60e5b Markus Mayer                     2013-09-10  560  	struct bcm_kona_gpio *kona_gpio;
757651e3d60e5b Markus Mayer                     2013-09-10  561  	struct gpio_chip *chip;
757651e3d60e5b Markus Mayer                     2013-09-10  562  	int ret;
757651e3d60e5b Markus Mayer                     2013-09-10  563  	int i;
757651e3d60e5b Markus Mayer                     2013-09-10  564  
757651e3d60e5b Markus Mayer                     2013-09-10  565  	kona_gpio = devm_kzalloc(dev, sizeof(*kona_gpio), GFP_KERNEL);
757651e3d60e5b Markus Mayer                     2013-09-10  566  	if (!kona_gpio)
757651e3d60e5b Markus Mayer                     2013-09-10  567  		return -ENOMEM;
757651e3d60e5b Markus Mayer                     2013-09-10  568  
757651e3d60e5b Markus Mayer                     2013-09-10  569  	kona_gpio->gpio_chip = template_chip;
757651e3d60e5b Markus Mayer                     2013-09-10  570  	chip = &kona_gpio->gpio_chip;
cfdca14c44a79b Peng Fan                         2019-12-04  571  	ret = platform_irq_count(pdev);
cfdca14c44a79b Peng Fan                         2019-12-04  572  	if (!ret) {
757651e3d60e5b Markus Mayer                     2013-09-10  573  		dev_err(dev, "Couldn't determine # GPIO banks\n");
757651e3d60e5b Markus Mayer                     2013-09-10  574  		return -ENOENT;
cfdca14c44a79b Peng Fan                         2019-12-04  575  	} else if (ret < 0) {
cff9d73f3d6a9f Krzysztof Kozlowski              2020-08-27  576  		return dev_err_probe(dev, ret, "Couldn't determine GPIO banks\n");
757651e3d60e5b Markus Mayer                     2013-09-10  577  	}
cfdca14c44a79b Peng Fan                         2019-12-04  578  	kona_gpio->num_bank = ret;
cfdca14c44a79b Peng Fan                         2019-12-04  579  
757651e3d60e5b Markus Mayer                     2013-09-10  580  	if (kona_gpio->num_bank > GPIO_MAX_BANK_NUM) {
757651e3d60e5b Markus Mayer                     2013-09-10  581  		dev_err(dev, "Too many GPIO banks configured (max=%d)\n",
757651e3d60e5b Markus Mayer                     2013-09-10  582  			GPIO_MAX_BANK_NUM);
757651e3d60e5b Markus Mayer                     2013-09-10  583  		return -ENXIO;
757651e3d60e5b Markus Mayer                     2013-09-10  584  	}
a86854d0c599b3 Kees Cook                        2018-06-12  585  	kona_gpio->banks = devm_kcalloc(dev,
a86854d0c599b3 Kees Cook                        2018-06-12  586  					kona_gpio->num_bank,
a86854d0c599b3 Kees Cook                        2018-06-12  587  					sizeof(*kona_gpio->banks),
a86854d0c599b3 Kees Cook                        2018-06-12  588  					GFP_KERNEL);
757651e3d60e5b Markus Mayer                     2013-09-10  589  	if (!kona_gpio->banks)
757651e3d60e5b Markus Mayer                     2013-09-10  590  		return -ENOMEM;
757651e3d60e5b Markus Mayer                     2013-09-10  591  
45a541a610af81 Andy Shevchenko                  2021-12-06  592  	chip->parent = dev;
757651e3d60e5b Markus Mayer                     2013-09-10  593  	chip->ngpio = kona_gpio->num_bank * GPIO_PER_BANK;
757651e3d60e5b Markus Mayer                     2013-09-10  594  
71093d3e361dfb Andy Shevchenko                  2023-07-17  595  	kona_gpio->irq_domain = irq_domain_create_linear(dev_fwnode(dev),
757651e3d60e5b Markus Mayer                     2013-09-10  596  							 chip->ngpio,
757651e3d60e5b Markus Mayer                     2013-09-10  597  							 &bcm_kona_irq_ops,
757651e3d60e5b Markus Mayer                     2013-09-10  598  							 kona_gpio);
757651e3d60e5b Markus Mayer                     2013-09-10  599  	if (!kona_gpio->irq_domain) {
757651e3d60e5b Markus Mayer                     2013-09-10  600  		dev_err(dev, "Couldn't allocate IRQ domain\n");
757651e3d60e5b Markus Mayer                     2013-09-10  601  		return -ENXIO;
757651e3d60e5b Markus Mayer                     2013-09-10  602  	}
757651e3d60e5b Markus Mayer                     2013-09-10  603  
72d8cb71547772 Enrico Weigelt, metux IT consult 2019-03-11  604  	kona_gpio->reg_base = devm_platform_ioremap_resource(pdev, 0);
757651e3d60e5b Markus Mayer                     2013-09-10  605  	if (IS_ERR(kona_gpio->reg_base)) {
98f7d1b15e87c8 Tiezhu Yang                      2020-05-22  606  		ret = PTR_ERR(kona_gpio->reg_base);
757651e3d60e5b Markus Mayer                     2013-09-10  607  		goto err_irq_domain;
757651e3d60e5b Markus Mayer                     2013-09-10  608  	}
757651e3d60e5b Markus Mayer                     2013-09-10  609  
757651e3d60e5b Markus Mayer                     2013-09-10  610  	for (i = 0; i < kona_gpio->num_bank; i++) {
757651e3d60e5b Markus Mayer                     2013-09-10  611  		bank = &kona_gpio->banks[i];
757651e3d60e5b Markus Mayer                     2013-09-10  612  		bank->id = i;
757651e3d60e5b Markus Mayer                     2013-09-10  613  		bank->irq = platform_get_irq(pdev, i);
757651e3d60e5b Markus Mayer                     2013-09-10  614  		bank->kona_gpio = kona_gpio;
757651e3d60e5b Markus Mayer                     2013-09-10  615  		if (bank->irq < 0) {
757651e3d60e5b Markus Mayer                     2013-09-10  616  			dev_err(dev, "Couldn't get IRQ for bank %d", i);
757651e3d60e5b Markus Mayer                     2013-09-10  617  			ret = -ENOENT;
757651e3d60e5b Markus Mayer                     2013-09-10  618  			goto err_irq_domain;
757651e3d60e5b Markus Mayer                     2013-09-10  619  		}
757651e3d60e5b Markus Mayer                     2013-09-10  620  	}
757651e3d60e5b Markus Mayer                     2013-09-10  621  
23b4faa9a36257 Markus Mayer                     2013-10-18  622  	dev_info(&pdev->dev, "Setting up Kona GPIO\n");
757651e3d60e5b Markus Mayer                     2013-09-10  623  
757651e3d60e5b Markus Mayer                     2013-09-10  624  	bcm_kona_gpio_reset(kona_gpio);
757651e3d60e5b Markus Mayer                     2013-09-10  625  
0b89312379e574 Laxman Dewangan                  2016-02-22  626  	ret = devm_gpiochip_add_data(dev, chip, kona_gpio);
757651e3d60e5b Markus Mayer                     2013-09-10  627  	if (ret < 0) {
757651e3d60e5b Markus Mayer                     2013-09-10  628  		dev_err(dev, "Couldn't add GPIO chip -- %d\n", ret);
757651e3d60e5b Markus Mayer                     2013-09-10  629  		goto err_irq_domain;
757651e3d60e5b Markus Mayer                     2013-09-10  630  	}
757651e3d60e5b Markus Mayer                     2013-09-10  631  	for (i = 0; i < kona_gpio->num_bank; i++) {
757651e3d60e5b Markus Mayer                     2013-09-10  632  		bank = &kona_gpio->banks[i];
b34cc62084e8c4 Thomas Gleixner                  2015-06-21  633  		irq_set_chained_handler_and_data(bank->irq,
b34cc62084e8c4 Thomas Gleixner                  2015-06-21  634  						 bcm_kona_gpio_irq_handler,
b34cc62084e8c4 Thomas Gleixner                  2015-06-21  635  						 bank);
757651e3d60e5b Markus Mayer                     2013-09-10  636  	}
757651e3d60e5b Markus Mayer                     2013-09-10  637  
c69fcea57e9d2b Julia Cartwright                 2017-03-09  638  	raw_spin_lock_init(&kona_gpio->lock);
757651e3d60e5b Markus Mayer                     2013-09-10  639  
757651e3d60e5b Markus Mayer                     2013-09-10  640  	return 0;
757651e3d60e5b Markus Mayer                     2013-09-10  641  
757651e3d60e5b Markus Mayer                     2013-09-10  642  err_irq_domain:
757651e3d60e5b Markus Mayer                     2013-09-10  643  	irq_domain_remove(kona_gpio->irq_domain);
757651e3d60e5b Markus Mayer                     2013-09-10  644  
757651e3d60e5b Markus Mayer                     2013-09-10  645  	return ret;
757651e3d60e5b Markus Mayer                     2013-09-10  646  }
757651e3d60e5b Markus Mayer                     2013-09-10  647  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
