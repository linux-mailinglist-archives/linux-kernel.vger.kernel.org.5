Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8987ACA32
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 17:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjIXPIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 11:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjIXPIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 11:08:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568FCCF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695568105; x=1727104105;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9lMEdEJ/jNPgXwR79cwContSPgzX3uPW3E2QXcSQzrc=;
  b=awDU8LSFaapZlJC2iC7iySLVbfppoKMWJIbEQPFrNFPWr72n2Kzlm2uB
   Nsa9IwZXxI0iXzwWF7XUBhezqYyc/7auxo5PB8myQZrxVk9DC3chRSMuG
   ITRFlfA+f89oVjbbwEIAT74UGjCjMGbgFLs0QJpRELhr7VCleSXF2cjD5
   8k9WYx5KEyVqZzvqO7XWA43giUGyFv9NgDc+RIp6pogzL48lVVH3dk17R
   IHhX7oJjHAvGDyb8ZhOb2fdOnMFsPXy7pVL2OdLgfV8J9LN5GWJwpYpyn
   QMcftYfkF4lBQDD/x//61TLiwDA3f2buKutlRFgq1y9EG7Hto9RDELZEf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445206892"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="445206892"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 08:08:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1078952539"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="1078952539"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 24 Sep 2023 08:08:22 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkQiX-0003pN-2s;
        Sun, 24 Sep 2023 15:08:18 +0000
Date:   Sun, 24 Sep 2023 23:07:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Simon Horman <horms@kernel.org>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: kismet: WARNING: unmet direct dependencies detected for FIXED_PHY
 when selected by LAN743X
Message-ID: <202309242300.16HQ5Db3-lkp@intel.com>
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
head:   3aba70aed91f2b283f7952be152ad76ec5c34975
commit: 73c4d1b307aeb713e80ab03f90c7df9d417dc0f0 net: lan743x: select FIXED_PHY
date:   3 months ago
config: i386-kismet-CONFIG_FIXED_PHY-CONFIG_LAN743X-0-0 (https://download.01.org/0day-ci/archive/20230924/202309242300.16HQ5Db3-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20230924/202309242300.16HQ5Db3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309242300.16HQ5Db3-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for FIXED_PHY when selected by LAN743X
   
   WARNING: unmet direct dependencies detected for FIXED_PHY
     Depends on [n]: NETDEVICES [=y] && PHYLIB [=n]
     Selected by [y]:
     - LAN743X [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
