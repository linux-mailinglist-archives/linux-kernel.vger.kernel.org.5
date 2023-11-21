Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408C67F356F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjKUSAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjKUSAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:00:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3392197;
        Tue, 21 Nov 2023 09:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700589598; x=1732125598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HajNcANzS8KHjONWzavIj/4wpkVTaBzXzzIAQEqc5MU=;
  b=aXPgOJI0oC7xUaDkTkvb2wElPOfZPZkKJT1NXRRaIAEYXsv9wW9PVEQF
   8npqSnSWtFmOSgwzH2KhaNHEQ1U/T4Ix2MMC3zid/hwskNjU1iPI9S3k0
   s5N0zXj2oKu9R8WqfM89VCwBJyKuILvWshECuE8yOCCU1asLxUhwECszm
   u7zwhMhP8z662Ad/J7cpEN1X041aQbTF583B3g0L9brJ2B/1vD9jauCJZ
   FQ6GWz45L7ijePon+X5DWjD/0MuywUqo7lcGrnEjLPfgHLsnx2YMADLL+
   fgO2gHpMoijDfincr7srDxydyzlsbbMS+CBf0rXrQmG080eQdUzq4Av9p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="422990035"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="422990035"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 09:59:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="760171994"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="760171994"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 21 Nov 2023 09:59:53 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5V2E-00086K-00;
        Tue, 21 Nov 2023 17:59:45 +0000
Date:   Wed, 22 Nov 2023 01:58:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jingbao Qiu <qiujingbao.dlmu@gmail.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, krzysztof.kozlowski+dt@linaro.org,
        chao.wei@sophgo.com, unicorn_wang@outlook.com, conor+dt@kernel.org,
        robh+dt@kernel.org, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     oe-kbuild-all@lists.linux.dev, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: Re: [PATCH 2/3] rtc: add rtc controller support for Sophgo CV1800B
 SoC
Message-ID: <202311220129.aOYelwJQ-lkp@intel.com>
References: <20231121094642.2973795-3-qiujingbao.dlmu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121094642.2973795-3-qiujingbao.dlmu@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingbao,

kernel test robot noticed the following build errors:

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on linus/master v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jingbao-Qiu/dt-bindings-rtc-add-binding-for-Sophgo-CV1800B-rtc-controller/20231121-174927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20231121094642.2973795-3-qiujingbao.dlmu%40gmail.com
patch subject: [PATCH 2/3] rtc: add rtc controller support for Sophgo CV1800B SoC
config: parisc-allmodconfig (https://download.01.org/0day-ci/archive/20231122/202311220129.aOYelwJQ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220129.aOYelwJQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220129.aOYelwJQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/rtc/rtc-cv1800b.c: In function 'cv1800b_rtc_probe':
>> drivers/rtc/rtc-cv1800b.c:246:16: error: implicit declaration of function 'rtc_register_device'; did you mean 'devm_rtc_register_device'? [-Werror=implicit-function-declaration]
     246 |         return rtc_register_device(rtc->rtc_dev);
         |                ^~~~~~~~~~~~~~~~~~~
         |                devm_rtc_register_device
   cc1: some warnings being treated as errors


vim +246 drivers/rtc/rtc-cv1800b.c

   189	
   190	static int cv1800b_rtc_probe(struct platform_device *pdev)
   191	{
   192		struct cv1800b_rtc_priv *rtc;
   193		struct resource *res;
   194		int ret;
   195	
   196		rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
   197		if (!rtc)
   198			return -ENOMEM;
   199	
   200		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   201		if (!res) {
   202			ret = -ENODEV;
   203			goto err;
   204		}
   205	
   206		rtc->core_map = devm_ioremap_resource(&pdev->dev, res);
   207		if (IS_ERR(rtc->core_map)) {
   208			ret = PTR_ERR(rtc->core_map);
   209			goto err;
   210		}
   211	
   212		rtc->irq = platform_get_irq(pdev, 0);
   213		platform_set_drvdata(pdev, rtc);
   214		if (rtc->irq < 0) {
   215			ret = -EINVAL;
   216			goto err;
   217		}
   218	
   219		ret =
   220		    devm_request_irq(&pdev->dev, rtc->irq, cv1800b_rtc_irq_handler,
   221				     IRQF_SHARED, "rtc alarm", &pdev->dev);
   222		if (ret)
   223			goto err;
   224	
   225		rtc->clk = devm_clk_get(&pdev->dev, NULL);
   226		if (IS_ERR(rtc->clk)) {
   227			dev_err(&pdev->dev, "no clock");
   228			ret = PTR_ERR(rtc->clk);
   229			goto err;
   230		}
   231		ret = clk_prepare_enable(rtc->clk);
   232		if (ret)
   233			goto err;
   234		ret = cv1800b_rtc_softinit(rtc);
   235		if (ret)
   236			goto err;
   237		cv1800b_rtc_alarm_irq_enable(&pdev->dev, 1);
   238		rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
   239		if (IS_ERR(rtc->rtc_dev)) {
   240			ret = PTR_ERR(rtc->rtc_dev);
   241			goto err;
   242		}
   243		rtc->rtc_dev->range_max = U32_MAX;
   244		rtc->rtc_dev->ops = &cv800b_rtc_ops;
   245	
 > 246		return rtc_register_device(rtc->rtc_dev);
   247	err:
   248		return dev_err_probe(&pdev->dev, ret, "Failed to init cv1800b rtc\n");
   249	}
   250	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
