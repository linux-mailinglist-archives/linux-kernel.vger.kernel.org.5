Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD94D77854A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHKCRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHKCRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:17:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F43A26A0;
        Thu, 10 Aug 2023 19:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691720252; x=1723256252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0THyFkSnK1p9RVFPp9ADMVWBCe9AiR93iSgzIjVkqpo=;
  b=nU5NhOPyUVJjRK2ex90AvSEmc/6/CWwX2nAaCOVfUoYTGr/JV3ODlHaO
   ew7yWOU7JifSj2GKTDDC4t9Bn2SrSE4ts/KvudAHQYVZ4F77Fg5CPc87/
   S8xWCc7H50CizRC7hCWs/WDTeN6PsHHq5thuD8glfdSgg2sJUwFaCCyln
   p++0joNM87zCXkSNKL93devyl9p2tqBdEuXpZbEcnqoy0t1fHLe2/HoZT
   9A1TSrrdsfty3B0kYZs1XUhua4l4Pa4cmcsJ6cMJOsLcCe5Wg5Ii2iCN7
   fTwwe0p/TK8yG/YH5ZxH6MdK/s7BFSGDI18I1GIlLp2Q7o1gOPIltdt1y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="369045307"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="369045307"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 19:17:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="846625134"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="846625134"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2023 19:17:26 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUHiQ-0007QS-0U;
        Fri, 11 Aug 2023 02:17:26 +0000
Date:   Fri, 11 Aug 2023 10:17:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Subject: Re: [PATCH 1/4] clk: mmp2: Move number of clocks into driver source
Message-ID: <202308110800.KkX1CemC-lkp@intel.com>
References: <20230809-mmp-nr-clks-v1-1-5f3cdbbb89b8@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809-mmp-nr-clks-v1-1-5f3cdbbb89b8@skole.hr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Duje,

kernel test robot noticed the following build errors:

[auto build test ERROR on 52a93d39b17dc7eb98b6aa3edb93943248e03b2f]

url:    https://github.com/intel-lab-lkp/linux/commits/Duje-Mihanovi/clk-mmp2-Move-number-of-clocks-into-driver-source/20230809-202111
base:   52a93d39b17dc7eb98b6aa3edb93943248e03b2f
patch link:    https://lore.kernel.org/r/20230809-mmp-nr-clks-v1-1-5f3cdbbb89b8%40skole.hr
patch subject: [PATCH 1/4] clk: mmp2: Move number of clocks into driver source
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20230811/202308110800.KkX1CemC-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308110800.KkX1CemC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308110800.KkX1CemC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/bits.h:5,
                    from include/linux/bitops.h:6,
                    from include/linux/of.h:15,
                    from include/linux/clk-provider.h:9,
                    from drivers/clk/mmp/clk-audio.c:8:
   drivers/clk/mmp/clk-audio.c: In function 'mmp2_audio_clk_probe':
>> drivers/clk/mmp/clk-audio.c:354:41: error: 'MMP2_CLK_AUDIO_NR_CLKS' undeclared (first use in this function); did you mean 'MMP2_CLK_AUDIO_SYSCLK'?
     354 |                                         MMP2_CLK_AUDIO_NR_CLKS),
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/const.h:12:55: note: in definition of macro '__is_constexpr'
      12 |         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                       ^
   drivers/clk/mmp/clk-audio.c:353:29: note: in expansion of macro 'struct_size'
     353 |                             struct_size(priv, clk_data.hws,
         |                             ^~~~~~~~~~~
   drivers/clk/mmp/clk-audio.c:354:41: note: each undeclared identifier is reported only once for each function it appears in
     354 |                                         MMP2_CLK_AUDIO_NR_CLKS),
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/const.h:12:55: note: in definition of macro '__is_constexpr'
      12 |         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
         |                                                       ^
   drivers/clk/mmp/clk-audio.c:353:29: note: in expansion of macro 'struct_size'
     353 |                             struct_size(priv, clk_data.hws,
         |                             ^~~~~~~~~~~
   In file included from include/linux/vmalloc.h:11,
                    from include/asm-generic/io.h:994,
                    from arch/arm/include/asm/io.h:416,
                    from include/linux/io.h:13,
                    from drivers/clk/mmp/clk-audio.c:9:
>> include/linux/overflow.h:276:9: error: first argument to '__builtin_choose_expr' not a constant
     276 |         __builtin_choose_expr(__is_constexpr(count),                    \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:293:32: note: in expansion of macro 'flex_array_size'
     293 |                 sizeof(*(p)) + flex_array_size(p, member, count),       \
         |                                ^~~~~~~~~~~~~~~
   drivers/clk/mmp/clk-audio.c:353:29: note: in expansion of macro 'struct_size'
     353 |                             struct_size(priv, clk_data.hws,
         |                             ^~~~~~~~~~~
>> include/linux/overflow.h:276:9: error: first argument to '__builtin_choose_expr' not a constant
     276 |         __builtin_choose_expr(__is_constexpr(count),                    \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:294:40: note: in expansion of macro 'flex_array_size'
     294 |                 size_add(sizeof(*(p)), flex_array_size(p, member, count)))
         |                                        ^~~~~~~~~~~~~~~
   drivers/clk/mmp/clk-audio.c:353:29: note: in expansion of macro 'struct_size'
     353 |                             struct_size(priv, clk_data.hws,
         |                             ^~~~~~~~~~~
   include/linux/overflow.h:292:9: error: first argument to '__builtin_choose_expr' not a constant
     292 |         __builtin_choose_expr(__is_constexpr(count),                    \
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clk/mmp/clk-audio.c:353:29: note: in expansion of macro 'struct_size'
     353 |                             struct_size(priv, clk_data.hws,
         |                             ^~~~~~~~~~~


vim +354 drivers/clk/mmp/clk-audio.c

725262d29139cc Lubomir Rintel 2020-05-20  346  
725262d29139cc Lubomir Rintel 2020-05-20  347  static int mmp2_audio_clk_probe(struct platform_device *pdev)
725262d29139cc Lubomir Rintel 2020-05-20  348  {
725262d29139cc Lubomir Rintel 2020-05-20  349  	struct mmp2_audio_clk *priv;
725262d29139cc Lubomir Rintel 2020-05-20  350  	int ret;
725262d29139cc Lubomir Rintel 2020-05-20  351  
725262d29139cc Lubomir Rintel 2020-05-20  352  	priv = devm_kzalloc(&pdev->dev,
725262d29139cc Lubomir Rintel 2020-05-20  353  			    struct_size(priv, clk_data.hws,
725262d29139cc Lubomir Rintel 2020-05-20 @354  					MMP2_CLK_AUDIO_NR_CLKS),
725262d29139cc Lubomir Rintel 2020-05-20  355  			    GFP_KERNEL);
725262d29139cc Lubomir Rintel 2020-05-20  356  	if (!priv)
725262d29139cc Lubomir Rintel 2020-05-20  357  		return -ENOMEM;
725262d29139cc Lubomir Rintel 2020-05-20  358  
725262d29139cc Lubomir Rintel 2020-05-20  359  	spin_lock_init(&priv->lock);
725262d29139cc Lubomir Rintel 2020-05-20  360  	platform_set_drvdata(pdev, priv);
725262d29139cc Lubomir Rintel 2020-05-20  361  
725262d29139cc Lubomir Rintel 2020-05-20  362  	priv->mmio_base = devm_platform_ioremap_resource(pdev, 0);
725262d29139cc Lubomir Rintel 2020-05-20  363  	if (IS_ERR(priv->mmio_base))
725262d29139cc Lubomir Rintel 2020-05-20  364  		return PTR_ERR(priv->mmio_base);
725262d29139cc Lubomir Rintel 2020-05-20  365  
725262d29139cc Lubomir Rintel 2020-05-20  366  	pm_runtime_enable(&pdev->dev);
725262d29139cc Lubomir Rintel 2020-05-20  367  	ret = pm_clk_create(&pdev->dev);
725262d29139cc Lubomir Rintel 2020-05-20  368  	if (ret)
725262d29139cc Lubomir Rintel 2020-05-20  369  		goto disable_pm_runtime;
725262d29139cc Lubomir Rintel 2020-05-20  370  
725262d29139cc Lubomir Rintel 2020-05-20  371  	ret = pm_clk_add(&pdev->dev, "audio");
725262d29139cc Lubomir Rintel 2020-05-20  372  	if (ret)
725262d29139cc Lubomir Rintel 2020-05-20  373  		goto destroy_pm_clk;
725262d29139cc Lubomir Rintel 2020-05-20  374  
725262d29139cc Lubomir Rintel 2020-05-20  375  	ret = register_clocks(priv, &pdev->dev);
725262d29139cc Lubomir Rintel 2020-05-20  376  	if (ret)
725262d29139cc Lubomir Rintel 2020-05-20  377  		goto destroy_pm_clk;
725262d29139cc Lubomir Rintel 2020-05-20  378  
725262d29139cc Lubomir Rintel 2020-05-20  379  	return 0;
725262d29139cc Lubomir Rintel 2020-05-20  380  
725262d29139cc Lubomir Rintel 2020-05-20  381  destroy_pm_clk:
725262d29139cc Lubomir Rintel 2020-05-20  382  	pm_clk_destroy(&pdev->dev);
725262d29139cc Lubomir Rintel 2020-05-20  383  disable_pm_runtime:
725262d29139cc Lubomir Rintel 2020-05-20  384  	pm_runtime_disable(&pdev->dev);
725262d29139cc Lubomir Rintel 2020-05-20  385  
725262d29139cc Lubomir Rintel 2020-05-20  386  	return ret;
725262d29139cc Lubomir Rintel 2020-05-20  387  }
725262d29139cc Lubomir Rintel 2020-05-20  388  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
