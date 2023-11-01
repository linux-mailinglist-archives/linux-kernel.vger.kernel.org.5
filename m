Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F0D7DE151
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344001AbjKANCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjKANCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:02:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE3A103;
        Wed,  1 Nov 2023 06:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698843717; x=1730379717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s2xZhAihU9OTZQg4ZTNwu8nAKvr8L+OIZA8uCubjXJs=;
  b=iJrKkGiTHO+spiP4BxCovdit3hGhA//QfnIt4K7/NyOLTv55nNqD3p0S
   7ZZqRo0vLxiPnq2SqA35XJPHiIeO8BMH5ELswNQqxKNleXgDIaqle8jqR
   DI+ET7vugl57ikTVQwBWSz+Xj98xiDXcgrU29Gmu72W8A3+qtw9JZ30Cc
   uMaIbqiGSjACLDppaqwpqcWj7RtDH24ofsQelfuXcToi/8kIMF673k4rf
   HesGkmYgj07L5yLnEyDbikC0UANgBuewOuyeibDaUM8uXFp0apuYxN00q
   s/QqUD8zfEVPg5OayzfmeGSWQuD0/VCKU9zExi1Odh69IANK9CUJRHNNo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="387371340"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="387371340"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 06:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="754470441"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="754470441"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 01 Nov 2023 06:01:54 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyAr1-0000om-1F;
        Wed, 01 Nov 2023 13:01:51 +0000
Date:   Wed, 1 Nov 2023 21:01:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kaiwei Liu <kaiwei.liu@unisoc.com>, Vinod Koul <vkoul@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kaiwei liu <liukaiwei086@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: Re: [PATCH 1/3] dmaengine: sprd: support dma device suspend/resume
Message-ID: <202311012018.QwjGJH02-lkp@intel.com>
References: <20231025120500.8914-1-kaiwei.liu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025120500.8914-1-kaiwei.liu@unisoc.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kaiwei,

kernel test robot noticed the following build errors:

[auto build test ERROR on vkoul-dmaengine/next]
[also build test ERROR on linus/master v6.6 next-20231101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kaiwei-Liu/dmaengine-sprd-delete-enable-opreation-in-probe/20231025-201524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20231025120500.8914-1-kaiwei.liu%40unisoc.com
patch subject: [PATCH 1/3] dmaengine: sprd: support dma device suspend/resume
config: openrisc-allyesconfig (https://download.01.org/0day-ci/archive/20231101/202311012018.QwjGJH02-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231101/202311012018.QwjGJH02-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311012018.QwjGJH02-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/dma/sprd-dma.c: In function 'sprd_dma_suspend_noirq':
>> drivers/dma/sprd-dma.c:1296:38: error: 'struct dev_pm_info' has no member named 'usage_count'
    1296 |             (atomic_read(&(dev->power.usage_count)) > 1))
         |                                      ^
   drivers/dma/sprd-dma.c: In function 'sprd_dma_resume_early':
   drivers/dma/sprd-dma.c:1305:38: error: 'struct dev_pm_info' has no member named 'usage_count'
    1305 |             (atomic_read(&(dev->power.usage_count)) > 1))
         |                                      ^
   drivers/dma/sprd-dma.c: At top level:
   drivers/dma/sprd-dma.c:1302:12: warning: 'sprd_dma_resume_early' defined but not used [-Wunused-function]
    1302 | static int sprd_dma_resume_early(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/dma/sprd-dma.c:1293:12: warning: 'sprd_dma_suspend_noirq' defined but not used [-Wunused-function]
    1293 | static int sprd_dma_suspend_noirq(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~


vim +1296 drivers/dma/sprd-dma.c

  1292	
  1293	static int sprd_dma_suspend_noirq(struct device *dev)
  1294	{
  1295		if ((pm_runtime_status_suspended(dev)) ||
> 1296		    (atomic_read(&(dev->power.usage_count)) > 1))
  1297			return 0;
  1298	
  1299		return sprd_dma_runtime_suspend(dev);
  1300	}
  1301	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
