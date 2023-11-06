Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E097E184C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 02:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjKFBZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 20:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFBY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 20:24:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C56DD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 17:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699233896; x=1730769896;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=emwDhGFwAcR/TkYDjsqb3lDZBQMFnV5WPFX6PaRArd0=;
  b=D6ASUYtbwW1v3xTKE8BXhWPBj/3ETX8/aaETMQesH1x3Zdwyv8OZIsWb
   90EhKa6Hp9Nss9iaZe7mV39lxBjwhZRmojLL0EKZaxKhYRG3C19x2gu3N
   QoJ3tOh2UK3boNN0FFkulw/x5PRYBIimvCCb06VQbPDpi0hHbcOzyKpl9
   boIdRvFWiXBVKTj/iwT8Hr5Y9QjKJC5Cv1u7V3/prgphHZaagoYEKBWIK
   ewtK1ycnQD61oP+/5bkUhE13dz6siggTQBHMI3DLuZTDWMxdg4hxmiLaw
   qhY4Y9ydq5YQt8TkgyhSmqWxNQj19lcvkQiNHqf1hwfbiwGogW5uSgvBZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="7822688"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="7822688"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 17:24:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="712056932"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="712056932"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Nov 2023 17:24:54 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzoMG-0005xW-1u;
        Mon, 06 Nov 2023 01:24:52 +0000
Date:   Mon, 6 Nov 2023 09:23:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/pmdomain/apple/pmgr-pwrstate.c:180:32: sparse: sparse:
 symbol 'apple_pmgr_reset_ops' was not declared. Should it be static?
Message-ID: <202311060916.WwbD4jNN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
commit: e2ad626f8f409899baf1bf192d0533a851128b19 pmdomain: Rename the genpd subsystem to pmdomain
date:   8 weeks ago
config: arm64-randconfig-r122-20231102 (https://download.01.org/0day-ci/archive/20231106/202311060916.WwbD4jNN-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231106/202311060916.WwbD4jNN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060916.WwbD4jNN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pmdomain/apple/pmgr-pwrstate.c:180:32: sparse: sparse: symbol 'apple_pmgr_reset_ops' was not declared. Should it be static?

vim +/apple_pmgr_reset_ops +180 drivers/pmdomain/apple/pmgr-pwrstate.c

6df9d38f9146e8 drivers/soc/apple/apple-pmgr-pwrstate.c Hector Martin 2021-11-24  179  
6df9d38f9146e8 drivers/soc/apple/apple-pmgr-pwrstate.c Hector Martin 2021-11-24 @180  const struct reset_control_ops apple_pmgr_reset_ops = {
6df9d38f9146e8 drivers/soc/apple/apple-pmgr-pwrstate.c Hector Martin 2021-11-24  181  	.assert		= apple_pmgr_reset_assert,
6df9d38f9146e8 drivers/soc/apple/apple-pmgr-pwrstate.c Hector Martin 2021-11-24  182  	.deassert	= apple_pmgr_reset_deassert,
6df9d38f9146e8 drivers/soc/apple/apple-pmgr-pwrstate.c Hector Martin 2021-11-24  183  	.reset		= apple_pmgr_reset_reset,
6df9d38f9146e8 drivers/soc/apple/apple-pmgr-pwrstate.c Hector Martin 2021-11-24  184  	.status		= apple_pmgr_reset_status,
6df9d38f9146e8 drivers/soc/apple/apple-pmgr-pwrstate.c Hector Martin 2021-11-24  185  };
6df9d38f9146e8 drivers/soc/apple/apple-pmgr-pwrstate.c Hector Martin 2021-11-24  186  

:::::: The code at line 180 was first introduced by commit
:::::: 6df9d38f9146e83b473f0c9e57fb5fdf3fcc93e2 soc: apple: Add driver for Apple PMGR power state controls

:::::: TO: Hector Martin <marcan@marcan.st>
:::::: CC: Hector Martin <marcan@marcan.st>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
