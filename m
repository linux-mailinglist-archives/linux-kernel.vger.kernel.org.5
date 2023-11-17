Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9867EEA23
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjKQAEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 19:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKQAEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:04:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92023EA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 16:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700179473; x=1731715473;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nhH7u1dVutBgChfQiLWCRnXfOfLR8ytyAeWNycBHTIQ=;
  b=IcCuOhgznci0g37YujiS3d5TpgCgL8rbbuhLXuYp5nf1GIZoQWbpHLah
   5/usdjoal1oVS8UaMF/xlYhvZFJ7/1JQqu2HtFlHkcJ6RfTF0LRTGZ6u+
   /sVgZlYgS+cgVcTCc0AO1p3F2fqhfMd8FkOFJaNo1VVNMT8Z+hkiZSbaR
   vHWl7BKGzvW2srLtnrerHFSA6+nw8PF90+mlx+jyBq/6E/xQr/QvsoNHY
   BZDVmCwi57gyvHsmOBiIjrBJYWf62uz+6L3+aGFREfhpZKRvbTUnV2q6y
   KXHB+Uj5WKdCeEBy/OVWM11HkxwHMCpgFlhgcxRDnV15aEAEdhnLbqLdu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="390988269"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="390988269"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 16:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="13296077"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 16 Nov 2023 16:04:32 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3mLV-00029X-1u;
        Fri, 17 Nov 2023 00:04:29 +0000
Date:   Fri, 17 Nov 2023 08:04:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: arch/riscv/kernel/traps.c:405:1: sparse: sparse: symbol
 '__pcpu_scope_overflow_stack' was not declared. Should it be static?
Message-ID: <202311170738.xXn02awd-lkp@intel.com>
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
commit: be97d0db5f44c0674480cb79ac6f5b0529b84c76 riscv: VMAP_STACK overflow detection thread-safe
date:   3 weeks ago
config: riscv-randconfig-r131-20231117 (https://download.01.org/0day-ci/archive/20231117/202311170738.xXn02awd-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231117/202311170738.xXn02awd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311170738.xXn02awd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
>> arch/riscv/kernel/traps.c:405:1: sparse: sparse: symbol '__pcpu_scope_overflow_stack' was not declared. Should it be static?

vim +/__pcpu_scope_overflow_stack +405 arch/riscv/kernel/traps.c

   403	
   404	#ifdef CONFIG_VMAP_STACK
 > 405	DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
   406			overflow_stack)__aligned(16);
   407	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
