Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D06F791D77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbjIDTGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjIDTGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:06:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F259E189;
        Mon,  4 Sep 2023 12:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693854410; x=1725390410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l+XLthKvLTYO2kZ9gcQFiN/7HFLhZKfoZBbtr2zk/0M=;
  b=TqHHXiqwMBRuaHcHSO/tKo5YXo81tz/gOTJ/+L2SYwEUWPQvCQhUrpzU
   exbSYbA3ZR7bqefKPSxX2baMPfdfP/gciF32fyFw6KytOSuHD4aWJDQUS
   5ZubQZw8hWlE9fv9on+6aS3Zj1+agKb8/YEeKJQa7EyqwgV3pTgXKZQSt
   +6xR1BgG+z48RD8+zv4C5M5NxAj6o9qVFc0uUMbNyLmp3LeNJSgOD+ux8
   2+TJHmDjHRlM+UprLHyVernOhfmCm/9xk2DdLemCCvj+qBj17DnLRoKoQ
   +Bzc/FAskjKD15JcrWjD+MZ88T0NPVipFyTjP0aa+TXPWe9iaGemXdN0E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="380445823"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="380445823"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 12:06:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="734390253"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="734390253"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Sep 2023 12:06:45 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdEuJ-0000ln-0f;
        Mon, 04 Sep 2023 19:06:43 +0000
Date:   Tue, 5 Sep 2023 03:06:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, mani@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     oe-kbuild-all@lists.linux.dev, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>
Subject: Re: [PATCH V7 5/5] scsi: ufs: qcom: Configure SYS1CLK_1US_REG for
 UFS V4 and above
Message-ID: <202309050228.1pT7cmfS-lkp@intel.com>
References: <20230904152100.30404-6-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904152100.30404-6-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nitin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on jejb-scsi/for-next linus/master next-20230831]
[cannot apply to v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitin-Rawat/scsi-ufs-qcom-Update-MAX_CORE_CLK_1US_CYCLES-for-UFS-V4-and-above/20230904-232447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230904152100.30404-6-quic_nitirawa%40quicinc.com
patch subject: [PATCH V7 5/5] scsi: ufs: qcom: Configure SYS1CLK_1US_REG for UFS V4 and above
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230905/202309050228.1pT7cmfS-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230905/202309050228.1pT7cmfS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309050228.1pT7cmfS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ufs/host/ufs-qcom.c:543: warning: Function parameter or member 'gear' not described in 'ufs_qcom_cfg_timers'
>> drivers/ufs/host/ufs-qcom.c:543: warning: Function parameter or member 'update_link_startup_timer' not described in 'ufs_qcom_cfg_timers'


vim +543 drivers/ufs/host/ufs-qcom.c

81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  529  
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  530  /**
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  531   * ufs_qcom_cfg_timers - Configure ufs qcom cfg timers
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  532   *
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  533   * @hba: host controller instance
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  534   * @hs: current power mode
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  535   * @rate: current rate
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  536   * @update_link_startup_timer indicate if link_start in progress
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  537   * @is_pre_scale_up: flag to check if pre scale up condition.
3a17fefe0f1960 drivers/ufs/host/ufs-qcom.c Bart Van Assche       2023-07-27  538   * Return: zero for success and non-zero in case of a failure.
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  539   */
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  540  static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  541  			       u32 hs, u32 rate, bool update_link_startup_timer,
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  542  			       bool is_pre_scale_up)
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15 @543  {
1ce5898af55e23 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  544  	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  545  	struct ufs_clk_info *clki;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  546  	u32 core_clk_period_in_ns;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  547  	u32 tx_clk_cycles_per_us = 0;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  548  	unsigned long core_clk_rate = 0;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  549  	u32 core_clk_cycles_per_us = 0;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  550  
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  551  	static u32 pwm_fr_table[][2] = {
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  552  		{UFS_PWM_G1, 0x1},
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  553  		{UFS_PWM_G2, 0x1},
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  554  		{UFS_PWM_G3, 0x1},
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  555  		{UFS_PWM_G4, 0x1},
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  556  	};
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  557  
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  558  	static u32 hs_fr_table_rA[][2] = {
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  559  		{UFS_HS_G1, 0x1F},
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  560  		{UFS_HS_G2, 0x3e},
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  561  		{UFS_HS_G3, 0x7D},
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  562  	};
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  563  
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  564  	static u32 hs_fr_table_rB[][2] = {
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  565  		{UFS_HS_G1, 0x24},
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  566  		{UFS_HS_G2, 0x49},
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  567  		{UFS_HS_G3, 0x92},
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  568  	};
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  569  
81c7e06a5ffcca drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-05-17  570  	/*
81c7e06a5ffcca drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-05-17  571  	 * The Qunipro controller does not use following registers:
81c7e06a5ffcca drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-05-17  572  	 * SYS1CLK_1US_REG, TX_SYMBOL_CLK_1US_REG, CLK_NS_REG &
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  573  	 * UFS_REG_PA_LINK_STARTUP_TIMER.
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  574  	 * However UTP controller uses SYS1CLK_1US_REG register for Interrupt
81c7e06a5ffcca drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-05-17  575  	 * Aggregation logic.
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  576  	 * It is mandatory to write SYS1CLK_1US_REG register on UFS host
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  577  	 * controller V4.0.0 onwards.
81c7e06a5ffcca drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-05-17  578  	 */
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  579  	if (host->hw_ver.major < 4 && ufs_qcom_cap_qunipro(host) &&
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  580  	    !ufshcd_is_intr_aggr_allowed(hba))
031312dbc6950a drivers/ufs/host/ufs-qcom.c Manivannan Sadhasivam 2022-12-22  581  		return 0;
81c7e06a5ffcca drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-05-17  582  
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  583  	if (gear == 0) {
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  584  		dev_err(hba->dev, "%s: invalid gear = %d\n", __func__, gear);
031312dbc6950a drivers/ufs/host/ufs-qcom.c Manivannan Sadhasivam 2022-12-22  585  		return -EINVAL;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  586  	}
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  587  
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  588  	list_for_each_entry(clki, &hba->clk_list_head, list) {
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  589  		if (!strcmp(clki->name, "core_clk")) {
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  590  			if (is_pre_scale_up)
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  591  				core_clk_rate = clki->max_freq;
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  592  			else
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  593  				core_clk_rate = clk_get_rate(clki->clk);
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  594  			break;
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  595  		}
17e4fe29e61fb2 drivers/ufs/host/ufs-qcom.c Nitin Rawat           2023-09-04  596  
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  597  	}
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  598  
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  599  	/* If frequency is smaller than 1MHz, set to 1MHz */
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  600  	if (core_clk_rate < DEFAULT_CLK_RATE_HZ)
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  601  		core_clk_rate = DEFAULT_CLK_RATE_HZ;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  602  
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  603  	core_clk_cycles_per_us = core_clk_rate / USEC_PER_SEC;
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  604  	if (ufshcd_readl(hba, REG_UFS_SYS1CLK_1US) != core_clk_cycles_per_us) {
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  605  		ufshcd_writel(hba, core_clk_cycles_per_us, REG_UFS_SYS1CLK_1US);
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  606  		/*
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  607  		 * make sure above write gets applied before we return from
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  608  		 * this function.
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  609  		 */
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  610  		mb();
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  611  	}
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  612  
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  613  	if (ufs_qcom_cap_qunipro(host))
031312dbc6950a drivers/ufs/host/ufs-qcom.c Manivannan Sadhasivam 2022-12-22  614  		return 0;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  615  
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  616  	core_clk_period_in_ns = NSEC_PER_SEC / core_clk_rate;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  617  	core_clk_period_in_ns <<= OFFSET_CLK_NS_REG;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  618  	core_clk_period_in_ns &= MASK_CLK_NS_REG;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  619  
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  620  	switch (hs) {
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  621  	case FASTAUTO_MODE:
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  622  	case FAST_MODE:
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  623  		if (rate == PA_HS_MODE_A) {
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  624  			if (gear > ARRAY_SIZE(hs_fr_table_rA)) {
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  625  				dev_err(hba->dev,
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  626  					"%s: index %d exceeds table size %zu\n",
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  627  					__func__, gear,
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  628  					ARRAY_SIZE(hs_fr_table_rA));
031312dbc6950a drivers/ufs/host/ufs-qcom.c Manivannan Sadhasivam 2022-12-22  629  				return -EINVAL;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  630  			}
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  631  			tx_clk_cycles_per_us = hs_fr_table_rA[gear-1][1];
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  632  		} else if (rate == PA_HS_MODE_B) {
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  633  			if (gear > ARRAY_SIZE(hs_fr_table_rB)) {
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  634  				dev_err(hba->dev,
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  635  					"%s: index %d exceeds table size %zu\n",
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  636  					__func__, gear,
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  637  					ARRAY_SIZE(hs_fr_table_rB));
031312dbc6950a drivers/ufs/host/ufs-qcom.c Manivannan Sadhasivam 2022-12-22  638  				return -EINVAL;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  639  			}
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  640  			tx_clk_cycles_per_us = hs_fr_table_rB[gear-1][1];
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  641  		} else {
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  642  			dev_err(hba->dev, "%s: invalid rate = %d\n",
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  643  				__func__, rate);
031312dbc6950a drivers/ufs/host/ufs-qcom.c Manivannan Sadhasivam 2022-12-22  644  			return -EINVAL;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  645  		}
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  646  		break;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  647  	case SLOWAUTO_MODE:
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  648  	case SLOW_MODE:
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  649  		if (gear > ARRAY_SIZE(pwm_fr_table)) {
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  650  			dev_err(hba->dev,
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  651  					"%s: index %d exceeds table size %zu\n",
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  652  					__func__, gear,
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  653  					ARRAY_SIZE(pwm_fr_table));
031312dbc6950a drivers/ufs/host/ufs-qcom.c Manivannan Sadhasivam 2022-12-22  654  			return -EINVAL;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  655  		}
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  656  		tx_clk_cycles_per_us = pwm_fr_table[gear-1][1];
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  657  		break;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  658  	case UNCHANGED:
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  659  	default:
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  660  		dev_err(hba->dev, "%s: invalid mode = %d\n", __func__, hs);
031312dbc6950a drivers/ufs/host/ufs-qcom.c Manivannan Sadhasivam 2022-12-22  661  		return -EINVAL;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  662  	}
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  663  
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  664  	if (ufshcd_readl(hba, REG_UFS_TX_SYMBOL_CLK_NS_US) !=
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  665  	    (core_clk_period_in_ns | tx_clk_cycles_per_us)) {
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  666  		/* this register 2 fields shall be written at once */
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  667  		ufshcd_writel(hba, core_clk_period_in_ns | tx_clk_cycles_per_us,
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  668  			      REG_UFS_TX_SYMBOL_CLK_NS_US);
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  669  		/*
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  670  		 * make sure above write gets applied before we return from
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  671  		 * this function.
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  672  		 */
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  673  		mb();
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  674  	}
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  675  
9c02aa24bf404a drivers/ufs/host/ufs-qcom.c Abel Vesa             2023-01-19  676  	if (update_link_startup_timer && host->hw_ver.major != 0x5) {
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  677  		ufshcd_writel(hba, ((core_clk_rate / MSEC_PER_SEC) * 100),
9c02aa24bf404a drivers/ufs/host/ufs-qcom.c Abel Vesa             2023-01-19  678  			      REG_UFS_CFG0);
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  679  		/*
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  680  		 * make sure that this configuration is applied before
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  681  		 * we return
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  682  		 */
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  683  		mb();
f06fcc7155dcbc drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-10-28  684  	}
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  685  
031312dbc6950a drivers/ufs/host/ufs-qcom.c Manivannan Sadhasivam 2022-12-22  686  	return 0;
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  687  }
81c0fc51b7a790 drivers/scsi/ufs/ufs-qcom.c Yaniv Gardi           2015-01-15  688  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
