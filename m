Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A948A7830AF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjHUTBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjHUTBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:01:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7F03C19
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692644485; x=1724180485;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1MZsQ8+jftqlEqF5TqG7ViteX4VHYpdU+NLSuN1XZoI=;
  b=IfDipeMjLXfODxnjkMtKphmzzqwuVSFUDDMs28s/x8vhEgHj5pqTH9YJ
   g7uhzqI3cO6ZwMNntNMeHd4YUWAI1d7QDxBS7bMD0y/IDZhthXgwUfXX+
   uXekd70cBgGlemd3aMFN+EgYNuYjrgfuMCKw2q7GYeV295chgtiTjWcZ1
   s+dEBgnQLJnBV2GkBoOKts1HDwRJDgdq/MhNQtXBzyYu+bJRsOHFP9oYA
   nrnjXff6mAC5AeCm1Oc8sGvmtjgSy3Y66BV6PlSRrxLoZzUxKQZQYUDg6
   lF2kvsUv/NSgGTzcBOfdnAYdFf0184Fc28AVWbeh84Q0cJ905T4VTBKL/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="377417118"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="377417118"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 11:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="685755155"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="685755155"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2023 11:38:34 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qY9nK-0000ni-2k;
        Mon, 21 Aug 2023 18:38:32 +0000
Date:   Tue, 22 Aug 2023 02:37:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: kernel/trace/trace_events.c:2102:37: warning: 'ftrace_event_id_fops'
 defined but not used
Message-ID: <202308220210.4uvlS2Zx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f7757129e3dea336c407551c98f50057c22bb266
commit: 93a4fa622eb061f75f87f0cf9609ab4e69c67d01 LoongArch: Add STACKTRACE support
date:   1 year ago
config: loongarch-randconfig-r014-20230821 (https://download.01.org/0day-ci/archive/20230822/202308220210.4uvlS2Zx-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308220210.4uvlS2Zx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308220210.4uvlS2Zx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_events.c:2102:37: warning: 'ftrace_event_id_fops' defined but not used [-Wunused-const-variable=]
    2102 | static const struct file_operations ftrace_event_id_fops = {
         |                                     ^~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/locking/lockdep.c:61:
>> kernel/locking/lockdep_internals.h:69:28: warning: 'LOCKF_USED_IN_IRQ_READ' defined but not used [-Wunused-const-variable=]
      69 | static const unsigned long LOCKF_USED_IN_IRQ_READ =
         |                            ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/locking/lockdep_internals.h:63:28: warning: 'LOCKF_ENABLED_IRQ_READ' defined but not used [-Wunused-const-variable=]
      63 | static const unsigned long LOCKF_ENABLED_IRQ_READ =
         |                            ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/locking/lockdep_internals.h:57:28: warning: 'LOCKF_USED_IN_IRQ' defined but not used [-Wunused-const-variable=]
      57 | static const unsigned long LOCKF_USED_IN_IRQ =
         |                            ^~~~~~~~~~~~~~~~~
>> kernel/locking/lockdep_internals.h:51:28: warning: 'LOCKF_ENABLED_IRQ' defined but not used [-Wunused-const-variable=]
      51 | static const unsigned long LOCKF_ENABLED_IRQ =
         |                            ^~~~~~~~~~~~~~~~~


vim +/ftrace_event_id_fops +2102 kernel/trace/trace_events.c

981d081ec8b958 Steven Rostedt 2009-03-02  2101  
23725aeeab10ba Peter Zijlstra 2009-03-19 @2102  static const struct file_operations ftrace_event_id_fops = {
23725aeeab10ba Peter Zijlstra 2009-03-19  2103  	.read = event_id_read,
6038f373a3dc1f Arnd Bergmann  2010-08-15  2104  	.llseek = default_llseek,
23725aeeab10ba Peter Zijlstra 2009-03-19  2105  };
23725aeeab10ba Peter Zijlstra 2009-03-19  2106  

:::::: The code at line 2102 was first introduced by commit
:::::: 23725aeeab10ba02bcf10ec49ad73146b54cb52f ftrace: provide an id file for each event

:::::: TO: Peter Zijlstra <a.p.zijlstra@chello.nl>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
