Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366C87A9FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjIUU0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjIUU0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:26:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA9537BEE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318582; x=1726854582;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8ZHu1hIXWBCsZA57pJrAZEA7etlLyQOr5qWeEtcu1xo=;
  b=KiGHv5h8a8Fi71xC7Ts2GQHn2ngYFDXbvxMRGVjTNMp/MbE+bAYDeeuk
   nORMxV0OArgYtCvuREExokcxnEL3wRREX1a4iA5KQi3Zndgux7s42BEUM
   otsZg/AACvgZAnEWpUpjZc2qiUd5hMVR4cpYqg70e6hqv3qJX+JCMcwGL
   TDLJsvcNH+yohfgT41tD4t7l2wQWibEMyir/u79gD6RUko2AhwPsl4JJ9
   f3Qn+MYvSeEzZDNB0FcEvniFpwpCGkoIvrVtpqA38oLPeYfODu7JqCcfU
   5j3NCHNgEjed5zx4Zakn3VdcdTDs4DnbNVwcHKG2z8Rg1GAfdcX5MyVIm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="446924941"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="446924941"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:31:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="862380081"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="862380081"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Sep 2023 01:31:36 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjF5v-0009ma-2S;
        Thu, 21 Sep 2023 08:31:33 +0000
Date:   Thu, 21 Sep 2023 16:31:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Andrew Donnellan <ajd@linux.ibm.com>
Subject: arch/powerpc/kernel/rtas-proc.c:771: warning: Function parameter or
 member 'm' not described in 'ppc_rtas_rmo_buf_show'
Message-ID: <202309211645.1Lvwmbv4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42dc814987c1feb6410904e58cfd4c36c4146150
commit: c13ff6f3251318f5e1ff5b1a6d05f76996db672a powerpc/rtas: improve ppc_rtas_rmo_buf_show documentation
date:   2 years, 5 months ago
config: powerpc-mgcoge_defconfig (https://download.01.org/0day-ci/archive/20230921/202309211645.1Lvwmbv4-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230921/202309211645.1Lvwmbv4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309211645.1Lvwmbv4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/powerpc/kernel/rtas-proc.c:771: warning: Function parameter or member 'm' not described in 'ppc_rtas_rmo_buf_show'
>> arch/powerpc/kernel/rtas-proc.c:771: warning: Function parameter or member 'v' not described in 'ppc_rtas_rmo_buf_show'


vim +771 arch/powerpc/kernel/rtas-proc.c

^1da177e4c3f41 arch/ppc64/kernel/rtas-proc.c   Linus Torvalds 2005-04-16  759  
c13ff6f3251318 arch/powerpc/kernel/rtas-proc.c Nathan Lynch   2021-04-08  760  /**
c13ff6f3251318 arch/powerpc/kernel/rtas-proc.c Nathan Lynch   2021-04-08  761   * ppc_rtas_rmo_buf_show() - Describe RTAS-addressable region for user space.
c13ff6f3251318 arch/powerpc/kernel/rtas-proc.c Nathan Lynch   2021-04-08  762   *
c13ff6f3251318 arch/powerpc/kernel/rtas-proc.c Nathan Lynch   2021-04-08  763   * Base + size description of a range of RTAS-addressable memory set
c13ff6f3251318 arch/powerpc/kernel/rtas-proc.c Nathan Lynch   2021-04-08  764   * aside for user space to use as work area(s) for certain RTAS
c13ff6f3251318 arch/powerpc/kernel/rtas-proc.c Nathan Lynch   2021-04-08  765   * functions. User space accesses this region via /dev/mem. Apart from
c13ff6f3251318 arch/powerpc/kernel/rtas-proc.c Nathan Lynch   2021-04-08  766   * security policies, the kernel does not arbitrate or serialize
c13ff6f3251318 arch/powerpc/kernel/rtas-proc.c Nathan Lynch   2021-04-08  767   * access to this region, and user space must ensure that concurrent
c13ff6f3251318 arch/powerpc/kernel/rtas-proc.c Nathan Lynch   2021-04-08  768   * users do not interfere with each other.
c13ff6f3251318 arch/powerpc/kernel/rtas-proc.c Nathan Lynch   2021-04-08  769   */
^1da177e4c3f41 arch/ppc64/kernel/rtas-proc.c   Linus Torvalds 2005-04-16  770  static int ppc_rtas_rmo_buf_show(struct seq_file *m, void *v)
^1da177e4c3f41 arch/ppc64/kernel/rtas-proc.c   Linus Torvalds 2005-04-16 @771  {

:::::: The code at line 771 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
