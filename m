Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FF77E670E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjKIJrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjKIJqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:46:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F2B2D6D;
        Thu,  9 Nov 2023 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699523212; x=1731059212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ip+CQU2PiDpNSq4YwNpQlS7L41kfKCfH4bP+hTrn7Po=;
  b=NSsR9e7xdtnIho6hhFr6hseKHJ6DxDj399TnR8o/9fNf2HDrtMCPoWMq
   bcyF+P/CASKMTPrkQJssH0RZzDDMW4tXGQ+kTspMnOyn+gqX7AxBxoR8G
   5YPa9KhQJ+8HF2gR6SXsGnW0qqTppTOkcLef/Y8oXh/NE1XkBW1VrgjeL
   2D2VD27OrCkZgn3jTtxYeidHTIEVZilmphoPctDKuJbbeNoPELt18QLGw
   9o/szLl8uDl7k9etaeDKUs+Cj/QqTmLTzTkEWP5RAyKnlH7DW1Ao547cb
   CD6fsuugzmAQK3JkiCWPsL0ucgc5zM9rwuPgO459Ci02ngcnhC0CnPYp6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="11503982"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="11503982"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 01:46:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="798282364"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="798282364"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Nov 2023 01:46:43 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r11cW-0008d1-3D;
        Thu, 09 Nov 2023 09:46:41 +0000
Date:   Thu, 9 Nov 2023 17:46:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geoff Levand <geoff@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 15/22] arch: vdso: consolidate gettime prototypes
Message-ID: <202311091740.g315K93o-lkp@intel.com>
References: <20231108125843.3806765-16-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108125843.3806765-16-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[cannot apply to v6.6 next-20231109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/ida-make-ida_dump-static/20231109-005742
base:   linus/master
patch link:    https://lore.kernel.org/r/20231108125843.3806765-16-arnd%40kernel.org
patch subject: [PATCH 15/22] arch: vdso: consolidate gettime prototypes
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231109/202311091740.g315K93o-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311091740.g315K93o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311091740.g315K93o-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/um/vdso/um_vdso.c:17:5: error: conflicting types for '__vdso_clock_gettime'
      17 | int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
         |     ^
   include/vdso/gettime.h:16:5: note: previous declaration is here
      16 | int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
         |     ^
   arch/x86/um/vdso/um_vdso.c:58:1: warning: no previous prototype for function '__vdso_getcpu' [-Wmissing-prototypes]
      58 | __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
         | ^
   arch/x86/um/vdso/um_vdso.c:57:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
      57 | long
         | ^
         | static 
   1 warning and 1 error generated.


vim +/__vdso_clock_gettime +17 arch/x86/um/vdso/um_vdso.c

f1c2bb8b9964ed arch/um/sys-x86_64/vdso/um_vdso.c Richard Weinberger 2011-07-25  16  
82210fc778982d arch/x86/um/vdso/um_vdso.c        Arnd Bergmann      2019-10-27 @17  int __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
f1c2bb8b9964ed arch/um/sys-x86_64/vdso/um_vdso.c Richard Weinberger 2011-07-25  18  {
f1c2bb8b9964ed arch/um/sys-x86_64/vdso/um_vdso.c Richard Weinberger 2011-07-25  19  	long ret;
f1c2bb8b9964ed arch/um/sys-x86_64/vdso/um_vdso.c Richard Weinberger 2011-07-25  20  
5541992e512de8 arch/x86/um/vdso/um_vdso.c        Ammar Faizi        2022-12-24  21  	asm("syscall"
5541992e512de8 arch/x86/um/vdso/um_vdso.c        Ammar Faizi        2022-12-24  22  		: "=a" (ret)
5541992e512de8 arch/x86/um/vdso/um_vdso.c        Ammar Faizi        2022-12-24  23  		: "0" (__NR_clock_gettime), "D" (clock), "S" (ts)
5541992e512de8 arch/x86/um/vdso/um_vdso.c        Ammar Faizi        2022-12-24  24  		: "rcx", "r11", "memory");
f1c2bb8b9964ed arch/um/sys-x86_64/vdso/um_vdso.c Richard Weinberger 2011-07-25  25  
f1c2bb8b9964ed arch/um/sys-x86_64/vdso/um_vdso.c Richard Weinberger 2011-07-25  26  	return ret;
f1c2bb8b9964ed arch/um/sys-x86_64/vdso/um_vdso.c Richard Weinberger 2011-07-25  27  }
82210fc778982d arch/x86/um/vdso/um_vdso.c        Arnd Bergmann      2019-10-27  28  int clock_gettime(clockid_t, struct __kernel_old_timespec *)
f1c2bb8b9964ed arch/um/sys-x86_64/vdso/um_vdso.c Richard Weinberger 2011-07-25  29  	__attribute__((weak, alias("__vdso_clock_gettime")));
f1c2bb8b9964ed arch/um/sys-x86_64/vdso/um_vdso.c Richard Weinberger 2011-07-25  30  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
