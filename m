Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5CD7A1480
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjIODkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjIODkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:40:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13246196;
        Thu, 14 Sep 2023 20:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694749249; x=1726285249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bt+hjTDDLQJjJdIyHbFT3WkRnY7jlECv6Dg+oQ8mbWs=;
  b=BhtYZHlAe/mkoVg/xN7V3G854aF4ux3At+iirP8cCRvZy5kk84awt7VA
   iuNEvSG5IHOcMHc/sulng6rhuvsCsoKtvg7RzhaFQRkcBgue/gI+QKwd2
   KV4cN6tm24tiZxBxq1Lk0M0EXURE52DAZOjbiYktaOEVciJsW7kTwXPLn
   QNP7Gl82ledbW5oTINJQU90BjU8I0IV0/KBFTA0sc03Argn3eQOEqDMgU
   8XWcBhbpfzbNxJQryQlDfevXm2cH4oGDEBW2Py8Zp8Q/AYoUotokOYNwf
   16y3vyiGAlJvthOEfEL771XvVOtjHI9nK5dDtbCqOOvVS1Ie3UJqfItCR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="376484390"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="376484390"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 20:40:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="991693467"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="991693467"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 14 Sep 2023 20:40:46 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgzfq-0002O5-2g;
        Fri, 15 Sep 2023 03:39:41 +0000
Date:   Fri, 15 Sep 2023 11:39:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oza Pawandeep <quic_poza@quicinc.com>, sudeep.holla@arm.com,
        catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
        lenb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Oza Pawandeep <quic_poza@quicinc.com>
Subject: Re: [PATCH v6] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <202309151138.69mFCPtW-lkp@intel.com>
References: <20230914184840.649412-1-quic_poza@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914184840.649412-1-quic_poza@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oza,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc1 next-20230915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oza-Pawandeep/cpuidle-ACPI-Evaluate-LPI-arch_flags-for-broadcast-timer/20230915-025307
base:   linus/master
patch link:    https://lore.kernel.org/r/20230914184840.649412-1-quic_poza%40quicinc.com
patch subject: [PATCH v6] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20230915/202309151138.69mFCPtW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230915/202309151138.69mFCPtW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309151138.69mFCPtW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/kernel/setup.c:36:
>> arch/arm64/include/asm/acpi.h:60: warning: "arch_update_idle_state_flags" redefined
      60 | #define arch_update_idle_state_flags _arch_update_idle_state_flags
         | 
   In file included from arch/arm64/kernel/setup.c:9:
   include/linux/acpi.h:1484: note: this is the location of the previous definition
    1484 | #define arch_update_idle_state_flags(af, sf)    do {} while (0)
         | 


vim +/arch_update_idle_state_flags +60 arch/arm64/include/asm/acpi.h

    53	
    54	static __always_inline void _arch_update_idle_state_flags(u32 arch_flags,
    55								unsigned int *sflags)
    56	{
    57		if (arch_flags & CPUIDLE_CORE_CTXT)
    58			*sflags |= CPUIDLE_FLAG_TIMER_STOP;
    59	}
  > 60	#define arch_update_idle_state_flags _arch_update_idle_state_flags
    61	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
