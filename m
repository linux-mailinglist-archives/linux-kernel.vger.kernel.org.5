Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3087682B4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 01:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjG2XZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 19:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjG2XZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 19:25:35 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2EC2D4C;
        Sat, 29 Jul 2023 16:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690673133; x=1722209133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lg5Z2zadJltzEJU5eTPAO7fkXvwEPhVsT0zhAmujkSU=;
  b=T4XksD5uiDwkX5+taLPBFzW26Y1xe13ajYLDKno4PzNPgYtGc7B7pPrh
   IbZ6vMhFR9jSZsO+QzNC0vz7So+KMkT5bSO0V4cCf4kdNlw6ZYFB4tNYb
   sq/OCVmivLPuj4kSFtRnw1wJ0QUtGPksM8ulOS77ucixwce8L+wsPDeAN
   gPouQQHr4EQ8Figm8XUrTbDbNKN8gnX1xY3A2Fx1EU3UzlmOOwQ+yPyJs
   j0QIIXgNCByPfBF7pvngMmO7QfFgVJQ6c3ZTZsf/s6Tks97LhlX4o+jdg
   XTlASgSoW/vS/vD/7rAqGQTBxysKuEzUQNldVe//7CjfmYh8aheAhIXr1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="366266755"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="366266755"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2023 16:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10786"; a="974471634"
X-IronPort-AV: E=Sophos;i="6.01,240,1684825200"; 
   d="scan'208";a="974471634"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jul 2023 16:25:29 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPtJQ-0004Kl-2g;
        Sat, 29 Jul 2023 23:25:28 +0000
Date:   Sun, 30 Jul 2023 07:25:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 1/2] rust: upgrade to Rust 1.71.0
Message-ID: <202307300737.8GuKiWIl-lkp@intel.com>
References: <20230729220317.416771-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729220317.416771-1-ojeda@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7c74839b2acc9b5a5d16d3a1737741dd64e1804b]

url:    https://github.com/intel-lab-lkp/linux/commits/Miguel-Ojeda/rust-enable-no_mangle_with_rust_abi-Clippy-lint/20230730-060434
base:   7c74839b2acc9b5a5d16d3a1737741dd64e1804b
patch link:    https://lore.kernel.org/r/20230729220317.416771-1-ojeda%40kernel.org
patch subject: [PATCH 1/2] rust: upgrade to Rust 1.71.0
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230730/202307300737.8GuKiWIl-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230730/202307300737.8GuKiWIl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307300737.8GuKiWIl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at_include/linux/compiler_types_h_146_2)" is not a valid Ident', /opt/cross/rustc-1.71.0-bindgen-0.56.0/cargo/registry/src/index.crates.io-6f17d22bba15001f/proc-macro2-1.0.24/src/fallback.rs:693:9
   stack backtrace:
      0: rust_begin_unwind
                at /rustc/8ede3aae28fe6e4d52b38157d7bfe0d3bceef225/library/std/src/panicking.rs:593:5
      1: core::panicking::panic_fmt
                at /rustc/8ede3aae28fe6e4d52b38157d7bfe0d3bceef225/library/core/src/panicking.rs:67:14
      2: proc_macro2::fallback::Ident::_new
      3: proc_macro2::Ident::new
      4: bindgen::ir::context::BindgenContext::rust_ident
      5: <bindgen::ir::comp::CompInfo as bindgen::codegen::CodeGenerator>::codegen
      6: <bindgen::ir::ty::Type as bindgen::codegen::CodeGenerator>::codegen
      7: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
      8: <bindgen::ir::comp::CompInfo as bindgen::codegen::CodeGenerator>::codegen
      9: <bindgen::ir::ty::Type as bindgen::codegen::CodeGenerator>::codegen
     10: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
     11: <bindgen::ir::module::Module as bindgen::codegen::CodeGenerator>::codegen
     12: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
     13: bindgen::ir::context::BindgenContext::gen
     14: bindgen::Builder::generate
     15: bindgen::main
   note: Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace.
   make[3]: *** [rust/Makefile:316: rust/uapi/uapi_generated.rs] Error 1
   make[3]: *** Deleting file 'rust/uapi/uapi_generated.rs'
>> thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at_include/linux/compiler_types_h_146_2)" is not a valid Ident', /opt/cross/rustc-1.71.0-bindgen-0.56.0/cargo/registry/src/index.crates.io-6f17d22bba15001f/proc-macro2-1.0.24/src/fallback.rs:693:9
   stack backtrace:
      0: rust_begin_unwind
                at /rustc/8ede3aae28fe6e4d52b38157d7bfe0d3bceef225/library/std/src/panicking.rs:593:5
      1: core::panicking::panic_fmt
                at /rustc/8ede3aae28fe6e4d52b38157d7bfe0d3bceef225/library/core/src/panicking.rs:67:14
      2: proc_macro2::fallback::Ident::_new
      3: proc_macro2::Ident::new
      4: bindgen::ir::context::BindgenContext::rust_ident
      5: <bindgen::ir::comp::CompInfo as bindgen::codegen::CodeGenerator>::codegen
      6: <bindgen::ir::ty::Type as bindgen::codegen::CodeGenerator>::codegen
      7: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
      8: <bindgen::ir::comp::CompInfo as bindgen::codegen::CodeGenerator>::codegen
      9: <bindgen::ir::ty::Type as bindgen::codegen::CodeGenerator>::codegen
     10: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
     11: <bindgen::ir::module::Module as bindgen::codegen::CodeGenerator>::codegen
     12: <bindgen::ir::item::Item as bindgen::codegen::CodeGenerator>::codegen
     13: bindgen::ir::context::BindgenContext::gen
     14: bindgen::Builder::generate
     15: bindgen::main
   note: Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace.
   make[3]: *** [rust/Makefile:310: rust/bindings/bindings_generated.rs] Error 1
   make[3]: *** Deleting file 'rust/bindings/bindings_generated.rs'
   make[3]: Target 'rust/' not remade because of errors.
   make[2]: *** [Makefile:1281: prepare] Error 2
   make[1]: *** [Makefile:234: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
