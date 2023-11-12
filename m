Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E107E90B2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjKLNaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjKLN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:28:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE533859
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 05:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699795703; x=1731331703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7RN+VzWptdlNS9vRqnpuq6kB7A27ydki0bvO3LaOzwo=;
  b=Oeda/6A0YLkAyAS42ZXUM+Pm46oxEPTUbFKeLrlJL4FUQdUulesDP/ra
   02YmHFplbzxfxFXuvf/lXmFgaR8M4PBtvkzobDXIGZkoJPwAIQHzyW0li
   T8uh+L7mwxvWvBB0Rc0ajhTNc91k2oGW+darze9Us9P/led81zNZ4VXyz
   vCSAC2suvGflNP5DzLCUVKsfdYhkUSiCYIvOQj9loHy24+SNIuyVaOzNb
   qvo1+tvL8dEwfsFUBCdkgFhvUmbPf+ypy/4aDLpNh5cBrymH/cROG8N2x
   uUVnc/uUROdWGrmryGlu1sR7MxJmiHVAX7EVb9yZ4PpxrDwxVlY9xh+B4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="393199340"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="393199340"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 05:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="834507769"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="834507769"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Nov 2023 05:28:20 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r2AVe-000BB8-1i;
        Sun, 12 Nov 2023 13:28:18 +0000
Date:   Sun, 12 Nov 2023 21:27:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: kernel/sched/sched.h:1619:25: sparse: sparse: incompatible types in
 comparison expression (different address spaces):
Message-ID: <202311122138.PP9yi2N4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b907d0507354b74a4f2c286380cd6059af79248
commit: 4104a562e0ca62e971089db9d3c47794a0d7d4eb sched/core: Annotate curr pointer in rq with __rcu
date:   3 years, 9 months ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231112/202311122138.PP9yi2N4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311122138.PP9yi2N4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311122138.PP9yi2N4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/core.c:510:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] <asn:4> *curr @@
   kernel/sched/core.c:510:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:510:38: sparse:     got struct task_struct [noderef] <asn:4> *curr
   kernel/sched/core.c:1444:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] <asn:4> *curr @@
   kernel/sched/core.c:1444:33: sparse:     expected struct task_struct *p
   kernel/sched/core.c:1444:33: sparse:     got struct task_struct [noderef] <asn:4> *curr
   kernel/sched/core.c:1444:68: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] <asn:4> *curr @@
   kernel/sched/core.c:1444:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:1444:68: sparse:     got struct task_struct [noderef] <asn:4> *curr
   kernel/sched/core.c:3589:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] <asn:4> *curr @@
   kernel/sched/core.c:3589:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:3589:38: sparse:     got struct task_struct [noderef] <asn:4> *curr
   kernel/sched/core.c:4010:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] <asn:4> *curr @@
   kernel/sched/core.c:4010:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:4010:14: sparse:     got struct task_struct [noderef] <asn:4> *curr
   kernel/sched/core.c:4430:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:4430:17: sparse:    struct task_struct *
   kernel/sched/core.c:4430:17: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/core.c:4629:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:4629:22: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/core.c:4629:22: sparse:    struct task_struct *
   kernel/sched/core.c:7926:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] <asn:4> *curr @@
   kernel/sched/core.c:7926:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:7926:25: sparse:     got struct task_struct [noderef] <asn:4> *curr
>> kernel/sched/core.c:1427:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1428:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1431:40: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c: note: in included file:
>> kernel/sched/sched.h:1619:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1619:25: sparse:    struct task_struct [noderef] <asn:4> *
>> kernel/sched/sched.h:1619:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1764:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1764:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1764:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1764:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1764:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1764:9: sparse:    struct task_struct *
>> kernel/sched/sched.h:1619:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1619:25: sparse:    struct task_struct [noderef] <asn:4> *
>> kernel/sched/sched.h:1619:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1764:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1764:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1764:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1770:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1770:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1770:9: sparse:    struct task_struct *
>> kernel/sched/sched.h:1619:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1619:25: sparse:    struct task_struct [noderef] <asn:4> *
>> kernel/sched/sched.h:1619:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1764:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1764:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1764:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1770:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1770:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1770:9: sparse:    struct task_struct *
>> kernel/sched/sched.h:1619:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1619:25: sparse:    struct task_struct [noderef] <asn:4> *
>> kernel/sched/sched.h:1619:25: sparse:    struct task_struct *
   kernel/sched/sched.h:1764:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1764:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1764:9: sparse:    struct task_struct *
   kernel/sched/sched.h:1770:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1770:9: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/sched.h:1770:9: sparse:    struct task_struct *
>> kernel/sched/sched.h:1619:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1619:25: sparse:    struct task_struct [noderef] <asn:4> *
>> kernel/sched/sched.h:1619:25: sparse:    struct task_struct *
--
>> kernel/sched/rt.c:910:70: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:910:70: sparse:    struct task_struct [noderef] <asn:4> *
>> kernel/sched/rt.c:910:70: sparse:    struct task_struct *
   kernel/sched/rt.c:996:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] <asn:4> *curr @@
   kernel/sched/rt.c:996:38: sparse:     expected struct task_struct *curr
   kernel/sched/rt.c:996:38: sparse:     got struct task_struct [noderef] <asn:4> *curr
   kernel/sched/rt.c:1422:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] <asn:4> *curr @@
   kernel/sched/rt.c:1422:31: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:1422:31: sparse:     got struct task_struct [noderef] <asn:4> *curr
   kernel/sched/rt.c:2275:46: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2275:46: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/rt.c:2275:46: sparse:    struct task_struct *
   kernel/sched/rt.c:2298:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2298:22: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/rt.c:2298:22: sparse:    struct task_struct *
   kernel/sched/rt.c: note: in included file:
>> kernel/sched/sched.h:1619:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1619:25: sparse:    struct task_struct [noderef] <asn:4> *
>> kernel/sched/sched.h:1619:25: sparse:    struct task_struct *
--
   kernel/sched/deadline.c:1719:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity *b @@     got struct sched_dl_entity [noderef] <asn:4> * @@
   kernel/sched/deadline.c:1719:42: sparse:     expected struct sched_dl_entity *b
   kernel/sched/deadline.c:1719:42: sparse:     got struct sched_dl_entity [noderef] <asn:4> *
   kernel/sched/deadline.c:1052:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] <asn:4> *curr @@
   kernel/sched/deadline.c:1052:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1052:23: sparse:     got struct task_struct [noderef] <asn:4> *curr
   kernel/sched/deadline.c:1181:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] <asn:4> *curr @@
   kernel/sched/deadline.c:1181:38: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1181:38: sparse:     got struct task_struct [noderef] <asn:4> *curr
>> kernel/sched/deadline.c:2383:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2383:22: sparse:    struct task_struct [noderef] <asn:4> *
>> kernel/sched/deadline.c:2383:22: sparse:    struct task_struct *
   kernel/sched/deadline.c:2402:46: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2402:46: sparse:    struct task_struct [noderef] <asn:4> *
   kernel/sched/deadline.c:2402:46: sparse:    struct task_struct *
   kernel/sched/deadline.c: note: in included file:
>> kernel/sched/sched.h:1619:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:1619:25: sparse:    struct task_struct [noderef] <asn:4> *
>> kernel/sched/sched.h:1619:25: sparse:    struct task_struct *

vim +1619 kernel/sched/sched.h

029632fbb7b7c9 kernel/sched.h Peter Zijlstra 2011-10-25  1616  
029632fbb7b7c9 kernel/sched.h Peter Zijlstra 2011-10-25  1617  static inline int task_current(struct rq *rq, struct task_struct *p)
029632fbb7b7c9 kernel/sched.h Peter Zijlstra 2011-10-25  1618  {
029632fbb7b7c9 kernel/sched.h Peter Zijlstra 2011-10-25 @1619  	return rq->curr == p;
029632fbb7b7c9 kernel/sched.h Peter Zijlstra 2011-10-25  1620  }
029632fbb7b7c9 kernel/sched.h Peter Zijlstra 2011-10-25  1621  

:::::: The code at line 1619 was first introduced by commit
:::::: 029632fbb7b7c9d85063cc9eb470de6c54873df3 sched: Make separate sched*.c translation units

:::::: TO: Peter Zijlstra <a.p.zijlstra@chello.nl>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
