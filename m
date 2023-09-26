Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481A67AF4FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjIZUY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjIZUYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:24:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F1011D;
        Tue, 26 Sep 2023 13:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695759888; x=1727295888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iz/QA/QRJh3/5tOMgpZTaVnisYFOlTx2dU19fiu2N1o=;
  b=Tm5xSHePM8luzZ8rEvYDxLTxwiSA2cDRnn3byJ6erF94rcW4FL3Egeui
   QtVW51SoOcqFlMdWjG46tgpOG66/Vr8RoCACizXpgEtp0CH2UdbJ3A2Qh
   NFsgttEIlRQkiib2Y6SWjIDl6FJCPboahpEh1Bm+uQ5mEYM9h/o8qIJvk
   tF7+sV5v/bS4etI09IvFcxYpwa50qiHvrxgXp4dlAiGHqEsXaBUKqNQ8l
   tt0AKv8m0a2GXyZEIkN8nYxG9VaCdToY0605WbUNBIojsYT6t0HLOWZDy
   MWK662/lHXUs7ItfvPe4uhqreq+wTLe0ExccMUGRiHCr+e9CYi0yNpqLJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384441080"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="384441080"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 13:24:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="814603088"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="814603088"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2023 13:24:32 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlEbe-0003Kl-1q;
        Tue, 26 Sep 2023 20:24:30 +0000
Date:   Wed, 27 Sep 2023 04:23:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, pkshih@realtek.com, larry.chiu@realtek.com,
        Justin Lai <justinlai0215@realtek.com>
Subject: Re: [PATCH net-next v8 12/13] net:ethernet:realtek: Update the
 Makefile and Kconfig in the realtek folder
Message-ID: <202309270412.RCn7zweU-lkp@intel.com>
References: <20230926114943.16340-13-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926114943.16340-13-justinlai0215@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Lai/net-ethernet-realtek-rtase-Add-pci-table-supported-in-this-module/20230926-195218
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230926114943.16340-13-justinlai0215%40realtek.com
patch subject: [PATCH net-next v8 12/13] net:ethernet:realtek: Update the Makefile and Kconfig in the realtek folder
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230927/202309270412.RCn7zweU-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230927/202309270412.RCn7zweU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309270412.RCn7zweU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/realtek/rtase/rtase_main.c:234:6: warning: no previous prototype for 'rtase_tx_clear' [-Wmissing-prototypes]
     234 | void rtase_tx_clear(struct rtase_private *tp)
         |      ^~~~~~~~~~~~~~
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:636:6: warning: no previous prototype for 'rtase_rx_clear' [-Wmissing-prototypes]
     636 | void rtase_rx_clear(struct rtase_private *tp)
         |      ^~~~~~~~~~~~~~
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:776:6: warning: no previous prototype for 'rtase_hw_set_rx_packet_filter' [-Wmissing-prototypes]
     776 | void rtase_hw_set_rx_packet_filter(struct net_device *dev)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:879:6: warning: no previous prototype for 'rtase_hw_reset' [-Wmissing-prototypes]
     879 | void rtase_hw_reset(const struct net_device *dev)
         |      ^~~~~~~~~~~~~~
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:1027:6: warning: no previous prototype for 'rtase_hw_start' [-Wmissing-prototypes]
    1027 | void rtase_hw_start(const struct net_device *dev)
         |      ^~~~~~~~~~~~~~
   drivers/net/ethernet/realtek/rtase/rtase_main.c: In function 'rtase_open':
>> drivers/net/ethernet/realtek/rtase/rtase_main.c:1140:25: warning: 'sprintf' argument 3 may overlap destination object 'dev' [-Wrestrict]
    1140 |                         sprintf((char *)&ivec->name, "%s_int%i", dev->name, i);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/realtek/rtase/rtase_main.c:1105:42: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
    1105 | static int rtase_open(struct net_device *dev)
         |                       ~~~~~~~~~~~~~~~~~~~^~~


vim +/rtase_tx_clear +234 drivers/net/ethernet/realtek/rtase/rtase_main.c

9a15ffa44557f94 Justin Lai 2023-09-26  233  
9a15ffa44557f94 Justin Lai 2023-09-26 @234  void rtase_tx_clear(struct rtase_private *tp)
9a15ffa44557f94 Justin Lai 2023-09-26  235  {
9a15ffa44557f94 Justin Lai 2023-09-26  236  	struct rtase_ring *ring;
9a15ffa44557f94 Justin Lai 2023-09-26  237  	u16 i;
9a15ffa44557f94 Justin Lai 2023-09-26  238  
9a15ffa44557f94 Justin Lai 2023-09-26  239  	for (i = 0; i < tp->func_tx_queue_num; i++) {
9a15ffa44557f94 Justin Lai 2023-09-26  240  		ring = &tp->tx_ring[i];
9a15ffa44557f94 Justin Lai 2023-09-26  241  		rtase_tx_clear_range(ring, ring->dirty_idx, NUM_DESC);
9a15ffa44557f94 Justin Lai 2023-09-26  242  		ring->cur_idx = 0;
9a15ffa44557f94 Justin Lai 2023-09-26  243  		ring->dirty_idx = 0;
9a15ffa44557f94 Justin Lai 2023-09-26  244  	}
9a15ffa44557f94 Justin Lai 2023-09-26  245  }
9a15ffa44557f94 Justin Lai 2023-09-26  246  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
