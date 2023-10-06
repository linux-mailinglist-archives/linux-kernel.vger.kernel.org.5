Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730657BB807
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjJFMoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjJFMod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:44:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F71CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696596272; x=1728132272;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KDV9Q7v6w7NxbZwSmJ1KGY0KMmrRQm4pceT0Mes1vok=;
  b=VKaG0Mvv5eVDJ8TMeqtCwX09fHec0c28xUCSHa2Iv2BVAsMuyxXRwWK9
   SY9oPvMzRytYw3fL+dsCqjX5KUziiS7WU/oRPLMqmfyolrYxv4Mhj0E+c
   xWkeqBLHg2sbxXn8YPdTwQOeqhrCua3zPnrbEET82Z6bveZcRR68AD5jO
   QLPN5VgLxttjOhnSgY8U558++IZxbohV3/9XyehYa8GRpHrg27/7+XaOX
   esRIIBZ9f/XUsv3Qs9lemntLnyeBQPJwhF90FPIhbA1hCsXEBuGGf8i17
   Y/yt588p+tynarVKyNdRs+wcT1bP9YusfWLWNkyVQefzaF2p4P9Yc0jsu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="381024899"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="381024899"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 05:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="752181743"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="752181743"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Oct 2023 05:44:29 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qokBv-00005d-0c;
        Fri, 06 Oct 2023 12:44:27 +0000
Date:   Fri, 6 Oct 2023 20:43:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: drivers/remoteproc/da8xx_remoteproc.c:80: warning: Function
 parameter or member 'dsp_reset' not described in 'da8xx_rproc'
Message-ID: <202310062044.AWGLMitV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b78b18fb8ee19f7a05f20c3abc865b3bfe182884
commit: b2201ee554a5811f569f31280b0079e7d6177606 remoteproc/davinci: use the reset framework
date:   5 years ago
config: arm-randconfig-004-20230928 (https://download.01.org/0day-ci/archive/20231006/202310062044.AWGLMitV-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310062044.AWGLMitV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310062044.AWGLMitV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/da8xx_remoteproc.c:80: warning: Function parameter or member 'dsp_reset' not described in 'da8xx_rproc'
   drivers/remoteproc/da8xx_remoteproc.c:89: warning: Function parameter or member 'irq' not described in 'handle_event'
   drivers/remoteproc/da8xx_remoteproc.c:89: warning: Function parameter or member 'p' not described in 'handle_event'
   drivers/remoteproc/da8xx_remoteproc.c:109: warning: Function parameter or member 'irq' not described in 'da8xx_rproc_callback'
   drivers/remoteproc/da8xx_remoteproc.c:109: warning: Function parameter or member 'p' not described in 'da8xx_rproc_callback'


vim +80 drivers/remoteproc/da8xx_remoteproc.c

59b2355fc90e4a Suman Anna          2017-08-01  56  
13be5432d8721d Robert Tivy         2013-04-09  57  /**
13be5432d8721d Robert Tivy         2013-04-09  58   * struct da8xx_rproc - da8xx remote processor instance state
13be5432d8721d Robert Tivy         2013-04-09  59   * @rproc: rproc handle
59b2355fc90e4a Suman Anna          2017-08-01  60   * @mem: internal memory regions data
59b2355fc90e4a Suman Anna          2017-08-01  61   * @num_mems: number of internal memory regions
13be5432d8721d Robert Tivy         2013-04-09  62   * @dsp_clk: placeholder for platform's DSP clk
13be5432d8721d Robert Tivy         2013-04-09  63   * @ack_fxn: chip-specific ack function for ack'ing irq
13be5432d8721d Robert Tivy         2013-04-09  64   * @irq_data: ack_fxn function parameter
13be5432d8721d Robert Tivy         2013-04-09  65   * @chipsig: virt ptr to DSP interrupt registers (CHIPSIG & CHIPSIG_CLR)
13be5432d8721d Robert Tivy         2013-04-09  66   * @bootreg: virt ptr to DSP boot address register (HOST1CFG)
13be5432d8721d Robert Tivy         2013-04-09  67   * @irq: irq # used by this instance
13be5432d8721d Robert Tivy         2013-04-09  68   */
13be5432d8721d Robert Tivy         2013-04-09  69  struct da8xx_rproc {
13be5432d8721d Robert Tivy         2013-04-09  70  	struct rproc *rproc;
59b2355fc90e4a Suman Anna          2017-08-01  71  	struct da8xx_rproc_mem *mem;
59b2355fc90e4a Suman Anna          2017-08-01  72  	int num_mems;
13be5432d8721d Robert Tivy         2013-04-09  73  	struct clk *dsp_clk;
b2201ee554a581 Bartosz Golaszewski 2018-06-21  74  	struct reset_control *dsp_reset;
13be5432d8721d Robert Tivy         2013-04-09  75  	void (*ack_fxn)(struct irq_data *data);
13be5432d8721d Robert Tivy         2013-04-09  76  	struct irq_data *irq_data;
13be5432d8721d Robert Tivy         2013-04-09  77  	void __iomem *chipsig;
13be5432d8721d Robert Tivy         2013-04-09  78  	void __iomem *bootreg;
13be5432d8721d Robert Tivy         2013-04-09  79  	int irq;
13be5432d8721d Robert Tivy         2013-04-09 @80  };
13be5432d8721d Robert Tivy         2013-04-09  81  

:::::: The code at line 80 was first introduced by commit
:::::: 13be5432d8721d89cadae105663761f45f427842 remoteproc/davinci: add a remoteproc driver for OMAP-L13x DSP

:::::: TO: Robert Tivy <rtivy@ti.com>
:::::: CC: Ohad Ben-Cohen <ohad@wizery.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
