Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9E57ADD1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjIYQap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjIYQan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:30:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A400CDF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695659436; x=1727195436;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/Dpxl8nzneKoGmLapRZomdk4+er8inqYj8xgRTzDNDA=;
  b=Z1alefOqR6xhSfre0v7JFdSVTOGNqoUhQJAdzuBIj9/s15tTkTM3Ft4t
   CjOZ0Z5O5yTz2ooPW3bwFp2Xs5lpGsG6tTAATrVvZ0B3vz7+Lwx9x2zO1
   LG2jksfIDcTP1mYP/V09dMuC+Ut06mxtFFxwG6PapJ8VOCZ96yJOwC+HC
   6JOCkV399sp+VwrcYKMfraZUPYAf3N3ruqzNxojcVswFAXdVFrgLIpyIt
   zNkrANXm/wWzDgp/PpOrd5IYpImnDyaIQexVSGjbdNVFcBnM5rIOOpbjD
   qGVp82N0trsKBqWe8aVSCYKGGPfrGjVNCMXN+7Jd9D+6PnhVMSHtoSbfj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380168834"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="380168834"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 09:30:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079270110"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="1079270110"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 25 Sep 2023 09:30:33 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkoTf-0001mN-0Q;
        Mon, 25 Sep 2023 16:30:31 +0000
Date:   Tue, 26 Sep 2023 00:30:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Simon Horman <horms@kernel.org>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: kismet: WARNING: unmet direct dependencies detected for FIXED_PHY
 when selected by LAN743X
Message-ID: <202309260045.nVvxZdWb-lkp@intel.com>
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
head:   6465e260f48790807eef06b583b38ca9789b6072
commit: 73c4d1b307aeb713e80ab03f90c7df9d417dc0f0 net: lan743x: select FIXED_PHY
date:   3 months ago
config: i386-kismet-CONFIG_FIXED_PHY-CONFIG_LAN743X-0-0 (https://download.01.org/0day-ci/archive/20230926/202309260045.nVvxZdWb-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20230926/202309260045.nVvxZdWb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309260045.nVvxZdWb-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for FIXED_PHY when selected by LAN743X
   .config:5306:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   .config:13319:warning: symbol value 'ONFIG_NR_CPUS_DEFAUL' invalid for NR_CPUS
   
   WARNING: unmet direct dependencies detected for FIXED_PHY
     Depends on [n]: NETDEVICES [=y] && PHYLIB [=n]
     Selected by [y]:
     - LAN743X [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
