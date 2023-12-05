Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B435805D99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjLESII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLESIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:08:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7DC18B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701799692; x=1733335692;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EfMWOnuH6ZT9MW+eCxL/VjTx2nkZlroQzSJphdr/0O4=;
  b=ZGNW1/Q7/wzkecRoQo6PisoTPWGAai+dZvrEw74X6tDrQj2IPIYrZWrc
   k/9LFPjiT8rbvt2yAgj8j1EWmV+g0Z0BdLjUuYwaKdMZsgNsUUkd2fhLL
   Oj3ar0kbbXFEAz5JU40OBD8tiA/xxyWKFCf3LLru6dJgJ2UM3/qB2b+G5
   hnFpjFqTO5psFNo7SDti3JlBvT+CYVdiJKvF7DXkaF4l4Fp07JZI9FnK8
   YFYxH40P27DDNx17StFMId0rtzh9mFwrNBuFnWXdfagbcHusvIs3qvIe7
   pntVy5ohETVg9QBAE4kIyCbsggROqa61p69VAGm2TVJKBiz8h4bwdYCGw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="391100975"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="391100975"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 10:08:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="889024030"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="889024030"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2023 10:08:10 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAZq3-0009VR-1i;
        Tue, 05 Dec 2023 18:08:07 +0000
Date:   Wed, 6 Dec 2023 02:07:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: drivers/edac/versal_edac.c:745:21: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202312060244.Y1Aw12Kr-lkp@intel.com>
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
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 6f15b178cd6315c997981f76c6ebed7ad39144c5 EDAC/versal: Add a Xilinx Versal memory controller driver
date:   6 weeks ago
config: riscv-randconfig-r131-20231203 (https://download.01.org/0day-ci/archive/20231206/202312060244.Y1Aw12Kr-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312060244.Y1Aw12Kr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060244.Y1Aw12Kr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
>> drivers/edac/versal_edac.c:745:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *cs @@     got char const [noderef] __user *data @@
   drivers/edac/versal_edac.c:745:21: sparse:     expected char const *cs
   drivers/edac/versal_edac.c:745:21: sparse:     got char const [noderef] __user *data

vim +745 drivers/edac/versal_edac.c

   736	
   737	static ssize_t xddr_inject_data_poison_store(struct mem_ctl_info *mci,
   738						     const char __user *data)
   739	{
   740		struct edac_priv *priv = mci->pvt_info;
   741	
   742		writel(0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
   743		writel(0, priv->ddrmc_baseaddr + ECCW1_FLIP0_OFFSET);
   744	
 > 745		if (strncmp(data, "CE", 2) == 0) {
   746			writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
   747			       ECCW0_FLIP0_OFFSET);
   748			writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
   749			       ECCW1_FLIP0_OFFSET);
   750		} else {
   751			writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
   752			       ECCW0_FLIP0_OFFSET);
   753			writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
   754			       ECCW1_FLIP0_OFFSET);
   755		}
   756	
   757		/* Lock the PCSR registers */
   758		writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
   759	
   760		return 0;
   761	}
   762	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
