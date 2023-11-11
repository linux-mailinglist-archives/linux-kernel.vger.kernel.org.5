Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A527E8901
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 04:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjKKDwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 22:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKKDwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 22:52:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979631FEF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 19:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699674763; x=1731210763;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Sx/321IiezqO3pIgI86+mQL1tSKoa6eiEj06qRmMyTw=;
  b=QBF0UaGC0JOEH7IlyxTGTcFqik4qVVtbHk80MXHjUQSpJMMDXR6kYbjV
   HMJCIuQ2zTFVOqBXMux8RIOkoK27ahlhq9qRRIgXpRR9jN7rZ1RCdbOBz
   GbtOJv9sxSje5e4MgTqitDMH8UfIeF962cqODk+LwJl1XBkdOQOX51a0W
   DND1jMtGFy0rOfHY+P5jRALpUrTxTq3CnEotEZ9RJfPlphUEmHNI9+ZLH
   VFF8NiWOGHYcXVTZaikIff5R8umYpNutQuMVY0EIYVrs6ZIdjwaprUL7M
   g/AyUkEcBZyUGJ3GYQmaIGPlMVpH2c13cJd7zRWS9fV/Qv3MVsq4eQ6ku
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="369585906"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="369585906"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 19:52:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="767458798"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="767458798"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 10 Nov 2023 19:52:42 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1f32-000ABw-0V;
        Sat, 11 Nov 2023 03:52:40 +0000
Date:   Sat, 11 Nov 2023 11:51:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c:107:23: sparse:
 sparse: restricted __le32 degrades to integer
Message-ID: <202311111127.0cYR4j6Z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 25e80cd05ff81e51750106f1ae12364449ec38e7 net: stmmac: Get correct timestamp values from XGMAC
date:   4 years, 3 months ago
config: i386-randconfig-062-20230914 (https://download.01.org/0day-ci/archive/20231111/202311111127.0cYR4j6Z-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111127.0cYR4j6Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111127.0cYR4j6Z-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c:107:23: sparse: sparse: restricted __le32 degrades to integer
   drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c:107:50: sparse: sparse: restricted __le32 degrades to integer

vim +107 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c

    94	
    95	static int dwxgmac2_rx_check_timestamp(void *desc)
    96	{
    97		struct dma_desc *p = (struct dma_desc *)desc;
    98		unsigned int rdes3 = le32_to_cpu(p->des3);
    99		bool desc_valid, ts_valid;
   100	
   101		dma_rmb();
   102	
   103		desc_valid = !(rdes3 & XGMAC_RDES3_OWN) && (rdes3 & XGMAC_RDES3_CTXT);
   104		ts_valid = !(rdes3 & XGMAC_RDES3_TSD) && (rdes3 & XGMAC_RDES3_TSA);
   105	
   106		if (likely(desc_valid && ts_valid)) {
 > 107			if ((p->des0 == 0xffffffff) && (p->des1 == 0xffffffff))
   108				return -EINVAL;
   109			return 0;
   110		}
   111	
   112		return -EINVAL;
   113	}
   114	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
