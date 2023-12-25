Return-Path: <linux-kernel+bounces-11178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD681E28F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 23:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EEE1F21B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 22:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF8353E2B;
	Mon, 25 Dec 2023 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmbUL/Oa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610E553E23
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703542809; x=1735078809;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sIIlrh2fCtHoNyDW0ONZAjJ/8f7/sd/eRf5K65yxIcw=;
  b=WmbUL/OaDMeN3vU2ehy8Z5b6F9fFSxOTXIyZ3XlQfYervSCdKri6ZQp1
   kOcWoLbE4xa4nslxK3XUyBYy+Z4H6eo2cLlNQ+ZtQ5yuohuWkp8GcHJiA
   4ucs3wL/OnyqzgtoT4pO2zqWzf7c0QO2LSJCsoc0PjgHZtiwTKm955enx
   4tyvJd8qPJ72Y6Br2n0V9ZMfbAV0RmUNXZGbu1FSthYUDEaTiY6KlIdKF
   tKmpLldCWxczybQTMotDqPvejo8pLZ+fIr1vOVvTsXFiR7gnlQb2NeLHQ
   MOig+XfLVWjADDUpl+Q3gV81Vlurbb2Qf69hu89exrNJvweHLdEzjy9hE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="399090965"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="399090965"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 14:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="1109224724"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="1109224724"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 25 Dec 2023 14:20:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHtIo-000Dib-2o;
	Mon, 25 Dec 2023 22:20:02 +0000
Date: Tue, 26 Dec 2023 06:19:38 +0800
From: kernel test robot <lkp@intel.com>
To: Can Guo <quic_cang@quicinc.com>, bvanassche@acm.org, mani@kernel.org,
	vkoul@kernel.org, abel.vesa@linaro.org, dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/2] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed
 Gear 5 support for SM8550
Message-ID: <202312260623.FFykk4qF-lkp@intel.com>
References: <1703472701-34197-3-git-send-email-quic_cang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1703472701-34197-3-git-send-email-quic_cang@quicinc.com>

Hi Can,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc7]
[cannot apply to next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Can-Guo/phy-qualcomm-phy-qcom-qmp-ufs-Add-High-Speed-Gear-5-support-for-SM8550/20231225-154853
base:   linus/master
patch link:    https://lore.kernel.org/r/1703472701-34197-3-git-send-email-quic_cang%40quicinc.com
patch subject: [PATCH v9 2/2] phy: qualcomm: phy-qcom-qmp-ufs: Add High Speed Gear 5 support for SM8550
config: arc-randconfig-001-20231225 (https://download.01.org/0day-ci/archive/20231226/202312260623.FFykk4qF-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312260623.FFykk4qF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312260623.FFykk4qF-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1071:10: error: 'const struct qmp_phy_cfg' has no member named 'tbls_hs_g4'; did you mean 'tbls_hs_b'?
    1071 |         .tbls_hs_g4 = {
         |          ^~~~~~~~~~
         |          tbls_hs_b
>> drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1072:17: error: field name not in record or union initializer
    1072 |                 .tx             = sm8250_ufsphy_hs_g4_tx,
         |                 ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1072:17: note: (near initialization for 'sc7280_ufsphy_cfg.tbls_hs_overlay')
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1073:17: error: field name not in record or union initializer
    1073 |                 .tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
         |                 ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1073:17: note: (near initialization for 'sc7280_ufsphy_cfg.tbls_hs_overlay')
   In file included from include/linux/kernel.h:16,
                    from include/linux/clk.h:13,
                    from drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:6:
>> include/linux/array_size.h:11:25: warning: initialization of 'const struct qmp_phy_init_tbl *' from 'unsigned int' makes pointer from integer without a cast [-Wint-conversion]
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1073:35: note: in expansion of macro 'ARRAY_SIZE'
    1073 |                 .tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
         |                                   ^~~~~~~~~~
   include/linux/array_size.h:11:25: note: (near initialization for 'sc7280_ufsphy_cfg.tbls_hs_overlay[1].serdes')
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1073:35: note: in expansion of macro 'ARRAY_SIZE'
    1073 |                 .tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
         |                                   ^~~~~~~~~~
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1074:17: error: field name not in record or union initializer
    1074 |                 .rx             = sc7280_ufsphy_hs_g4_rx,
         |                 ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1074:17: note: (near initialization for 'sc7280_ufsphy_cfg.tbls_hs_overlay')
>> drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1075:17: warning: excess elements in array initializer
    1075 |                 .rx_num         = ARRAY_SIZE(sc7280_ufsphy_hs_g4_rx),
         |                 ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1075:17: note: (near initialization for 'sc7280_ufsphy_cfg.tbls_hs_overlay')
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1075:17: error: field name not in record or union initializer
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1075:17: note: (near initialization for 'sc7280_ufsphy_cfg.tbls_hs_overlay')
>> include/linux/array_size.h:11:25: warning: initialization of 'const struct qmp_phy_init_tbl *' from 'unsigned int' makes pointer from integer without a cast [-Wint-conversion]
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1075:35: note: in expansion of macro 'ARRAY_SIZE'
    1075 |                 .rx_num         = ARRAY_SIZE(sc7280_ufsphy_hs_g4_rx),
         |                                   ^~~~~~~~~~
   include/linux/array_size.h:11:25: note: (near initialization for 'sc7280_ufsphy_cfg.tbls_hs_overlay[2].serdes')
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1075:35: note: in expansion of macro 'ARRAY_SIZE'
    1075 |                 .rx_num         = ARRAY_SIZE(sc7280_ufsphy_hs_g4_rx),
         |                                   ^~~~~~~~~~
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1076:17: warning: excess elements in array initializer
    1076 |                 .pcs            = sm8150_ufsphy_hs_g4_pcs,
         |                 ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1076:17: note: (near initialization for 'sc7280_ufsphy_cfg.tbls_hs_overlay')
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1076:17: error: field name not in record or union initializer
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1076:17: note: (near initialization for 'sc7280_ufsphy_cfg.tbls_hs_overlay')
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1077:17: warning: excess elements in array initializer
    1077 |                 .pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
         |                 ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1077:17: note: (near initialization for 'sc7280_ufsphy_cfg.tbls_hs_overlay')
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1077:17: error: field name not in record or union initializer
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1077:17: note: (near initialization for 'sc7280_ufsphy_cfg.tbls_hs_overlay')
>> include/linux/array_size.h:11:25: warning: initialization of 'const struct qmp_phy_init_tbl *' from 'unsigned int' makes pointer from integer without a cast [-Wint-conversion]
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1077:35: note: in expansion of macro 'ARRAY_SIZE'
    1077 |                 .pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
         |                                   ^~~~~~~~~~
   include/linux/array_size.h:11:25: note: (near initialization for 'sc7280_ufsphy_cfg.tbls_hs_overlay[2].serdes')
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                         ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1077:35: note: in expansion of macro 'ARRAY_SIZE'
    1077 |                 .pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
         |                                   ^~~~~~~~~~
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1078:9: warning: excess elements in array initializer
    1078 |         },
         |         ^
   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1078:9: note: (near initialization for 'sc7280_ufsphy_cfg.tbls_hs_overlay')
>> drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1052:53: warning: missing braces around initializer [-Wmissing-braces]
    1052 | static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
         |                                                     ^
>> drivers/phy/qualcomm/phy-qcom-qmp-ufs.c:1052:53: warning: missing braces around initializer [-Wmissing-braces]


vim +1071 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c

607c101fe9f2f6 Bartosz Golaszewski 2023-04-11  1051  
8abe9792d1ff7e Nitin Rawat         2023-09-19 @1052  static const struct qmp_phy_cfg sc7280_ufsphy_cfg = {
8abe9792d1ff7e Nitin Rawat         2023-09-19  1053  	.lanes                  = 2,
8abe9792d1ff7e Nitin Rawat         2023-09-19  1054  
8abe9792d1ff7e Nitin Rawat         2023-09-19  1055  	.offsets                = &qmp_ufs_offsets,
8abe9792d1ff7e Nitin Rawat         2023-09-19  1056  
8abe9792d1ff7e Nitin Rawat         2023-09-19  1057  	.tbls = {
8abe9792d1ff7e Nitin Rawat         2023-09-19  1058  		.serdes         = sm8150_ufsphy_serdes,
8abe9792d1ff7e Nitin Rawat         2023-09-19  1059  		.serdes_num     = ARRAY_SIZE(sm8150_ufsphy_serdes),
8abe9792d1ff7e Nitin Rawat         2023-09-19  1060  		.tx             = sc7280_ufsphy_tx,
8abe9792d1ff7e Nitin Rawat         2023-09-19  1061  		.tx_num         = ARRAY_SIZE(sc7280_ufsphy_tx),
8abe9792d1ff7e Nitin Rawat         2023-09-19  1062  		.rx             = sc7280_ufsphy_rx,
8abe9792d1ff7e Nitin Rawat         2023-09-19  1063  		.rx_num         = ARRAY_SIZE(sc7280_ufsphy_rx),
8abe9792d1ff7e Nitin Rawat         2023-09-19  1064  		.pcs            = sc7280_ufsphy_pcs,
8abe9792d1ff7e Nitin Rawat         2023-09-19  1065  		.pcs_num        = ARRAY_SIZE(sc7280_ufsphy_pcs),
8abe9792d1ff7e Nitin Rawat         2023-09-19  1066  	},
8abe9792d1ff7e Nitin Rawat         2023-09-19  1067  	.tbls_hs_b = {
8abe9792d1ff7e Nitin Rawat         2023-09-19  1068  		.serdes         = sm8150_ufsphy_hs_b_serdes,
8abe9792d1ff7e Nitin Rawat         2023-09-19  1069  		.serdes_num     = ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
8abe9792d1ff7e Nitin Rawat         2023-09-19  1070  	},
8abe9792d1ff7e Nitin Rawat         2023-09-19 @1071  	.tbls_hs_g4 = {
8abe9792d1ff7e Nitin Rawat         2023-09-19 @1072  		.tx             = sm8250_ufsphy_hs_g4_tx,
8abe9792d1ff7e Nitin Rawat         2023-09-19 @1073  		.tx_num         = ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
8abe9792d1ff7e Nitin Rawat         2023-09-19  1074  		.rx             = sc7280_ufsphy_hs_g4_rx,
8abe9792d1ff7e Nitin Rawat         2023-09-19 @1075  		.rx_num         = ARRAY_SIZE(sc7280_ufsphy_hs_g4_rx),
8abe9792d1ff7e Nitin Rawat         2023-09-19  1076  		.pcs            = sm8150_ufsphy_hs_g4_pcs,
8abe9792d1ff7e Nitin Rawat         2023-09-19 @1077  		.pcs_num        = ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
8abe9792d1ff7e Nitin Rawat         2023-09-19  1078  	},
8abe9792d1ff7e Nitin Rawat         2023-09-19  1079  	.clk_list               = sm8450_ufs_phy_clk_l,
8abe9792d1ff7e Nitin Rawat         2023-09-19  1080  	.num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
8abe9792d1ff7e Nitin Rawat         2023-09-19  1081  	.vreg_list              = qmp_phy_vreg_l,
8abe9792d1ff7e Nitin Rawat         2023-09-19  1082  	.num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
8abe9792d1ff7e Nitin Rawat         2023-09-19  1083  	.regs                   = ufsphy_v4_regs_layout,
8abe9792d1ff7e Nitin Rawat         2023-09-19  1084  };
8abe9792d1ff7e Nitin Rawat         2023-09-19  1085  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

