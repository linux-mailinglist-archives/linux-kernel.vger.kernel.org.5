Return-Path: <linux-kernel+bounces-18523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1222B825EB4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E33F1C23C50
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFBD4439;
	Sat,  6 Jan 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCz/KALA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E0440A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704526372; x=1736062372;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sd/HO2XtNVvtIKP/1UrKzVj6TIOdw3X0vVMBEgm0kxo=;
  b=DCz/KALAPSo3T+A2r9CwqC6+v+VVDu30RpjNQV2ZJtvaYV5UvjGItzDI
   Rwgw8wIlAvY5GAuqNPjGF1zgk2jzpDUboVBizIVdDwhRez2vj6/rLzFSB
   BMQH2+bYTNiS2kPzrlhBkxlUmVVluIJ5+3EC3ppeqhIamFUV8lziWaXTZ
   NIMEtiMl7C433lZszj3HAnpgZmEhpqfd4NTbbLFBSgsoPX4H+DouieKxf
   EoS3Qh45Xhw08nEPezMqJb1lwM02rt5BxaX5NSO+Inzatnql4pwzxi03m
   sikZJfwNFValQnq8RAWQbCybnHvhhtW0QgmL+Pl0OK7iDloFZjDooRg8v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="428824166"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="428824166"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 23:32:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="871417128"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="871417128"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jan 2024 23:32:49 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM1Ak-0002AK-21;
	Sat, 06 Jan 2024 07:32:46 +0000
Date: Sat, 6 Jan 2024 15:32:39 +0800
From: kernel test robot <lkp@intel.com>
To: Eddie James <eajames@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>
Subject: drivers/leds/leds-pca955x.c:590:43: warning: '%d' directive output
 may be truncated writing between 1 and 11 bytes into a region of size 8
Message-ID: <202401061544.q6p3WSvR-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: 7c4815929276b2e223eb6f2e49afe5071d4294a5 leds: pca955x: Let the core process the fwnode
date:   2 years, 5 months ago
config: x86_64-randconfig-006-20240105 (https://download.01.org/0day-ci/archive/20240106/202401061544.q6p3WSvR-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401061544.q6p3WSvR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401061544.q6p3WSvR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/leds/leds-pca955x.c: In function 'pca955x_probe':
>> drivers/leds/leds-pca955x.c:590:43: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Wformat-truncation=]
     590 |                                          "%d", i);
         |                                           ^~
   drivers/leds/leds-pca955x.c:590:42: note: directive argument in the range [-2147483644, 2147483646]
     590 |                                          "%d", i);
         |                                          ^~~~
   drivers/leds/leds-pca955x.c:589:33: note: 'snprintf' output between 2 and 12 bytes into a destination of size 8
     589 |                                 snprintf(default_label, sizeof(default_label),
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     590 |                                          "%d", i);
         |                                          ~~~~~~~~


vim +590 drivers/leds/leds-pca955x.c

   481	
   482	static int pca955x_probe(struct i2c_client *client,
   483				 const struct i2c_device_id *id)
   484	{
   485		struct pca955x *pca955x;
   486		struct pca955x_led *pca955x_led;
   487		struct pca955x_chipdef *chip;
   488		struct led_classdev *led;
   489		struct led_init_data init_data;
   490		struct i2c_adapter *adapter;
   491		int i, err;
   492		struct pca955x_platform_data *pdata;
   493		int ngpios = 0;
   494		bool set_default_label = false;
   495		bool keep_pwm = false;
   496		char default_label[8];
   497	
   498		chip = &pca955x_chipdefs[id->driver_data];
   499		adapter = client->adapter;
   500		pdata = dev_get_platdata(&client->dev);
   501		if (!pdata) {
   502			pdata =	pca955x_get_pdata(client, chip);
   503			if (IS_ERR(pdata))
   504				return PTR_ERR(pdata);
   505		}
   506	
   507		/* Make sure the slave address / chip type combo given is possible */
   508		if ((client->addr & ~((1 << chip->slv_addr_shift) - 1)) !=
   509		    chip->slv_addr) {
   510			dev_err(&client->dev, "invalid slave address %02x\n",
   511				client->addr);
   512			return -ENODEV;
   513		}
   514	
   515		dev_info(&client->dev, "leds-pca955x: Using %s %d-bit LED driver at "
   516			 "slave address 0x%02x\n", client->name, chip->bits,
   517			 client->addr);
   518	
   519		if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
   520			return -EIO;
   521	
   522		if (pdata->num_leds != chip->bits) {
   523			dev_err(&client->dev,
   524				"board info claims %d LEDs on a %d-bit chip\n",
   525				pdata->num_leds, chip->bits);
   526			return -ENODEV;
   527		}
   528	
   529		pca955x = devm_kzalloc(&client->dev, sizeof(*pca955x), GFP_KERNEL);
   530		if (!pca955x)
   531			return -ENOMEM;
   532	
   533		pca955x->leds = devm_kcalloc(&client->dev, chip->bits,
   534					     sizeof(*pca955x_led), GFP_KERNEL);
   535		if (!pca955x->leds)
   536			return -ENOMEM;
   537	
   538		i2c_set_clientdata(client, pca955x);
   539	
   540		mutex_init(&pca955x->lock);
   541		pca955x->client = client;
   542		pca955x->chipdef = chip;
   543	
   544		init_data.devname_mandatory = false;
   545		init_data.devicename = "pca955x";
   546	
   547		for (i = 0; i < chip->bits; i++) {
   548			pca955x_led = &pca955x->leds[i];
   549			pca955x_led->led_num = i;
   550			pca955x_led->pca955x = pca955x;
   551			pca955x_led->type = pdata->leds[i].type;
   552	
   553			switch (pca955x_led->type) {
   554			case PCA955X_TYPE_NONE:
   555				break;
   556			case PCA955X_TYPE_GPIO:
   557				ngpios++;
   558				break;
   559			case PCA955X_TYPE_LED:
   560				led = &pca955x_led->led_cdev;
   561				led->brightness_set_blocking = pca955x_led_set;
   562				led->brightness_get = pca955x_led_get;
   563	
   564				if (pdata->leds[i].default_state ==
   565				    LEDS_GPIO_DEFSTATE_OFF) {
   566					err = pca955x_led_set(led, LED_OFF);
   567					if (err)
   568						return err;
   569				} else if (pdata->leds[i].default_state ==
   570					   LEDS_GPIO_DEFSTATE_ON) {
   571					err = pca955x_led_set(led, LED_FULL);
   572					if (err)
   573						return err;
   574				}
   575	
   576				init_data.fwnode = pdata->leds[i].fwnode;
   577	
   578				if (is_of_node(init_data.fwnode)) {
   579					if (to_of_node(init_data.fwnode)->name[0] ==
   580					    '\0')
   581						set_default_label = true;
   582					else
   583						set_default_label = false;
   584				} else {
   585					set_default_label = true;
   586				}
   587	
   588				if (set_default_label) {
   589					snprintf(default_label, sizeof(default_label),
 > 590						 "%d", i);
   591					init_data.default_label = default_label;
   592				} else {
   593					init_data.default_label = NULL;
   594				}
   595	
   596				err = devm_led_classdev_register_ext(&client->dev, led,
   597								     &init_data);
   598				if (err)
   599					return err;
   600	
   601				/*
   602				 * For default-state == "keep", let the core update the
   603				 * brightness from the hardware, then check the
   604				 * brightness to see if it's using PWM1. If so, PWM1
   605				 * should not be written below.
   606				 */
   607				if (pdata->leds[i].default_state ==
   608				    LEDS_GPIO_DEFSTATE_KEEP) {
   609					if (led->brightness != LED_FULL &&
   610					    led->brightness != LED_OFF &&
   611					    led->brightness != LED_HALF)
   612						keep_pwm = true;
   613				}
   614			}
   615		}
   616	
   617		/* PWM0 is used for half brightness or 50% duty cycle */
   618		err = pca955x_write_pwm(client, 0, 255 - LED_HALF);
   619		if (err)
   620			return err;
   621	
   622		if (!keep_pwm) {
   623			/* PWM1 is used for variable brightness, default to OFF */
   624			err = pca955x_write_pwm(client, 1, 0);
   625			if (err)
   626				return err;
   627		}
   628	
   629		/* Set to fast frequency so we do not see flashing */
   630		err = pca955x_write_psc(client, 0, 0);
   631		if (err)
   632			return err;
   633		err = pca955x_write_psc(client, 1, 0);
   634		if (err)
   635			return err;
   636	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

