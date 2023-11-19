Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82C97F096A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjKSWXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjKSWW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:22:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1A6F2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700432575; x=1731968575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z712roQ+Z3IjAHPPRhYNaGg0I5PFx2mMvhm4YZIMOME=;
  b=LgvsNT/tLnIjo2iNxfbP9VjhJh5VyRuM7llS2iWlMPcZdazWPXqg0b16
   vpluG6/9KgNUKva6hk89+KugVLSib85p1by6Pw9CBqRL4wGA4Q6nN4JhL
   eV+5cz8+5ZNgXhqhaRaWZjNQfr9WN+icP1LTat3txHunxcfLtP/KutNr9
   v94wPOMkQNgsDXBXks5hg+BoX6cirF1d3v6Yx6VvAFzAHaJlPgby35uKB
   qT0U/7FkTRxP06y7vcQ2c336RCJfCTTlwpTPNxxuBWcYknFInTljNFFzR
   4f8v4uqo9oCoQZGBIaSRF14mEByZG+IdgW+J4avf7/75oZ6G7jRJwtIkT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="4700781"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="4700781"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 14:22:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="7521964"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 19 Nov 2023 14:22:53 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4qBm-0005db-2s;
        Sun, 19 Nov 2023 22:22:50 +0000
Date:   Mon, 20 Nov 2023 06:22:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: warning: unused import: `ffi::c_void`
Message-ID: <202311200633.01qo6GEu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   037266a5f7239ead1530266f7d7af153d2a867fa
commit: ae6df65dabc3f8bd89663d96203963323e266d90 rust: upgrade to Rust 1.72.1
date:   6 weeks ago
config: x86_64-buildonly-randconfig-006-20231120 (https://download.01.org/0day-ci/archive/20231120/202311200633.01qo6GEu-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311200633.01qo6GEu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311200633.01qo6GEu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: unused import: `ffi::c_void`
   --> rust/kernel/kunit.rs:9:12
   |
   9 | use core::{ffi::c_void, fmt};
   |            ^^^^^^^^^^^
   |
   = note: `#[warn(unused_imports)]` on by default
--
>> warning: unused variable: `args`
   --> rust/kernel/kunit.rs:15:12
   |
   15 | pub fn err(args: fmt::Arguments<'_>) {
   |            ^^^^ help: if this is intentional, prefix it with an underscore: `_args`
   |
   = note: `#[warn(unused_variables)]` on by default
--
>> warning: unused variable: `args`
   --> rust/kernel/kunit.rs:31:13
   |
   31 | pub fn info(args: fmt::Arguments<'_>) {
   |             ^^^^ help: if this is intentional, prefix it with an underscore: `_args`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
