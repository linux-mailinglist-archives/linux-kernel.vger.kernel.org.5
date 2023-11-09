Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A92B7E61C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 02:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjKIBQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 20:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjKIBQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 20:16:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38A9258F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 17:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699492573; x=1731028573;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hj9O1oUl29Hx5F9sNOt7f3tvRUpgBetDr5T4gH2wu8A=;
  b=f4Q/g/R/YWozexc0atwAuq7JvugVxpKWz3Dz8U40NksA8Sbs2xugEuVX
   f0/J/WK8ISQHfR+EEZrFXzQlqCmMb45oXBKBTESC1OC0Hv9aABmR2V6Yh
   zaTYweW8rB18y/am+HWB7fkpPdz8IoWNdJO9kQsN8YsertFeTlmyxzbbz
   9t3j8wevjsO2zKZllp40oUc0QgDgsMx0LavruvIsy2T3CLfdjMtGwiX/3
   08GWCend2jvGktUTgRVtBhaCJfNa5ypyRjha3dscELGj33WjIM0xWz38v
   VKbDviYmzfcmsEUQ7arNnUQXYUuj+RCRCQFbmF3uO5P6IFGdgcrcHIVOo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="11446278"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="11446278"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 17:16:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="1010462801"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="1010462801"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Nov 2023 17:16:11 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0teT-0008MQ-1G;
        Thu, 09 Nov 2023 01:16:09 +0000
Date:   Thu, 9 Nov 2023 09:15:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ipvlan/ipvlan_core.c:57:36: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202311090900.o5hCIMpN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc986ab839c844e78a2333a02e55f02c9e57935
commit: c675e06a98a474f7ad0af32ce467613da818da52 ipvlan: decouple l3s mode dependencies from other modes
date:   4 years, 9 months ago
config: i386-randconfig-062-20230914 (https://download.01.org/0day-ci/archive/20231109/202311090900.o5hCIMpN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311090900.o5hCIMpN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311090900.o5hCIMpN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ipvlan/ipvlan_core.c:57:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] a @@     got restricted __be32 const [usertype] s_addr @@
   drivers/net/ipvlan/ipvlan_core.c:57:36: sparse:     expected unsigned int [usertype] a
   drivers/net/ipvlan/ipvlan_core.c:57:36: sparse:     got restricted __be32 const [usertype] s_addr

vim +57 drivers/net/ipvlan/ipvlan_core.c

2ad7bf3638411c Mahesh Bandewar 2014-11-23  52  
2ad7bf3638411c Mahesh Bandewar 2014-11-23  53  static u8 ipvlan_get_v4_hash(const void *iaddr)
2ad7bf3638411c Mahesh Bandewar 2014-11-23  54  {
2ad7bf3638411c Mahesh Bandewar 2014-11-23  55  	const struct in_addr *ip4_addr = iaddr;
2ad7bf3638411c Mahesh Bandewar 2014-11-23  56  
2ad7bf3638411c Mahesh Bandewar 2014-11-23 @57  	return jhash_1word(ip4_addr->s_addr, ipvlan_jhash_secret) &
2ad7bf3638411c Mahesh Bandewar 2014-11-23  58  	       IPVLAN_HASH_MASK;
2ad7bf3638411c Mahesh Bandewar 2014-11-23  59  }
2ad7bf3638411c Mahesh Bandewar 2014-11-23  60  

:::::: The code at line 57 was first introduced by commit
:::::: 2ad7bf3638411cb547f2823df08166c13ab04269 ipvlan: Initial check-in of the IPVLAN driver.

:::::: TO: Mahesh Bandewar <maheshb@google.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
