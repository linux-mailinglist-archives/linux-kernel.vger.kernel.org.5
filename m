Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB00378A15E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 22:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjH0U0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 16:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjH0U0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 16:26:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93264128
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 13:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693167959; x=1724703959;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ovndHV9hLKdTZvQnsCTnqeQ+3Wl+RwYyqBnW8kOuPFA=;
  b=dXJRVYu1/igVMKyUuB2fzR2iVlsf+wX9vA3uJV1ho+xTueSbp23LMNV7
   k6ptrM9phqqlEk+UyiyAA46lqKzQ5QlfTfrOoWpGZn9rP3rAeM9nBsmsE
   ZQQ4wvUG80kIJHaNk0ewcS9i7+r01IXDCRd3z5ihGZ61KKbjl9rNqaS20
   0vUU0+we/5E8+2S+gD6a4C3Rk3ToTJZilmpZ4YxthpUD5QuA5lB/5TS25
   gvSERv9OUjTfs18krb+qM+0e8ohY86GUkRzQeTeUQOOFQNjV1A/hDybcC
   vgldjN2H0idEAKKGCpF0v9FqhUcm1FBC0dOqiSXKCcEtuugG14IQtIN37
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="359963380"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="359963380"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 13:25:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881709548"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2023 13:26:02 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaMKZ-0006AF-2z;
        Sun, 27 Aug 2023 20:25:55 +0000
Date:   Mon, 28 Aug 2023 04:25:48 +0800
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
Message-ID: <202308280404.zWFYpWWE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   85eb043618bb17124050197d71c453d4a1f556e5
commit: 55c1528f9b97ff3b7efad73e8f79627fc2efb298 sfc: fix field-spanning memcpy in selftest
date:   4 weeks ago
config: arm-randconfig-r001-20230828 (https://download.01.org/0day-ci/archive/20230828/202308280404.zWFYpWWE-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230828/202308280404.zWFYpWWE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308280404.zWFYpWWE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/sfc/selftest.c:48:16: warning: field ip within 'struct efx_loopback_payload::(anonymous at drivers/net/ethernet/sfc/selftest.c:46:2)' is less aligned than 'struct iphdr' and is usually due to 'struct efx_loopback_payload::(anonymous at drivers/net/ethernet/sfc/selftest.c:46:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
      48 |                 struct iphdr ip;
         |                              ^
>> drivers/net/ethernet/sfc/selftest.c:48:16: warning: field ip within 'struct efx_loopback_payload::(unnamed at drivers/net/ethernet/sfc/selftest.c:46:2)' is less aligned than 'struct iphdr' and is usually due to 'struct efx_loopback_payload::(unnamed at drivers/net/ethernet/sfc/selftest.c:46:2)' being packed, which can lead to unaligned accesses [-Wunaligned-access]
   2 warnings generated.


vim +48 drivers/net/ethernet/sfc/selftest.c

93e5dfa59b0e26a drivers/net/ethernet/sfc/selftest.c Ben Hutchings   2012-02-28  37  
3273c2e8c66a21a drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  38  /*
3273c2e8c66a21a drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  39   * Loopback test packet structure
3273c2e8c66a21a drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  40   *
3273c2e8c66a21a drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  41   * The self-test should stress every RSS vector, and unfortunately
3273c2e8c66a21a drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  42   * Falcon only performs RSS on TCP/UDP packets.
3273c2e8c66a21a drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  43   */
3273c2e8c66a21a drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  44  struct efx_loopback_payload {
cf60ed469629927 drivers/net/ethernet/sfc/selftest.c Edward Cree     2023-06-23  45  	char pad[2]; /* Ensures ip is 4-byte aligned */
55c1528f9b97ff3 drivers/net/ethernet/sfc/selftest.c Edward Cree     2023-07-28  46  	struct_group_attr(packet, __packed,
3273c2e8c66a21a drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  47  		struct ethhdr header;
3273c2e8c66a21a drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07 @48  		struct iphdr ip;
3273c2e8c66a21a drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  49  		struct udphdr udp;
3273c2e8c66a21a drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  50  		__be16 iteration;
1d20a16062e771b drivers/net/ethernet/sfc/selftest.c David S. Miller 2015-04-17  51  		char msg[64];
55c1528f9b97ff3 drivers/net/ethernet/sfc/selftest.c Edward Cree     2023-07-28  52  	);
cf60ed469629927 drivers/net/ethernet/sfc/selftest.c Edward Cree     2023-06-23  53  } __packed __aligned(4);
55c1528f9b97ff3 drivers/net/ethernet/sfc/selftest.c Edward Cree     2023-07-28  54  #define EFX_LOOPBACK_PAYLOAD_LEN	\
55c1528f9b97ff3 drivers/net/ethernet/sfc/selftest.c Edward Cree     2023-07-28  55  		sizeof_field(struct efx_loopback_payload, packet)
3273c2e8c66a21a drivers/net/sfc/selftest.c          Ben Hutchings   2008-05-07  56  

:::::: The code at line 48 was first introduced by commit
:::::: 3273c2e8c66a21ae1c53b0c730ee937c6efde7e2 [netdrvr] sfc: sfc: Add self-test support

:::::: TO: Ben Hutchings <bhutchings@solarflare.com>
:::::: CC: Jeff Garzik <jgarzik@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
