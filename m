Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE487BC443
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbjJGCtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjJGCtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:49:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29955BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696646984; x=1728182984;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pX/0EsWUXqTCP5p+PRZZ/XgZBNz1MkDH9SqDCXCWzCQ=;
  b=mqJggp1yDtequxgoC1NRUS5Gs8n+Jd3RleUcxFs7tudhJhGvqZ9Iy/rR
   05VfG40tf5YIg+u74QEKmm0tTUrUath/N8buxOfClb0ZBfTf0lmraCYKi
   J+UuwJLqRCWiwxaMj/7lhG1BViRsgYS9hK7xlkH2hMLmK+k8PJw5HKPH2
   SfKZe1pKCCSmk6vwhwCyxXv2YHpapHW8HDpemLD7jjpn+ccqgB8bzjxxd
   a3qSdM2lr/652Pw8ufWI6qy0fHwioZITWsl6I2nNmTbgWRhYII0/ATl5x
   fUQPczprJCZuX7luDsG3JzgBy+/Tnaz5ODPL3zh4Q9GMqh76RZ4sNjQDy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="450378483"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="450378483"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 19:49:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="702258107"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="702258107"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Oct 2023 19:49:41 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoxNr-0003sv-1p;
        Sat, 07 Oct 2023 02:49:39 +0000
Date:   Sat, 7 Oct 2023 10:48:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hui Wang <hui.wang@canonical.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/fsl/fsl-asoc-card.c:57: warning: Function parameter or
 member 'mclk' not described in 'codec_priv'
Message-ID: <202310071052.e2QMGLd2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hui,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   82714078aee4ccbd6ee7579d5a21f8a72155d0fb
commit: 1075df4bdeb320bbf94a1f6d3761391264eb2c7f ASoC: fsl-asoc-card: add nau8822 support
date:   4 months ago
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231007/202310071052.e2QMGLd2-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310071052.e2QMGLd2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310071052.e2QMGLd2-lkp@intel.com/

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
