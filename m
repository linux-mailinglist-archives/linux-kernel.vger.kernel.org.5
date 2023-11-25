Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B177F88CE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKYHY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYHY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:24:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7418BD57
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 23:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700897074; x=1732433074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EKXobDNAisJFES+aua3AQTfSzZ0E5+bKj+a4rhFGrPo=;
  b=Eazzgyod8mwHaJevGMoh4v4dVF8SLtAmN8cR/VyhqXV1+tWTI+bKK1ve
   jmb8P3vpy74LJXPymfyK3FGmZTqT290k0XvhuLCPUzSzIh3fAUMHlJVjJ
   NNBte+VlsH2sKpbhh0L/oFxYWTxah2Gq5gIPuYEEPxEYdV9LEnWI6apsh
   10SejMx9Pt1KLhNG/cq6LaciT8gxBLfAmjQcPPUFov0DNKZzoqk6MtStG
   dNFT9/rlLU5kvdM15Jq0A+xoLEOlPcCJgYYTNNGKTKfMcVxoARwYqgHo6
   g0nOkIyJPgEC5y46Vne5JAVFbx+0j77nUvJAALPk7pCvLw1qBSXV5EvDf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="372655167"
X-IronPort-AV: E=Sophos;i="6.04,225,1695711600"; 
   d="scan'208";a="372655167"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 23:24:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="1015075370"
X-IronPort-AV: E=Sophos;i="6.04,225,1695711600"; 
   d="scan'208";a="1015075370"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 24 Nov 2023 23:24:31 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6n1h-0003jB-2l;
        Sat, 25 Nov 2023 07:24:29 +0000
Date:   Sat, 25 Nov 2023 15:24:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Bohac <jbohac@suse.cz>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        mhocko@suse.cz
Subject: Re: [PATCH 1/4] kdump: add crashkernel cma suffix
Message-ID: <202311251303.71yrbT6l-lkp@intel.com>
References: <ZWEAPXiCCgAf1WrY@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWEAPXiCCgAf1WrY@dwarf.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on powerpc/next]
[also build test WARNING on powerpc/fixes s390/features linus/master v6.7-rc2 next-20231124]
[cannot apply to tip/x86/core arm64/for-next/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiri-Bohac/kdump-implement-reserve_crashkernel_cma/20231125-082724
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/ZWEAPXiCCgAf1WrY%40dwarf.suse.cz
patch subject: [PATCH 1/4] kdump: add crashkernel cma suffix
config: alpha-randconfig-r081-20231125 (https://download.01.org/0day-ci/archive/20231125/202311251303.71yrbT6l-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311251303.71yrbT6l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311251303.71yrbT6l-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/crash_core.c: In function 'parse_crashkernel':
>> kernel/crash_core.c:319:28: warning: unused variable 'cma_base' [-Wunused-variable]
     319 |         unsigned long long cma_base;
         |                            ^~~~~~~~


vim +/cma_base +319 kernel/crash_core.c

   302	
   303	/*
   304	 * That function is the entry point for command line parsing and should be
   305	 * called from the arch-specific code.
   306	 *
   307	 * If crashkernel=,high|low is supported on architecture, non-NULL values
   308	 * should be passed to parameters 'low_size' and 'high'.
   309	 */
   310	int __init parse_crashkernel(char *cmdline,
   311				     unsigned long long system_ram,
   312				     unsigned long long *crash_size,
   313				     unsigned long long *crash_base,
   314				     unsigned long long *low_size,
   315				     unsigned long long *cma_size,
   316				     bool *high)
   317	{
   318		int ret;
 > 319		unsigned long long cma_base;
   320	
   321		/* crashkernel=X[@offset] */
   322		ret = __parse_crashkernel(cmdline, system_ram, crash_size,
   323					crash_base, NULL);
   324	#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
   325		/*
   326		 * If non-NULL 'high' passed in and no normal crashkernel
   327		 * setting detected, try parsing crashkernel=,high|low.
   328		 */
   329		if (high && ret == -ENOENT) {
   330			ret = __parse_crashkernel(cmdline, 0, crash_size,
   331					crash_base, suffix_tbl[SUFFIX_HIGH]);
   332			if (ret || !*crash_size)
   333				return -EINVAL;
   334	
   335			/*
   336			 * crashkernel=Y,low can be specified or not, but invalid value
   337			 * is not allowed.
   338			 */
   339			ret = __parse_crashkernel(cmdline, 0, low_size,
   340					crash_base, suffix_tbl[SUFFIX_LOW]);
   341			if (ret == -ENOENT) {
   342				*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
   343				ret = 0;
   344			} else if (ret) {
   345				return ret;
   346			}
   347	
   348			*high = true;
   349		}
   350	
   351		/*
   352		* optional CMA reservation
   353		* cma_base is ignored
   354		*/
   355		if (cma_size)
   356			__parse_crashkernel(cmdline, 0, cma_size,
   357				&cma_base, suffix_tbl[SUFFIX_CMA]);
   358	#endif
   359		if (!*crash_size)
   360			ret = -EINVAL;
   361	
   362		return ret;
   363	}
   364	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
