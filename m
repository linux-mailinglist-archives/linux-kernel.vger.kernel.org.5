Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4323F793E05
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbjIFNtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjIFNtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:49:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCA6E6B;
        Wed,  6 Sep 2023 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694008154; x=1725544154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KPAWd+TFJubxnsFyigdchHUcDBQpqpD8+pHOHcoO3b0=;
  b=XZHZ1CbgBXi+5lttrawwmm9HRfdiGHXOkY05Ej3OOJiQdjSVrPPkgOlZ
   OLqNHhba/9kH6rwnQGrjjhIQ0IhWfPGwXm4ToMyvpru9nEzT1NIGPAU3u
   ryxvoPD0O/81IMasDFliWHbyNczYPnIwm2CEjLR7z10agZe9sfr8KZFGu
   JC1XRkIJkwAffLhIA88DL9gcwh2tql7yt2R+Vaad7XBoNybbOdT7yHiZx
   5OgGkGrxldBjweKZYdrEw87Ic0CqIGO7djKQJLnXNTZJ0MuyIYkg941dG
   /ysha4isczNxEAl3s/dTy4AHZ09v2+XU05G/4LOjvbs1sLt3SA6lAlPW4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="379784344"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="379784344"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 06:49:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="856436984"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="856436984"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Sep 2023 06:49:11 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdsu5-0000Gd-2D;
        Wed, 06 Sep 2023 13:49:09 +0000
Date:   Wed, 6 Sep 2023 21:48:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martino Fontana <tinozzo123@gmail.com>, djogorchock@gmail.com,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Martino Fontana <tinozzo123@gmail.com>
Subject: Re: [PATCH v2 RESEND] HID: nintendo: cleanup LED code
Message-ID: <202309062140.CiSKWeEO-lkp@intel.com>
References: <20230906102831.16734-2-tinozzo123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906102831.16734-2-tinozzo123@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martino,

kernel test robot noticed the following build errors:

[auto build test ERROR on hid/for-next]
[also build test ERROR on linus/master v6.5 next-20230906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Martino-Fontana/HID-nintendo-cleanup-LED-code/20230906-183111
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20230906102831.16734-2-tinozzo123%40gmail.com
patch subject: [PATCH v2 RESEND] HID: nintendo: cleanup LED code
config: parisc-randconfig-r011-20230906 (https://download.01.org/0day-ci/archive/20230906/202309062140.CiSKWeEO-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309062140.CiSKWeEO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309062140.CiSKWeEO-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/hid/hid-nintendo.c: In function 'joycon_leds_create':
>> drivers/hid/hid-nintendo.c:1954:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1954 |                 if (ret)
         |                 ^~
   drivers/hid/hid-nintendo.c:1956:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1956 |                         return ret;
         |                         ^~~~~~
   drivers/hid/hid-nintendo.c:1986:17: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1986 |                 if (ret)
         |                 ^~
   drivers/hid/hid-nintendo.c:1988:25: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1988 |                         return ret
         |                         ^~~~~~
>> drivers/hid/hid-nintendo.c:1988:35: error: expected ';' before '}' token
    1988 |                         return ret
         |                                   ^
         |                                   ;
    1989 |         }
         |         ~                          


vim +1988 drivers/hid/hid-nintendo.c

  1906	
  1907	static DEFINE_SPINLOCK(joycon_input_num_spinlock);
  1908	static int joycon_leds_create(struct joycon_ctlr *ctlr)
  1909	{
  1910		struct hid_device *hdev = ctlr->hdev;
  1911		struct device *dev = &hdev->dev;
  1912		const char *d_name = dev_name(dev);
  1913		struct led_classdev *led;
  1914		char *name;
  1915		int ret;
  1916		int i;
  1917		unsigned long flags;
  1918		int player_led_number;
  1919		static int input_num;
  1920	
  1921		/* Set the player leds based on controller number */
  1922		spin_lock_irqsave(&joycon_input_num_spinlock, flags);
  1923		player_led_number = input_num++ % JC_NUM_LEDS;
  1924		spin_unlock_irqrestore(&joycon_input_num_spinlock, flags);
  1925	
  1926		/* configure the player LEDs */
  1927		for (i = 0; i < JC_NUM_LEDS; i++) {
  1928			name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s:%s",
  1929					      d_name,
  1930					      "green",
  1931					      joycon_player_led_names[i]);
  1932			if (!name)
  1933				return -ENOMEM;
  1934	
  1935			led = &ctlr->leds[i];
  1936			led->name = name;
  1937			led->brightness = (i == player_led_number) ? 1 : 0;
  1938			led->max_brightness = 1;
  1939			led->brightness_set_blocking =
  1940						joycon_player_led_brightness_set;
  1941			led->flags = LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
  1942		}
  1943		mutex_lock(&ctlr->output_mutex);
  1944		ret = joycon_set_player_leds(ctlr, 0, 0x1 << player_led_number);
  1945		mutex_unlock(&ctlr->output_mutex);
  1946		if (ret) {
  1947			hid_warn(hdev, "Failed to set players LEDs, skipping registration; ret=%d\n", ret);
  1948			goto home_led;
  1949		}
  1950	
  1951		for (i = 0; i < JC_NUM_LEDS; i++) {
  1952			led = &ctlr->leds[i];
  1953			ret = devm_led_classdev_register(&hdev->dev, led);
> 1954			if (ret)
  1955				hid_err(hdev, "Failed to register player %d LED; ret=%d\n", i + 1, ret);
> 1956				return ret;
  1957		}
  1958	
  1959	home_led:
  1960		/* configure the home LED */
  1961		if (jc_type_has_right(ctlr)) {
  1962			name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s:%s",
  1963					      d_name,
  1964					      "blue",
  1965					      LED_FUNCTION_PLAYER5);
  1966			if (!name)
  1967				return -ENOMEM;
  1968	
  1969			led = &ctlr->home_led;
  1970			led->name = name;
  1971			led->brightness = 0;
  1972			led->max_brightness = 0xF;
  1973			led->brightness_set_blocking = joycon_home_led_brightness_set;
  1974			led->flags = LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
  1975	
  1976			/* Set the home LED to 0 as default state */
  1977			mutex_lock(&ctlr->output_mutex);
  1978			ret = joycon_set_home_led(ctlr, 0);
  1979			mutex_unlock(&ctlr->output_mutex);
  1980			if (ret) {
  1981				hid_warn(hdev, "Failed to set home LED, skipping registration; ret=%d\n", ret);
  1982				return 0;
  1983			}
  1984	
  1985			ret = devm_led_classdev_register(&hdev->dev, led);
  1986			if (ret)
  1987				hid_err(hdev, "Failed to register home LED; ret=%d\n", ret);
> 1988				return ret
  1989		}
  1990	
  1991		return 0;
  1992	}
  1993	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
