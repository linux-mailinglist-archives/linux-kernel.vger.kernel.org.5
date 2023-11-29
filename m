Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3697FE418
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343613AbjK2XNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjK2XND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:13:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D472A2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701299589; x=1732835589;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B3Pmc/bJMfGydSsp7HHeLKgvHx1bcl85MNeuryNu+hM=;
  b=eaMWxaPG1FXqp7POoWL7O6nb9kivHVlMO6/P8EcEcPXa2o5Az1WGDntY
   dh21MndybvzFjEDqODuzGmd18hDfIjTtfct/XyUXUoSrFxNIPu8FUxZLB
   VerQAAJ8kJu3RcOaPeuGpnxsrml/H52MHuQc6xXHV9hSIfc51jxDdQuIL
   RtW/6yHx9jswJUOEZFoSY/JfmER0u/f9LEERbETEhQ8PFz2OjAzhWf+uS
   8wMxzxjjApmLlcq1m7H7toHyNbdH1Yd4EldejiUeL9ItlnC269MYJhPBU
   xajtXQrIrhLO2wVqhOjnzCJwIRMjJWp2OM/7J4O9YokL3seLdC+dmq+X1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="14796273"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="14796273"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 15:13:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="798085320"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="798085320"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 29 Nov 2023 15:13:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8Tjs-000146-3B;
        Wed, 29 Nov 2023 23:13:04 +0000
Date:   Thu, 30 Nov 2023 07:11:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haoran Liu <liuhaoran14@163.com>, lgirdwood@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: Re: [PATCH] [regulator] pwm-regulator: Add error handling
Message-ID: <202311300304.BQV0GwDE-lkp@intel.com>
References: <20231129130530.33744-1-liuhaoran14@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129130530.33744-1-liuhaoran14@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
config: i386-randconfig-r081-20231130 (https://download.01.org/0day-ci/archive/20231130/202311300304.BQV0GwDE-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311300304.BQV0GwDE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311300304.BQV0GwDE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/regulator/pwm-regulator.c:299:2: error: use of undeclared identifier 'ret'
           ret = of_property_read_u32_array(pdev->dev.of_node,
           ^
   drivers/regulator/pwm-regulator.c:302:6: error: use of undeclared identifier 'ret'
           if (ret) {
               ^
   drivers/regulator/pwm-regulator.c:304:48: error: use of undeclared identifier 'ret'
                           "Failed to read pwm-dutycycle-range: %d\n", ret);
                                                                       ^
   drivers/regulator/pwm-regulator.c:305:10: error: use of undeclared identifier 'ret'
                   return ret;
                          ^
   drivers/regulator/pwm-regulator.c:308:2: error: use of undeclared identifier 'ret'
           ret = of_property_read_u32(pdev->dev.of_node,
           ^
   drivers/regulator/pwm-regulator.c:311:6: error: use of undeclared identifier 'ret'
           if (ret) {
               ^
   drivers/regulator/pwm-regulator.c:313:47: error: use of undeclared identifier 'ret'
                           "Failed to read pwm-dutycycle-unit: %d\n", ret);
                                                                      ^
   drivers/regulator/pwm-regulator.c:314:10: error: use of undeclared identifier 'ret'
                   return ret;
                          ^
   8 errors generated.


vim +/ret +299 drivers/regulator/pwm-regulator.c

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
