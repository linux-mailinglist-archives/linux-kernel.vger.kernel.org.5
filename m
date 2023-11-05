Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750977E1274
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 08:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjKEHab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 02:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjKEHa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 02:30:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C59FF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699169426; x=1730705426;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qwBgqe25CLImrb0YEJGrafg6TBFTklaA3nukUOZl6BQ=;
  b=T3HwvhMbDzF7cI9tJajKFXQxCM3gB71TBSuZ2lY6bHNheuVnSznL+QfN
   W4TcKzVpMrFgzGp5nVRbQyvhXsVle0+pwe7pyyxmdvNdrX62fQ1nQx+fH
   3t6Iaq7GtWPWKbbu4AALYtHn5OFgKBzXbMbrlhEqVGYANKxsPYhN3+9WX
   cXDsO9EmADfbVeFfAzBXICC3sWUEkoFt6HFlVzo+o4CH6pwsKVxtf30la
   RMKv7OIw6mK4D58G5csk5PrbkuueFh6SgXB7TwNAyVnKGsw3N/UWDXFMk
   J4b5K4cGKCx9BomPHVRR5G+KI+1E68wrtKTgvUHxgspuQqEu9n5VKruUA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="374162755"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="374162755"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 00:30:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="1009232419"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="1009232419"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Nov 2023 00:30:23 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzXaP-00059I-0o;
        Sun, 05 Nov 2023 07:30:21 +0000
Date:   Sun, 5 Nov 2023 15:29:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ben Levinsky <ben.levinsky@amd.com>
Subject: drivers/remoteproc/xlnx_r5_remoteproc.c:209:20: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202311051552.fmM6xtjE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea6bf908d730b01bd264a8821159db9463c111c
commit: 6b291e8020a8bd90e94ee13d61f251040425c90d drivers: remoteproc: Add Xilinx r5 remoteproc driver
date:   12 months ago
config: arm64-randconfig-r122-20231102 (https://download.01.org/0day-ci/archive/20231105/202311051552.fmM6xtjE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231105/202311051552.fmM6xtjE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051552.fmM6xtjE-lkp@intel.com/

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
