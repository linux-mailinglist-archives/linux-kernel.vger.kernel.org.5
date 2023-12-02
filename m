Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F733801A3D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 04:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjLBD2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 22:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBD2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 22:28:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A835F1B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 19:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701487726; x=1733023726;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=apzBccbexJg0z5J6JHF92DO6CiDcYfb1DX9lbMIlGkU=;
  b=UWwIkvxQ5Hn1QxlwSfQx8S48eR9I3d0KFoXw88SUAsizUOYvb0idqxcc
   1YNxnJ3+eRLdDGBeWTElkldaEMJ2GJ7ywEG7TS1uJTx66TK6FtaX3deGU
   VBCTWndRfhtXCVfcOoqPV6Lfk8kxCEbI2PQWFekiKp6kxHI2hTyWH5uz3
   Btd5oMK3lMDbVw6SdMFJS8UgXy7TYquSpx7NHjwKolMJzpE06H1HvQVCk
   0yUfW2dKqVAtZOFrGZXTJMOZrfRpx8Fn2DHM4Wmwa5C21gGE1t6bbKDkY
   ADbM8Zkjd6mXWOsUQMW4jxhHt2Q9ohz6ZwuJzE8N1qJRSmXoLU/pABhF6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="456696"
X-IronPort-AV: E=Sophos;i="6.04,243,1695711600"; 
   d="scan'208";a="456696"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 19:28:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="913774549"
X-IronPort-AV: E=Sophos;i="6.04,243,1695711600"; 
   d="scan'208";a="913774549"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 01 Dec 2023 19:28:44 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9GgL-0004c8-2U;
        Sat, 02 Dec 2023 03:28:41 +0000
Date:   Sat, 2 Dec 2023 11:28:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Wilcox <mawilcox@microsoft.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/scsi/sym53c8xx_2/sym_hipd.c:5077:32: sparse: sparse:
 incorrect type in argument 2 (different base types)
Message-ID: <202312021119.N5Typgj1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: 1caffba9db4aa27c3e7ebc05668afca1f991ab8d drivers/scsi/sym53c8xx_2/sym_hipd.c: convert to use memset32
date:   6 years ago
config: powerpc-randconfig-r121-20231107 (https://download.01.org/0day-ci/archive/20231202/202312021119.N5Typgj1-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231202/202312021119.N5Typgj1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312021119.N5Typgj1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2531:16: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2535:24: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2536:24: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2539:24: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2543:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2555:48: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2556:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2587:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2589:34: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2611:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2611:21: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2611:21: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2612:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2612:21: sparse:     expected unsigned int [usertype] size
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2612:21: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2613:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ret @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2613:21: sparse:     expected unsigned int [usertype] ret
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2613:21: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2631:23: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2632:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2632:38: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2632:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2633:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2633:29: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2633:29: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2634:23: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2635:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2635:38: sparse:     expected unsigned int [usertype] size
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2635:38: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2636:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2636:29: sparse:     expected unsigned int [usertype] size
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2636:29: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2653:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2653:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2653:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2663:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] lastp @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2663:9: sparse:     expected unsigned int [usertype] lastp
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2663:9: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2663:9: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] lastp @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2663:9: sparse:     expected unsigned int [usertype] lastp
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2663:9: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4600:33: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4908:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] start @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4908:34: sparse:     expected unsigned int [usertype] start
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4908:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4909:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] restart @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4909:34: sparse:     expected unsigned int [usertype] restart
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4909:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4914:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4914:32: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/sym53c8xx_2/sym_hipd.c:4914:32: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/sym53c8xx_2/sym_hipd.c:5077:32: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:5077:32: sparse:     expected unsigned int [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:5077:32: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:5089:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] itlq_tbl_sa @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:5089:30: sparse:     expected unsigned int [usertype] itlq_tbl_sa
   drivers/scsi/sym53c8xx_2/sym_hipd.c:5089:30: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3889:37: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3908:29: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1027:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] scratch @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1027:21: sparse:     expected unsigned int [usertype] scratch
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1027:21: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1068:19: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1172:17: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1518:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1518:36: sparse:     expected unsigned int volatile [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1518:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1520:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1520:36: sparse:     expected unsigned int volatile [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1520:36: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1605:23: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1726:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1726:33: sparse:     expected unsigned int volatile [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1726:33: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1727:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1727:33: sparse:     expected unsigned int volatile [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1727:33: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1729:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1729:35: sparse:     expected unsigned int volatile [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1729:35: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1742:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1742:33: sparse:     expected unsigned int volatile [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1742:33: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1744:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile [usertype] @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1744:35: sparse:     expected unsigned int volatile [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1744:35: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:1921:32: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2374:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] lastp @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2374:25: sparse:     expected unsigned int [usertype] lastp
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2374:25: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2374:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] lastp @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2374:25: sparse:     expected unsigned int [usertype] lastp
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2374:25: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:2994:43: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3126:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3126:41: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3126:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3127:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3127:41: sparse:     expected unsigned int [usertype] size
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3127:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3132:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3132:41: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3132:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3133:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3133:41: sparse:     expected unsigned int [usertype] size
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3133:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3149:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3149:41: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3149:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3150:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3150:41: sparse:     expected unsigned int [usertype] size
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3150:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3157:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] savep @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3157:41: sparse:     expected unsigned int [usertype] savep
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3157:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3158:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] lastp @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3158:41: sparse:     expected unsigned int [usertype] lastp
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3158:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3159:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] startp @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3159:41: sparse:     expected unsigned int [usertype] startp
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3159:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3160:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] goalp @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3160:41: sparse:     expected unsigned int [usertype] goalp
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3160:41: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3169:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] start @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3169:40: sparse:     expected unsigned int [usertype] start
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3169:40: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3425:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3425:35: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3425:35: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3603:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3603:35: sparse:     expected unsigned int [usertype] size
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3603:35: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3660:27: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3661:27: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3678:15: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3700:31: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3711:31: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3760:27: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3785:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dp_ret @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3785:16: sparse:     expected unsigned int [usertype] dp_ret
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3785:16: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3825:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ret @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3825:17: sparse:     expected unsigned int [usertype] ret
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3825:17: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3826:16: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3827:16: sparse: sparse: cast to restricted __le32
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3828:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3828:21: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3828:21: sparse:     got restricted __le32 [usertype]
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3829:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __le32 [usertype] @@
   drivers/scsi/sym53c8xx_2/sym_hipd.c:3829:21: sparse:     expected unsigned int [usertype] size

vim +5077 drivers/scsi/sym53c8xx_2/sym_hipd.c

  5050	
  5051	/*
  5052	 *  Allocate LCB resources for tagged command queuing.
  5053	 */
  5054	static void sym_alloc_lcb_tags (struct sym_hcb *np, u_char tn, u_char ln)
  5055	{
  5056		struct sym_tcb *tp = &np->target[tn];
  5057		struct sym_lcb *lp = sym_lp(tp, ln);
  5058		int i;
  5059	
  5060		/*
  5061		 *  Allocate the task table and and the tag allocation 
  5062		 *  circular buffer. We want both or none.
  5063		 */
  5064		lp->itlq_tbl = sym_calloc_dma(SYM_CONF_MAX_TASK*4, "ITLQ_TBL");
  5065		if (!lp->itlq_tbl)
  5066			goto fail;
  5067		lp->cb_tags = kcalloc(SYM_CONF_MAX_TASK, 1, GFP_ATOMIC);
  5068		if (!lp->cb_tags) {
  5069			sym_mfree_dma(lp->itlq_tbl, SYM_CONF_MAX_TASK*4, "ITLQ_TBL");
  5070			lp->itlq_tbl = NULL;
  5071			goto fail;
  5072		}
  5073	
  5074		/*
  5075		 *  Initialize the task table with invalid entries.
  5076		 */
> 5077		memset32(lp->itlq_tbl, cpu_to_scr(np->notask_ba), SYM_CONF_MAX_TASK);
  5078	
  5079		/*
  5080		 *  Fill up the tag buffer with tag numbers.
  5081		 */
  5082		for (i = 0 ; i < SYM_CONF_MAX_TASK ; i++)
  5083			lp->cb_tags[i] = i;
  5084	
  5085		/*
  5086		 *  Make the task table available to SCRIPTS, 
  5087		 *  And accept tagged commands now.
  5088		 */
  5089		lp->head.itlq_tbl_sa = cpu_to_scr(vtobus(lp->itlq_tbl));
  5090	
  5091		return;
  5092	fail:
  5093		return;
  5094	}
  5095	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
