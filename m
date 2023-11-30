Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027AE7FEAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbjK3Iey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344918AbjK3Iev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:34:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF6E10C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 00:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701333297; x=1732869297;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3Y2TBDVwQOzIxmpcXdwryCSZlupkhhoBTOPxm1mMjoc=;
  b=eqrgX3/t4cDOCli3jYSaDiKe8l64YHcMhzasxaKbIzIIuCI2501R0XCZ
   KIGLiVidqkJ0chepu4CCmDy8jKr4n6cQ+GotKTaO6D2xkDIlTYDvWQA5A
   s/9Xnv+aTWljA2p0CA+S5KfE4DhLz07oRtUycKYk8d7yHNn2gXwg9lgI9
   Qfu8uVPPLjWipFBaC1VorGb4e0UkeU9PPwD0euEAKW70HkppcKFXwEkM/
   RXRxu40jZg6mC/9YaiuKGrRqZAomXYKC/eN5sgSJV6R6Wlc62sZ/k7/yr
   6yoONwoNDxuVrlfDz1zLLvHCYcRahUdBYsatc/RV4XWAv0IIvtEpVUyHS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="6562152"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="6562152"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 00:34:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="803601501"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="803601501"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2023 00:34:56 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8cVZ-0001aF-2S;
        Thu, 30 Nov 2023 08:34:53 +0000
Date:   Thu, 30 Nov 2023 16:34:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leon Huang <Leon.Huang1@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_abm_lcd.c:253:63:
 sparse: sparse: cast truncates bits from constant value (ffff becomes ff)
Message-ID: <202311301656.jZFH7af7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: b8fe56375f78835db47565d91ea9d21767fe3c08 drm/amd/display: Refactor ABM feature
date:   8 months ago
config: sparc64-randconfig-r036-20230708 (https://download.01.org/0day-ci/archive/20231130/202311301656.jZFH7af7-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231130/202311301656.jZFH7af7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311301656.jZFH7af7-lkp@intel.com/

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
