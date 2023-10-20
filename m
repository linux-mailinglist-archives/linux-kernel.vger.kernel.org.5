Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3787D1650
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjJTTgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjJTTgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:36:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E82DD57
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697830589; x=1729366589;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7tfIa88JfZL6wVGo7dkyR7qcpPMpH3lInJY7kekyklc=;
  b=LsuTv0bJWaSKaZCJV8OGhIH9Pgxxyg3qV/PuwuuxZXqflW1YJPiClFib
   4N5tHqwhGjYjBrYpiyCot2eozpch/lB9k5/69Pxqj4spQA5X7yhYcClu5
   5XsFAN/FmL7vhoVbHsA1PWYvWSMuOq+roYc5ipEBh+S/xPLbdGoM3EibX
   v0dLa0uG/A3PfQHdKvOtNouY8yXiDaTT7P54QZhrZHChqPniPRno+In6l
   g2QSWqGhz4T1xt3FlVd29DCzQUrK9a7BmQSiIpe9xBw7pQsHZpJ3NLVJJ
   cd/+LW6SK4WSZi2bTeWXzlsDaEkmNDOMQKRmYlgVQjaXh45ZRw2/y4JN2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="453038840"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="453038840"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 12:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="757558481"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="757558481"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Oct 2023 12:36:27 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtvIG-0003uR-32;
        Fri, 20 Oct 2023 19:36:24 +0000
Date:   Sat, 21 Oct 2023 03:36:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jack Xiao <Jack.Xiao@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1443:66: warning: '%s'
 directive output may be truncated writing 1 byte into a region of size
 between 0 and 29
Message-ID: <202310210328.KaJWGR5u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c3200081020d63f6c6bfd8a6db2ae8a5b99b348a
commit: 97998b893c3000b27a780a4982e16cfc8f4ea555 drm/amd/amdgpu: introduce gc_*_mes_2.bin v2
date:   6 months ago
config: x86_64-randconfig-x051-20230809 (https://download.01.org/0day-ci/archive/20231021/202310210328.KaJWGR5u-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231021/202310210328.KaJWGR5u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310210328.KaJWGR5u-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c: In function 'amdgpu_mes_init_microcode':
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1448:66: warning: '%s' directive output may be truncated writing up to 1 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
    1448 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
         |                                                                  ^~
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1448:17: note: 'snprintf' output between 16 and 46 bytes into a destination of size 40
    1448 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1449 |                          ucode_prefix,
         |                          ~~~~~~~~~~~~~
    1450 |                          pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1443:66: warning: '%s' directive output may be truncated writing 1 byte into a region of size between 0 and 29 [-Wformat-truncation=]
    1443 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
         |                                                                  ^~
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1443:17: note: 'snprintf' output between 17 and 46 bytes into a destination of size 40
    1443 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1444 |                          ucode_prefix,
         |                          ~~~~~~~~~~~~~
    1445 |                          pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1443:66: warning: '%s' directive output may be truncated writing 2 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
    1443 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
         |                                                                  ^~
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1443:17: note: 'snprintf' output between 18 and 47 bytes into a destination of size 40
    1443 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1444 |                          ucode_prefix,
         |                          ~~~~~~~~~~~~~
    1445 |                          pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1455:62: warning: '_mes.bin' directive output may be truncated writing 8 bytes into a region of size between 4 and 33 [-Wformat-truncation=]
    1455 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
         |                                                              ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c:1455:17: note: 'snprintf' output between 16 and 45 bytes into a destination of size 40
    1455 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1456 |                          ucode_prefix);
         |                          ~~~~~~~~~~~~~


vim +1443 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c

  1430	
  1431	int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
  1432	{
  1433		const struct mes_firmware_header_v1_0 *mes_hdr;
  1434		struct amdgpu_firmware_info *info;
  1435		char ucode_prefix[30];
  1436		char fw_name[40];
  1437		bool need_retry = false;
  1438		int r;
  1439	
  1440		amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix,
  1441					       sizeof(ucode_prefix));
  1442		if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) {
> 1443			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
  1444				 ucode_prefix,
  1445				 pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
  1446			need_retry = true;
  1447		} else {
> 1448			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
  1449				 ucode_prefix,
  1450				 pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
  1451		}
  1452	
  1453		r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], fw_name);
  1454		if (r && need_retry && pipe == AMDGPU_MES_SCHED_PIPE) {
> 1455			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
