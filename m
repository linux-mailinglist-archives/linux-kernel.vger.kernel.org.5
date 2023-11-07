Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5107E4911
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 20:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343534AbjKGTTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 14:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjKGTTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 14:19:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B9310A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 11:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699384758; x=1730920758;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IaDGfIa0O5RTktcmcd6R9szGmG8LN48GzrFZLN4uhGk=;
  b=DOweMnbzOzNGpqpJ1TUlLfXt2clJ62jho8tLGJR4QzWsj+CzjaNFiLJs
   xZXsmVDt3sA7nDlTlKHlkb5MRPRvNSE3bkoLJceWENyO/fzxMV+c3Xhu/
   x8b2jMnaHwQF7zsdabjCTMgQAa+/R0KRkIJN+zlk3fHiYoZGfiawVYw83
   /LLtQst2cSDuhhy7PeHKXZaNtLTV5sh+yZk3eJ2BZvUIyYfhieDrv6CWP
   13Ggk4K11M7zVs1wywoHPs1aDpYmVlQk0gXDnWhuHhl37SVw1he42tgrT
   87RL2zylY04sGm/HmauwcvdzB/NJLOAXKY8u1iSzmeTXXVW/e1M9Bwpbk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2534649"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="2534649"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 11:19:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="833213809"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="833213809"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Nov 2023 11:19:16 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0RbV-0007LM-31;
        Tue, 07 Nov 2023 19:19:13 +0000
Date:   Wed, 8 Nov 2023 03:18:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: drivers/video/fbdev/fsl-diu-fb.c:880:49: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202311080231.4z5kSiw6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
commit: b28d1ccf921a4333be14017d82066386d419e638 powerpc/io: Expect immutable pointer in virt_to_phys() prototype
date:   3 weeks ago
config: powerpc-randconfig-r113-20231106 (https://download.01.org/0day-ci/archive/20231108/202311080231.4z5kSiw6-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231108/202311080231.4z5kSiw6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080231.4z5kSiw6-lkp@intel.com/

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

vim +880 drivers/video/fbdev/fsl-diu-fb.c

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
