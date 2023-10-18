Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A917CD239
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 04:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjJRCZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 22:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjJRCZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 22:25:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F22AB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 19:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697595902; x=1729131902;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7en9aZ7S4+2uPck8FlGzQZQ/GvTeGZtW/LkkI6LVpN4=;
  b=hKoIhDKOYDUFxuP767NKtz+2g7c0rnzK5rrSPpXWOiR5DVEHu7SNkhGD
   rC3oi0yIr9UpTfC8aAk15sNPj93L//7Y965zWqtvfIpeiF2H/FnjRgtEn
   hljX6uooY7QrJVI2EwcFlQdtpxpp7iY1M3uDMUqwI8yJA+v14J9mk03JP
   JCXuksNooaBNmQ6Gkp9NYh6k/ygBAkyxaA47NbZCDc2kfPgm28AA4AxP4
   6UvNFa8xFkD7Ca8Tza0mW3pIkrO5zST10nJC25e7wO61I3XjPGoAk90oX
   XMnZ8K1euPkBsqF0U5fUp83dr3cGC+0y2UYkAdiFPhjMi0TDNdpXBlIuX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384800788"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384800788"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 19:25:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="760039651"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="760039651"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 17 Oct 2023 19:25:00 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qswF0-000ANt-0w;
        Wed, 18 Oct 2023 02:24:58 +0000
Date:   Wed, 18 Oct 2023 10:24:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: drivers/i2c/busses/i2c-axxia.c:150: warning: Function parameter or
 member 'slave' not described in 'axxia_i2c_dev'
Message-ID: <202310181049.Vo62moV1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: e49560f02716839a74a7907200a589c1f990261b i2c: axxia: use 'struct' for kernel-doc notation
date:   9 months ago
config: x86_64-buildonly-randconfig-006-20230906 (https://download.01.org/0day-ci/archive/20231018/202310181049.Vo62moV1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181049.Vo62moV1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310181049.Vo62moV1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-axxia.c:150: warning: Function parameter or member 'slave' not described in 'axxia_i2c_dev'
>> drivers/i2c/busses/i2c-axxia.c:150: warning: Function parameter or member 'irq' not described in 'axxia_i2c_dev'
   drivers/i2c/busses/i2c-axxia.c:172: warning: Function parameter or member 'ns' not described in 'ns_to_clk'
   drivers/i2c/busses/i2c-axxia.c:172: warning: Function parameter or member 'clk_mhz' not described in 'ns_to_clk'
   drivers/i2c/busses/i2c-axxia.c:271: warning: Function parameter or member 'idev' not described in 'axxia_i2c_empty_rx_fifo'
   drivers/i2c/busses/i2c-axxia.c:303: warning: Function parameter or member 'idev' not described in 'axxia_i2c_fill_tx_fifo'


vim +150 drivers/i2c/busses/i2c-axxia.c

08678b850cd0c4 Anders Berg                             2014-10-03  119  
08678b850cd0c4 Anders Berg                             2014-10-03  120  /**
e49560f0271683 Randy Dunlap                            2023-01-12  121   * struct axxia_i2c_dev - I2C device context
08678b850cd0c4 Anders Berg                             2014-10-03  122   * @base: pointer to register struct
08678b850cd0c4 Anders Berg                             2014-10-03  123   * @msg: pointer to current message
3035a66934dadc Adamski, Krzysztof (Nokia - PL/Wroclaw  2018-12-13  124)  * @msg_r: pointer to current read message (sequence transfer)
3035a66934dadc Adamski, Krzysztof (Nokia - PL/Wroclaw  2018-12-13  125)  * @msg_xfrd: number of bytes transferred in tx_fifo
3035a66934dadc Adamski, Krzysztof (Nokia - PL/Wroclaw  2018-12-13  126)  * @msg_xfrd_r: number of bytes transferred in rx_fifo
08678b850cd0c4 Anders Berg                             2014-10-03  127   * @msg_err: error code for completed message
08678b850cd0c4 Anders Berg                             2014-10-03  128   * @msg_complete: xfer completion object
08678b850cd0c4 Anders Berg                             2014-10-03  129   * @dev: device reference
08678b850cd0c4 Anders Berg                             2014-10-03  130   * @adapter: core i2c abstraction
08678b850cd0c4 Anders Berg                             2014-10-03  131   * @i2c_clk: clock reference for i2c input clock
08678b850cd0c4 Anders Berg                             2014-10-03  132   * @bus_clk_rate: current i2c bus clock rate
530edb501ce476 Adamski, Krzysztof (Nokia - PL/Wroclaw  2019-03-28  133)  * @last: a flag indicating is this is last message in transfer
08678b850cd0c4 Anders Berg                             2014-10-03  134   */
08678b850cd0c4 Anders Berg                             2014-10-03  135  struct axxia_i2c_dev {
08678b850cd0c4 Anders Berg                             2014-10-03  136  	void __iomem *base;
08678b850cd0c4 Anders Berg                             2014-10-03  137  	struct i2c_msg *msg;
3035a66934dadc Adamski, Krzysztof (Nokia - PL/Wroclaw  2018-12-13  138) 	struct i2c_msg *msg_r;
08678b850cd0c4 Anders Berg                             2014-10-03  139  	size_t msg_xfrd;
3035a66934dadc Adamski, Krzysztof (Nokia - PL/Wroclaw  2018-12-13  140) 	size_t msg_xfrd_r;
08678b850cd0c4 Anders Berg                             2014-10-03  141  	int msg_err;
08678b850cd0c4 Anders Berg                             2014-10-03  142  	struct completion msg_complete;
08678b850cd0c4 Anders Berg                             2014-10-03  143  	struct device *dev;
08678b850cd0c4 Anders Berg                             2014-10-03  144  	struct i2c_adapter adapter;
08678b850cd0c4 Anders Berg                             2014-10-03  145  	struct clk *i2c_clk;
08678b850cd0c4 Anders Berg                             2014-10-03  146  	u32 bus_clk_rate;
530edb501ce476 Adamski, Krzysztof (Nokia - PL/Wroclaw  2019-03-28  147) 	bool last;
f0b576801d83ce Adamski, Krzysztof (Nokia - PL/Wroclaw  2019-08-19  148) 	struct i2c_client *slave;
f0b576801d83ce Adamski, Krzysztof (Nokia - PL/Wroclaw  2019-08-19  149) 	int irq;
08678b850cd0c4 Anders Berg                             2014-10-03 @150  };
08678b850cd0c4 Anders Berg                             2014-10-03  151  

:::::: The code at line 150 was first introduced by commit
:::::: 08678b850cd0c49cc49c7fed0c93f720f85368e8 i2c: axxia: Add I2C driver for AXM55xx

:::::: TO: Anders Berg <anders.berg@avagotech.com>
:::::: CC: Wolfram Sang <wsa@the-dreams.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
