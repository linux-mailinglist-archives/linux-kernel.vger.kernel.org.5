Return-Path: <linux-kernel+bounces-165626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E478B8ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298641F23A5F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2EB18040;
	Wed,  1 May 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVa38c+4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE72C1B964;
	Wed,  1 May 2024 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583282; cv=none; b=jR12ac8VN3s0AR7YhgRebbhb+ALjDgg3kpBX8PGSruamEn7eu2G0F8v5VoGooWsezYUXeTMDVnNfLN+VL7xMxOUxZaFEk9FVx7Kq/NOfMIpjLs9gPFtlHHd17715A8cJie11JhHXrrRELDPY5kzqVW90Ck1ho6+eyyKWQ8nPkJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583282; c=relaxed/simple;
	bh=R++pfBgyM8DpUgzRcVsetGb7scWw1DWg4IjtUXMthEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju9NZkgyo/rM6EvfRa6jNWHBH8cUMprrdlk+hX6PDnUNN+Dnldk5rHTwRfF1QFBa33exwxIOkIUu+NQNmXsPGZpub7KGsDL6AfkVTZDihle5WJKeeYN1qzftcX8Y479wzZSpih0q0d2CZTg6lBeIMXep20dX8o9wpe7uGdoJn4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVa38c+4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714583280; x=1746119280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R++pfBgyM8DpUgzRcVsetGb7scWw1DWg4IjtUXMthEg=;
  b=AVa38c+4zu5z+lt+Ut3BNNBqVwyR3x6N2CWxPmbbBU4lrsq5VJkJal+J
   YibMU003FwuOeyJ2oVuWU0VdSooqTKHfxB2TGfmCBbTkLG3KO2eTGxiAB
   EmgU7lI1ZHzVe7h96O21WTXyfNbMQcMgzi+GK3741//cW877sNtqESZ4O
   WuSSCv9dfrB3tDQlMlwFcSqA2DBt7Rppgprr6xLsV0TUomJIOInl82MrI
   DieHvO9yCUDbhV70CNuYpuKID8SMk+/XSO40V0fwb6f+StWPtDC6jJaMA
   DeLfJy6XKu9E5qEkqijtFjSM9Tkyl0ga94YbL0+qWVmc2Dnwl4xV6mYif
   Q==;
X-CSE-ConnectionGUID: 9lDZe64TRgC4ANLFt/AU7A==
X-CSE-MsgGUID: NMB3tCpYQWKnNx+Mtjt+pw==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10199763"
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="10199763"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 10:07:59 -0700
X-CSE-ConnectionGUID: W3MmdGvzRRWGs+hcA0tZ9g==
X-CSE-MsgGUID: 03+TZmWrQs6/eHZ/aOd0OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; 
   d="scan'208";a="27336659"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 01 May 2024 10:07:56 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2DQv-0009nw-1m;
	Wed, 01 May 2024 17:07:53 +0000
Date: Thu, 2 May 2024 01:07:40 +0800
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
Message-ID: <202405020009.iVV1DXVS-lkp@intel.com>
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
[also build test WARNING on v6.9-rc6 next-20240501]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lyndon-Sanche/platform-x86-dell-laptop-Implement-platform_profile/20240430-135932
base:   linus/master
patch link:    https://lore.kernel.org/r/20240429164844.7544-2-lsanche%40lyndeno.ca
patch subject: [PATCH v3] platform/x86: dell-laptop: Implement platform_profile
config: x86_64-randconfig-r122-20240501 (https://download.01.org/0day-ci/archive/20240502/202405020009.iVV1DXVS-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240502/202405020009.iVV1DXVS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405020009.iVV1DXVS-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/dell/dell-laptop.c:2418:6: sparse: sparse: symbol 'thermal_cleanup' was not declared. Should it be static?

vim +/thermal_cleanup +2418 drivers/platform/x86/dell/dell-laptop.c

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

