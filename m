Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3F97E6195
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjKIAqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjKIAqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:46:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA4C19A3;
        Wed,  8 Nov 2023 16:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699490761; x=1731026761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z2FrfTnHBfSdoKNm7WfvRCuIqwLKe5cJG+xNskgdhKY=;
  b=jEMP188uoT4AUiJgSyDLGHw/FnHhpKV0+KAwPifMQ8du1ZGVLONdLc51
   0D5TLn24ybyWgTcnRhJZ1Fzrx6607hKoCmpjnmpDBBWwI020Djb8caoN1
   R1nb2H4K6NORxrueSKntjhOzk1Vtqj3J4Uai8XvS4fR3XX9B7MjFitaQc
   adpRVCXr5ZcEZ4W1O60ipwALpzdEoMdaCXj8cjfgqRMQxuMAtilkkVgE0
   HUyLZRbKglNTFMl8fHdCRp0GHo3bOjvj+CAJzFTScIkzIdigcKpXN2fqn
   3z/94zGH3LPLXnY9e/FPu4a9vjWYBe3RAMEGhZ2iYW3t14YXD9vf4mh4l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="2848928"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="2848928"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 16:46:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="792364352"
X-IronPort-AV: E=Sophos;i="6.03,287,1694761200"; 
   d="scan'208";a="792364352"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Nov 2023 16:45:52 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0tB8-0008Lg-02;
        Thu, 09 Nov 2023 00:45:50 +0000
Date:   Thu, 9 Nov 2023 08:44:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
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
Subject: Re: [PATCH 17/22] powerpc: ps3: move udbg_shutdown_ps3gelic prototype
Message-ID: <202311090843.b8ISrsV1-lkp@intel.com>
References: <20231108125843.3806765-18-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108125843.3806765-18-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on next-20231108]
[cannot apply to v6.6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/ida-make-ida_dump-static/20231109-005742
base:   linus/master
patch link:    https://lore.kernel.org/r/20231108125843.3806765-18-arnd%40kernel.org
patch subject: [PATCH 17/22] powerpc: ps3: move udbg_shutdown_ps3gelic prototype
config: powerpc64-randconfig-001-20231109 (https://download.01.org/0day-ci/archive/20231109/202311090843.b8ISrsV1-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311090843.b8ISrsV1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311090843.b8ISrsV1-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/platforms/ps3/gelic_udbg.c:59:1: warning: alignment 1 of 'struct debug_block' is less than 32 [-Wpacked-not-aligned]
      59 | } __packed;
         | ^
>> arch/powerpc/platforms/ps3/gelic_udbg.c:240:6: error: redefinition of 'udbg_shutdown_ps3gelic'
     240 | void udbg_shutdown_ps3gelic(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/platforms/ps3/gelic_udbg.c:17:
   arch/powerpc/include/asm/ps3.h:520:20: note: previous definition of 'udbg_shutdown_ps3gelic' with type 'void(void)'
     520 | static inline void udbg_shutdown_ps3gelic(void) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~


vim +/udbg_shutdown_ps3gelic +240 arch/powerpc/platforms/ps3/gelic_udbg.c

c26afe9e8591f3 Hector Martin 2011-08-31  239  
c26afe9e8591f3 Hector Martin 2011-08-31 @240  void udbg_shutdown_ps3gelic(void)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
