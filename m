Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFBC7ED7FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjKOXBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKOXBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:01:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF059E1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700089295; x=1731625295;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=56CdDY6FYsPjduY5DbqYX0LDa9vSmX9/ofpMMduC834=;
  b=EfGtl/zsnNFCPhweadt7Vyo1a5/Vu1HB10vhYMkozrL0idAm/jlcQJwf
   jplweIrN7eizRIA5pxsid/9YU/zCY0PdN6oe2f5JPen7PndjuEUd3S9rp
   7LFOWNq2V/1YrVTcMCWVnMz6ghvN7j7sLObmkVD0xP+UIwfb9ultN2Xoq
   p86ObGHJnqjihdWxpK1rs1B9Fg6PZ8XhiUZaeTXtsgwzfriLyuLq6ngDn
   ddY7aVdqPtIDTeHsWEjTuadcb2aS4xc1EE/yOjBxmDvBx3nUaoDBo1W93
   80LRmr0GXuSnPCTyRrWvIPC0rMeg0v3fzGlnpDGu5vMtyDyJN7F4g8K4W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="381365205"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="381365205"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 15:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="938634702"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="938634702"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Nov 2023 15:00:57 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3OsR-0000wA-0v;
        Wed, 15 Nov 2023 23:00:55 +0000
Date:   Thu, 16 Nov 2023 07:00:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Charlie Jenkins <charlie@rivosinc.com>
Subject: arch/riscv/kernel/module.c:33:25: sparse: sparse: cast to restricted
 __le16
Message-ID: <202311160648.Adh0V2Wd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 8cbe0accc4a6ba7ed34812a1c7e1ba67e7f7b2a4 riscv: Avoid unaligned access when relocating modules
date:   8 days ago
config: riscv-randconfig-r133-20231115 (https://download.01.org/0day-ci/archive/20231116/202311160648.Adh0V2Wd-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231116/202311160648.Adh0V2Wd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160648.Adh0V2Wd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
>> arch/riscv/kernel/module.c:33:25: sparse: sparse: cast to restricted __le16
   arch/riscv/kernel/module.c:33:55: sparse: sparse: cast to restricted __le16
>> arch/riscv/kernel/module.c:38:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/riscv/kernel/module.c:38:19: sparse:     expected unsigned short [usertype]
   arch/riscv/kernel/module.c:38:19: sparse:     got restricted __le16 [usertype]
   arch/riscv/kernel/module.c:39:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/riscv/kernel/module.c:39:19: sparse:     expected unsigned short [usertype]
   arch/riscv/kernel/module.c:39:19: sparse:     got restricted __le16 [usertype]
   arch/riscv/kernel/module.c:46:20: sparse: sparse: cast to restricted __le16
   arch/riscv/kernel/module.c:51:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/riscv/kernel/module.c:51:17: sparse:     expected unsigned short [usertype]
   arch/riscv/kernel/module.c:51:17: sparse:     got restricted __le16 [usertype]

vim +33 arch/riscv/kernel/module.c

    29	
    30	static int riscv_insn_rmw(void *location, u32 keep, u32 set)
    31	{
    32		u16 *parcel = location;
  > 33		u32 insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
    34	
    35		insn &= keep;
    36		insn |= set;
    37	
  > 38		parcel[0] = cpu_to_le16(insn);
    39		parcel[1] = cpu_to_le16(insn >> 16);
    40		return 0;
    41	}
    42	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
