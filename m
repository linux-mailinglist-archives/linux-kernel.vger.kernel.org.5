Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67317CBD47
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjJQIWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQIWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:22:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1C93;
        Tue, 17 Oct 2023 01:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697530968; x=1729066968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=18C0RvA7Co1JNquL2AuXahyTLK/I1EcsLrFRsMv0xXw=;
  b=VERU788PmM/RGtklGywkmGlZ9X/rGnxIjx/bBnIN4sBwHmzaOd1z3HlN
   Komk68SM4cnE10cAENt7Lu45dEFIjIv8jPuID7gUDvwOqk04L1NJ5Si7z
   L/7gC4nuXWN0SiSuedS0OU0jd5eemNaF+q7vFDFN5IxfKZj4tWEFSrgfv
   8GO6sgz7TqCPL7uN0fmn3zIdBchDjiUOfd8d3XbdAMH1KdkmyRSOpM4hs
   /A5IW1NHYPB+C1uMUhWpuA9zA6OOtfIbGqrtMeydohU8LwyrY1isW20Wu
   Xhbxv034v51SgEwZf5uzD4rcz8XBp8qwdRXndTzxtPzdDC0jphhglSr7a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="389598072"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="389598072"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:22:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826348799"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="826348799"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Oct 2023 01:22:43 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsfLd-0009LV-2L;
        Tue, 17 Oct 2023 08:22:41 +0000
Date:   Tue, 17 Oct 2023 16:21:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_parass@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v2] bus: mhi: host: Add tracing support
Message-ID: <202310171556.hmPBsvRX-lkp@intel.com>
References: <20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3006adf3be79cde4d14b1800b963b82b6e5572e0]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/bus-mhi-host-Add-tracing-support/20231017-120241
base:   3006adf3be79cde4d14b1800b963b82b6e5572e0
patch link:    https://lore.kernel.org/r/20231013-ftrace_support-v2-1-6e893ce010b5%40quicinc.com
patch subject: [PATCH v2] bus: mhi: host: Add tracing support
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310171556.hmPBsvRX-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310171556.hmPBsvRX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310171556.hmPBsvRX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/bus/mhi/host/main.c:249:12: warning: no previous prototype for 'mhi_to_physical' [-Wmissing-prototypes]
     249 | dma_addr_t mhi_to_physical(struct mhi_ring *ring, void *addr)
         |            ^~~~~~~~~~~~~~~


vim +/mhi_to_physical +249 drivers/bus/mhi/host/main.c

   248	
 > 249	dma_addr_t mhi_to_physical(struct mhi_ring *ring, void *addr)
   250	{
   251		return (addr - ring->base) + ring->iommu_base;
   252	}
   253	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
