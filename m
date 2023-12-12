Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FCD80EC9C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376351AbjLLMzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376288AbjLLMzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:55:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CF9ED;
        Tue, 12 Dec 2023 04:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702385727; x=1733921727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w+lkU+xutOwVwtDcyc729Y4oCnLefQk3xbQDr3f4OT8=;
  b=Ol4/FqXx7vEDZpIccUO+qS4Prn86mPrnFXatmddCnnMJMNk7Ol9iVXYI
   GeaSd/BAyKZ0gdt9xenr3Ep22zQQwY4CGQOoawQs6t+SGkZUm+a3Gl9fx
   27USyw3SePo5Ysjt+wJdafG8x5StGLHP5FiRJY6POfx534j7LsTqoLGD1
   iGU90fR75SQ2xhCZnCZ2na2YG4PLUAipVUuDhaNDBlA4BZhrqN37DBEvo
   hhXYhrGWvWgKVfvB5C7Lwyd9llCq/3KXY8a9ce6bH37KmaDQnB41vgaa6
   SNSuqqakWx4JtDqIiJzwlvifv39tI/77Je/QgU9O6WvDbSbYASSGl7cDN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="459116276"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="459116276"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 04:55:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="802456171"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="802456171"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2023 04:55:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rD2IB-000JAz-1W;
        Tue, 12 Dec 2023 12:55:19 +0000
Date:   Tue, 12 Dec 2023 20:50:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Maurer <mmaurer@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Matthew Maurer <mmaurer@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] x86/Kconfig: rust: Patchable function Rust compat
Message-ID: <202312122055.m7s1ccIE-lkp@intel.com>
References: <20231211150753.293883-1-mmaurer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211150753.293883-1-mmaurer@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on peterz-queue/sched/core tip/master tip/auto-latest linus/master v6.7-rc5 next-20231212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Maurer/x86-Kconfig-rust-Patchable-function-Rust-compat/20231211-230934
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20231211150753.293883-1-mmaurer%40google.com
patch subject: [PATCH] x86/Kconfig: rust: Patchable function Rust compat
config: x86_64-rhel-8.3-bpf (attached as .config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231212/202312122055.m7s1ccIE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312122055.m7s1ccIE-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/Kconfig:2443: syntax error
   arch/x86/Kconfig:2442: invalid statement
   arch/x86/Kconfig:2443: invalid statement
   make[3]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1
   make[2]: *** [Makefile:685: oldconfig] Error 2
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'oldconfig' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'oldconfig' not remade because of errors.
--
>> arch/x86/Kconfig:2443: syntax error
   arch/x86/Kconfig:2442: invalid statement
   arch/x86/Kconfig:2443: invalid statement
   make[3]: *** [scripts/kconfig/Makefile:77: olddefconfig] Error 1
   make[2]: *** [Makefile:685: olddefconfig] Error 2
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'olddefconfig' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'olddefconfig' not remade because of errors.


vim +2443 arch/x86/Kconfig

  2431	
  2432	config CC_HAS_SLS
  2433		def_bool $(cc-option,-mharden-sls=all)
  2434	
  2435	config CC_HAS_RETURN_THUNK
  2436		def_bool $(cc-option,-mfunction-return=thunk-extern)
  2437	
  2438	config CC_HAS_ENTRY_PADDING
  2439		def_bool $(cc-option,-fpatchable-function-entry=16,16)
  2440	
  2441	config RUSTC_HAS_ENTRY_PADDING
  2442		depends RUST
> 2443		def_bool $(rs-option,-Zpatchable-function-entry=16,16)
  2444	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
