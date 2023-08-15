Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E4D77CCAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237193AbjHOMbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbjHOMa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:30:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1E1D1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692102655; x=1723638655;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dkAwFDLCaiCqtDw24YGd2ktTM+uJiKX+nDBEWhIfqOY=;
  b=Dg5Y0xi9+Uai3mDiHCsW2isS/djc6MG9SJFrsHaaiIjO+zblR7+csx/N
   kXUa2qJcplneqOebXIZcF78qCe+b0E5kdofUVqxXEpoahnytfjirXszhp
   FEP66lhWbjfbhGmJgOu36A0TjSYPBqJ64SKmUNnDsdGfUpqaEgMVin1h4
   LYBG7An/ZXy8Y4Gzq6daxeiniMFNVVG6CerWspkrby1sa8VfmIzDuA9/1
   sepUWGzJYBbEvhWSs9jMnajH3q3HJAnp+GL+9Pz0NbkK6GRCwtSNfGZos
   /qAc0tcnjk4Uw7MS1dz+mRkSA1WZArMprRl2p6h/SBlLKNezIqzC8ptBo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362415613"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="362415613"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 05:30:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="727372085"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="727372085"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Aug 2023 05:30:52 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVtCF-0000xa-3C;
        Tue, 15 Aug 2023 12:30:51 +0000
Date:   Tue, 15 Aug 2023 20:30:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Andy Moreton <andy.moreton@amd.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: drivers/net/ethernet/sfc/falcon/selftest.c:45:16: warning: field ip
 within 'struct ef4_loopback_payload::(anonymous at
 drivers/net/ethernet/sfc/falcon/selftest.c:43:2)' is less aligned than
 'struct iphdr' and is usually due to 'struct ef4_loopback_payload...
Message-ID: <202308152020.SxCOJiOI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   91aa6c412d7f85e48aead7b00a7d9e91f5cf5863
commit: 55c1528f9b97ff3b7efad73e8f79627fc2efb298 sfc: fix field-spanning memcpy in selftest
date:   2 weeks ago
config: arm-randconfig-r011-20230815 (https://download.01.org/0day-ci/archive/20230815/202308152020.SxCOJiOI-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308152020.SxCOJiOI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308152020.SxCOJiOI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/sfc/falcon/selftest.c:45:16: warning: field ip within 'struct ef4_loopback_payload::(anonymous at drivers/net/ethernet/sfc/falcon/selftest.c:43:2)' is less aligned than 'struct iphdr' and is usually due to 'struct ef4_loopback_payload::(anonymous at drivers/net/ethernet/sfc/falcon/selftest.c:43:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
      45 |                 struct iphdr ip;
         |                              ^
>> drivers/net/ethernet/sfc/falcon/selftest.c:45:16: warning: field ip within 'struct ef4_loopback_payload::(unnamed at drivers/net/ethernet/sfc/falcon/selftest.c:43:2)' is less aligned than 'struct iphdr' and is usually due to 'struct ef4_loopback_payload::(unnamed at drivers/net/ethernet/sfc/falcon/selftest.c:43:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
   2 warnings generated.


vim +45 drivers/net/ethernet/sfc/falcon/selftest.c

5a6681e22c1409 Edward Cree 2016-11-28  34  
5a6681e22c1409 Edward Cree 2016-11-28  35  /*
5a6681e22c1409 Edward Cree 2016-11-28  36   * Loopback test packet structure
5a6681e22c1409 Edward Cree 2016-11-28  37   *
5a6681e22c1409 Edward Cree 2016-11-28  38   * The self-test should stress every RSS vector, and unfortunately
5a6681e22c1409 Edward Cree 2016-11-28  39   * Falcon only performs RSS on TCP/UDP packets.
5a6681e22c1409 Edward Cree 2016-11-28  40   */
5a6681e22c1409 Edward Cree 2016-11-28  41  struct ef4_loopback_payload {
1186c6b31ee14f Edward Cree 2023-06-23  42  	char pad[2]; /* Ensures ip is 4-byte aligned */
55c1528f9b97ff Edward Cree 2023-07-28  43  	struct_group_attr(packet, __packed,
5a6681e22c1409 Edward Cree 2016-11-28  44  		struct ethhdr header;
5a6681e22c1409 Edward Cree 2016-11-28 @45  		struct iphdr ip;
5a6681e22c1409 Edward Cree 2016-11-28  46  		struct udphdr udp;
5a6681e22c1409 Edward Cree 2016-11-28  47  		__be16 iteration;
5a6681e22c1409 Edward Cree 2016-11-28  48  		char msg[64];
55c1528f9b97ff Edward Cree 2023-07-28  49  	);
1186c6b31ee14f Edward Cree 2023-06-23  50  } __packed __aligned(4);
55c1528f9b97ff Edward Cree 2023-07-28  51  #define EF4_LOOPBACK_PAYLOAD_LEN	\
55c1528f9b97ff Edward Cree 2023-07-28  52  		sizeof_field(struct ef4_loopback_payload, packet)
5a6681e22c1409 Edward Cree 2016-11-28  53  

:::::: The code at line 45 was first introduced by commit
:::::: 5a6681e22c1409089132085811857d6da828761b sfc: separate out SFC4000 ("Falcon") support into new sfc-falcon driver

:::::: TO: Edward Cree <ecree@solarflare.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
