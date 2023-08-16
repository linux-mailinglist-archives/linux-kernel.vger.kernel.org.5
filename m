Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B5677D8F1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbjHPDUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241419AbjHPDTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:19:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2550B1FCA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 20:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692155979; x=1723691979;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CkXtmHegSk/PkmcFdzJevFUzfjawOHUoTx9CiuDiLa0=;
  b=mtPk5AteM6iGbODA0yp2aMAPahTtDx+MHX4sHn4LBVK9JGEon+g+ojD9
   u948dtS60yJBefSx0UWDbBmF8xRS+8KrFk6UScPU0GAaq75ZI9qlP2mHL
   kVvxJO1sBmQqwlVPi9feIDmvBxXtsXFBqtDskIzUEnDFYihbbW8atjTww
   PS34IUd7fV2IvP60G5dr3uDzc4uCgwvQspEYXVXJGnO87zLgCELXMGHsK
   D2zrqpcy/4Wl2af/bz0TSCGFwNKxyvRrTa21hJMyuf0PztAp4wuxIDxMU
   Xhu5MoXm53Tn7zIvNT7lyrdBiYlERvRkSlwf6/uYoR0eiraSeoC/yrbH3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403408302"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="403408302"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 20:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="804041982"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="804041982"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2023 20:19:37 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qW74K-0001Rb-2m;
        Wed, 16 Aug 2023 03:19:36 +0000
Date:   Wed, 16 Aug 2023 11:19:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2023.08.14a 49/51] kernel/rcu/rcutorture.c:24:10:
 fatal error: 'linux/rcu_notifier.h' file not found
Message-ID: <202308161157.fjx0zzow-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2023.08.14a
head:   a90c4cbc91475bd5df35f712a954972fbfff40a1
commit: 37730a9ba11627b63d8108dd8b3061ea2ee04df9 [49/51] rcutorture: Add test of RCU CPU stall notifiers
config: x86_64-randconfig-x004-20230816 (https://download.01.org/0day-ci/archive/20230816/202308161157.fjx0zzow-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308161157.fjx0zzow-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308161157.fjx0zzow-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/rcu/rcutorture.c:24:10: fatal error: 'linux/rcu_notifier.h' file not found
   #include <linux/rcu_notifier.h>
            ^~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +24 kernel/rcu/rcutorture.c

    14	
    15	#include <linux/types.h>
    16	#include <linux/kernel.h>
    17	#include <linux/init.h>
    18	#include <linux/module.h>
    19	#include <linux/kthread.h>
    20	#include <linux/err.h>
    21	#include <linux/spinlock.h>
    22	#include <linux/smp.h>
    23	#include <linux/rcupdate_wait.h>
  > 24	#include <linux/rcu_notifier.h>
    25	#include <linux/interrupt.h>
    26	#include <linux/sched/signal.h>
    27	#include <uapi/linux/sched/types.h>
    28	#include <linux/atomic.h>
    29	#include <linux/bitops.h>
    30	#include <linux/completion.h>
    31	#include <linux/moduleparam.h>
    32	#include <linux/percpu.h>
    33	#include <linux/notifier.h>
    34	#include <linux/reboot.h>
    35	#include <linux/freezer.h>
    36	#include <linux/cpu.h>
    37	#include <linux/delay.h>
    38	#include <linux/stat.h>
    39	#include <linux/srcu.h>
    40	#include <linux/slab.h>
    41	#include <linux/trace_clock.h>
    42	#include <asm/byteorder.h>
    43	#include <linux/torture.h>
    44	#include <linux/vmalloc.h>
    45	#include <linux/sched/debug.h>
    46	#include <linux/sched/sysctl.h>
    47	#include <linux/oom.h>
    48	#include <linux/tick.h>
    49	#include <linux/rcupdate_trace.h>
    50	#include <linux/nmi.h>
    51	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
