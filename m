Return-Path: <linux-kernel+bounces-13072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6DC81FF44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E71FD1F234BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158EE11198;
	Fri, 29 Dec 2023 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYQ4rxAL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FCC11185;
	Fri, 29 Dec 2023 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703851023; x=1735387023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DTlQJczvvFLgdrK2fpElfp8nTf07vIktGqkhqHM/r1k=;
  b=dYQ4rxALqRfdKwOOD5Y4tO3ScxMxbYa941xQLbghDcEdOoFll4VgacYj
   JI2y76p6g0RsFu0WeuW+gSixM7W2wgtxoiUfe7m1Y6GX7JlYmxKbRXTAU
   7tRao57xVy4a0bLb0F+eTxExRIxFHz+ufAgW4lJqc5Uf2X6lkHnKI7lOK
   ccqmFirN9FiJAfRyOUMcQCq9w2qAQiWGrhVjFzLfyOnHnyEQkiTKmFMOd
   il49SfGuU6qhUll2myawNQhreYiXvlIzgpwNKhu/XTCCpMNbZIXzhUmtw
   +v4ptkkQ+46Yw7nxiJlR4JJ44SlSyAq409G6mjkSFLl84+PNqY3IGswRx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="400449337"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="400449337"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 03:57:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="778798949"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="778798949"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 29 Dec 2023 03:56:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJBU0-000HQ2-2D;
	Fri, 29 Dec 2023 11:56:56 +0000
Date: Fri, 29 Dec 2023 19:56:17 +0800
From: kernel test robot <lkp@intel.com>
To: "larry.lai" <larry.lai@yunjingtech.com>, lee@kernel.org,
	andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
	pavel@ucw.cz, krzk@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
	musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
	noah.hung@yunjingtech.com, "larry.lai" <larry.lai@yunjingtech.com>
Subject: Re: [PATCH V8 2/3] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Message-ID: <202312291907.7mgFSafz-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 4fe89d07dcc2804c8b562f6c7896a45643d34b2f]

url:    https://github.com/intel-lab-lkp/linux/commits/larry-lai/mfd-Add-support-for-UP-board-CPLD-FPGA/20231228-231750
base:   4fe89d07dcc2804c8b562f6c7896a45643d34b2f
patch link:    https://lore.kernel.org/r/20231228151544.14408-3-larry.lai%40yunjingtech.com
patch subject: [PATCH V8 2/3] pinctrl: Add support pin control for UP board CPLD/FPGA
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20231229/202312291907.7mgFSafz-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231229/202312291907.7mgFSafz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312291907.7mgFSafz-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-upboard.c:709:13: warning: variable length array used [-Wvla]
     709 |         int offset[pctrl->pctldesc->npins];
         |                    ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/pinctrl/pinctrl-upboard.c:1089:12: error: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int' [-Wint-conversion]
    1089 |                 .ident = BOARD_UP_APL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:46:27: note: expanded from macro 'BOARD_UP_APL01'
      46 | #define BOARD_UP_APL01                          1
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1096:12: error: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int' [-Wint-conversion]
    1096 |                 .ident = BOARD_UP_APL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:46:27: note: expanded from macro 'BOARD_UP_APL01'
      46 | #define BOARD_UP_APL01                          1
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1103:12: error: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int' [-Wint-conversion]
    1103 |                 .ident = BOARD_UP_APL03,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:53:27: note: expanded from macro 'BOARD_UP_APL03'
      53 | #define BOARD_UP_APL03                          9
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1110:12: error: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int' [-Wint-conversion]
    1110 |                 .ident = BOARD_UP_WHL01,
         |                          ^~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:50:27: note: expanded from macro 'BOARD_UP_WHL01'
      50 | #define BOARD_UP_WHL01                          5
         |                                                 ^
   drivers/pinctrl/pinctrl-upboard.c:1117:12: error: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int' [-Wint-conversion]
    1117 |                 .ident = BOARD_UPX_TGL,
         |                          ^~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:55:26: note: expanded from macro 'BOARD_UPX_TGL'
      55 | #define BOARD_UPX_TGL                           11
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1124:12: error: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int' [-Wint-conversion]
    1124 |                 .ident = BOARD_UPN_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:57:28: note: expanded from macro 'BOARD_UPN_EHL01'
      57 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1131:12: error: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int' [-Wint-conversion]
    1131 |                 .ident = BOARD_UPS_EHL01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:58:28: note: expanded from macro 'BOARD_UPS_EHL01'
      58 | #define BOARD_UPS_EHL01                         BOARD_UPN_EHL01
         |                                                 ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:57:28: note: expanded from macro 'BOARD_UPN_EHL01'
      57 | #define BOARD_UPN_EHL01                         13
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1138:12: error: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int' [-Wint-conversion]
    1138 |                 .ident = BOARD_UPX_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:59:28: note: expanded from macro 'BOARD_UPX_ADLP01'
      59 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1145:12: error: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int' [-Wint-conversion]
    1145 |                 .ident = BOARD_UPN_ADLN01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:60:28: note: expanded from macro 'BOARD_UPN_ADLN01'
      60 | #define BOARD_UPN_ADLN01                        16
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1152:12: error: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int' [-Wint-conversion]
    1152 |                 .ident = BOARD_UPS_ADLP01,
         |                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:61:28: note: expanded from macro 'BOARD_UPS_ADLP01'
      61 | #define BOARD_UPS_ADLP01                        BOARD_UPX_ADLP01
         |                                                 ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:59:28: note: expanded from macro 'BOARD_UPX_ADLP01'
      59 | #define BOARD_UPX_ADLP01                        15
         |                                                 ^~
   drivers/pinctrl/pinctrl-upboard.c:1159:12: error: incompatible integer to pointer conversion initializing 'const char *' with an expression of type 'int' [-Wint-conversion]
    1159 |                 .ident = BOARD_UP_ADLN01,
         |                          ^~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-upboard.c:62:28: note: expanded from macro 'BOARD_UP_ADLN01'
      62 | #define BOARD_UP_ADLN01                         18
         |                                                 ^~
>> drivers/pinctrl/pinctrl-upboard.c:1185:12: error: incompatible pointer to integer conversion assigning to 'int' from 'const char *const' [-Wint-conversion]
    1185 |                 board_id = system_id->ident;
         |                          ^ ~~~~~~~~~~~~~~~~
   1 warning and 12 errors generated.


vim +1089 drivers/pinctrl/pinctrl-upboard.c

  1085	
  1086	/* DMI Matches to assign pin mapping driver data */
  1087	static const struct dmi_system_id upboard_dmi_table[] __initconst = {
  1088		{
> 1089			.ident = BOARD_UP_APL01,
  1090			.matches = { /* UP SQUARED */
  1091				DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
  1092				DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL01"),
  1093			},
  1094		},
  1095		{
  1096			.ident = BOARD_UP_APL01,
  1097			.matches = { /* UP SQUARED Pro*/
  1098				DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
  1099				DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-APL01"),
  1100			},
  1101		},
  1102		{
  1103			.ident = BOARD_UP_APL03,
  1104			.matches = { /* UP 4000 */
  1105				DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
  1106				DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-APL03"),
  1107			},
  1108		},
  1109		{
  1110			.ident = BOARD_UP_WHL01,
  1111			.matches = { /* UPX WHL */
  1112				DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
  1113				DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-WHL01"),
  1114			},
  1115		},
  1116		{
  1117			.ident = BOARD_UPX_TGL,
  1118			.matches = { /* UP i11 */
  1119				DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
  1120				DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPX-TGL01"),
  1121			},
  1122		},
  1123		{
  1124			.ident = BOARD_UPN_EHL01,
  1125			.matches = { /* UP 6000 */
  1126				DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
  1127				DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-EHL01"),
  1128			},
  1129		},
  1130		{
  1131			.ident = BOARD_UPS_EHL01,
  1132			.matches = { /* UP squared v2 */
  1133				DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
  1134				DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPS-EHL01"),
  1135			},
  1136		},
  1137		{
  1138			.ident = BOARD_UPX_ADLP01,
  1139			.matches = { /* UP Xtreme i12 */
  1140				DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
  1141				DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPX-ADLP01"),
  1142			},
  1143		},
  1144		{
  1145			.ident = BOARD_UPN_ADLN01,
  1146			.matches = { /* UP 7000 */
  1147				DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
  1148				DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPN-ADLN01"),
  1149			},
  1150		},
  1151		{
  1152			.ident = BOARD_UPS_ADLP01,
  1153			.matches = { /* UP Squared i12 */
  1154				DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
  1155				DMI_EXACT_MATCH(DMI_BOARD_NAME, "UPS-ADLP01"),
  1156			},
  1157		},
  1158		{
  1159			.ident = BOARD_UP_ADLN01,
  1160			.matches = { /* UP 7000 */
  1161				DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AAEON"),
  1162				DMI_EXACT_MATCH(DMI_BOARD_NAME, "UP-ADLN01"),
  1163			},
  1164		},
  1165		{ }	/* Terminating entry */
  1166	};
  1167	
  1168	static int upboard_pinctrl_probe(struct platform_device *pdev)
  1169	{
  1170		struct upboard_fpga * const fpga = dev_get_drvdata(pdev->dev.parent);
  1171		struct pinctrl_desc *pctldesc;
  1172		struct upboard_pinctrl *pctrl;
  1173		struct upboard_pin *pins;
  1174		const struct dmi_system_id *system_id;
  1175		const unsigned int *rpi_mapping;
  1176		unsigned int ngpio;
  1177		int ret;
  1178		int i;
  1179		/* default */
  1180		int board_id = BOARD_UP_APL03;
  1181	
  1182		/* check board id to arrange driver data */
  1183		system_id = dmi_first_match(upboard_dmi_table);
  1184		if (system_id)
> 1185			board_id = system_id->ident;
  1186		dev_info(&pdev->dev, "Compatible Up Board ID %d", board_id);
  1187		switch (board_id) {
  1188		case BOARD_UP_APL01:
  1189			pctldesc = &upboard_up2_pinctrl_desc;
  1190			rpi_mapping = upboard_up2_rpi_mapping;
  1191			ngpio = ARRAY_SIZE(upboard_up2_rpi_mapping);
  1192			break;
  1193		case BOARD_UP_UPCORE:
  1194			pctldesc = &upboard_upcore_crex_pinctrl_desc;
  1195			rpi_mapping = upboard_upcore_crex_rpi_mapping;
  1196			ngpio = ARRAY_SIZE(upboard_upcore_crex_rpi_mapping);
  1197			break;
  1198		case BOARD_UP_CORE_PLUS:
  1199			pctldesc = &upboard_upcore_crst02_pinctrl_desc;
  1200			rpi_mapping = upboard_upcore_crst02_rpi_mapping;
  1201			ngpio = ARRAY_SIZE(upboard_upcore_crst02_rpi_mapping);
  1202			break;
  1203		default:
  1204			pctldesc = &upboard_up_pinctrl_desc;
  1205			rpi_mapping = upboard_up_rpi_mapping;
  1206			ngpio = ARRAY_SIZE(upboard_up_rpi_mapping);
  1207			break;
  1208		}
  1209	
  1210		pctldesc->name = dev_name(&pdev->dev);
  1211	
  1212		pins = devm_kcalloc(&pdev->dev, pctldesc->npins, sizeof(*pins), GFP_KERNEL);
  1213		if (!pins)
  1214			return -ENOMEM;
  1215	
  1216		/* initialise pins */
  1217		for (i = 0; i < pctldesc->npins; i++) {
  1218			struct upboard_pin *pin = &pins[i];
  1219			struct pinctrl_pin_desc *pd = (struct pinctrl_pin_desc *) &pctldesc->pins[i];
  1220			struct reg_field fldconf = {0};
  1221			unsigned int regoff = (pd->number / UPFPGA_REGISTER_SIZE);
  1222			unsigned int lsb = pd->number % UPFPGA_REGISTER_SIZE;
  1223	
  1224			pin->funcbit = NULL;
  1225	
  1226			if (pd->drv_data) {
  1227				fldconf = *(struct reg_field *)pd->drv_data;
  1228	
  1229				pin->funcbit = devm_regmap_field_alloc(&pdev->dev,
  1230								       fpga->regmap,
  1231								       fldconf);
  1232				if (IS_ERR(pin->funcbit))
  1233					return PTR_ERR(pin->funcbit);
  1234			}
  1235	
  1236			fldconf.reg = UPFPGA_REG_GPIO_EN0 + regoff;
  1237			fldconf.lsb = lsb;
  1238			fldconf.msb = lsb;
  1239	
  1240			pin->enbit = devm_regmap_field_alloc(&pdev->dev,
  1241							     fpga->regmap,
  1242							     fldconf);
  1243			if (IS_ERR(pin->enbit))
  1244				return PTR_ERR(pin->enbit);
  1245	
  1246			fldconf.reg = UPFPGA_REG_GPIO_DIR0 + regoff;
  1247			fldconf.lsb = lsb;
  1248			fldconf.msb = lsb;
  1249	
  1250			pin->dirbit = devm_regmap_field_alloc(&pdev->dev,
  1251							      fpga->regmap,
  1252							      fldconf);
  1253			if (IS_ERR(pin->dirbit))
  1254				return PTR_ERR(pin->dirbit);
  1255	
  1256			pd->drv_data = pin;
  1257		}
  1258	
  1259		/* create a new pinctrl device and register it */
  1260		pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
  1261		if (!pctrl)
  1262			return -ENOMEM;
  1263	
  1264		pctrl->rpi_mapping = rpi_mapping;
  1265		pctrl->chip = upboard_gpio_chip;
  1266		pctrl->pctldesc = pctldesc;
  1267		pctrl->chip.parent = &pdev->dev;
  1268		pctrl->chip.ngpio = ngpio;
  1269		pctrl->pins = pins;
  1270		pctrl->ident = board_id;
  1271	
  1272		ret = devm_gpiochip_add_data(&pdev->dev, &pctrl->chip, pctrl);
  1273		if (ret)
  1274			return ret;
  1275	
  1276		pctrl->pctldev = devm_pinctrl_register(&pdev->dev, pctldesc, pctrl);
  1277		if (IS_ERR(pctrl->pctldev))
  1278			return PTR_ERR(pctrl->pctldev);
  1279	
  1280		/* add acpi pin mapping according to external-gpios key */
  1281		ret = upboard_acpi_node_pin_mapping(fpga, pctrl,
  1282						    "external",
  1283						    dev_name(&pdev->dev),
  1284						    0);
  1285		if (ret)
  1286			return ret;
  1287	
  1288		upboard_alt_func_enable(&pctrl->chip, "I2C",    pctrl->ident);
  1289		upboard_alt_func_enable(&pctrl->chip, "SPI",    pctrl->ident);
  1290		upboard_alt_func_enable(&pctrl->chip, "UART",   pctrl->ident);
  1291		upboard_alt_func_enable(&pctrl->chip, "I2S",    pctrl->ident);
  1292		upboard_alt_func_enable(&pctrl->chip, "PWM",    pctrl->ident);
  1293		upboard_alt_func_enable(&pctrl->chip, "ADC",    pctrl->ident);
  1294		upboard_alt_func_enable(&pctrl->chip, "PINMUX", pctrl->ident);
  1295	
  1296		return ret;
  1297	}
  1298	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

