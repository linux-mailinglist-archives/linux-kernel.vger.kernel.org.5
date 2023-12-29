Return-Path: <linux-kernel+bounces-13003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 210DA81FE4E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2991F232BA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC34107A1;
	Fri, 29 Dec 2023 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avgJgm0t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2019CFBF9;
	Fri, 29 Dec 2023 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703840019; x=1735376019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KEH0DzktZzMChMErKUnMsrxem7mhAA7Bkaa1QsiaQvA=;
  b=avgJgm0t6DNzelmOTNHvNBcccARuxCWCY08ic6xmKyELhAfWEZrRfsQS
   qk9y8jpgiO5ChF8ZRUSHAfl2gujLZyScJVdxd9x2mlq9mD3y5FpkMIhK5
   0anlkKS56NLt05JBptabmE9r7+vG7BrngOblxVqNOXIEmqFmDWF5C6tz4
   gDeJk0n0MNOufWlD0u/BQ0QT/KpnXHdmcsvORCwUHMZvDs5Ku37w9S2wi
   YPneuNmgmmEW+byBfXo0SUE+1drylgrdUUtgEfRivuTnchVp6+CO6uPC0
   tvO3DaIJQLoKhHHRpoZBFngWTNb9NddaBMmWWVFsJT856YT3ltlSfV65C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="395522093"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="395522093"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 00:53:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="869351091"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="869351091"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Dec 2023 00:53:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJ8cQ-000HFl-15;
	Fri, 29 Dec 2023 08:53:26 +0000
Date: Fri, 29 Dec 2023 16:52:57 +0800
From: kernel test robot <lkp@intel.com>
To: "larry.lai" <larry.lai@yunjingtech.com>, lee@kernel.org,
	andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
	pavel@ucw.cz, krzk@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
	GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
	jack.chang@yunjingtech.com, noah.hung@yunjingtech.com,
	"larry.lai" <larry.lai@yunjingtech.com>
Subject: Re: [PATCH V8 2/3] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Message-ID: <202312291634.yn0gCqZI-lkp@intel.com>
References: <20231228151544.14408-3-larry.lai@yunjingtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228151544.14408-3-larry.lai@yunjingtech.com>

Hi larry.lai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 4fe89d07dcc2804c8b562f6c7896a45643d34b2f]

url:    https://github.com/intel-lab-lkp/linux/commits/larry-lai/mfd-Add-support-for-UP-board-CPLD-FPGA/20231228-231750
base:   4fe89d07dcc2804c8b562f6c7896a45643d34b2f
patch link:    https://lore.kernel.org/r/20231228151544.14408-3-larry.lai%40yunjingtech.com
patch subject: [PATCH V8 2/3] pinctrl: Add support pin control for UP board CPLD/FPGA
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20231229/202312291634.yn0gCqZI-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231229/202312291634.yn0gCqZI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312291634.yn0gCqZI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_alt_func_enable':
>> drivers/pinctrl/pinctrl-upboard.c:709:9: warning: ISO C90 forbids variable length array 'offset' [-Wvla]
     709 |         int offset[pctrl->pctldesc->npins];
         |         ^~~
   drivers/pinctrl/pinctrl-upboard.c: At top level:
>> drivers/pinctrl/pinctrl-upboard.c:46:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      46 | #define BOARD_UP_APL01                          1
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1089:26: note: in expansion of macro 'BOARD_UP_APL01'
    1089 |                 .ident = BOARD_UP_APL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:46:49: note: (near initialization for 'upboard_dmi_table[0].ident')
      46 | #define BOARD_UP_APL01                          1
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1089:26: note: in expansion of macro 'BOARD_UP_APL01'
    1089 |                 .ident = BOARD_UP_APL01,
         |                          ^~~~~~~~~~~~~~
>> drivers/pinctrl/pinctrl-upboard.c:46:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      46 | #define BOARD_UP_APL01                          1
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1096:26: note: in expansion of macro 'BOARD_UP_APL01'
    1096 |                 .ident = BOARD_UP_APL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:46:49: note: (near initialization for 'upboard_dmi_table[1].ident')
      46 | #define BOARD_UP_APL01                          1
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1096:26: note: in expansion of macro 'BOARD_UP_APL01'
    1096 |                 .ident = BOARD_UP_APL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:53:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      53 | #define BOARD_UP_APL03                          9
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1103:26: note: in expansion of macro 'BOARD_UP_APL03'
    1103 |                 .ident = BOARD_UP_APL03,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:53:49: note: (near initialization for 'upboard_dmi_table[2].ident')
      53 | #define BOARD_UP_APL03                          9
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1103:26: note: in expansion of macro 'BOARD_UP_APL03'
    1103 |                 .ident = BOARD_UP_APL03,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:50:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      50 | #define BOARD_UP_WHL01                          5
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1110:26: note: in expansion of macro 'BOARD_UP_WHL01'
    1110 |                 .ident = BOARD_UP_WHL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:50:49: note: (near initialization for 'upboard_dmi_table[3].ident')
      50 | #define BOARD_UP_WHL01                          5
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1110:26: note: in expansion of macro 'BOARD_UP_WHL01'
    1110 |                 .ident = BOARD_UP_WHL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:55:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      55 | #define BOARD_UPX_TGL                           11
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1117:26: note: in expansion of macro 'BOARD_UPX_TGL'
    1117 |                 .ident = BOARD_UPX_TGL,
         |                          ^~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:55:49: note: (near initialization for 'upboard_dmi_table[4].ident')
      55 | #define BOARD_UPX_TGL                           11
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1117:26: note: in expansion of macro 'BOARD_UPX_TGL'
    1117 |                 .ident = BOARD_UPX_TGL,
         |                          ^~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:57:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      57 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1124:26: note: in expansion of macro 'BOARD_UPN_EHL01'
    1124 |                 .ident = BOARD_UPN_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:57:49: note: (near initialization for 'upboard_dmi_table[5].ident')
      57 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1124:26: note: in expansion of macro 'BOARD_UPN_EHL01'
    1124 |                 .ident = BOARD_UPN_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:57:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      57 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:58:49: note: in expansion of macro 'BOARD_UPN_EHL01'
      58 | #define BOARD_UPS_EHL01                         BOARD_UPN_EHL01
         |                                                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1131:26: note: in expansion of macro 'BOARD_UPS_EHL01'
    1131 |                 .ident = BOARD_UPS_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:57:49: note: (near initialization for 'upboard_dmi_table[6].ident')
      57 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:58:49: note: in expansion of macro 'BOARD_UPN_EHL01'
      58 | #define BOARD_UPS_EHL01                         BOARD_UPN_EHL01
         |                                                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1131:26: note: in expansion of macro 'BOARD_UPS_EHL01'
    1131 |                 .ident = BOARD_UPS_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:59:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      59 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1138:26: note: in expansion of macro 'BOARD_UPX_ADLP01'
    1138 |                 .ident = BOARD_UPX_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:59:49: note: (near initialization for 'upboard_dmi_table[7].ident')
      59 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1138:26: note: in expansion of macro 'BOARD_UPX_ADLP01'
    1138 |                 .ident = BOARD_UPX_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:60:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      60 | #define BOARD_UPN_ADLN01                        16
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1145:26: note: in expansion of macro 'BOARD_UPN_ADLN01'
    1145 |                 .ident = BOARD_UPN_ADLN01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:60:49: note: (near initialization for 'upboard_dmi_table[8].ident')
      60 | #define BOARD_UPN_ADLN01                        16
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1145:26: note: in expansion of macro 'BOARD_UPN_ADLN01'
    1145 |                 .ident = BOARD_UPN_ADLN01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:59:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      59 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:61:49: note: in expansion of macro 'BOARD_UPX_ADLP01'
      61 | #define BOARD_UPS_ADLP01                        BOARD_UPX_ADLP01
         |                                                 ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1152:26: note: in expansion of macro 'BOARD_UPS_ADLP01'
    1152 |                 .ident = BOARD_UPS_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:59:49: note: (near initialization for 'upboard_dmi_table[9].ident')
      59 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:61:49: note: in expansion of macro 'BOARD_UPX_ADLP01'
      61 | #define BOARD_UPS_ADLP01                        BOARD_UPX_ADLP01
         |                                                 ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:1152:26: note: in expansion of macro 'BOARD_UPS_ADLP01'
    1152 |                 .ident = BOARD_UPS_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:62:49: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      62 | #define BOARD_UP_ADLN01                         18
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1159:26: note: in expansion of macro 'BOARD_UP_ADLN01'
    1159 |                 .ident = BOARD_UP_ADLN01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:62:49: note: (near initialization for 'upboard_dmi_table[10].ident')
      62 | #define BOARD_UP_ADLN01                         18
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1159:26: note: in expansion of macro 'BOARD_UP_ADLN01'
    1159 |                 .ident = BOARD_UP_ADLN01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c: In function 'upboard_pinctrl_probe':
>> drivers/pinctrl/pinctrl-upboard.c:1185:26: warning: assignment to 'int' from 'const char *' makes integer from pointer without a cast [-Wint-conversion]
    1185 |                 board_id = system_id->ident;
         |                          ^


vim +/offset +709 drivers/pinctrl/pinctrl-upboard.c

   705	
   706	static void upboard_alt_func_enable(struct gpio_chip *gc, const char *name, int id)
   707	{
   708		struct upboard_pinctrl *pctrl = container_of(gc, struct upboard_pinctrl, chip);
 > 709		int offset[pctrl->pctldesc->npins];
   710		int i, cnt;
   711		bool input;
   712		int mode;
   713		unsigned int val;
   714	
   715		/* find all pins */
   716		for (i = 0, cnt = 0; i < pctrl->pctldesc->npins; i++) {
   717			if (strstr(pctrl->pctldesc->pins[i].name, name))
   718				offset[cnt++] = i;
   719		}
   720	
   721		/* change to alternate function */
   722		for (i = 0; i < cnt; i++) {
   723			if (pctrl->pins[offset[i]].regs == NULL)
   724				continue;
   725			input = false;
   726			mode = 0; /* default GPIO */
   727			val = readl(pctrl->pins[offset[i]].regs);
   728	
   729			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "I2C") ||
   730			    strstr(pctrl->pctldesc->pins[offset[i]].name, "PINMUX")) {
   731				mode = 1;
   732				switch (id) {
   733				case BOARD_UPN_ADLN01:
   734				case BOARD_UPX_ADLP01:
   735					mode = 2;
   736					break;
   737				default:
   738					break;
   739				}
   740	
   741				val |= mode<<PADCFG0_PMODE_SHIFT;
   742				writel(val, pctrl->pins[offset[i]].regs);
   743				upboard_fpga_request_free(pctrl->pctldev, offset[i]);
   744				continue;
   745			}
   746	
   747			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "UART")) {
   748				mode = 1;
   749				switch (id) {
   750				case BOARD_UPN_EHL01:
   751					mode = 4;
   752					break;
   753				case BOARD_UP_ADLN01:
   754				case BOARD_UPN_ADLN01:
   755				case BOARD_UPX_ADLP01:
   756					mode = 2;
   757					break;
   758				default:
   759					break;
   760				}
   761			}
   762	
   763			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "SPI")) {
   764				mode = 1;
   765				switch (id) {
   766				case BOARD_UP_WHL01:
   767					mode = 3;
   768					break;
   769				case BOARD_UP_ADLN01:
   770				case BOARD_UPN_ADLN01:
   771				case BOARD_UPX_ADLP01:
   772					mode = 7;
   773					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MOSI")) {
   774						val &= ~PADCFG0_GPIOTXDIS;
   775						val |= PADCFG0_GPIORXDIS;
   776					}
   777	
   778					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MISO"))
   779						val |= PADCFG0_GPIORXDIS;
   780	
   781					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CLK")) {
   782						val &= ~PADCFG0_GPIOTXDIS;
   783						val |= PADCFG0_GPIORXDIS;
   784					}
   785					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CS0"))
   786						val |= PADCFG0_GPIORXDIS;
   787	
   788					if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CS1"))
   789						continue;
   790					break;
   791				default:
   792					break;
   793				}
   794			}
   795	
   796			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "I2S")) {
   797				mode = 1;
   798				switch (id) {
   799				case BOARD_UPX_ADLP01:
   800					mode = 4;
   801					break;
   802				default:
   803					break;
   804				}
   805			}
   806	
   807			val |= mode<<PADCFG0_PMODE_SHIFT;
   808			writel(val, pctrl->pins[offset[i]].regs);
   809	
   810			/* input pins */
   811			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "RX"))
   812				input = true;
   813	
   814			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "CTS"))
   815				input = true;
   816	
   817			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "ADC")) {
   818				input = true;
   819				if (id == BOARD_UP_APL01)
   820					upboard_fpga_request_enable(pctrl->pctldev, NULL, offset[i]);
   821				else
   822					upboard_fpga_request_free(pctrl->pctldev, offset[i]);
   823			}
   824	
   825			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "MISO"))
   826				input = true;
   827	
   828			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "DIN"))
   829				input = true;
   830	
   831			if (strstr(pctrl->pctldesc->pins[offset[i]].name, "SDI"))
   832				input = true;
   833	
   834			upboard_fpga_set_direction(pctrl->pctldev, NULL, offset[i], input);
   835		}
   836	}
   837	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

