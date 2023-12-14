Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F27281297B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbjLNHga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbjLNHg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:36:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB43F10F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702539392; x=1734075392;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OHT0rrkC540J0qbJWN8oh5Kam/JAt8k55e41ve183GQ=;
  b=NMe+Ix84AA/ORVH3WamQEpDlCOV480PTHUgvNGIyhX/uakHl36EKGjZO
   qa9hdaWuXK+7Oj7mRtX3/3IhRKlfsjFHslmAmpkptTy2by9AaOpjZ2zOI
   6zDjL4TF5ZCDD0WYgj1vUiRNXkqKQa9ZHW0PM0N5s8nyw4bCXWDcQLJPv
   xVL/wLOfF4lBKvx9WlV2jmL0C3S9sVqvkKGpWG7jU1g9pAsEoRE5hr3us
   a1zH4GL3isXrmWgtZJwUqbN29gCkxoN8kWTxYQEDOiYZ1bO6Y9pof8B0T
   f2lMuygPORrzZNht5AqCXolwBIwJvfkNCx9nk8rpWLieE6C77otFt5xpq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="374588353"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="374588353"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:36:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1021420785"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="1021420785"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 13 Dec 2023 23:36:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDgGL-000Lju-1s;
        Thu, 14 Dec 2023 07:36:09 +0000
Date:   Thu, 14 Dec 2023 15:35:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Julien Massot <julien.massot@iot.bzh>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: drivers/remoteproc/rcar_rproc.c:45:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202312141514.1LX4xpRG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 285892a74f1370a12249f765c6a4e3b16194852e remoteproc: Add Renesas rcar driver
date:   2 years ago
config: mips-randconfig-r122-20231108 (https://download.01.org/0day-ci/archive/20231214/202312141514.1LX4xpRG-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312141514.1LX4xpRG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141514.1LX4xpRG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/rcar_rproc.c:28:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     expected void *va
   drivers/remoteproc/rcar_rproc.c:28:12: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/rcar_rproc.c:45:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *va @@
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/remoteproc/rcar_rproc.c:45:20: sparse:     got void *va

vim +45 drivers/remoteproc/rcar_rproc.c

    40	
    41	static int rcar_rproc_mem_release(struct rproc *rproc,
    42					   struct rproc_mem_entry *mem)
    43	{
    44		dev_dbg(&rproc->dev, "unmap memory: %pa\n", &mem->dma);
  > 45		iounmap(mem->va);
    46	
    47		return 0;
    48	}
    49	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
