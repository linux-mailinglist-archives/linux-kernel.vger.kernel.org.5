Return-Path: <linux-kernel+bounces-165027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE468B86CC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1621F21EC1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528634F1E5;
	Wed,  1 May 2024 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyecZfCa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A4C4DA16;
	Wed,  1 May 2024 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714551447; cv=none; b=sOgPGugn8avF/SLISJr5ccL+g3cnptLTknMVczAytoftxl+ZXzK/ll6GDlvQ8f1KhsxtrR7qQnZFPWTT1eDBsBiHjjwnMIXbd+cyTJKvE37feCE/Vkk5NtEiW+QZMIWBbKRwWcYdhDUpLdxOwaw5H0O2aDuinYuOCX+7pHkOlw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714551447; c=relaxed/simple;
	bh=KOdtGaAloVYRcbgEMvF8HZPdgpnc+UXP5zW3aSPEydU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN1b5QruU6dq1nndLw+6ktnTqUwXwI2OJtvCfwwIPkkHBhyvKDE2d75LUWSrHr7VIgr/cr1m2Ex4NojNwLv4UU6HdGU7iYx4v0qzveo4BgYBH9Qnf3WG98C63ohUaor1LkldS7T/v3Ylb+PyJP+JVPp9Qk6SviN7Hmakk4Wyl0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyecZfCa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714551446; x=1746087446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KOdtGaAloVYRcbgEMvF8HZPdgpnc+UXP5zW3aSPEydU=;
  b=IyecZfCaS2CgoXGQB3FqUso0s7BhWMXD7sAxaDFXbyMtwBwYsI5S7WZh
   DavF9/kBsvY0Tt9gIRiCf8Hc5xDaY0Zh4oJuCQ14sYn7iqgSC51R/MZdC
   xNkf4cvMCLbU2jVE8ibmxZ2vwJzMoccTfWIPkotz8IaivtJaw9OieYV5P
   84r//MT6fewxaNO6AxTx/Xjur6LHvNKDBWhbJRJ+1Zq6RMxGnU89RJJnT
   XePNqoBtn67S011VXbckCk2tl/XBOfxdYLblW4qiacOdAsQdwPXNrqZLI
   xSMjAu7xFhdiMmUO91DhKq4guE3jtVBmFcLMmoLo86wLl74LMCnGTpBna
   A==;
X-CSE-ConnectionGUID: GH1EbhBNTy+Bn+rAlaEpJA==
X-CSE-MsgGUID: fJCBf7cSTFKRx8Rc5k2WHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="20963420"
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="20963420"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 01:17:25 -0700
X-CSE-ConnectionGUID: fZZQNo1uTyaAS1VxQWRXNQ==
X-CSE-MsgGUID: Hvg7e5F0SGevV4xMv8rAVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,244,1708416000"; 
   d="scan'208";a="31435222"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 01 May 2024 01:17:22 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s259T-0009Du-0E;
	Wed, 01 May 2024 08:17:19 +0000
Date: Wed, 1 May 2024 16:16:52 +0800
From: kernel test robot <lkp@intel.com>
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	mario.limonciello@amd.com, pali@kernel.org, W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3] platform/x86: dell-laptop: Implement platform_profile
Message-ID: <202405011636.CDJVLh7l-lkp@intel.com>
References: <20240429164844.7544-2-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429164844.7544-2-lsanche@lyndeno.ca>

Hi Lyndon,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.9-rc6 next-20240430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lyndon-Sanche/platform-x86-dell-laptop-Implement-platform_profile/20240430-135932
base:   linus/master
patch link:    https://lore.kernel.org/r/20240429164844.7544-2-lsanche%40lyndeno.ca
patch subject: [PATCH v3] platform/x86: dell-laptop: Implement platform_profile
config: i386-buildonly-randconfig-001-20240501 (https://download.01.org/0day-ci/archive/20240501/202405011636.CDJVLh7l-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405011636.CDJVLh7l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405011636.CDJVLh7l-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/dell/dell-laptop.c:2387:5: warning: no previous prototype for function 'thermal_init' [-Wmissing-prototypes]
    2387 | int thermal_init(void)
         |     ^
   drivers/platform/x86/dell/dell-laptop.c:2387:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    2387 | int thermal_init(void)
         | ^
         | static 
>> drivers/platform/x86/dell/dell-laptop.c:2418:6: warning: no previous prototype for function 'thermal_cleanup' [-Wmissing-prototypes]
    2418 | void thermal_cleanup(void)
         |      ^
   drivers/platform/x86/dell/dell-laptop.c:2418:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    2418 | void thermal_cleanup(void)
         | ^
         | static 
   2 warnings generated.


vim +/thermal_init +2387 drivers/platform/x86/dell/dell-laptop.c

  2386	
> 2387	int thermal_init(void)
  2388	{
  2389		int ret;
  2390		int supported_modes;
  2391	
  2392		ret = thermal_get_supported_modes(&supported_modes);
  2393		if (ret || !supported_modes)
  2394			return 0;
  2395	
  2396		thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
  2397		if (!thermal_handler)
  2398			return -ENOMEM;
  2399		thermal_handler->profile_get = thermal_platform_profile_get;
  2400		thermal_handler->profile_set = thermal_platform_profile_set;
  2401	
  2402		if (supported_modes & DELL_QUIET)
  2403			set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
  2404		if (supported_modes & DELL_COOL_BOTTOM)
  2405			set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
  2406		if (supported_modes & DELL_BALANCED)
  2407			set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
  2408		if (supported_modes & DELL_PERFORMANCE)
  2409			set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
  2410	
  2411		// Clean up but do not fail
  2412		if (platform_profile_register(thermal_handler))
  2413			kfree(thermal_handler);
  2414	
  2415		return 0;
  2416	}
  2417	
> 2418	void thermal_cleanup(void)
  2419	{
  2420		if (thermal_handler) {
  2421			platform_profile_remove();
  2422			kfree(thermal_handler);
  2423		}
  2424	}
  2425	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

