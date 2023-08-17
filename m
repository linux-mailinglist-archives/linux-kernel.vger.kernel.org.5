Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C05777F0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 08:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348319AbjHQGtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 02:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348316AbjHQGtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 02:49:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0B21FF3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 23:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692254953; x=1723790953;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pccFl1BewzWUrx+3IbCAJJ0Ktr4Amor3WOXX7UhPCog=;
  b=YA0ItH/a+OHZirFUiBN6TAmKwFBmtm/DX6VCk5XQ1vqMKeDldUoS3FgT
   u1fpTWx/3nKfCRA1G6tAiz78o0vu40zoHvyWjimyNR3fUdvPD45w0xGb+
   OiiR0E5FawLyRRvnHYdzwFJrci4KojFiLrE48PXkE5ZdN4VS6auh2GYVz
   RFxFNeNiDBnPXIhWzYGb+rhH5rO6O/0wXwhouWDmR8IbJ5ayTevqtCAs4
   QsJA4WaP5oX+7+uFy0k6CkqZmWY9dCcUQ9R1L+rsMOEJrVBSULOpRJ6D+
   NMUK+FlVJmfQdk/BMadiXAtEPuEJrh/LqfweGBM7hnFUg9MHssLPe8HxK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375495448"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="375495448"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 23:49:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="734548645"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="734548645"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Aug 2023 23:49:10 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWWof-0000s5-1f;
        Thu, 17 Aug 2023 06:49:09 +0000
Date:   Thu, 17 Aug 2023 14:48:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: drivers/i2c/busses/i2c-tegra.c:297: warning: Function parameter or
 member 'dma_dev' not described in 'tegra_i2c_dev'
Message-ID: <202308171413.orPN3iw6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: cdbf26251d3b35c4ccaea0c3a6de4318f727d3d2 i2c: tegra: Allocate DMA memory for DMA engine
date:   10 months ago
config: riscv-randconfig-r022-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171413.orPN3iw6-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171413.orPN3iw6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171413.orPN3iw6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-tegra.c:297: warning: Function parameter or member 'dma_dev' not described in 'tegra_i2c_dev'


vim +297 drivers/i2c/busses/i2c-tegra.c

6ad068ed63100f Laxman Dewangan     2012-08-19  228  
db811ca0f48578 Colin Cross         2011-02-20  229  /**
c990bbafdb11c6 Thierry Reding      2018-12-17  230   * struct tegra_i2c_dev - per device I2C context
db811ca0f48578 Colin Cross         2011-02-20  231   * @dev: device reference for power management
c990bbafdb11c6 Thierry Reding      2018-12-17  232   * @hw: Tegra I2C HW feature
c990bbafdb11c6 Thierry Reding      2018-12-17  233   * @adapter: core I2C layer adapter information
c990bbafdb11c6 Thierry Reding      2018-12-17  234   * @div_clk: clock reference for div clock of I2C controller
586a97d907ac34 Dmitry Osipenko     2020-09-30  235   * @clocks: array of I2C controller clocks
586a97d907ac34 Dmitry Osipenko     2020-09-30  236   * @nclocks: number of clocks in the array
0604ee4aefa20f Thierry Reding      2018-12-17  237   * @rst: reset control for the I2C controller
db811ca0f48578 Colin Cross         2011-02-20  238   * @base: ioremapped registers cookie
86c92b9965ff17 Sowjanya Komatineni 2019-02-12  239   * @base_phys: physical base address of the I2C controller
c990bbafdb11c6 Thierry Reding      2018-12-17  240   * @cont_id: I2C controller ID, used for packet header
c990bbafdb11c6 Thierry Reding      2018-12-17  241   * @irq: IRQ number of transfer complete interrupt
c990bbafdb11c6 Thierry Reding      2018-12-17  242   * @is_dvc: identifies the DVC I2C controller, has a different register layout
c73178b93754ed Thierry Reding      2019-06-07  243   * @is_vi: identifies the VI I2C controller, has a different register layout
db811ca0f48578 Colin Cross         2011-02-20  244   * @msg_complete: transfer completion notifier
db811ca0f48578 Colin Cross         2011-02-20  245   * @msg_err: error code for completed message
db811ca0f48578 Colin Cross         2011-02-20  246   * @msg_buf: pointer to current message data
db811ca0f48578 Colin Cross         2011-02-20  247   * @msg_buf_remaining: size of unsent data in the message buffer
94a5573f0719cf Dmitry Osipenko     2020-09-30  248   * @msg_read: indicates that the transfer is a read access
50665d58db052b Akhil R             2021-12-10  249   * @timings: i2c timings information like bus frequency
a99042e7d9fb5c Dmitry Osipenko     2020-09-30  250   * @multimaster_mode: indicates that I2C controller is in multi-master mode
86c92b9965ff17 Sowjanya Komatineni 2019-02-12  251   * @tx_dma_chan: DMA transmit channel
86c92b9965ff17 Sowjanya Komatineni 2019-02-12  252   * @rx_dma_chan: DMA receive channel
86c92b9965ff17 Sowjanya Komatineni 2019-02-12  253   * @dma_phys: handle to DMA resources
86c92b9965ff17 Sowjanya Komatineni 2019-02-12  254   * @dma_buf: pointer to allocated DMA buffer
86c92b9965ff17 Sowjanya Komatineni 2019-02-12  255   * @dma_buf_size: DMA buffer size
a99042e7d9fb5c Dmitry Osipenko     2020-09-30  256   * @dma_mode: indicates active DMA transfer
86c92b9965ff17 Sowjanya Komatineni 2019-02-12  257   * @dma_complete: DMA completion notifier
a99042e7d9fb5c Dmitry Osipenko     2020-09-30  258   * @atomic_mode: indicates active atomic transfer
db811ca0f48578 Colin Cross         2011-02-20  259   */
db811ca0f48578 Colin Cross         2011-02-20  260  struct tegra_i2c_dev {
db811ca0f48578 Colin Cross         2011-02-20  261  	struct device *dev;
db811ca0f48578 Colin Cross         2011-02-20  262  	struct i2c_adapter adapter;
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  263  
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  264  	const struct tegra_i2c_hw_feature *hw;
dda9d6a8262cb1 Stephen Warren      2013-11-06  265  	struct reset_control *rst;
f1c2ff98065dce Dmitry Osipenko     2020-09-30  266  	unsigned int cont_id;
f1c2ff98065dce Dmitry Osipenko     2020-09-30  267  	unsigned int irq;
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  268  
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  269  	phys_addr_t base_phys;
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  270  	void __iomem *base;
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  271  
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  272  	struct clk_bulk_data clocks[2];
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  273  	unsigned int nclocks;
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  274  
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  275  	struct clk *div_clk;
50665d58db052b Akhil R             2021-12-10  276  	struct i2c_timings timings;
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  277  
db811ca0f48578 Colin Cross         2011-02-20  278  	struct completion msg_complete;
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  279  	size_t msg_buf_remaining;
db811ca0f48578 Colin Cross         2011-02-20  280  	int msg_err;
db811ca0f48578 Colin Cross         2011-02-20  281  	u8 *msg_buf;
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  282  
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  283  	struct completion dma_complete;
86c92b9965ff17 Sowjanya Komatineni 2019-02-12  284  	struct dma_chan *tx_dma_chan;
86c92b9965ff17 Sowjanya Komatineni 2019-02-12  285  	struct dma_chan *rx_dma_chan;
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  286  	unsigned int dma_buf_size;
cdbf26251d3b35 Thierry Reding      2022-10-20  287  	struct device *dma_dev;
86c92b9965ff17 Sowjanya Komatineni 2019-02-12  288  	dma_addr_t dma_phys;
4be62340f3ce62 Dmitry Osipenko     2020-09-30  289  	void *dma_buf;
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  290  
a99042e7d9fb5c Dmitry Osipenko     2020-09-30  291  	bool multimaster_mode;
a99042e7d9fb5c Dmitry Osipenko     2020-09-30  292  	bool atomic_mode;
a99042e7d9fb5c Dmitry Osipenko     2020-09-30  293  	bool dma_mode;
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  294  	bool msg_read;
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  295  	bool is_dvc;
89e3748acd0bf6 Dmitry Osipenko     2020-09-30  296  	bool is_vi;
db811ca0f48578 Colin Cross         2011-02-20 @297  };
db811ca0f48578 Colin Cross         2011-02-20  298  

:::::: The code at line 297 was first introduced by commit
:::::: db811ca0f48578f9940f49f284ac81e336b264ad i2c: tegra: Add i2c support

:::::: TO: Colin Cross <ccross@android.com>
:::::: CC: Ben Dooks <ben-linux@fluff.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
