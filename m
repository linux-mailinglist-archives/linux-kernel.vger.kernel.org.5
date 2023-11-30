Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062387FEDFC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbjK3LdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345242AbjK3Lcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:32:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AEA1BD1;
        Thu, 30 Nov 2023 03:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701343936; x=1732879936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UO+bXR6o+6cAWqwvpcVd9uh3omCgQJUjpZg+pITqvvY=;
  b=AdaDDN4kdArYpHXkwoeKPdPgnw3yMjPlbv9VQoBTcWI4C39KrYSM5Rhw
   VZrsw6vt+HJOu77ki/niWdoDx3/IJFgolHxGsou849tlrtw/dGWTjUWTy
   28MqmQUw9vcvFSsCtN575YnxjlgwI+8atiCv74tiwScjBaHZToAh2cFEJ
   Czg2svngpA7I3CwI7mjZl/4zZ7+6elLoppo+NhTsT6aB7fnUkWPxEKYul
   E+JsZeoFL7TvfxcM2g4mMz2Ym0Rq6L555vm/axy9tFnR5eZfi/oc804pk
   uXi0L9ld8QuO4zTwgEG+eWmg197FwEBhbbeABdgcHabhZB2La6cJXk2Yg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="190765"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="190765"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 03:31:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="769274010"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="769274010"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Nov 2023 03:31:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8fGq-0001nW-1m;
        Thu, 30 Nov 2023 11:31:52 +0000
Date:   Thu, 30 Nov 2023 19:31:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        Tengfei Fan <quic_tengfan@quicinc.com>
Subject: Re: [PATCH v5 2/4] pinctrl: qcom: Add SM4450 pinctrl driver
Message-ID: <202311301909.pcIvnNks-lkp@intel.com>
References: <20231130024046.25938-3-quic_tengfan@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130024046.25938-3-quic_tengfan@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tengfei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next linus/master v6.7-rc3 next-20231130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tengfei-Fan/pinctrl-qcom-Add-SM4450-pinctrl-driver/20231130-114914
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20231130024046.25938-3-quic_tengfan%40quicinc.com
patch subject: [PATCH v5 2/4] pinctrl: qcom: Add SM4450 pinctrl driver
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231130/202311301909.pcIvnNks-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311301909.pcIvnNks-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311301909.pcIvnNks-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/qcom/pinctrl-sm4450.c:618:31: warning: suspicious concatenation of string literals in an array initialization; did you mean to separate the elements with a comma? [-Wstring-concatenation]
           "gpio44", "gpio45", "gpio46" "gpio47", "gpio49",  "gpio59", "gpio62", "gpio118",
                                        ^
                                       ,
   drivers/pinctrl/qcom/pinctrl-sm4450.c:618:22: note: place parentheses around the string literal to silence warning
           "gpio44", "gpio45", "gpio46" "gpio47", "gpio49",  "gpio59", "gpio62", "gpio118",
                               ^
   drivers/pinctrl/qcom/pinctrl-sm4450.c:996:12: error: incompatible function pointer types initializing 'int (*)(struct platform_device *)' with an expression of type 'void (struct platform_device *)' [-Wincompatible-function-pointer-types]
           .remove = msm_pinctrl_remove,
                     ^~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +618 drivers/pinctrl/qcom/pinctrl-sm4450.c

   480	
   481	static const char * const gpio_groups[] = {
   482		"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
   483		"gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
   484		"gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
   485		"gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
   486		"gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
   487		"gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41", "gpio42",
   488		"gpio43", "gpio44", "gpio45", "gpio46", "gpio47", "gpio48", "gpio49",
   489		"gpio50", "gpio51", "gpio52", "gpio53", "gpio54", "gpio55", "gpio56",
   490		"gpio57", "gpio58", "gpio59", "gpio60", "gpio61", "gpio62", "gpio63",
   491		"gpio64", "gpio65", "gpio66", "gpio67", "gpio68", "gpio69", "gpio70",
   492		"gpio71", "gpio72", "gpio73", "gpio74", "gpio75", "gpio76", "gpio77",
   493		"gpio78", "gpio79", "gpio80", "gpio81", "gpio82", "gpio83", "gpio84",
   494		"gpio85", "gpio86", "gpio87", "gpio88", "gpio89", "gpio90", "gpio91",
   495		"gpio92", "gpio93", "gpio94", "gpio95", "gpio96", "gpio97", "gpio98",
   496		"gpio99", "gpio100", "gpio101", "gpio102", "gpio103", "gpio104",
   497		"gpio105", "gpio106", "gpio107", "gpio108", "gpio109", "gpio110",
   498		"gpio111", "gpio112", "gpio113", "gpio114", "gpio115", "gpio116",
   499		"gpio117", "gpio118", "gpio119", "gpio120", "gpio121", "gpio122",
   500		"gpio123", "gpio124", "gpio125", "gpio126", "gpio127", "gpio128",
   501		"gpio129", "gpio130", "gpio131", "gpio132", "gpio133", "gpio134",
   502		"gpio135",
   503	};
   504	static const char * const atest_char_groups[] = {
   505		"gpio95", "gpio97", "gpio98", "gpio99", "gpio100",
   506	};
   507	static const char * const atest_usb0_groups[] = {
   508		"gpio75", "gpio10", "gpio78", "gpio79", "gpio80",
   509	};
   510	static const char * const audio_ref_clk_groups[] = {
   511		"gpio71",
   512	};
   513	static const char * const cam_mclk_groups[] = {
   514		"gpio36", "gpio37", "gpio38", "gpio39",
   515	};
   516	static const char * const cci_async_in0_groups[] = {
   517		"gpio40",
   518	};
   519	static const char * const cci_i2c_groups[] = {
   520		"gpio45", "gpio47", "gpio49", "gpio44",
   521		"gpio46", "gpio48",
   522	};
   523	static const char * const cci_groups[] = {
   524		"gpio40", "gpio41", "gpio42", "gpio43",
   525	};
   526	static const char * const cmu_rng_groups[] = {
   527		"gpio28", "gpio3", "gpio1", "gpio0",
   528	};
   529	static const char * const coex_uart1_rx_groups[] = {
   530		"gpio54",
   531	};
   532	static const char * const coex_uart1_tx_groups[] = {
   533		"gpio55",
   534	};
   535	static const char * const cri_trng_groups[] = {
   536		"gpio42", "gpio40", "gpio41",
   537	};
   538	static const char * const dbg_out_clk_groups[] = {
   539		"gpio80",
   540	};
   541	static const char * const ddr_bist_groups[] = {
   542		"gpio32", "gpio29", "gpio30", "gpio31",
   543	};
   544	static const char * const ddr_pxi0_test_groups[] = {
   545		"gpio90", "gpio127",
   546	};
   547	static const char * const ddr_pxi1_test_groups[] = {
   548		"gpio118", "gpio122",
   549	};
   550	static const char * const gcc_gp1_clk_groups[] = {
   551		"gpio37", "gpio48",
   552	};
   553	static const char * const gcc_gp2_clk_groups[] = {
   554		"gpio30", "gpio49",
   555	};
   556	static const char * const gcc_gp3_clk_groups[] = {
   557		"gpio3", "gpio50",
   558	};
   559	static const char * const host2wlan_sol_groups[] = {
   560		"gpio106",
   561	};
   562	static const char * const ibi_i3c_qup0_groups[] = {
   563		"gpio4", "gpio5",
   564	};
   565	static const char * const ibi_i3c_qup1_groups[] = {
   566		"gpio0", "gpio1",
   567	};
   568	static const char * const jitter_bist_ref_groups[] = {
   569		"gpio90",
   570	};
   571	static const char * const mdp_vsync0_out_groups[] = {
   572		"gpio93",
   573	};
   574	static const char * const mdp_vsync1_out_groups[] = {
   575		"gpio93",
   576	};
   577	static const char * const mdp_vsync2_out_groups[] = {
   578		"gpio22",
   579	};
   580	static const char * const mdp_vsync3_out_groups[] = {
   581		"gpio22",
   582	};
   583	static const char * const mdp_vsync_groups[] = {
   584		"gpio26", "gpio22", "gpio30", "gpio34", "gpio93", "gpio97",
   585	};
   586	static const char * const nav_groups[] = {
   587		"gpio81", "gpio83", "gpio84",
   588	};
   589	static const char * const pcie0_clk_req_groups[] = {
   590		"gpio107",
   591	};
   592	static const char * const phase_flag_groups[] = {
   593		"gpio7", "gpio8", "gpio9", "gpio11", "gpio13", "gpio14", "gpio15",
   594		"gpio17", "gpio18", "gpio19", "gpio21", "gpio24", "gpio25", "gpio31",
   595		"gpio32", "gpio33", "gpio35", "gpio61", "gpio72", "gpio82", "gpio91",
   596		"gpio95", "gpio97", "gpio98", "gpio99", "gpio100", "gpio105", "gpio115",
   597		"gpio116", "gpio117", "gpio133", "gpio135",
   598	};
   599	static const char * const pll_bist_sync_groups[] = {
   600		"gpio73",
   601	};
   602	static const char * const pll_clk_aux_groups[] = {
   603		"gpio108",
   604	};
   605	static const char * const prng_rosc_groups[] = {
   606		"gpio36", "gpio37", "gpio38", "gpio39",
   607	};
   608	static const char * const qdss_cti_trig0_groups[] = {
   609		"gpio26", "gpio60", "gpio113", "gpio114",
   610	};
   611	static const char * const qdss_cti_trig1_groups[] = {
   612		"gpio6", "gpio27", "gpio57", "gpio58",
   613	};
   614	static const char * const qdss_gpio_groups[] = {
   615		"gpio0", "gpio1", "gpio3", "gpio4", "gpio5", "gpio7", "gpio8", "gpio9",
   616		"gpio14", "gpio15", "gpio17", "gpio23", "gpio31", "gpio32", "gpio33", "gpio35",
   617		"gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41", "gpio42", "gpio43",
 > 618		"gpio44", "gpio45", "gpio46" "gpio47", "gpio49",  "gpio59", "gpio62", "gpio118",
   619		"gpio121", "gpio122", "gpio126", "gpio127",
   620	};
   621	static const char * const qlink0_enable_groups[] = {
   622		"gpio88",
   623	};
   624	static const char * const qlink0_request_groups[] = {
   625		"gpio87",
   626	};
   627	static const char * const qlink0_wmss_reset_groups[] = {
   628		"gpio89",
   629	};
   630	static const char * const qup0_se0_groups[] = {
   631		"gpio4", "gpio5", "gpio34", "gpio35",
   632	};
   633	static const char * const qup0_se1_groups[] = {
   634		"gpio10", "gpio11", "gpio12", "gpio13",
   635	};
   636	static const char * const qup0_se2_groups[] = {
   637		"gpio14", "gpio15", "gpio16", "gpio17",
   638	};
   639	static const char * const qup0_se3_groups[] = {
   640		"gpio18", "gpio19", "gpio20", "gpio21",
   641	};
   642	static const char * const qup0_se4_groups[] = {
   643		"gpio6", "gpio7", "gpio8", "gpio9",
   644		"gpio26", "gpio27", "gpio34",
   645	};
   646	static const char * const qup1_se0_groups[] = {
   647		"gpio0", "gpio1", "gpio2", "gpio3",
   648	};
   649	static const char * const qup1_se1_groups[] = {
   650		"gpio26", "gpio27", "gpio50", "gpio51",
   651	};
   652	static const char * const qup1_se2_groups[] = {
   653		"gpio22", "gpio23", "gpio31", "gpio32",
   654	};
   655	static const char * const qup1_se3_groups[] = {
   656		"gpio24", "gpio25", "gpio51", "gpio50",
   657	};
   658	static const char * const qup1_se4_groups[] = {
   659		"gpio43", "gpio48", "gpio49", "gpio90",
   660		"gpio91",
   661	};
   662	static const char * const sd_write_protect_groups[] = {
   663		"gpio102",
   664	};
   665	static const char * const tb_trig_sdc1_groups[] = {
   666		"gpio128",
   667	};
   668	static const char * const tb_trig_sdc2_groups[] = {
   669		"gpio51",
   670	};
   671	static const char * const tgu_ch0_trigout_groups[] = {
   672		"gpio20",
   673	};
   674	static const char * const tgu_ch1_trigout_groups[] = {
   675		"gpio21",
   676	};
   677	static const char * const tgu_ch2_trigout_groups[] = {
   678		"gpio22",
   679	};
   680	static const char * const tgu_ch3_trigout_groups[] = {
   681		"gpio23",
   682	};
   683	static const char * const tmess_prng_groups[] = {
   684		"gpio57", "gpio58", "gpio59", "gpio60",
   685	};
   686	static const char * const tsense_pwm1_out_groups[] = {
   687		"gpio134",
   688	};
   689	static const char * const tsense_pwm2_out_groups[] = {
   690		"gpio134",
   691	};
   692	static const char * const uim0_groups[] = {
   693		"gpio64", "gpio63", "gpio66", "gpio65",
   694	};
   695	static const char * const uim1_groups[] = {
   696		"gpio68", "gpio67", "gpio69", "gpio70",
   697	};
   698	static const char * const usb0_hs_ac_groups[] = {
   699		"gpio99",
   700	};
   701	static const char * const usb0_phy_ps_groups[] = {
   702		"gpio94",
   703	};
   704	static const char * const vfr_0_mira_groups[] = {
   705		"gpio19",
   706	};
   707	static const char * const vfr_0_mirb_groups[] = {
   708		"gpio100",
   709	};
   710	static const char * const vfr_1_groups[] = {
   711		"gpio84",
   712	};
   713	static const char * const vsense_trigger_mirnat_groups[] = {
   714		"gpio75",
   715	};
   716	static const char * const wlan1_adc_dtest0_groups[] = {
   717		"gpio79",
   718	};
   719	static const char * const wlan1_adc_dtest1_groups[] = {
   720		"gpio80",
   721	};
   722	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
