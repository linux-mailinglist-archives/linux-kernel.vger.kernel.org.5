Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0727998BB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 15:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346121AbjIINq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 09:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIINq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 09:46:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A412512B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 06:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694267184; x=1725803184;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L/J2oj1wFgrbLdAStJtFXG99YZ0s8wTr/c9SvUrqHmM=;
  b=VDk6OPYFVqnZNqzbNEEJpoPXAx6xtS1w/gEohu1WgOKl2IbvPF8jB/XK
   7jEu3Eom7J4FBT48bo7S7CG6Bkwi+Onx3NrO3HCvibTnh0lK9kUf0eql5
   Mvtow5X2MXMiYUS8YEGMKpQGQw/yQndUeYrTtaVd7Ra2E9s104AWbSrCp
   +5LfWctuGqCV6J6t9D0oK4ZFcK2lcBtiwc1CjpJPyOSRAyPMyVfFwtl2f
   gJM3grc8D+/lyHvsOzRb4ARTSrr/hVqb/uu5zBk2fpwp6yRbSfk3/YDOl
   o0h2mGfCo+t43AWTLDurSJJoA6VFL4qhBkZSYqq0rzh6CGyoBtfMKiqeZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="377733873"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="377733873"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 06:46:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="857735638"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="857735638"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Sep 2023 06:46:22 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeyI0-0003Ye-1m;
        Sat, 09 Sep 2023 13:46:20 +0000
Date:   Sat, 9 Sep 2023 21:46:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dillon Varone <Dillon.Varone@amd.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Jun Lei <Jun.Lei@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1684:6:
 warning: stack frame size (2072) exceeds limit (2048) in
 'dml32_ModeSupportAndSystemConfigurationFull'
Message-ID: <202309092155.8xQKDjJA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: ce902d987a8caa5c9a96080e280ecc992414a127 drm/amd/display: Enforce minimum prefetch time for low memclk on DCN32
date:   10 months ago
config: x86_64-randconfig-015-20230909 (https://download.01.org/0day-ci/archive/20230909/202309092155.8xQKDjJA-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309092155.8xQKDjJA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309092155.8xQKDjJA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1684:6: warning: stack frame size (2072) exceeds limit (2048) in 'dml32_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than]
   void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
        ^
   1076/2072 (51.93%) spills, 996/2072 (48.07%) variables
   1 warning generated.


vim +/dml32_ModeSupportAndSystemConfigurationFull +1684 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c

1b54a0121dba12 Rodrigo Siqueira 2022-07-22  1683  
dda4fb85e433f7 Aurabindo Pillai 2022-02-21 @1684  void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
dda4fb85e433f7 Aurabindo Pillai 2022-02-21  1685  {
7acc487ab57e07 Alex Deucher     2022-07-20  1686  	struct vba_vars_st *v = &mode_lib->vba;
7acc487ab57e07 Alex Deucher     2022-07-20  1687  	int i, j;
7acc487ab57e07 Alex Deucher     2022-07-20  1688  	unsigned int k, m;
dda4fb85e433f7 Aurabindo Pillai 2022-02-21  1689  	unsigned int MaximumMPCCombine;
7acc487ab57e07 Alex Deucher     2022-07-20  1690  	unsigned int NumberOfNonCombinedSurfaceOfMaximumBandwidth;
7acc487ab57e07 Alex Deucher     2022-07-20  1691  	unsigned int TotalSlots;
f4b4e41a2e0527 Jun Lei          2022-06-24  1692  	bool CompBufReservedSpaceNeedAdjustment;
f4b4e41a2e0527 Jun Lei          2022-06-24  1693  	bool CompBufReservedSpaceNeedAdjustmentSingleDPP;
dda4fb85e433f7 Aurabindo Pillai 2022-02-21  1694  

:::::: The code at line 1684 was first introduced by commit
:::::: dda4fb85e433f761eedaed0005a2bc20d705d504 drm/amd/display: DML changes for DCN32/321

:::::: TO: Aurabindo Pillai <aurabindo.pillai@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
