Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42666804C32
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344804AbjLEIXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjLEIXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:23:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634C2138;
        Tue,  5 Dec 2023 00:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701764597; x=1733300597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gcfTZdhA5gWjXKrvaXBrEm3hhlOaQHfXwYwZPdM9PEM=;
  b=gtiujLQ88TUa2gLcB7zFDT4/vJTF8IXajM02kDKEXqH8oLG/me8CfC3M
   zsUpi9qKSBBn9V6dhQ2p9KsGov+Yw4+0cVGhcDmsBeJ9PAE6hEfGLNLa2
   5Qjjpjt/hrNrGJkFM8bGySzpvBLPd+//XmIKpTNy17+HbzB5iISS2fYW8
   68meM16kqc7biPywvIY7s8yPRxhINqpQU26yHSaPMosA72EdmNLMT367j
   H8CnfMgVWV9nccnptF3QAncdbUxhxu7xXugHKEL8o0FmVIhz3kzgbH1AZ
   y2aALm8bGTDSoMWfyLVdjxdg5g2AvjVZ5FfND5+Ll0GnCgukYj6qR3EBm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="384259759"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="384259759"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 00:23:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="764248993"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="764248993"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Dec 2023 00:23:16 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAQi2-0008Zp-06;
        Tue, 05 Dec 2023 08:23:14 +0000
Date:   Tue, 5 Dec 2023 16:23:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     YangXin <yx.0xffff@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ___neigh_lookup_noref(): remove redundant parameters
Message-ID: <202312051637.EOZ86jSh-lkp@intel.com>
References: <20231204185943.68-1-yx.0xffff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204185943.68-1-yx.0xffff@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YangXin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.7-rc4 next-20231205]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/YangXin/net-___neigh_lookup_noref-remove-redundant-parameters/20231205-030205
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231204185943.68-1-yx.0xffff%40gmail.com
patch subject: [PATCH] net: ___neigh_lookup_noref(): remove redundant parameters
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231205/202312051637.EOZ86jSh-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051637.EOZ86jSh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051637.EOZ86jSh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/net/route.h:28,
                    from include/net/ip.h:30,
                    from include/net/busy_poll.h:18,
                    from drivers/net/ethernet/sfc/falcon/net_driver.h:29,
                    from drivers/net/ethernet/sfc/falcon/efx.c:21:
   include/net/arp.h: In function '__ipv4_neigh_lookup_noref':
   include/net/arp.h:27:64: error: passing argument 3 of '___neigh_lookup_noref' from incompatible pointer type [-Werror=incompatible-pointer-types]
      27 |         return ___neigh_lookup_noref(&arp_tbl, neigh_key_eq32, &key, dev);
         |                                                                ^~~~
         |                                                                |
         |                                                                u32 * {aka unsigned int *}
   In file included from include/net/dst.h:20,
                    from include/net/sock.h:66,
                    from include/linux/tcp.h:19,
                    from drivers/net/ethernet/sfc/falcon/efx.c:15:
   include/net/neighbour.h:296:28: note: expected 'struct net_device *' but argument is of type 'u32 *' {aka 'unsigned int *'}
     296 |         struct net_device *dev)
         |         ~~~~~~~~~~~~~~~~~~~^~~
   include/net/arp.h:27:16: error: too many arguments to function '___neigh_lookup_noref'
      27 |         return ___neigh_lookup_noref(&arp_tbl, neigh_key_eq32, &key, dev);
         |                ^~~~~~~~~~~~~~~~~~~~~
   include/net/neighbour.h:293:33: note: declared here
     293 | static inline struct neighbour *___neigh_lookup_noref(
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/net/route.h:29:
   include/net/ndisc.h: In function '__ipv6_neigh_lookup_noref':
>> include/net/ndisc.h:383:64: warning: passing argument 3 of '___neigh_lookup_noref' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     383 |         return ___neigh_lookup_noref(&nd_tbl, neigh_key_eq128, pkey, dev);
         |                                                                ^~~~
   include/net/neighbour.h:296:28: note: expected 'struct net_device *' but argument is of type 'const void *'
     296 |         struct net_device *dev)
         |         ~~~~~~~~~~~~~~~~~~~^~~
   include/net/ndisc.h:383:16: error: too many arguments to function '___neigh_lookup_noref'
     383 |         return ___neigh_lookup_noref(&nd_tbl, neigh_key_eq128, pkey, dev);
         |                ^~~~~~~~~~~~~~~~~~~~~
   include/net/neighbour.h:293:33: note: declared here
     293 | static inline struct neighbour *___neigh_lookup_noref(
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   include/net/ndisc.h: In function '__ipv6_neigh_lookup_noref_stub':
   include/net/ndisc.h:390:74: warning: passing argument 3 of '___neigh_lookup_noref' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     390 |         return ___neigh_lookup_noref(ipv6_stub->nd_tbl, neigh_key_eq128, pkey, dev);
         |                                                                          ^~~~
   include/net/neighbour.h:296:28: note: expected 'struct net_device *' but argument is of type 'const void *'
     296 |         struct net_device *dev)
         |         ~~~~~~~~~~~~~~~~~~~^~~
   include/net/ndisc.h:390:16: error: too many arguments to function '___neigh_lookup_noref'
     390 |         return ___neigh_lookup_noref(ipv6_stub->nd_tbl, neigh_key_eq128, pkey, dev);
         |                ^~~~~~~~~~~~~~~~~~~~~
   include/net/neighbour.h:293:33: note: declared here
     293 | static inline struct neighbour *___neigh_lookup_noref(
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +383 include/net/ndisc.h

   380	
   381	static inline struct neighbour *__ipv6_neigh_lookup_noref(struct net_device *dev, const void *pkey)
   382	{
 > 383		return ___neigh_lookup_noref(&nd_tbl, neigh_key_eq128, pkey, dev);
   384	}
   385	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
