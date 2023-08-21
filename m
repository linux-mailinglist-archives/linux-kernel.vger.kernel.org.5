Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A8F78349D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjHUVHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHUVHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:07:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60E511C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692652049; x=1724188049;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y4ms5ktb/CMeFkV2h7UxjjgJTX5Qm+SU0EhuHx6jOfQ=;
  b=fZ5t8oiauO7uX7SvlXDUdODPS7paSSt7VqDWZgPnKlr2uZ0KzErqV70f
   dYGDQglL/I+O4P/spMYj4P6R0M5OiJ8eOncBNSRQLb/4lrsqG1qocrU1p
   jPzJaK//ACsgycX4mKQwfyl24bPaJ8DadBXPknvPQcAM+iGP5KbYaBRpU
   RHA836AFVoxhYxA7DvWpLOpHA48l7+MPvhkPXVPgAju/6li/RfdZiqwky
   6dEa2yt0Y/mXxPDM0bSzGSehzVw4GqSEXaF8LoSlzcJkMHtI9P9hXM/Qs
   N0lJAVwbcS7o6ypQq228l05QouVNRvojey3Ep7dZBAzbytPi1MMZzg4sB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353275421"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="353275421"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 14:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="909846002"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="909846002"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Aug 2023 14:07:27 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYC7S-0000vY-2O;
        Mon, 21 Aug 2023 21:07:26 +0000
Date:   Tue, 22 Aug 2023 05:07:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/at_hdmac.c:240: warning: Function parameter or member
 'sglen' not described in 'at_desc'
Message-ID: <202308220538.UNfyRiI2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f7757129e3dea336c407551c98f50057c22bb266
commit: ac803b56860f6506c55a3c9330007837e3f4edda dmaengine: at_hdmac: Convert driver to use virt-dma
date:   9 months ago
config: arm-randconfig-r003-20230821 (https://download.01.org/0day-ci/archive/20230822/202308220538.UNfyRiI2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308220538.UNfyRiI2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308220538.UNfyRiI2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'sglen' not described in 'at_desc'
   drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'boundary' not described in 'at_desc'
   drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'dst_hole' not described in 'at_desc'
   drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'src_hole' not described in 'at_desc'
   drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'memset_buffer' not described in 'at_desc'
   drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'memset_paddr' not described in 'at_desc'
   drivers/dma/at_hdmac.c:240: warning: Function parameter or member 'memset_vaddr' not described in 'at_desc'
   drivers/dma/at_hdmac.c:249: warning: cannot understand function prototype: 'enum atc_status '
>> drivers/dma/at_hdmac.c:284: warning: Function parameter or member 'cyclic' not described in 'at_dma_chan'
   drivers/dma/at_hdmac.c:348: warning: Function parameter or member 'regs' not described in 'at_dma'
   drivers/dma/at_hdmac.c:348: warning: Function parameter or member 'memset_pool' not described in 'at_dma'


vim +240 drivers/dma/at_hdmac.c

ac803b56860f65 Tudor Ambarus 2022-10-25  216  
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  217  /**
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  218   * struct at_desc - software descriptor
ac803b56860f65 Tudor Ambarus 2022-10-25  219   * @vd: pointer to the virtual dma descriptor.
ac803b56860f65 Tudor Ambarus 2022-10-25  220   * @atchan: pointer to the atmel dma channel.
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  221   * @total_len: total transaction byte count
ac803b56860f65 Tudor Ambarus 2022-10-25  222   * @sg_len: number of sg entries.
ac803b56860f65 Tudor Ambarus 2022-10-25  223   * @sg: array of sgs.
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  224   */
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  225  struct at_desc {
ac803b56860f65 Tudor Ambarus 2022-10-25  226  	struct				virt_dma_desc vd;
ac803b56860f65 Tudor Ambarus 2022-10-25  227  	struct				at_dma_chan *atchan;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  228  	size_t				total_len;
ac803b56860f65 Tudor Ambarus 2022-10-25  229  	unsigned int			sglen;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  230  	/* Interleaved data */
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  231  	size_t				boundary;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  232  	size_t				dst_hole;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  233  	size_t				src_hole;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  234  
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  235  	/* Memset temporary buffer */
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  236  	bool				memset_buffer;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  237  	dma_addr_t			memset_paddr;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  238  	int				*memset_vaddr;
ac803b56860f65 Tudor Ambarus 2022-10-25  239  	struct atdma_sg			sg[];
5cecadc3e2a4fb Tudor Ambarus 2022-10-25 @240  };
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  241  
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  242  /*--  Channels  --------------------------------------------------------*/
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  243  
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  244  /**
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  245   * atc_status - information bits stored in channel status flag
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  246   *
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  247   * Manipulated with atomic operations.
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  248   */
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  249  enum atc_status {
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  250  	ATC_IS_PAUSED = 1,
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  251  	ATC_IS_CYCLIC = 24,
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  252  };
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  253  
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  254  /**
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  255   * struct at_dma_chan - internal representation of an Atmel HDMAC channel
ac803b56860f65 Tudor Ambarus 2022-10-25  256   * @vc: virtual dma channel entry.
ac803b56860f65 Tudor Ambarus 2022-10-25  257   * @atdma: pointer to the driver data.
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  258   * @ch_regs: memory mapped register base
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  259   * @mask: channel index in a mask
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  260   * @per_if: peripheral interface
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  261   * @mem_if: memory interface
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  262   * @status: transmit status information from irq/prep* functions
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  263   *                to tasklet (use atomic operations)
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  264   * @save_cfg: configuration register that is saved on suspend/resume cycle
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  265   * @save_dscr: for cyclic operations, preserve next descriptor address in
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  266   *             the cyclic list on suspend/resume cycle
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  267   * @dma_sconfig: configuration for slave transfers, passed via
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  268   * .device_config
ac803b56860f65 Tudor Ambarus 2022-10-25  269   * @desc: pointer to the atmel dma descriptor.
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  270   */
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  271  struct at_dma_chan {
ac803b56860f65 Tudor Ambarus 2022-10-25  272  	struct virt_dma_chan	vc;
ac803b56860f65 Tudor Ambarus 2022-10-25  273  	struct at_dma		*atdma;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  274  	void __iomem		*ch_regs;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  275  	u8			mask;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  276  	u8			per_if;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  277  	u8			mem_if;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  278  	unsigned long		status;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  279  	u32			save_cfg;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  280  	u32			save_dscr;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  281  	struct dma_slave_config	dma_sconfig;
ac803b56860f65 Tudor Ambarus 2022-10-25  282  	bool			cyclic;
ac803b56860f65 Tudor Ambarus 2022-10-25  283  	struct at_desc		*desc;
5cecadc3e2a4fb Tudor Ambarus 2022-10-25 @284  };
5cecadc3e2a4fb Tudor Ambarus 2022-10-25  285  

:::::: The code at line 240 was first introduced by commit
:::::: 5cecadc3e2a4fb72ab37d9420df0a9e1179b8a3e dmaengine: at_hdmac: Keep register definitions and structures private to at_hdmac.c

:::::: TO: Tudor Ambarus <tudor.ambarus@microchip.com>
:::::: CC: Vinod Koul <vkoul@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
