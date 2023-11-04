Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9BC7E0F86
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjKDNA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjKDNAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:00:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE41D47
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 06:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699102852; x=1730638852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LGEds4QrLxCqJapPZdzX+e6v5AjYi9DmPL6ZRMVbi+M=;
  b=KfYHOCS0AevDAnTfMWhwrpHKEQIADZaL2oPRKaPMMDYmS15pnoSX1/p7
   mJoA/+xV+9u6jVFwQHnVdyiioYPIeg7M70ZVsSPiABp04Wp8JqtfPcJ7H
   Pi5NGJcSOA1uboyDVM0Zl8re00eQB12CLX5bRDUIRZ8mwrVrGgmPp03Gn
   lmKnENekN9oZ/l8Sd9al8CSawSobAiayytK7dikNEJG/tnY8OgS9TOEUO
   DdULzvPSTgYWs06iqSAuG/9QLDA7elg49rF8qZEQpP4GGz8ISXDluoJsr
   Xynk9Yy5v+z/ivHXmsjbgC5mePYeLLRR7BPiGJbcF30jVDrvWx4JHj6MO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="420199789"
X-IronPort-AV: E=Sophos;i="6.03,277,1694761200"; 
   d="scan'208";a="420199789"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 06:00:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="765523156"
X-IronPort-AV: E=Sophos;i="6.03,277,1694761200"; 
   d="scan'208";a="765523156"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 04 Nov 2023 06:00:50 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzGGe-0004Pv-2Y;
        Sat, 04 Nov 2023 13:00:48 +0000
Date:   Sat, 4 Nov 2023 21:00:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast
 truncates bits from constant value (dead00000000eb9f becomes 9f)
Message-ID: <202311042016.s4qMWPT6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90b0c2b2edd1adff742c621e246562fbefa11b70
commit: c3c510ce431cd99fa10dcd50d995c8e89330ee5b bpf: Add 'owner' field to bpf_{list,rb}_node
date:   4 months ago
config: arm64-randconfig-r122-20231102 (https://download.01.org/0day-ci/archive/20231104/202311042016.s4qMWPT6-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231104/202311042016.s4qMWPT6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311042016.s4qMWPT6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/bpf/helpers.c: note: in included file (through arch/arm64/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/atomic.h, ...):
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (dead00000000eb9f becomes 9f)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (dead00000000eb9f becomes eb9f)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (dead00000000eb9f becomes eb9f)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (dead00000000eb9f becomes 9f)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (dead00000000eb9f becomes eb9f)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (dead00000000eb9f becomes eb9f)
   kernel/bpf/helpers.c:2419:18: sparse: sparse: context imbalance in 'bpf_rcu_read_lock' - wrong count at exit
   kernel/bpf/helpers.c:2424:18: sparse: sparse: context imbalance in 'bpf_rcu_read_unlock' - unexpected unlock

vim +171 arch/arm64/include/asm/cmpxchg.h

10b663aef1c247 Catalin Marinas 2012-03-05  167  
305d454aaa292b Will Deacon     2015-10-08  168  __CMPXCHG_GEN()
305d454aaa292b Will Deacon     2015-10-08  169  __CMPXCHG_GEN(_acq)
305d454aaa292b Will Deacon     2015-10-08  170  __CMPXCHG_GEN(_rel)
305d454aaa292b Will Deacon     2015-10-08 @171  __CMPXCHG_GEN(_mb)
10b663aef1c247 Catalin Marinas 2012-03-05  172  

:::::: The code at line 171 was first introduced by commit
:::::: 305d454aaa292be3a09a9d674e6c35f5b4249a13 arm64: atomics: implement native {relaxed, acquire, release} atomics

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
