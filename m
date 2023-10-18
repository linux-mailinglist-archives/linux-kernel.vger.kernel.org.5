Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034607CDD3A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbjJRN2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344679AbjJRN17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:27:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71A411B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697635677; x=1729171677;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/CxlLN8Oqkj/pOKWxBNRMJvTluUZnsZ5TnlkbzZ7HT8=;
  b=AZ4Sb7hAIsLdTUEj8Ee5odaETxINw7UiKMiAPrkSU0gDDXPSBTq5gilz
   C3b+eQi7/vxdtiV+qEgwzqh03nY7vOAYX0XGbh9QmcU0FcaKoZ4p7X9U5
   qsQvaYDf2aSvvRbzDv8o+GjS2UYPUDtKe1jAbF9CUVdK1zG+kb/zzTs26
   bUCf+Ld8X5+2wQuL2GZUf07tlMh4a9wd7+BUn+DdM3nzytO/3HDdWO0m+
   YIWwmtp+U1B989ZgOx42QDMHSzDDPTExl6ulmViLlqGjpjBOJzJpX98jE
   z92vlyKtnqigMcfQDcsBtPILFPaLO4DqDELX/UTkx2w385p3E+wDR82BF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="417125406"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="417125406"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 06:27:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1003810880"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="1003810880"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Oct 2023 06:27:51 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt6aT-0000Q2-0q;
        Wed, 18 Oct 2023 13:27:49 +0000
Date:   Wed, 18 Oct 2023 21:27:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geetha sowjanya <gakula@marvell.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sunil Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c:535:36:
 warning: '%d' directive writing between 1 and 11 bytes into a region of size
 7
Message-ID: <202310182158.KXRDW2Ao-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: d06c2aba51631bf6cd32a2f8f1edd67c110ade8a octeontx2-af: cn10k: mcs: Add debugfs support
date:   1 year ago
config: x86_64-buildonly-randconfig-006-20230826 (https://download.01.org/0day-ci/archive/20231018/202310182158.KXRDW2Ao-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310182158.KXRDW2Ao-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310182158.KXRDW2Ao-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c: In function 'rvu_dbg_mcs_init':
>> drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c:535:36: warning: '%d' directive writing between 1 and 11 bytes into a region of size 7 [-Wformat-overflow=]
     535 |                 sprintf(dname, "mcs%d", i);
         |                                    ^~
   drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c:535:32: note: directive argument in the range [-2147483644, 2147483646]
     535 |                 sprintf(dname, "mcs%d", i);
         |                                ^~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c:535:17: note: 'sprintf' output between 5 and 15 bytes into a destination of size 10
     535 |                 sprintf(dname, "mcs%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +535 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c

   520	
   521	static void rvu_dbg_mcs_init(struct rvu *rvu)
   522	{
   523		struct mcs *mcs;
   524		char dname[10];
   525		int i;
   526	
   527		if (!rvu->mcs_blk_cnt)
   528			return;
   529	
   530		rvu->rvu_dbg.mcs_root = debugfs_create_dir("mcs", rvu->rvu_dbg.root);
   531	
   532		for (i = 0; i < rvu->mcs_blk_cnt; i++) {
   533			mcs = mcs_get_pdata(i);
   534	
 > 535			sprintf(dname, "mcs%d", i);
   536			rvu->rvu_dbg.mcs = debugfs_create_dir(dname,
   537							      rvu->rvu_dbg.mcs_root);
   538	
   539			rvu->rvu_dbg.mcs_rx = debugfs_create_dir("rx_stats", rvu->rvu_dbg.mcs);
   540	
   541			debugfs_create_file("flowid", 0600, rvu->rvu_dbg.mcs_rx, mcs,
   542					    &rvu_dbg_mcs_rx_flowid_stats_fops);
   543	
   544			debugfs_create_file("secy", 0600, rvu->rvu_dbg.mcs_rx, mcs,
   545					    &rvu_dbg_mcs_rx_secy_stats_fops);
   546	
   547			debugfs_create_file("sc", 0600, rvu->rvu_dbg.mcs_rx, mcs,
   548					    &rvu_dbg_mcs_rx_sc_stats_fops);
   549	
   550			debugfs_create_file("sa", 0600, rvu->rvu_dbg.mcs_rx, mcs,
   551					    &rvu_dbg_mcs_rx_sa_stats_fops);
   552	
   553			debugfs_create_file("port", 0600, rvu->rvu_dbg.mcs_rx, mcs,
   554					    &rvu_dbg_mcs_rx_port_stats_fops);
   555	
   556			rvu->rvu_dbg.mcs_tx = debugfs_create_dir("tx_stats", rvu->rvu_dbg.mcs);
   557	
   558			debugfs_create_file("flowid", 0600, rvu->rvu_dbg.mcs_tx, mcs,
   559					    &rvu_dbg_mcs_tx_flowid_stats_fops);
   560	
   561			debugfs_create_file("secy", 0600, rvu->rvu_dbg.mcs_tx, mcs,
   562					    &rvu_dbg_mcs_tx_secy_stats_fops);
   563	
   564			debugfs_create_file("sc", 0600, rvu->rvu_dbg.mcs_tx, mcs,
   565					    &rvu_dbg_mcs_tx_sc_stats_fops);
   566	
   567			debugfs_create_file("sa", 0600, rvu->rvu_dbg.mcs_tx, mcs,
   568					    &rvu_dbg_mcs_tx_sa_stats_fops);
   569	
   570			debugfs_create_file("port", 0600, rvu->rvu_dbg.mcs_tx, mcs,
   571					    &rvu_dbg_mcs_tx_port_stats_fops);
   572		}
   573	}
   574	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
