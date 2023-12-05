Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F7A805182
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345138AbjLELFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346732AbjLELFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:05:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599629A;
        Tue,  5 Dec 2023 03:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701774325; x=1733310325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vxtWDeGzVM4kvy0di8LLvjYNsy4xYn3TtHE94cFFtoI=;
  b=aymnqoW63Xl1IB8S6sWu2XvyFcuuiQkiTynli4f3CHEN44n3KucPPanE
   5jeP1b9WpoaE2ryBCvVNJ/i9ZwAuZq78kMOD+xjwKDnkDclzwoTDInUNb
   VFm5RLxb+2rPPAhcK+guFNxNPu7VYlkXOHGc54t0tJhuf3Z/+j3RxE/Ta
   jt47MteQjelfWeHVlselsEHD8KnN9LhoVggcQm3dXOmePUkoMNeS1nC/r
   cevLmMBLRvB87Y3qM2m7qy4VvRekB/X2I4zsjmphKXR6UW0LLHfyf9odR
   t2078ay7oWoG7qInjFPCUwWoy1/XaCp7GlLDwBuu5iKS4MAS7J7JLKl10
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="458199426"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="458199426"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="861708559"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="861708559"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Dec 2023 03:05:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rATEp-0008pW-0o;
        Tue, 05 Dec 2023 11:05:16 +0000
Date:   Tue, 5 Dec 2023 19:04:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     baneric926@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, corbet@lwn.net
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kcfeng0@nuvoton.com,
        DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com
Subject: Re: [PATCH v1 2/2] hwmon: Driver for Nuvoton NCT736X
Message-ID: <202312051854.qBIoJW1N-lkp@intel.com>
References: <20231204055650.788388-3-kcfeng0@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204055650.788388-3-kcfeng0@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc4 next-20231205]
[cannot apply to groeck-staging/hwmon-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/baneric926-gmail-com/dt-bindings-hwmon-Add-nct736x-bindings/20231204-135942
base:   linus/master
patch link:    https://lore.kernel.org/r/20231204055650.788388-3-kcfeng0%40nuvoton.com
patch subject: [PATCH v1 2/2] hwmon: Driver for Nuvoton NCT736X
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231205/202312051854.qBIoJW1N-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051854.qBIoJW1N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051854.qBIoJW1N-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/nct736x.c:352:5: warning: variable 'gpio14_17' is uninitialized when used here [-Wuninitialized]
                                   gpio14_17 |= FANIN_SEL(i);
                                   ^~~~~~~~~
   drivers/hwmon/nct736x.c:339:46: note: initialize the variable 'gpio14_17' to silence this warning
           u8 i, gpio0_3, gpio4_7, gpio10_13, gpio14_17;
                                                       ^
                                                        = '\0'
>> drivers/hwmon/nct736x.c:347:5: warning: variable 'gpio10_13' is uninitialized when used here [-Wuninitialized]
                                   gpio10_13 |= FANIN_SEL(i);
                                   ^~~~~~~~~
   drivers/hwmon/nct736x.c:339:35: note: initialize the variable 'gpio10_13' to silence this warning
           u8 i, gpio0_3, gpio4_7, gpio10_13, gpio14_17;
                                            ^
                                             = '\0'
>> drivers/hwmon/nct736x.c:350:5: warning: variable 'gpio4_7' is uninitialized when used here [-Wuninitialized]
                                   gpio4_7 |= PWM_SEL(i);
                                   ^~~~~~~
   drivers/hwmon/nct736x.c:339:24: note: initialize the variable 'gpio4_7' to silence this warning
           u8 i, gpio0_3, gpio4_7, gpio10_13, gpio14_17;
                                 ^
                                  = '\0'
>> drivers/hwmon/nct736x.c:345:5: warning: variable 'gpio0_3' is uninitialized when used here [-Wuninitialized]
                                   gpio0_3 |= PWM_SEL(i);
                                   ^~~~~~~
   drivers/hwmon/nct736x.c:339:15: note: initialize the variable 'gpio0_3' to silence this warning
           u8 i, gpio0_3, gpio4_7, gpio10_13, gpio14_17;
                        ^
                         = '\0'
   4 warnings generated.


vim +/gpio14_17 +352 drivers/hwmon/nct736x.c

   334	
   335	static int nct736x_init_chip(struct i2c_client *client,
   336				     u32 pwm_mask, u32 fanin_mask, u32 wdt_cfg)
   337	{
   338		const struct i2c_device_id *id = i2c_match_id(nct736x_id, client);
   339		u8 i, gpio0_3, gpio4_7, gpio10_13, gpio14_17;
   340		int ret;
   341	
   342		for (i = 0; i < NCT736X_PWM_COUNT; i++) {
   343			if (i < 4) {
   344				if (pwm_mask & BIT_CHECK(i))
 > 345					gpio0_3 |= PWM_SEL(i);
   346				if (fanin_mask & BIT_CHECK(i))
 > 347					gpio10_13 |= FANIN_SEL(i);
   348			} else if (i < 8) {
   349				if (pwm_mask & BIT_CHECK(i))
 > 350					gpio4_7 |= PWM_SEL(i);
   351				if (fanin_mask & BIT_CHECK(i))
 > 352					gpio14_17 |= FANIN_SEL(i);
   353			} else if (i < 12) {
   354				if (pwm_mask & BIT_CHECK(i))
   355					gpio10_13 |= PWM_SEL(i);
   356				if (fanin_mask & BIT_CHECK(i))
   357					gpio0_3 |= FANIN_SEL(i);
   358			} else {
   359				if (pwm_mask & BIT_CHECK(i))
   360					gpio14_17 |= PWM_SEL(i);
   361				if (fanin_mask & BIT_CHECK(i))
   362					gpio4_7 |= FANIN_SEL(i);
   363			}
   364		}
   365	
   366		/* Pin Function Configuration */
   367		ret = nct736x_write_reg(client, NCT736X_REG_GPIO_0_3, gpio0_3);
   368		if (ret < 0)
   369			return ret;
   370		ret = nct736x_write_reg(client, NCT736X_REG_GPIO_4_7, gpio4_7);
   371		if (ret < 0)
   372			return ret;
   373		ret = nct736x_write_reg(client, NCT736X_REG_GPIO_10_13, gpio10_13);
   374		if (ret < 0)
   375			return ret;
   376		ret = nct736x_write_reg(client, NCT736X_REG_GPIO_14_17, gpio14_17);
   377		if (ret < 0)
   378			return ret;
   379	
   380		/* PWM and FANIN Monitoring Enable */
   381		ret = nct736x_write_reg(client, NCT736X_REG_PWMEN_0_7,
   382					pwm_mask & 0xff);
   383		if (ret < 0)
   384			return ret;
   385		ret = nct736x_write_reg(client,
   386					NCT736X_REG_PWMEN_8_15, (pwm_mask >> 8) & 0xff);
   387		if (ret < 0)
   388			return ret;
   389		ret = nct736x_write_reg(client, NCT736X_REG_FANINEN_0_7,
   390					fanin_mask & 0xff);
   391		if (ret < 0)
   392			return ret;
   393		ret = nct736x_write_reg(client, NCT736X_REG_FANINEN_8_15,
   394					(fanin_mask >> 8) & 0xff);
   395		if (ret < 0)
   396			return ret;
   397	
   398		/* Watchdog Timer Configuration */
   399		if (wdt_cfg != 0xff && id->driver_data == nct7363) {
   400			ret = nct736x_write_reg(client, NCT7363_REG_WDT, wdt_cfg);
   401			if (ret < 0)
   402				return ret;
   403		}
   404	
   405		return 0;
   406	}
   407	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
