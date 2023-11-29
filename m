Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0423E7FE400
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343581AbjK2XJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjK2XJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:09:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F27AD50
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701299361; x=1732835361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qiftWdWBpUGFAoAbkd0zLQE6rJOagS1X33Lmyslrp6E=;
  b=iey9Bpa+tNQ62v1CHjGS3vRrt/+4qM80hAI0rCIgnXXaMqoI9gfv5uK5
   mcSuWUYyKZArP+CTmW5IqQwsn/kR5hDQceZr7HtgmlX618HzXM83xYSVe
   gy9CV/NazomGOnERBR9YWqAxwCJKit+gHL7Cxptjr6bxZbYIdaJvBZKr/
   gQzeKuU/wsE8kuCiLNZEr06RZVC/QrYmxMXVH/7/s7O8zC4bWe6GUZ5dP
   Ff46LUvCc1S9TcQd8eSr4N29Xbu8mzVA9fvyn5XVeDZBw2fFYmWJ5EVGe
   Th5tU1Q75Y16WyyaDQkY/J7UESQW3Pnc5N4Ze0CK/HuEV7NERNdLHfU5C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="120543"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="120543"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 15:09:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="912995497"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="912995497"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2023 15:09:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8TgC-00013p-0c;
        Wed, 29 Nov 2023 23:09:16 +0000
Date:   Thu, 30 Nov 2023 07:08:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haoran Liu <liuhaoran14@163.com>, lgirdwood@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: Re: [PATCH] [regulator] pwm-regulator: Add error handling
Message-ID: <202311300301.wF0bkQA5-lkp@intel.com>
References: <20231129130530.33744-1-liuhaoran14@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129130530.33744-1-liuhaoran14@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haoran,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.7-rc3]
[also build test ERROR on linus/master next-20231129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haoran-Liu/pwm-regulator-Add-error-handling/20231129-210930
base:   v6.7-rc3
patch link:    https://lore.kernel.org/r/20231129130530.33744-1-liuhaoran14%40163.com
patch subject: [PATCH] [regulator] pwm-regulator: Add error handling
config: x86_64-buildonly-randconfig-004-20231130 (https://download.01.org/0day-ci/archive/20231130/202311300301.wF0bkQA5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311300301.wF0bkQA5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311300301.wF0bkQA5-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/regulator/pwm-regulator.c: In function 'pwm_regulator_init_continuous':
>> drivers/regulator/pwm-regulator.c:299:9: error: 'ret' undeclared (first use in this function); did you mean 'net'?
     299 |         ret = of_property_read_u32_array(pdev->dev.of_node,
         |         ^~~
         |         net
   drivers/regulator/pwm-regulator.c:299:9: note: each undeclared identifier is reported only once for each function it appears in


vim +299 drivers/regulator/pwm-regulator.c

   289	
   290	static int pwm_regulator_init_continuous(struct platform_device *pdev,
   291						 struct pwm_regulator_data *drvdata)
   292	{
   293		u32 dutycycle_range[2] = { 0, 100 };
   294		u32 dutycycle_unit = 100;
   295	
   296		drvdata->desc.ops = &pwm_regulator_voltage_continuous_ops;
   297		drvdata->desc.continuous_voltage_range = true;
   298	
 > 299		ret = of_property_read_u32_array(pdev->dev.of_node,
   300						"pwm-dutycycle-range",
   301						dutycycle_range, 2);
   302		if (ret) {
   303			dev_err(&pdev->dev,
   304				"Failed to read pwm-dutycycle-range: %d\n", ret);
   305			return ret;
   306		}
   307	
   308		ret = of_property_read_u32(pdev->dev.of_node,
   309						"pwm-dutycycle-unit",
   310						&dutycycle_unit);
   311		if (ret) {
   312			dev_err(&pdev->dev,
   313				"Failed to read pwm-dutycycle-unit: %d\n", ret);
   314			return ret;
   315		}
   316	
   317		if (dutycycle_range[0] > dutycycle_unit ||
   318		    dutycycle_range[1] > dutycycle_unit)
   319			return -EINVAL;
   320	
   321		drvdata->continuous.dutycycle_unit = dutycycle_unit;
   322		drvdata->continuous.min_uV_dutycycle = dutycycle_range[0];
   323		drvdata->continuous.max_uV_dutycycle = dutycycle_range[1];
   324	
   325		return 0;
   326	}
   327	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
