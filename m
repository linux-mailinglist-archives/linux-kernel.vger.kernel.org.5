Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC56790A83
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 03:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbjICB5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 21:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjICB5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 21:57:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91199131
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 18:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693706261; x=1725242261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=w7kAA0dDhx3JMWGLOZ3PRy9gzEcEaBz2rEhs9OuIcYs=;
  b=eIA8vaILgdW4iWVo1gnc9A5y47WXsXRpunv3uvlF/1n3MnvX+FHqMu+J
   bkmZa2S/8RbYSVwOtGFBI6hQadRNct+vpO7DK+6rZW3CuoG3xdK5nY/I/
   bQwh/lvSIXPfRPFvn5jSuKB9jMvGaXhM1D4+tzNRSlfEeM3jArHUHwJKO
   3uvsizWnwlN2knmf6xwg6sn0hAZ+/TstXJudVXQtA2Frb4ZPPYcQU78tg
   Y3C9glar0MepMtdWh884NLGPtBWGEHV3xlkWWerbiHu7TWEhr39F7tTBe
   dCzP2fw6mLrDtJLcvbgWAlR7JXXX2zBl5hLZ+8ATAaKV+91R0r9x4CrDV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="380203285"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="380203285"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 18:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="855164368"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="855164368"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2023 18:57:38 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qccMq-0002nH-0t;
        Sun, 03 Sep 2023 01:57:36 +0000
Date:   Sun, 3 Sep 2023 09:56:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, pierre-eric.pelloux-prayer@amd.com,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com
Subject: Re: [PATCH 1/2] drm/amdgpu: Merge debug module parameters
Message-ID: <202309030946.q2LgJYO7-lkp@intel.com>
References: <20230824162505.173399-2-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824162505.173399-2-andrealmeid@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi André,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.5 next-20230831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/drm-amdgpu-Merge-debug-module-parameters/20230825-002641
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230824162505.173399-2-andrealmeid%40igalia.com
patch subject: [PATCH 1/2] drm/amdgpu: Merge debug module parameters
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230903/202309030946.q2LgJYO7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230903/202309030946.q2LgJYO7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309030946.q2LgJYO7-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c: In function 'amdgpu_init_debug_options':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:2923:33: error: assignment of read-only variable 'debug_evictions'
    2923 |                 debug_evictions = true;
         |                                 ^
>> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:2933:17: error: 'debug_largebar' undeclared (first use in this function)
    2933 |                 debug_largebar = true;
         |                 ^~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:2933:17: note: each undeclared identifier is reported only once for each function it appears in


vim +/debug_evictions +2923 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c

  2918	
  2919	static void amdgpu_init_debug_options(void)
  2920	{
  2921		if (amdgpu_debug_mask & DEBUG_VERBOSE_EVICTIONS) {
  2922			pr_info("debug: eviction debug messages enabled\n");
> 2923			debug_evictions = true;
  2924		}
  2925	
  2926		if (amdgpu_debug_mask & DEBUG_VM) {
  2927			pr_info("debug: VM handling debug enabled\n");
  2928			amdgpu_vm_debug = true;
  2929		}
  2930	
  2931		if (amdgpu_debug_mask & DEBUG_LARGEBAR) {
  2932			pr_info("debug: enabled simulating large-bar capability on non-large bar system\n");
> 2933			debug_largebar = true;
  2934		}
  2935	}
  2936	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
