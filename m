Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D99B7E29EC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjKFQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjKFQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:37:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849531BF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699288643; x=1730824643;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fjgTk/51mLg0fX3unJqNcugBnjE5sDnTkD80glau2iM=;
  b=SIUUgQaTuQGt7fvL5Ha4zc1Mwk3OgJY1r0JbBNPXXkStMMTzStugPGDX
   BxM43tRo3s/Hc3dl/5OF6BrER1Z2rYpGzWWL06sn5avYegG+lv79kze3w
   3uq9F2gUzQJnV4dFzqPPV3G8rsm/qOshTRyxVtzkBHCtsaXyfrOPByzUC
   N6/6uSpNDPD3505+a3xQHgpat+tLpPGXBLlXeZ47s88w7wiI4Hr6tTu36
   4PeVZssSGdTyP8b+4WZ7hbOAkW6H1Fg2nsDnv9jrr15SrBKNUECFHjLB+
   nZK06hmycKCQQPJBEkhHCd+UHVQspuzvJ7qGW/Oe8bVTtjgchlOlv9DCR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="392182494"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="392182494"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 08:37:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="906104706"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="906104706"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Nov 2023 08:37:00 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r02aw-0006Z4-0K;
        Mon, 06 Nov 2023 16:36:58 +0000
Date:   Tue, 7 Nov 2023 00:36:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: drivers/net/ethernet/ti/cpsw_ethtool.c:244:21: warning: ': '
 directive output may be truncated writing 2 bytes into a region of size
 between 1 and 19
Message-ID: <202311070051.jj6o85Vg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: c24eef283a23b85cbd755265539dc4dbe3fee949 net: ethernet: ti: cpsw: move ethtool func in separate file
date:   4 years, 6 months ago
config: x86_64-buildonly-randconfig-006-20230915 (https://download.01.org/0day-ci/archive/20231107/202311070051.jj6o85Vg-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311070051.jj6o85Vg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311070051.jj6o85Vg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/ti/cpsw_ethtool.c: In function 'cpsw_add_ch_strings':
>> drivers/net/ethernet/ti/cpsw_ethtool.c:244:21: warning: ': ' directive output may be truncated writing 2 bytes into a region of size between 1 and 19 [-Wformat-truncation=]
        "%s DMA chan %ld: %s", rx_dir ? "Rx" : "Tx",
                        ^~
   drivers/net/ethernet/ti/cpsw_ethtool.c:243:3: note: 'snprintf' output 16 or more bytes (assuming 34) into a destination of size 32
      snprintf(*p, ETH_GSTRING_LEN,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        "%s DMA chan %ld: %s", rx_dir ? "Rx" : "Tx",
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        (long)(i / CPSW_STATS_CH_LEN),
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        cpsw_gstrings_ch_stats[line].stat_string);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +244 drivers/net/ethernet/ti/cpsw_ethtool.c

   233	
   234	static void cpsw_add_ch_strings(u8 **p, int ch_num, int rx_dir)
   235	{
   236		int ch_stats_len;
   237		int line;
   238		int i;
   239	
   240		ch_stats_len = CPSW_STATS_CH_LEN * ch_num;
   241		for (i = 0; i < ch_stats_len; i++) {
   242			line = i % CPSW_STATS_CH_LEN;
   243			snprintf(*p, ETH_GSTRING_LEN,
 > 244				 "%s DMA chan %ld: %s", rx_dir ? "Rx" : "Tx",
   245				 (long)(i / CPSW_STATS_CH_LEN),
   246				 cpsw_gstrings_ch_stats[line].stat_string);
   247			*p += ETH_GSTRING_LEN;
   248		}
   249	}
   250	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
