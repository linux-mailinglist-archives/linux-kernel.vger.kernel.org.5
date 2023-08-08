Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15899773C22
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjHHQAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjHHP6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:58:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837896190
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691509464; x=1723045464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QyCWV3QjNzfUnZv2+pg0lwlA/f/GlJHPMfP1AGZDu20=;
  b=cdAp/QXu7EOHDXNk1zCAjB874QpoTGzcRcpf3+IqKPi9LsZD3wphD9ya
   ++V5byB3ZenF73md0W4KOfIr1pBGavrTDDsTelbc0Bh1a7Er8iJUHJ8ba
   13vxzk8akpHrIRmd0oMPQ1/Mjx6so37xeCpqXUyWk/R2EPA97V+vvGlEs
   4MlXtj/kt321OYzMqqUv1ByBKWfP0erpg9CwKCepMOTSpyiNa5cQVrXh4
   i3IwI3tXNrGUGbDkd3o7jLrs+cODMWlcYxGZzbnbVZc90M1oRnQbY0mph
   LwXcx4S4WVLPH3IB25YGN3iDvC1jPa8VI3mcLI88KIaaawFjwA+VrfGoN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457230501"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="457230501"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 07:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="855118140"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="855118140"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Aug 2023 07:46:00 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTNyB-0005P6-0p;
        Tue, 08 Aug 2023 14:45:59 +0000
Date:   Tue, 8 Aug 2023 22:45:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>
Subject: arch/riscv/include/asm/syscall.h:87 syscall_handler() warn:
 inconsistent indenting
Message-ID: <202308082206.4tGQS0Nb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   14f9643dc90adea074a0ffb7a17d337eafc6a5cc
commit: f0bddf50586da81360627a772be0e355b62f071e riscv: entry: Convert to generic entry
date:   5 months ago
config: riscv-randconfig-m031-20230808 (https://download.01.org/0day-ci/archive/20230808/202308082206.4tGQS0Nb-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230808/202308082206.4tGQS0Nb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308082206.4tGQS0Nb-lkp@intel.com/

New smatch warnings:
arch/riscv/include/asm/syscall.h:87 syscall_handler() warn: inconsistent indenting

Old smatch warnings:
arch/riscv/kernel/traps.c:327 is_valid_bugaddr() warn: unsigned 'pc' is never less than zero.

vim +87 arch/riscv/include/asm/syscall.h

    76	
    77	typedef long (*syscall_t)(ulong, ulong, ulong, ulong, ulong, ulong, ulong);
    78	static inline void syscall_handler(struct pt_regs *regs, ulong syscall)
    79	{
    80		syscall_t fn;
    81	
    82	#ifdef CONFIG_COMPAT
    83		if ((regs->status & SR_UXL) == SR_UXL_32)
    84			fn = compat_sys_call_table[syscall];
    85		else
    86	#endif
  > 87			fn = sys_call_table[syscall];
    88	
    89		regs->a0 = fn(regs->orig_a0, regs->a1, regs->a2,
    90			      regs->a3, regs->a4, regs->a5, regs->a6);
    91	}
    92	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
