Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762B87FE6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 03:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343936AbjK3CTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344146AbjK3CS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:18:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC93D5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 18:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701310744; x=1732846744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pl0zM653ZYuAq9oghChWbz41v4bjQe3jljVDgnRIUU8=;
  b=awlwEwq6S1QHPZ91rZDMIaLRcSnYAS9MRwUpVxIlm33P/z/2PgvS8Gfp
   c5Rz6SuWExE/jTDU6wRiGhw9SnECjAvE0nQT8S8/5v3WpI+W+eOF7elrY
   du1eM1iJqdJbmG0x/98y2S3SxjcF0n6z03dtlCl14QlpIAUnUEOX53NpR
   4X/1TVSPGNrE0TS0UluzvJC4IwN1mD1NBfyRWGJbkP7k74VkQfWzp1N7g
   Kfbg0SVPzXjTfT3cLxXrAeaj1R6wuOMoonBQ6t9tY/KhyoYaj6qxiyJ+o
   t/CxPC9SMRYPhTluUjQHh++C3GzqEZpPG0O/8AYkIolbZMUJpWCpXzeNa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="392121459"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="392121459"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 18:19:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="10591917"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 29 Nov 2023 18:19:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8Wdn-0001F8-1t;
        Thu, 30 Nov 2023 02:18:59 +0000
Date:   Thu, 30 Nov 2023 10:18:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:721:64:
 sparse: sparse: cast truncates bits from constant value (44 becomes 4)
Message-ID: <202311300627.JIslfWKU-lkp@intel.com>
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
commit: c186c13e65286a46b61f5c295f9f9c65c75c926e drm/amd/display: Drop unnecessary DCN guards
date:   9 months ago
config: sparc64-randconfig-r036-20230708 (https://download.01.org/0day-ci/archive/20231130/202311300627.JIslfWKU-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231130/202311300627.JIslfWKU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311300627.JIslfWKU-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h, ...):
   include/linux/page-flags.h:246:46: sparse: sparse: self-comparison always evaluates to false
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:721:64: sparse: sparse: cast truncates bits from constant value (44 becomes 4)

vim +721 drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c

85f4bc0c333cee Alvin Lee        2022-05-02  694  
85f4bc0c333cee Alvin Lee        2022-05-02  695  /**
6be153dc8c8840 Rodrigo Siqueira 2022-10-20  696   * dc_dmub_setup_subvp_dmub_command - Populate the DMCUB SubVP command
85f4bc0c333cee Alvin Lee        2022-05-02  697   *
6be153dc8c8840 Rodrigo Siqueira 2022-10-20  698   * @dc: [in] current dc state
6be153dc8c8840 Rodrigo Siqueira 2022-10-20  699   * @context: [in] new dc state
01543dcf99bdab Arthur Grillo    2023-02-13  700   * @enable: [in] if true enables the pipes population
85f4bc0c333cee Alvin Lee        2022-05-02  701   *
6be153dc8c8840 Rodrigo Siqueira 2022-10-20  702   * This function loops through each pipe and populates the DMUB SubVP CMD info
6be153dc8c8840 Rodrigo Siqueira 2022-10-20  703   * based on the pipe (e.g. SubVP, VBLANK).
85f4bc0c333cee Alvin Lee        2022-05-02  704   */
85f4bc0c333cee Alvin Lee        2022-05-02  705  void dc_dmub_setup_subvp_dmub_command(struct dc *dc,
85f4bc0c333cee Alvin Lee        2022-05-02  706  		struct dc_state *context,
85f4bc0c333cee Alvin Lee        2022-05-02  707  		bool enable)
85f4bc0c333cee Alvin Lee        2022-05-02  708  {
85f4bc0c333cee Alvin Lee        2022-05-02  709  	uint8_t cmd_pipe_index = 0;
85f4bc0c333cee Alvin Lee        2022-05-02  710  	uint32_t i, pipe_idx;
85f4bc0c333cee Alvin Lee        2022-05-02  711  	uint8_t subvp_count = 0;
85f4bc0c333cee Alvin Lee        2022-05-02  712  	union dmub_rb_cmd cmd;
85f4bc0c333cee Alvin Lee        2022-05-02  713  	struct pipe_ctx *subvp_pipes[2];
85f4bc0c333cee Alvin Lee        2022-05-02  714  	uint32_t wm_val_refclk = 0;
85f4bc0c333cee Alvin Lee        2022-05-02  715  
85f4bc0c333cee Alvin Lee        2022-05-02  716  	memset(&cmd, 0, sizeof(cmd));
85f4bc0c333cee Alvin Lee        2022-05-02  717  	// FW command for SUBVP
85f4bc0c333cee Alvin Lee        2022-05-02  718  	cmd.fw_assisted_mclk_switch_v2.header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
85f4bc0c333cee Alvin Lee        2022-05-02  719  	cmd.fw_assisted_mclk_switch_v2.header.sub_type = DMUB_CMD__HANDLE_SUBVP_CMD;
85f4bc0c333cee Alvin Lee        2022-05-02  720  	cmd.fw_assisted_mclk_switch_v2.header.payload_bytes =
85f4bc0c333cee Alvin Lee        2022-05-02 @721  			sizeof(cmd.fw_assisted_mclk_switch_v2) - sizeof(cmd.fw_assisted_mclk_switch_v2.header);
85f4bc0c333cee Alvin Lee        2022-05-02  722  
85f4bc0c333cee Alvin Lee        2022-05-02  723  	for (i = 0; i < dc->res_pool->pipe_count; i++) {
85f4bc0c333cee Alvin Lee        2022-05-02  724  		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
85f4bc0c333cee Alvin Lee        2022-05-02  725  
85f4bc0c333cee Alvin Lee        2022-05-02  726  		if (!pipe->stream)
85f4bc0c333cee Alvin Lee        2022-05-02  727  			continue;
85f4bc0c333cee Alvin Lee        2022-05-02  728  
b0d6de32e30c63 Alvin Lee        2022-09-01  729  		/* For SubVP pipe count, only count the top most (ODM / MPC) pipe
b0d6de32e30c63 Alvin Lee        2022-09-01  730  		 */
b0d6de32e30c63 Alvin Lee        2022-09-01  731  		if (pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe &&
85f4bc0c333cee Alvin Lee        2022-05-02  732  				pipe->stream->mall_stream_config.type == SUBVP_MAIN)
85f4bc0c333cee Alvin Lee        2022-05-02  733  			subvp_pipes[subvp_count++] = pipe;
85f4bc0c333cee Alvin Lee        2022-05-02  734  	}
85f4bc0c333cee Alvin Lee        2022-05-02  735  
85f4bc0c333cee Alvin Lee        2022-05-02  736  	if (enable) {
85f4bc0c333cee Alvin Lee        2022-05-02  737  		// For each pipe that is a "main" SUBVP pipe, fill in pipe data for DMUB SUBVP cmd
85f4bc0c333cee Alvin Lee        2022-05-02  738  		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
85f4bc0c333cee Alvin Lee        2022-05-02  739  			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
85f4bc0c333cee Alvin Lee        2022-05-02  740  
85f4bc0c333cee Alvin Lee        2022-05-02  741  			if (!pipe->stream)
85f4bc0c333cee Alvin Lee        2022-05-02  742  				continue;
85f4bc0c333cee Alvin Lee        2022-05-02  743  
b0d6de32e30c63 Alvin Lee        2022-09-01  744  			/* When populating subvp cmd info, only pass in the top most (ODM / MPC) pipe.
b0d6de32e30c63 Alvin Lee        2022-09-01  745  			 * Any ODM or MPC splits being used in SubVP will be handled internally in
b0d6de32e30c63 Alvin Lee        2022-09-01  746  			 * populate_subvp_cmd_pipe_info
b0d6de32e30c63 Alvin Lee        2022-09-01  747  			 */
85f4bc0c333cee Alvin Lee        2022-05-02  748  			if (pipe->plane_state && pipe->stream->mall_stream_config.paired_stream &&
b0d6de32e30c63 Alvin Lee        2022-09-01  749  					!pipe->top_pipe && !pipe->prev_odm_pipe &&
85f4bc0c333cee Alvin Lee        2022-05-02  750  					pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
85f4bc0c333cee Alvin Lee        2022-05-02  751  				populate_subvp_cmd_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
9bb10b7aaec3b6 Ayush Gupta      2023-02-10  752  			} else if (pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_NONE &&
9bb10b7aaec3b6 Ayush Gupta      2023-02-10  753  				    !pipe->top_pipe && !pipe->prev_odm_pipe) {
85f4bc0c333cee Alvin Lee        2022-05-02  754  				// Don't need to check for ActiveDRAMClockChangeMargin < 0, not valid in cases where
85f4bc0c333cee Alvin Lee        2022-05-02  755  				// we run through DML without calculating "natural" P-state support
85f4bc0c333cee Alvin Lee        2022-05-02  756  				populate_subvp_cmd_vblank_pipe_info(dc, context, &cmd, pipe, cmd_pipe_index++);
85f4bc0c333cee Alvin Lee        2022-05-02  757  
85f4bc0c333cee Alvin Lee        2022-05-02  758  			}
85f4bc0c333cee Alvin Lee        2022-05-02  759  			pipe_idx++;
85f4bc0c333cee Alvin Lee        2022-05-02  760  		}
85f4bc0c333cee Alvin Lee        2022-05-02  761  		if (subvp_count == 2) {
85f4bc0c333cee Alvin Lee        2022-05-02  762  			update_subvp_prefetch_end_to_mall_start(dc, context, &cmd, subvp_pipes);
85f4bc0c333cee Alvin Lee        2022-05-02  763  		}
85f4bc0c333cee Alvin Lee        2022-05-02  764  		cmd.fw_assisted_mclk_switch_v2.config_data.pstate_allow_width_us = dc->caps.subvp_pstate_allow_width_us;
85f4bc0c333cee Alvin Lee        2022-05-02  765  		cmd.fw_assisted_mclk_switch_v2.config_data.vertical_int_margin_us = dc->caps.subvp_vertical_int_margin_us;
85f4bc0c333cee Alvin Lee        2022-05-02  766  
85f4bc0c333cee Alvin Lee        2022-05-02  767  		// Store the original watermark value for this SubVP config so we can lower it when the
85f4bc0c333cee Alvin Lee        2022-05-02  768  		// MCLK switch starts
85f4bc0c333cee Alvin Lee        2022-05-02  769  		wm_val_refclk = context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns *
9799702360d51a Alvin Lee        2022-06-29  770  				(dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000) / 1000;
85f4bc0c333cee Alvin Lee        2022-05-02  771  
85f4bc0c333cee Alvin Lee        2022-05-02  772  		cmd.fw_assisted_mclk_switch_v2.config_data.watermark_a_cache = wm_val_refclk < 0xFFFF ? wm_val_refclk : 0xFFFF;
85f4bc0c333cee Alvin Lee        2022-05-02  773  	}
85f4bc0c333cee Alvin Lee        2022-05-02  774  	dc_dmub_srv_cmd_queue(dc->ctx->dmub_srv, &cmd);
85f4bc0c333cee Alvin Lee        2022-05-02  775  	dc_dmub_srv_cmd_execute(dc->ctx->dmub_srv);
85f4bc0c333cee Alvin Lee        2022-05-02  776  	dc_dmub_srv_wait_idle(dc->ctx->dmub_srv);
85f4bc0c333cee Alvin Lee        2022-05-02  777  }
85f4bc0c333cee Alvin Lee        2022-05-02  778  

:::::: The code at line 721 was first introduced by commit
:::::: 85f4bc0c333ceed24cbc9f69a2a77fab1ae3d4d1 drm/amd/display: Add SubVP required code

:::::: TO: Alvin Lee <Alvin.Lee2@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
