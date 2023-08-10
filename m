Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39EE776E62
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjHJDN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHJDNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:13:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A54B9;
        Wed,  9 Aug 2023 20:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691637204; x=1723173204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HxGWHKx9Iwk/BOa+mNcHI9v6yPigjZskuc2ISwPW4EU=;
  b=U/V0bjgYz6ICANLOxa5c6gqVD0FHepDlGm/kRWRCJELdKXWuchG60OeP
   IOn+a7NTPTcnr6EvGSfcRJYrFmDh2Q0p9z1cXpEXZZj+FFk/5edbaU7+Z
   JB1j/Ir8pKFshinieM58LxJsCYkkQO0IvKcdkuhfNkGgGWs64Iu+1puXf
   alvStrfgzH/fmi8fvxcwlt6On6wrB+14svjCwpYhncK1Y2q8A/u6n4HVY
   GqPTuj2pp9KyvxiUU3OMq+bMQ45Vb+t3IsaRt5LhsAZx6QVTIueUqhurM
   YBq/E4r7wi+lGAtYRs2pBgGp+UH0Ofo6zFoO8ehJtazElKS/2S9i172gt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="457642658"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="457642658"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 20:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="732047061"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="732047061"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Aug 2023 20:12:57 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTw6b-0006gi-06;
        Thu, 10 Aug 2023 03:12:57 +0000
Date:   Thu, 10 Aug 2023 11:12:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "larry.lai" <larry.lai@yunjingtech.com>, lee@kernel.org,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        pavel@ucw.cz
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        michael.wang@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, "larry.lai" <larry.lai@yunjingtech.com>
Subject: Re: [PATCH V5 1/3] mfd: Add support for UP board CPLD/FPGA
Message-ID: <202308101112.LWcBvo24-lkp@intel.com>
References: <20230808145601.9401-2-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808145601.9401-2-larry.lai@yunjingtech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi larry.lai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-fixes]
[also build test WARNING on pavel-leds/for-next]
[cannot apply to lee-mfd/for-mfd-next linusw-pinctrl/devel linusw-pinctrl/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/larry-lai/pinctrl-Add-support-pin-control-for-UP-board-CPLD-FPGA/20230809-013857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-fixes
patch link:    https://lore.kernel.org/r/20230808145601.9401-2-larry.lai%40yunjingtech.com
patch subject: [PATCH V5 1/3] mfd: Add support for UP board CPLD/FPGA
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230810/202308101112.LWcBvo24-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230810/202308101112.LWcBvo24-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308101112.LWcBvo24-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mfd/upboard-fpga.c:344:5: warning: no previous prototype for 'upboard_led_gpio_register' [-Wmissing-prototypes]
     344 | int upboard_led_gpio_register(struct upboard_fpga *fpga)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mfd/upboard-fpga.c: In function 'upboard_fpga_probe':
>> drivers/mfd/upboard-fpga.c:460:30: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     460 |         ddata->regmap_config = fpga_data->regmap_config;
         |                              ^


vim +/upboard_led_gpio_register +344 drivers/mfd/upboard-fpga.c

   343	
 > 344	int upboard_led_gpio_register(struct upboard_fpga *fpga)
   345	{
   346		struct gpio_led blue_led, yellow_led, green_led, red_led;
   347		struct gpio_desc *desc;
   348		static struct gpio_led leds[4];
   349		int num_leds = 0;
   350		int ret;
   351	
   352		desc = devm_gpiod_get(fpga->dev, "blue", GPIOD_OUT_LOW);
   353		if (!IS_ERR(desc)) {
   354			blue_led.name = "upboard:blue:";
   355			blue_led.gpio = desc_to_gpio(desc);
   356			blue_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
   357			leds[num_leds++] = blue_led;
   358			devm_gpiod_put(fpga->dev, desc);
   359		}
   360	
   361		desc = devm_gpiod_get(fpga->dev, "yellow", GPIOD_OUT_LOW);
   362		if (!IS_ERR(desc)) {
   363			yellow_led.name = "upboard:yellow:";
   364			yellow_led.gpio = desc_to_gpio(desc);
   365			yellow_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
   366			leds[num_leds++] = yellow_led;
   367			devm_gpiod_put(fpga->dev, desc);
   368		}
   369	
   370		desc = devm_gpiod_get(fpga->dev, "green", GPIOD_OUT_LOW);
   371		if (!IS_ERR(desc)) {
   372			green_led.name = "upboard:green:";
   373			green_led.gpio = desc_to_gpio(desc);
   374			green_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
   375			leds[num_leds++] = green_led;
   376			devm_gpiod_put(fpga->dev, desc);
   377		}
   378	
   379		desc = devm_gpiod_get(fpga->dev, "red", GPIOD_OUT_LOW);
   380		if (!IS_ERR(desc)) {
   381			red_led.name = "upboard:red:";
   382			red_led.gpio = desc_to_gpio(desc);
   383			red_led.default_state = LEDS_GPIO_DEFSTATE_KEEP;
   384			leds[num_leds++] = red_led;
   385			devm_gpiod_put(fpga->dev, desc);
   386		}
   387	
   388		/* No optional LEDs defined */
   389		if (num_leds == 0)
   390			return 0;
   391	
   392		pdata.num_leds = num_leds;
   393		pdata.leds = leds;
   394	
   395		ret = devm_mfd_add_devices(fpga->dev, PLATFORM_DEVID_AUTO,
   396					   upboard_gpio_led_cells,
   397					   ARRAY_SIZE(upboard_gpio_led_cells),
   398					   NULL, 0, NULL);
   399		if (ret) {
   400			dev_err(fpga->dev, "Failed to add GPIO LEDs, %d", ret);
   401			return ret;
   402		}
   403	
   404		return 0;
   405	}
   406	
   407	/*
   408	 * --------------------------------------       ------------
   409	 * |    Intel SOC,1.8V                   | --- |ADC Chip   |  native driver
   410	 * | GPIO/I2C/SPI/UART/PWM               |     |SPI/I2C    |
   411	 * --------------------------------------      -------------
   412	 *            |                                     |
   413	 * ----------------------------------------------------------
   414	 * |        CPLD/FPGA Driver                                |   upboard-fpga CPLD control driver
   415	 * |   provide more GPIO driving power                      |   register leds-upboard
   416	 * |        HAT 40 pin mux function                         |   register pinctrl-upboard
   417	 * ---------------------------------------------------------
   418	 *    |                                      |
   419	 * ----------   -------------------------------------------
   420	 * |3 or 4|     |    HAT 40 pins, 3.3V                    |   leds-upboard
   421	 * | Leds |     |GPIO/ADC/I2C/SPI/UART/PWM                |  pinctrl-upboard
   422	 * ----------   -------------------------------------------
   423	 */
   424	static const struct acpi_device_id upboard_fpga_acpi_match[] = {
   425		{ "AANT0000", (kernel_ulong_t)&upboard_pinctrl_data },
   426		{ "AANT0F00", (kernel_ulong_t)&upboard_up_fpga_data },
   427		{ "AANT0F01", (kernel_ulong_t)&upboard_up2_fpga_data },
   428		{ "AANT0F02", (kernel_ulong_t)&upboard_up_fpga_data },
   429		{ "AANT0F03", (kernel_ulong_t)&upboard_upcore_crst02_fpga_data },
   430		{ "AANT0F04", (kernel_ulong_t)&upboard_up_fpga_data },
   431		{ }
   432	};
   433	MODULE_DEVICE_TABLE(acpi, upboard_fpga_acpi_match);
   434	
   435	static int __init upboard_fpga_probe(struct platform_device *pdev)
   436	{
   437		struct device *dev = &pdev->dev;
   438		struct upboard_fpga *ddata;
   439		const struct acpi_device_id *id;
   440		const struct upboard_fpga_data *fpga_data;
   441		int ret;
   442	
   443		id = acpi_match_device(upboard_fpga_acpi_match, dev);
   444		if (!id)
   445			return -ENODEV;
   446	
   447		fpga_data = (const struct upboard_fpga_data *) id->driver_data;
   448	
   449		ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
   450		if (!ddata)
   451			return -ENOMEM;
   452	
   453		platform_set_drvdata(pdev, ddata);
   454		ddata->dev = dev;
   455	
   456		ddata->regmap = devm_regmap_init(dev, NULL, ddata, fpga_data->regmap_config);
   457		if (IS_ERR(ddata->regmap))
   458			return PTR_ERR(ddata->regmap);
   459	
 > 460		ddata->regmap_config = fpga_data->regmap_config;
   461	
   462		ret = upboard_fpga_gpio_init(ddata);
   463		if (ret) {
   464			/* Not FPGA firmware, abort FPGA GPIO initialize process */
   465			dev_warn(dev, "Failed to initialize FPGA common GPIOs: %d", ret);
   466		} else {
   467			upboard_fpga_verify_device(ddata);
   468		}
   469	
   470		ret = upboard_led_gpio_register(ddata);
   471		if (ret) {
   472			/* LEDs are optional. */
   473			dev_warn(dev, "Failed to register LEDs: %d", ret);
   474		}
   475	
   476		return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
   477					    fpga_data->cells,
   478					    fpga_data->ncells,
   479					    NULL, 0, NULL);
   480	}
   481	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
