Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A916B77A599
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 10:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjHMI2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 04:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHMI2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 04:28:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDA010FE;
        Sun, 13 Aug 2023 01:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691915319; x=1723451319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XxPTm8R4vR10S02dVEZu8zr6sQWPR0ovTfnQKuydudc=;
  b=FQvNokOZJFJY0mJT2Elb1kVRvspb/85iaouttocNHXFrn8pUYxSNliua
   HMuwMgyqwRKytJCL2IPqaxA/QucsiumeDuwTtiQDEKyRuTCJSic+a7qDt
   +7uAgarLVNqt6bZaJ/qR+YG0tB5UB0UcsUQuzRMXjhkkU7/6mWYMKaD1v
   rhoVfFToAvqFnkmZrochSpQAUV9h7arzT55rwzWD4vJw3BHvAkuZ1i5Q9
   OmvzcZ6f2vCmokKeDsVtgmY+XqeUqwabzApJwhz35JQcYBExI/eEKeikC
   IWrVprZwvZx5vzBCW3kY3qL9SY4/gWe+dHzlYQCXAR8LrA7dX8CGrMeea
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="351482597"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="351482597"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 01:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="733112417"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="733112417"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2023 01:28:34 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qV6Sf-00091s-2h;
        Sun, 13 Aug 2023 08:28:33 +0000
Date:   Sun, 13 Aug 2023 16:28:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: Re: [PATCH 4/5] net: stmmac: Add glue layer for Loongson-1 SoC
Message-ID: <202308131600.I6iscZMl-lkp@intel.com>
References: <20230812151135.1028780-5-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812151135.1028780-5-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keguang,

kernel test robot noticed the following build errors:

[auto build test ERROR on 21ef7b1e17d039053edaeaf41142423810572741]

url:    https://github.com/intel-lab-lkp/linux/commits/Keguang-Zhang/MIPS-loongson32-Remove-Loongson1-MAC-arch-code/20230812-231420
base:   21ef7b1e17d039053edaeaf41142423810572741
patch link:    https://lore.kernel.org/r/20230812151135.1028780-5-keguang.zhang%40gmail.com
patch subject: [PATCH 4/5] net: stmmac: Add glue layer for Loongson-1 SoC
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230813/202308131600.I6iscZMl-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230813/202308131600.I6iscZMl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308131600.I6iscZMl-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c: In function 'ls1x_dwmac_probe':
>> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c:188:21: error: implicit declaration of function 'of_parse_phandle' [-Werror=implicit-function-declaration]
     188 |         syscon_np = of_parse_phandle(pdev->dev.of_node, "syscon", 0);
         |                     ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c:188:19: warning: assignment to 'struct device_node *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     188 |         syscon_np = of_parse_phandle(pdev->dev.of_node, "syscon", 0);
         |                   ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c:192:17: error: implicit declaration of function 'of_match_node'; did you mean 'for_each_node'? [-Werror=implicit-function-declaration]
     192 |         match = of_match_node(ls1x_dwmac_syscon_match, syscon_np);
         |                 ^~~~~~~~~~~~~
         |                 for_each_node
   drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c:192:15: warning: assignment to 'const struct of_device_id *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     192 |         match = of_match_node(ls1x_dwmac_syscon_match, syscon_np);
         |               ^
>> drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c:194:17: error: implicit declaration of function 'of_node_put'; did you mean 'bpf_module_put'? [-Werror=implicit-function-declaration]
     194 |                 of_node_put(syscon_np);
         |                 ^~~~~~~~~~~
         |                 bpf_module_put
   cc1: some warnings being treated as errors


vim +/of_parse_phandle +188 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c

   170	
   171	static int ls1x_dwmac_probe(struct platform_device *pdev)
   172	{
   173		struct plat_stmmacenet_data *plat_dat;
   174		struct stmmac_resources stmmac_res;
   175		struct device_node *syscon_np;
   176		const struct of_device_id *match;
   177		struct regmap *regmap;
   178		struct ls1x_dwmac *dwmac;
   179		const struct ls1x_dwmac_syscon *syscon;
   180		size_t size;
   181		int ret;
   182	
   183		ret = stmmac_get_platform_resources(pdev, &stmmac_res);
   184		if (ret)
   185			return ret;
   186	
   187		/* Probe syscon */
 > 188		syscon_np = of_parse_phandle(pdev->dev.of_node, "syscon", 0);
   189		if (!syscon_np)
   190			return -ENODEV;
   191	
 > 192		match = of_match_node(ls1x_dwmac_syscon_match, syscon_np);
   193		if (!match) {
 > 194			of_node_put(syscon_np);
   195			return -EINVAL;
   196		}
   197		syscon = (const struct ls1x_dwmac_syscon *)match->data;
   198	
   199		regmap = syscon_node_to_regmap(syscon_np);
   200		of_node_put(syscon_np);
   201		if (IS_ERR(regmap)) {
   202			ret = PTR_ERR(regmap);
   203			dev_err(&pdev->dev, "Unable to map syscon: %d\n", ret);
   204			return ret;
   205		}
   206	
   207		size = syscon->nr_reg_fields * sizeof(struct regmap_field *);
   208		dwmac = devm_kzalloc(&pdev->dev, sizeof(*dwmac) + size, GFP_KERNEL);
   209		if (!dwmac)
   210			return -ENOMEM;
   211	
   212		plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
   213		if (IS_ERR(plat_dat)) {
   214			dev_err(&pdev->dev, "dt configuration failed\n");
   215			return PTR_ERR(plat_dat);
   216		}
   217	
   218		plat_dat->bsp_priv = dwmac;
   219		plat_dat->init = ls1x_dwmac_init;
   220		dwmac->dev = &pdev->dev;
   221		dwmac->plat_dat = plat_dat;
   222		dwmac->syscon = syscon;
   223		dwmac->regmap = regmap;
   224	
   225		ret = stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
   226		if (ret)
   227			goto err_remove_config_dt;
   228	
   229		return 0;
   230	
   231	err_remove_config_dt:
   232		if (pdev->dev.of_node)
   233			stmmac_remove_config_dt(pdev, plat_dat);
   234	
   235		return ret;
   236	}
   237	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
