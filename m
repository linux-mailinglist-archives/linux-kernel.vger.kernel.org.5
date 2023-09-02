Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCE07904A2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 03:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbjIBBYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 21:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIBBYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 21:24:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A9310FB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 18:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693617843; x=1725153843;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tckHgtpwnQNcacjW4qfssKjLmK7UZmRr5r8lIDbiAwo=;
  b=Sm3QRT3oA9bvVJy1VOnkX1hAGNy327VyUHubuVhglPnhRIHQagAR9Fkv
   1yjMRPk9vS9IZr95M4dmjSjYbWixmkaHX+/nhwyNk+bTkaTAW2DlUiTO7
   WV7xPiTiIxeM87ldK5c8jg4mxX/wcAuBaLU2jfqFDRoxsEV/4piIsWu68
   2sxNvk9g6RYHyJUrfsmflGcVVYCJSLfVeM+5mhMCsHl4AXsJoOQbA8QL2
   4kdZtW2GayF6v6fbhCdHjs0aAAmrJUG0XcAMrGSwaCR203S3fuavhw8XI
   adWCd+pJb1cA7Axnj+3jz3I+jt13khr/WNiJa10wicjrgd1+9FifYP+YQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356650878"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="356650878"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 18:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="883388683"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="883388683"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Sep 2023 18:24:03 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qcFMl-0001p7-1m;
        Sat, 02 Sep 2023 01:23:59 +0000
Date:   Sat, 2 Sep 2023 09:23:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: drivers/mmc/host/atmel-mci.c:238: warning: Function parameter or
 member 'dma_filter' not described in 'mci_platform_data'
Message-ID: <202309020937.C5S2sRnr-lkp@intel.com>
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

Hi Balamanikandan,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0468be89b3fa5b9249cee1097f1d50314950a2df
commit: d2c6d518c21d73d96616e08a19eccd4642f4bafa mmc: atmel-mci: move atmel MCI header file
date:   8 days ago
config: arm-defconfig (https://download.01.org/0day-ci/archive/20230902/202309020937.C5S2sRnr-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230902/202309020937.C5S2sRnr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309020937.C5S2sRnr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/atmel-mci.c:238: warning: Function parameter or member 'dma_filter' not described in 'mci_platform_data'


vim +238 drivers/mmc/host/atmel-mci.c

   228	
   229	/**
   230	 * struct mci_platform_data - board-specific MMC/SDcard configuration
   231	 * @dma_slave: DMA slave interface to use in data transfers.
   232	 * @slot: Per-slot configuration data.
   233	 */
   234	struct mci_platform_data {
   235		void			*dma_slave;
   236		dma_filter_fn		dma_filter;
   237		struct mci_slot_pdata	slot[ATMCI_MAX_NR_SLOTS];
 > 238	};
   239	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
