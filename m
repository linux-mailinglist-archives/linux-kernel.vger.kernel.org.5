Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDAC790394
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245077AbjIAWTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjIAWTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:19:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F103F2D56;
        Fri,  1 Sep 2023 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693606741; x=1725142741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RGoNgoP1tkAOm5Qmu/pw23EzpeEN4IrBktGvciLUMlY=;
  b=IzPNuwIR7WK86LeFvk+/fwGkFJtLPZYDannNxYVQPPZOK2QOMPro7Sdo
   RHy8llYbhb08NLTWihqOsvDbz+nDYMJ8q/fEQZXPuXPUX5zqeQcZr+XuF
   lG5palw263Iexjfi8mJviM6j2GCBwulSjKAhCiPwiC0IYOVAKXWZUInXN
   Un8gO/oEIAnkDOMnsLDprDOkaaHQrWGDsOOmZP11cPM6TyUDANP/EE0lF
   2FMSvSoBR/Yhoy4cdFxmynzay9ktZXrz8sTCeNvmGPy0l1yiUKNHijYgE
   IrdYVPeUYgw/V0kAL92weHM/CNBUO8HfqMSeP0kHk/RiQ7A3sgv9IDcL8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373714329"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="373714329"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 15:19:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805598368"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="805598368"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Sep 2023 15:18:56 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qcCTe-0001h7-2E;
        Fri, 01 Sep 2023 22:18:54 +0000
Date:   Sat, 2 Sep 2023 06:18:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run,
        marijn.suijten@somainline.org, robh@kernel.org,
        steven.price@arm.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, adrian.larumbe@collabora.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        healych@amazon.com, kernel@collabora.com,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 6/6] drm/drm-file: Allow size unit selection in
 drm_show_memory_stats
Message-ID: <202309020634.fwC7KBk6-lkp@intel.com>
References: <20230824013604.466224-7-adrian.larumbe@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824013604.466224-7-adrian.larumbe@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrián,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.5 next-20230831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adri-n-Larumbe/drm-panfrost-Add-cycle-count-GPU-register-definitions/20230824-093848
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230824013604.466224-7-adrian.larumbe%40collabora.com
patch subject: [PATCH v2 6/6] drm/drm-file: Allow size unit selection in drm_show_memory_stats
config: x86_64-randconfig-002-20230902 (https://download.01.org/0day-ci/archive/20230902/202309020634.fwC7KBk6-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230902/202309020634.fwC7KBk6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309020634.fwC7KBk6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_file.c:905: warning: Function parameter or member 'unit' not described in 'drm_print_memory_stats'


vim +905 drivers/gpu/drm/drm_file.c

686b21b5f6ca2f Rob Clark      2023-05-24  891  
686b21b5f6ca2f Rob Clark      2023-05-24  892  /**
686b21b5f6ca2f Rob Clark      2023-05-24  893   * drm_print_memory_stats - A helper to print memory stats
686b21b5f6ca2f Rob Clark      2023-05-24  894   * @p: The printer to print output to
686b21b5f6ca2f Rob Clark      2023-05-24  895   * @stats: The collected memory stats
686b21b5f6ca2f Rob Clark      2023-05-24  896   * @supported_status: Bitmask of optional stats which are available
686b21b5f6ca2f Rob Clark      2023-05-24  897   * @region: The memory region
686b21b5f6ca2f Rob Clark      2023-05-24  898   *
686b21b5f6ca2f Rob Clark      2023-05-24  899   */
686b21b5f6ca2f Rob Clark      2023-05-24  900  void drm_print_memory_stats(struct drm_printer *p,
686b21b5f6ca2f Rob Clark      2023-05-24  901  			    const struct drm_memory_stats *stats,
686b21b5f6ca2f Rob Clark      2023-05-24  902  			    enum drm_gem_object_status supported_status,
cccad8cb432637 Adrián Larumbe 2023-08-24  903  			    const char *region,
cccad8cb432637 Adrián Larumbe 2023-08-24  904  			    unsigned int unit)
686b21b5f6ca2f Rob Clark      2023-05-24 @905  {
cccad8cb432637 Adrián Larumbe 2023-08-24  906  	print_size(p, "total", region, stats->private + stats->shared, unit);
cccad8cb432637 Adrián Larumbe 2023-08-24  907  	print_size(p, "shared", region, stats->shared, unit);
cccad8cb432637 Adrián Larumbe 2023-08-24  908  	print_size(p, "active", region, stats->active, unit);
686b21b5f6ca2f Rob Clark      2023-05-24  909  
686b21b5f6ca2f Rob Clark      2023-05-24  910  	if (supported_status & DRM_GEM_OBJECT_RESIDENT)
cccad8cb432637 Adrián Larumbe 2023-08-24  911  		print_size(p, "resident", region, stats->resident, unit);
686b21b5f6ca2f Rob Clark      2023-05-24  912  
686b21b5f6ca2f Rob Clark      2023-05-24  913  	if (supported_status & DRM_GEM_OBJECT_PURGEABLE)
cccad8cb432637 Adrián Larumbe 2023-08-24  914  		print_size(p, "purgeable", region, stats->purgeable, unit);
686b21b5f6ca2f Rob Clark      2023-05-24  915  }
686b21b5f6ca2f Rob Clark      2023-05-24  916  EXPORT_SYMBOL(drm_print_memory_stats);
686b21b5f6ca2f Rob Clark      2023-05-24  917  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
