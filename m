Return-Path: <linux-kernel+bounces-2374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EE6815BD9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 22:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDE11C21748
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1858A35292;
	Sat, 16 Dec 2023 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aP9l9PKl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792C3527A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702762023; x=1734298023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LF1U+urGL4pMU/U6WKZ5rZdge+me5blDVNX0sz0n8ko=;
  b=aP9l9PKlUAcxYmQfLb4K3Y8XfljWPa26cJjYAnRiPuk88kqOhQPjxzBJ
   RWpMTepC8+LxV1TSxkNnBwM+iF/wnvJNYIHiu1dSOGzTOjHj7Ya7wp6MT
   KTNuU+PjfMdemt+aJY5cmHz5utfSKSQ5G53h5hYKJqRPD/Ng0S9bTzHdh
   jWkW0zpsJ6pO2OBiBpeDWnvbC3gCNG/Ht/uA+QX+hXoSxR3KUPJ8+L8Ap
   3Ist5/ElZkmUQQyQ95Of0KsyDSJ3c4lkLU5wB9QZnRbYM3p6vyYSACFV5
   pva/pM1JBO7OGA7mAafw5mldjJTqLzqgMCuqiNI1HCtO5Cjj9BYTY/vTQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="461846429"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="461846429"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 13:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="751323958"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="751323958"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2023 13:27:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEcBV-0002EZ-2a;
	Sat, 16 Dec 2023 21:26:57 +0000
Date: Sun, 17 Dec 2023 05:26:32 +0800
From: kernel test robot <lkp@intel.com>
To: yang.guang5@zte.com.cn, lee@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jiang.xuexin@zte.com.cn,
	chen.haonan2@zte.com.cn, cgel.zte@gmail.com,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] mfd: wm8994: Switch to use dev_err_probe()
 helper
Message-ID: <202312170506.9Yut538Z-lkp@intel.com>
References: <202312142004599156569@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312142004599156569@zte.com.cn>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231214]

url:    https://github.com/intel-lab-lkp/linux/commits/yang-guang5-zte-com-cn/mfd-wm8994-Switch-to-use-dev_err_probe-helper/20231214-200907
base:   next-20231214
patch link:    https://lore.kernel.org/r/202312142004599156569%40zte.com.cn
patch subject: [PATCH linux-next] mfd: wm8994: Switch to use dev_err_probe() helper
config: i386-randconfig-012-20231217 (https://download.01.org/0day-ci/archive/20231217/202312170506.9Yut538Z-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312170506.9Yut538Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312170506.9Yut538Z-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mfd/wm8994-core.c: In function 'wm8994_device_init':
>> drivers/mfd/wm8994-core.c:382:75: warning: format '%d' expects a matching 'int' argument [-Wformat=]
     382 |                 dev_err_probe(wm8994->dev, ret, "Failed to get supplies: %d\n");
         |                                                                          ~^
         |                                                                           |
         |                                                                           int


vim +382 drivers/mfd/wm8994-core.c

   299	
   300	/*
   301	 * Instantiate the generic non-control parts of the device.
   302	 */
   303	static int wm8994_device_init(struct wm8994 *wm8994, int irq)
   304	{
   305		struct wm8994_pdata *pdata;
   306		struct regmap_config *regmap_config;
   307		const struct reg_sequence *regmap_patch = NULL;
   308		const char *devname;
   309		int ret, i, patch_regs = 0;
   310		int pulls = 0;
   311	
   312		if (dev_get_platdata(wm8994->dev)) {
   313			pdata = dev_get_platdata(wm8994->dev);
   314			wm8994->pdata = *pdata;
   315		}
   316		pdata = &wm8994->pdata;
   317	
   318		ret = wm8994_set_pdata_from_of(wm8994);
   319		if (ret != 0)
   320			return ret;
   321	
   322		/* Add the on-chip regulators first for bootstrapping */
   323		ret = mfd_add_devices(wm8994->dev, 0,
   324				      wm8994_regulator_devs,
   325				      ARRAY_SIZE(wm8994_regulator_devs),
   326				      NULL, 0, NULL);
   327		if (ret != 0) {
   328			dev_err(wm8994->dev, "Failed to add children: %d\n", ret);
   329			goto err;
   330		}
   331	
   332		switch (wm8994->type) {
   333		case WM1811:
   334			wm8994->num_supplies = ARRAY_SIZE(wm1811_main_supplies);
   335			break;
   336		case WM8994:
   337			wm8994->num_supplies = ARRAY_SIZE(wm8994_main_supplies);
   338			break;
   339		case WM8958:
   340			wm8994->num_supplies = ARRAY_SIZE(wm8958_main_supplies);
   341			break;
   342		default:
   343			BUG();
   344			goto err;
   345		}
   346	
   347		wm8994->supplies = devm_kcalloc(wm8994->dev,
   348						wm8994->num_supplies,
   349						sizeof(struct regulator_bulk_data),
   350						GFP_KERNEL);
   351		if (!wm8994->supplies) {
   352			ret = -ENOMEM;
   353			goto err;
   354		}
   355	
   356		switch (wm8994->type) {
   357		case WM1811:
   358			for (i = 0; i < ARRAY_SIZE(wm1811_main_supplies); i++)
   359				wm8994->supplies[i].supply = wm1811_main_supplies[i];
   360			break;
   361		case WM8994:
   362			for (i = 0; i < ARRAY_SIZE(wm8994_main_supplies); i++)
   363				wm8994->supplies[i].supply = wm8994_main_supplies[i];
   364			break;
   365		case WM8958:
   366			for (i = 0; i < ARRAY_SIZE(wm8958_main_supplies); i++)
   367				wm8994->supplies[i].supply = wm8958_main_supplies[i];
   368			break;
   369		default:
   370			BUG();
   371			goto err;
   372		}
   373	
   374		/*
   375		 * Can't use devres helper here as some of the supplies are provided by
   376		 * wm8994->dev's children (regulators) and those regulators are
   377		 * unregistered by the devres core before the supplies are freed.
   378		 */
   379		ret = regulator_bulk_get(wm8994->dev, wm8994->num_supplies,
   380					 wm8994->supplies);
   381		if (ret != 0) {
 > 382			dev_err_probe(wm8994->dev, ret, "Failed to get supplies: %d\n");
   383			goto err;
   384		}
   385	
   386		ret = regulator_bulk_enable(wm8994->num_supplies, wm8994->supplies);
   387		if (ret != 0) {
   388			dev_err(wm8994->dev, "Failed to enable supplies: %d\n", ret);
   389			goto err_regulator_free;
   390		}
   391	
   392		ret = wm8994_reg_read(wm8994, WM8994_SOFTWARE_RESET);
   393		if (ret < 0) {
   394			dev_err(wm8994->dev, "Failed to read ID register\n");
   395			goto err_enable;
   396		}
   397		switch (ret) {
   398		case 0x1811:
   399			devname = "WM1811";
   400			if (wm8994->type != WM1811)
   401				dev_warn(wm8994->dev, "Device registered as type %d\n",
   402					 wm8994->type);
   403			wm8994->type = WM1811;
   404			break;
   405		case 0x8994:
   406			devname = "WM8994";
   407			if (wm8994->type != WM8994)
   408				dev_warn(wm8994->dev, "Device registered as type %d\n",
   409					 wm8994->type);
   410			wm8994->type = WM8994;
   411			break;
   412		case 0x8958:
   413			devname = "WM8958";
   414			if (wm8994->type != WM8958)
   415				dev_warn(wm8994->dev, "Device registered as type %d\n",
   416					 wm8994->type);
   417			wm8994->type = WM8958;
   418			break;
   419		default:
   420			dev_err(wm8994->dev, "Device is not a WM8994, ID is %x\n",
   421				ret);
   422			ret = -EINVAL;
   423			goto err_enable;
   424		}
   425	
   426		ret = wm8994_reg_read(wm8994, WM8994_CHIP_REVISION);
   427		if (ret < 0) {
   428			dev_err(wm8994->dev, "Failed to read revision register: %d\n",
   429				ret);
   430			goto err_enable;
   431		}
   432		wm8994->revision = ret & WM8994_CHIP_REV_MASK;
   433		wm8994->cust_id = (ret & WM8994_CUST_ID_MASK) >> WM8994_CUST_ID_SHIFT;
   434	
   435		switch (wm8994->type) {
   436		case WM8994:
   437			switch (wm8994->revision) {
   438			case 0:
   439			case 1:
   440				dev_warn(wm8994->dev,
   441					 "revision %c not fully supported\n",
   442					 'A' + wm8994->revision);
   443				break;
   444			case 2:
   445			case 3:
   446			default:
   447				regmap_patch = wm8994_revc_patch;
   448				patch_regs = ARRAY_SIZE(wm8994_revc_patch);
   449				break;
   450			}
   451			break;
   452	
   453		case WM8958:
   454			switch (wm8994->revision) {
   455			case 0:
   456				regmap_patch = wm8958_reva_patch;
   457				patch_regs = ARRAY_SIZE(wm8958_reva_patch);
   458				break;
   459			default:
   460				break;
   461			}
   462			break;
   463	
   464		case WM1811:
   465			/* Revision C did not change the relevant layer */
   466			if (wm8994->revision > 1)
   467				wm8994->revision++;
   468	
   469			regmap_patch = wm1811_reva_patch;
   470			patch_regs = ARRAY_SIZE(wm1811_reva_patch);
   471			break;
   472	
   473		default:
   474			break;
   475		}
   476	
   477		dev_info(wm8994->dev, "%s revision %c CUST_ID %02x\n", devname,
   478			 'A' + wm8994->revision, wm8994->cust_id);
   479	
   480		switch (wm8994->type) {
   481		case WM1811:
   482			regmap_config = &wm1811_regmap_config;
   483			break;
   484		case WM8994:
   485			regmap_config = &wm8994_regmap_config;
   486			break;
   487		case WM8958:
   488			regmap_config = &wm8958_regmap_config;
   489			break;
   490		default:
   491			dev_err(wm8994->dev, "Unknown device type %d\n", wm8994->type);
   492			ret = -EINVAL;
   493			goto err_enable;
   494		}
   495	
   496		ret = regmap_reinit_cache(wm8994->regmap, regmap_config);
   497		if (ret != 0) {
   498			dev_err(wm8994->dev, "Failed to reinit register cache: %d\n",
   499				ret);
   500			goto err_enable;
   501		}
   502	
   503		/* Explicitly put the device into reset in case regulators
   504		 * don't get disabled in order to ensure we know the device
   505		 * state.
   506		 */
   507		ret = wm8994_reg_write(wm8994, WM8994_SOFTWARE_RESET,
   508				       wm8994_reg_read(wm8994, WM8994_SOFTWARE_RESET));
   509		if (ret != 0) {
   510			dev_err(wm8994->dev, "Failed to reset device: %d\n", ret);
   511			goto err_enable;
   512		}
   513	
   514		if (regmap_patch) {
   515			ret = regmap_register_patch(wm8994->regmap, regmap_patch,
   516						    patch_regs);
   517			if (ret != 0) {
   518				dev_err(wm8994->dev, "Failed to register patch: %d\n",
   519					ret);
   520				goto err_enable;
   521			}
   522		}
   523	
   524		wm8994->irq_base = pdata->irq_base;
   525		wm8994->gpio_base = pdata->gpio_base;
   526	
   527		/* GPIO configuration is only applied if it's non-zero */
   528		for (i = 0; i < ARRAY_SIZE(pdata->gpio_defaults); i++) {
   529			if (pdata->gpio_defaults[i]) {
   530				wm8994_set_bits(wm8994, WM8994_GPIO_1 + i,
   531						0xffff, pdata->gpio_defaults[i]);
   532			}
   533		}
   534	
   535		wm8994->ldo_ena_always_driven = pdata->ldo_ena_always_driven;
   536	
   537		if (pdata->spkmode_pu)
   538			pulls |= WM8994_SPKMODE_PU;
   539		if (pdata->csnaddr_pd)
   540			pulls |= WM8994_CSNADDR_PD;
   541	
   542		/* Disable unneeded pulls */
   543		wm8994_set_bits(wm8994, WM8994_PULL_CONTROL_2,
   544				WM8994_LDO1ENA_PD | WM8994_LDO2ENA_PD |
   545				WM8994_SPKMODE_PU | WM8994_CSNADDR_PD,
   546				pulls);
   547	
   548		/* In some system designs where the regulators are not in use,
   549		 * we can achieve a small reduction in leakage currents by
   550		 * floating LDO outputs.  This bit makes no difference if the
   551		 * LDOs are enabled, it only affects cases where the LDOs were
   552		 * in operation and are then disabled.
   553		 */
   554		for (i = 0; i < WM8994_NUM_LDO_REGS; i++) {
   555			if (wm8994_ldo_in_use(pdata, i))
   556				wm8994_set_bits(wm8994, WM8994_LDO_1 + i,
   557						WM8994_LDO1_DISCH, WM8994_LDO1_DISCH);
   558			else
   559				wm8994_set_bits(wm8994, WM8994_LDO_1 + i,
   560						WM8994_LDO1_DISCH, 0);
   561		}
   562	
   563		wm8994_irq_init(wm8994);
   564	
   565		ret = mfd_add_devices(wm8994->dev, -1,
   566				      wm8994_devs, ARRAY_SIZE(wm8994_devs),
   567				      NULL, 0, NULL);
   568		if (ret != 0) {
   569			dev_err(wm8994->dev, "Failed to add children: %d\n", ret);
   570			goto err_irq;
   571		}
   572	
   573		pm_runtime_set_active(wm8994->dev);
   574		pm_runtime_enable(wm8994->dev);
   575		pm_runtime_idle(wm8994->dev);
   576	
   577		return 0;
   578	
   579	err_irq:
   580		wm8994_irq_exit(wm8994);
   581	err_enable:
   582		regulator_bulk_disable(wm8994->num_supplies,
   583				       wm8994->supplies);
   584	err_regulator_free:
   585		regulator_bulk_free(wm8994->num_supplies, wm8994->supplies);
   586	err:
   587		mfd_remove_devices(wm8994->dev);
   588		return ret;
   589	}
   590	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

