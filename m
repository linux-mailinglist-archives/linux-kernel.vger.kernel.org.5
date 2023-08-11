Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DC3779777
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbjHKTCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjHKTCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:02:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A94530ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691780549; x=1723316549;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GCTJDuNfQjRI0Mvfmc1myTRrBjeXtraJrL7wFDMzXho=;
  b=dcp5CZ+RTkCBTaRhsa/M313M0aUFiJ7+Ozl3AX87c2tN8WA66wRD+ZXK
   OVgeESVjkmtAtF6zeo8nJ1wFHd9GLHm5J/rf/Ro7s9rkRfMLskqWf4RN+
   JdcZmHWx4FFk6sZVUJUm/tX16l9H3DdxerdNTR/Dv35fuZWwiyUXacz0F
   ScujjXqlntTdfgVy5Wj90SZMywmkIzLXdlO1C9bqLjIEMt5XMXwcySZZn
   lgjp3yvyqO3/MxiXdyCfD9KNre5NE/zipCH4Gixi7LKc9bXVQSbjMzfzJ
   0jTZe7/eVBnIAxfdG8mm/d6B1eow0tZ39vuaa8mLA5YYnhRq7LaR+IfnQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="402719670"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="402719670"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 12:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="802768889"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="802768889"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2023 12:01:50 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUXOP-0007xg-06;
        Fri, 11 Aug 2023 19:01:49 +0000
Date:   Sat, 12 Aug 2023 03:01:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202308120240.nHv97bTv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qing,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9106536c1aa37bcf60202ad93bb8b94bcd29f3f0
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   1 year ago
config: loongarch-randconfig-r072-20230811 (https://download.01.org/0day-ci/archive/20230812/202308120240.nHv97bTv-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308120240.nHv97bTv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308120240.nHv97bTv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got unsigned int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got unsigned int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got unsigned int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got unsigned int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got int [noderef] __percpu *
>> fs/eventpoll.c:620:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:620:9: sparse:     expected void *ptr
   fs/eventpoll.c:620:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:692:9: sparse:     expected void *ptr
   fs/eventpoll.c:692:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1456:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1456:9: sparse:     expected void *ptr
   fs/eventpoll.c:1456:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1571:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1571:9: sparse:     expected void *ptr
   fs/eventpoll.c:1571:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got unsigned int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got int [noderef] __percpu *
   fs/eventpoll.c:1775:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   fs/eventpoll.c:1775:9: sparse:     expected void *ptr
   fs/eventpoll.c:1775:9: sparse:     got int [noderef] __percpu *

vim +620 fs/eventpoll.c

eea1d585917c53 Eric Wong       2013-04-30  604  
92e64178405599 Davidlohr Bueso 2018-08-21  605  
5071f97ec6d74f Davide Libenzi  2009-03-31  606  /*
57804b1cc46167 Al Viro         2020-08-31  607   * ep->mutex needs to be held because we could be hit by
e057e15ff66a62 Tony Battersby  2009-03-31  608   * eventpoll_release_file() and epoll_ctl().
5071f97ec6d74f Davide Libenzi  2009-03-31  609   */
57804b1cc46167 Al Viro         2020-08-31  610  static void ep_start_scan(struct eventpoll *ep, struct list_head *txlist)
57804b1cc46167 Al Viro         2020-08-31  611  {
5071f97ec6d74f Davide Libenzi  2009-03-31  612  	/*
5071f97ec6d74f Davide Libenzi  2009-03-31  613  	 * Steal the ready list, and re-init the original one to the
5071f97ec6d74f Davide Libenzi  2009-03-31  614  	 * empty list. Also, set ep->ovflist to NULL so that events
5071f97ec6d74f Davide Libenzi  2009-03-31  615  	 * happening while looping w/out locks, are not lost. We cannot
5071f97ec6d74f Davide Libenzi  2009-03-31  616  	 * have the poll callback to queue directly on ep->rdllist,
5071f97ec6d74f Davide Libenzi  2009-03-31  617  	 * because we want the "sproc" callback to be able to do it
5071f97ec6d74f Davide Libenzi  2009-03-31  618  	 * in a lockless way.
5071f97ec6d74f Davide Libenzi  2009-03-31  619  	 */
57804b1cc46167 Al Viro         2020-08-31 @620  	lockdep_assert_irqs_enabled();
a218cc4914209a Roman Penyaev   2019-03-07  621  	write_lock_irq(&ep->lock);
db502f8a3b0bb5 Al Viro         2020-08-31  622  	list_splice_init(&ep->rdllist, txlist);
c5a282e9635e9c Davidlohr Bueso 2019-01-03  623  	WRITE_ONCE(ep->ovflist, NULL);
a218cc4914209a Roman Penyaev   2019-03-07  624  	write_unlock_irq(&ep->lock);
db502f8a3b0bb5 Al Viro         2020-08-31  625  }
5071f97ec6d74f Davide Libenzi  2009-03-31  626  

:::::: The code at line 620 was first introduced by commit
:::::: 57804b1cc4616780c72a2d0930d1bd0d5bd3ed4c lift locking/unlocking ep->mtx out of ep_{start,done}_scan()

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
