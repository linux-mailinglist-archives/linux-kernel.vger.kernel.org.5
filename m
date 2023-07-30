Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCCC768945
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 01:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjG3XU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 19:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3XU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 19:20:56 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E3011B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 16:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690759255; x=1722295255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6Aw4/lrxucmFXF6W+uR8/t0g4Kq178PLlA2njxWbOVU=;
  b=Iecu9C7dCnjp/R3dcACTU5XSXI/Z8q2WZrk1mcOJdorP2+rS+z+GiXPR
   WTw1kjxDCp/hgEr5jMumDSUzXTzB08A3EXkmICxrR1epusbelNisvZd6H
   JSKz7jRkjuhXWKPwud5FSuqc1CAPqO2lZAsZ5oMtSGLJY0E8Ec1gldIWp
   +edoXXy+F6wmTjQJPR/VsmuYQ3XIM2itnD0jdxuengoS79+DtGh1hSFqx
   iKaa+GxFQ5I25dooGMiOqcg3dzEXRnvPauiW3Th7EUZENabdi53D29ZiN
   UDB/El5AtZk3fszwNiwxj47E8DESvmr7hV8SMO4CFb1YhRwD6MhEXqKRP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="372513606"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="372513606"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2023 16:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="818110163"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; 
   d="scan'208";a="818110163"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jul 2023 16:20:46 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQFiP-0004ox-2Z;
        Sun, 30 Jul 2023 23:20:45 +0000
Date:   Mon, 31 Jul 2023 07:20:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: kernel/sched/psi.c:1479:17: error: implicit declaration of function
 'kernfs_generic_poll'
Message-ID: <202307310732.r65EQFY0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
commit: aff037078ecaecf34a7c2afab1341815f90fba5e sched/psi: use kernfs polling functions for PSI trigger polling
date:   3 weeks ago
config: nios2-randconfig-r011-20230731 (https://download.01.org/0day-ci/archive/20230731/202307310732.r65EQFY0-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230731/202307310732.r65EQFY0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307310732.r65EQFY0-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:97:
   kernel/sched/psi.c: In function 'psi_trigger_poll':
>> kernel/sched/psi.c:1479:17: error: implicit declaration of function 'kernfs_generic_poll' [-Werror=implicit-function-declaration]
    1479 |                 kernfs_generic_poll(t->of, wait);
         |                 ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/kernfs_generic_poll +1479 kernel/sched/psi.c

  1464	
  1465	__poll_t psi_trigger_poll(void **trigger_ptr,
  1466					struct file *file, poll_table *wait)
  1467	{
  1468		__poll_t ret = DEFAULT_POLLMASK;
  1469		struct psi_trigger *t;
  1470	
  1471		if (static_branch_likely(&psi_disabled))
  1472			return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
  1473	
  1474		t = smp_load_acquire(trigger_ptr);
  1475		if (!t)
  1476			return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
  1477	
  1478		if (t->of)
> 1479			kernfs_generic_poll(t->of, wait);
  1480		else
  1481			poll_wait(file, &t->event_wait, wait);
  1482	
  1483		if (cmpxchg(&t->event, 1, 0) == 1)
  1484			ret |= EPOLLPRI;
  1485	
  1486		return ret;
  1487	}
  1488	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
