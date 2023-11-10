Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFF27E8554
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 23:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjKJWLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 17:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKJWLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 17:11:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BBE4229
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 14:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699654271; x=1731190271;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QBwFMb5kaZyckytqVjHFltF8fASd9MKlX3D3+cefOhQ=;
  b=aY7vX0/YdZUwZ913s/53wy9jBwmOkR6qkJVKYJ4CToTxhZEJ0ekLYA78
   23T8JUhqmCCcFS2WRr8oMSzJdO5RA1bY6fOt0dPPXKlRGRPoa5iA3SiVW
   Dv5zAbU4S4kvRro9k3ZeCPtwNrY4hx6D5uECEyjFlauAeUnEJk2baDKr5
   qrHDQm3L79Jz/jXr4iBT05EBXcpN2lg7YlkPkpeeGzomGeNPzbebbS1QV
   2ZhEpFbWpBt/FHkzcVrYbY5aolB2sY3ltMo1TggowOIWV7S8hlnmytq3j
   RfAGiDlC1OhbGec4PtOo8Nn4u8ADrfr7ynYquGbo+tgRFTdNvMUq73TVB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="456735063"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="456735063"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 14:11:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="11572558"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Nov 2023 14:11:09 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1ZiU-0009xe-3D;
        Fri, 10 Nov 2023 22:11:07 +0000
Date:   Sat, 11 Nov 2023 06:10:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: arch/x86/lib/insn-eval.c:907: warning: Function parameter or member
 'base_offset' not described in 'get_eff_addr_sib'
Message-ID: <202311110537.or2lAihp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ac347a0655dbc7d885e217c89dddd16e2800bd58
commit: 70e57c0f4b502f2435b7649a201861fe212c2e4e x86/insn-eval: Compute linear address in several utility functions
date:   6 years ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20231111/202311110537.or2lAihp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311110537.or2lAihp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311110537.or2lAihp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/workqueue.h:9,
                    from include/linux/rhashtable.h:26,
                    from include/linux/ipc.h:7,
                    from include/uapi/linux/sem.h:5,
                    from include/linux/sem.h:9,
                    from include/linux/sched.h:15,
                    from include/linux/ratelimit.h:6,
                    from arch/x86/lib/insn-eval.c:8:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:179:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     179 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                              ^
   include/linux/timer.h:144:39: note: in definition of macro '__setup_timer'
     144 |                 (_timer)->function = (_fn);                             \
         |                                       ^~~
   arch/x86/lib/insn-eval.c: In function 'resolve_default_seg':
   arch/x86/lib/insn-eval.c:179:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
     179 |                 if (insn->addr_bytes == 2)
         |                    ^
   arch/x86/lib/insn-eval.c:182:9: note: here
     182 |         case -EDOM:
         |         ^~~~
>> arch/x86/lib/insn-eval.c:907: warning: Function parameter or member 'base_offset' not described in 'get_eff_addr_sib'
>> arch/x86/lib/insn-eval.c:907: warning: Excess function parameter 'regoff' description in 'get_eff_addr_sib'


vim +907 arch/x86/lib/insn-eval.c

70e57c0f4b502f Ricardo Neri 2017-11-05  882  
70e57c0f4b502f Ricardo Neri 2017-11-05  883  /**
70e57c0f4b502f Ricardo Neri 2017-11-05  884   * get_eff_addr_sib() - Obtain referenced effective address via SIB
70e57c0f4b502f Ricardo Neri 2017-11-05  885   * @insn:	Instruction. Must be valid.
70e57c0f4b502f Ricardo Neri 2017-11-05  886   * @regs:	Register values as seen when entering kernel mode
70e57c0f4b502f Ricardo Neri 2017-11-05  887   * @regoff:	Obtained operand offset, in pt_regs, associated with segment
70e57c0f4b502f Ricardo Neri 2017-11-05  888   * @eff_addr:	Obtained effective address
70e57c0f4b502f Ricardo Neri 2017-11-05  889   *
70e57c0f4b502f Ricardo Neri 2017-11-05  890   * Obtain the effective address referenced by the SIB byte of @insn. After
70e57c0f4b502f Ricardo Neri 2017-11-05  891   * identifying the registers involved in the indexed, register-indirect memory
70e57c0f4b502f Ricardo Neri 2017-11-05  892   * reference, its value is obtained from the operands in @regs. The computed
70e57c0f4b502f Ricardo Neri 2017-11-05  893   * address is stored @eff_addr. Also, the register operand that indicates the
70e57c0f4b502f Ricardo Neri 2017-11-05  894   * associated segment is stored in @regoff, this parameter can later be used to
70e57c0f4b502f Ricardo Neri 2017-11-05  895   * determine such segment.
70e57c0f4b502f Ricardo Neri 2017-11-05  896   *
70e57c0f4b502f Ricardo Neri 2017-11-05  897   * Returns:
70e57c0f4b502f Ricardo Neri 2017-11-05  898   *
70e57c0f4b502f Ricardo Neri 2017-11-05  899   * 0 on success. @eff_addr will have the referenced effective address.
70e57c0f4b502f Ricardo Neri 2017-11-05  900   * @base_offset will have a register, as an offset from the base of pt_regs,
70e57c0f4b502f Ricardo Neri 2017-11-05  901   * that can be used to resolve the associated segment.
70e57c0f4b502f Ricardo Neri 2017-11-05  902   *
70e57c0f4b502f Ricardo Neri 2017-11-05  903   * -EINVAL on error.
70e57c0f4b502f Ricardo Neri 2017-11-05  904   */
70e57c0f4b502f Ricardo Neri 2017-11-05  905  static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
70e57c0f4b502f Ricardo Neri 2017-11-05  906  			    int *base_offset, long *eff_addr)
32542ee295bec3 Ricardo Neri 2017-10-27 @907  {

:::::: The code at line 907 was first introduced by commit
:::::: 32542ee295bec38e5e1608f8c9d6d28e5a7e6112 x86/mpx, x86/insn: Relocate insn util functions to a new insn-eval file

:::::: TO: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
