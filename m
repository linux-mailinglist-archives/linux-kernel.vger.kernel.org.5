Return-Path: <linux-kernel+bounces-12874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 314B681FBF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 00:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC771F244A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 23:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6CD1097C;
	Thu, 28 Dec 2023 23:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTjs6akp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D7A1096A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703804604; x=1735340604;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pv3ZMSFrGiX536ncjZzUH7NPEX7DruJAVur9Lx0dOTw=;
  b=fTjs6akpLkme+12E1zaDGR7qgx52jm/T94McSdYnPF8381bgWPhJ4i8P
   3OJR3+mWUvE4Cdk/Ccix58kRY29OM0eTy++C9k+jp/7ybl8Z+8G40sKtO
   OwMhf2dCIRxVdKe3FJ6pPLzJSiq0dj5XEhveuMRoSGrBd+42jxMW3GcfL
   Daxt8orBxGI2rqkir8AHbLKTFtuVpGFtoZhHCcit3qByBHJaADJjjjTqi
   TREh1OKvVeMw22PCQ56VqUaRLqNAnBGG2agSeXdO7h31d7C3yomDUXIhe
   tdJIt/AmEcCbUrJ5XYPp/Qr++/Q5m67LsNBVJIeNUW1B/bEwblwdl2mIK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="18150580"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="18150580"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 15:03:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="778650970"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="778650970"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 28 Dec 2023 15:03:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIzPL-000GuP-0E;
	Thu, 28 Dec 2023 23:03:19 +0000
Date: Fri, 29 Dec 2023 07:02:49 +0800
From: kernel test robot <lkp@intel.com>
To: Evan Quan <evan.quan@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c:104:52:
 warning: '%s' directive output may be truncated writing up to 29 bytes into
 a region of size 23
Message-ID: <202312290653.xdMUAh0o-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   505e701c0b2cfa9e34811020829759b7663a604c
commit: 276c03a0547068026241decd2c1159df0be5941f drm/amd/smu: Update SMU13 support for SMU 13.0.0
date:   1 year, 8 months ago
config: x86_64-randconfig-x066-20230529 (https://download.01.org/0day-ci/archive/20231229/202312290653.xdMUAh0o-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231229/202312290653.xdMUAh0o-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312290653.xdMUAh0o-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c: In function 'smu_v13_0_init_microcode':
>> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c:104:52: warning: '%s' directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
     104 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", chip_name);
         |                                                    ^~
   drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c:104:9: note: 'snprintf' output between 12 and 41 bytes into a destination of size 30
     104 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", chip_name);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +104 drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu13/smu_v13_0.c

    76	
    77	static int smu_v13_0_get_pptable_from_firmware(struct smu_context *smu, void **table, uint32_t *size,
    78						       uint32_t pptable_id);
    79	
    80	int smu_v13_0_init_microcode(struct smu_context *smu)
    81	{
    82		struct amdgpu_device *adev = smu->adev;
    83		const char *chip_name;
    84		char fw_name[30];
    85		char ucode_prefix[30];
    86		int err = 0;
    87		const struct smc_firmware_header_v1_0 *hdr;
    88		const struct common_firmware_header *header;
    89		struct amdgpu_firmware_info *ucode = NULL;
    90	
    91		/* doesn't need to load smu firmware in IOV mode */
    92		if (amdgpu_sriov_vf(adev))
    93			return 0;
    94	
    95		switch (adev->ip_versions[MP1_HWIP][0]) {
    96		case IP_VERSION(13, 0, 2):
    97			chip_name = "aldebaran_smc";
    98			break;
    99		default:
   100			amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
   101			chip_name = ucode_prefix;
   102		}
   103	
 > 104		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", chip_name);
   105	
   106		err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
   107		if (err)
   108			goto out;
   109		err = amdgpu_ucode_validate(adev->pm.fw);
   110		if (err)
   111			goto out;
   112	
   113		hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
   114		amdgpu_ucode_print_smc_hdr(&hdr->header);
   115		adev->pm.fw_version = le32_to_cpu(hdr->header.ucode_version);
   116	
   117		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
   118			ucode = &adev->firmware.ucode[AMDGPU_UCODE_ID_SMC];
   119			ucode->ucode_id = AMDGPU_UCODE_ID_SMC;
   120			ucode->fw = adev->pm.fw;
   121			header = (const struct common_firmware_header *)ucode->fw->data;
   122			adev->firmware.fw_size +=
   123				ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
   124		}
   125	
   126	out:
   127		if (err) {
   128			DRM_ERROR("smu_v13_0: Failed to load firmware \"%s\"\n",
   129				  fw_name);
   130			release_firmware(adev->pm.fw);
   131			adev->pm.fw = NULL;
   132		}
   133		return err;
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

