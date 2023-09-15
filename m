Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7A57A2695
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbjIOSuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237016AbjIOSt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:49:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6C246AC;
        Fri, 15 Sep 2023 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694803698; x=1726339698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w8Vd8w3fs3gL9eusBn8RDURLP2JQlaTPVkIaTs0Spg4=;
  b=lp2nQJlOryxr2P0qibLR3uVMMSAXSmgJkcptgdMkJkae5A/uS+wXjqaJ
   +YGWLnxrWp0W9jghKSQZYFb5X39PgsKk5T2DEfkv3xuYsB2jH1vTLjInt
   bDqTlSndKga6Ltc/+ioRrGSeIHcTajwku6VhPMKzYFxJKi/X3ZytQhqVO
   W3TvONYzaaqfn4KuPjIPgSgtbXqFB24m10ILBoI34jXWOp+Z4d8RXK9nu
   hn0xcd4kWGOW9df+08uPxjhyyGyVncoVQ7UOLNm4dt9VJ1pyx7+bR0Uja
   rKirZqUxXoTQo/0llWr6/jjhrV1NLsQDXdVlUa6JLwp/Sh6EvNzfmDdyY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="364371823"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="364371823"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 11:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="738423414"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="738423414"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Sep 2023 11:46:42 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qhDpw-0003IK-0P;
        Fri, 15 Sep 2023 18:46:40 +0000
Date:   Sat, 16 Sep 2023 02:46:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "larry.lai" <larry.lai@yunjingtech.com>, lee@kernel.org,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        pavel@ucw.cz
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, noah.hung@yunjingtech.com,
        "larry.lai" <larry.lai@yunjingtech.com>
Subject: Re: [PATCH V6 2/3] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Message-ID: <202309160256.4y4zg2ZM-lkp@intel.com>
References: <20230915031123.14515-3-larry.lai@yunjingtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915031123.14515-3-larry.lai@yunjingtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi larry.lai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4fe89d07dcc2804c8b562f6c7896a45643d34b2f]

url:    https://github.com/intel-lab-lkp/linux/commits/larry-lai/mfd-Add-support-for-UP-board-CPLD-FPGA/20230915-111244
base:   4fe89d07dcc2804c8b562f6c7896a45643d34b2f
patch link:    https://lore.kernel.org/r/20230915031123.14515-3-larry.lai%40yunjingtech.com
patch subject: [PATCH V6 2/3] pinctrl: Add support pin control for UP board CPLD/FPGA
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230916/202309160256.4y4zg2ZM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230916/202309160256.4y4zg2ZM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309160256.4y4zg2ZM-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_pin_dbg_show':
>> drivers/pinctrl/pinctrl-upboard.c:748:30: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'void *' [-Wformat=]
     748 |         seq_printf(s, " 0x%08x", pctrl->pins[pin].regs);
         |                           ~~~^   ~~~~~~~~~~~~~~~~~~~~~
         |                              |                   |
         |                              unsigned int        void *
         |                           %08p
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
   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_gpio_get_direction':
   drivers/pinctrl/pinctrl-upboard.c:960:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     960 |         unsigned int padcfg0 = readl(pctrl->pins[pin].regs);
         |         ^~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c: At top level:
>> drivers/pinctrl/pinctrl-upboard.c:1109:5: warning: no previous prototype for 'upboard_acpi_node_pin_mapping' [-Wmissing-prototypes]
    1109 | int upboard_acpi_node_pin_mapping(struct upboard_fpga *fpga,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/pinctrl-upboard.c:84:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      84 | #define BOARD_UP_APL01                          1
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1170:26: note: in expansion of macro 'BOARD_UP_APL01'
    1170 |                 .ident = BOARD_UP_APL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:84:49: note: (near initialization for 'upboard_dmi_table[0].ident')
      84 | #define BOARD_UP_APL01                          1
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1170:26: note: in expansion of macro 'BOARD_UP_APL01'
    1170 |                 .ident = BOARD_UP_APL01,
         |                          ^~~~~~~~~~~~~~
>> drivers/pinctrl/pinctrl-upboard.c:84:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      84 | #define BOARD_UP_APL01                          1
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1177:26: note: in expansion of macro 'BOARD_UP_APL01'
    1177 |                 .ident = BOARD_UP_APL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:84:49: note: (near initialization for 'upboard_dmi_table[1].ident')
      84 | #define BOARD_UP_APL01                          1
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1177:26: note: in expansion of macro 'BOARD_UP_APL01'
    1177 |                 .ident = BOARD_UP_APL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:91:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      91 | #define BOARD_UP_APL03                          9
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1184:26: note: in expansion of macro 'BOARD_UP_APL03'
    1184 |                 .ident = BOARD_UP_APL03,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:91:49: note: (near initialization for 'upboard_dmi_table[2].ident')
      91 | #define BOARD_UP_APL03                          9
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1184:26: note: in expansion of macro 'BOARD_UP_APL03'
    1184 |                 .ident = BOARD_UP_APL03,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:88:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      88 | #define BOARD_UP_WHL01                          5
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1191:26: note: in expansion of macro 'BOARD_UP_WHL01'
    1191 |                 .ident = BOARD_UP_WHL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:88:49: note: (near initialization for 'upboard_dmi_table[3].ident')
      88 | #define BOARD_UP_WHL01                          5
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1191:26: note: in expansion of macro 'BOARD_UP_WHL01'
    1191 |                 .ident = BOARD_UP_WHL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:93:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      93 | #define BOARD_UPX_TGL                           11
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1198:26: note: in expansion of macro 'BOARD_UPX_TGL'
    1198 |                 .ident = BOARD_UPX_TGL,
         |                          ^~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:93:49: note: (near initialization for 'upboard_dmi_table[4].ident')
      93 | #define BOARD_UPX_TGL                           11
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1198:26: note: in expansion of macro 'BOARD_UPX_TGL'
    1198 |                 .ident = BOARD_UPX_TGL,
         |                          ^~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:95:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      95 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1205:26: note: in expansion of macro 'BOARD_UPN_EHL01'
    1205 |                 .ident = BOARD_UPN_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:95:49: note: (near initialization for 'upboard_dmi_table[5].ident')
      95 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1205:26: note: in expansion of macro 'BOARD_UPN_EHL01'
    1205 |                 .ident = BOARD_UPN_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:95:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      95 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:96:49: note: in expansion of macro 'BOARD_UPN_EHL01'
      96 | #define BOARD_UPS_EHL01                         BOARD_UPN_EHL01
         |                                                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1212:26: note: in expansion of macro 'BOARD_UPS_EHL01'
    1212 |                 .ident = BOARD_UPS_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:95:49: note: (near initialization for 'upboard_dmi_table[6].ident')
      95 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:96:49: note: in expansion of macro 'BOARD_UPN_EHL01'
      96 | #define BOARD_UPS_EHL01                         BOARD_UPN_EHL01
         |                                                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1212:26: note: in expansion of macro 'BOARD_UPS_EHL01'
    1212 |                 .ident = BOARD_UPS_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:97:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      97 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1219:26: note: in expansion of macro 'BOARD_UPX_ADLP01'
    1219 |                 .ident = BOARD_UPX_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:97:49: note: (near initialization for 'upboard_dmi_table[7].ident')
      97 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1219:26: note: in expansion of macro 'BOARD_UPX_ADLP01'
    1219 |                 .ident = BOARD_UPX_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:98:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      98 | #define BOARD_UPN_ADLN01                        16
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1226:26: note: in expansion of macro 'BOARD_UPN_ADLN01'
    1226 |                 .ident = BOARD_UPN_ADLN01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:98:49: note: (near initialization for 'upboard_dmi_table[8].ident')
      98 | #define BOARD_UPN_ADLN01                        16
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1226:26: note: in expansion of macro 'BOARD_UPN_ADLN01'
    1226 |                 .ident = BOARD_UPN_ADLN01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:97:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      97 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:99:49: note: in expansion of macro 'BOARD_UPX_ADLP01'
      99 | #define BOARD_UPS_ADLP01                        BOARD_UPX_ADLP01
         |                                                 ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1233:26: note: in expansion of macro 'BOARD_UPS_ADLP01'
    1233 |                 .ident = BOARD_UPS_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:97:49: note: (near initialization for 'upboard_dmi_table[9].ident')
      97 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:99:49: note: in expansion of macro 'BOARD_UPX_ADLP01'
      99 | #define BOARD_UPS_ADLP01                        BOARD_UPX_ADLP01
         |                                                 ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1233:26: note: in expansion of macro 'BOARD_UPS_ADLP01'
    1233 |                 .ident = BOARD_UPS_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:100:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     100 | #define BOARD_UP_ADLN01                         18
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1240:26: note: in expansion of macro 'BOARD_UP_ADLN01'
    1240 |                 .ident = BOARD_UP_ADLN01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:100:49: note: (near initialization for 'upboard_dmi_table[10].ident')
     100 | #define BOARD_UP_ADLN01                         18
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1240:26: note: in expansion of macro 'BOARD_UP_ADLN01'
    1240 |                 .ident = BOARD_UP_ADLN01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_pinctrl_probe':
>> drivers/pinctrl/pinctrl-upboard.c:1266:26: warning: assignment to 'int' from 'const char *' makes integer from pointer without a cast [-Wint-conversion]
    1266 |                 board_id = system_id->ident;
         |                          ^
   drivers/pinctrl/pinctrl-upboard.c: At top level:
>> drivers/pinctrl/pinctrl-upboard.c:327:38: warning: 'pin_functions' defined but not used [-Wunused-const-variable=]
     327 | static const struct upboard_function pin_functions[] = {
         |                                      ^~~~~~~~~~~~~
>> drivers/pinctrl/pinctrl-upboard.c:305:38: warning: 'pin_groups' defined but not used [-Wunused-const-variable=]
     305 | static const struct upboard_pingroup pin_groups[] = {
         |                                      ^~~~~~~~~~


vim +748 drivers/pinctrl/pinctrl-upboard.c

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
   737			seq_puts(s, "GPIO ");
   738		else
   739			seq_printf(s, "mode %d ", mode);
   740	
   741		seq_printf(s, "0x%08x 0x%08x", cfg0, cfg1);
   742	
   743		/* Dump the additional PADCFG registers if available */
   744		padcfg = pctrl->pins[pin].regs + PADCFG2;
   745		if (padcfg)
   746			seq_printf(s, " 0x%08x", readl(padcfg));
   747	
 > 748		seq_printf(s, " 0x%08x", pctrl->pins[pin].regs);
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
   833				case BOARD_UP_ADLN01:
   834				case BOARD_UPN_ADLN01:
   835				case BOARD_UPX_ADLP01:
   836					mode = 2;
   837					break;
   838				default:
   839					break;
   840				}
   841			}
   842	
   843			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "SPI")) {
   844				mode = 1;
   845				switch (id) {
   846				case BOARD_UP_WHL01:
   847					mode = 3;
   848					break;
   849				case BOARD_UP_ADLN01:
   850				case BOARD_UPN_ADLN01:
   851				case BOARD_UPX_ADLP01:
   852					mode = 7;
   853					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MOSI")) {
   854						val &= ~PADCFG0_GPIOTXDIS;
   855						val |= PADCFG0_GPIORXDIS;
   856					}
   857	
   858					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MISO"))
   859						val |= PADCFG0_GPIORXDIS;
   860	
   861					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CLK")) {
   862						val &= ~PADCFG0_GPIOTXDIS;
   863						val |= PADCFG0_GPIORXDIS;
   864					}
   865					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CS0"))
   866						val |= PADCFG0_GPIORXDIS;
   867	
   868					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CS1"))
   869						continue;
   870					break;
   871				default:
   872					break;
   873				}
   874			}
   875	
   876			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "I2S")) {
   877				mode = 1;
   878				switch (id) {
   879				case BOARD_UPX_ADLP01:
   880					mode = 4;
   881					break;
   882				default:
   883					break;
   884				}
   885			}
   886	
   887			val |= mode<<PADCFG0_PMODE_SHIFT;
   888			writel(val, pctrl->pins[offset[i]].regs);
   889	
   890			/* input pins */
   891			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "RX"))
   892				input = true;
   893	
   894			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CTS"))
   895				input = true;
   896	
   897			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "ADC")) {
   898				input = true;
   899				if (id == BOARD_UP_APL01)
   900					upboard_fpga_request_enable(pctrl->pctldev, NULL, offset[i]);
   901				else
   902					upboard_fpga_request_free(pctrl->pctldev, offset[i]);
   903			}
   904	
   905			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MISO"))
   906				input = true;
   907	
   908			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "DIN"))
   909				input = true;
   910	
   911			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "SDI"))
   912				input = true;
   913	
   914			upboard_fpga_set_direction(pctrl->pctldev, NULL, offset[i], input);
   915		}
   916	}
   917	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
