Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610FC765986
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjG0RHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjG0RHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:07:45 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7D89E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690477665; x=1722013665;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IVhmgYvk7Yl+FZSQ8/gaoLaT3W9kTSDKWkXI/r0IFJ8=;
  b=Wh1/+up6tPqb3O7WoahKZtKV14na6i50eCf779nszB5HvuK3uwFj4p8R
   Xpx9XNOurEowZnnFEWK+hAGJO/Tx4D0zv9mbI6HVTypeBhZUH6NHqCWvS
   Af+2YFSVh/tKtGioryHoZqR+peVvwYLcW0tC67X+S0tMYETvmlatf1bLy
   lGv1GMdC0fxSqyZV2V6S/optluz8A0lYj5g0M/EEn5C9ujZkWmFeaQiru
   npEMx74xC718Q0/jX3GLyHMukUQqLeplq8cPOZzMdyB4yUjO+yd0683N3
   Apvs83iWZ1sSbLYn6kG8NUIKUQhJVpnx6mAcsCvg0M8tQ0SowfSKs1J1U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="358396265"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="358396265"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 10:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="762248099"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="762248099"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Jul 2023 10:07:32 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qP4SZ-0002Rd-18;
        Thu, 27 Jul 2023 17:07:31 +0000
Date:   Fri, 28 Jul 2023 01:06:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/rv/monitors/wip/wip.c:20:1: sparse: sparse: symbol
 'da_mon_wip' was not declared. Should it be static?
Message-ID: <202307280030.7EjUG9gR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0a8db05b571ad5b8d5c8774a004c0424260a90bd
commit: 10bde81c74863472047f31304064018c40f488ee rv/monitor: Add the wip monitor
date:   12 months ago
config: i386-randconfig-i063-20230727 (https://download.01.org/0day-ci/archive/20230728/202307280030.7EjUG9gR-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307280030.7EjUG9gR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307280030.7EjUG9gR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/rv/monitors/wip/wip.c: note: in included file:
   kernel/trace/rv/monitors/wip/wip.h:30:22: sparse: sparse: symbol 'automaton_wip' was not declared. Should it be static?

vim +/da_mon_wip +20 kernel/trace/rv/monitors/wip/wip.c

8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  18  
8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29 @19  struct rv_monitor rv_wip;
8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29 @20  DECLARE_DA_MON_PER_CPU(wip, unsigned char);
8812d21219b9c6 Daniel Bristot de Oliveira 2022-07-29  21  

:::::: The code at line 20 was first introduced by commit
:::::: 8812d21219b9c649dd25eb93915e00939944aeb7 rv/monitor: Add the wip monitor skeleton created by dot2k

:::::: TO: Daniel Bristot de Oliveira <bristot@kernel.org>
:::::: CC: Steven Rostedt (Google) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
