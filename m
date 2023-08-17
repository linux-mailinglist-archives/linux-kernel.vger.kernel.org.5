Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA7777FE3A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354625AbjHQS6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353742AbjHQS6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:58:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229DDC1;
        Thu, 17 Aug 2023 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692298682; x=1723834682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7yo3tNXh31iOl1DRSqLjn8gRj2unBq2YatRzwFJUzDI=;
  b=UAdcOeR7wxX3kuko9KmQOLUTNxavPGflmbrrXKDT/xAfereJa1Vtuv4S
   tcvLQ0YSO0mFbqdAksTjwXKdBggDppayRdNYNrzK7nGLzC1Y94PefclQU
   K6aRqUoEirnR1DJLhKDuVcOP4pzfkdSi14pf0v5fTXzh4eHose445opOA
   3DRwibtdMcRl7yji1+BAqW17djQXo2ji21EbfqNxG84XOh5qC1x5D+E7X
   idM8JMTvCL3w9d5wucb++qYhker/IDJIpffFKoZhvaSs0xDCUukP/SUFR
   2S5sbhjI66Ec23jq2M3syAxB/WWjvSFkzLlP5y+CRQgt0esJiplBsOKGy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371805533"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="371805533"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 11:58:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="734766972"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="734766972"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2023 11:57:51 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWiBp-0001Ox-34;
        Thu, 17 Aug 2023 18:57:49 +0000
Date:   Fri, 18 Aug 2023 02:57:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        corbet@lwn.net, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        BMC-SW@aspeedtech.com, patrick@stwcx.xyz
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 2/2] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED
 g6 PWM/Fan tach
Message-ID: <202308180218.lgWU1tp1-lkp@intel.com>
References: <20230817120029.221484-3-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817120029.221484-3-billy_tsai@aspeedtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Billy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.5-rc6 next-20230817]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Billy-Tsai/dt-bindings-hwmon-Support-Aspeed-g6-PWM-TACH-Control/20230817-200427
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20230817120029.221484-3-billy_tsai%40aspeedtech.com
patch subject: [PATCH v7 2/2] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach
config: powerpc-randconfig-r011-20230818 (https://download.01.org/0day-ci/archive/20230818/202308180218.lgWU1tp1-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308180218.lgWU1tp1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308180218.lgWU1tp1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwmon/aspeed-g6-pwm-tach.c:431:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     431 |         int ret, count;
         |             ^
   1 warning generated.


vim +/ret +431 drivers/hwmon/aspeed-g6-pwm-tach.c

   426	
   427	static int aspeed_tach_create_fan(struct device *dev,
   428					  struct aspeed_pwm_tach_data *priv)
   429	{
   430		u8 *tach_ch;
 > 431		int ret, count;
   432	
   433		count = of_property_count_u8_elems(dev->of_node, "aspeed,fan-tach-ch");
   434		if (count < 1)
   435			return -EINVAL;
   436		tach_ch = devm_kcalloc(dev, count, sizeof(*tach_ch), GFP_KERNEL);
   437		if (!tach_ch)
   438			return -ENOMEM;
   439		ret = of_property_read_u8_array(dev->of_node, "aspeed,fan-tach-ch",
   440						tach_ch, count);
   441	
   442		aspeed_present_fan_tach(priv, tach_ch, count);
   443	
   444		return 0;
   445	}
   446	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
