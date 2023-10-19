Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFA77D02E5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346442AbjJST7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjJST7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:59:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94397114
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697745570; x=1729281570;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5L6DwHPhQ/sS54GokL5hmmQt1T0criMmAS8sdr+4Im8=;
  b=FmhPmenqOwjH1o5snw+k6iqwTQbcpjd73jDa/hSUXvy5Kq+21tDqqLDO
   i8WTWLy7G2qV7SzBzVS8gGhIOBXqdKKbnGFZFuMIA8Xt7ooMnhMFR79rq
   xBYgfqoExYcZ8BNIMpwvsksPT48w5iDqc5wVnO6Evr1ALAmAsygFybJmG
   AWYqLFKjTx866RH7yyTEUIsRvNWv9GvN1bA/foQgc5tTMQ3C75Ca5nYBH
   1vUD6xUmXFvqYLjdYg8eXRpibALkODCPY8WmlO/5bgJjqdbu4tHlo/q58
   NSsUnCQJxd5KJcuwd+c0XuuAqplFAG57md3Iuo59UaWUZuxzrAn7FqBNY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="386178728"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="386178728"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 12:59:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="750650646"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="750650646"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2023 12:59:27 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtZAz-0002Xq-1t;
        Thu, 19 Oct 2023 19:59:25 +0000
Date:   Fri, 20 Oct 2023 03:59:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [paulmck-rcu:mmap_sem.2023.10.18a 31/31] task_mmu.c:undefined
 reference to `__bad_udelay'
Message-ID: <202310200320.JSEpTicA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git mmap_sem.2023.10.18a
head:   4015256f2bc734d4175381762282784597f41cfa
commit: 4015256f2bc734d4175381762282784597f41cfa [31/31] EXP TESTING: introduce delay between getting a VMA and using it in show_map
config: arm-randconfig-002-20231019 (https://download.01.org/0day-ci/archive/20231020/202310200320.JSEpTicA-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310200320.JSEpTicA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310200320.JSEpTicA-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: fs/proc/task_mmu.o: in function `show_map':
>> task_mmu.c:(.text+0x6c4): undefined reference to `__bad_udelay'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
