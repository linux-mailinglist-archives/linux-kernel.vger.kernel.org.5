Return-Path: <linux-kernel+bounces-258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6671E813E63
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FE82834CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0D02DB7C;
	Thu, 14 Dec 2023 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFjV09sm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D086C6FB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702597719; x=1734133719;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NwTPjsINtjz6bj7IWfrfWCE6ugFwF08fiakrTtgjL+Y=;
  b=JFjV09sm1AXcWy6Q+6P6McRUuGxvISZP3+6LDzOxXoZvv1RjNThO+iIQ
   QVMEfQ2PTvIgb+hiQFcCPwcQEnJ1rgFH/Zhk3iUV8nhGHKkZ/faX3xCZC
   9hpeoROAz70nyVKcnTePXYdkA4Js/0GB7cKcrKfwmse+XIj6128Ed3/Jp
   xWofBjSvKAV3G0PRjJGW4mZqBPZPfIpVLuwB2FMVe7A26qVA3sMCWX5C3
   f3RJM5S8ZQG+CPrUYXmg5bRDEKtH5pUIduV+EdtuoRK6LEArlWSn0A8VC
   8vCR9ShnKr56hz9jYksrXaa7K92EHa7GZ10TATUMxIfcHbjkt/xKJCq74
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2058227"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="2058227"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:48:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="844910749"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="844910749"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 14 Dec 2023 15:48:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDvRQ-000MkZ-0p;
	Thu, 14 Dec 2023 23:48:32 +0000
Date: Fri, 15 Dec 2023 07:48:26 +0800
From: kernel test robot <lkp@intel.com>
To: Lewis Huang <lewis.huang@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c:532:62-63: WARNING
 comparing pointer to 0
Message-ID: <202312150759.RDeuSwNA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c7402612e2e61b76177f22e6e7f705adcbecc6fe
commit: 5911d02cac70d7fb52009fbd37423e63f8f6f9bc drm/amd/display: Change the DMCUB mailbox memory location from FB to inbox
date:   4 weeks ago
config: x86_64-randconfig-104-20231214 (https://download.01.org/0day-ci/archive/20231215/202312150759.RDeuSwNA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231215/202312150759.RDeuSwNA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150759.RDeuSwNA-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c:532:62-63: WARNING comparing pointer to 0

vim +532 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c

   505	
   506	enum dmub_status dmub_srv_calc_mem_info(struct dmub_srv *dmub,
   507					       const struct dmub_srv_memory_params *params,
   508					       struct dmub_srv_fb_info *out)
   509	{
   510		uint8_t *cpu_base;
   511		uint64_t gpu_base;
   512		uint32_t i;
   513	
   514		if (!dmub->sw_init)
   515			return DMUB_STATUS_INVALID;
   516	
   517		memset(out, 0, sizeof(*out));
   518	
   519		if (params->region_info->num_regions != DMUB_NUM_WINDOWS)
   520			return DMUB_STATUS_INVALID;
   521	
   522		cpu_base = (uint8_t *)params->cpu_fb_addr;
   523		gpu_base = params->gpu_fb_addr;
   524	
   525		for (i = 0; i < DMUB_NUM_WINDOWS; ++i) {
   526			const struct dmub_region *reg =
   527				&params->region_info->regions[i];
   528	
   529			out->fb[i].cpu_addr = cpu_base + reg->base;
   530			out->fb[i].gpu_addr = gpu_base + reg->base;
   531	
 > 532			if (i == DMUB_WINDOW_4_MAILBOX && params->cpu_inbox_addr != 0) {
   533				out->fb[i].cpu_addr = (uint8_t *)params->cpu_inbox_addr + reg->base;
   534				out->fb[i].gpu_addr = params->gpu_inbox_addr + reg->base;
   535			}
   536	
   537			out->fb[i].size = reg->top - reg->base;
   538		}
   539	
   540		out->num_fb = DMUB_NUM_WINDOWS;
   541	
   542		return DMUB_STATUS_OK;
   543	}
   544	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

