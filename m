Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77DB7E8920
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 05:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjKKEVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 23:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjKKEVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 23:21:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D03AA2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 20:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699676505; x=1731212505;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=//oHXkLWDK1XxNxC1cQmSqFIOk555ollNH0v5Bpu8kY=;
  b=IjJ8Jw52ZG+J/lc6iGWVHG0DhUwL5aMbrmTzgasBRwLDGDBdtpohqTOL
   WP0uVAHFuggTv+iXk4rUhfMa6Yyub0VnF3rXdGjTS1luW7DhoB1C8Wv+h
   fMG+8iA3Vi4J4dXx7clY0lchLZNFkTOktaJNsNU8uXdLlaAYuuWlDY8RH
   t+H/ofEdhFLuEyqE5HDV8doihfZV5fLwE7Ox8Db922HF2xqqfU7ON2I9R
   c2h2MaLfhtgWFCgyr/78MPsNmod4QB8dEKovM8OhwkzT02lRwZ37RcX3u
   WD0FuhsaoRxefvhfjtSDWYY23irnJKjl7ROz3I+IpHUJ5fSrndMfjbP0x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="375288940"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="375288940"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 20:21:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="854537650"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="854537650"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Nov 2023 20:21:43 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1fV7-000ACe-12;
        Sat, 11 Nov 2023 04:21:41 +0000
Date:   Sat, 11 Nov 2023 12:20:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?utf-8?B?U3plbXrFkSBBbmRyw6Fz?= <sza@esh.hu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: drivers/usb/gadget/udc/atmel_usba_udc.c:379:27: warning: this
 statement may fall through
Message-ID: <202311111246.JwAbYSzm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 2d4c44e979eaa846dfa63717c4f4818e11161c66 ARM: at91: Add armv7m support
date:   6 years ago
config: arm-randconfig-001-20231106 (https://download.01.org/0day-ci/archive/20231111/202311111246.JwAbYSzm-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111246.JwAbYSzm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111246.JwAbYSzm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/usb/gadget/udc/atmel_usba_udc.c:12:
   include/linux/module.h:137:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'udc_driver_exit': 'cold' [-Wmissing-attributes]
     137 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   include/linux/platform_device.h:256:1: note: in expansion of macro 'module_exit'
     256 | module_exit(__platform_driver##_exit);
         | ^~~~~~~~~~~
   drivers/usb/gadget/udc/atmel_usba_udc.c:2470:1: note: in expansion of macro 'module_platform_driver_probe'
    2470 | module_platform_driver_probe(udc_driver, usba_udc_probe);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/usb/gadget/udc/atmel_usba_udc.c:21:
   drivers/usb/gadget/udc/atmel_usba_udc.c:2470:30: note: 'cleanup_module' target declared here
    2470 | module_platform_driver_probe(udc_driver, usba_udc_probe);
         |                              ^~~~~~~~~~
   include/linux/platform_device.h:252:20: note: in definition of macro 'module_platform_driver_probe'
     252 | static void __exit __platform_driver##_exit(void) \
         |                    ^~~~~~~~~~~~~~~~~
   include/linux/module.h:131:13: warning: 'init_module' specifies less restrictive attribute than its target 'udc_driver_init': 'cold' [-Wmissing-attributes]
     131 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   include/linux/platform_device.h:251:1: note: in expansion of macro 'module_init'
     251 | module_init(__platform_driver##_init); \
         | ^~~~~~~~~~~
   drivers/usb/gadget/udc/atmel_usba_udc.c:2470:1: note: in expansion of macro 'module_platform_driver_probe'
    2470 | module_platform_driver_probe(udc_driver, usba_udc_probe);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/gadget/udc/atmel_usba_udc.c:2470:30: note: 'init_module' target declared here
    2470 | module_platform_driver_probe(udc_driver, usba_udc_probe);
         |                              ^~~~~~~~~~
   include/linux/platform_device.h:246:19: note: in definition of macro 'module_platform_driver_probe'
     246 | static int __init __platform_driver##_init(void) \
         |                   ^~~~~~~~~~~~~~~~~
   drivers/usb/gadget/udc/atmel_usba_udc.c: In function 'usba_config_fifo_table':
>> drivers/usb/gadget/udc/atmel_usba_udc.c:379:27: warning: this statement may fall through [-Wimplicit-fallthrough=]
     379 |                 fifo_mode = 0;
         |                 ~~~~~~~~~~^~~
   drivers/usb/gadget/udc/atmel_usba_udc.c:380:9: note: here
     380 |         case 0:
         |         ^~~~
   drivers/usb/gadget/udc/atmel_usba_udc.c: In function 'usba_udc_pdata':
   drivers/usb/gadget/udc/atmel_usba_udc.c:2246:40: warning: array subscript i is outside array bounds of 'struct usba_ep_data[0]' [-Warray-bounds=]
    2246 |                 ep->ep.name = pdata->ep[i].name;
         |                               ~~~~~~~~~^~~
   In file included from drivers/usb/gadget/udc/atmel_usba_udc.c:26:
   include/linux/usb/atmel_usba_udc.h:20:33: note: while referencing 'ep'
      20 |         struct usba_ep_data     ep[0];
         |                                 ^~
   drivers/usb/gadget/udc/atmel_usba_udc.c:2247:42: warning: array subscript i is outside array bounds of 'struct usba_ep_data[0]' [-Warray-bounds=]
    2247 |                 ep->fifo_size = pdata->ep[i].fifo_size;
         |                                 ~~~~~~~~~^~~
   include/linux/usb/atmel_usba_udc.h:20:33: note: while referencing 'ep'
      20 |         struct usba_ep_data     ep[0];
         |                                 ^~
   drivers/usb/gadget/udc/atmel_usba_udc.c:2251:41: warning: array subscript i is outside array bounds of 'struct usba_ep_data[0]' [-Warray-bounds=]
    2251 |                 ep->nr_banks = pdata->ep[i].nr_banks;
         |                                ~~~~~~~~~^~~
   include/linux/usb/atmel_usba_udc.h:20:33: note: while referencing 'ep'
      20 |         struct usba_ep_data     ep[0];
         |                                 ^~
   drivers/usb/gadget/udc/atmel_usba_udc.c:2252:38: warning: array subscript i is outside array bounds of 'struct usba_ep_data[0]' [-Warray-bounds=]
    2252 |                 ep->index = pdata->ep[i].index;
         |                             ~~~~~~~~~^~~
   include/linux/usb/atmel_usba_udc.h:20:33: note: while referencing 'ep'
      20 |         struct usba_ep_data     ep[0];
         |                                 ^~
   drivers/usb/gadget/udc/atmel_usba_udc.c:2253:40: warning: array subscript i is outside array bounds of 'struct usba_ep_data[0]' [-Warray-bounds=]
    2253 |                 ep->can_dma = pdata->ep[i].can_dma;
         |                               ~~~~~~~~~^~~
   include/linux/usb/atmel_usba_udc.h:20:33: note: while referencing 'ep'
      20 |         struct usba_ep_data     ep[0];
         |                                 ^~
   drivers/usb/gadget/udc/atmel_usba_udc.c:2254:41: warning: array subscript i is outside array bounds of 'struct usba_ep_data[0]' [-Warray-bounds=]
    2254 |                 ep->can_isoc = pdata->ep[i].can_isoc;
         |                                ~~~~~~~~~^~~
   include/linux/usb/atmel_usba_udc.h:20:33: note: while referencing 'ep'
      20 |         struct usba_ep_data     ep[0];
         |                                 ^~
--
   drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_wakeup_sources' not described in 'atmel_pioctrl'
   drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_suspend_backup' not described in 'atmel_pioctrl'
>> drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_suspend_backup.imr' not described in 'atmel_pioctrl'
>> drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_suspend_backup.odsr' not described in 'atmel_pioctrl'
>> drivers/pinctrl/pinctrl-at91-pio4.c:136: warning: Function parameter or member 'pm_suspend_backup.cfgr' not described in 'atmel_pioctrl'
--
   In file included from drivers/power/reset/at91-poweroff.c:15:
   include/linux/module.h:137:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'at91_poweroff_driver_exit': 'cold' [-Wmissing-attributes]
     137 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
         |              ^~~~~~~~~~~~~~
   include/linux/platform_device.h:256:1: note: in expansion of macro 'module_exit'
     256 | module_exit(__platform_driver##_exit);
         | ^~~~~~~~~~~
   drivers/power/reset/at91-poweroff.c:233:1: note: in expansion of macro 'module_platform_driver_probe'
     233 | module_platform_driver_probe(at91_poweroff_driver, at91_poweroff_probe);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/power/reset/at91-poweroff.c:18:
   drivers/power/reset/at91-poweroff.c:233:30: note: 'cleanup_module' target declared here
     233 | module_platform_driver_probe(at91_poweroff_driver, at91_poweroff_probe);
         |                              ^~~~~~~~~~~~~~~~~~~~
   include/linux/platform_device.h:252:20: note: in definition of macro 'module_platform_driver_probe'
     252 | static void __exit __platform_driver##_exit(void) \
         |                    ^~~~~~~~~~~~~~~~~
   include/linux/module.h:131:13: warning: 'init_module' specifies less restrictive attribute than its target 'at91_poweroff_driver_init': 'cold' [-Wmissing-attributes]
     131 |         int init_module(void) __attribute__((alias(#initfn)));
         |             ^~~~~~~~~~~
   include/linux/platform_device.h:251:1: note: in expansion of macro 'module_init'
     251 | module_init(__platform_driver##_init); \
         | ^~~~~~~~~~~
   drivers/power/reset/at91-poweroff.c:233:1: note: in expansion of macro 'module_platform_driver_probe'
     233 | module_platform_driver_probe(at91_poweroff_driver, at91_poweroff_probe);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/power/reset/at91-poweroff.c:233:30: note: 'init_module' target declared here
     233 | module_platform_driver_probe(at91_poweroff_driver, at91_poweroff_probe);
         |                              ^~~~~~~~~~~~~~~~~~~~
   include/linux/platform_device.h:246:19: note: in definition of macro 'module_platform_driver_probe'
     246 | static int __init __platform_driver##_init(void) \
         |                   ^~~~~~~~~~~~~~~~~
>> drivers/power/reset/at91-poweroff.c:213:34: warning: 'at91_ramc_of_match' defined but not used [-Wunused-const-variable=]
     213 | static const struct of_device_id at91_ramc_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~


vim +379 drivers/usb/gadget/udc/atmel_usba_udc.c

741d2558bf0aa8 Cristian Birsan 2017-01-23  372  
fbf4987ae89261 Cristian Birsan 2017-03-28  373  static int usba_config_fifo_table(struct usba_udc *udc)
741d2558bf0aa8 Cristian Birsan 2017-01-23  374  {
741d2558bf0aa8 Cristian Birsan 2017-01-23  375  	int n;
741d2558bf0aa8 Cristian Birsan 2017-01-23  376  
741d2558bf0aa8 Cristian Birsan 2017-01-23  377  	switch (fifo_mode) {
741d2558bf0aa8 Cristian Birsan 2017-01-23  378  	default:
741d2558bf0aa8 Cristian Birsan 2017-01-23 @379  		fifo_mode = 0;
741d2558bf0aa8 Cristian Birsan 2017-01-23  380  	case 0:
741d2558bf0aa8 Cristian Birsan 2017-01-23  381  		udc->fifo_cfg = NULL;
741d2558bf0aa8 Cristian Birsan 2017-01-23  382  		n = 0;
741d2558bf0aa8 Cristian Birsan 2017-01-23  383  		break;
741d2558bf0aa8 Cristian Birsan 2017-01-23  384  	case 1:
741d2558bf0aa8 Cristian Birsan 2017-01-23  385  		udc->fifo_cfg = mode_1_cfg;
741d2558bf0aa8 Cristian Birsan 2017-01-23  386  		n = ARRAY_SIZE(mode_1_cfg);
741d2558bf0aa8 Cristian Birsan 2017-01-23  387  		break;
741d2558bf0aa8 Cristian Birsan 2017-01-23  388  	case 2:
741d2558bf0aa8 Cristian Birsan 2017-01-23  389  		udc->fifo_cfg = mode_2_cfg;
741d2558bf0aa8 Cristian Birsan 2017-01-23  390  		n = ARRAY_SIZE(mode_2_cfg);
741d2558bf0aa8 Cristian Birsan 2017-01-23  391  		break;
741d2558bf0aa8 Cristian Birsan 2017-01-23  392  	case 3:
741d2558bf0aa8 Cristian Birsan 2017-01-23  393  		udc->fifo_cfg = mode_3_cfg;
741d2558bf0aa8 Cristian Birsan 2017-01-23  394  		n = ARRAY_SIZE(mode_3_cfg);
741d2558bf0aa8 Cristian Birsan 2017-01-23  395  		break;
741d2558bf0aa8 Cristian Birsan 2017-01-23  396  	case 4:
741d2558bf0aa8 Cristian Birsan 2017-01-23  397  		udc->fifo_cfg = mode_4_cfg;
741d2558bf0aa8 Cristian Birsan 2017-01-23  398  		n = ARRAY_SIZE(mode_4_cfg);
741d2558bf0aa8 Cristian Birsan 2017-01-23  399  		break;
741d2558bf0aa8 Cristian Birsan 2017-01-23  400  	}
741d2558bf0aa8 Cristian Birsan 2017-01-23  401  	DBG(DBG_HW, "Setup fifo_mode %d\n", fifo_mode);
741d2558bf0aa8 Cristian Birsan 2017-01-23  402  
741d2558bf0aa8 Cristian Birsan 2017-01-23  403  	return n;
741d2558bf0aa8 Cristian Birsan 2017-01-23  404  }
741d2558bf0aa8 Cristian Birsan 2017-01-23  405  

:::::: The code at line 379 was first introduced by commit
:::::: 741d2558bf0aa8da9c0834ad43e1b9a1b16aa515 usb: gadget: udc: atmel: Update endpoint allocation scheme

:::::: TO: Cristian Birsan <cristian.birsan@microchip.com>
:::::: CC: Felipe Balbi <felipe.balbi@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
