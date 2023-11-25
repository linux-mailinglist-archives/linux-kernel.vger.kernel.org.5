Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE117F89CA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 10:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjKYJuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 04:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYJuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 04:50:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008C0E0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 01:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700905816; x=1732441816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TCt+iEfaSGWgIQZIfzmbjrCV+kFWZ7dJ6VUTIeE/jX0=;
  b=OuvxC6v6/yMAKJxmfjpqzUrX7Z/yPWJ/ggtJNl9H8XxX1QbZD7ADURg8
   lVMRBdLy8zBClDw6xOnhtlfL3VJ+8gVZK5ZHbqN9e9Za+35bxccU/0XjR
   FYo1hF1qfMt0PykISGroNPFoj2zfM1jvHYdcCjSa/7+oMB3/PaXF854+t
   SXyl6J+McJkBqIFqs/xTVqVl7CmaDGc/S6nqQc3JAvibr+i0FgZ31pB/t
   DfRJCW8rXgT3VtqGx9rDXPyZ2ljG2+6dbZGG8GyqzqtDTcZPuDVrS3c9Y
   FJSjwF2vgk8IMlniuz9niremGwsPaevWs4qP0RtQsKf+LZJqPdORuadfd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="389656147"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="389656147"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2023 01:50:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="885477614"
X-IronPort-AV: E=Sophos;i="6.04,226,1695711600"; 
   d="scan'208";a="885477614"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 25 Nov 2023 01:50:13 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6pIh-0003rB-0h;
        Sat, 25 Nov 2023 09:50:11 +0000
Date:   Sat, 25 Nov 2023 17:49:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     guoren@kernel.org, mark.rutland@arm.com, peterz@infradead.org,
        keescook@chromium.org, paulmck@kernel.org, ubizjak@gmail.com,
        tglx@linutronix.de
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2] locking/atomic: scripts: Increase template priority
 in order variants
Message-ID: <202311251758.xmI3qAhf-lkp@intel.com>
References: <20231125013025.3620560-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125013025.3620560-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on kees/for-next/kspp]
[cannot apply to linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/guoren-kernel-org/locking-atomic-scripts-Increase-template-priority-in-order-variants/20231125-093207
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/20231125013025.3620560-1-guoren%40kernel.org
patch subject: [PATCH V2] locking/atomic: scripts: Increase template priority in order variants
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231125/202311251758.xmI3qAhf-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311251758.xmI3qAhf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311251758.xmI3qAhf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
   In file included from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:11:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:23:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:3961:9: error: invalid output size for constraint '+q'
           return raw_xchg_acquire(&v->counter, new);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:27:26: note: expanded from macro 'raw_xchg_acquire'
   #define raw_xchg_acquire arch_xchg
                            ^
   arch/x86/include/asm/cmpxchg.h:78:27: note: expanded from macro 'arch_xchg'
   #define arch_xchg(ptr, v)       __xchg_op((ptr), (v), xchg, "")
                                   ^
   arch/x86/include/asm/cmpxchg.h:48:19: note: expanded from macro '__xchg_op'
                                         : "+q" (__ret), "+m" (*(ptr))     \
                                                 ^
   In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
   In file included from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:11:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:23:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:3985:9: error: invalid output size for constraint '+q'
           return raw_xchg_release(&v->counter, new);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:39:26: note: expanded from macro 'raw_xchg_release'
   #define raw_xchg_release arch_xchg
                            ^
   arch/x86/include/asm/cmpxchg.h:78:27: note: expanded from macro 'arch_xchg'
   #define arch_xchg(ptr, v)       __xchg_op((ptr), (v), xchg, "")
                                   ^
   arch/x86/include/asm/cmpxchg.h:48:19: note: expanded from macro '__xchg_op'
                                         : "+q" (__ret), "+m" (*(ptr))     \
                                                 ^
   In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
   In file included from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:11:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:23:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:4006:9: error: invalid output size for constraint '+q'
           return raw_xchg_relaxed(&v->counter, new);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:48:26: note: expanded from macro 'raw_xchg_relaxed'
   #define raw_xchg_relaxed arch_xchg
                            ^
   arch/x86/include/asm/cmpxchg.h:78:27: note: expanded from macro 'arch_xchg'
   #define arch_xchg(ptr, v)       __xchg_op((ptr), (v), xchg, "")
                                   ^
   arch/x86/include/asm/cmpxchg.h:48:19: note: expanded from macro '__xchg_op'
                                         : "+q" (__ret), "+m" (*(ptr))     \
                                                 ^
   In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
   In file included from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:11:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:23:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:4060:9: error: invalid output size for constraint '=a'
           return raw_cmpxchg_acquire(&v->counter, old, new);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:70:29: note: expanded from macro 'raw_cmpxchg_acquire'
   #define raw_cmpxchg_acquire arch_cmpxchg
                               ^
   arch/x86/include/asm/cmpxchg.h:149:2: note: expanded from macro 'arch_cmpxchg'
           __cmpxchg(ptr, old, new, sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:134:2: note: expanded from macro '__cmpxchg'
           __raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:95:17: note: expanded from macro '__raw_cmpxchg'
                                : "=a" (__ret), "+m" (*__ptr)              \
                                        ^
   In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
   In file included from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:11:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:23:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:4060:9: error: invalid output size for constraint '=a'
   include/linux/atomic/atomic-arch-fallback.h:70:29: note: expanded from macro 'raw_cmpxchg_acquire'
   #define raw_cmpxchg_acquire arch_cmpxchg
                               ^
   arch/x86/include/asm/cmpxchg.h:149:2: note: expanded from macro 'arch_cmpxchg'
           __cmpxchg(ptr, old, new, sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:134:2: note: expanded from macro '__cmpxchg'
           __raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:104:17: note: expanded from macro '__raw_cmpxchg'
                                : "=a" (__ret), "+m" (*__ptr)              \
                                        ^
   In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
   In file included from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:11:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:23:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:4060:9: error: invalid output size for constraint '=a'
   include/linux/atomic/atomic-arch-fallback.h:70:29: note: expanded from macro 'raw_cmpxchg_acquire'
   #define raw_cmpxchg_acquire arch_cmpxchg
                               ^
   arch/x86/include/asm/cmpxchg.h:149:2: note: expanded from macro 'arch_cmpxchg'
           __cmpxchg(ptr, old, new, sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:134:2: note: expanded from macro '__cmpxchg'
           __raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:113:17: note: expanded from macro '__raw_cmpxchg'
                                : "=a" (__ret), "+m" (*__ptr)              \
                                        ^
   In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
   In file included from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:11:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:23:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
>> include/linux/atomic/atomic-arch-fallback.h:4060:9: error: invalid output size for constraint '=a'
   include/linux/atomic/atomic-arch-fallback.h:70:29: note: expanded from macro 'raw_cmpxchg_acquire'
   #define raw_cmpxchg_acquire arch_cmpxchg
                               ^
   arch/x86/include/asm/cmpxchg.h:149:2: note: expanded from macro 'arch_cmpxchg'
           __cmpxchg(ptr, old, new, sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:134:2: note: expanded from macro '__cmpxchg'
           __raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:122:17: note: expanded from macro '__raw_cmpxchg'
                                : "=a" (__ret), "+m" (*__ptr)              \
                                        ^
   In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
   In file included from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:11:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:23:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:4085:9: error: invalid output size for constraint '=a'
           return raw_cmpxchg_release(&v->counter, old, new);
                  ^
   include/linux/atomic/atomic-arch-fallback.h:82:29: note: expanded from macro 'raw_cmpxchg_release'
   #define raw_cmpxchg_release arch_cmpxchg
                               ^
   arch/x86/include/asm/cmpxchg.h:149:2: note: expanded from macro 'arch_cmpxchg'
           __cmpxchg(ptr, old, new, sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:134:2: note: expanded from macro '__cmpxchg'
           __raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:95:17: note: expanded from macro '__raw_cmpxchg'
                                : "=a" (__ret), "+m" (*__ptr)              \
                                        ^
   In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
   In file included from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:11:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:23:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:4085:9: error: invalid output size for constraint '=a'
   include/linux/atomic/atomic-arch-fallback.h:82:29: note: expanded from macro 'raw_cmpxchg_release'
   #define raw_cmpxchg_release arch_cmpxchg
                               ^
   arch/x86/include/asm/cmpxchg.h:149:2: note: expanded from macro 'arch_cmpxchg'
           __cmpxchg(ptr, old, new, sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:134:2: note: expanded from macro '__cmpxchg'
           __raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:104:17: note: expanded from macro '__raw_cmpxchg'
                                : "=a" (__ret), "+m" (*__ptr)              \
                                        ^
   In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
   In file included from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:11:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:23:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:4085:9: error: invalid output size for constraint '=a'
   include/linux/atomic/atomic-arch-fallback.h:82:29: note: expanded from macro 'raw_cmpxchg_release'
   #define raw_cmpxchg_release arch_cmpxchg
                               ^
   arch/x86/include/asm/cmpxchg.h:149:2: note: expanded from macro 'arch_cmpxchg'
           __cmpxchg(ptr, old, new, sizeof(*(ptr)))
           ^
   arch/x86/include/asm/cmpxchg.h:134:2: note: expanded from macro '__cmpxchg'
           __raw_cmpxchg((ptr), (old), (new), (size), LOCK_PREFIX)
           ^
   arch/x86/include/asm/cmpxchg.h:113:17: note: expanded from macro '__raw_cmpxchg'
                                : "=a" (__ret), "+m" (*__ptr)              \
                                        ^
   In file included from arch/x86/entry/vdso/vdso32/vclock_gettime.c:4:
   In file included from arch/x86/entry/vdso/vdso32/../vclock_gettime.c:11:
   In file included from include/linux/time.h:60:
   In file included from include/linux/time32.h:13:
   In file included from include/linux/timex.h:67:
   In file included from arch/x86/include/asm/timex.h:5:
   In file included from arch/x86/include/asm/processor.h:23:
   In file included from arch/x86/include/asm/msr.h:11:
   In file included from arch/x86/include/asm/cpumask.h:5:
   In file included from include/linux/cpumask.h:13:
   In file included from include/linux/atomic.h:80:
   include/linux/atomic/atomic-arch-fallback.h:4085:9: error: invalid output size for constraint '=a'
   include/linux/atomic/atomic-arch-fallback.h:82:29: note: expanded from macro 'raw_cmpxchg_release'
   #define raw_cmpxchg_release arch_cmpxchg


vim +3961 include/linux/atomic/atomic-arch-fallback.h

d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3939  
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3940  /**
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3941   * raw_atomic64_xchg_acquire() - atomic exchange with acquire ordering
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3942   * @v: pointer to atomic64_t
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3943   * @new: s64 value to assign
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3944   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3945   * Atomically updates @v to @new with acquire ordering.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3946   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3947   * Safe to use in noinstr code; prefer atomic64_xchg_acquire() elsewhere.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3948   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3949   * Return: The original value of @v.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3950   */
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3951  static __always_inline s64
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3952  raw_atomic64_xchg_acquire(atomic64_t *v, s64 new)
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3953  {
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3954  #if defined(arch_atomic64_xchg_acquire)
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3955  	return arch_atomic64_xchg_acquire(v, new);
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3956  #elif defined(arch_atomic64_xchg_relaxed)
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3957  	s64 ret = arch_atomic64_xchg_relaxed(v, new);
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3958  	__atomic_acquire_fence();
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3959  	return ret;
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3960  #else
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05 @3961  	return raw_xchg_acquire(&v->counter, new);
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3962  #endif
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3963  }
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3964  
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3965  /**
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3966   * raw_atomic64_xchg_release() - atomic exchange with release ordering
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3967   * @v: pointer to atomic64_t
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3968   * @new: s64 value to assign
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3969   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3970   * Atomically updates @v to @new with release ordering.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3971   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3972   * Safe to use in noinstr code; prefer atomic64_xchg_release() elsewhere.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3973   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3974   * Return: The original value of @v.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3975   */
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3976  static __always_inline s64
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3977  raw_atomic64_xchg_release(atomic64_t *v, s64 new)
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3978  {
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3979  #if defined(arch_atomic64_xchg_release)
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3980  	return arch_atomic64_xchg_release(v, new);
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3981  #elif defined(arch_atomic64_xchg_relaxed)
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3982  	__atomic_release_fence();
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3983  	return arch_atomic64_xchg_relaxed(v, new);
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3984  #else
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3985  	return raw_xchg_release(&v->counter, new);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  3986  #endif
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3987  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  3988  
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3989  /**
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3990   * raw_atomic64_xchg_relaxed() - atomic exchange with relaxed ordering
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3991   * @v: pointer to atomic64_t
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3992   * @new: s64 value to assign
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3993   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3994   * Atomically updates @v to @new with relaxed ordering.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3995   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3996   * Safe to use in noinstr code; prefer atomic64_xchg_relaxed() elsewhere.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3997   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3998   * Return: The original value of @v.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  3999   */
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  4000  static __always_inline s64
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4001  raw_atomic64_xchg_relaxed(atomic64_t *v, s64 new)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  4002  {
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4003  #if defined(arch_atomic64_xchg_relaxed)
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4004  	return arch_atomic64_xchg_relaxed(v, new);
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4005  #else
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4006  	return raw_xchg_relaxed(&v->counter, new);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  4007  #endif
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4008  }
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  4009  
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4010  /**
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4011   * raw_atomic64_cmpxchg() - atomic compare and exchange with full ordering
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4012   * @v: pointer to atomic64_t
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4013   * @old: s64 value to compare with
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4014   * @new: s64 value to assign
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4015   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4016   * If (@v == @old), atomically updates @v to @new with full ordering.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4017   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4018   * Safe to use in noinstr code; prefer atomic64_cmpxchg() elsewhere.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4019   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4020   * Return: The original value of @v.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4021   */
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  4022  static __always_inline s64
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4023  raw_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  4024  {
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4025  #if defined(arch_atomic64_cmpxchg)
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4026  	return arch_atomic64_cmpxchg(v, old, new);
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4027  #elif defined(arch_atomic64_cmpxchg_relaxed)
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  4028  	s64 ret;
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  4029  	__atomic_pre_full_fence();
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4030  	ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  4031  	__atomic_post_full_fence();
37f8173dd84936 include/linux/atomic-arch-fallback.h        Peter Zijlstra 2020-01-24  4032  	return ret;
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4033  #else
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4034  	return raw_cmpxchg(&v->counter, old, new);
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4035  #endif
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4036  }
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4037  
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4038  /**
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4039   * raw_atomic64_cmpxchg_acquire() - atomic compare and exchange with acquire ordering
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4040   * @v: pointer to atomic64_t
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4041   * @old: s64 value to compare with
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4042   * @new: s64 value to assign
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4043   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4044   * If (@v == @old), atomically updates @v to @new with acquire ordering.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4045   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4046   * Safe to use in noinstr code; prefer atomic64_cmpxchg_acquire() elsewhere.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4047   *
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4048   * Return: The original value of @v.
ad8110706f3811 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4049   */
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4050  static __always_inline s64
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4051  raw_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4052  {
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4053  #if defined(arch_atomic64_cmpxchg_acquire)
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4054  	return arch_atomic64_cmpxchg_acquire(v, old, new);
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4055  #elif defined(arch_atomic64_cmpxchg_relaxed)
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4056  	s64 ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4057  	__atomic_acquire_fence();
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4058  	return ret;
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4059  #else
9257959a6e5b4f include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05 @4060  	return raw_cmpxchg_acquire(&v->counter, old, new);
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4061  #endif
1d78814d41701c include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4062  }
d12157efc8e083 include/linux/atomic/atomic-arch-fallback.h Mark Rutland   2023-06-05  4063  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
