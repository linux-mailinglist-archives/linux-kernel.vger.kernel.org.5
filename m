Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A14D7F77F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbjKXPn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345877AbjKXPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:43:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2A512B;
        Fri, 24 Nov 2023 07:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700840612; x=1732376612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uKuVnPiHCsCFBoLsMwZ3LFPbqS8wzUlMQMfhLTEoxK4=;
  b=RRwO7TyYTt8Diy0ih8dJGGKocG57rh/PlFZOAc49EJtgKK4d3iv8Ta1a
   VtZzN8yBMBi0+o7kxJuCW0BzzhxDpyIfsnLYYO++f/lUTpkNIGMeqcZIa
   eSI//bi+pkKz0dSC4iVX/4c5gm4AQ+Eu0uHUWSxVtq/+ifbGqwTbD38D7
   0TXbNsZy24/FojxvcqwYo5aQie0ClKXb0n9jMoZ8v8xiSldAGLAjvGQfe
   E+SszA3keMB7SObXWnUmiWUlidABOI2O1+rUPH+0JdM0IAL4cmxvInkPv
   JDOIwvhQsGDSsg6KdJ0LbMlERNBggBSdMp4m2kUD6YSqyLOdgMtWsqgJR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="5662513"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="5662513"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 07:43:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="16005200"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Nov 2023 07:43:28 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6YKz-0002z6-23;
        Fri, 24 Nov 2023 15:43:25 +0000
Date:   Fri, 24 Nov 2023 23:42:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuxi Wang <Yuxi.Wang@monolithicpower.com>, pavel@ucw.cz,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        wyx137120466@gmail.com
Subject: Re: [PATCH 2/2] leds: add mp3326 driver
Message-ID: <202311242100.FGwL3wE0-lkp@intel.com>
References: <20231124093034.951-3-Yuxi.Wang@monolithicpower.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124093034.951-3-Yuxi.Wang@monolithicpower.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuxi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-leds/for-leds-next]
[also build test WARNING on robh/for-next linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuxi-Wang/dt-bindings-leds-add-mps-mp3326-LED/20231124-173610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20231124093034.951-3-Yuxi.Wang%40monolithicpower.com
patch subject: [PATCH 2/2] leds: add mp3326 driver
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20231124/202311242100.FGwL3wE0-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311242100.FGwL3wE0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311242100.FGwL3wE0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/leds/leds-mp3326.c: In function 'mp3326_parse_dt':
>> drivers/leds/leds-mp3326.c:543:13: warning: unused variable 'val' [-Wunused-variable]
     543 |         int val;
         |             ^~~
   drivers/leds/leds-mp3326.c: At top level:
   drivers/leds/leds-mp3326.c:611:10: error: 'struct i2c_driver' has no member named 'probe_new'
     611 |         .probe_new = mp3326_leds_probe,
         |          ^~~~~~~~~
   drivers/leds/leds-mp3326.c:611:22: warning: initialization of 'unsigned int' from 'int (*)(struct i2c_client *)' makes integer from pointer without a cast [-Wint-conversion]
     611 |         .probe_new = mp3326_leds_probe,
         |                      ^~~~~~~~~~~~~~~~~
   drivers/leds/leds-mp3326.c:611:22: note: (near initialization for 'mp3326_driver.class')


vim +/val +543 drivers/leds/leds-mp3326.c

   536	
   537	static int mp3326_parse_dt(struct mp3326 *chip)
   538	{
   539		struct device_node *np = dev_of_node(&chip->client->dev);
   540		struct device_node *child;
   541		int ret;
   542		int i = 0;
 > 543		int val;
   544	
   545		for_each_available_child_of_node(np, child) {
   546			ret = mp3326_add_led(chip, child, i);
   547			if (ret)
   548				return ret;
   549			i++;
   550		}
   551	
   552		ret = regmap_write(chip->regmap, MP3326_PWM_CTRL_CHANNEL_9_16, 0);
   553		if (ret)
   554			return ret;
   555		ret = regmap_write(chip->regmap, MP3326_PWM_CTRL_CHANNEL_1_8, 0);
   556		if (ret)
   557			return ret;
   558		return 0;
   559	}
   560	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
