Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D561807AA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjLFVms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLFVmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:42:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FDB98;
        Wed,  6 Dec 2023 13:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701898972; x=1733434972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/wvQNefmrWV1INKaH/TuPyztXWQSTC9DZZffyWof5es=;
  b=FqcD98ai6cGKTHjiQAaWpuC8k+vJvs89WF0qREJTs0FZ47GPBvFwzlQ9
   oXcY0zD60Pg7QZmgFvwalJTt52KAiI9qZ0GlWD8/AUav/Gg6s5U+MWxmm
   l5oGRn2EuGM/rh48Mi+PB6oM8DIJ46YPPY5dAIdoQL4TFHierdtEEywkS
   bQas6jb33H9qf/LNDOfeiZ2W1btIhsF5471aodp+97gBxzwm6KvEJmS2U
   Dsg+NeOEqLnvHTIYJR2SSlmmybmZaDSB6fObAd8P7+oWMZ/arvSmJAMC5
   IClL2C4/B48ib2OEyofnQwF96WXxz1+jkLHg3v+7dyxj9zjQM1NWrkfUo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="384532494"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="384532494"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 13:42:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="19457631"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Dec 2023 13:42:49 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAzfJ-000BSs-3D;
        Wed, 06 Dec 2023 21:42:45 +0000
Date:   Thu, 7 Dec 2023 05:41:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Josua Mayer <josua@solid-run.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        kernel@pengutronix.de,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: rfkill: gpio: set GPIO direction
Message-ID: <202312070522.71CNBJ25-lkp@intel.com>
References: <20231206131336.3099727-1-r.czerwinski@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206131336.3099727-1-r.czerwinski@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rouven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 994d5c58e50e91bb02c7be4a91d5186292a895c8]

url:    https://github.com/intel-lab-lkp/linux/commits/Rouven-Czerwinski/net-rfkill-gpio-set-GPIO-direction/20231206-211525
base:   994d5c58e50e91bb02c7be4a91d5186292a895c8
patch link:    https://lore.kernel.org/r/20231206131336.3099727-1-r.czerwinski%40pengutronix.de
patch subject: [PATCH] net: rfkill: gpio: set GPIO direction
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20231207/202312070522.71CNBJ25-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231207/202312070522.71CNBJ25-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312070522.71CNBJ25-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/rfkill/rfkill-gpio.c:129:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     129 |         if (rfkill->reset_gpio)
         |             ^~~~~~~~~~~~~~~~~~
   net/rfkill/rfkill-gpio.c:131:6: note: uninitialized use occurs here
     131 |         if (ret)
         |             ^~~
   net/rfkill/rfkill-gpio.c:129:2: note: remove the 'if' if its condition is always true
     129 |         if (rfkill->reset_gpio)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
     130 |                 ret = gpiod_direction_output(rfkill->reset_gpio, true);
         | ~~~~~~~~~~~~~~~~
   net/rfkill/rfkill-gpio.c:82:9: note: initialize the variable 'ret' to silence this warning
      82 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +129 net/rfkill/rfkill-gpio.c

    74	
    75	static int rfkill_gpio_probe(struct platform_device *pdev)
    76	{
    77		struct rfkill_gpio_data *rfkill;
    78		struct gpio_desc *gpio;
    79		const char *name_property;
    80		const char *type_property;
    81		const char *type_name;
    82		int ret;
    83	
    84		rfkill = devm_kzalloc(&pdev->dev, sizeof(*rfkill), GFP_KERNEL);
    85		if (!rfkill)
    86			return -ENOMEM;
    87	
    88		if (dev_of_node(&pdev->dev)) {
    89			name_property = "label";
    90			type_property = "radio-type";
    91		} else {
    92			name_property = "name";
    93			type_property = "type";
    94		}
    95		device_property_read_string(&pdev->dev, name_property, &rfkill->name);
    96		device_property_read_string(&pdev->dev, type_property, &type_name);
    97	
    98		if (!rfkill->name)
    99			rfkill->name = dev_name(&pdev->dev);
   100	
   101		rfkill->type = rfkill_find_type(type_name);
   102	
   103		if (ACPI_HANDLE(&pdev->dev)) {
   104			ret = rfkill_gpio_acpi_probe(&pdev->dev, rfkill);
   105			if (ret)
   106				return ret;
   107		}
   108	
   109		rfkill->clk = devm_clk_get(&pdev->dev, NULL);
   110	
   111		gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_ASIS);
   112		if (IS_ERR(gpio))
   113			return PTR_ERR(gpio);
   114	
   115		rfkill->reset_gpio = gpio;
   116	
   117		gpio = devm_gpiod_get_optional(&pdev->dev, "shutdown", GPIOD_ASIS);
   118		if (IS_ERR(gpio))
   119			return PTR_ERR(gpio);
   120	
   121		rfkill->shutdown_gpio = gpio;
   122	
   123		/* Make sure at-least one GPIO is defined for this instance */
   124		if (!rfkill->reset_gpio && !rfkill->shutdown_gpio) {
   125			dev_err(&pdev->dev, "invalid platform data\n");
   126			return -EINVAL;
   127		}
   128	
 > 129		if (rfkill->reset_gpio)
   130			ret = gpiod_direction_output(rfkill->reset_gpio, true);
   131		if (ret)
   132			return ret;
   133	
   134		if (rfkill->shutdown_gpio)
   135			ret = gpiod_direction_output(rfkill->shutdown_gpio, true);
   136		if (ret)
   137			return ret;
   138	
   139		rfkill->rfkill_dev = rfkill_alloc(rfkill->name, &pdev->dev,
   140						  rfkill->type, &rfkill_gpio_ops,
   141						  rfkill);
   142		if (!rfkill->rfkill_dev)
   143			return -ENOMEM;
   144	
   145		ret = rfkill_register(rfkill->rfkill_dev);
   146		if (ret < 0)
   147			goto err_destroy;
   148	
   149		platform_set_drvdata(pdev, rfkill);
   150	
   151		dev_info(&pdev->dev, "%s device registered.\n", rfkill->name);
   152	
   153		return 0;
   154	
   155	err_destroy:
   156		rfkill_destroy(rfkill->rfkill_dev);
   157	
   158		return ret;
   159	}
   160	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
