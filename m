Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A0B7E1899
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 03:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjKFC1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 21:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKFC1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 21:27:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982E4D6;
        Sun,  5 Nov 2023 18:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699237652; x=1730773652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2GJpYqysQuTF5tqL/b1VeNnpS+0M2mXiG2Sc6wszklQ=;
  b=ix4w//199YS1AIjn0/AYfqwrANvPFHlbDbIaOgJRuA0iXVsruSmXYGD2
   j8TWwUvx40fdU8WOufGtUpZVfEpzbkQuR4aPgCAQFLHM3tdWtZRk+s5WS
   338NSboLI6QdsBgGpEqaXg9r8pA8EyXIPEu6hqOXD7mavPkfLmTc5RpC+
   SSZhonOLv0NRDwJXy1KyeVea3lFHAB8Mki0XJt813RSi0Dexw+n4Qv9V4
   GGh4/HybLHJ/rnhbo0nkfiVv2VxnvyZChY0pQGvMku0Xp+Zr8kEynKCs7
   FYsSRm2ZPRTwl3BKwOOx+ExDzydjBneR6uCjXtcfe54mi1hRTRSCRR4lA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="420310411"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="420310411"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 18:27:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="885760713"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="885760713"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Nov 2023 18:27:28 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzpKn-00060u-2U;
        Mon, 06 Nov 2023 02:27:25 +0000
Date:   Mon, 6 Nov 2023 10:26:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, pkshih@realtek.com, larry.chiu@realtek.com,
        Justin Lai <justinlai0215@realtek.com>
Subject: Re: [PATCH net-next v10 12/13] net:ethernet:realtek: Update the
 Makefile and Kconfig in the realtek folder
Message-ID: <202311060957.C85OYvxq-lkp@intel.com>
References: <20231102154505.940783-13-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102154505.940783-13-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Lai/net-ethernet-realtek-rtase-Add-pci-table-supported-in-this-module/20231103-032946
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231102154505.940783-13-justinlai0215%40realtek.com
patch subject: [PATCH net-next v10 12/13] net:ethernet:realtek: Update the Makefile and Kconfig in the realtek folder
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231106/202311060957.C85OYvxq-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060957.C85OYvxq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060957.C85OYvxq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/realtek/rtase/rtase_main.c:68:10: fatal error: net/page_pool.h: No such file or directory
      68 | #include <net/page_pool.h>
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.


vim +68 drivers/net/ethernet/realtek/rtase/rtase_main.c

db2657d0fa3a98 Justin Lai 2023-11-02 @68  #include <net/page_pool.h>
db2657d0fa3a98 Justin Lai 2023-11-02  69  #include <net/pkt_cls.h>
db2657d0fa3a98 Justin Lai 2023-11-02  70  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
