Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0711C7BCAA1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344227AbjJHAnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjJHAno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:43:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F07B6
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 17:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696725822; x=1728261822;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Dhi6J5BMnQ4CXSxmhqjnimc3+DsvWKxzmJpa6AiWYEM=;
  b=lgn9R+FyCHYDYspPmcqdGt8iIXOY473DeLSv0hodPEr/VjmOUe0R3uL4
   xpj7ZlWf1+ISa1bA2emMFPUxYko4JsTwmW9fCnCEzezem7/8jvy0Y2BdH
   5COevw/TNWKS2QdsnT+SnxsP4lLZk5Q6NhPuUfpruszyqTJWh9LzP3p64
   N12qjbJ0yKq55pY93DPUarbuigXWeRcddbP1Au3xCm1eeRkfHS7JEb5yK
   WVnQO7Rn9XjM11J12Ij0mBSLZqlIKwHq/Iu1XyEjnvH1+Sk0sxoVG8uDh
   2FbC448yrir8lUuNM4+3NGDH3U5mKJc/vDoaH/+/L5KJqwR8Z5VEDMSF6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="363321685"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="363321685"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 17:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="926377179"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="926377179"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2023 17:43:39 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpHtR-0004yR-19;
        Sun, 08 Oct 2023 00:43:37 +0000
Date:   Sun, 8 Oct 2023 08:43:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: [tip:x86/percpu 12/12] arch/x86/include/asm/preempt.h:27:55: sparse:
 sparse: incompatible types for operation (&):
Message-ID: <202310080853.UhMe5iWa-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
head:   ca4256348660cb2162668ec3d13d1f921d05374a
commit: ca4256348660cb2162668ec3d13d1f921d05374a [12/12] x86/percpu: Use C for percpu read/write accessors
config: x86_64-randconfig-122-20231007 (https://download.01.org/0day-ci/archive/20231008/202310080853.UhMe5iWa-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231008/202310080853.UhMe5iWa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310080853.UhMe5iWa-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/bpf/percpu_freelist.c: note: in included file (through arch/x86/include/asm/preempt.h, include/linux/preempt.h, include/linux/spinlock.h, ...):
   arch/x86/include/asm/percpu.h:550:49: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/percpu.h:550:49: sparse: sparse: got __seg_gs
   arch/x86/include/asm/percpu.h:564:33: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/percpu.h:564:33: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c: note: in included file (through arch/x86/include/asm/cpufeature.h, arch/x86/include/asm/thread_info.h, include/linux/thread_info.h, ...):
   arch/x86/include/asm/processor.h:504:9: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/processor.h:504:9: sparse: sparse: got __seg_gs
   arch/x86/include/asm/processor.h:504:9: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/processor.h:504:9: sparse: sparse: got __seg_gs
   arch/x86/include/asm/processor.h:504:9: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/processor.h:504:9: sparse: sparse: got __seg_gs
   arch/x86/include/asm/processor.h:504:9: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/processor.h:504:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c: note: in included file (through include/linux/preempt.h, include/linux/spinlock.h, kernel/bpf/percpu_freelist.h):
   arch/x86/include/asm/preempt.h:27:16: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:27:16: sparse: sparse: got __seg_gs
   arch/x86/include/asm/preempt.h:34:15: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:34:15: sparse: sparse: got __seg_gs
   arch/x86/include/asm/preempt.h:38:19: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:38:19: sparse: sparse: got __seg_gs
   arch/x86/include/asm/preempt.h:61:9: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:61:9: sparse: sparse: got __seg_gs
   arch/x86/include/asm/preempt.h:66:9: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:66:9: sparse: sparse: got __seg_gs
   arch/x86/include/asm/preempt.h:71:18: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:71:18: sparse: sparse: got __seg_gs
   arch/x86/include/asm/preempt.h:80:9: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:80:9: sparse: sparse: got __seg_gs
   arch/x86/include/asm/preempt.h:80:9: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:80:9: sparse: sparse: got __seg_gs
   arch/x86/include/asm/preempt.h:80:9: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:80:9: sparse: sparse: got __seg_gs
   arch/x86/include/asm/preempt.h:85:9: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:85:9: sparse: sparse: got __seg_gs
   arch/x86/include/asm/preempt.h:85:9: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:85:9: sparse: sparse: got __seg_gs
   arch/x86/include/asm/preempt.h:85:9: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:85:9: sparse: sparse: got __seg_gs
   arch/x86/include/asm/preempt.h:95:16: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:95:16: sparse: sparse: got __seg_gs
   arch/x86/include/asm/preempt.h:104:16: sparse: sparse: Expected ) at end of cast operator
   arch/x86/include/asm/preempt.h:104:16: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:61:20: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:61:20: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:61:20: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:61:20: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:61:20: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:61:20: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:61:20: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:61:20: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:86:39: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:86:39: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:127:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: got __seg_gs
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: Expected ) at end of cast operator
   kernel/bpf/percpu_freelist.c:159:9: sparse: sparse: got __seg_gs
>> arch/x86/include/asm/preempt.h:27:55: sparse: sparse: incompatible types for operation (&):
>> arch/x86/include/asm/preempt.h:27:55: sparse:    void
>> arch/x86/include/asm/preempt.h:27:55: sparse:    unsigned int
>> arch/x86/include/asm/preempt.h:27:55: sparse: sparse: incompatible types for operation (&):
>> arch/x86/include/asm/preempt.h:27:55: sparse:    void
>> arch/x86/include/asm/preempt.h:27:55: sparse:    unsigned int

vim +27 arch/x86/include/asm/preempt.h

ba1f14fbe70965 Peter Zijlstra  2013-11-28  20  
c2daa3bed53a81 Peter Zijlstra  2013-08-14  21  /*
c2daa3bed53a81 Peter Zijlstra  2013-08-14  22   * We mask the PREEMPT_NEED_RESCHED bit so as not to confuse all current users
c2daa3bed53a81 Peter Zijlstra  2013-08-14  23   * that think a non-zero value indicates we cannot preempt.
c2daa3bed53a81 Peter Zijlstra  2013-08-14  24   */
c2daa3bed53a81 Peter Zijlstra  2013-08-14  25  static __always_inline int preempt_count(void)
c2daa3bed53a81 Peter Zijlstra  2013-08-14  26  {
64701838bf0575 Thomas Gleixner 2022-09-15 @27  	return raw_cpu_read_4(pcpu_hot.preempt_count) & ~PREEMPT_NEED_RESCHED;
c2daa3bed53a81 Peter Zijlstra  2013-08-14  28  }
c2daa3bed53a81 Peter Zijlstra  2013-08-14  29  

:::::: The code at line 27 was first introduced by commit
:::::: 64701838bf0575ef8acb1ad2db5934e864f3e6c3 x86/percpu: Move preempt_count next to current_task

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
