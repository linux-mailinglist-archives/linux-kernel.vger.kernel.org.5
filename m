Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB8777EEE1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347560AbjHQB4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347467AbjHQBz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:55:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B800E48;
        Wed, 16 Aug 2023 18:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692237356; x=1723773356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=an4OihAbsi8ksvlnSt9o6Jgc9iKxzwGw/cFTct/opko=;
  b=g25BgoknmQK1Zz8Kg6HW3Oju1naaX2JExJX2qeiCu7q0Zz/H40eTvRvi
   4nO4nXEMfc3ALXVHA9MYhmLhiUKjnhJhUJMxOzttlgNSI9lbIQg6Iumg0
   qQPn8v9m0VmC0u4BGUVaKyFLOndu5lUG5unXsDGBbGwVF+HEFtAmg8vKf
   66kohfXoJ1IinFMGfPoP2cxp+erMqTWRpfq7L0VEgI3dmATIiuvHqReI7
   6uQd9kSoWtrxi7ZQwTsSBDGT4bAFfFG4iN72PYrW9qrp9fQhd6NTR5pQy
   gs2vLZO0jnH2SSWXUl63bbbXtggP3QyMztHQ1+S2BN/qryGp9JuqWysla
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376426060"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="376426060"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 18:55:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848710883"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="848710883"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2023 18:55:52 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWSEq-0000i1-05;
        Thu, 17 Aug 2023 01:55:52 +0000
Date:   Thu, 17 Aug 2023 09:55:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Asmaa Mnebhi <asmaa@nvidia.com>
Subject: Re: [PATCH v2 2/2] gpio: mlxbf3: Support add_pin_ranges()
Message-ID: <202308170926.sCNjFYJH-lkp@intel.com>
References: <20230816154442.8417-3-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816154442.8417-3-asmaa@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Asmaa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next brgl/gpio/for-next linus/master v6.5-rc6 next-20230816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Asmaa-Mnebhi/pinctrl-mlxbf3-Remove-gpio_disable_free/20230816-234711
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20230816154442.8417-3-asmaa%40nvidia.com
patch subject: [PATCH v2 2/2] gpio: mlxbf3: Support add_pin_ranges()
config: i386-buildonly-randconfig-r005-20230817 (https://download.01.org/0day-ci/archive/20230817/202308170926.sCNjFYJH-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308170926.sCNjFYJH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308170926.sCNjFYJH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpio-mlxbf3.c:164:6: warning: unused variable 'ret' [-Wunused-variable]
           int ret;
               ^
   1 warning generated.


vim +/ret +164 drivers/gpio/gpio-mlxbf3.c

   160	
   161	static int mlxbf3_gpio_add_pin_ranges(struct gpio_chip *chip)
   162	{
   163		unsigned int id = 0;
 > 164		int ret;
   165	
   166		if (chip->ngpio % MLXBF3_GPIO_MAX_PINS_PER_BLOCK)
   167			id = 1;
   168	
   169		return gpiochip_add_pin_range(chip, "MLNXBF34:00",
   170				chip->base, id * MLXBF3_GPIO_MAX_PINS_PER_BLOCK,
   171				chip->ngpio);
   172	}
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
