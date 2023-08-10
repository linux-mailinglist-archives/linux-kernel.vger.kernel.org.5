Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE09776F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjHJF1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHJF1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:27:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6132DE75;
        Wed,  9 Aug 2023 22:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691645239; x=1723181239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CDDSGY8hGxxSb7SjMKYwkHW7gRDzh7794XSMlm6EQNE=;
  b=ccb/53uBiGpBUhrlWEvPllfl3t9KFanuFbHHktNeMBxa3irmLP5S5bvE
   911AzuYPbqRRs4odz5YVvdbnDbQux3s8tAK/LzDGjk31Y/1ESAsBxm8S2
   VuzMT47Yxm0Yf9j0j7Bq2h1t6qNid0VMW60QA+/CqqBDBrbUmpqdlvyq6
   slc413ZB9LjcoGuu3lWrJUiPDaV1mwlqCFjzFfEuk7/uMI7C2/jXwfQ9U
   /0szNT8EWxiqNsmR2b0PWhqQJNul9BzsdIRgzCyNtx87vC5BaBgoUyIKq
   KnQGal4v+9NPzZqRmhyGSHlUyFFiGaIoRY6Ntw/A0MQWI3Yjp6SWOqe+5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="402260230"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="402260230"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 22:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="822100593"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="822100593"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2023 22:27:00 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTyCJ-0006kG-2N;
        Thu, 10 Aug 2023 05:26:59 +0000
Date:   Thu, 10 Aug 2023 13:26:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "larry.lai" <larry.lai@yunjingtech.com>, lee@kernel.org,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        pavel@ucw.cz
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        michael.wang@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, "larry.lai" <larry.lai@yunjingtech.com>
Subject: Re: [PATCH V5 2/3] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Message-ID: <202308101342.i8bVXJ0S-lkp@intel.com>
References: <20230808145601.9401-3-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808145601.9401-3-larry.lai@yunjingtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
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
[cannot apply to lee-mfd/for-mfd-next linusw-pinctrl/devel linusw-pinctrl/for-next linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/larry-lai/pinctrl-Add-support-pin-control-for-UP-board-CPLD-FPGA/20230809-013857
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-fixes
patch link:    https://lore.kernel.org/r/20230808145601.9401-3-larry.lai%40yunjingtech.com
patch subject: [PATCH V5 2/3] pinctrl: Add support pin control for UP board CPLD/FPGA
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230810/202308101342.i8bVXJ0S-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230810/202308101342.i8bVXJ0S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308101342.i8bVXJ0S-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_pin_dbg_show':
   drivers/pinctrl/pinctrl-upboard.c:737:17: error: implicit declaration of function 'seq_puts' [-Werror=implicit-function-declaration]
     737 |                 seq_puts(s, "GPIO ");
         |                 ^~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:739:17: error: implicit declaration of function 'seq_printf'; did you mean 'bstr_printf'? [-Werror=implicit-function-declaration]
     739 |                 seq_printf(s, "mode %d ", mode);
         |                 ^~~~~~~~~~
         |                 bstr_printf
>> drivers/pinctrl/pinctrl-upboard.c:727:13: warning: unused variable 'locked' [-Wunused-variable]
     727 |         int locked;
         |             ^~~~~~
   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_alt_func_enable':
>> drivers/pinctrl/pinctrl-upboard.c:792:9: warning: ISO C90 forbids variable length array 'offset' [-Wvla]
     792 |         int offset[pctrl->pctldesc->npins];
         |         ^~~
>> drivers/pinctrl/pinctrl-upboard.c:805:17: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     805 |                 bool input = false;
         |                 ^~~~
   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_gpio_request':
   drivers/pinctrl/pinctrl-upboard.c:936:16: error: implicit declaration of function 'pinctrl_gpio_request'; did you mean 'upboard_gpio_request'? [-Werror=implicit-function-declaration]
     936 |         return pinctrl_gpio_request(gpio);
         |                ^~~~~~~~~~~~~~~~~~~~
         |                upboard_gpio_request
   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_gpio_free':
   drivers/pinctrl/pinctrl-upboard.c:945:9: error: implicit declaration of function 'pinctrl_gpio_free' [-Werror=implicit-function-declaration]
     945 |         pinctrl_gpio_free(gpio);
         |         ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_gpio_get_direction':
   drivers/pinctrl/pinctrl-upboard.c:958:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     958 |         unsigned int padcfg0 = readl(pctrl->pins[pin].regs);
         |         ^~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_gpio_direction_input':
   drivers/pinctrl/pinctrl-upboard.c:1039:16: error: implicit declaration of function 'pinctrl_gpio_direction_input'; did you mean 'upboard_gpio_direction_input'? [-Werror=implicit-function-declaration]
    1039 |         return pinctrl_gpio_direction_input(gpio);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                upboard_gpio_direction_input
   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_gpio_direction_output':
   drivers/pinctrl/pinctrl-upboard.c:1051:16: error: implicit declaration of function 'pinctrl_gpio_direction_output'; did you mean 'upboard_gpio_direction_output'? [-Werror=implicit-function-declaration]
    1051 |         return pinctrl_gpio_direction_output(gpio);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                upboard_gpio_direction_output
   drivers/pinctrl/pinctrl-upboard.c: At top level:
>> drivers/pinctrl/pinctrl-upboard.c:1106:5: warning: no previous prototype for 'upboard_acpi_node_pin_mapping' [-Wmissing-prototypes]
    1106 | int upboard_acpi_node_pin_mapping(struct upboard_fpga *fpga,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/pinctrl-upboard.c:91:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      91 | #define BOARD_UP_APL03                          9
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1166:26: note: in expansion of macro 'BOARD_UP_APL03'
    1166 |                 .ident = BOARD_UP_APL03,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:91:49: note: (near initialization for 'upboard_dmi_table[0].ident')
      91 | #define BOARD_UP_APL03                          9
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1166:26: note: in expansion of macro 'BOARD_UP_APL03'
    1166 |                 .ident = BOARD_UP_APL03,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:88:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      88 | #define BOARD_UP_WHL01                          5
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1173:26: note: in expansion of macro 'BOARD_UP_WHL01'
    1173 |                 .ident = BOARD_UP_WHL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:88:49: note: (near initialization for 'upboard_dmi_table[1].ident')
      88 | #define BOARD_UP_WHL01                          5
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1173:26: note: in expansion of macro 'BOARD_UP_WHL01'
    1173 |                 .ident = BOARD_UP_WHL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:93:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      93 | #define BOARD_UPX_TGL                           11
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1180:26: note: in expansion of macro 'BOARD_UPX_TGL'
    1180 |                 .ident = BOARD_UPX_TGL,
         |                          ^~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:93:49: note: (near initialization for 'upboard_dmi_table[2].ident')
      93 | #define BOARD_UPX_TGL                           11
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1180:26: note: in expansion of macro 'BOARD_UPX_TGL'
    1180 |                 .ident = BOARD_UPX_TGL,
         |                          ^~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:95:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      95 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1187:26: note: in expansion of macro 'BOARD_UPN_EHL01'
    1187 |                 .ident = BOARD_UPN_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:95:49: note: (near initialization for 'upboard_dmi_table[3].ident')
      95 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1187:26: note: in expansion of macro 'BOARD_UPN_EHL01'
    1187 |                 .ident = BOARD_UPN_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:95:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      95 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:96:49: note: in expansion of macro 'BOARD_UPN_EHL01'
      96 | #define BOARD_UPS_EHL01                         BOARD_UPN_EHL01
         |                                                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1194:26: note: in expansion of macro 'BOARD_UPS_EHL01'
    1194 |                 .ident = BOARD_UPS_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:95:49: note: (near initialization for 'upboard_dmi_table[4].ident')
      95 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:96:49: note: in expansion of macro 'BOARD_UPN_EHL01'
      96 | #define BOARD_UPS_EHL01                         BOARD_UPN_EHL01
         |                                                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1194:26: note: in expansion of macro 'BOARD_UPS_EHL01'
    1194 |                 .ident = BOARD_UPS_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:97:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      97 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1201:26: note: in expansion of macro 'BOARD_UPX_ADLP01'
    1201 |                 .ident = BOARD_UPX_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:97:49: note: (near initialization for 'upboard_dmi_table[5].ident')
      97 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1201:26: note: in expansion of macro 'BOARD_UPX_ADLP01'
    1201 |                 .ident = BOARD_UPX_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:98:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      98 | #define BOARD_UPN_ADLN01                        16
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1208:26: note: in expansion of macro 'BOARD_UPN_ADLN01'
    1208 |                 .ident = BOARD_UPN_ADLN01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:98:49: note: (near initialization for 'upboard_dmi_table[6].ident')
      98 | #define BOARD_UPN_ADLN01                        16
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1208:26: note: in expansion of macro 'BOARD_UPN_ADLN01'
    1208 |                 .ident = BOARD_UPN_ADLN01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:97:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      97 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:99:49: note: in expansion of macro 'BOARD_UPX_ADLP01'
      99 | #define BOARD_UPS_ADLP01                        BOARD_UPX_ADLP01
         |                                                 ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1215:26: note: in expansion of macro 'BOARD_UPS_ADLP01'
    1215 |                 .ident = BOARD_UPS_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:97:49: note: (near initialization for 'upboard_dmi_table[7].ident')
      97 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:99:49: note: in expansion of macro 'BOARD_UPX_ADLP01'
      99 | #define BOARD_UPS_ADLP01                        BOARD_UPX_ADLP01
         |                                                 ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1215:26: note: in expansion of macro 'BOARD_UPS_ADLP01'
    1215 |                 .ident = BOARD_UPS_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:98:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      98 | #define BOARD_UPN_ADLN01                        16
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:100:49: note: in expansion of macro 'BOARD_UPN_ADLN01'
     100 | #define BOARD_UP_ADLN01                         BOARD_UPN_ADLN01
         |                                                 ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1222:26: note: in expansion of macro 'BOARD_UP_ADLN01'
    1222 |                 .ident = BOARD_UP_ADLN01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:98:49: note: (near initialization for 'upboard_dmi_table[8].ident')
      98 | #define BOARD_UPN_ADLN01                        16
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:100:49: note: in expansion of macro 'BOARD_UPN_ADLN01'
     100 | #define BOARD_UP_ADLN01                         BOARD_UPN_ADLN01
         |                                                 ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1222:26: note: in expansion of macro 'BOARD_UP_ADLN01'
    1222 |                 .ident = BOARD_UP_ADLN01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_pinctrl_probe':
>> drivers/pinctrl/pinctrl-upboard.c:1353:30: warning: assignment to 'int' from 'const char *' makes integer from pointer without a cast [-Wint-conversion]
    1353 |                 pctrl->ident = system_id->ident;
         |                              ^
   drivers/pinctrl/pinctrl-upboard.c: At top level:
>> drivers/pinctrl/pinctrl-upboard.c:327:38: warning: 'pin_functions' defined but not used [-Wunused-const-variable=]
     327 | static const struct upboard_function pin_functions[] = {
         |                                      ^~~~~~~~~~~~~
>> drivers/pinctrl/pinctrl-upboard.c:305:38: warning: 'pin_groups' defined but not used [-Wunused-const-variable=]
     305 | static const struct upboard_pingroup pin_groups[] = {
         |                                      ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/locked +727 drivers/pinctrl/pinctrl-upboard.c

   720	
   721	static void upboard_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
   722					 unsigned int pin)
   723	{
   724		struct upboard_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
   725		void __iomem *padcfg;
   726		u32 cfg0, cfg1, mode;
 > 727		int locked;
   728	
   729		if (pctrl->pins[pin].regs == NULL)
   730			return;
   731	
   732		cfg0 = readl(pctrl->pins[pin].regs);
   733		cfg1 = readl(pctrl->pins[pin].regs + PADCFG1);
   734	
   735		mode = (cfg0 & PADCFG0_PMODE_MASK) >> PADCFG0_PMODE_SHIFT;
   736		if (mode == PADCFG0_PMODE_GPIO)
 > 737			seq_puts(s, "GPIO ");
   738		else
 > 739			seq_printf(s, "mode %d ", mode);
   740	
   741		seq_printf(s, "0x%08x 0x%08x", cfg0, cfg1);
   742	
   743		/* Dump the additional PADCFG registers if available */
   744		padcfg = pctrl->pins[pin].regs + PADCFG2;
   745		if (padcfg)
   746			seq_printf(s, " 0x%08x", readl(padcfg));
   747	
   748		seq_printf(s, " 0x%08x", pctrl->pins[pin].regs);
   749	}
   750	
   751	static const struct pinctrl_ops upboard_pinctrl_ops = {
   752		.get_groups_count = upboard_get_groups_count,
   753		.get_group_name = upboard_get_group_name,
   754		.pin_dbg_show = upboard_pin_dbg_show,
   755	};
   756	
   757	static struct pinctrl_desc upboard_up_pinctrl_desc = {
   758		.pins = upboard_up_pins,
   759		.npins = ARRAY_SIZE(upboard_up_pins),
   760		.pctlops = &upboard_pinctrl_ops,
   761		.pmxops = &upboard_pinmux_ops,
   762		.owner = THIS_MODULE,
   763	};
   764	
   765	static struct pinctrl_desc upboard_up2_pinctrl_desc = {
   766		.pins = upboard_up2_pins,
   767		.npins = ARRAY_SIZE(upboard_up2_pins),
   768		.pctlops = &upboard_pinctrl_ops,
   769		.pmxops = &upboard_pinmux_ops,
   770		.owner = THIS_MODULE,
   771	};
   772	
   773	static struct pinctrl_desc upboard_upcore_crex_pinctrl_desc = {
   774		.pins = upboard_upcore_crex_pins,
   775		.npins = ARRAY_SIZE(upboard_upcore_crex_pins),
   776		.pctlops = &upboard_pinctrl_ops,
   777		.pmxops = &upboard_pinmux_ops,
   778		.owner = THIS_MODULE,
   779	};
   780	
   781	static struct pinctrl_desc upboard_upcore_crst02_pinctrl_desc = {
   782		.pins = upboard_upcore_crst02_pins,
   783		.npins = ARRAY_SIZE(upboard_upcore_crst02_pins),
   784		.pctlops = &upboard_pinctrl_ops,
   785		.pmxops = &upboard_pinmux_ops,
   786		.owner = THIS_MODULE,
   787	};
   788	
   789	static void upboard_alt_func_enable(struct gpio_chip *gc, const char *name, int id)
   790	{
   791		struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
 > 792		int offset[pctrl->pctldesc->npins];
   793		int i, cnt;
   794	
   795		/* find all pins */
   796		for (i = 0, cnt = 0; i < pctrl->pctldesc->npins; i++) {
   797			if (strstr(pctrl->pctldesc->pins[i].name, name))
   798				offset[cnt++] = i;
   799		}
   800	
   801		/* change to alternate function */
   802		for (i = 0; i < cnt; i++) {
   803			if (pctrl->pins[offset[i]].regs == NULL)
   804				continue;
 > 805			bool input = false;
   806			int mode = 0; /* default GPIO */
   807			unsigned int val = readl(pctrl->pins[offset[i]].regs);
   808	
   809			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "I2C") ||
   810			    strstr(pctrl->pctldesc->pins[offset[i]].name, "PINMUX")) {
   811				mode = 1;
   812				switch (id) {
   813				case BOARD_UPN_ADLN01:
   814				case BOARD_UPX_ADLP01:
   815					mode = 2;
   816					break;
   817				default:
   818					break;
   819				}
   820	
   821				val |= mode<<PADCFG0_PMODE_SHIFT;
   822				writel(val, pctrl->pins[offset[i]].regs);
   823				upboard_fpga_request_free(pctrl->pctldev, offset[i]);
   824				continue;
   825			}
   826	
   827			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "UART")) {
   828				mode = 1;
   829				switch (id) {
   830				case BOARD_UPN_EHL01:
   831					mode = 4;
   832					break;
   833				case BOARD_UPN_ADLN01:
   834				case BOARD_UPX_ADLP01:
   835					mode = 2;
   836					break;
   837				default:
   838					break;
   839				}
   840			}
   841	
   842			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "SPI")) {
   843				mode = 1;
   844				switch (id) {
   845				case BOARD_UP_WHL01:
   846					mode = 3;
   847					break;
   848				case BOARD_UPN_ADLN01:
   849				case BOARD_UPX_ADLP01:
   850					mode = 7;
   851					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MOSI")) {
   852						val &= ~PADCFG0_GPIOTXDIS;
   853						val |= PADCFG0_GPIORXDIS;
   854					}
   855	
   856					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MISO"))
   857						val |= PADCFG0_GPIORXDIS;
   858	
   859					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CLK")) {
   860						val &= ~PADCFG0_GPIOTXDIS;
   861						val |= PADCFG0_GPIORXDIS;
   862					}
   863					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CS0"))
   864						val |= PADCFG0_GPIORXDIS;
   865	
   866					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CS1"))
   867						continue;
   868					break;
   869				default:
   870					break;
   871				}
   872			}
   873	
   874			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "I2S")) {
   875				mode = 1;
   876				switch (id) {
   877				case BOARD_UPX_ADLP01:
   878					mode = 4;
   879					break;
   880				default:
   881					break;
   882				}
   883			}
   884	
   885			val |= mode<<PADCFG0_PMODE_SHIFT;
   886			writel(val, pctrl->pins[offset[i]].regs);
   887	
   888			/* input pins */
   889			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "RX"))
   890				input = true;
   891	
   892			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CTS"))
   893				input = true;
   894	
   895			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "ADC")) {
   896				input = true;
   897				if (id == BOARD_UP_APL01)
   898					upboard_fpga_request_enable(pctrl->pctldev, NULL, offset[i]);
   899				else
   900					upboard_fpga_request_free(pctrl->pctldev, offset[i]);
   901			}
   902	
   903			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MISO"))
   904				input = true;
   905	
   906			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "DIN"))
   907				input = true;
   908	
   909			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "SDI"))
   910				input = true;
   911	
   912			upboard_fpga_set_direction(pctrl->pctldev, NULL, offset[i], input);
   913		}
   914	}
   915	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
