Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1827F74CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345608AbjKXNUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345324AbjKXNUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:20:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950BC1724;
        Fri, 24 Nov 2023 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700832038; x=1732368038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D6sAom7DCqR1Zyqj6Jdy6bkLwVXib4NKjEjRLqF2SOc=;
  b=cwW0+E/b/CDSWn2YxcZ3+w3t7cHB9ibez/ry/tuKUxu7XlhCItoK4XAR
   tQDTwhLJ4fpGa/4dFa1HB+dUyN3/rL8BV3INhkSHcJr4BWDOfyJZj+WgD
   blQQ+aArXDRzly3mV7rJWR8PS0WP8mAj1yp3rj3/F1BUiY8gKvNthMvj/
   VSK9DKB2HOrcKIgVAbUTqn7RTg/H7W8eZkAO5Qb6w5m4z4aLYXl0wLXn8
   KFBitvC1BCgwCl0CQFhxKxZXDU1ff7WWjR0PMWGKke9lFGNEasihhch+y
   bh9LFXYzD3G6HUaemaeevlBPV0gxmwLyiIoi6c6t7XooGm3cwaNxtrd1P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456765084"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="456765084"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 05:20:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767477050"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="767477050"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Nov 2023 05:20:09 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6W6J-0002ng-1e;
        Fri, 24 Nov 2023 13:20:07 +0000
Date:   Fri, 24 Nov 2023 21:19:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: Re: [PATCH v2 7/9] clk: qcom: add NSS clock Controller driver for
 Qualcomm IPQ5332
Message-ID: <202311241420.9uiff44i-lkp@intel.com>
References: <20231121-ipq5332-nsscc-v2-7-a7ff61beab72@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-ipq5332-nsscc-v2-7-a7ff61beab72@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kathiravan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 07b677953b9dca02928be323e2db853511305fa9]

url:    https://github.com/intel-lab-lkp/linux/commits/Kathiravan-Thirumoorthy/clk-qcom-ipq5332-add-const-qualifier-to-the-clk_init_data-structure/20231121-223615
base:   07b677953b9dca02928be323e2db853511305fa9
patch link:    https://lore.kernel.org/r/20231121-ipq5332-nsscc-v2-7-a7ff61beab72%40quicinc.com
patch subject: [PATCH v2 7/9] clk: qcom: add NSS clock Controller driver for Qualcomm IPQ5332
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20231124/202311241420.9uiff44i-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241420.9uiff44i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241420.9uiff44i-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/qcom/nsscc-ipq5332.c:161:62: error: array has incomplete element type 'const struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_25[] = {
                                                                ^
   drivers/clk/qcom/nsscc-ipq5332.c:161:21: note: forward declaration of 'struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_25[] = {
                       ^
>> drivers/clk/qcom/nsscc-ipq5332.c:162:2: error: call to undeclared function 'C'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           C(P_UNIPHY0_NSS_RX_CLK, 12.5, 0, 0),
           ^
   drivers/clk/qcom/nsscc-ipq5332.c:166:63: error: array has incomplete element type 'const struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_125[] = {
                                                                 ^
   drivers/clk/qcom/nsscc-ipq5332.c:161:21: note: forward declaration of 'struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_25[] = {
                       ^
>> drivers/clk/qcom/nsscc-ipq5332.c:171:64: error: array has incomplete element type 'const struct freq_multi_tbl'
   static const struct freq_multi_tbl ftbl_nss_cc_port1_rx_clk_src[] = {
                                                                  ^
   drivers/clk/qcom/nsscc-ipq5332.c:171:21: note: forward declaration of 'struct freq_multi_tbl'
   static const struct freq_multi_tbl ftbl_nss_cc_port1_rx_clk_src[] = {
                       ^
>> drivers/clk/qcom/nsscc-ipq5332.c:172:2: error: call to undeclared function 'FMS'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           FMS(24000000, P_XO, 1, 0, 0),
           ^
>> drivers/clk/qcom/nsscc-ipq5332.c:173:2: error: call to undeclared function 'FM'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           FM(25000000, ftbl_nss_cc_port1_rx_clk_src_25),
           ^
>> drivers/clk/qcom/nsscc-ipq5332.c:191:11: error: use of undeclared identifier 'clk_rcg2_fm_ops'; did you mean 'clk_rcg2_ops'?
                   .ops = &clk_rcg2_fm_ops,
                           ^~~~~~~~~~~~~~~
                           clk_rcg2_ops
   drivers/clk/qcom/clk-rcg.h:170:29: note: 'clk_rcg2_ops' declared here
   extern const struct clk_ops clk_rcg2_ops;
                               ^
   drivers/clk/qcom/nsscc-ipq5332.c:195:62: error: array has incomplete element type 'const struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port1_tx_clk_src_25[] = {
                                                                ^
   drivers/clk/qcom/nsscc-ipq5332.c:161:21: note: forward declaration of 'struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_25[] = {
                       ^
   drivers/clk/qcom/nsscc-ipq5332.c:200:63: error: array has incomplete element type 'const struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port1_tx_clk_src_125[] = {
                                                                 ^
   drivers/clk/qcom/nsscc-ipq5332.c:161:21: note: forward declaration of 'struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_25[] = {
                       ^
   drivers/clk/qcom/nsscc-ipq5332.c:205:64: error: array has incomplete element type 'const struct freq_multi_tbl'
   static const struct freq_multi_tbl ftbl_nss_cc_port1_tx_clk_src[] = {
                                                                  ^
   drivers/clk/qcom/nsscc-ipq5332.c:171:21: note: forward declaration of 'struct freq_multi_tbl'
   static const struct freq_multi_tbl ftbl_nss_cc_port1_rx_clk_src[] = {
                       ^
   drivers/clk/qcom/nsscc-ipq5332.c:225:11: error: use of undeclared identifier 'clk_rcg2_fm_ops'; did you mean 'clk_rcg2_ops'?
                   .ops = &clk_rcg2_fm_ops,
                           ^~~~~~~~~~~~~~~
                           clk_rcg2_ops
   drivers/clk/qcom/clk-rcg.h:170:29: note: 'clk_rcg2_ops' declared here
   extern const struct clk_ops clk_rcg2_ops;
                               ^
   drivers/clk/qcom/nsscc-ipq5332.c:229:62: error: array has incomplete element type 'const struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port2_rx_clk_src_25[] = {
                                                                ^
   drivers/clk/qcom/nsscc-ipq5332.c:161:21: note: forward declaration of 'struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_25[] = {
                       ^
   drivers/clk/qcom/nsscc-ipq5332.c:234:63: error: array has incomplete element type 'const struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port2_rx_clk_src_125[] = {
                                                                 ^
   drivers/clk/qcom/nsscc-ipq5332.c:161:21: note: forward declaration of 'struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_25[] = {
                       ^
   drivers/clk/qcom/nsscc-ipq5332.c:239:64: error: array has incomplete element type 'const struct freq_multi_tbl'
   static const struct freq_multi_tbl ftbl_nss_cc_port2_rx_clk_src[] = {
                                                                  ^
   drivers/clk/qcom/nsscc-ipq5332.c:171:21: note: forward declaration of 'struct freq_multi_tbl'
   static const struct freq_multi_tbl ftbl_nss_cc_port1_rx_clk_src[] = {
                       ^
   drivers/clk/qcom/nsscc-ipq5332.c:259:11: error: use of undeclared identifier 'clk_rcg2_fm_ops'; did you mean 'clk_rcg2_ops'?
                   .ops = &clk_rcg2_fm_ops,
                           ^~~~~~~~~~~~~~~
                           clk_rcg2_ops
   drivers/clk/qcom/clk-rcg.h:170:29: note: 'clk_rcg2_ops' declared here
   extern const struct clk_ops clk_rcg2_ops;
                               ^
   drivers/clk/qcom/nsscc-ipq5332.c:263:62: error: array has incomplete element type 'const struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port2_tx_clk_src_25[] = {
                                                                ^
   drivers/clk/qcom/nsscc-ipq5332.c:161:21: note: forward declaration of 'struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_25[] = {
                       ^
   drivers/clk/qcom/nsscc-ipq5332.c:268:63: error: array has incomplete element type 'const struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port2_tx_clk_src_125[] = {
                                                                 ^
   drivers/clk/qcom/nsscc-ipq5332.c:161:21: note: forward declaration of 'struct freq_conf'
   static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_25[] = {
                       ^
   drivers/clk/qcom/nsscc-ipq5332.c:273:64: error: array has incomplete element type 'const struct freq_multi_tbl'
   static const struct freq_multi_tbl ftbl_nss_cc_port2_tx_clk_src[] = {
                                                                  ^
   drivers/clk/qcom/nsscc-ipq5332.c:171:21: note: forward declaration of 'struct freq_multi_tbl'
   static const struct freq_multi_tbl ftbl_nss_cc_port1_rx_clk_src[] = {
                       ^
   drivers/clk/qcom/nsscc-ipq5332.c:293:11: error: use of undeclared identifier 'clk_rcg2_fm_ops'; did you mean 'clk_rcg2_ops'?
                   .ops = &clk_rcg2_fm_ops,
                           ^~~~~~~~~~~~~~~
                           clk_rcg2_ops
   drivers/clk/qcom/clk-rcg.h:170:29: note: 'clk_rcg2_ops' declared here
   extern const struct clk_ops clk_rcg2_ops;
                               ^
   19 errors generated.


vim +161 drivers/clk/qcom/nsscc-ipq5332.c

   160	
 > 161	static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_25[] = {
 > 162		C(P_UNIPHY0_NSS_RX_CLK, 12.5, 0, 0),
   163		C(P_UNIPHY0_NSS_RX_CLK, 5, 0, 0),
   164	};
   165	
   166	static const struct freq_conf ftbl_nss_cc_port1_rx_clk_src_125[] = {
   167		C(P_UNIPHY0_NSS_RX_CLK, 2.5, 0, 0),
   168		C(P_UNIPHY0_NSS_RX_CLK, 1, 0, 0),
   169	};
   170	
 > 171	static const struct freq_multi_tbl ftbl_nss_cc_port1_rx_clk_src[] = {
 > 172		FMS(24000000, P_XO, 1, 0, 0),
 > 173		FM(25000000, ftbl_nss_cc_port1_rx_clk_src_25),
   174		FMS(78125000, P_UNIPHY0_NSS_RX_CLK, 4, 0, 0),
   175		FM(125000000, ftbl_nss_cc_port1_rx_clk_src_125),
   176		FMS(156250000, P_UNIPHY0_NSS_RX_CLK, 2, 0, 0),
   177		FMS(312500000, P_UNIPHY0_NSS_RX_CLK, 1, 0, 0),
   178		{ }
   179	};
   180	
   181	static struct clk_rcg2 nss_cc_port1_rx_clk_src = {
   182		.cmd_rcgr = 0x450,
   183		.mnd_width = 0,
   184		.hid_width = 5,
   185		.parent_map = nss_cc_parent_map_1,
   186		.freq_multi_tbl = ftbl_nss_cc_port1_rx_clk_src,
   187		.clkr.hw.init = &(const struct clk_init_data) {
   188			.name = "nss_cc_port1_rx_clk_src",
   189			.parent_data = nss_cc_parent_data_1,
   190			.num_parents = ARRAY_SIZE(nss_cc_parent_data_1),
 > 191			.ops = &clk_rcg2_fm_ops,
   192		},
   193	};
   194	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
