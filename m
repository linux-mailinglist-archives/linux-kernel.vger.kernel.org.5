Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A084A7CC88D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbjJQP4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbjJQPzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:55:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AD695;
        Tue, 17 Oct 2023 08:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697558148; x=1729094148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KvNF39DN5bsLz6aBPCxszPKohNzs0AOuRVPxH10s/7g=;
  b=DPACtJJL01iygb182SlAdZPD7dwyy3K5v3q723010iyYkd73uV56S+NE
   b0Nx1dF+qvRPpnxlJb/lc/ewd+ZYebkFTEvpG01oJUaU4arWJo8C0251c
   Nojta8cdjLtgJTnkGTn+x/mtRpWdEC20W4DaaZGD1+NB/orZ1iwgA/pr9
   +DKBHY8G60Fy/ieqvv+n5cGGobiuFmc38fXstIKKr3k1K6Funa+cFbXUc
   e6BP4V52v45v/s9v6LPVsdrQzltgzOMvUUKBvx2M9zyVzocuzPY+peZdJ
   IX8uza7OmhykX1eOBghYOHtOXOL0ftMd0zehKjs4uF830d6hYMYTxsFIg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="385651925"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="385651925"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 08:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="791271177"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="791271177"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Oct 2023 08:55:40 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsmPx-0009lt-2a;
        Tue, 17 Oct 2023 15:55:37 +0000
Date:   Tue, 17 Oct 2023 23:55:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vishvambar Panth S <vishvambarpanth.s@microchip.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jacob.e.keller@intel.com, kuba@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, bryan.whitehead@microchip.com,
        UNGLinuxDriver@microchip.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com
Subject: Re: [PATCH v2 net-next] net: microchip: lan743x: improve throughput
 with rx timestamp config
Message-ID: <202310172343.lfyTHDCw-lkp@intel.com>
References: <20231017180542.30613-1-vishvambarpanth.s@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017180542.30613-1-vishvambarpanth.s@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vishvambar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vishvambar-Panth-S/net-microchip-lan743x-improve-throughput-with-rx-timestamp-config/20231017-180453
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231017180542.30613-1-vishvambarpanth.s%40microchip.com
patch subject: [PATCH v2 net-next] net: microchip: lan743x: improve throughput with rx timestamp config
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310172343.lfyTHDCw-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172343.lfyTHDCw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172343.lfyTHDCw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/microchip/lan743x_main.c:1873:6: warning: no previous prototype for 'lan743x_rx_cfg_b_tstamp_config' [-Wmissing-prototypes]
    1873 | void lan743x_rx_cfg_b_tstamp_config(struct lan743x_adapter *adapter,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/lan743x_rx_cfg_b_tstamp_config +1873 drivers/net/ethernet/microchip/lan743x_main.c

  1872	
> 1873	void lan743x_rx_cfg_b_tstamp_config(struct lan743x_adapter *adapter,
  1874					    int rx_ts_config)
  1875	{
  1876		int channel_number;
  1877		int index;
  1878		u32 data;
  1879	
  1880		for (index = 0; index < LAN743X_USED_RX_CHANNELS; index++) {
  1881			channel_number = adapter->rx[index].channel_number;
  1882			data = lan743x_csr_read(adapter, RX_CFG_B(channel_number));
  1883			data &= RX_CFG_B_TS_MASK_;
  1884			data |= rx_ts_config;
  1885			lan743x_csr_write(adapter, RX_CFG_B(channel_number),
  1886					  data);
  1887		}
  1888	}
  1889	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
