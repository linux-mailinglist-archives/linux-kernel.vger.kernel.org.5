Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B4379FDF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjININJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjININI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:13:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3920CD8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694679184; x=1726215184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0HuLFSOV1iee1YccL1q6ba1Qi+BrJA064NEgTIarkeA=;
  b=BeoCrXuEwYzHXeJmQHW9UoCNj8u6W4bBVCwyW7d8kKPTLg6EgKCTcxwB
   1oRUVbxHWbD70WPqhllas93lNalKbYwdVYsSlyc6skrE3yoz57BQmK8Nh
   Mm5tecnI3TQENVsgtYT2VcIG6rJI4n19jwA9mWAhUVIhqfUBWoEV87yvu
   cfFjiSKu9/2AXpiQltYePkq7noLvP0KWSaCpsq5Y8olkU2vieAj8h+fu4
   TcedWBD53UWOy9c/fx8x/GsOCoYP7PukV6rhSwlo6VzouNZKDs5TtBEq7
   xi368YuoTCrCQB2xl3o5Za1xBzRgEJZkGUNlN8s9ps/5dMUqHKAwx88Lp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="382693804"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="382693804"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 01:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="1075270812"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="1075270812"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Sep 2023 01:13:01 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qghT9-0001MP-09;
        Thu, 14 Sep 2023 08:12:59 +0000
Date:   Thu, 14 Sep 2023 16:12:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        akpm@linux-foundation.org, thunder.leizhen@huawei.com,
        catalin.marinas@arm.com, chenjiahao16@huawei.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 6/9] x86: kdump: use generic interface to simplify
 crashkernel reservation code
Message-ID: <202309141534.moH4dTcz-lkp@intel.com>
References: <20230914033142.676708-7-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914033142.676708-7-bhe@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on powerpc/next]
[also build test WARNING on powerpc/fixes linus/master v6.6-rc1 next-20230914]
[cannot apply to arm64/for-next/core tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/crash_core-c-remove-unnecessary-parameter-of-function/20230914-113546
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20230914033142.676708-7-bhe%40redhat.com
patch subject: [PATCH v3 6/9] x86: kdump: use generic interface to simplify crashkernel reservation code
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230914/202309141534.moH4dTcz-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309141534.moH4dTcz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309141534.moH4dTcz-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/setup.c:476:15: warning: no previous prototype for function 'crash_low_size_default' [-Wmissing-prototypes]
   unsigned long crash_low_size_default(void)
                 ^
   arch/x86/kernel/setup.c:476:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long crash_low_size_default(void)
   ^
   static 
   1 warning generated.


vim +/crash_low_size_default +476 arch/x86/kernel/setup.c

   472	
   473	/*
   474	 * --------- Crashkernel reservation ------------------------------
   475	 */
 > 476	unsigned long crash_low_size_default(void)
   477	{
   478	#ifdef CONFIG_X86_64
   479		return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
   480	#else
   481		return 0;
   482	#endif
   483	}
   484	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
