Return-Path: <linux-kernel+bounces-10876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAFE81DDB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 03:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08111F21C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 02:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC87A34;
	Mon, 25 Dec 2023 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KiMcly+1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A25804
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 02:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703473177; x=1735009177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dbIgb9FvzQi+yY5LSqrrWc60CVIz7MdAxHOcztqNnNw=;
  b=KiMcly+1tlHtrao4Ca57vbYnQwPSmTCtO6/axeepvhHKWyIMXa4asIYI
   CQl/wEmsOGXHhExgpb+Cnd5R7cRkV02E5TbVyV5WMLq7YOwB9ytb1E0HL
   QKjSKrhInKLsfKkhZGPgjw2FNJkyEdSXLL3LJIYA1TN/xFMFHtA8Ecl0K
   3EEgjw0/1YTUIUzTb0X1LANdzhToKiF+e05TrFHGBZ1IKtLAF0mKNfrS5
   Z/kbuZoywfrzPNps2RCPMNiJRxSX4RMTcV3Y+Rm77u4XBHfQ6xVIkS3ix
   nrzaGXFtl4j7I51CT5hB+6hfQ40Xa45hzDZ2qQQtzvtGsR7XUd0bUKqw4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="393424343"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="393424343"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 18:59:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="1109052249"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="1109052249"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 24 Dec 2023 18:59:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHb9K-000Crd-2e;
	Mon, 25 Dec 2023 02:57:52 +0000
Date: Mon, 25 Dec 2023 10:56:27 +0800
From: kernel test robot <lkp@intel.com>
To: David Francis <David.Francis@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Harry Wentland <harry.wentland@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:296:34:
 sparse: sparse: incorrect type in assignment (different base types)
Message-ID: <202312251037.69jiZ034-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: bbf854dc3570eb0a2b9d851f21e363e1570c717e drm/amd/display: Load DMCU IRAM
date:   5 years ago
config: x86_64-randconfig-x051-20230813 (https://download.01.org/0day-ci/archive/20231225/202312251037.69jiZ034-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231225/202312251037.69jiZ034-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312251037.69jiZ034-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:163:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] blRampReduction @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:163:35: sparse:     expected unsigned short [addressable] [assigned] [usertype] blRampReduction
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:163:35: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:165:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [addressable] [assigned] [usertype] blRampStart @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:165:31: sparse:     expected unsigned short [addressable] [assigned] [usertype] blRampStart
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:165:31: sparse:     got restricted __be16 [usertype]
>> drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:296:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:296:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:296:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:297:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:297:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:297:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:298:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:298:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:298:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:299:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:299:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:299:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:300:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:300:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:300:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:301:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:301:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:301:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:302:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:302:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:302:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:303:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:303:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:303:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:304:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:304:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:304:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:305:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:305:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:305:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:306:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:306:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:306:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:307:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:307:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:307:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:308:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:308:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:308:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:309:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:309:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:309:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:310:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:310:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:310:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:311:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:311:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:311:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:312:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:312:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:312:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:313:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:313:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:313:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:314:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:314:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:314:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:315:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:315:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:315:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:316:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:316:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:316:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:317:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:317:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:317:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:318:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:318:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:318:34: sparse:     got restricted __be16 [usertype]
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:319:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:319:34: sparse:     expected unsigned short
   drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:319:34: sparse:     got restricted __be16 [usertype]
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/dmcu.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c:25:
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

vim +296 drivers/gpu/drm/amd/amdgpu/../display/modules/power/power_helpers.c

   145	
   146	bool dmcu_load_iram(struct dmcu *dmcu,
   147		struct dmcu_iram_parameters params)
   148	{
   149		struct iram_table_v_2 ram_table;
   150		unsigned int set = params.set;
   151	
   152		if (dmcu == NULL)
   153			return false;
   154	
   155		if (!dmcu->funcs->is_dmcu_initialized(dmcu))
   156			return true;
   157	
   158		memset(&ram_table, 0, sizeof(ram_table));
   159	
   160		ram_table.flags = 0x0;
   161		ram_table.deviation_gain = 0xb3;
   162	
 > 163		ram_table.blRampReduction =
   164			cpu_to_be16(params.backlight_ramping_reduction);
   165		ram_table.blRampStart =
   166			cpu_to_be16(params.backlight_ramping_start);
   167	
   168		ram_table.min_reduction[0][0] = min_reduction_table[abm_config[set][0]];
   169		ram_table.min_reduction[1][0] = min_reduction_table[abm_config[set][0]];
   170		ram_table.min_reduction[2][0] = min_reduction_table[abm_config[set][0]];
   171		ram_table.min_reduction[3][0] = min_reduction_table[abm_config[set][0]];
   172		ram_table.min_reduction[4][0] = min_reduction_table[abm_config[set][0]];
   173		ram_table.max_reduction[0][0] = max_reduction_table[abm_config[set][0]];
   174		ram_table.max_reduction[1][0] = max_reduction_table[abm_config[set][0]];
   175		ram_table.max_reduction[2][0] = max_reduction_table[abm_config[set][0]];
   176		ram_table.max_reduction[3][0] = max_reduction_table[abm_config[set][0]];
   177		ram_table.max_reduction[4][0] = max_reduction_table[abm_config[set][0]];
   178	
   179		ram_table.min_reduction[0][1] = min_reduction_table[abm_config[set][1]];
   180		ram_table.min_reduction[1][1] = min_reduction_table[abm_config[set][1]];
   181		ram_table.min_reduction[2][1] = min_reduction_table[abm_config[set][1]];
   182		ram_table.min_reduction[3][1] = min_reduction_table[abm_config[set][1]];
   183		ram_table.min_reduction[4][1] = min_reduction_table[abm_config[set][1]];
   184		ram_table.max_reduction[0][1] = max_reduction_table[abm_config[set][1]];
   185		ram_table.max_reduction[1][1] = max_reduction_table[abm_config[set][1]];
   186		ram_table.max_reduction[2][1] = max_reduction_table[abm_config[set][1]];
   187		ram_table.max_reduction[3][1] = max_reduction_table[abm_config[set][1]];
   188		ram_table.max_reduction[4][1] = max_reduction_table[abm_config[set][1]];
   189	
   190		ram_table.min_reduction[0][2] = min_reduction_table[abm_config[set][2]];
   191		ram_table.min_reduction[1][2] = min_reduction_table[abm_config[set][2]];
   192		ram_table.min_reduction[2][2] = min_reduction_table[abm_config[set][2]];
   193		ram_table.min_reduction[3][2] = min_reduction_table[abm_config[set][2]];
   194		ram_table.min_reduction[4][2] = min_reduction_table[abm_config[set][2]];
   195		ram_table.max_reduction[0][2] = max_reduction_table[abm_config[set][2]];
   196		ram_table.max_reduction[1][2] = max_reduction_table[abm_config[set][2]];
   197		ram_table.max_reduction[2][2] = max_reduction_table[abm_config[set][2]];
   198		ram_table.max_reduction[3][2] = max_reduction_table[abm_config[set][2]];
   199		ram_table.max_reduction[4][2] = max_reduction_table[abm_config[set][2]];
   200	
   201		ram_table.min_reduction[0][3] = min_reduction_table[abm_config[set][3]];
   202		ram_table.min_reduction[1][3] = min_reduction_table[abm_config[set][3]];
   203		ram_table.min_reduction[2][3] = min_reduction_table[abm_config[set][3]];
   204		ram_table.min_reduction[3][3] = min_reduction_table[abm_config[set][3]];
   205		ram_table.min_reduction[4][3] = min_reduction_table[abm_config[set][3]];
   206		ram_table.max_reduction[0][3] = max_reduction_table[abm_config[set][3]];
   207		ram_table.max_reduction[1][3] = max_reduction_table[abm_config[set][3]];
   208		ram_table.max_reduction[2][3] = max_reduction_table[abm_config[set][3]];
   209		ram_table.max_reduction[3][3] = max_reduction_table[abm_config[set][3]];
   210		ram_table.max_reduction[4][3] = max_reduction_table[abm_config[set][3]];
   211	
   212		ram_table.bright_pos_gain[0][0] = 0x20;
   213		ram_table.bright_pos_gain[0][1] = 0x20;
   214		ram_table.bright_pos_gain[0][2] = 0x20;
   215		ram_table.bright_pos_gain[0][3] = 0x20;
   216		ram_table.bright_pos_gain[1][0] = 0x20;
   217		ram_table.bright_pos_gain[1][1] = 0x20;
   218		ram_table.bright_pos_gain[1][2] = 0x20;
   219		ram_table.bright_pos_gain[1][3] = 0x20;
   220		ram_table.bright_pos_gain[2][0] = 0x20;
   221		ram_table.bright_pos_gain[2][1] = 0x20;
   222		ram_table.bright_pos_gain[2][2] = 0x20;
   223		ram_table.bright_pos_gain[2][3] = 0x20;
   224		ram_table.bright_pos_gain[3][0] = 0x20;
   225		ram_table.bright_pos_gain[3][1] = 0x20;
   226		ram_table.bright_pos_gain[3][2] = 0x20;
   227		ram_table.bright_pos_gain[3][3] = 0x20;
   228		ram_table.bright_pos_gain[4][0] = 0x20;
   229		ram_table.bright_pos_gain[4][1] = 0x20;
   230		ram_table.bright_pos_gain[4][2] = 0x20;
   231		ram_table.bright_pos_gain[4][3] = 0x20;
   232		ram_table.bright_neg_gain[0][1] = 0x00;
   233		ram_table.bright_neg_gain[0][2] = 0x00;
   234		ram_table.bright_neg_gain[0][3] = 0x00;
   235		ram_table.bright_neg_gain[1][0] = 0x00;
   236		ram_table.bright_neg_gain[1][1] = 0x00;
   237		ram_table.bright_neg_gain[1][2] = 0x00;
   238		ram_table.bright_neg_gain[1][3] = 0x00;
   239		ram_table.bright_neg_gain[2][0] = 0x00;
   240		ram_table.bright_neg_gain[2][1] = 0x00;
   241		ram_table.bright_neg_gain[2][2] = 0x00;
   242		ram_table.bright_neg_gain[2][3] = 0x00;
   243		ram_table.bright_neg_gain[3][0] = 0x00;
   244		ram_table.bright_neg_gain[3][1] = 0x00;
   245		ram_table.bright_neg_gain[3][2] = 0x00;
   246		ram_table.bright_neg_gain[3][3] = 0x00;
   247		ram_table.bright_neg_gain[4][0] = 0x00;
   248		ram_table.bright_neg_gain[4][1] = 0x00;
   249		ram_table.bright_neg_gain[4][2] = 0x00;
   250		ram_table.bright_neg_gain[4][3] = 0x00;
   251		ram_table.dark_pos_gain[0][0] = 0x00;
   252		ram_table.dark_pos_gain[0][1] = 0x00;
   253		ram_table.dark_pos_gain[0][2] = 0x00;
   254		ram_table.dark_pos_gain[0][3] = 0x00;
   255		ram_table.dark_pos_gain[1][0] = 0x00;
   256		ram_table.dark_pos_gain[1][1] = 0x00;
   257		ram_table.dark_pos_gain[1][2] = 0x00;
   258		ram_table.dark_pos_gain[1][3] = 0x00;
   259		ram_table.dark_pos_gain[2][0] = 0x00;
   260		ram_table.dark_pos_gain[2][1] = 0x00;
   261		ram_table.dark_pos_gain[2][2] = 0x00;
   262		ram_table.dark_pos_gain[2][3] = 0x00;
   263		ram_table.dark_pos_gain[3][0] = 0x00;
   264		ram_table.dark_pos_gain[3][1] = 0x00;
   265		ram_table.dark_pos_gain[3][2] = 0x00;
   266		ram_table.dark_pos_gain[3][3] = 0x00;
   267		ram_table.dark_pos_gain[4][0] = 0x00;
   268		ram_table.dark_pos_gain[4][1] = 0x00;
   269		ram_table.dark_pos_gain[4][2] = 0x00;
   270		ram_table.dark_pos_gain[4][3] = 0x00;
   271		ram_table.dark_neg_gain[0][0] = 0x00;
   272		ram_table.dark_neg_gain[0][1] = 0x00;
   273		ram_table.dark_neg_gain[0][2] = 0x00;
   274		ram_table.dark_neg_gain[0][3] = 0x00;
   275		ram_table.dark_neg_gain[1][0] = 0x00;
   276		ram_table.dark_neg_gain[1][1] = 0x00;
   277		ram_table.dark_neg_gain[1][2] = 0x00;
   278		ram_table.dark_neg_gain[1][3] = 0x00;
   279		ram_table.dark_neg_gain[2][0] = 0x00;
   280		ram_table.dark_neg_gain[2][1] = 0x00;
   281		ram_table.dark_neg_gain[2][2] = 0x00;
   282		ram_table.dark_neg_gain[2][3] = 0x00;
   283		ram_table.dark_neg_gain[3][0] = 0x00;
   284		ram_table.dark_neg_gain[3][1] = 0x00;
   285		ram_table.dark_neg_gain[3][2] = 0x00;
   286		ram_table.dark_neg_gain[3][3] = 0x00;
   287		ram_table.dark_neg_gain[4][0] = 0x00;
   288		ram_table.dark_neg_gain[4][1] = 0x00;
   289		ram_table.dark_neg_gain[4][2] = 0x00;
   290		ram_table.dark_neg_gain[4][3] = 0x00;
   291		ram_table.iir_curve[0] = 0x65;
   292		ram_table.iir_curve[1] = 0x65;
   293		ram_table.iir_curve[2] = 0x65;
   294		ram_table.iir_curve[3] = 0x65;
   295		ram_table.iir_curve[4] = 0x65;
 > 296		ram_table.crgb_thresh[0] = cpu_to_be16(0x13b6);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

