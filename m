Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8480BB1F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 14:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjLJNiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 08:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjLJNZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 08:25:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E582698
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 05:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702214703; x=1733750703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qgA9sHUCpCBRdTVsZcv1YtwlGzitGNqqpRctmc0bWaQ=;
  b=IjRUqAVXQc/APRK7XWtb8lh4L61oOVjNN4WAoNRjqI0yl7rJc5ujip5c
   997OKvoWU02dxZYDbjDHWrB+pCsUjYxmGg3sQ/wQkAe42aF1qBveMQyr9
   97xAG5p4K9IuMkLkKSvT8y0oxGErAh+jK8L+YCsfzMzTDoC+0Hbjzq1UN
   UFgFMu+IWFqYwUDrr0DQCdk1deLP6Pd6JViQstHmQhLSctBaT9wNwIY74
   mLvv2IcMlTiB2GGoJtTqF6VzXJVIXiWgCMmtjQNOBFUTec0lTM9of2Yh8
   WWgAwjy83FTvwR1p0P9M4+N5jCSixGMpXKxbksYZdfqFUqF8/GK8EQwPr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="374060335"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="374060335"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:25:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="776337372"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="776337372"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 10 Dec 2023 05:25:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCJnd-000GsA-1J;
        Sun, 10 Dec 2023 13:24:54 +0000
Date:   Sun, 10 Dec 2023 21:24:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/mtd/nand/raw/pl35x-nand-controller.c:147: warning: Function
 parameter or member 'chips' not described in 'pl35x_nandc'
Message-ID: <202312102130.geZ4dqyN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c527f5606aa545233a4d2c6d5c636ed82b8633ef
commit: 08d8c62164a322eb923034acacf25246b775593a mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller
date:   2 years, 6 months ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231210/202312102130.geZ4dqyN-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312102130.geZ4dqyN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312102130.geZ4dqyN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/raw/pl35x-nand-controller.c:147: warning: Function parameter or member 'chips' not described in 'pl35x_nandc'


vim +147 drivers/mtd/nand/raw/pl35x-nand-controller.c

   126	
   127	/**
   128	 * struct pl35x_nandc - NAND flash controller driver structure
   129	 * @dev: Kernel device
   130	 * @conf_regs: SMC configuration registers for command phase
   131	 * @io_regs: NAND data registers for data phase
   132	 * @controller: Core NAND controller structure
   133	 * @chip: NAND chip information structure
   134	 * @selected_chip: NAND chip currently selected by the controller
   135	 * @assigned_cs: List of assigned CS
   136	 * @ecc_buf: Temporary buffer to extract ECC bytes
   137	 */
   138	struct pl35x_nandc {
   139		struct device *dev;
   140		void __iomem *conf_regs;
   141		void __iomem *io_regs;
   142		struct nand_controller controller;
   143		struct list_head chips;
   144		struct nand_chip *selected_chip;
   145		unsigned long assigned_cs;
   146		u8 *ecc_buf;
 > 147	};
   148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
