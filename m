Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248457DF808
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376965AbjKBQ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKBQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:56:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BF013D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698944180; x=1730480180;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HRQxM3v2FYFxPHlOWMME6lbgFWbLyvIU7sEJQZswi0w=;
  b=cqv8Xjitdon29PiS+k/8IYVosqQux3jxcabMhNyE3E1DOoOjIqh0wGDI
   hBzrLfOL6zNZOuGBULEUQFOy6RYPeC23qkunK6YwqhoCKz/TNK/wQ70dJ
   a+zw6kqP6AUBCFek7/HQfy0QSPVbCQFp+sQ25UTt88YvEIaRlQUXf13ar
   9hP+mCmjulJrcdF0bY5BB6beUI8oo/XUL2lzGj1dvO4RHwcs9ObdRKnsR
   oRaCUkGNq4cTV32ctuBXZKHd0CQHJGsZXw6FwkRnHd/l3CJ5NrDyf1kpM
   Xh/EXaXSiiu17r0+FM9Z3hHsfSxpgKwNFQhW7Q63CNMdLkSfa+QTXbXry
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="368969531"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="368969531"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:56:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="796307696"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="796307696"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Nov 2023 09:56:17 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyazO-0001gB-2j;
        Thu, 02 Nov 2023 16:56:14 +0000
Date:   Fri, 3 Nov 2023 00:55:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: drivers/dma/dw-edma/dw-edma-v0-debugfs.c:250:50: warning: '%d'
 directive output may be truncated writing between 1 and 11 bytes into a
 region of size 8
Message-ID: <202311030041.DznTeuS5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
commit: 00498167650b682a053b85e0e705f59a54f427a3 dmaengine: dw-edma: Simplify debugfs context CSRs init procedure
date:   9 months ago
config: parisc-randconfig-001-20231102 (https://download.01.org/0day-ci/archive/20231103/202311030041.DznTeuS5-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030041.DznTeuS5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030041.DznTeuS5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/dw-edma/dw-edma-v0-debugfs.c: In function 'dw_edma_debugfs_regs_rd':
>> drivers/dma/dw-edma/dw-edma-v0-debugfs.c:250:50: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Wformat-truncation=]
     250 |                 snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
         |                                                  ^~
   drivers/dma/dw-edma/dw-edma-v0-debugfs.c:250:46: note: directive argument in the range [-2147483641, 65534]
     250 |                 snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
         |                                              ^~~~~~~
   drivers/dma/dw-edma/dw-edma-v0-debugfs.c:250:17: note: 'snprintf' output between 10 and 20 bytes into a destination of size 16
     250 |                 snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/dma/dw-edma/dw-edma-v0-debugfs.c: In function 'dw_edma_debugfs_regs_wr':
   drivers/dma/dw-edma/dw-edma-v0-debugfs.c:188:50: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 8 [-Wformat-truncation=]
     188 |                 snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
         |                                                  ^~
   drivers/dma/dw-edma/dw-edma-v0-debugfs.c:188:46: note: directive argument in the range [-2147483641, 65534]
     188 |                 snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
         |                                              ^~~~~~~
   drivers/dma/dw-edma/dw-edma-v0-debugfs.c:188:17: note: 'snprintf' output between 10 and 20 bytes into a destination of size 16
     188 |                 snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +250 drivers/dma/dw-edma/dw-edma-v0-debugfs.c

305aebeff8795c Gustavo Pimentel 2019-06-04  195  
95c55b7836f579 Serge Semin      2023-01-13  196  static void dw_edma_debugfs_regs_rd(struct dentry *dent)
305aebeff8795c Gustavo Pimentel 2019-06-04  197  {
345e3a95b2fb46 Serge Semin      2023-01-13  198  	const struct dw_edma_debugfs_entry debugfs_regs[] = {
305aebeff8795c Gustavo Pimentel 2019-06-04  199  		/* eDMA global registers */
305aebeff8795c Gustavo Pimentel 2019-06-04  200  		RD_REGISTER(engine_en),
305aebeff8795c Gustavo Pimentel 2019-06-04  201  		RD_REGISTER(doorbell),
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  202  		RD_REGISTER(ch_arb_weight.lsb),
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  203  		RD_REGISTER(ch_arb_weight.msb),
305aebeff8795c Gustavo Pimentel 2019-06-04  204  		/* eDMA interrupts registers */
305aebeff8795c Gustavo Pimentel 2019-06-04  205  		RD_REGISTER(int_status),
305aebeff8795c Gustavo Pimentel 2019-06-04  206  		RD_REGISTER(int_mask),
305aebeff8795c Gustavo Pimentel 2019-06-04  207  		RD_REGISTER(int_clear),
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  208  		RD_REGISTER(err_status.lsb),
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  209  		RD_REGISTER(err_status.msb),
305aebeff8795c Gustavo Pimentel 2019-06-04  210  		RD_REGISTER(linked_list_err_en),
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  211  		RD_REGISTER(done_imwr.lsb),
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  212  		RD_REGISTER(done_imwr.msb),
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  213  		RD_REGISTER(abort_imwr.lsb),
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  214  		RD_REGISTER(abort_imwr.msb),
305aebeff8795c Gustavo Pimentel 2019-06-04  215  		RD_REGISTER(ch01_imwr_data),
305aebeff8795c Gustavo Pimentel 2019-06-04  216  		RD_REGISTER(ch23_imwr_data),
305aebeff8795c Gustavo Pimentel 2019-06-04  217  		RD_REGISTER(ch45_imwr_data),
305aebeff8795c Gustavo Pimentel 2019-06-04  218  		RD_REGISTER(ch67_imwr_data),
305aebeff8795c Gustavo Pimentel 2019-06-04  219  	};
345e3a95b2fb46 Serge Semin      2023-01-13  220  	const struct dw_edma_debugfs_entry debugfs_unroll_regs[] = {
305aebeff8795c Gustavo Pimentel 2019-06-04  221  		/* eDMA channel context grouping */
305aebeff8795c Gustavo Pimentel 2019-06-04  222  		RD_REGISTER_UNROLL(engine_chgroup),
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  223  		RD_REGISTER_UNROLL(engine_hshake_cnt.lsb),
04e0a39fc10f82 Gustavo Pimentel 2021-02-18  224  		RD_REGISTER_UNROLL(engine_hshake_cnt.msb),
305aebeff8795c Gustavo Pimentel 2019-06-04  225  		RD_REGISTER_UNROLL(ch0_pwr_en),
305aebeff8795c Gustavo Pimentel 2019-06-04  226  		RD_REGISTER_UNROLL(ch1_pwr_en),
305aebeff8795c Gustavo Pimentel 2019-06-04  227  		RD_REGISTER_UNROLL(ch2_pwr_en),
305aebeff8795c Gustavo Pimentel 2019-06-04  228  		RD_REGISTER_UNROLL(ch3_pwr_en),
305aebeff8795c Gustavo Pimentel 2019-06-04  229  		RD_REGISTER_UNROLL(ch4_pwr_en),
305aebeff8795c Gustavo Pimentel 2019-06-04  230  		RD_REGISTER_UNROLL(ch5_pwr_en),
305aebeff8795c Gustavo Pimentel 2019-06-04  231  		RD_REGISTER_UNROLL(ch6_pwr_en),
305aebeff8795c Gustavo Pimentel 2019-06-04  232  		RD_REGISTER_UNROLL(ch7_pwr_en),
305aebeff8795c Gustavo Pimentel 2019-06-04  233  	};
95c55b7836f579 Serge Semin      2023-01-13  234  	struct dentry *regs_dent, *ch_dent;
305aebeff8795c Gustavo Pimentel 2019-06-04  235  	int nr_entries, i;
305aebeff8795c Gustavo Pimentel 2019-06-04  236  	char name[16];
305aebeff8795c Gustavo Pimentel 2019-06-04  237  
95c55b7836f579 Serge Semin      2023-01-13  238  	regs_dent = debugfs_create_dir(READ_STR, dent);
305aebeff8795c Gustavo Pimentel 2019-06-04  239  
305aebeff8795c Gustavo Pimentel 2019-06-04  240  	nr_entries = ARRAY_SIZE(debugfs_regs);
95c55b7836f579 Serge Semin      2023-01-13  241  	dw_edma_debugfs_create_x32(debugfs_regs, nr_entries, regs_dent);
305aebeff8795c Gustavo Pimentel 2019-06-04  242  
203184571388a9 Frank Li         2022-05-24  243  	if (dw->chip->mf == EDMA_MF_HDMA_COMPAT) {
305aebeff8795c Gustavo Pimentel 2019-06-04  244  		nr_entries = ARRAY_SIZE(debugfs_unroll_regs);
305aebeff8795c Gustavo Pimentel 2019-06-04  245  		dw_edma_debugfs_create_x32(debugfs_unroll_regs, nr_entries,
95c55b7836f579 Serge Semin      2023-01-13  246  					   regs_dent);
305aebeff8795c Gustavo Pimentel 2019-06-04  247  	}
305aebeff8795c Gustavo Pimentel 2019-06-04  248  
305aebeff8795c Gustavo Pimentel 2019-06-04  249  	for (i = 0; i < dw->rd_ch_cnt; i++) {
305aebeff8795c Gustavo Pimentel 2019-06-04 @250  		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
305aebeff8795c Gustavo Pimentel 2019-06-04  251  
95c55b7836f579 Serge Semin      2023-01-13  252  		ch_dent = debugfs_create_dir(name, regs_dent);
305aebeff8795c Gustavo Pimentel 2019-06-04  253  
00498167650b68 Serge Semin      2023-01-13  254  		dw_edma_debugfs_regs_ch(EDMA_DIR_READ, i, ch_dent);
305aebeff8795c Gustavo Pimentel 2019-06-04  255  	}
305aebeff8795c Gustavo Pimentel 2019-06-04  256  }
305aebeff8795c Gustavo Pimentel 2019-06-04  257  

:::::: The code at line 250 was first introduced by commit
:::::: 305aebeff8795cbf03b3f117e74bb702c130ae4c dmaengine: Add Synopsys eDMA IP version 0 debugfs support

:::::: TO: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
:::::: CC: Vinod Koul <vkoul@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
