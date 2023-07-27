Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA5E7643C5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjG0CY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjG0CYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:24:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5842685;
        Wed, 26 Jul 2023 19:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690424693; x=1721960693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C264Jlx7omC2IGbVFzDmPqjvhYuKy5hrLHi7x8Hv+9c=;
  b=Vki36Vsu7/8gw7GL9qR60DP29aPUgksJuoGStuI4EG8FAZUKbfs+50Bd
   Pk1EXxDxloB6YRPMGeipNkkXtrXc76rlsPZls5nuGVsFEz9WhXHny1zwJ
   idpVqJAOnpVRTkj0U5O7a9kwqm2AVX3XnlmtD4XyHNQ4+lZNKB00Lc0Nt
   qad571F/KQ+wUKyevLkll1N/+6F+YpMpAJZ59y9Y2TFj2sb29wD7Ofxh5
   VrCHCKrzenTNMVivz0Ff5Iuc68xIXQF4eb6erfKfCZPFaRGui7ADXGkKV
   HMCvtBx13dSewZRIRah+RDFNvFzszbKV1Mjx27qf64HJSzuSJ9jVHUxqW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="371794980"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="371794980"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 19:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="850685813"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="850685813"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2023 19:24:48 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOqgJ-0001aK-1P;
        Thu, 27 Jul 2023 02:24:47 +0000
Date:   Thu, 27 Jul 2023 10:24:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, olivia@selenic.com,
        herbert@gondor.apana.org.au, jiajie.ho@starfivetech.com,
        conor.dooley@microchip.com, martin@kaiser.cx, mmyangfl@gmail.com,
        jenny.zhang@starfivetech.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        leoliu@zhaoxin.com, CobeChen@zhaoxin.com, YunShen@zhaoxin.com,
        TonyWWang@zhaoxin.com, leoliu-oc <leoliu-oc@zhaoxin.com>
Subject: Re: [PATCH] hwrng: add Zhaoxin HW RNG driver
Message-ID: <202307271008.RbzxDGux-lkp@intel.com>
References: <20230726113553.1965627-1-LeoLiu-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726113553.1965627-1-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LeoLiu-oc,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master linus/master v6.5-rc3 next-20230726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LeoLiu-oc/hwrng-add-Zhaoxin-HW-RNG-driver/20230726-193710
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20230726113553.1965627-1-LeoLiu-oc%40zhaoxin.com
patch subject: [PATCH] hwrng: add Zhaoxin HW RNG driver
config: i386-randconfig-i014-20230726 (https://download.01.org/0day-ci/archive/20230727/202307271008.RbzxDGux-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230727/202307271008.RbzxDGux-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307271008.RbzxDGux-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/char/hw_random/zhaoxin-rng.c:58:2: error: register %rcx is only available in 64-bit mode
           "movq %0, %%rcx\n"
           ^
   <inline asm>:1:13: note: instantiated into assembly here
           movq %eax, %rcx
                      ^~~~
>> drivers/char/hw_random/zhaoxin-rng.c:59:3: error: register %rdx is only available in 64-bit mode
           "movq %1, %%rdx\n"
            ^
   <inline asm>:2:12: note: instantiated into assembly here
   movq %ecx, %rdx
              ^~~~
>> drivers/char/hw_random/zhaoxin-rng.c:60:3: error: register %rdi is only available in 64-bit mode
           "movq %2, %%rdi\n"
            ^
   <inline asm>:3:12: note: instantiated into assembly here
   movq %edx, %rdi
              ^~~~
   3 errors generated.


vim +58 drivers/char/hw_random/zhaoxin-rng.c

    54	
    55	static inline int rep_xstore(size_t size, size_t factor, void *result)
    56	{
    57		__asm__ __volatile__ (
  > 58		"movq %0, %%rcx\n"
  > 59		"movq %1, %%rdx\n"
  > 60		"movq %2, %%rdi\n"
    61		".byte 0xf3, 0x0f, 0xa7, 0xc0"
    62		:
    63		: "r"(size), "r"(factor), "r"(result)
    64		: "%rcx", "%rdx", "%rdi", "memory");
    65	
    66		return 0;
    67	}
    68	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
