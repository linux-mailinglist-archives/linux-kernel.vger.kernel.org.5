Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A687EECEE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 08:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjKQHrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 02:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQHrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 02:47:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2A92
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 23:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700207224; x=1731743224;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gqLvmGB6oW1jilPhRTwVkhwwoWc2jXYasQjZesKco3A=;
  b=J5+E19x2PjWdpFKTgbx8AgzcdoBtpi8uLpxt6gff0gU4nOMBSp2rQpZD
   sBKPTpmySoqUVb4MT8ySjqdY/ckFCU9JD32mgB0/UxY6reBEV9dMpws9K
   l60wOvGZ7j/4OMRRzazrACOpLWZm12ahj0AwnfSWXXYHQC4uf27gFNLu3
   O/JO1FtDRuuQwCh3YbuvcnSey+Jn7ZZEV7VJbog42PPHUzb0kGzjzuNBN
   TfIKcLkvBVfbCGOksLDgOak436OJHFyJ04VvGtpME9vTSvBiTETFtBbzQ
   kOkePVoBZnMj5BTNMEmhBcO6tCwkY2Xep2qfj3IO37Lc4rvqw/IYNv5sE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="376303206"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="376303206"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 23:47:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="6775586"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 16 Nov 2023 23:47:04 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3tZ5-0002TD-1B;
        Fri, 17 Nov 2023 07:46:59 +0000
Date:   Fri, 17 Nov 2023 15:46:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/parisc/net/bpf_jit_comp32.c:321:13: sparse: sparse: missing
 identifier in declaration
Message-ID: <202311171550.uOBghX01-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7475e51b87969e01a6812eac713a1c8310372e8a
commit: 4800a6215e335c6dade05e10c8fdbf919c04a3a7 parisc: Wire up eBPF JIT compiler
date:   3 months ago
config: parisc-randconfig-r113-20231115 (https://download.01.org/0day-ci/archive/20231117/202311171550.uOBghX01-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231117/202311171550.uOBghX01-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311171550.uOBghX01-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/parisc/net/bpf_jit_comp32.c:321:13: sparse: sparse: missing identifier in declaration
   arch/parisc/net/bpf_jit_comp32.c:321:13: sparse: sparse: Expected ; at the end of type declaration
   arch/parisc/net/bpf_jit_comp32.c:321:13: sparse: sparse: got $
   arch/parisc/net/bpf_jit_comp32.c:322:13: sparse: sparse: Expected ; at the end of type declaration
   arch/parisc/net/bpf_jit_comp32.c:322:13: sparse: sparse: got $
   arch/parisc/net/bpf_jit_comp32.c:323:13: sparse: sparse: Expected ; at the end of type declaration
   arch/parisc/net/bpf_jit_comp32.c:323:13: sparse: sparse: got $
   arch/parisc/net/bpf_jit_comp32.c:666:37: sparse: sparse: Expected ) in function call
   arch/parisc/net/bpf_jit_comp32.c:666:37: sparse: sparse: got $
   arch/parisc/net/bpf_jit_comp32.c:669:37: sparse: sparse: Expected ) in function call
   arch/parisc/net/bpf_jit_comp32.c:669:37: sparse: sparse: got $
   arch/parisc/net/bpf_jit_comp32.c:672:37: sparse: sparse: Expected ) in function call
   arch/parisc/net/bpf_jit_comp32.c:672:37: sparse: sparse: got $
>> arch/parisc/net/bpf_jit_comp32.c:666:36: sparse: sparse: not enough arguments for function emit_call_millicode
   arch/parisc/net/bpf_jit_comp32.c:669:36: sparse: sparse: not enough arguments for function emit_call_millicode
   arch/parisc/net/bpf_jit_comp32.c:672:36: sparse: sparse: not enough arguments for function emit_call_millicode

vim +321 arch/parisc/net/bpf_jit_comp32.c

ceb0e7267693d3e Helge Deller 2023-08-17  319  
ceb0e7267693d3e Helge Deller 2023-08-17  320  /* extern hppa millicode functions */
ceb0e7267693d3e Helge Deller 2023-08-17 @321  extern void $$mulI(void);
ceb0e7267693d3e Helge Deller 2023-08-17  322  extern void $$divU(void);
ceb0e7267693d3e Helge Deller 2023-08-17  323  extern void $$remU(void);
ceb0e7267693d3e Helge Deller 2023-08-17  324  

:::::: The code at line 321 was first introduced by commit
:::::: ceb0e7267693d3e6c43bd65695cd79d7c072a42a parisc: Add 32-bit eBPF JIT compiler

:::::: TO: Helge Deller <deller@gmx.de>
:::::: CC: Helge Deller <deller@gmx.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
