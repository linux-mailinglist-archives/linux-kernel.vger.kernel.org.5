Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D84D80B932
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjLJFxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 00:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJFxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 00:53:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805F101
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 21:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702187606; x=1733723606;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3cxGuIrU6sLzht4RqrEj+t/bppeXuI1tJ5FElPA5KBU=;
  b=C+SIIdt5kEL0UpUJXlwC/OCWSMeGssEGe5QxFzflLw4n0D0/17A1f0b5
   rcuCE1WeJ2bkirupYIuHmalR4216vL6QZ4nCmewTDmE3VETNWNCO0ZbLT
   Qz5UFmIk8YnYjrAiiOgurtedc2Xehh20zLvdbq8FYO223i2B8nvzViIWG
   JTLLp/Ut68iKap8XRKp5AGxB+NV4f5tvDQ7dxH0MUUHx99MfwPEoPGcXa
   9h81XLOUTLlF3alWVuBhESEnd0blMKyflDsqMpp8TXddgFyXOkblmMv7j
   igeDfORZpaq/FXGpiKGWj0LZQcZtZp68t8qoBJe1dcXXZx4fNxlXsouHg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="384948904"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="384948904"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 21:53:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="863352892"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="863352892"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Dec 2023 21:53:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCCkj-000GS1-1B;
        Sun, 10 Dec 2023 05:53:21 +0000
Date:   Sun, 10 Dec 2023 13:53:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/video/fbdev/fsl-diu-fb.c:880:49: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202312101354.RzyyOmYQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c527f5606aa545233a4d2c6d5c636ed82b8633ef
commit: b28d1ccf921a4333be14017d82066386d419e638 powerpc/io: Expect immutable pointer in virt_to_phys() prototype
date:   7 weeks ago
config: powerpc-randconfig-r113-20231106 (https://download.01.org/0day-ci/archive/20231210/202312101354.RzyyOmYQ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231210/202312101354.RzyyOmYQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312101354.RzyyOmYQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/video/fbdev/fsl-diu-fb.c:497:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *reg @@
   drivers/video/fbdev/fsl-diu-fb.c:497:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:497:26: sparse:     got unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:496:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] *reg @@
   drivers/video/fbdev/fsl-diu-fb.c:496:26: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:496:26: sparse:     got unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:493:6: sparse: sparse: symbol 'wr_reg_wa' was not declared. Should it be static?
   drivers/video/fbdev/fsl-diu-fb.c:509:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:509:36: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:509:36: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:513:29: sparse: sparse: restricted __be32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:519:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:519:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:519:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:524:29: sparse: sparse: restricted __be32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:530:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:530:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:530:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:536:29: sparse: sparse: restricted __be32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:537:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:537:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:537:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:544:29: sparse: sparse: restricted __be32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:545:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:545:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:545:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:561:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:561:36: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:561:36: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:566:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:566:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:566:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:569:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:569:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:569:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:575:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:575:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:575:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:578:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:578:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:578:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:583:29: sparse: sparse: restricted __be32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:589:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:589:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:589:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:594:29: sparse: sparse: restricted __be32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:600:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] *reg @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:600:44: sparse:     expected unsigned int [usertype] *reg
   drivers/video/fbdev/fsl-diu-fb.c:600:44: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:612:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:612:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:612:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:621:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:621:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:621:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:829:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:829:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:829:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:831:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:831:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:831:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:832:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:832:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:832:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:839:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:839:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:839:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:845:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:845:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:845:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:861:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:861:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:861:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:879:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got void *[assigned] p @@
   drivers/video/fbdev/fsl-diu-fb.c:879:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/fsl-diu-fb.c:879:27: sparse:     got void *[assigned] p
>> drivers/video/fbdev/fsl-diu-fb.c:880:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *address @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/fsl-diu-fb.c:880:49: sparse:     expected void const volatile *address
   drivers/video/fbdev/fsl-diu-fb.c:880:49: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/fsl-diu-fb.c:890:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *p @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/fsl-diu-fb.c:890:23: sparse:     expected void *p
   drivers/video/fbdev/fsl-diu-fb.c:890:23: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/fsl-diu-fb.c:959:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/fsl-diu-fb.c:959:24: sparse:     expected unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:959:24: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/fsl-diu-fb.c:962:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/fsl-diu-fb.c:962:24: sparse:     expected unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:962:24: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/fsl-diu-fb.c:965:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/video/fbdev/fsl-diu-fb.c:965:24: sparse:     expected unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:965:24: sparse:     got restricted __le32 [usertype]
   drivers/video/fbdev/fsl-diu-fb.c:1051:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1051:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1051:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1112:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1112:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1112:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1114:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1114:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1114:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1154:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] pix_fmt @@     got unsigned int @@
   drivers/video/fbdev/fsl-diu-fb.c:1154:29: sparse:     expected restricted __be32 [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1154:29: sparse:     got unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:1157:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] pix_fmt @@     got unsigned int @@
   drivers/video/fbdev/fsl-diu-fb.c:1157:29: sparse:     expected restricted __be32 [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1157:29: sparse:     got unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:1160:32: sparse: sparse: restricted __le32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:1160:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] src_size_g_alpha @@     got unsigned int @@
   drivers/video/fbdev/fsl-diu-fb.c:1160:30: sparse:     expected restricted __le32 [usertype] src_size_g_alpha
   drivers/video/fbdev/fsl-diu-fb.c:1160:30: sparse:     got unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:1294:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] pix_fmt @@     got unsigned int [addressable] [usertype] pix_fmt @@
   drivers/video/fbdev/fsl-diu-fb.c:1294:29: sparse:     expected restricted __be32 [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1294:29: sparse:     got unsigned int [addressable] [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1302:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [usertype] pix_fmt @@     got restricted __be32 [usertype] pix_fmt @@
   drivers/video/fbdev/fsl-diu-fb.c:1302:25: sparse:     expected unsigned int [addressable] [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1302:25: sparse:     got restricted __be32 [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1329:43: sparse: sparse: restricted __le32 degrades to integer
   drivers/video/fbdev/fsl-diu-fb.c:1329:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] src_size_g_alpha @@     got unsigned int @@
   drivers/video/fbdev/fsl-diu-fb.c:1329:38: sparse:     expected restricted __le32 [usertype] src_size_g_alpha
   drivers/video/fbdev/fsl-diu-fb.c:1329:38: sparse:     got unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:1444:39: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1444:39: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1444:39: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1579:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct diu [noderef] __iomem *hw @@     got void *dev_id @@
   drivers/video/fbdev/fsl-diu-fb.c:1579:34: sparse:     expected struct diu [noderef] __iomem *hw
   drivers/video/fbdev/fsl-diu-fb.c:1579:34: sparse:     got void *dev_id
   drivers/video/fbdev/fsl-diu-fb.c:1580:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1580:36: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1580:36: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1585:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1585:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1585:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1587:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1587:35: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1587:35: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1760:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] pix_fmt @@     got unsigned int @@
   drivers/video/fbdev/fsl-diu-fb.c:1760:32: sparse:     expected restricted __be32 [usertype] pix_fmt
   drivers/video/fbdev/fsl-diu-fb.c:1760:32: sparse:     got unsigned int
   drivers/video/fbdev/fsl-diu-fb.c:1772:26: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1772:26: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1772:26: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1773:46: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1773:46: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1773:46: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1775:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1775:38: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1775:38: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1776:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1776:38: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1776:38: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1782:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1782:23: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1782:23: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1783:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/video/fbdev/fsl-diu-fb.c:1783:22: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/video/fbdev/fsl-diu-fb.c:1783:22: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/video/fbdev/fsl-diu-fb.c:1786:31: sparse: sparse: incorrect type in argument 5 (different address spaces) @@     expected void *dev @@     got struct diu [noderef] __iomem *diu_reg @@
   drivers/video/fbdev/fsl-diu-fb.c:1786:31: sparse:     expected void *dev
   drivers/video/fbdev/fsl-diu-fb.c:1786:31: sparse:     got struct diu [noderef] __iomem *diu_reg
   drivers/video/fbdev/fsl-diu-fb.c:1796:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void * @@     got struct diu [noderef] __iomem *diu_reg @@
   drivers/video/fbdev/fsl-diu-fb.c:1796:49: sparse:     expected void *
   drivers/video/fbdev/fsl-diu-fb.c:1796:49: sparse:     got struct diu [noderef] __iomem *diu_reg
   drivers/video/fbdev/fsl-diu-fb.c:1832:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void * @@     got struct diu [noderef] __iomem *diu_reg @@
   drivers/video/fbdev/fsl-diu-fb.c:1832:33: sparse:     expected void *
   drivers/video/fbdev/fsl-diu-fb.c:1832:33: sparse:     got struct diu [noderef] __iomem *diu_reg
   drivers/video/fbdev/fsl-diu-fb.c:1937:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *p @@     got unsigned int const [usertype] *[assigned] prop @@
   drivers/video/fbdev/fsl-diu-fb.c:1937:44: sparse:     expected restricted __be32 const [usertype] *p
   drivers/video/fbdev/fsl-diu-fb.c:1937:44: sparse:     got unsigned int const [usertype] *[assigned] prop
   drivers/video/fbdev/fsl-diu-fb.c:1950:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __be32 const [usertype] *p @@     got unsigned int const [usertype] *[assigned] prop @@
   drivers/video/fbdev/fsl-diu-fb.c:1950:42: sparse:     expected restricted __be32 const [usertype] *p
   drivers/video/fbdev/fsl-diu-fb.c:1950:42: sparse:     got unsigned int const [usertype] *[assigned] prop
   drivers/video/fbdev/fsl-diu-fb.c:513:29: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/fsl-diu-fb.c:524:29: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/fsl-diu-fb.c:536:29: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/fsl-diu-fb.c:544:29: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/fsl-diu-fb.c:583:29: sparse: sparse: dereference of noderef expression
   drivers/video/fbdev/fsl-diu-fb.c:594:29: sparse: sparse: dereference of noderef expression
--
>> drivers/pci/controller/pcie-mediatek.c:400:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *address @@     got void [noderef] __iomem * @@
   drivers/pci/controller/pcie-mediatek.c:400:40: sparse:     expected void const volatile *address
   drivers/pci/controller/pcie-mediatek.c:400:40: sparse:     got void [noderef] __iomem *
   drivers/pci/controller/pcie-mediatek.c:523:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile *address @@     got void [noderef] __iomem * @@
   drivers/pci/controller/pcie-mediatek.c:523:44: sparse:     expected void const volatile *address
   drivers/pci/controller/pcie-mediatek.c:523:44: sparse:     got void [noderef] __iomem *
   drivers/pci/controller/pcie-mediatek.c: note: in included file (through include/linux/mutex.h, include/linux/notifier.h, include/linux/clk.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +880 drivers/video/fbdev/fsl-diu-fb.c

9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  798  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  799  static void update_lcdc(struct fb_info *info)
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  800  {
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  801  	struct fb_var_screeninfo *var = &info->var;
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  802  	struct mfb_info *mfbi = info->par;
b7795052825902 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-08  803  	struct fsl_diu_data *data = mfbi->parent;
3c755b7c09a5f8 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-10-04  804  	struct diu __iomem *hw;
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  805  	int i, j;
ddd3d905436b57 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-02  806  	u8 *gamma_table_base;
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  807  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  808  	u32 temp;
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  809  
b7795052825902 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-08  810  	hw = data->diu_reg;
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  811  
2867173572d5ca drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  812  	if (diu_ops.set_monitor_port)
b7795052825902 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-08  813  		diu_ops.set_monitor_port(data->monitor_port);
b7795052825902 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-08  814  	gamma_table_base = data->gamma;
ddd3d905436b57 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-02  815  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  816  	/* Prep for DIU init  - gamma table, cursor table */
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  817  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  818  	for (i = 0; i <= 2; i++)
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  819  		for (j = 0; j <= 255; j++)
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  820  			*gamma_table_base++ = j;
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  821  
e09a8c3a42f4c9 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-19  822  	if (diu_ops.set_gamma_table)
b7795052825902 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-08  823  		diu_ops.set_gamma_table(data->monitor_port, data->gamma);
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  824  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  825  	disable_lcdc(info);
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  826  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  827  	/* Program DIU registers */
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  828  
b7795052825902 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-08  829  	out_be32(&hw->gamma, DMA_ADDR(data, gamma));
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  830  
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  831  	out_be32(&hw->bgnd, 0x007F7F7F); /* Set background to grey */
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  832  	out_be32(&hw->disp_size, (var->yres << 16) | var->xres);
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  833  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  834  	/* Horizontal and vertical configuration register */
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  835  	temp = var->left_margin << 22 | /* BP_H */
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  836  	       var->hsync_len << 11 |   /* PW_H */
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  837  	       var->right_margin;       /* FP_H */
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  838  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  839  	out_be32(&hw->hsyn_para, temp);
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  840  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  841  	temp = var->upper_margin << 22 | /* BP_V */
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  842  	       var->vsync_len << 11 |    /* PW_V  */
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  843  	       var->lower_margin;        /* FP_V  */
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  844  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28 @845  	out_be32(&hw->vsyn_para, temp);
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  846  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  847  	diu_ops.set_pixel_clock(var->pixclock);
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  848  
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  849  #ifndef CONFIG_PPC_MPC512x
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  850  	/*
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  851  	 * The PLUT register is defined differently on the MPC5121 than it
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  852  	 * is on other SOCs.  Unfortunately, there's no documentation that
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  853  	 * explains how it's supposed to be programmed, so for now, we leave
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  854  	 * it at the default value on the MPC5121.
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  855  	 *
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  856  	 * For other SOCs, program it for the highest priority, which will
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  857  	 * reduce the chance of underrun. Technically, we should scale the
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  858  	 * priority to match the screen resolution, but doing that properly
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  859  	 * requires delicate fine-tuning for each use-case.
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  860  	 */
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  861  	out_be32(&hw->plut, 0x01F5F666);
ceb001b077af64 drivers/video/fsl-diu-fb.c       Timur Tabi        2012-10-16  862  #endif
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  863  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  864  	/* Enable the DIU */
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  865  	enable_lcdc(info);
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  866  }
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  867  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  868  static int map_video_memory(struct fb_info *info)
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  869  {
537a1bf059fa31 drivers/video/fsl-diu-fb.c       Krzysztof Helt    2009-06-30  870  	u32 smem_len = info->fix.line_length * info->var.yres_virtual;
05342c0bdfd519 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-19  871  	void *p;
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  872  
05342c0bdfd519 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-19  873  	p = alloc_pages_exact(smem_len, GFP_DMA | __GFP_ZERO);
05342c0bdfd519 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-19  874  	if (!p) {
550949324ce77f drivers/video/fbdev/fsl-diu-fb.c Thomas Zimmermann 2023-06-13  875  		fb_err(info, "unable to allocate fb memory\n");
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  876  		return -ENOMEM;
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  877  	}
537a1bf059fa31 drivers/video/fsl-diu-fb.c       Krzysztof Helt    2009-06-30  878  	mutex_lock(&info->mm_lock);
05342c0bdfd519 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-19  879  	info->screen_base = p;
05342c0bdfd519 drivers/video/fsl-diu-fb.c       Timur Tabi        2011-12-19 @880  	info->fix.smem_start = virt_to_phys(info->screen_base);
537a1bf059fa31 drivers/video/fsl-diu-fb.c       Krzysztof Helt    2009-06-30  881  	info->fix.smem_len = smem_len;
537a1bf059fa31 drivers/video/fsl-diu-fb.c       Krzysztof Helt    2009-06-30  882  	mutex_unlock(&info->mm_lock);
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  883  	info->screen_size = info->fix.smem_len;
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  884  
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  885  	return 0;
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  886  }
9b53a9e28a34ed drivers/video/fsl-diu-fb.c       York Sun          2008-04-28  887  

:::::: The code at line 880 was first introduced by commit
:::::: 05342c0bdfd519873462e04ad81be07c9cd3c1e1 drivers/video: fsl-diu-fb: merge fsl_diu_alloc() into map_video_memory()

:::::: TO: Timur Tabi <timur@freescale.com>
:::::: CC: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
