Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49027798E5B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbjIHSmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbjIHSmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:42:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEF81BF4;
        Fri,  8 Sep 2023 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694198480; x=1725734480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QPLINnlBu9wjGkIIvfYqrRJ4j0WIW2UBVJYhir95sJ8=;
  b=KeV+TH4WbTYOpQbOe3yH2PlGo+Eue+zDZWf/KK46Lx6uG0IB482l2Brv
   ykrBri2Ard5zsaF3G+1yVgU/uN8BrZEQx1ZzZgX6b+A7d1v0lhrzNGWZl
   5KFyTthCXu5b6LVyVG66OxQuR/IOV78Wdeht7m4x6TFyBwcu/d2NDFBCA
   BvNpLoISxoS87l00mGluhQLRbZ0bDwhqMAOU/H74Qv4Yh2cLwHQjUXw8o
   PHS/7bWw0nEXts7kypgiFJlyt5MALkTFRcdkfQNIG9azhea3e4SpHRCvM
   7Yv74BtT/NkbmRz7ukGQ2kT6A18fdjQ4k9Q+LJB1gUSIlg0e3jrqcsg+1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="444151350"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="444151350"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 11:39:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="832746957"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="832746957"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Sep 2023 11:39:18 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qegNv-0002WK-2g;
        Fri, 08 Sep 2023 18:39:15 +0000
Date:   Sat, 9 Sep 2023 02:38:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     oe-kbuild-all@lists.linux.dev,
        Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: max31790: support to config PWM as TACH
Message-ID: <202309090228.2bSFmAO8-lkp@intel.com>
References: <20230906084837.3043030-3-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906084837.3043030-3-Delphine_CC_Chiu@wiwynn.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Delphine,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.5 next-20230908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Delphine-CC-Chiu/hwmon-max31790-support-to-config-PWM-as-TACH/20230906-165344
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230906084837.3043030-3-Delphine_CC_Chiu%40wiwynn.com
patch subject: [PATCH] hwmon: max31790: support to config PWM as TACH
config: x86_64-randconfig-161-20230907 (https://download.01.org/0day-ci/archive/20230909/202309090228.2bSFmAO8-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230909/202309090228.2bSFmAO8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309090228.2bSFmAO8-lkp@intel.com/

smatch warnings:
drivers/hwmon/max31790.c:511 max31790_config_pwm_as_tach() warn: unsigned 'fan_config' is never less than zero.

vim +/fan_config +511 drivers/hwmon/max31790.c

   482	
   483	static int max31790_config_pwm_as_tach(struct device *dev,
   484					       struct i2c_client *client)
   485	{
   486		struct device_node *np = dev->of_node;
   487		int i, ret = 0, size, channel;
   488		u8 pwm_index[NR_CHANNEL] = { 0 };
   489		u8 fan_config;
   490	
   491		size = of_property_count_u8_elems(np, "pwm-as-tach");
   492	
   493		if ((size > 0) && (size <= NR_CHANNEL)) {
   494			ret = of_property_read_u8_array(np, "pwm-as-tach", pwm_index,
   495							size);
   496			if (ret) {
   497				dev_err(dev,
   498					"Property 'pwm-as-tach' cannot be read.\n");
   499				return ret;
   500			}
   501	
   502			for (i = 0; i < size; i++) {
   503				if ((pwm_index[i] == 0) ||
   504				    (pwm_index[i] > NR_CHANNEL)) {
   505					continue;
   506				}
   507	
   508				channel = pwm_index[i] - 1;
   509				fan_config = i2c_smbus_read_byte_data(
   510					client, MAX31790_REG_FAN_CONFIG(channel));
 > 511				if (fan_config < 0) {
   512					dev_err(dev,
   513						"Read fan config for channel %d failed.\n",
   514						channel);
   515					return fan_config;
   516				}
   517	
   518				fan_config |= (MAX31790_FAN_CFG_CTRL_MON |
   519					       MAX31790_FAN_CFG_TACH_INPUT);
   520				i2c_smbus_write_byte_data(
   521					client, MAX31790_REG_FAN_CONFIG(channel),
   522					fan_config);
   523			}
   524		}
   525	
   526		return 0;
   527	}
   528	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
