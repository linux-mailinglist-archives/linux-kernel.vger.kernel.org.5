Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1098804A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbjLEGhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344429AbjLEGhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:37:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF810136
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 22:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701758225; x=1733294225;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z7mcQP5twc2Q1+h2RBQFr9z+2yBUEmf4+3Gz4Au0aKs=;
  b=geqWMWmWknfguFyr6Oi7jYoEO/PqHbMBGc4xiSzBiULrI4w7YKL1MQWB
   Pzrc3blgV6mnQKOOvlozofnvOwZTkBWEbhiFACe7miBYOw4l/qjBYFPO3
   yYtS2dKrc/Dm6K1/8tPiVhFYBqe2MaOnlq44CoEt8CgBHJf3Np0bH9hYU
   cKOHYsb5z5qStFaYoOy76mewiy2xlPWV3sh5wf8zAkRAdhDDmh1RXT/ZI
   E/J+8WXpv+CT1i6WOJRTTNR+vehghjmpZnuPF7Tv5iTJD1WpE/bZ9YaCW
   yeDnZ3UKND5HXCpkPOjcU4c9V9xK0b8whEJ2Chkm3X5cAtKWDnqdYuai1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="374035360"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="374035360"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 22:37:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="764224098"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="764224098"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2023 22:37:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAP3F-0008RS-1M;
        Tue, 05 Dec 2023 06:37:01 +0000
Date:   Tue, 5 Dec 2023 14:36:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c:135:42:
 warning: '%d' directive output may be truncated writing between 1 and 10
 bytes into a region of size 7
Message-ID: <202312051441.oET2UCAw-lkp@intel.com>
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
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: b1dd9bf6ead81bfb910de1df3be74e9d176cae47 net: dpaa2-eth: export buffer pool info into a new debugfs file
date:   1 year, 1 month ago
config: x86_64-buildonly-randconfig-002-20231205 (https://download.01.org/0day-ci/archive/20231205/202312051441.oET2UCAw-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051441.oET2UCAw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051441.oET2UCAw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c: In function 'dpaa2_dbg_bp_show':
>> drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c:135:42: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 7 [-Wformat-truncation=]
     135 |   snprintf(ch_name, sizeof(ch_name), "CH#%d", i);
         |                                          ^~
   drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c:135:38: note: directive argument in the range [0, 2147483646]
     135 |   snprintf(ch_name, sizeof(ch_name), "CH#%d", i);
         |                                      ^~~~~~~
   drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c:135:3: note: 'snprintf' output between 5 and 14 bytes into a destination of size 10
     135 |   snprintf(ch_name, sizeof(ch_name), "CH#%d", i);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +135 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c

   121	
   122	static int dpaa2_dbg_bp_show(struct seq_file *file, void *offset)
   123	{
   124		struct dpaa2_eth_priv *priv = (struct dpaa2_eth_priv *)file->private;
   125		int i, j, num_queues, buf_cnt;
   126		struct dpaa2_eth_bp *bp;
   127		char ch_name[10];
   128		int err;
   129	
   130		/* Print out the header */
   131		seq_printf(file, "Buffer pool info for %s:\n", priv->net_dev->name);
   132		seq_printf(file, "%s  %10s%15s", "IDX", "BPID", "Buf count");
   133		num_queues = dpaa2_eth_queue_count(priv);
   134		for (i = 0; i < num_queues; i++) {
 > 135			snprintf(ch_name, sizeof(ch_name), "CH#%d", i);
   136			seq_printf(file, "%10s", ch_name);
   137		}
   138		seq_printf(file, "\n");
   139	
   140		/* For each buffer pool, print out its BPID, the number of buffers in
   141		 * that buffer pool and the channels which are using it.
   142		 */
   143		for (i = 0; i < priv->num_bps; i++) {
   144			bp = priv->bp[i];
   145	
   146			err = dpaa2_io_query_bp_count(NULL, bp->bpid, &buf_cnt);
   147			if (err) {
   148				netdev_warn(priv->net_dev, "Buffer count query error %d\n", err);
   149				return err;
   150			}
   151	
   152			seq_printf(file, "%3s%d%10d%15d", "BP#", i, bp->bpid, buf_cnt);
   153			for (j = 0; j < num_queues; j++) {
   154				if (priv->channel[j]->bp == bp)
   155					seq_printf(file, "%10s", "x");
   156				else
   157					seq_printf(file, "%10s", "");
   158			}
   159			seq_printf(file, "\n");
   160		}
   161	
   162		return 0;
   163	}
   164	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
