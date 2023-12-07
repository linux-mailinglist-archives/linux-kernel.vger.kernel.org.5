Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA29809109
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443786AbjLGTHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443238AbjLGTHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:07:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9737A10DC;
        Thu,  7 Dec 2023 11:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701976071; x=1733512071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ieJEkuMKhcAdLylW1AUSXkjLtQT7yen+rjsrcCv2Ujc=;
  b=kgzskMW/3jukR6TzUl0mJOaRdE4iWCJVIFLxzK2Qx4bETHg4W0bdjkcg
   fpyiYqjAmV65Je+Rw+6MXo/XiZZrxil4oibO8XvSJLfebGfpBeW6poS6x
   MNQNo1TGR/l+9WGJl8yIB2/8X+obo2sWylZGDT6gkN36Bs7uBEDp90sbx
   uvY1IGrEM8C8xXcc3EqT7iW9zxdy8qo417Fpu2OYX1Iae2ExMGaVgjZAw
   ADpZeJZAagU6Std/cyYa72JKSjer4GSfhV5FW6hymKr8gGgI08df9bgHH
   d9pVfcgpChth6E796MThHDzLIjBxm0aR73q8jMj2ZA4XIFmOIpbazuNA3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="15843127"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="15843127"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:07:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="721582135"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="721582135"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2023 11:07:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBJio-000Cib-0A;
        Thu, 07 Dec 2023 19:07:42 +0000
Date:   Fri, 8 Dec 2023 03:07:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
Cc:     oe-kbuild-all@lists.linux.dev, Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v5 3/4] clk: sophgo: Add SG2042 clock generator driver
Message-ID: <202312080230.uE0e0ycK-lkp@intel.com>
References: <975f9995584dfa8af751e96a1f4d2c7991551a35.1701938395.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <975f9995584dfa8af751e96a1f4d2c7991551a35.1701938395.git.unicorn_wang@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

kernel test robot noticed the following build errors:

[auto build test ERROR on b85ea95d086471afb4ad062012a4d73cd328fa86]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Wang/dt-bindings-soc-sophgo-Add-Sophgo-system-control-module/20231207-165948
base:   b85ea95d086471afb4ad062012a4d73cd328fa86
patch link:    https://lore.kernel.org/r/975f9995584dfa8af751e96a1f4d2c7991551a35.1701938395.git.unicorn_wang%40outlook.com
patch subject: [PATCH v5 3/4] clk: sophgo: Add SG2042 clock generator driver
config: arc-randconfig-002-20231208 (https://download.01.org/0day-ci/archive/20231208/202312080230.uE0e0ycK-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312080230.uE0e0ycK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080230.uE0e0ycK-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/clk/sophgo/clk-sophgo-sg2042.c: In function 'sg2042_clk_init_clk_data':
>> drivers/clk/sophgo/clk-sophgo-sg2042.c:1273:20: error: implicit declaration of function 'kzalloc'; did you mean 'vzalloc'? [-Werror=implicit-function-declaration]
    1273 |         clk_data = kzalloc(struct_size(clk_data, onecell_data.hws, num_clks), GFP_KERNEL);
         |                    ^~~~~~~
         |                    vzalloc
>> drivers/clk/sophgo/clk-sophgo-sg2042.c:1273:18: warning: assignment to 'struct sg2042_clk_data *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1273 |         clk_data = kzalloc(struct_size(clk_data, onecell_data.hws, num_clks), GFP_KERNEL);
         |                  ^
>> drivers/clk/sophgo/clk-sophgo-sg2042.c:1293:9: error: implicit declaration of function 'kfree'; did you mean 'vfree'? [-Werror=implicit-function-declaration]
    1293 |         kfree(clk_data);
         |         ^~~~~
         |         vfree
   cc1: some warnings being treated as errors


vim +1273 drivers/clk/sophgo/clk-sophgo-sg2042.c

  1256	
  1257	static int __init sg2042_clk_init_clk_data(
  1258		struct device_node *node,
  1259		int num_clks,
  1260		struct sg2042_clk_data **pp_clk_data)
  1261	{
  1262		int ret = 0;
  1263		struct sg2042_clk_data *clk_data = NULL;
  1264		struct device_node *np_syscon;
  1265	
  1266		np_syscon = of_parse_phandle(node, "sophgo,system-ctrl", 0);
  1267		if (!np_syscon) {
  1268			pr_err("failed to get system-ctrl node\n");
  1269			ret = -EINVAL;
  1270			goto error_out;
  1271		}
  1272	
> 1273		clk_data = kzalloc(struct_size(clk_data, onecell_data.hws, num_clks), GFP_KERNEL);
  1274		if (!clk_data) {
  1275			ret = -ENOMEM;
  1276			goto error_out;
  1277		}
  1278	
  1279		clk_data->regmap_syscon = device_node_to_regmap(np_syscon);
  1280		if (IS_ERR_OR_NULL(clk_data->regmap_syscon)) {
  1281			pr_err("cannot get regmap_syscon %ld\n", PTR_ERR(clk_data->regmap_syscon));
  1282			ret = -ENODEV;
  1283			goto cleanup;
  1284		}
  1285		clk_data->iobase_syscon = of_iomap(np_syscon, 0);
  1286		clk_data->iobase = of_iomap(node, 0);
  1287		clk_data->onecell_data.num = num_clks;
  1288	
  1289		*pp_clk_data = clk_data;
  1290		return ret;
  1291	
  1292	cleanup:
> 1293		kfree(clk_data);
  1294	
  1295	error_out:
  1296		return ret;
  1297	}
  1298	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
