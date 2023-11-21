Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4987F27DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjKUIrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjKUIrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:47:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBB110D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700556445; x=1732092445;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HHXRgW9jtyyYucb3j55PPV8IpOiORDp9wIDflnAuoDA=;
  b=BuH6sK79Pozw3dFvXm/YsAAIwekh3bnNl98lY2V4rn2NKiMQrd2BOWSW
   eUxFEjf+fmgTnDTq2ZoHFFwq8UDbLJxE1tQwB25GP2yuyPfK0dUiVVy+4
   VPJf+ptSXDQWcEBHh/K/jMRgzbzyjXyTKM70N70kLkOWPhhaIpKLoJAX/
   W7RI8TPBuXGiZKh2vAiRCVuML8jk8L4jdD9TIr26MXGGZT7R0+j86oMxl
   Hx93mC5e5C1p41KrCCFV/6mr9tcuPSBdjR1oq94Uf8YH2OwKsHnC2e5lU
   OSkHEbq0Ettz7EnT38h13GxDZry3BVAB8imKVg6Mw2XywzpWd1apxJVwJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="4988628"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="4988628"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:47:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="7834835"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 21 Nov 2023 00:47:24 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5MPc-0007ah-2J;
        Tue, 21 Nov 2023 08:47:17 +0000
Date:   Tue, 21 Nov 2023 16:45:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] regulator: event: Add regulator netlink event support
Message-ID: <202311211612.t2XcssHt-lkp@intel.com>
References: <20231120194311.3581036-1-naresh.solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120194311.3581036-1-naresh.solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

kernel test robot noticed the following build errors:

[auto build test ERROR on 753e4d5c433da57da75dd4c3e1aececc8e874a62]

url:    https://github.com/intel-lab-lkp/linux/commits/Naresh-Solanki/regulator-event-Add-regulator-netlink-event-support/20231121-034604
base:   753e4d5c433da57da75dd4c3e1aececc8e874a62
patch link:    https://lore.kernel.org/r/20231120194311.3581036-1-naresh.solanki%409elements.com
patch subject: [PATCH v1] regulator: event: Add regulator netlink event support
config: loongarch-randconfig-r071-20231121 (https://download.01.org/0day-ci/archive/20231121/202311211612.t2XcssHt-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211612.t2XcssHt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211612.t2XcssHt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/regulator/event.c:110:5: error: conflicting types for 'reg_generate_netlink_event'; have 'int(const char *, const char *, u8,  int)' {aka 'int(const char *, const char *, unsigned char,  int)'}
     110 | int reg_generate_netlink_event(const char *device_class, const char *bus_id, u8 type, int data)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/regulator/event.c:6:
   drivers/regulator/regnl.h:6:5: note: previous declaration of 'reg_generate_netlink_event' with type 'int(const char *, u64)' {aka 'int(const char *, long long unsigned int)'}
       6 | int reg_generate_netlink_event(const char *reg_name, u64 event);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/kernel.h:18,
                    from include/linux/skbuff.h:13,
                    from include/linux/netlink.h:7,
                    from include/net/netlink.h:6,
                    from drivers/regulator/event.c:3:
   drivers/regulator/event.c:114:15: error: conflicting types for 'reg_generate_netlink_event'; have 'int(const char *, const char *, u8,  int)' {aka 'int(const char *, const char *, unsigned char,  int)'}
     114 | EXPORT_SYMBOL(reg_generate_netlink_event);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/export.h:74:28: note: in definition of macro '__EXPORT_SYMBOL'
      74 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   include/linux/export.h:86:41: note: in expansion of macro '_EXPORT_SYMBOL'
      86 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
         |                                         ^~~~~~~~~~~~~~
   drivers/regulator/event.c:114:1: note: in expansion of macro 'EXPORT_SYMBOL'
     114 | EXPORT_SYMBOL(reg_generate_netlink_event);
         | ^~~~~~~~~~~~~
   drivers/regulator/regnl.h:6:5: note: previous declaration of 'reg_generate_netlink_event' with type 'int(const char *, u64)' {aka 'int(const char *, long long unsigned int)'}
       6 | int reg_generate_netlink_event(const char *reg_name, u64 event);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +110 drivers/regulator/event.c

   108	
   109	#else
 > 110	int reg_generate_netlink_event(const char *device_class, const char *bus_id, u8 type, int data)
   111	{
   112		return 0;
   113	}
   114	EXPORT_SYMBOL(reg_generate_netlink_event);
   115	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
