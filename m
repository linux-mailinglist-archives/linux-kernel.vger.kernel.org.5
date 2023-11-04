Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B2A7E0F3C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 12:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjKDLs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 07:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjKDLs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 07:48:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB7EAD
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699098535; x=1730634535;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xS3FTJ90QAKgDzcV+OZDIlWpFbssrgAMTTv3AR+zXSA=;
  b=IfKUq7Fk2Y3h3dv2VhPlc3EnNZlVeJs00Fc4HQRZXvxHatK4nnAErjXV
   xrBrB6eB0K03VfW93ZMWvv0zKgPxPfwISPL7e0V4QSGSkGVLImVRJdLHg
   1aqsR/bgoD9uZK5vfFTIi2kbNSiw5TQRc7GzlupmHG/1ULiAn1S1cIUu6
   UDuRCA7H2/RQYzJ0+kH27FCUFE5BZhejPFNDO7ueS0Vai+WJYueLhvxwg
   TFQ0FEVlCZmEio4oc4Sr71zvIJoT9g7vCyUda5AbcXcz/HEiTDXyEMCt3
   /O5xVyMvghrizSpvlu0D+PNzSntPAxzVNtDiD37Af1Z2bxQe7scK2i1hQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="10615224"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="10615224"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 04:48:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,277,1694761200"; 
   d="scan'208";a="9997434"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Nov 2023 04:48:54 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzF91-0004Id-1d;
        Sat, 04 Nov 2023 11:48:51 +0000
Date:   Sat, 4 Nov 2023 19:48:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geetha sowjanya <gakula@marvell.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sunil Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>
Subject: drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c:535:36:
 warning: '%d' directive writing between 1 and 11 bytes into a region of size
 7
Message-ID: <202311041952.XgfdAuan-lkp@intel.com>
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

Hi Geetha,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90b0c2b2edd1adff742c621e246562fbefa11b70
commit: d06c2aba51631bf6cd32a2f8f1edd67c110ade8a octeontx2-af: cn10k: mcs: Add debugfs support
date:   1 year, 1 month ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231104/202311041952.XgfdAuan-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311041952.XgfdAuan-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311041952.XgfdAuan-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c: In function 'rvu_dbg_mcs_init':
>> drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c:535:36: warning: '%d' directive writing between 1 and 11 bytes into a region of size 7 [-Wformat-overflow=]
     535 |                 sprintf(dname, "mcs%d", i);
         |                                    ^~
   drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c:535:32: note: directive argument in the range [-2147483641, 2147483646]
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
