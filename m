Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9674B813361
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573523AbjLNOlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjLNOla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:41:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBF4115
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702564896; x=1734100896;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9rgxfOe2FH8YxsT2QMJChnJtUV9rZKfVkhp7rG3QJIw=;
  b=i+35Wg9kzJtmIcH0y76Haye9HrZyULpusaciWeiAYebaqo0vZyCSGFd1
   mjF9cnx52IVOQKEfNJ4OeF7EDvLfmTqXGnPnNAmpBav7YNaFaZu9Ky8ih
   85s4B1PdYjJed5xKvl+zN/9joDfSYVqcHAsdrTGx96u1SsIa5rf12Hued
   egXeJp/O5vE7affcjIalKYc9973faE9pZliVNeXuoOtrM+NBcXBFf5bdz
   8uz3x9cqmSTkjblfGSWgqELItREzIYsBF6LJsbgKFbi0JMtkKGNMrEUqQ
   a8O5ct+RD+o3AZrtT0doWgKonZa31Xle2HYtLJ5pqN+aF8EEwRlsGsuM0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392302135"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="392302135"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:41:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="892488774"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="892488774"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2023 06:41:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDmu3-000MBO-2Z;
        Thu, 14 Dec 2023 14:41:31 +0000
Date:   Thu, 14 Dec 2023 22:40:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Francis <David.Francis@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:809:67:
 sparse: sparse: dubious: x | !y
Message-ID: <202312142225.r4UO3nhc-lkp@intel.com>
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
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: c85e6e546edd7e362693218a33a6f63217802fd3 drm/amd/display: Create new i2c resource
date:   5 years ago
config: x86_64-randconfig-121-20231101 (https://download.01.org/0day-ci/archive/20231214/202312142225.r4UO3nhc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312142225.r4UO3nhc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312142225.r4UO3nhc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:89:6: sparse: sparse: symbol 'dce_i2c_hw_engine_acquire_engine' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:113:6: sparse: sparse: symbol 'dce_i2c_engine_acquire_hw' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:301:35: sparse: sparse: symbol 'dce_i2c_hw_engine_wait_on_operation_result' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:369:10: sparse: sparse: symbol 'get_reference_clock' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:677:6: sparse: sparse: symbol 'dce_i2c_hw_engine_submit_request' was not declared. Should it be static?
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:809:67: sparse: sparse: dubious: x | !y
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:89:6: warning: no previous prototype for 'dce_i2c_hw_engine_acquire_engine' [-Wmissing-prototypes]
      89 | bool dce_i2c_hw_engine_acquire_engine(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:113:6: warning: no previous prototype for 'dce_i2c_engine_acquire_hw' [-Wmissing-prototypes]
     113 | bool dce_i2c_engine_acquire_hw(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:301:35: warning: no previous prototype for 'dce_i2c_hw_engine_wait_on_operation_result' [-Wmissing-prototypes]
     301 | enum i2c_channel_operation_result dce_i2c_hw_engine_wait_on_operation_result(
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:369:10: warning: no previous prototype for 'get_reference_clock' [-Wmissing-prototypes]
     369 | uint32_t get_reference_clock(
         |          ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:677:6: warning: no previous prototype for 'dce_i2c_hw_engine_submit_request' [-Wmissing-prototypes]
     677 | bool dce_i2c_hw_engine_submit_request(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:25:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:120:22: warning: 'DP_DVI_CONVERTER_ID_4' defined but not used [-Wunused-const-variable=]
     120 | static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:118:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
     118 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:116:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
     116 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c:25:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
         |                                ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
      74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
         |                                ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
      73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
         |                                ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
      72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
         |                                ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:67:32: warning: 'dc_fixpt_zero' defined but not used [-Wunused-const-variable=]
      67 | static const struct fixed31_32 dc_fixpt_zero = { 0 };
         |                                ^~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.o: warning: objtool: acquire_i2c_hw_engine()+0x4f: sibling call from callable instruction with modified stack frame
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.o: warning: objtool: dce_i2c_submit_command_hw()+0x1f1: sibling call from callable instruction with modified stack frame
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:73:35: sparse: sparse: symbol 'dce_i2c_sw_engine_get_channel_status' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:371:6: sparse: sparse: symbol 'dce_i2c_sw_engine_set_speed' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:385:6: sparse: sparse: symbol 'dce_i2c_sw_engine_acquire_engine' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:401:6: sparse: sparse: symbol 'dce_i2c_engine_acquire_sw' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:429:6: sparse: sparse: symbol 'dce_i2c_sw_engine_submit_channel_request' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:472:6: sparse: sparse: symbol 'dce_i2c_sw_engine_submit_request' was not declared. Should it be static?
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:566:67: sparse: sparse: dubious: x | !y
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:73:35: warning: no previous prototype for 'dce_i2c_sw_engine_get_channel_status' [-Wmissing-prototypes]
      73 | enum i2c_channel_operation_result dce_i2c_sw_engine_get_channel_status(
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:371:6: warning: no previous prototype for 'dce_i2c_sw_engine_set_speed' [-Wmissing-prototypes]
     371 | void dce_i2c_sw_engine_set_speed(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:385:6: warning: no previous prototype for 'dce_i2c_sw_engine_acquire_engine' [-Wmissing-prototypes]
     385 | bool dce_i2c_sw_engine_acquire_engine(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:401:6: warning: no previous prototype for 'dce_i2c_engine_acquire_sw' [-Wmissing-prototypes]
     401 | bool dce_i2c_engine_acquire_sw(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:429:6: warning: no previous prototype for 'dce_i2c_sw_engine_submit_channel_request' [-Wmissing-prototypes]
     429 | void dce_i2c_sw_engine_submit_channel_request(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:472:6: warning: no previous prototype for 'dce_i2c_sw_engine_submit_request' [-Wmissing-prototypes]
     472 | bool dce_i2c_sw_engine_submit_request(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:25:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:120:22: warning: 'DP_DVI_CONVERTER_ID_4' defined but not used [-Wunused-const-variable=]
     120 | static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:118:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
     118 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:116:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
     116 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.c:25:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
         |                                ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
      74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
         |                                ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
      73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
         |                                ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
      72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
         |                                ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:67:32: warning: 'dc_fixpt_zero' defined but not used [-Wunused-const-variable=]
      67 | static const struct fixed31_32 dc_fixpt_zero = { 0 };
         |                                ^~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.o: warning: objtool: wait_for_scl_high_sw.constprop.0()+0x60: sibling call from callable instruction with modified stack frame
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.o: warning: objtool: dce_i2c_submit_command_sw()+0x190: sibling call from callable instruction with modified stack frame
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_sw.o: warning: objtool: dce_i2c_acquire_i2c_sw_engine()+0x47: sibling call from callable instruction with modified stack frame

vim +809 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_i2c_hw.c

   782	
   783	bool dce_i2c_submit_command_hw(
   784		struct resource_pool *pool,
   785		struct ddc *ddc,
   786		struct i2c_command *cmd,
   787		struct dce_i2c_hw *dce_i2c_hw)
   788	{
   789		uint8_t index_of_payload = 0;
   790		bool result;
   791	
   792		dce_i2c_hw->funcs->set_speed(dce_i2c_hw, cmd->speed);
   793	
   794		result = true;
   795	
   796		while (index_of_payload < cmd->number_of_payloads) {
   797			bool mot = (index_of_payload != cmd->number_of_payloads - 1);
   798	
   799			struct i2c_payload *payload = cmd->payloads + index_of_payload;
   800	
   801			struct dce_i2c_transaction_request request = { 0 };
   802	
   803			request.operation = payload->write ?
   804				DCE_I2C_TRANSACTION_WRITE :
   805				DCE_I2C_TRANSACTION_READ;
   806	
   807			request.payload.address_space =
   808				DCE_I2C_TRANSACTION_ADDRESS_SPACE_I2C;
 > 809			request.payload.address = (payload->address << 1) |
   810				!payload->write;
   811			request.payload.length = payload->length;
   812			request.payload.data = payload->data;
   813	
   814	
   815			if (!dce_i2c_hw_engine_submit_request(
   816					dce_i2c_hw, &request, mot)) {
   817				result = false;
   818				break;
   819			}
   820	
   821	
   822	
   823			++index_of_payload;
   824		}
   825	
   826		release_engine_dce_hw(pool, dce_i2c_hw);
   827	
   828		return result;
   829	}
   830	static const struct dce_i2c_hw_funcs dce100_i2c_hw_funcs = {
   831			.setup_engine = setup_engine_hw_dce100,
   832			.set_speed = set_speed_hw_dce100,
   833			.get_speed = get_speed_hw,
   834			.release_engine = release_engine_hw,
   835			.process_transaction = process_transaction_hw_dce100,
   836			.process_channel_reply = process_channel_reply_hw_dce100,
   837			.is_hw_busy = is_hw_busy,
   838			.get_channel_status = get_channel_status_hw,
   839			.execute_transaction = execute_transaction_hw,
   840			.disable_i2c_hw_engine = disable_i2c_hw_engine
   841	};
   842	static const struct dce_i2c_hw_funcs dce80_i2c_hw_funcs = {
   843			.setup_engine = setup_engine_hw_dce80,
   844			.set_speed = set_speed_hw_dce80,
   845			.get_speed = get_speed_hw,
   846			.release_engine = release_engine_hw,
   847			.process_transaction = process_transaction_hw_dce80,
   848			.process_channel_reply = process_channel_reply_hw_dce80,
   849			.is_hw_busy = is_hw_busy,
   850			.get_channel_status = get_channel_status_hw,
   851			.execute_transaction = execute_transaction_hw,
   852			.disable_i2c_hw_engine = disable_i2c_hw_engine
   853	};
   854	
   855	
   856	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
