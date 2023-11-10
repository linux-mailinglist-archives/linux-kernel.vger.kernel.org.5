Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112597E807F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjKJSM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345697AbjKJSLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:11:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAA73481B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699620233; x=1731156233;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DlvQdSBX/WW9fYA1g6Fn+SCEN2Gi3eiuxv35iy5Eyz8=;
  b=kJWi1AB1mqvy8On+hze45w76l0zf5uAamm9nI3z5E3IeNwsOjJXKKqop
   7TBltn0s21Z/JXDfN6/DWDcSrgBZ1Iiy0YMGunguaLaTpL8hP0qBeC+mR
   e7QqghYbmMQDosKaBgFTpZg1rh7zWEomqKcF5gzm1ENCeOUbFAUmXro3g
   6lEOu+FDYXBUfNrsMN16c54dxqPUJFi9q9boNqFjQXUelWdKCTZU7fIXF
   8XBII0292NOlQhQPyoNkkKmP9REmI8+qPmI+P+4Bfsc5mZiIJgQfS5QkP
   XpfUr8Mx48mRUKevA95PJwhdWgo47c6f6JsBpndRXM6MB+GB4b58fgbHS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="11727053"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="11727053"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 04:43:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="829644308"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="829644308"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Nov 2023 04:43:51 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1QrU-0009bS-2h;
        Fri, 10 Nov 2023 12:43:48 +0000
Date:   Fri, 10 Nov 2023 20:43:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ipvlan/ipvlan_core.c:57:36: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202311102025.IRGm5CAD-lkp@intel.com>
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
head:   89cdf9d556016a54ff6ddd62324aa5ec790c05cc
commit: c675e06a98a474f7ad0af32ce467613da818da52 ipvlan: decouple l3s mode dependencies from other modes
date:   4 years, 9 months ago
config: i386-randconfig-062-20230914 (https://download.01.org/0day-ci/archive/20231110/202311102025.IRGm5CAD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311102025.IRGm5CAD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311102025.IRGm5CAD-lkp@intel.com/

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
