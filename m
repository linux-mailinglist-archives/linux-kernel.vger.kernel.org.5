Return-Path: <linux-kernel+bounces-167515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA758BAAA7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7151C22419
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2E61514EF;
	Fri,  3 May 2024 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceQLMO7c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C11514EC;
	Fri,  3 May 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731574; cv=none; b=UGIv7cZW9IG4MSIih/p33qcf+G4QkfGbIuY92yw6MHZcPbdH9M5l+nvnHpHSzcUrsWF2q3lNUAe6PIj+y1xWmd/1kpjZvcxIrYWuID6VCHz3QI9OTGI9ExxhOgkj/Nbwzm9rCmNEboOYqWVFFTYL9gRUCy9ryZrIBV/RMk9S4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731574; c=relaxed/simple;
	bh=/lDfUxTRFR9mzrkg5jEHWirycAbncJU/9vGHcLZJTHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epuh57Gr4w2QWgleNmprQtpY0hjXIizafy7MnQ2NC2vGW+M4S5KFx8f8AnJdhzIQMA4VTbNo4WKCIY9uJh1005TGnFOUtf0SiNvaxVo5pHYeyyeXZEZoFOJf3Jau2w3kRhKjOis5xsWlNVS+AGHoaPGan1Angixulx1ASGJMhN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceQLMO7c; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714731573; x=1746267573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/lDfUxTRFR9mzrkg5jEHWirycAbncJU/9vGHcLZJTHE=;
  b=ceQLMO7c95D4fan8HM48UQbXwkT+Tpi1vV+X3sm8Gl3Xgkc/wi2VeXtz
   9Q+7zuaCQNXHCrp2weBjBdVsB0zrm+LDE2e2mKEmbEg5CqGdofsbS2rwt
   Xb8tCm5QOpkyuI32HhBqPM0mutjqSfVar1newnztw7zIeNdbiVAM08iF1
   LXmVmUvC7uIY8SQ14ApdGbcv9k8VeI5a25x89pl8cQFGxQ2/9byhsULA4
   YwM9nHdu7pdaWT6LsL6b/WjHpB2AEI1gxG5dqRTu0UzoamSGTW442OwST
   Tf6M+IwJw8Bb2qs7Dd7M1+NuGaKl1XVzkeUMZuUkgQvGmoHVel2s7mnhH
   w==;
X-CSE-ConnectionGUID: r5ZyBRgkTNaEsjsC2pBpmw==
X-CSE-MsgGUID: ZqFNwp6dRoyo87RoqRVaRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10390955"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10390955"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 03:19:32 -0700
X-CSE-ConnectionGUID: SioMnQgmSzScssdJPzZcBA==
X-CSE-MsgGUID: 0JKIIG6tQkKTg7ZClaSN9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27464215"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 03 May 2024 03:19:27 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2q0i-000BZw-0K;
	Fri, 03 May 2024 10:19:24 +0000
Date: Fri, 3 May 2024 18:19:18 +0800
From: kernel test robot <lkp@intel.com>
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, mario.limonciello@amd.com,
	pali@kernel.org, W_Armin@gmx.de,
	srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	lkp@intel.com, Hans de Goede <hdegoede@redhat.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
Message-ID: <202405031851.NYy0ZB02-lkp@intel.com>
References: <20240501215829.4991-2-lsanche@lyndeno.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501215829.4991-2-lsanche@lyndeno.ca>

Hi Lyndon,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.9-rc6 next-20240503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lyndon-Sanche/platform-x86-dell-laptop-Implement-platform_profile/20240502-060146
base:   linus/master
patch link:    https://lore.kernel.org/r/20240501215829.4991-2-lsanche%40lyndeno.ca
patch subject: [PATCH v5] platform/x86: dell-laptop: Implement platform_profile
config: i386-kismet-CONFIG_ACPI_PLATFORM_PROFILE-CONFIG_DELL_LAPTOP-0-0 (https://download.01.org/0day-ci/archive/20240503/202405031851.NYy0ZB02-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240503/202405031851.NYy0ZB02-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405031851.NYy0ZB02-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for ACPI_PLATFORM_PROFILE when selected by DELL_LAPTOP
   WARNING: unmet direct dependencies detected for ACPI_PLATFORM_PROFILE
     Depends on [n]: ACPI [=n]
     Selected by [y]:
     - DELL_LAPTOP [=y] && X86_PLATFORM_DEVICES [=y] && X86_PLATFORM_DRIVERS_DELL [=y] && DMI [=y] && BACKLIGHT_CLASS_DEVICE [=y] && (ACPI_VIDEO [=n] || ACPI_VIDEO [=n]=n) && (RFKILL [=n] || RFKILL [=n]=n) && (DELL_WMI [=n] || DELL_WMI [=n]=n) && SERIO_I8042 [=y] && DELL_SMBIOS [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

