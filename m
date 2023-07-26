Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FE6762802
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjGZBJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjGZBJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:09:42 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0B9268B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 18:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690333780; x=1721869780;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8N2pAFQ3if94TCvGhYfcjiKTRVqUsuCoD4cDE6Th3ug=;
  b=kp/G6OZW6xJf41vRbVxEi5dus8sYDEGFnNylmcZU6c7CXMhDHykMMX+G
   p+rHWL9/y6Abk4ptAEM5KvFYR9rjYBS+yaH/1uQGpxLfaNns4l1R0Ea1s
   2X56YzcjIwYagVMb83G7xM4guVnX6z0oc2rv5jI9p5cR7rM3NnhI5uwkU
   FGU7rge0/WHSOEAvg1OqfkVkdKZIrUM0Xe94YQFPAwDWSTcKsg6zXWJEe
   STr7S1WgVbLcbQN5hvdjZilxbYFuxTYImCcdluCVxpL7jKink9WrxFobR
   pE+OenZ5YBJ3DYoJAOVSIef6wmxMm+vji1La1wDLSqNea2u7lPFYUpWbj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352785419"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="352785419"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 18:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="1056985602"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="1056985602"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jul 2023 18:09:38 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOT1c-0000V1-1E;
        Wed, 26 Jul 2023 01:09:18 +0000
Date:   Wed, 26 Jul 2023 09:08:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Chancellor <nathan@kernel.org>
Subject: arch/powerpc/mm/book3s64/radix_tlb.c:419:20: error: unused function
 '_tlbie_pid_lpid'
Message-ID: <202307260802.Mjr99P5O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   18b44bc5a67275641fb26f2c54ba7eef80ac5950
commit: d78c8e32890ef7eca79ffd67c96022c7f9d8cce4 powerpc/mm: Rearrange if-else block to avoid clang warning
date:   5 months ago
config: powerpc-skiroot_defconfig (https://download.01.org/0day-ci/archive/20230726/202307260802.Mjr99P5O-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260802.Mjr99P5O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260802.Mjr99P5O-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/powerpc/mm/book3s64/radix_tlb.c:419:20: error: unused function '_tlbie_pid_lpid' [-Werror,-Wunused-function]
     419 | static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
         |                    ^
>> arch/powerpc/mm/book3s64/radix_tlb.c:663:20: error: unused function '_tlbie_va_range_lpid' [-Werror,-Wunused-function]
     663 | static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
         |                    ^
   2 errors generated.


vim +/_tlbie_pid_lpid +419 arch/powerpc/mm/book3s64/radix_tlb.c

1a472c9dba6b96 arch/powerpc/mm/tlb-radix.c          Aneesh Kumar K.V 2016-04-29  418  
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21 @419  static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  420  				   unsigned long ric)
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  421  {
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  422  	asm volatile("ptesync" : : : "memory");
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  423  
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  424  	/*
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  425  	 * Workaround the fact that the "ric" argument to __tlbie_pid
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  426  	 * must be a compile-time contraint to match the "i" constraint
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  427  	 * in the asm statement.
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  428  	 */
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  429  	switch (ric) {
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  430  	case RIC_FLUSH_TLB:
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  431  		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_TLB);
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  432  		fixup_tlbie_pid_lpid(pid, lpid);
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  433  		break;
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  434  	case RIC_FLUSH_PWC:
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  435  		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  436  		break;
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  437  	case RIC_FLUSH_ALL:
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  438  	default:
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  439  		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_ALL);
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  440  		fixup_tlbie_pid_lpid(pid, lpid);
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  441  	}
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  442  	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
f0c6fbbb90504f arch/powerpc/mm/book3s64/radix_tlb.c Bharata B Rao    2021-06-21  443  }
2275d7b5754a57 arch/powerpc/mm/book3s64/radix_tlb.c Nicholas Piggin  2019-09-03  444  struct tlbiel_pid {
2275d7b5754a57 arch/powerpc/mm/book3s64/radix_tlb.c Nicholas Piggin  2019-09-03  445  	unsigned long pid;
2275d7b5754a57 arch/powerpc/mm/book3s64/radix_tlb.c Nicholas Piggin  2019-09-03  446  	unsigned long ric;
2275d7b5754a57 arch/powerpc/mm/book3s64/radix_tlb.c Nicholas Piggin  2019-09-03  447  };
2275d7b5754a57 arch/powerpc/mm/book3s64/radix_tlb.c Nicholas Piggin  2019-09-03  448  

:::::: The code at line 419 was first introduced by commit
:::::: f0c6fbbb90504fb7e9dbf0865463d3c2b4de49e5 KVM: PPC: Book3S HV: Add support for H_RPT_INVALIDATE

:::::: TO: Bharata B Rao <bharata@linux.ibm.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
