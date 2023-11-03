Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448B77E0751
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377670AbjKCRUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377348AbjKCRU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:20:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081EE134
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699032022; x=1730568022;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ejvdbfSEo7Ye5TjfsNgbN/I8T2uSWDIQWUd/UB8L5x8=;
  b=XSOQxKDC8IbHws4spE7CH3PzJI8FfJFNd3XTypyYrhJkPHdz974m9Bjn
   BI6Jo5N+2ymo2kf/rttTWHNb3TTF5NPoar/4GZi1vNOmD0xME7doSczjI
   uHUuxhwk92fN/+jaK/rpXR2J0vaL/GysBq7eq+l2fmgn++k8OUGypuCXo
   h5c4ggnt0rAAPDFKSkhNUWRSzKeYazfIqoYSPz1+hPamsBbDtfMVDZU4t
   BIzTHWXelyCZYXuCJSXCYmOniUvqsXQuMUzP1/WJqHNPEukTHA/+YlHrh
   3piHaEnirwyEsrkdUZRTjvg7WgfviS1NkeaU/Z2Qv5Aud/oZ9OqDZSIVC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="391855877"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="391855877"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 10:20:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1093126725"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="1093126725"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Nov 2023 10:20:19 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyxqD-0002kf-13;
        Fri, 03 Nov 2023 17:20:17 +0000
Date:   Sat, 4 Nov 2023 01:19:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thierry Reding <treding@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: drivers/i2c/busses/i2c-tegra.c:297: warning: Function parameter or
 member 'dma_dev' not described in 'tegra_i2c_dev'
Message-ID: <202311040140.VjgAOuvJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f6f76a6a29f36d2f3e4510d0bde5046672f6924
commit: cdbf26251d3b35c4ccaea0c3a6de4318f727d3d2 i2c: tegra: Allocate DMA memory for DMA engine
date:   1 year ago
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040140.VjgAOuvJ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040140.VjgAOuvJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040140.VjgAOuvJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-tegra.c:297: warning: Function parameter or member 'dma_dev' not described in 'tegra_i2c_dev'


vim +297 drivers/i2c/busses/i2c-tegra.c

6ad068ed63100f1 Laxman Dewangan     2012-08-19  228  
db811ca0f48578f Colin Cross         2011-02-20  229  /**
c990bbafdb11c60 Thierry Reding      2018-12-17  230   * struct tegra_i2c_dev - per device I2C context
db811ca0f48578f Colin Cross         2011-02-20  231   * @dev: device reference for power management
c990bbafdb11c60 Thierry Reding      2018-12-17  232   * @hw: Tegra I2C HW feature
c990bbafdb11c60 Thierry Reding      2018-12-17  233   * @adapter: core I2C layer adapter information
c990bbafdb11c60 Thierry Reding      2018-12-17  234   * @div_clk: clock reference for div clock of I2C controller
586a97d907ac348 Dmitry Osipenko     2020-09-30  235   * @clocks: array of I2C controller clocks
586a97d907ac348 Dmitry Osipenko     2020-09-30  236   * @nclocks: number of clocks in the array
0604ee4aefa20f4 Thierry Reding      2018-12-17  237   * @rst: reset control for the I2C controller
db811ca0f48578f Colin Cross         2011-02-20  238   * @base: ioremapped registers cookie
86c92b9965ff175 Sowjanya Komatineni 2019-02-12  239   * @base_phys: physical base address of the I2C controller
c990bbafdb11c60 Thierry Reding      2018-12-17  240   * @cont_id: I2C controller ID, used for packet header
c990bbafdb11c60 Thierry Reding      2018-12-17  241   * @irq: IRQ number of transfer complete interrupt
c990bbafdb11c60 Thierry Reding      2018-12-17  242   * @is_dvc: identifies the DVC I2C controller, has a different register layout
c73178b93754edd Thierry Reding      2019-06-07  243   * @is_vi: identifies the VI I2C controller, has a different register layout
db811ca0f48578f Colin Cross         2011-02-20  244   * @msg_complete: transfer completion notifier
db811ca0f48578f Colin Cross         2011-02-20  245   * @msg_err: error code for completed message
db811ca0f48578f Colin Cross         2011-02-20  246   * @msg_buf: pointer to current message data
db811ca0f48578f Colin Cross         2011-02-20  247   * @msg_buf_remaining: size of unsent data in the message buffer
94a5573f0719cf8 Dmitry Osipenko     2020-09-30  248   * @msg_read: indicates that the transfer is a read access
50665d58db052b0 Akhil R             2021-12-10  249   * @timings: i2c timings information like bus frequency
a99042e7d9fb5c9 Dmitry Osipenko     2020-09-30  250   * @multimaster_mode: indicates that I2C controller is in multi-master mode
86c92b9965ff175 Sowjanya Komatineni 2019-02-12  251   * @tx_dma_chan: DMA transmit channel
86c92b9965ff175 Sowjanya Komatineni 2019-02-12  252   * @rx_dma_chan: DMA receive channel
86c92b9965ff175 Sowjanya Komatineni 2019-02-12  253   * @dma_phys: handle to DMA resources
86c92b9965ff175 Sowjanya Komatineni 2019-02-12  254   * @dma_buf: pointer to allocated DMA buffer
86c92b9965ff175 Sowjanya Komatineni 2019-02-12  255   * @dma_buf_size: DMA buffer size
a99042e7d9fb5c9 Dmitry Osipenko     2020-09-30  256   * @dma_mode: indicates active DMA transfer
86c92b9965ff175 Sowjanya Komatineni 2019-02-12  257   * @dma_complete: DMA completion notifier
a99042e7d9fb5c9 Dmitry Osipenko     2020-09-30  258   * @atomic_mode: indicates active atomic transfer
db811ca0f48578f Colin Cross         2011-02-20  259   */
db811ca0f48578f Colin Cross         2011-02-20  260  struct tegra_i2c_dev {
db811ca0f48578f Colin Cross         2011-02-20  261  	struct device *dev;
db811ca0f48578f Colin Cross         2011-02-20  262  	struct i2c_adapter adapter;
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  263  
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  264  	const struct tegra_i2c_hw_feature *hw;
dda9d6a8262cb1f Stephen Warren      2013-11-06  265  	struct reset_control *rst;
f1c2ff98065dced Dmitry Osipenko     2020-09-30  266  	unsigned int cont_id;
f1c2ff98065dced Dmitry Osipenko     2020-09-30  267  	unsigned int irq;
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  268  
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  269  	phys_addr_t base_phys;
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  270  	void __iomem *base;
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  271  
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  272  	struct clk_bulk_data clocks[2];
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  273  	unsigned int nclocks;
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  274  
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  275  	struct clk *div_clk;
50665d58db052b0 Akhil R             2021-12-10  276  	struct i2c_timings timings;
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  277  
db811ca0f48578f Colin Cross         2011-02-20  278  	struct completion msg_complete;
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  279  	size_t msg_buf_remaining;
db811ca0f48578f Colin Cross         2011-02-20  280  	int msg_err;
db811ca0f48578f Colin Cross         2011-02-20  281  	u8 *msg_buf;
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  282  
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  283  	struct completion dma_complete;
86c92b9965ff175 Sowjanya Komatineni 2019-02-12  284  	struct dma_chan *tx_dma_chan;
86c92b9965ff175 Sowjanya Komatineni 2019-02-12  285  	struct dma_chan *rx_dma_chan;
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  286  	unsigned int dma_buf_size;
cdbf26251d3b35c Thierry Reding      2022-10-20  287  	struct device *dma_dev;
86c92b9965ff175 Sowjanya Komatineni 2019-02-12  288  	dma_addr_t dma_phys;
4be62340f3ce62b Dmitry Osipenko     2020-09-30  289  	void *dma_buf;
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  290  
a99042e7d9fb5c9 Dmitry Osipenko     2020-09-30  291  	bool multimaster_mode;
a99042e7d9fb5c9 Dmitry Osipenko     2020-09-30  292  	bool atomic_mode;
a99042e7d9fb5c9 Dmitry Osipenko     2020-09-30  293  	bool dma_mode;
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  294  	bool msg_read;
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  295  	bool is_dvc;
89e3748acd0bf65 Dmitry Osipenko     2020-09-30  296  	bool is_vi;
db811ca0f48578f Colin Cross         2011-02-20 @297  };
db811ca0f48578f Colin Cross         2011-02-20  298  

:::::: The code at line 297 was first introduced by commit
:::::: db811ca0f48578f9940f49f284ac81e336b264ad i2c: tegra: Add i2c support

:::::: TO: Colin Cross <ccross@android.com>
:::::: CC: Ben Dooks <ben-linux@fluff.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
