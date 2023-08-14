Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DDE77C344
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjHNWIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjHNWIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:08:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BDFB0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692050918; x=1723586918;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J5BZGTZeel4YoawbOP6rqQ/YAxx0GP7ZSdtaygTIQs0=;
  b=Lc+gHFmetXMJQ6DzugcYFnQi4zub5fKeLq9I4Q7kKng0fC/CzjIV8BN4
   ud075dayTqukiOrFDhPz4Tyx1ayE7uxhh6IueKC8wiWAp75jkaL6TOYNN
   zmOKi0pG22SSGdjr3nQ0jx0qEi8hmGXy8TTnh3jMkHDlEZtlLDmAAGHpA
   8xpNtkWHrCG92SkEsFmbFb0qY0xomZvHiwJPBOwyQ0IaNfczoXCJNEVK3
   k02vgWHJmH205oKTlyCQAx7Zl4+vzCaOtPyFX+know4FS7uw3TxiKj/gu
   vZeqk37FFQRmiaN1LXzhkkqYzna910VcNCSsTox1j7IkFUoLn8euqylA/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="436041225"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="436041225"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 15:08:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="736668824"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="736668824"
Received: from lkp-server02.sh.intel.com (HELO b5fb8d9e1ffc) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 14 Aug 2023 15:08:35 -0700
Received: from kbuild by b5fb8d9e1ffc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVfjn-0000Rf-0V;
        Mon, 14 Aug 2023 22:08:35 +0000
Date:   Tue, 15 Aug 2023 06:07:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yimin Gu <ustcymgu@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: arch/riscv/include/asm/timex.h:25:16: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202308150611.CcCG8SBw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yimin,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ccdd1b13c591d306f0401d98dedc4bdcd02b421
commit: b5e2c507b06c9d36411845149162a804ae7b04a9 riscv: Kconfig: Allow RV32 to build with no MMU
date:   5 months ago
config: riscv-randconfig-r073-20230815 (https://download.01.org/0day-ci/archive/20230815/202308150611.CcCG8SBw-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230815/202308150611.CcCG8SBw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308150611.CcCG8SBw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
   fs/ext4/mballoc.c: note: in included file (through include/linux/timex.h, include/linux/time32.h, include/linux/time.h, ...):
>> arch/riscv/include/asm/timex.h:25:16: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/riscv/include/asm/timex.h:25:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/riscv/include/asm/timex.h:25:16: sparse:     expected void const volatile [noderef] __iomem *addr
   arch/riscv/include/asm/timex.h:25:16: sparse:     got unsigned int [usertype] *
>> arch/riscv/include/asm/timex.h:25:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] * @@
   arch/riscv/include/asm/timex.h:25:16: sparse:     expected void const volatile [noderef] __iomem *addr
   arch/riscv/include/asm/timex.h:25:16: sparse:     got unsigned int [usertype] *
   fs/ext4/mballoc.c:1217:9: sparse: sparse: context imbalance in 'ext4_mb_init_cache' - different lock contexts for basic block
   fs/ext4/mballoc.c:2127:5: sparse: sparse: context imbalance in 'ext4_mb_try_best_found' - different lock contexts for basic block
   fs/ext4/mballoc.c:2155:5: sparse: sparse: context imbalance in 'ext4_mb_find_by_goal' - different lock contexts for basic block
   fs/ext4/mballoc.c:2448:12: sparse: sparse: context imbalance in 'ext4_mb_good_group_nolock' - wrong count at exit
   fs/ext4/mballoc.c:2670:58: sparse: sparse: context imbalance in 'ext4_mb_regular_allocator' - different lock contexts for basic block
   fs/ext4/mballoc.c:2942:13: sparse: sparse: context imbalance in 'ext4_mb_seq_structs_summary_start' - wrong count at exit
   fs/ext4/mballoc.c:3322:17: sparse: sparse: context imbalance in 'ext4_discard_work' - different lock contexts for basic block
   fs/ext4/mballoc.c:3525:17: sparse: sparse: context imbalance in 'ext4_mb_release' - different lock contexts for basic block
   fs/ext4/mballoc.c:3647:26: sparse: sparse: context imbalance in 'ext4_free_data_in_buddy' - wrong count at exit
   fs/ext4/mballoc.c:3852:15: sparse: sparse: context imbalance in 'ext4_mb_mark_diskspace_used' - different lock contexts for basic block
   fs/ext4/mballoc.c:3964:9: sparse: sparse: context imbalance in 'ext4_mb_mark_bb' - different lock contexts for basic block
   fs/ext4/mballoc.c:4240:13: sparse: sparse: context imbalance in 'ext4_discard_allocated_blocks' - different lock contexts for basic block
   fs/ext4/mballoc.c:4542:13: sparse: sparse: context imbalance in 'ext4_mb_put_pa' - different lock contexts for basic block
   fs/ext4/mballoc.c:4924:9: sparse: sparse: context imbalance in 'ext4_mb_discard_group_preallocations' - different lock contexts for basic block
   fs/ext4/mballoc.c:5017:9: sparse: sparse: context imbalance in 'ext4_discard_preallocations' - different lock contexts for basic block
   fs/ext4/mballoc.c:5084:9: sparse: sparse: context imbalance in 'ext4_mb_show_ac' - different lock contexts for basic block
   fs/ext4/mballoc.c:5313:9: sparse: sparse: context imbalance in 'ext4_mb_discard_lg_preallocations' - different lock contexts for basic block
   fs/ext4/mballoc.c:5084:9: sparse: sparse: context imbalance in 'ext4_mb_new_blocks' - different lock contexts for basic block
   fs/ext4/mballoc.c:5910:9: sparse: sparse: context imbalance in 'ext4_mb_clear_bb' - different lock contexts for basic block
   fs/ext4/mballoc.c:6309:15: sparse: sparse: context imbalance in 'ext4_group_add_blocks' - different lock contexts for basic block
   fs/ext4/mballoc.c:6325:12: sparse: sparse: context imbalance in 'ext4_trim_extent' - wrong count at exit
   fs/ext4/mballoc.c:6400:9: sparse: sparse: context imbalance in 'ext4_try_to_trim_range' - different lock contexts for basic block
   fs/ext4/mballoc.c:6418:1: sparse: sparse: context imbalance in 'ext4_trim_all_free' - different lock contexts for basic block
   fs/ext4/mballoc.c:6560:1: sparse: sparse: context imbalance in 'ext4_mballoc_query_range' - different lock contexts for basic block

vim +/__iomem +25 arch/riscv/include/asm/timex.h

d5be89a8d118a8 Palmer Dabbelt 2020-09-14  16  
d5be89a8d118a8 Palmer Dabbelt 2020-09-14  17  #ifdef CONFIG_64BIT
d5be89a8d118a8 Palmer Dabbelt 2020-09-14  18  static inline cycles_t get_cycles(void)
d5be89a8d118a8 Palmer Dabbelt 2020-09-14  19  {
d5be89a8d118a8 Palmer Dabbelt 2020-09-14  20  	return readq_relaxed(clint_time_val);
d5be89a8d118a8 Palmer Dabbelt 2020-09-14  21  }
d5be89a8d118a8 Palmer Dabbelt 2020-09-14  22  #else /* !CONFIG_64BIT */
d5be89a8d118a8 Palmer Dabbelt 2020-09-14  23  static inline u32 get_cycles(void)
d5be89a8d118a8 Palmer Dabbelt 2020-09-14  24  {
d5be89a8d118a8 Palmer Dabbelt 2020-09-14 @25  	return readl_relaxed(((u32 *)clint_time_val));
d5be89a8d118a8 Palmer Dabbelt 2020-09-14  26  }
d5be89a8d118a8 Palmer Dabbelt 2020-09-14  27  #define get_cycles get_cycles
d5be89a8d118a8 Palmer Dabbelt 2020-09-14  28  

:::::: The code at line 25 was first introduced by commit
:::::: d5be89a8d118a8e8d09cd74a921a808f17fbdd09 RISC-V: Resurrect the MMIO timer implementation for M-mode systems

:::::: TO: Palmer Dabbelt <palmerdabbelt@google.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
