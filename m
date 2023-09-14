Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDDF79FBB6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjINGOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjINGOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:14:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D38FDF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694672056; x=1726208056;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y3wKfPdCXsNeJ2WkONbQZoMRXCsRiwzJvyZSIbo4lzE=;
  b=mWsLGTp+XAqbDDhYxRq+rI/UMZyOAOqi4ZIxLB8APdbYVFhA4iDJHl9n
   zJjw3jgBKnuYMmgF4C/uyHcC0RMrF1nrkQ7KL1Cgk7LUXrG3tNfAiAI3c
   /H6ihB8pfo5Z2JDkHipfQe3GITLWXH0UsoI3S4Sjer0BBQhJLcmgP9gJ3
   nOBKlcbHAvBL3xdbUeWGVlMvleGUtV/jLgfQ+KQLL02AKL1sJK956JY6m
   Z89SFpKBd1LKei0hwl8Bm1b0Sm+q46L8CAWtARuVu5IIw5BEnbR37OyiP
   98NsxBfAcJSieM7V7fIGyFcqa4kg1ri/gfNkZXYd6QqEIEhqomSScn9uY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381548943"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="381548943"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 23:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779510223"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="779510223"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2023 23:14:14 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgfcB-0001Ef-2h;
        Thu, 14 Sep 2023 06:14:11 +0000
Date:   Thu, 14 Sep 2023 14:13:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Kees Cook <keescook@chromium.org>
Subject: ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol
 '.L.str.6'; recompile with -fPIC
Message-ID: <202309141433.6gzJPSYA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aed8aee11130a954356200afa3f1b8753e8a9482
commit: 74f8fc31feb4b756814ec0720f48ccdc1175f774 riscv: Allow CONFIG_CFI_CLANG to be selected
date:   3 weeks ago
config: riscv-randconfig-r002-20230912 (https://download.01.org/0day-ci/archive/20230914/202309141433.6gzJPSYA-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309141433.6gzJPSYA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309141433.6gzJPSYA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: relocation R_RISCV_HI20 cannot be used against symbol '.L.str.6'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:94 (arch/riscv/errata/sifive/errata.c:94)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a
--
>> ld.lld: error: relocation R_RISCV_LO12_I cannot be used against symbol '.L.str.6'; recompile with -fPIC
   >>> defined in vmlinux.a(arch/riscv/errata/sifive/errata.o)
   >>> referenced by errata.c:94 (arch/riscv/errata/sifive/errata.c:94)
   >>>               arch/riscv/errata/sifive/errata.o:(sifive_errata_patch_func) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
