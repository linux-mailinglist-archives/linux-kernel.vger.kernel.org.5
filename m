Return-Path: <linux-kernel+bounces-18487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF76D825E4F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116EC1F2413C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978DF4695;
	Sat,  6 Jan 2024 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8WRFXs8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B7440A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 05:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704519807; x=1736055807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KH8F7+1GuZ7x5sDtuPcRj34IFWtfgrTYakCXWnfiRXE=;
  b=a8WRFXs8B3rC7GSX/EBne5/aaRhCRKb58o1LX20QwhzMgDDFT3Py8ub9
   00jtJmjR1Kz6Y0x3vF3IN2V/6tJeiEgPOL1NnFIDBs2oJeVGXdcQQNdX6
   lDbCSrNb7pLkbW39g7QnYMDQYqim4i2rHN0WsnjQjqqdrCpKaZc7jS5Rr
   qtH3x0ob7pnU25rPZubE6vMjbksO9LZR7eNS/kCXL6ylHdUT0rEK2SWl6
   EzljK082ORg17L2+SX3Viy4XYxe1Zp8x3UONXmS3P7wx5UfcpQcLh9vnP
   VAb114nwk/gwPsOdAZog4Uz7JbJMibtYbyRLxHKEas2OaeSS9NbknwQ53
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="394812300"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="394812300"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 21:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="871404302"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="871404302"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jan 2024 21:43:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLzSn-00024y-18;
	Sat, 06 Jan 2024 05:43:17 +0000
Date: Sat, 6 Jan 2024 13:42:24 +0800
From: kernel test robot <lkp@intel.com>
To: Wyes Karny <wyes.karny@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Subject: include/linux/amd-pstate.h:87:27: warning: 'amd_pstate_mode_string'
 defined but not used
Message-ID: <202401061345.DE6P9g5i-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wyes,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4ab2706bb1280693e7dff1c5c42a8cb9d70c177
commit: 36c5014e5460963ad7766487c0e22a7ff28681fc cpufreq: amd-pstate: optimize driver working mode selection in amd_pstate_param()
date:   11 months ago
config: i386-randconfig-053-20240106 (https://download.01.org/0day-ci/archive/20240106/202401061345.DE6P9g5i-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401061345.DE6P9g5i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401061345.DE6P9g5i-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/cpufreq/amd-pstate-ut.c:29:
>> include/linux/amd-pstate.h:87:27: warning: 'amd_pstate_mode_string' defined but not used [-Wunused-const-variable=]
      87 | static const char * const amd_pstate_mode_string[] = {
         |                           ^~~~~~~~~~~~~~~~~~~~~~


vim +/amd_pstate_mode_string +87 include/linux/amd-pstate.h

    86	
  > 87	static const char * const amd_pstate_mode_string[] = {
    88		[AMD_PSTATE_DISABLE]     = "disable",
    89		[AMD_PSTATE_PASSIVE]     = "passive",
    90		[AMD_PSTATE_ACTIVE]      = "active",
    91		NULL,
    92	};
    93	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

