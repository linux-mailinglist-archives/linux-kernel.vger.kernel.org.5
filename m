Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544F2758B84
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGSCrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGSCrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:47:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C993B1BDC;
        Tue, 18 Jul 2023 19:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689734850; x=1721270850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7l2RLpq7FfwUjP9ss8SVVFWP/mR+Jc43Uc8Ex0yPyD4=;
  b=Ldhe186cycf8RjDZEPWiKWUC8OROpIXYR/wMSSrdZNi7yISnuX91TlGo
   K76fOxvMxYMm9q/zqCnzjZLy3pm28VmKUizq/dhpZ34szwL9ba8UKztuJ
   2q4WyuQpXQxZI0K2hEEerpQ6N3tqOQJIjGinDIlTh0K+Lv1/aJLV78U2b
   k3A6wINW5JUQKIOM18y+nFnwcgvR4jPan9FT4/YeRkY4FyXJuHUkppqrC
   N6ZgxalGPw1pXXVBtcBxyCD5M+BkMH8hTUmbvgxTpHT8okXrSWSgdT0Dz
   HsPd+z+UbcbLk50K2csAFGswEwwJrHY4EB6LXING8cfrFzCQfhnL0Rmzl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="356305645"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="356305645"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 19:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="723840975"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="723840975"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2023 19:47:26 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLxDp-00045M-1J;
        Wed, 19 Jul 2023 02:47:25 +0000
Date:   Wed, 19 Jul 2023 10:46:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org,
        stephan@gerhold.net
Subject: Re: [PATCH v9 4/7] usb: misc: eud: Add driver support for SM6115 /
 SM4250
Message-ID: <202307191045.FMNOhyay-lkp@intel.com>
References: <20230718061052.1332993-5-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718061052.1332993-5-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus lee-mfd/for-mfd-next linus/master v6.5-rc2 next-20230718]
[cannot apply to robh/for-next lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh-Sharma/dt-bindings-mfd-qcom-tcsr-Add-the-compatible-for-SM6115/20230718-190223
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230718061052.1332993-5-bhupesh.sharma%40linaro.org
patch subject: [PATCH v9 4/7] usb: misc: eud: Add driver support for SM6115 / SM4250
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230719/202307191045.FMNOhyay-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307191045.FMNOhyay-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307191045.FMNOhyay-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/misc/qcom_eud.c: In function 'eud_probe':
>> drivers/usb/misc/qcom_eud.c:251:52: error: passing argument 2 of 'eud_find_secure_reg_addr' from incompatible pointer type [-Werror=incompatible-pointer-types]
     251 |         ret = eud_find_secure_reg_addr(&pdev->dev, &tcsr_check);
         |                                                    ^~~~~~~~~~~
         |                                                    |
         |                                                    phys_addr_t * {aka unsigned int *}
   drivers/usb/misc/qcom_eud.c:194:62: note: expected 'u64 *' {aka 'long long unsigned int *'} but argument is of type 'phys_addr_t *' {aka 'unsigned int *'}
     194 | static int eud_find_secure_reg_addr(struct device *dev, u64 *addr)
         |                                                         ~~~~~^~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SM_GCC_8350
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
   Selected by [m]:
   - SM_VIDEOCC_8350 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   WARNING: unmet direct dependencies detected for SM_GCC_8450
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
   Selected by [m]:
   - SM_GPUCC_8450 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   - SM_VIDEOCC_8450 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   WARNING: unmet direct dependencies detected for SM_GCC_8550
   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
   Selected by [m]:
   - SM_GPUCC_8550 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
   - SM_VIDEOCC_8550 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]


vim +/eud_find_secure_reg_addr +251 drivers/usb/misc/qcom_eud.c

   219	
   220	static int eud_probe(struct platform_device *pdev)
   221	{
   222		struct eud_chip *chip;
   223		struct resource *res;
   224		phys_addr_t tcsr_check = 0;
   225		int ret;
   226	
   227		chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
   228		if (!chip)
   229			return -ENOMEM;
   230	
   231		chip->dev = &pdev->dev;
   232	
   233		chip->role_sw = usb_role_switch_get(&pdev->dev);
   234		if (IS_ERR(chip->role_sw))
   235			return dev_err_probe(chip->dev, PTR_ERR(chip->role_sw),
   236						"failed to get role switch\n");
   237	
   238		ret = devm_add_action_or_reset(chip->dev, eud_role_switch_release, chip);
   239		if (ret)
   240			return dev_err_probe(chip->dev, ret,
   241					"failed to add role switch release action\n");
   242	
   243		chip->base = devm_platform_ioremap_resource(pdev, 0);
   244		if (IS_ERR(chip->base))
   245			return PTR_ERR(chip->base);
   246	
   247		/*
   248		 * EUD block on a few Qualcomm SoCs needs secure register access.
   249		 * Check for the same via vendor-specific dt property.
   250		 */
 > 251		ret = eud_find_secure_reg_addr(&pdev->dev, &tcsr_check);
   252		if (ret < 0)
   253			return ret;
   254	
   255		if (tcsr_check) {
   256			res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
   257			if (!res)
   258				return dev_err_probe(chip->dev, -ENODEV,
   259						     "failed to get secure_mode_mgr reg base\n");
   260	
   261			chip->secure_mode_mgr = res->start;
   262	
   263			ret = qcom_scm_io_writel(tcsr_check, TCSR_CHECK_EN);
   264			if (ret)
   265				return dev_err_probe(chip->dev, ret, "failed to write tcsr check reg\n");
   266		} else {
   267			chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
   268			if (IS_ERR(chip->mode_mgr))
   269				return PTR_ERR(chip->mode_mgr);
   270		}
   271	
   272		chip->irq = platform_get_irq(pdev, 0);
   273		ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
   274				handle_eud_irq_thread, IRQF_ONESHOT, NULL, chip);
   275		if (ret)
   276			return dev_err_probe(chip->dev, ret, "failed to allocate irq\n");
   277	
   278		enable_irq_wake(chip->irq);
   279	
   280		platform_set_drvdata(pdev, chip);
   281	
   282		return 0;
   283	}
   284	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
