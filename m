Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037357F3840
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjKUV0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjKUV0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:26:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08881DD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 13:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700601970; x=1732137970;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yWltos9U073xVdxGr9Xw4dPqFUsPE1sLwJOtk0Fu1Io=;
  b=Oq4WxujUpxFi8xgBtZAhfBRDdoyORljuMoT9TWzrzgywcs33gnHpvbS2
   hFrG5or/a9zenY7vrOAzYG9ut5NwUTsEtZq/4N5AQf01QnWcyuQ9raaNL
   ysLkeXbNJf0GHbIIRUufSblS7yYXVfCue8LOjanyuYYiRvlWQIQxbLVcG
   1XR/wL+EVtph+frHFJAK+5c8oIKNUuIouWa5MKgt8T6fNo9k1lGCQFF39
   HfpxTKrAxeRh9iRsg9PPMRaPj0nM7fbZD3a128AMr3bfxuFKd7E5PNo7c
   VAy5PkZL92ycFvlz2U9/KPevJSaC0x3OLTrE4VAXuPUEeorQ6RpRdoiqp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="456265165"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="456265165"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:26:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1098163044"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="1098163044"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 21 Nov 2023 13:26:01 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5YFr-0008Gw-0O;
        Tue, 21 Nov 2023 21:25:59 +0000
Date:   Wed, 22 Nov 2023 05:25:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Andy Moreton <andy.moreton@amd.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: drivers/net/ethernet/sfc/selftest.c:48:16: warning: field ip within
 'struct efx_loopback_payload::(anonymous at
 drivers/net/ethernet/sfc/selftest.c:46:2)' is less aligned than 'struct
 iphdr' and is usually due to 'struct efx_loopback_payload::(anonymous a...
Message-ID: <202311220537.geMTr31W-lkp@intel.com>
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

Hi Edward,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: 55c1528f9b97ff3b7efad73e8f79627fc2efb298 sfc: fix field-spanning memcpy in selftest
date:   4 months ago
config: arm-randconfig-003-20231122 (https://download.01.org/0day-ci/archive/20231122/202311220537.geMTr31W-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220537.geMTr31W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220537.geMTr31W-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/sfc/selftest.c:48:16: warning: field ip within 'struct efx_loopback_payload::(anonymous at drivers/net/ethernet/sfc/selftest.c:46:2)' is less aligned than 'struct iphdr' and is usually due to 'struct efx_loopback_payload::(anonymous at drivers/net/ethernet/sfc/selftest.c:46:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
      48 |                 struct iphdr ip;
         |                              ^
>> drivers/net/ethernet/sfc/selftest.c:48:16: warning: field ip within 'struct efx_loopback_payload::(unnamed at drivers/net/ethernet/sfc/selftest.c:46:2)' is less aligned than 'struct iphdr' and is usually due to 'struct efx_loopback_payload::(unnamed at drivers/net/ethernet/sfc/selftest.c:46:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
   2 warnings generated.
--
>> drivers/net/ethernet/sfc/falcon/selftest.c:45:16: warning: field ip within 'struct ef4_loopback_payload::(anonymous at drivers/net/ethernet/sfc/falcon/selftest.c:43:2)' is less aligned than 'struct iphdr' and is usually due to 'struct ef4_loopback_payload::(anonymous at drivers/net/ethernet/sfc/falcon/selftest.c:43:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
      45 |                 struct iphdr ip;
         |                              ^
>> drivers/net/ethernet/sfc/falcon/selftest.c:45:16: warning: field ip within 'struct ef4_loopback_payload::(unnamed at drivers/net/ethernet/sfc/falcon/selftest.c:43:2)' is less aligned than 'struct iphdr' and is usually due to 'struct ef4_loopback_payload::(unnamed at drivers/net/ethernet/sfc/falcon/selftest.c:43:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
   2 warnings generated.


vim +48 drivers/net/ethernet/sfc/selftest.c

93e5dfa59b0e26 drivers/net/ethernet/sfc/selftest.c Ben Hutchings   2012-02-28  37  
3273c2e8c66a21 drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  38  /*
3273c2e8c66a21 drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  39   * Loopback test packet structure
3273c2e8c66a21 drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  40   *
3273c2e8c66a21 drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  41   * The self-test should stress every RSS vector, and unfortunately
3273c2e8c66a21 drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  42   * Falcon only performs RSS on TCP/UDP packets.
3273c2e8c66a21 drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  43   */
3273c2e8c66a21 drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  44  struct efx_loopback_payload {
cf60ed46962992 drivers/net/ethernet/sfc/selftest.c Edward Cree     2023-06-23  45  	char pad[2]; /* Ensures ip is 4-byte aligned */
55c1528f9b97ff drivers/net/ethernet/sfc/selftest.c Edward Cree     2023-07-28  46  	struct_group_attr(packet, __packed,
3273c2e8c66a21 drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  47  		struct ethhdr header;
3273c2e8c66a21 drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07 @48  		struct iphdr ip;
3273c2e8c66a21 drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  49  		struct udphdr udp;
3273c2e8c66a21 drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  50  		__be16 iteration;
1d20a16062e771 drivers/net/ethernet/sfc/selftest.c David S. Miller 2015-04-17  51  		char msg[64];
55c1528f9b97ff drivers/net/ethernet/sfc/selftest.c Edward Cree     2023-07-28  52  	);
cf60ed46962992 drivers/net/ethernet/sfc/selftest.c Edward Cree     2023-06-23  53  } __packed __aligned(4);
55c1528f9b97ff drivers/net/ethernet/sfc/selftest.c Edward Cree     2023-07-28  54  #define EFX_LOOPBACK_PAYLOAD_LEN	\
55c1528f9b97ff drivers/net/ethernet/sfc/selftest.c Edward Cree     2023-07-28  55  		sizeof_field(struct efx_loopback_payload, packet)
3273c2e8c66a21 drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  56  

:::::: The code at line 48 was first introduced by commit
:::::: 3273c2e8c66a21ae1c53b0c730ee937c6efde7e2 [netdrvr] sfc: sfc: Add self-test support

:::::: TO: Ben Hutchings <bhutchings@solarflare.com>
:::::: CC: Jeff Garzik <jgarzik@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
