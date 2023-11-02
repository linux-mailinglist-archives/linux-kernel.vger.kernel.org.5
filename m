Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF07DFC78
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377494AbjKBWiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjKBWh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:37:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73BBDC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 15:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698964672; x=1730500672;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0NvfMfK7RivB/Qa2Bg1cm3UbudCwE0MREXOfQzBobsI=;
  b=geIZY6IKEByo4QGHdjDOulRvW1W7tfO40sNrRXdZ1Ob4zBVxlqu8q8lC
   EVTQis2sTJS8YEoea1HrFHkxWcZwe3oRq+RqTwGyaWk7klRgJ9/kIJ+AD
   jDdF5Z63Kghec3WtMkwOgjeiCED3mGqD0vp8EGB9gel1Kk+jKyZdX0wLD
   7WWxoxAhdT/FT4WHwUZY26RD21gxMplV716vy1ezKQn13+gf0z6oBeSn8
   J2DYxJcdzjdMEuwcEVIvA7zme8TL4A9M1RwS8GmKkoUGXSal7N/0Ywbdw
   L0N2bguvNJFkKSsL7XEPlUdqjrnnZfrCZ4EnKyC16OL+zyHFmFJiV28cj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="368186326"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="368186326"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 15:37:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="905140204"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="905140204"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Nov 2023 15:37:51 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qygJx-0001xT-0Z;
        Thu, 02 Nov 2023 22:37:49 +0000
Date:   Fri, 3 Nov 2023 06:36:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ben Levinsky <ben.levinsky@amd.com>
Subject: drivers/remoteproc/xlnx_r5_remoteproc.c:209:20: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202311030635.j5LPZWZV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4652b8e4f3ffa48c706ec334f048c217a7d9750d
commit: 6b291e8020a8bd90e94ee13d61f251040425c90d drivers: remoteproc: Add Xilinx r5 remoteproc driver
date:   11 months ago
config: arm64-randconfig-r122-20231102 (https://download.01.org/0day-ci/archive/20231103/202311030635.j5LPZWZV-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231103/202311030635.j5LPZWZV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030635.j5LPZWZV-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/xlnx_r5_remoteproc.c:209:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/remoteproc/xlnx_r5_remoteproc.c:315:20: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +209 drivers/remoteproc/xlnx_r5_remoteproc.c

   190	
   191	/*
   192	 * zynqmp_r5_mem_region_map()
   193	 * @rproc: single R5 core's corresponding rproc instance
   194	 * @mem: mem descriptor to map reserved memory-regions
   195	 *
   196	 * Callback to map va for memory-region's carveout.
   197	 *
   198	 * return 0 on success, otherwise non-zero value on failure
   199	 */
   200	static int zynqmp_r5_mem_region_map(struct rproc *rproc,
   201					    struct rproc_mem_entry *mem)
   202	{
   203		void __iomem *va;
   204	
   205		va = ioremap_wc(mem->dma, mem->len);
   206		if (IS_ERR_OR_NULL(va))
   207			return -ENOMEM;
   208	
 > 209		mem->va = (void *)va;
   210	
   211		return 0;
   212	}
   213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
