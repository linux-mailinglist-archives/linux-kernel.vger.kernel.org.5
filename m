Return-Path: <linux-kernel+bounces-19492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F71826DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30A41C22354
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95F3405CA;
	Mon,  8 Jan 2024 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkgkkOpX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2C405C2;
	Mon,  8 Jan 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704716666; x=1736252666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U6PZV0XSf3M5jl7U4BTOkxIJfcJQG0oaRB000eW0FEs=;
  b=VkgkkOpXiijlqkFhDWYeqTXHbIO9e+EhFC8K9DiElgOeeY7+C39j4Wg8
   B5oCCwL4NpyhRJT3sui91RrqcFHUl53MKE4k/1zOZ+XelnKJX28SL72dH
   9cW/jPwRTW+ChR8lFg/Uccl4MKhuSZmjTX46nauH7TpxyKRMFRjZN77Pd
   dNaHMI2w5QlXwCUl5U3NgI/ZMyuQgTSNinchknHv3xYQ4/2/4v7WS9Sxd
   HB0A9OXaxgIHbSoecLqGXw073MJvUeFKS0bMEafGzGhqd3DqZY6UJtpfW
   TUCKuci+fgM9xHLgR96W/qZac1Xz/xybvVaDVErcwpPo3yajoa855lfXn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="484049016"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="484049016"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 04:24:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="815593873"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="815593873"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 08 Jan 2024 04:24:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMog0-0004ga-12;
	Mon, 08 Jan 2024 12:24:20 +0000
Date: Mon, 8 Jan 2024 20:24:13 +0800
From: kernel test robot <lkp@intel.com>
To: Joseph Strauss <jstrauss@mailbox.org>, lee@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, pavel@ucw.cz, jansimon.moeller@gmx.de,
	conor@kernel.org, christophe.jaillet@wanadoo.fr,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joseph Strauss <jstrauss@mailbox.org>
Subject: Re: [PATCH v4] Add multicolor support to BlinkM LED driver
Message-ID: <202401082043.w97LLdJn-lkp@intel.com>
References: <20240106172944.7593-1-jstrauss@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106172944.7593-1-jstrauss@mailbox.org>

Hi Joseph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pavel-leds/for-next]
[cannot apply to lee-leds/for-leds-next linus/master v6.7 next-20240108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joseph-Strauss/Add-multicolor-support-to-BlinkM-LED-driver/20240107-013235
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
patch link:    https://lore.kernel.org/r/20240106172944.7593-1-jstrauss%40mailbox.org
patch subject: [PATCH v4] Add multicolor support to BlinkM LED driver
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240108/202401082043.w97LLdJn-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240108/202401082043.w97LLdJn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401082043.w97LLdJn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/leds/leds-blinkm.c: In function 'blinkm_probe':
>> drivers/leds/leds-blinkm.c:721:53: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     721 |                          "blinkm-%d-%d:rgb:indicator",
         |                                                     ^
   drivers/leds/leds-blinkm.c:720:17: note: 'snprintf' output between 25 and 39 bytes into a destination of size 28
     720 |                 snprintf(blinkm_led_name, sizeof(blinkm_led_name),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     721 |                          "blinkm-%d-%d:rgb:indicator",
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     722 |                          client->adapter->nr,
         |                          ~~~~~~~~~~~~~~~~~~~~
     723 |                          client->addr);
         |                          ~~~~~~~~~~~~~


vim +/snprintf +721 drivers/leds/leds-blinkm.c

   595	
   596	static int blinkm_probe(struct i2c_client *client,
   597				const struct i2c_device_id *id)
   598	{
   599		struct blinkm_data *data;
   600		/* For multicolor support */
   601		struct blinkm_led *mc_led;
   602		struct mc_subled *mc_led_info;
   603		/* 3 seperate classes for red, green, and blue respectively */
   604		struct blinkm_led *leds[NUM_LEDS];
   605		int err, i;
   606		char blinkm_led_name[28];
   607	
   608		data = devm_kzalloc(&client->dev,
   609				sizeof(struct blinkm_data), GFP_KERNEL);
   610		if (!data) {
   611			err = -ENOMEM;
   612			goto exit;
   613		}
   614	
   615		mc_led_info = devm_kcalloc(&client->dev, NUM_LEDS, sizeof(*mc_led_info),
   616						GFP_KERNEL);
   617		if (!mc_led_info) {
   618			err = -ENOMEM;
   619			goto exit;
   620		}
   621		data->i2c_addr = 0x08;
   622		/* i2c addr  - use fake addr of 0x08 initially (real is 0x09) */
   623		data->fw_ver = 0xfe;
   624		/* firmware version - use fake until we read real value
   625		 * (currently broken - BlinkM confused!) */
   626		data->script_id = 0x01;
   627		data->i2c_client = client;
   628	
   629		i2c_set_clientdata(client, data);
   630		mutex_init(&data->update_lock);
   631	
   632		/* Register sysfs hooks */
   633		err = sysfs_create_group(&client->dev.kobj, &blinkm_group);
   634		if (err < 0) {
   635			dev_err(&client->dev, "couldn't register sysfs group\n");
   636			goto exit;
   637		}
   638	
   639		if (!IS_ENABLED(CONFIG_LEDS_BLINKM_MULTICOLOR)) {
   640			/* Register red, green, and blue sysfs classes */
   641			for (i = 0; i < NUM_LEDS; i++) {
   642				/* RED = 0, GREEN = 1, BLUE = 2 */
   643				leds[i] = &data->blinkm_leds[i];
   644				leds[i]->i2c_client = client;
   645				leds[i]->id = i;
   646				leds[i]->led_cdev.max_brightness = 255;
   647				leds[i]->led_cdev.flags = LED_CORE_SUSPENDRESUME;
   648				switch (i) {
   649				case RED:
   650					snprintf(blinkm_led_name, sizeof(blinkm_led_name),
   651							 "blinkm-%d-%d-red",
   652							 client->adapter->nr,
   653							 client->addr);
   654					leds[i]->led_cdev.name = blinkm_led_name;
   655					leds[i]->led_cdev.brightness_set_blocking =
   656									blinkm_led_red_set;
   657					err = led_classdev_register(&client->dev,
   658									&leds[i]->led_cdev);
   659					if (err < 0) {
   660						dev_err(&client->dev,
   661							"couldn't register LED %s\n",
   662							leds[i]->led_cdev.name);
   663						goto failred;
   664					}
   665					break;
   666				case GREEN:
   667					snprintf(blinkm_led_name, sizeof(blinkm_led_name),
   668							 "blinkm-%d-%d-green",
   669							 client->adapter->nr,
   670							 client->addr);
   671					leds[i]->led_cdev.name = blinkm_led_name;
   672					leds[i]->led_cdev.brightness_set_blocking =
   673									blinkm_led_green_set;
   674					err = led_classdev_register(&client->dev,
   675								&leds[i]->led_cdev);
   676					if (err < 0) {
   677						dev_err(&client->dev,
   678							"couldn't register LED %s\n",
   679							leds[i]->led_cdev.name);
   680						goto failgreen;
   681					}
   682					break;
   683				case BLUE:
   684					snprintf(blinkm_led_name, sizeof(blinkm_led_name),
   685							 "blinkm-%d-%d-blue",
   686							 client->adapter->nr,
   687							 client->addr);
   688					leds[i]->led_cdev.name = blinkm_led_name;
   689					leds[i]->led_cdev.brightness_set_blocking =
   690									blinkm_led_blue_set;
   691					err = led_classdev_register(&client->dev,
   692									&leds[i]->led_cdev);
   693					if (err < 0) {
   694						dev_err(&client->dev,
   695							"couldn't register LED %s\n",
   696							leds[i]->led_cdev.name);
   697						goto failblue;
   698					}
   699					break;
   700				default:
   701					break;
   702				}		/* end switch */
   703			}			/* end for */
   704		} else {
   705			/* Register multicolor sysfs class */
   706			/* The first element of leds is used for multicolor facilities */
   707			mc_led = &data->blinkm_leds[RED];
   708			mc_led->i2c_client = client;
   709	
   710			mc_led_info[RED].color_index = LED_COLOR_ID_RED;
   711			mc_led_info[GREEN].color_index = LED_COLOR_ID_GREEN;
   712			mc_led_info[BLUE].color_index = LED_COLOR_ID_BLUE;
   713	
   714			mc_led->mcled_cdev.subled_info = mc_led_info;
   715			mc_led->mcled_cdev.num_colors = NUM_LEDS;
   716			mc_led->mcled_cdev.led_cdev.brightness = 255;
   717			mc_led->mcled_cdev.led_cdev.max_brightness = 255;
   718			mc_led->mcled_cdev.led_cdev.flags = LED_CORE_SUSPENDRESUME;
   719	
   720			snprintf(blinkm_led_name, sizeof(blinkm_led_name),
 > 721				 "blinkm-%d-%d:rgb:indicator",
   722				 client->adapter->nr,
   723				 client->addr);
   724			mc_led->mcled_cdev.led_cdev.name = blinkm_led_name;
   725			mc_led->mcled_cdev.led_cdev.brightness_set_blocking = blinkm_set_mc_brightness;
   726	
   727			err = led_classdev_multicolor_register(&client->dev, &mc_led->mcled_cdev);
   728			if (err < 0) {
   729				dev_err(&client->dev, "couldn't register LED %s\n",
   730						mc_led->led_cdev.name);
   731				goto failmulti;
   732			}
   733		}
   734	
   735		blinkm_init_hw(client);
   736	
   737		return 0;
   738	
   739	failmulti:
   740		led_classdev_unregister(&leds[BLUE]->led_cdev);
   741	
   742	failblue:
   743		led_classdev_unregister(&leds[GREEN]->led_cdev);
   744	
   745	failgreen:
   746		led_classdev_unregister(&leds[RED]->led_cdev);
   747	
   748	failred:
   749		sysfs_remove_group(&client->dev.kobj, &blinkm_group);
   750	
   751	exit:
   752		return err;
   753	}
   754	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

