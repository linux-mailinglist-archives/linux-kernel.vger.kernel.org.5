Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC2C7BB66F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjJFLaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjJFLah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:30:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25EECA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696591836; x=1728127836;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OIFOXyHqZsilKi5jbVZWnqdrR0vwq3pTqM7uhFNVFNY=;
  b=IOYwQsxXL9Recyjd0iEDMH29lbQ8RYtEqU/fPcFMwPkBlwjMXSXrcQM4
   CKm4O6qICeVcSSUcYVCO2iUkdeFshwwNumuA3CZ4K1Kf9P+gXkb4ZDjLs
   OYr1Efoar89bzNLAA4nVPT8PyS5uUTTw7x9FdmmjF5WZUbhV0i9vdoVHG
   HQ2Q0l+encc8LJQmW/9KSuM+vmladJo7+lH86bvom5Af7nyJn0XorTkq1
   2IRAzL6Zkn43jdUoRdjbm60/OdYdu+TJtA3MJpbKi2Nbew6Ok/aYrHLhw
   OS84tVmjb3Hw2xo3jrpTsXZFxkJpJ9iX+F52X/VCwvfwUP3Irl0zDSJ1F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2336684"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="2336684"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 04:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875911091"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="875911091"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Oct 2023 04:30:34 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoj2N-000MYG-2f;
        Fri, 06 Oct 2023 11:30:31 +0000
Date:   Fri, 6 Oct 2023 19:29:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: drivers/mtd/nand/raw/rockchip-nand-controller.c:112: warning: Cannot
 understand  * @type: NFC version
Message-ID: <202310061916.ept7QOrX-lkp@intel.com>
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
head:   b78b18fb8ee19f7a05f20c3abc865b3bfe182884
commit: 058e0e847d54944c5dc9ec6d29727e1449feb131 mtd: rawnand: rockchip: NFC driver for RK3308, RK2928 and others
date:   2 years, 10 months ago
config: arm-randconfig-003-20230918 (https://download.01.org/0day-ci/archive/20231006/202310061916.ept7QOrX-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310061916.ept7QOrX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310061916.ept7QOrX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/raw/rockchip-nand-controller.c:112: warning: Cannot understand  * @type: NFC version
    on line 112 - I thought it was a doc line


vim +112 drivers/mtd/nand/raw/rockchip-nand-controller.c

   110	
   111	/**
 > 112	 * @type: NFC version
   113	 * @ecc_strengths: ECC strengths
   114	 * @ecc_cfgs: ECC config values
   115	 * @flctl_off: FLCTL register offset
   116	 * @bchctl_off: BCHCTL register offset
   117	 * @dma_data_buf_off: DMA_DATA_BUF register offset
   118	 * @dma_oob_buf_off: DMA_OOB_BUF register offset
   119	 * @dma_cfg_off: DMA_CFG register offset
   120	 * @dma_st_off: DMA_ST register offset
   121	 * @bch_st_off: BCG_ST register offset
   122	 * @randmz_off: RANDMZ register offset
   123	 * @int_en_off: interrupt enable register offset
   124	 * @int_clr_off: interrupt clean register offset
   125	 * @int_st_off: interrupt status register offset
   126	 * @oob0_off: oob0 register offset
   127	 * @oob1_off: oob1 register offset
   128	 * @ecc0: represent ECC0 status data
   129	 * @ecc1: represent ECC1 status data
   130	 */
   131	struct nfc_cfg {
   132		enum nfc_type type;
   133		u8 ecc_strengths[NFC_ECC_MAX_MODES];
   134		u32 ecc_cfgs[NFC_ECC_MAX_MODES];
   135		u32 flctl_off;
   136		u32 bchctl_off;
   137		u32 dma_cfg_off;
   138		u32 dma_data_buf_off;
   139		u32 dma_oob_buf_off;
   140		u32 dma_st_off;
   141		u32 bch_st_off;
   142		u32 randmz_off;
   143		u32 int_en_off;
   144		u32 int_clr_off;
   145		u32 int_st_off;
   146		u32 oob0_off;
   147		u32 oob1_off;
   148		struct ecc_cnt_status ecc0;
   149		struct ecc_cnt_status ecc1;
   150	};
   151	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
