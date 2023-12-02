Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943428019B8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 02:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjLBBmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 20:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBBmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 20:42:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD0B116
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 17:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701481349; x=1733017349;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZO29iu/oyxoU9JH5mz/IFKz/Uz60hiaZME2RI7JzULM=;
  b=GtfE3BZE8khF5pmofEoHCRfkZazSeQZZJeDCrjwTkoqHRi8c4WAqeUDj
   Dov3lV0HuDjdSSjwX3VVGbvtgcpcV7uq5RiEwNjqq6EnlgUE+zvH27ykz
   vjtRhHr/fP07pivU5MHA865Y+zpKkyC9e2rUpVikKYMBL5GVQNtorkFOA
   mYM8F7phGBzlVH5qtcFvXXerjh5UZCZQ2m14BnbVmzqJ6MJCt+ndyM1NW
   cEqr5OXrUnCzA7C6Sh9ORTCLs9EavvwPQmlshXYyrTSFZXQh+gQXVQz8C
   MI+dBniG5saJQkoGHqTAgmvmysplbtvEbC7RgnvlMGmMoNjMUMOrlUJYs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="397459085"
X-IronPort-AV: E=Sophos;i="6.04,243,1695711600"; 
   d="scan'208";a="397459085"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 17:42:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,243,1695711600"; 
   d="scan'208";a="17951299"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 01 Dec 2023 17:42:28 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9F1U-0004Wc-2y;
        Sat, 02 Dec 2023 01:42:24 +0000
Date:   Sat, 2 Dec 2023 09:42:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Huang <Leon.Huang1@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:253:63:
 sparse: sparse: cast truncates bits from constant value (ffff becomes ff)
Message-ID: <202312020943.r4FQzx2s-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b1e51588aa50287c3d33e14969d47ccdd403ad80
commit: b8fe56375f78835db47565d91ea9d21767fe3c08 drm/amd/display: Refactor ABM feature
date:   8 months ago
config: sparc64-randconfig-r036-20230708 (https://download.01.org/0day-ci/archive/20231202/202312020943.r4FQzx2s-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231202/202312020943.r4FQzx2s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312020943.r4FQzx2s-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:83:6: sparse: sparse: symbol 'dmub_abm_init' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:124:14: sparse: sparse: symbol 'dmub_abm_get_current_backlight' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:135:14: sparse: sparse: symbol 'dmub_abm_get_target_backlight' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:146:6: sparse: sparse: symbol 'dmub_abm_set_level' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:167:6: sparse: sparse: symbol 'dmub_abm_set_ambient_level' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:189:6: sparse: sparse: symbol 'dmub_abm_init_config' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:221:6: sparse: sparse: symbol 'dmub_abm_set_pause' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:241:6: sparse: sparse: symbol 'dmub_abm_set_pipe' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:263:6: sparse: sparse: symbol 'dmub_abm_set_backlight_level' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h, ...):
   include/linux/page-flags.h:246:46: sparse: sparse: self-comparison always evaluates to false
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:253:63: sparse: sparse: cast truncates bits from constant value (ffff becomes ff)

vim +253 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c

   240	
   241	bool dmub_abm_set_pipe(struct abm *abm, uint32_t otg_inst, uint32_t option, uint32_t panel_inst)
   242	{
   243		union dmub_rb_cmd cmd;
   244		struct dc_context *dc = abm->ctx;
   245		uint32_t ramping_boundary = 0xFFFF;
   246	
   247		memset(&cmd, 0, sizeof(cmd));
   248		cmd.abm_set_pipe.header.type = DMUB_CMD__ABM;
   249		cmd.abm_set_pipe.header.sub_type = DMUB_CMD__ABM_SET_PIPE;
   250		cmd.abm_set_pipe.abm_set_pipe_data.otg_inst = otg_inst;
   251		cmd.abm_set_pipe.abm_set_pipe_data.set_pipe_option = option;
   252		cmd.abm_set_pipe.abm_set_pipe_data.panel_inst = panel_inst;
 > 253		cmd.abm_set_pipe.abm_set_pipe_data.ramping_boundary = ramping_boundary;
   254		cmd.abm_set_pipe.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_pipe_data);
   255	
   256		dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
   257		dc_dmub_srv_cmd_execute(dc->dmub_srv);
   258		dc_dmub_srv_wait_idle(dc->dmub_srv);
   259	
   260		return true;
   261	}
   262	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
