Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467337CE166
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344692AbjJRPnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjJRPnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:43:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFB1118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697643786; x=1729179786;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cAf5Ji2j36cqM4XbqEvEUweS4HwzbBeSDrHrEamrOmc=;
  b=EMQf41eNnxOmN7e6oX75M1aV+IWVVwGO0VoWlOfP6TeXAOcrW5YnEmMV
   uNQ7EvRvDR7tqUfvApY10HLCm8CPyKaKBZpTd6I6YbQBF7VgLId08tP/k
   LuLyPNmmbxB7SAOe8fVQprn2Xll5tM2cfeAl373nFqHcJJqBwRQF7XMho
   +ebhqGLPkIeYjmxkuh3sIg5nAqEsgi/akT4YXPIS0O+RLiZm1O2AEnWnJ
   v0MjpxZgGSNJqUFdlcOhNJNzMgoi81gT+FLq6qNyV0s3W2JrJQfMv+bNg
   HnBWX4Gd2PEdIeZFDM+E5SogXgL0+S0/DQAt4/kDK2R4Cx8FK/59NQZcF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="365391093"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="365391093"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 08:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756629303"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="756629303"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Oct 2023 08:43:04 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt8hJ-0000bM-23;
        Wed, 18 Oct 2023 15:43:01 +0000
Date:   Wed, 18 Oct 2023 23:42:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c:110:54:
 warning: '.bin' directive output may be truncated writing 4 bytes into a
 region of size between 0 and 29
Message-ID: <202310182332.OXIRVcAe-lkp@intel.com>
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
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: 6b54496238cc81792f697e7b21c452cdcdbb4ac5 drm/amd: Convert SMUv11 microcode to use `amdgpu_ucode_ip_version_decode`
date:   9 months ago
config: x86_64-randconfig-r006-20230904 (https://download.01.org/0day-ci/archive/20231018/202310182332.OXIRVcAe-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310182332.OXIRVcAe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310182332.OXIRVcAe-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c: In function 'smu_v11_0_init_microcode':
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c:110:54: warning: '.bin' directive output may be truncated writing 4 bytes into a region of size between 0 and 29 [-Wformat-truncation=]
     110 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
         |                                                      ^~~~
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c:110:9: note: 'snprintf' output between 12 and 41 bytes into a destination of size 36
     110 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +110 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/smu_v11_0.c

    92	
    93	int smu_v11_0_init_microcode(struct smu_context *smu)
    94	{
    95		struct amdgpu_device *adev = smu->adev;
    96		char ucode_prefix[30];
    97		char fw_name[SMU_FW_NAME_LEN];
    98		int err = 0;
    99		const struct smc_firmware_header_v1_0 *hdr;
   100		const struct common_firmware_header *header;
   101		struct amdgpu_firmware_info *ucode = NULL;
   102	
   103		if (amdgpu_sriov_vf(adev) &&
   104		    ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 9)) ||
   105		     (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(11, 0, 7))))
   106			return 0;
   107	
   108		amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
   109	
 > 110		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
   111	
   112		err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
   113		if (err)
   114			goto out;
   115		err = amdgpu_ucode_validate(adev->pm.fw);
   116		if (err)
   117			goto out;
   118	
   119		hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
   120		amdgpu_ucode_print_smc_hdr(&hdr->header);
   121		adev->pm.fw_version = le32_to_cpu(hdr->header.ucode_version);
   122	
   123		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
   124			ucode = &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
   125			ucode->ucode_id = AMDGPU_UCODE_ID_SMC;
   126			ucode->fw = adev->pm.fw;
   127			header = (const struct common_firmware_header *)ucode->fw->data;
   128			adev->firmware.fw_size +=
   129				ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
   130		}
   131	
   132	out:
   133		if (err) {
   134			DRM_ERROR("smu_v11_0: Failed to load firmware \"%s\"\n",
   135				  fw_name);
   136			release_firmware(adev->pm.fw);
   137			adev->pm.fw = NULL;
   138		}
   139		return err;
   140	}
   141	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
