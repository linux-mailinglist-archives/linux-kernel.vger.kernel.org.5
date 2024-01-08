Return-Path: <linux-kernel+bounces-19799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC04827468
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822C21C22EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B65537FE;
	Mon,  8 Jan 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADrYVbbJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EC412B6F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704728747; x=1736264747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dpK0Ej33oIoEe/aUsIcxvDQrT3HmTnLQUXcdxMh3ARU=;
  b=ADrYVbbJpDU62HlA1e9+ukuyMgZUAemPxFv8vRsSzWfXkTp3nL8Unt+T
   0IK9oQmWJ798bSwCEaJJRolp4+voIGz0jSMK+cdUIhe8FMtTajqLskLX9
   cIzoMs3M1ghF3UQq+CY5kd/DqZFwJHppjnrr5rcrPN5fTPDB8t/30e9bo
   9WdUUTN9E7foZDAjl82Qqfp9Q8suVnT/1uubygr/Q7rFLmrVsmL01hciv
   a0moWUoVmxE/wnxKDsnVIMUrUeZudUB5zDSYAeqYx1T3l/dAEG3amFqsS
   wSc8CngwtUCHnt+znGtrgs0keITEqE4zuMLNJUd15h45KHxsGAdd08GS4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11261764"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="11261764"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 07:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="904839670"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="904839670"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2024 07:45:44 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMros-0004pY-1z;
	Mon, 08 Jan 2024 15:45:42 +0000
Date: Mon, 8 Jan 2024 23:44:47 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/linux/compiler_types.h:352:45: error: call to
 '__compiletime_assert_395' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(cmd_a64_entry_t) != 64
Message-ID: <202401082313.WUaUgMM3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0dd3ee31125508cd67f7e7172247f05b7fd1753a
commit: 7036440eab3e2d47a775d4616909f8235488d714 ARM: omap1: enable multiplatform
date:   1 year, 7 months ago
config: arm-randconfig-003-20240108 (https://download.01.org/0day-ci/archive/20240108/202401082313.WUaUgMM3-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240108/202401082313.WUaUgMM3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401082313.WUaUgMM3-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/scsi/qla2xxx/qla_os.c: In function 'qla2x00_module_init':
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_395' declared with attribute error: BUILD_BUG_ON failed: sizeof(cmd_a64_entry_t) != 64
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:333:25: note: in definition of macro '__compiletime_assert'
     333 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_os.c:8032:9: note: in expansion of macro 'BUILD_BUG_ON'
    8032 |         BUILD_BUG_ON(sizeof(cmd_a64_entry_t) != 64);
         |         ^~~~~~~~~~~~
--
   In file included from include/linux/string.h:253,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/scsi/qla2xxx/qla_target.c:17:
   In function 'fortify_memcpy_chk',
       inlined from 'qla24xx_post_nack_work' at drivers/scsi/qla2xxx/qla_target.c:555:2:
   include/linux/fortify-string.h:344:25: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
     344 |                         __write_overflow_field(p_size_field, size);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   drivers/scsi/qla2xxx/qla_target.c: In function 'qlt_init':
>> include/linux/compiler_types.h:352:45: error: call to '__compiletime_assert_312' declared with attribute error: BUILD_BUG_ON failed: sizeof(struct ctio7_to_24xx) != 64
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:333:25: note: in definition of macro '__compiletime_assert'
     333 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:352:9: note: in expansion of macro '_compiletime_assert'
     352 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   drivers/scsi/qla2xxx/qla_target.c:7414:9: note: in expansion of macro 'BUILD_BUG_ON'
    7414 |         BUILD_BUG_ON(sizeof(struct ctio7_to_24xx) != 64);
         |         ^~~~~~~~~~~~
--
   In file included from drivers/net/ethernet/intel/i40e/i40e_adminq.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e_type.h:10,
                    from drivers/net/ethernet/intel/i40e/i40e.h:40,
                    from drivers/net/ethernet/intel/i40e/i40e_debugfs.c:9:
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1174 | I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_cloud_filters_element_data);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:29: error: enumerator value for 'i40e_static_assert_i40e_aqc_cloud_filters_element_data' is not an integer constant
    1174 | I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_cloud_filters_element_data);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1185:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1185 | I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1185:29: error: enumerator value for 'i40e_static_assert_i40e_aqc_cloud_filters_element_bb' is not an integer constant
    1185 | I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1506:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1506 | I40E_CHECK_STRUCT_LEN(0x22, i40e_aqc_configure_partition_bw_data);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1506:29: error: enumerator value for 'i40e_static_assert_i40e_aqc_configure_partition_bw_data' is not an integer constant
    1506 | I40E_CHECK_STRUCT_LEN(0x22, i40e_aqc_configure_partition_bw_data);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:306:41: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
     306 | #define I40E_CHECK_CMD_LENGTH(X)        I40E_CHECK_STRUCT_LEN(16, X)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1769:1: note: in expansion of macro 'I40E_CHECK_CMD_LENGTH'
    1769 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1769:23: error: enumerator value for 'i40e_static_assert_i40e_aqc_get_link_status' is not an integer constant
    1769 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1769:1: note: in expansion of macro 'I40E_CHECK_CMD_LENGTH'
    1769 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
         | ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1908:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1908 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1908:28: error: enumerator value for 'i40e_static_assert_i40e_aqc_nvm_config_data_feature' is not an integer constant
    1908 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e.h:41:
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:391:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     391 | VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:391:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_irq_map_info' is not an integer constant
     391 | VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:484:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     484 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:484:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_vlan_filter_list' is not an integer constant
     484 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:869:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     869 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:869:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_key' is not an integer constant
     869 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
         |                              ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:877:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     877 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:877:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_lut' is not an integer constant
     877 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
         |                              ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
--
   In file included from drivers/net/ethernet/intel/i40e/i40e_adminq.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e_type.h:10,
                    from drivers/net/ethernet/intel/i40e/i40e.h:40,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:12:
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1174 | I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_cloud_filters_element_data);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1174:29: error: enumerator value for 'i40e_static_assert_i40e_aqc_cloud_filters_element_data' is not an integer constant
    1174 | I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_cloud_filters_element_data);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1185:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1185 | I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1185:29: error: enumerator value for 'i40e_static_assert_i40e_aqc_cloud_filters_element_bb' is not an integer constant
    1185 | I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1506:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1506 | I40E_CHECK_STRUCT_LEN(0x22, i40e_aqc_configure_partition_bw_data);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1506:29: error: enumerator value for 'i40e_static_assert_i40e_aqc_configure_partition_bw_data' is not an integer constant
    1506 | I40E_CHECK_STRUCT_LEN(0x22, i40e_aqc_configure_partition_bw_data);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:306:41: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
     306 | #define I40E_CHECK_CMD_LENGTH(X)        I40E_CHECK_STRUCT_LEN(16, X)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1769:1: note: in expansion of macro 'I40E_CHECK_CMD_LENGTH'
    1769 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1769:23: error: enumerator value for 'i40e_static_assert_i40e_aqc_get_link_status' is not an integer constant
    1769 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1769:1: note: in expansion of macro 'I40E_CHECK_CMD_LENGTH'
    1769 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
         | ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:39: warning: division by zero [-Wdiv-by-zero]
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                       ^
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1908:1: note: in expansion of macro 'I40E_CHECK_STRUCT_LEN'
    1908 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
         | ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1908:28: error: enumerator value for 'i40e_static_assert_i40e_aqc_nvm_config_data_feature' is not an integer constant
    1908 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:301:56: note: in definition of macro 'I40E_CHECK_STRUCT_LEN'
     301 |         { i40e_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                        ^
   In file included from drivers/net/ethernet/intel/i40e/i40e_prototype.h:9,
                    from drivers/net/ethernet/intel/i40e/i40e.h:41:
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:391:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     391 | VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:391:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_irq_map_info' is not an integer constant
     391 | VIRTCHNL_CHECK_STRUCT_LEN(14, virtchnl_irq_map_info);
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:484:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     484 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:484:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_vlan_filter_list' is not an integer constant
     484 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_vlan_filter_list);
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:869:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     869 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:869:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_key' is not an integer constant
     869 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
         |                              ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   include/linux/avf/virtchnl.h:160:43: warning: division by zero [-Wdiv-by-zero]
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                           ^
   include/linux/avf/virtchnl.h:877:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     877 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
         | ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:877:30: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_lut' is not an integer constant
     877 | VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
         |                              ^~~~~~~~~~~~~~~~
   include/linux/avf/virtchnl.h:160:60: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     160 |         { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
         |                                                            ^
   drivers/net/ethernet/intel/i40e/i40e_main.c:128:5: warning: conflicting types for 'i40e_allocate_dma_mem_d' due to enum/integer mismatch; have 'int(struct i40e_hw *, struct i40e_dma_mem *, u64,  u32)' {aka 'int(struct i40e_hw *, struct i40e_dma_mem *, long long unsigned int,  unsigned int)'} [-Wenum-int-mismatch]
     128 | int i40e_allocate_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/intel/i40e/i40e_type.h:8:
   drivers/net/ethernet/intel/i40e/i40e_osdep.h:40:25: note: previous declaration of 'i40e_allocate_dma_mem_d' with type 'i40e_status(struct i40e_hw *, struct i40e_dma_mem *, u64,  u32)' {aka 'enum i40e_status_code(struct i40e_hw *, struct i40e_dma_mem *, long long unsigned int,  unsigned int)'}
      40 |                         i40e_allocate_dma_mem_d(h, m, s, a)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_alloc.h:23:13: note: in expansion of macro 'i40e_allocate_dma_mem'
      23 | i40e_status i40e_allocate_dma_mem(struct i40e_hw *hw,
         |             ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_main.c:147:5: warning: conflicting types for 'i40e_free_dma_mem_d' due to enum/integer mismatch; have 'int(struct i40e_hw *, struct i40e_dma_mem *)' [-Wenum-int-mismatch]
     147 | int i40e_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
         |     ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_osdep.h:41:33: note: previous declaration of 'i40e_free_dma_mem_d' with type 'i40e_status(struct i40e_hw *, struct i40e_dma_mem *)' {aka 'enum i40e_status_code(struct i40e_hw *, struct i40e_dma_mem *)'}
      41 | #define i40e_free_dma_mem(h, m) i40e_free_dma_mem_d(h, m)
         |                                 ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_alloc.h:27:13: note: in expansion of macro 'i40e_free_dma_mem'
      27 | i40e_status i40e_free_dma_mem(struct i40e_hw *hw,
         |             ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_main.c:165:5: warning: conflicting types for 'i40e_allocate_virt_mem_d' due to enum/integer mismatch; have 'int(struct i40e_hw *, struct i40e_virt_mem *, u32)' {aka 'int(struct i40e_hw *, struct i40e_virt_mem *, unsigned int)'} [-Wenum-int-mismatch]
     165 | int i40e_allocate_virt_mem_d(struct i40e_hw *hw, struct i40e_virt_mem *mem,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_osdep.h:48:41: note: previous declaration of 'i40e_allocate_virt_mem_d' with type 'i40e_status(struct i40e_hw *, struct i40e_virt_mem *, u32)' {aka 'enum i40e_status_code(struct i40e_hw *, struct i40e_virt_mem *, unsigned int)'}
      48 | #define i40e_allocate_virt_mem(h, m, s) i40e_allocate_virt_mem_d(h, m, s)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_alloc.h:29:13: note: in expansion of macro 'i40e_allocate_virt_mem'
      29 | i40e_status i40e_allocate_virt_mem(struct i40e_hw *hw,
         |             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_main.c:182:5: warning: conflicting types for 'i40e_free_virt_mem_d' due to enum/integer mismatch; have 'int(struct i40e_hw *, struct i40e_virt_mem *)' [-Wenum-int-mismatch]
     182 | int i40e_free_virt_mem_d(struct i40e_hw *hw, struct i40e_virt_mem *mem)
         |     ^~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_osdep.h:49:34: note: previous declaration of 'i40e_free_virt_mem_d' with type 'i40e_status(struct i40e_hw *, struct i40e_virt_mem *)' {aka 'enum i40e_status_code(struct i40e_hw *, struct i40e_virt_mem *)'}
      49 | #define i40e_free_virt_mem(h, m) i40e_free_virt_mem_d(h, m)
         |                                  ^~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_alloc.h:32:13: note: in expansion of macro 'i40e_free_virt_mem'
      32 | i40e_status i40e_free_virt_mem(struct i40e_hw *hw,
         |             ^~~~~~~~~~~~~~~~~~


vim +/__compiletime_assert_395 +352 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  338  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  339  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  340  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  341  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  342  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  343   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  344   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  345   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  346   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  347   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  348   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  349   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  350   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  351  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @352  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  353  

:::::: The code at line 352 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

