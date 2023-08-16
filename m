Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831F177D86F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbjHPC1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241293AbjHPC0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:26:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C931FDC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 19:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692152797; x=1723688797;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2tRf3naf2c5ctxT7q+HHdzbvlkfLOsIUa5+Agb4rgas=;
  b=m1OjrNmHShS++E3O7kPuM9gJ2AdWCXiPi3xC68vc4/YQw+lYX29iRBc/
   Td+8Qz058IZiXd7qa/4t+a3hI+4bHURNNCZeFWSaLfa7mI1xDZUB9huRR
   MBtOuI1Uvrw19mxEz+XSzhjxnW3PmAbxPQcmMzp32kofKMPFhJEYvXSiF
   bwT2DSSXxA13eelcIXZgSe/aVelsnpK0Gp3I1ZZqZ/pBl4wNMtitY3xKP
   ewIrQ50QV1H4IqB8tJSn6/9VLLmG4M3u1PvY1LmRfZk3ubXCkb8MqJMod
   c6jl5wOifud1W3eXRsiN9USjZLhZYFCYdyAaJ6AytyPDopTVnJFq2Bd0l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458775788"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="458775788"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 19:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877585273"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2023 19:26:40 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qW6F1-0001Q7-1w;
        Wed, 16 Aug 2023 02:26:35 +0000
Date:   Wed, 16 Aug 2023 10:26:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.08.14a 48/51] kernel/rcu/tree_stall.h:11:10:
 fatal error: linux/rcu_notifier.h: No such file or directory
Message-ID: <202308161041.0EOMbdcX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.14a
head:   a90c4cbc91475bd5df35f712a954972fbfff40a1
commit: 815c9a53ab6b20e0dc90e733336151310a05cba2 [48/51] rcu: Add RCU CPU stall notifier
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20230816/202308161041.0EOMbdcX-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308161041.0EOMbdcX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308161041.0EOMbdcX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:5066:
>> kernel/rcu/tree_stall.h:11:10: fatal error: linux/rcu_notifier.h: No such file or directory
      11 | #include <linux/rcu_notifier.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +11 kernel/rcu/tree_stall.h

  > 11	#include <linux/rcu_notifier.h>
    12	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
