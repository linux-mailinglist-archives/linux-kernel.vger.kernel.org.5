Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601937ED8EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 02:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbjKPBbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 20:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjKPBbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 20:31:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD9ED63
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 17:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700098236; x=1731634236;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+QjEvwNJF/bamkB8nQ+NjNqIrMclrxPDK0abTLt8t7I=;
  b=D+dcFvAkteETX71slvXu9Vd1wVYV6oEpyCVE9ocBB8R7yjE9ybWDPwOr
   s6T2bLX55z3KjwEw85lZ79BQLMh7cVA+x/nFobl93TTVLRN8Hj5a01dpb
   TrOHrWQRCQiL4rFgoxF2jGXs+DkSkaeXaOYd4ZJM8A2ecMySG+xHuFThx
   iJo1k/TeuCtjfJpARc/V/ofqpBXH+FXeC12/7mmlCOvuqVcF01bZP+ykM
   AMQWmK7iu5hZObjgTP+e1Lx9NxUrwUP8GXTniuMZ5lHEdqZroV5jeeZby
   JgrFYaRC4R88OBVx7N1r9Tr4luvA9Jbqt4J45Iv2s700nC6kuvlbseSe6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="371175581"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="371175581"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 17:30:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="12954235"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 15 Nov 2023 17:30:34 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r3RCy-00015b-2S;
        Thu, 16 Nov 2023 01:30:30 +0000
Date:   Thu, 16 Nov 2023 09:29:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: arch/riscv/kernel/module.c:48:19: sparse: sparse: symbol
 'relocation_hashtable' was not declared. Should it be static?
Message-ID: <202311160958.D9SGclUM-lkp@intel.com>
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
commit: 8fd6c5142395a106b63c8668e9f4a7106b6a0772 riscv: Add remaining module relocations
date:   8 days ago
config: riscv-randconfig-r133-20231115 (https://download.01.org/0day-ci/archive/20231116/202311160958.D9SGclUM-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231116/202311160958.D9SGclUM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160958.D9SGclUM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
>> arch/riscv/kernel/module.c:48:19: sparse: sparse: symbol 'relocation_hashtable' was not declared. Should it be static?
>> arch/riscv/kernel/module.c:50:18: sparse: sparse: symbol 'used_buckets_list' was not declared. Should it be static?
   arch/riscv/kernel/module.c:68:25: sparse: sparse: cast to restricted __le16
   arch/riscv/kernel/module.c:68:55: sparse: sparse: cast to restricted __le16
   arch/riscv/kernel/module.c:73:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/riscv/kernel/module.c:73:19: sparse:     expected unsigned short [usertype]
   arch/riscv/kernel/module.c:73:19: sparse:     got restricted __le16 [usertype]
   arch/riscv/kernel/module.c:74:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/riscv/kernel/module.c:74:19: sparse:     expected unsigned short [usertype]
   arch/riscv/kernel/module.c:74:19: sparse:     got restricted __le16 [usertype]
   arch/riscv/kernel/module.c:81:20: sparse: sparse: cast to restricted __le16
   arch/riscv/kernel/module.c:86:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   arch/riscv/kernel/module.c:86:17: sparse:     expected unsigned short [usertype]
   arch/riscv/kernel/module.c:86:17: sparse:     got restricted __le16 [usertype]

vim +/relocation_hashtable +48 arch/riscv/kernel/module.c

    42	
    43	unsigned int initialize_relocation_hashtable(unsigned int num_relocations);
    44	void process_accumulated_relocations(struct module *me);
    45	int add_relocation_to_accumulate(struct module *me, int type, void *location,
    46					 unsigned int hashtable_bits, Elf_Addr v);
    47	
  > 48	struct hlist_head *relocation_hashtable;
    49	
  > 50	struct list_head used_buckets_list;
    51	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
