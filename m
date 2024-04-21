Return-Path: <linux-kernel+bounces-152441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1FC8ABE78
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 05:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6904EB20DDA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC85610B;
	Sun, 21 Apr 2024 03:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPXriNdq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3521A205E22;
	Sun, 21 Apr 2024 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713670396; cv=none; b=J7eExWsMy+HSPD0XzNnEDsthd8NlJIB67gTjUpDMs2xtJ9vR9TPAWfWWSsaHVOfsIC1ymYdMfJdWxRTc2dLimhtxZNGoj+7kS8UV4at8RkyUYaeVCMp/+8HkZoOENQ8mMZQh8xeTkGadOcq16Vmq8MH1qWl0+g6DcalcAR8y//c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713670396; c=relaxed/simple;
	bh=2wGoBsP6PzGZdr0dF6/8wwx8vJ80lvo1VMdDLh+ZaHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHNx5EBnrUdZucC70E5DP9C1Rue67MJ0aogI10E4WVqzOjhGJhOcVoETxpHDggmM0Bw51kTtbhMiqdGt1GHTc5rAJnj0IAnMGLRCPyxl3UUJFkj9PnL+BdlgPyAWGaewVtI0ljU7iBXICghyy1OX1ZEhH3ce6Swe86JWSGLTV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPXriNdq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713670392; x=1745206392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2wGoBsP6PzGZdr0dF6/8wwx8vJ80lvo1VMdDLh+ZaHY=;
  b=ZPXriNdqyLNBJEJaSODk4/8mxnLmBJExywuyoWqW56ERyNut2REFCkHE
   Go8w6pWdaSaxrliSpIUXbv9kcBE8+sqbmLn/KXT+sy5/3NMhFwrMHsnci
   bi0I8NW4ZitQsR0MKFL+OooOTKN6KK51U5ebo+Bdx0mLU83iYo8wZutzm
   taxKqfccOCWz85Vzv9nQlvTi5ZMJpH+eyX4fd3rEmO6spxgHqxB75Rl2m
   WkFidhiZCSQQITR+WH4Ui6f+L0Zywy2qAJO3JeDUXy7fAXKFlMTUCqlvX
   8S+JcDK3HfmHNiDeCJYqF7I3qOwV8gU3t+8Ou0RTLAocz36yEN/hEV4IF
   w==;
X-CSE-ConnectionGUID: lEaCESP+Sqie6jlollFPcw==
X-CSE-MsgGUID: k7Xp2aqvT7u7LwaZNSKLHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="31715546"
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="31715546"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 20:33:11 -0700
X-CSE-ConnectionGUID: 2OlAjcfJRt2fW/MzsH2jJw==
X-CSE-MsgGUID: +eJRpfAvSV6+wAapHyc8gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="28501483"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 20 Apr 2024 20:33:09 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryNww-000Bex-0G;
	Sun, 21 Apr 2024 03:33:06 +0000
Date: Sun, 21 Apr 2024 11:32:58 +0800
From: kernel test robot <lkp@intel.com>
To: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>, hdegoede@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, corentin.chary@gmail.com,
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, "Luke D . Jones" <luke@ljones.dev>,
	Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for vivobook
 fan profiles
Message-ID: <202404211141.mYHti4dq-lkp@intel.com>
References: <20240418214727.10658-2-mohamed.ghanmi@supcom.tn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418214727.10658-2-mohamed.ghanmi@supcom.tn>

Hi Mohamed,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240418]
[cannot apply to linus/master v6.9-rc4 v6.9-rc3 v6.9-rc2 v6.9-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mohamed-Ghanmi/platform-x86-asus-wmi-add-support-for-vivobook-fan-profiles/20240419-055003
base:   next-20240418
patch link:    https://lore.kernel.org/r/20240418214727.10658-2-mohamed.ghanmi%40supcom.tn
patch subject: [PATCH v2 1/1] platform/x86: asus-wmi: add support for vivobook fan profiles
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240421/202404211141.mYHti4dq-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240421/202404211141.mYHti4dq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404211141.mYHti4dq-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/platform/x86/asus-wmi.c: In function 'throttle_thermal_policy_store':
>> drivers/platform/x86/asus-wmi.c:3730:56: error: 'asus' undeclared (first use in this function)
    3730 |         u8 max_mode = throttle_thermal_policy_max_mode(asus);
         |                                                        ^~~~
   drivers/platform/x86/asus-wmi.c:3730:56: note: each undeclared identifier is reported only once for each function it appears in


vim +/asus +3730 drivers/platform/x86/asus-wmi.c

  3725	
  3726	static ssize_t throttle_thermal_policy_store(struct device *dev,
  3727					    struct device_attribute *attr,
  3728					    const char *buf, size_t count)
  3729	{
> 3730		u8 max_mode = throttle_thermal_policy_max_mode(asus);
  3731		struct asus_wmi *asus = dev_get_drvdata(dev);
  3732		u8 new_mode;
  3733		int result;
  3734		int err;
  3735	
  3736		result = kstrtou8(buf, 10, &new_mode);
  3737		if (result < 0)
  3738			return result;
  3739	
  3740		if (new_mode > max_mode)
  3741			return -EINVAL;
  3742	
  3743		asus->throttle_thermal_policy_mode = new_mode;
  3744		err = throttle_thermal_policy_write(asus);
  3745		if (err)
  3746			return err;
  3747	
  3748		/*
  3749		 * Ensure that platform_profile updates userspace with the change to ensure
  3750		 * that platform_profile and throttle_thermal_policy_mode are in sync.
  3751		 */
  3752		platform_profile_notify();
  3753	
  3754		return count;
  3755	}
  3756	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

