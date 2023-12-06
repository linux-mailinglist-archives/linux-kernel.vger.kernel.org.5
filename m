Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD7A806FB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378233AbjLFM3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377925AbjLFM32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:29:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7497898;
        Wed,  6 Dec 2023 04:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701865774; x=1733401774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+GkCBS3JPIqJfqmVwwKDxl1JgdlAWVWExb1QL0i3ln4=;
  b=YzQzuKNCU7/eX5LFily/FZaeS7bIklYc4uBTPri5Ebw4jw1aCbiNMxv1
   dfgHso/+UFqCoNW4FQMBzrI/xMHkEAIkeFnOKbaMIhwZg/ImZ2Xq1JXAN
   bHchB9/MXrjmt/HqfWsxqyv782DSloetYXg24cWCTdhrUENNdSEX7nzt/
   ZB4Pzpt3nzx57lEk6n5frBMcFmqpQWAvtiz/Q/IG1njzz1CHyWZJN/I3W
   9gW+srAVZyA4Nil4Pbuol4K5tGR62Rxtccj6gGTpAKreS2KNLq/W4Bcw4
   wLf1gX0Mb/+9uQE6rEPGXrdrvfTbad/yyWJlnpUKrE+aYv3rBdy51VIzQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1147663"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="1147663"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 04:29:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="764706491"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="764706491"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 06 Dec 2023 04:29:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAr1q-000Amh-1e;
        Wed, 06 Dec 2023 12:29:26 +0000
Date:   Wed, 6 Dec 2023 20:28:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        andy@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        KWLIU@nuvoton.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v8 3/3] gpio: nuvoton: Add Nuvoton NPCM sgpio driver
Message-ID: <202312062043.9nNc7GIZ-lkp@intel.com>
References: <20231206014530.1600151-4-jim.t90615@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206014530.1600151-4-jim.t90615@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on robh/for-next linus/master v6.7-rc4 next-20231206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jim-Liu/dt-bindings-gpio-add-NPCM-sgpio-driver-bindings/20231206-095724
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20231206014530.1600151-4-jim.t90615%40gmail.com
patch subject: [PATCH v8 3/3] gpio: nuvoton: Add Nuvoton NPCM sgpio driver
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231206/202312062043.9nNc7GIZ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312062043.9nNc7GIZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312062043.9nNc7GIZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/alpha/include/asm/bug.h:23,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:6,
                    from ./arch/alpha/include/generated/asm/current.h:1,
                    from include/linux/mutex.h:14,
                    from include/linux/notifier.h:14,
                    from include/linux/clk.h:14,
                    from drivers/gpio/gpio-npcm-sgpio.c:9:
   drivers/gpio/gpio-npcm-sgpio.c: In function 'bank_reg':
>> drivers/gpio/gpio-npcm-sgpio.c:150:26: warning: passing argument 1 of 'dev_driver_string' makes pointer from integer without a cast [-Wint-conversion]
     150 |                 dev_WARN(true, "Getting here is an error condition");
         |                          ^~~~
         |                          |
         |                          int
   include/asm-generic/bug.h:99:62: note: in definition of macro '__WARN_printf'
      99 |                 warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);      \
         |                                                              ^~~
   include/linux/dev_printk.h:271:9: note: in expansion of macro 'WARN'
     271 |         WARN(1, "%s %s: " format, dev_driver_string(dev), dev_name(dev), ## arg)
         |         ^~~~
   drivers/gpio/gpio-npcm-sgpio.c:150:17: note: in expansion of macro 'dev_WARN'
     150 |                 dev_WARN(true, "Getting here is an error condition");
         |                 ^~~~~~~~
   In file included from include/linux/platform_device.h:13,
                    from drivers/gpio/gpio-npcm-sgpio.c:16:
   include/linux/device.h:1242:52: note: expected 'const struct device *' but argument is of type 'int'
    1242 | const char *dev_driver_string(const struct device *dev);
         |                               ~~~~~~~~~~~~~~~~~~~~~^~~
>> drivers/gpio/gpio-npcm-sgpio.c:150:26: warning: passing argument 1 of 'dev_name' makes pointer from integer without a cast [-Wint-conversion]
     150 |                 dev_WARN(true, "Getting here is an error condition");
         |                          ^~~~
         |                          |
         |                          int
   include/asm-generic/bug.h:99:62: note: in definition of macro '__WARN_printf'
      99 |                 warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);      \
         |                                                              ^~~
   include/linux/dev_printk.h:271:9: note: in expansion of macro 'WARN'
     271 |         WARN(1, "%s %s: " format, dev_driver_string(dev), dev_name(dev), ## arg)
         |         ^~~~
   drivers/gpio/gpio-npcm-sgpio.c:150:17: note: in expansion of macro 'dev_WARN'
     150 |                 dev_WARN(true, "Getting here is an error condition");
         |                 ^~~~~~~~
   include/linux/device.h:858:57: note: expected 'const struct device *' but argument is of type 'int'
     858 | static inline const char *dev_name(const struct device *dev)
         |                                    ~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/gpio/gpio-npcm-sgpio.c: In function 'npcm_sgpio_dir_out':
>> drivers/gpio/gpio-npcm-sgpio.c:211:28: warning: unused variable 'gpio' [-Wunused-variable]
     211 |         struct npcm_sgpio *gpio = gpiochip_get_data(gc);
         |                            ^~~~
   drivers/gpio/gpio-npcm-sgpio.c: At top level:
>> drivers/gpio/gpio-npcm-sgpio.c:534:20: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     534 |         .sft_clk = npcm750_SFT_CLK,
         |                    ^~~~~~~~~~~~~~~
   drivers/gpio/gpio-npcm-sgpio.c:535:20: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     535 |         .clk_sel = npcm750_CLK_SEL,
         |                    ^~~~~~~~~~~~~~~
   drivers/gpio/gpio-npcm-sgpio.c:540:20: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     540 |         .sft_clk = npcm845_SFT_CLK,
         |                    ^~~~~~~~~~~~~~~
   drivers/gpio/gpio-npcm-sgpio.c:541:20: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     541 |         .clk_sel = npcm845_CLK_SEL,
         |                    ^~~~~~~~~~~~~~~


vim +/dev_driver_string +150 drivers/gpio/gpio-npcm-sgpio.c

   134	
   135	static void __iomem *bank_reg(struct npcm_sgpio *gpio,
   136				      const struct npcm_sgpio_bank *bank,
   137				      const enum npcm_sgpio_reg reg)
   138	{
   139		switch (reg) {
   140		case READ_DATA:
   141			return gpio->base + bank->rdata_reg;
   142		case WRITE_DATA:
   143			return gpio->base + bank->wdata_reg;
   144		case EVENT_CFG:
   145			return gpio->base + bank->event_config;
   146		case EVENT_STS:
   147			return gpio->base + bank->event_status;
   148		default:
   149			/* actually if code runs to here, it's an error case */
 > 150			dev_WARN(true, "Getting here is an error condition");
   151		}
   152		return 0;
   153	}
   154	
   155	static const struct npcm_sgpio_bank *offset_to_bank(unsigned int offset)
   156	{
   157		unsigned int bank = GPIO_BANK(offset);
   158	
   159		return &npcm_sgpio_banks[bank];
   160	}
   161	
   162	static void irqd_to_npcm_sgpio_data(struct irq_data *d,
   163					    struct npcm_sgpio **gpio,
   164					    const struct npcm_sgpio_bank **bank,
   165					    u8 *bit, unsigned int *offset)
   166	{
   167		struct npcm_sgpio *internal;
   168	
   169		*offset = irqd_to_hwirq(d);
   170		internal = irq_data_get_irq_chip_data(d);
   171	
   172		*gpio = internal;
   173		*offset -= internal->nout_sgpio;
   174		*bank = offset_to_bank(*offset);
   175		*bit = GPIO_BIT(*offset);
   176	}
   177	
   178	static int npcm_sgpio_init_port(struct npcm_sgpio *gpio)
   179	{
   180		u8 in_port, out_port, set_port, reg;
   181	
   182		in_port = GPIO_BANK(gpio->nin_sgpio);
   183		if (GPIO_BIT(gpio->nin_sgpio) > 0)
   184			in_port += 1;
   185	
   186		out_port = GPIO_BANK(gpio->nout_sgpio);
   187		if (GPIO_BIT(gpio->nout_sgpio) > 0)
   188			out_port += 1;
   189	
   190		gpio->in_port = in_port;
   191		gpio->out_port = out_port;
   192		set_port = ((out_port & NPCM_IOXCFG2_PORT) << 4) | (in_port & NPCM_IOXCFG2_PORT);
   193		iowrite8(set_port, gpio->base + NPCM_IOXCFG2);
   194	
   195		reg = ioread8(gpio->base + NPCM_IOXCFG2);
   196	
   197		return reg == set_port ? 0 : -EINVAL;
   198	
   199	}
   200	
   201	static int npcm_sgpio_dir_in(struct gpio_chip *gc, unsigned int offset)
   202	{
   203		struct npcm_sgpio *gpio = gpiochip_get_data(gc);
   204	
   205		return offset <	gpio->nout_sgpio ? -EINVAL : 0;
   206	
   207	}
   208	
   209	static int npcm_sgpio_dir_out(struct gpio_chip *gc, unsigned int offset, int val)
   210	{
 > 211		struct npcm_sgpio *gpio = gpiochip_get_data(gc);
   212	
   213		gc->set(gc, offset, val);
   214	
   215		return 0;
   216	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
