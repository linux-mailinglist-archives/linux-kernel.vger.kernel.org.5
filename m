Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B240B77F18B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348639AbjHQHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348636AbjHQHyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:54:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FD71982
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692258882; x=1723794882;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JjqfJzbjuYdRYPECagrfG7wvT+iC8uA0V847U6jle+w=;
  b=YwoTdHTjwDTZjt5ntl8v3mA2rOqbgft5PvfANdllL/lfQKMMOGatIvFt
   kud75XUBJQeco0SUDtFjGQEZNIvI0FWxFFMLnNh8lTJ0XawpfaDGqTyOI
   XC7LCwaQBen7qjd0P5ocIyMM0mU6ambjpvSxjO4TDxhBu5sQyPcoide+K
   0v/G8mvTgg+kKcrOeBzWHyAuGL7KmsepIk4SuUnCwaUc0RU7Y06EwiMJ2
   tXs+Kq0ofIvxLvSyS2MTUNq5wxp9u2U/M8bEEOiZdTL5nXhm5BEBzgqnj
   8efQM9ECzRN3gESPJEz4VSeTjho5370Y0DW4lM6dTzcDHiojPKDb8zskb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357707711"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="357707711"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:54:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711435491"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="711435491"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2023 00:54:39 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWXq3-0000v7-08;
        Thu, 17 Aug 2023 07:54:39 +0000
Date:   Thu, 17 Aug 2023 15:54:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: drivers/i2c/busses/i2c-cadence.c:218: warning: Function parameter or
 member 'rinfo' not described in 'cdns_i2c'
Message-ID: <202308171510.bKHBcZQW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 58b924241d0a23eee8e86dd9e6f5dacd01c82e62 i2c: cadence: Add standard bus recovery support
date:   11 months ago
config: riscv-randconfig-r002-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171510.bKHBcZQW-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171510.bKHBcZQW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171510.bKHBcZQW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-cadence.c:218: warning: Function parameter or member 'rinfo' not described in 'cdns_i2c'


vim +218 drivers/i2c/busses/i2c-cadence.c

1a351b10b9671f Radu Pirea           2020-01-06  163  
df8eb5691c48d3 Soren Brinkmann      2014-04-04  164  /**
df8eb5691c48d3 Soren Brinkmann      2014-04-04  165   * struct cdns_i2c - I2C device private data structure
30e31a1fbc1fc0 Shubhrajyoti Datta   2016-03-07  166   *
30e31a1fbc1fc0 Shubhrajyoti Datta   2016-03-07  167   * @dev:		Pointer to device structure
df8eb5691c48d3 Soren Brinkmann      2014-04-04  168   * @membase:		Base address of the I2C device
df8eb5691c48d3 Soren Brinkmann      2014-04-04  169   * @adap:		I2C adapter instance
df8eb5691c48d3 Soren Brinkmann      2014-04-04  170   * @p_msg:		Message pointer
df8eb5691c48d3 Soren Brinkmann      2014-04-04  171   * @err_status:		Error status in Interrupt Status Register
df8eb5691c48d3 Soren Brinkmann      2014-04-04  172   * @xfer_done:		Transfer complete status
df8eb5691c48d3 Soren Brinkmann      2014-04-04  173   * @p_send_buf:		Pointer to transmit buffer
df8eb5691c48d3 Soren Brinkmann      2014-04-04  174   * @p_recv_buf:		Pointer to receive buffer
df8eb5691c48d3 Soren Brinkmann      2014-04-04  175   * @send_count:		Number of bytes still expected to send
df8eb5691c48d3 Soren Brinkmann      2014-04-04  176   * @recv_count:		Number of bytes still expected to receive
9fae82e1acda8d Harini Katakam       2014-12-12  177   * @curr_recv_count:	Number of bytes to be received in current transfer
df8eb5691c48d3 Soren Brinkmann      2014-04-04  178   * @irq:		IRQ number
df8eb5691c48d3 Soren Brinkmann      2014-04-04  179   * @input_clk:		Input clock to I2C controller
df8eb5691c48d3 Soren Brinkmann      2014-04-04  180   * @i2c_clk:		Maximum I2C clock speed
df8eb5691c48d3 Soren Brinkmann      2014-04-04  181   * @bus_hold_flag:	Flag used in repeated start for clearing HOLD bit
df8eb5691c48d3 Soren Brinkmann      2014-04-04  182   * @clk:		Pointer to struct clk
df8eb5691c48d3 Soren Brinkmann      2014-04-04  183   * @clk_rate_change_nb:	Notifier block for clock rate changes
63cab195bf4986 Anurag Kumar Vulisha 2015-07-10  184   * @quirks:		flag for broken hold bit usage in r1p10
8b51a8e64443b9 Shubhrajyoti Datta   2021-07-13  185   * @ctrl_reg:		Cached value of the control register.
1a351b10b9671f Radu Pirea           2020-01-06  186   * @ctrl_reg_diva_divb: value of fields DIV_A and DIV_B from CR register
1a351b10b9671f Radu Pirea           2020-01-06  187   * @slave:		Registered slave instance.
1a351b10b9671f Radu Pirea           2020-01-06  188   * @dev_mode:		I2C operating role(master/slave).
1a351b10b9671f Radu Pirea           2020-01-06  189   * @slave_state:	I2C Slave state(idle/read/write).
df8eb5691c48d3 Soren Brinkmann      2014-04-04  190   */
df8eb5691c48d3 Soren Brinkmann      2014-04-04  191  struct cdns_i2c {
7fa32329ca0314 Shubhrajyoti Datta   2015-11-24  192  	struct device		*dev;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  193  	void __iomem *membase;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  194  	struct i2c_adapter adap;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  195  	struct i2c_msg *p_msg;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  196  	int err_status;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  197  	struct completion xfer_done;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  198  	unsigned char *p_send_buf;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  199  	unsigned char *p_recv_buf;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  200  	unsigned int send_count;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  201  	unsigned int recv_count;
9fae82e1acda8d Harini Katakam       2014-12-12  202  	unsigned int curr_recv_count;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  203  	int irq;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  204  	unsigned long input_clk;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  205  	unsigned int i2c_clk;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  206  	unsigned int bus_hold_flag;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  207  	struct clk *clk;
df8eb5691c48d3 Soren Brinkmann      2014-04-04  208  	struct notifier_block clk_rate_change_nb;
63cab195bf4986 Anurag Kumar Vulisha 2015-07-10  209  	u32 quirks;
8b51a8e64443b9 Shubhrajyoti Datta   2021-07-13  210  	u32 ctrl_reg;
58b924241d0a23 Shubhrajyoti Datta   2022-07-28  211  	struct i2c_bus_recovery_info rinfo;
1a351b10b9671f Radu Pirea           2020-01-06  212  #if IS_ENABLED(CONFIG_I2C_SLAVE)
1a351b10b9671f Radu Pirea           2020-01-06  213  	u16 ctrl_reg_diva_divb;
1a351b10b9671f Radu Pirea           2020-01-06  214  	struct i2c_client *slave;
1a351b10b9671f Radu Pirea           2020-01-06  215  	enum cdns_i2c_mode dev_mode;
1a351b10b9671f Radu Pirea           2020-01-06  216  	enum cdns_i2c_slave_state slave_state;
1a351b10b9671f Radu Pirea           2020-01-06  217  #endif
63cab195bf4986 Anurag Kumar Vulisha 2015-07-10 @218  };
63cab195bf4986 Anurag Kumar Vulisha 2015-07-10  219  

:::::: The code at line 218 was first introduced by commit
:::::: 63cab195bf498676619951e81ad5791e9d47c420 i2c: removed work arounds in i2c driver for Zynq Ultrascale+ MPSoC

:::::: TO: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
:::::: CC: Wolfram Sang <wsa@the-dreams.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
