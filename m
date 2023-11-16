Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917C57EE097
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345197AbjKPMTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345138AbjKPMTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:19:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3120E9C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 04:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700137174; x=1731673174;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q82emOdPNTGIPOiyowhlYI6UEobKDc3XJ9o/oniDe1g=;
  b=Csg07q8qyqi/e97hdYacpd2NiHPFBl4yGZWVA0Qav/sxJAFG1HMnDkpA
   megkxQCzCKAfSIUXwYF0cIX65GHqpFqDGwg8MAatpsTFT6zfs0SDXIo1D
   W6U33a0MrZ5DRMiHSppJ5+ReL7x8vQOlYa+3rvIoqAmFhIq1VHk9k4o/0
   Os+1pHUHyvGaWvxMHqAIOqJvoGfLewAYd9TZ2ju16+D6Ez6IWztwZozS6
   fzdXu5r5WjxmNhR9+bvgWm8WBkotrk9Q213ipKEeqCGzmrTw1Rb1mK7RM
   Ypr8st4Lmlu8nRto24ihYXb+8V/a0HnNc1X4GJ26FuOnh6wXhh1ta7coO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="457570329"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="457570329"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:19:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="909092137"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="909092137"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2023 04:19:32 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3bLG-0001df-0N;
        Thu, 16 Nov 2023 12:19:30 +0000
Date:   Thu, 16 Nov 2023 20:18:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/parisc/net/bpf_jit_comp32.c:321:13: sparse: sparse: missing
 identifier in declaration
Message-ID: <202311162045.0hHGIKOR-lkp@intel.com>
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
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 4800a6215e335c6dade05e10c8fdbf919c04a3a7 parisc: Wire up eBPF JIT compiler
date:   3 months ago
config: parisc-randconfig-r113-20231115 (https://download.01.org/0day-ci/archive/20231116/202311162045.0hHGIKOR-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231116/202311162045.0hHGIKOR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311162045.0hHGIKOR-lkp@intel.com/

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

ceb0e7267693d3 Helge Deller 2023-08-17  319  
ceb0e7267693d3 Helge Deller 2023-08-17  320  /* extern hppa millicode functions */
ceb0e7267693d3 Helge Deller 2023-08-17 @321  extern void $$mulI(void);
ceb0e7267693d3 Helge Deller 2023-08-17  322  extern void $$divU(void);
ceb0e7267693d3 Helge Deller 2023-08-17  323  extern void $$remU(void);
ceb0e7267693d3 Helge Deller 2023-08-17  324  

:::::: The code at line 321 was first introduced by commit
:::::: ceb0e7267693d3e6c43bd65695cd79d7c072a42a parisc: Add 32-bit eBPF JIT compiler

:::::: TO: Helge Deller <deller@gmx.de>
:::::: CC: Helge Deller <deller@gmx.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
