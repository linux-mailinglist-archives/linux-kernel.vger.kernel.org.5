Return-Path: <linux-kernel+bounces-164291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293FA8B7BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9304E1F2639E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1F6172BBF;
	Tue, 30 Apr 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJH82wkB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5B1E493;
	Tue, 30 Apr 2024 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491462; cv=none; b=EU0EWV6IBw7BcRU6SXqXRa5jDaBp0SEhFcsoGJzO0W4uVB2rx/fAphaKFLG5x6U2IVkHCiMFZaeFfL/M3Q1H9yZ4mXd1zlly/HgTKeurQa6jxj2s2H/XcP3Hd3iFAP5cEu7OXyJ5eV8p1yW09JpMQjRshh6P1Sn/67OOnwSaOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491462; c=relaxed/simple;
	bh=mzCvvGmzi+tDG2LjR2pFFqD74q9WqTrcAc4c07C/Kig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrdT85nBn398VCoSY1C7KqILAMBqh1vCmzGuKWTdR/fL0qMiVK47IjJb/weeNn+NqEr1QQnoWhHxcuEzUTwnidRK60hUPCNpqc9jUvvV6721dp9s4Gxo2kdu8t/fQof1cvrKiQUy/SDqYQzAyLR0V/jE/2NiXJ44s+k27usy0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJH82wkB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714491461; x=1746027461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mzCvvGmzi+tDG2LjR2pFFqD74q9WqTrcAc4c07C/Kig=;
  b=TJH82wkBPexVkwXuHq0vTj1ypL3+F0zMA//Qt5AFZoZCmzREvKMkQK6Z
   EFPeL0Rqi9AFXNm/qwpc2h2N7hlzFx91vbtDbYv9HlMiBmNxi46ECdPR2
   bVnIitnVEE3lU/iZzkbGZ3Ykvg+N9zVlIChz6vlnD8AkyH6DhDVW+Ssxx
   kK1ps2977XHFx3PcAYPCNJkmvBWkiwfdKR0rejI1960yG1hZe6HITV6jK
   IAAFs71MvAj7AtJuEvLBGk5bu7FLj7bG4W6KieP/9fb9Z8HYM594uHE3p
   YkSjxbwKvoPtStH/WysA9/pnQXqpHAqV/4NcttSvBbaqstfKK2xax65Ve
   g==;
X-CSE-ConnectionGUID: pYTmHjg0RtyrA4T7T9vx2g==
X-CSE-MsgGUID: meWQBy2fQtirF912RQ+AUQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10427251"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10427251"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 08:37:31 -0700
X-CSE-ConnectionGUID: zSro6sTXTzSbDRXyhuVpRA==
X-CSE-MsgGUID: 0mMX/D5zQ6OfbTmGwMreXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="57385201"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 30 Apr 2024 08:37:28 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1pXp-0008HF-2a;
	Tue, 30 Apr 2024 15:37:25 +0000
Date: Tue, 30 Apr 2024 23:36:29 +0800
From: kernel test robot <lkp@intel.com>
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: oe-kbuild-all@lists.linux.dev, mario.limonciello@amd.com,
	pali@kernel.org, W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3] platform/x86: dell-laptop: Implement platform_profile
Message-ID: <202404302351.31IWk45T-lkp@intel.com>
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20240430/202404302351.31IWk45T-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240430/202404302351.31IWk45T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404302351.31IWk45T-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/x86/dell/dell-laptop.c:2387:5: warning: no previous prototype for 'thermal_init' [-Wmissing-prototypes]
    2387 | int thermal_init(void)
         |     ^~~~~~~~~~~~
>> drivers/platform/x86/dell/dell-laptop.c:2418:6: warning: no previous prototype for 'thermal_cleanup' [-Wmissing-prototypes]
    2418 | void thermal_cleanup(void)
         |      ^~~~~~~~~~~~~~~


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

