Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36CD79A516
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 09:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjIKHyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 03:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjIKHyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:54:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D2FA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694418885; x=1725954885;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sY1AcfvpX4DDkwt+QmJjCLO65PXr0lHFI/eGUfN3flg=;
  b=cY5Hh+3qMLrrQt/BA0HR52pifGwDiRhPniAEXoLYMr6VDyxu6H1oqC/f
   4FW9P+7yPmHwfnb0fBiGPFr6KjA1Eo4jGqWRaW/I/Iu5Dak7COmMtDisQ
   CRIJ5llCPIHpm8cgtqRzvZCtgxdgK6yKepruTUv3/fmdOriA7FyT/7jQi
   0XdHOpNHBKZpJ2ImnLyWQFL3o12RQ8ZUllBpuzG2IJ6BI1rSpPS33vIhp
   S/gFCSyJbzMDj1VyHOMyO3BLG6t3huJKIAdTogGCiY+YFSePssTzc2jh3
   7bYp20XscwZ7gDHdtUVvweVxBUznpygLhI3s69Q1UlLG5CwJrShFIS/Ax
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="368260572"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="368260572"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 00:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="989995342"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="989995342"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2023 00:54:43 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfbkn-0005xT-2q;
        Mon, 11 Sep 2023 07:54:41 +0000
Date:   Mon, 11 Sep 2023 15:54:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hui Wang <hui.wang@canonical.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/fsl/fsl-asoc-card.c:57: warning: Function parameter or
 member 'mclk' not described in 'codec_priv'
Message-ID: <202309111520.OcgoPaRW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 1075df4bdeb320bbf94a1f6d3761391264eb2c7f ASoC: fsl-asoc-card: add nau8822 support
date:   3 months ago
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230911/202309111520.OcgoPaRW-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230911/202309111520.OcgoPaRW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309111520.OcgoPaRW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/fsl/fsl-asoc-card.c:57: warning: Function parameter or member 'mclk' not described in 'codec_priv'


vim +57 sound/soc/fsl/fsl-asoc-card.c

708b4351f08c08 Nicolin Chen         2014-07-30  41  
708b4351f08c08 Nicolin Chen         2014-07-30  42  /**
31deacffcdba10 Pierre-Louis Bossart 2020-07-02  43   * struct codec_priv - CODEC private data
708b4351f08c08 Nicolin Chen         2014-07-30  44   * @mclk_freq: Clock rate of MCLK
efd0b1660829a9 Shengjiu Wang        2021-03-17  45   * @free_freq: Clock rate of MCLK for hw_free()
708b4351f08c08 Nicolin Chen         2014-07-30  46   * @mclk_id: MCLK (or main clock) id for set_sysclk()
708b4351f08c08 Nicolin Chen         2014-07-30  47   * @fll_id: FLL (or secordary clock) id for set_sysclk()
708b4351f08c08 Nicolin Chen         2014-07-30  48   * @pll_id: PLL id for set_pll()
708b4351f08c08 Nicolin Chen         2014-07-30  49   */
708b4351f08c08 Nicolin Chen         2014-07-30  50  struct codec_priv {
1075df4bdeb320 Hui Wang             2022-06-16  51  	struct clk *mclk;
708b4351f08c08 Nicolin Chen         2014-07-30  52  	unsigned long mclk_freq;
efd0b1660829a9 Shengjiu Wang        2021-03-17  53  	unsigned long free_freq;
708b4351f08c08 Nicolin Chen         2014-07-30  54  	u32 mclk_id;
708b4351f08c08 Nicolin Chen         2014-07-30  55  	u32 fll_id;
708b4351f08c08 Nicolin Chen         2014-07-30  56  	u32 pll_id;
708b4351f08c08 Nicolin Chen         2014-07-30 @57  };
708b4351f08c08 Nicolin Chen         2014-07-30  58  

:::::: The code at line 57 was first introduced by commit
:::::: 708b4351f08c08ea93f773fb9197bdd3f3b08273 ASoC: fsl: Add Freescale Generic ASoC Sound Card with ASRC support

:::::: TO: Nicolin Chen <nicoleotsuka@gmail.com>
:::::: CC: Mark Brown <broonie@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
