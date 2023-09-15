Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7117A14D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjIOEil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjIOEij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:38:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B5E2710
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694752713; x=1726288713;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZZLKoQSL6YEoCq1x8YD2Z64VjduC5d2dKjXE25gIXbU=;
  b=C4yETuDWmSbllUSlqmUWMuo2BAEvBXY2J/r9KzU5L6QeC+atmeGpeMOc
   OxGpp9lpQsgAWMuFTYmURzGxD0oFFQtwM3DOS0Q9XXyGLHAWDI0UGc8dn
   Z3KEXYqFiPf281B/IKP/lA6sPfCqaoBLShD1NvZNVqSq/sUNwArSc5gJC
   q2IplozEGwkmxABHZg8z/TQnNGMaFob7UdK5NNm1PHO5aZLQF/i6jyseL
   5uG2v4IEAw5FQmoSvLWsxQ8MCkwdf6TxoiDNrwV1tMoHlr95IqmfUgtOQ
   oG4FXrgpVVHe3s0onQZQ5fng6SUEBIDn018qUDj7GEVzbh4oQADHlB2q8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="443218045"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="443218045"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 21:33:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="1075659755"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="1075659755"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Sep 2023 21:33:34 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qh0WG-0002R3-0U;
        Fri, 15 Sep 2023 04:33:30 +0000
Date:   Fri, 15 Sep 2023 12:32:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Simon Horman <horms@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: icss_iep.c:undefined reference to `ptp_clock_index'
Message-ID: <202309151207.NPDMiINe-lkp@intel.com>
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
head:   9fdfb15a3dbf818e06be514f4abbfc071004cbe7
commit: c1e0230eeaab26984f6e5c5575486e96a63e2e48 net: ti: icss-iep: Add IEP driver
date:   3 weeks ago
config: arm64-randconfig-r012-20230514 (https://download.01.org/0day-ci/archive/20230915/202309151207.NPDMiINe-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309151207.NPDMiINe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309151207.NPDMiINe-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: aarch64-linux-ld: DWARF error: could not find abbrev number 7
   drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_get_ptp_clock_idx':
>> icss_iep.c:(.text+0x234): undefined reference to `ptp_clock_index'
   aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_exit':
>> icss_iep.c:(.text+0x5b4): undefined reference to `ptp_clock_unregister'
   aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_init':
>> icss_iep.c:(.text+0x14f0): undefined reference to `ptp_clock_register'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
