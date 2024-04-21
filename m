Return-Path: <linux-kernel+bounces-152444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8825F8ABE7E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 05:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B5B281065
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 03:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7983C6FB1;
	Sun, 21 Apr 2024 03:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9WKXXjF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861B84C70;
	Sun, 21 Apr 2024 03:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713671059; cv=none; b=Udw7smjQ2zerw+JzASV4tpTiCdgPoC8+aXIuuz6j4qTMQIH4m0PTx2jeG/0cnMWSFebz3mmC4Ag++wvTfhWsLV3JYcbLNEUc3PnC5eedSxvugW0iTU9z5n+Owx68B1oNoW8IExrkJj4orKyV+LZuy1KeGEt8T2fbmJ3K996Xrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713671059; c=relaxed/simple;
	bh=7w0n391lEOJiB4Bkz9LUiRO65cvGXQ/0hj8tv7G2fJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFuefCoXP4o+6og2VghFeTjOhgxPmI9w5766+/QeRW22kvd5vU68XesQ5e8x8iWwbGFKjwrvhI5qHPQm6eY8PpqUNImQ24B9LZ3GmOBfAooL5nMak71+d3URXChdT8dvUSfsNU3ypMZJSxS3oPcwvnmXK/idBx1QuvsBLKONjrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9WKXXjF; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713671055; x=1745207055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7w0n391lEOJiB4Bkz9LUiRO65cvGXQ/0hj8tv7G2fJc=;
  b=l9WKXXjFwf+8smdBxl7Y8QpVdBI8vjscihlY9xkRi96U3o/gVQPYZP5Z
   Q5vmomwfDUine7X85whUng8nUeQdC/K+vfpRiMrmaQqCSr+qtSyI4y1EB
   OlAp9JE5fMIaLfv130EERsrKRCh7OsF1/5JeXOlsGUyczKBJkasuqFx+V
   SOKg5iX2Ilo6lVilIragqj5GnSjlDlrs4du56enHOjhBVw4739nVSKsgA
   vE2q+ogd1SL+Koq+OaX5gsCJWMIdsRJL8xpv4NwXZZBgynZvyLpH6sZ40
   ePAI93LhSIzUTFZizjisvvpMtRkLVh90xL6kALPiupKF5u8xjTc4UboNk
   g==;
X-CSE-ConnectionGUID: ShkHpnZTTiCHNCPn205ZkQ==
X-CSE-MsgGUID: pg59g6i9RmKEfFzSAUzPPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="20374178"
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="20374178"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2024 20:44:14 -0700
X-CSE-ConnectionGUID: bhsNMk0ETOmtQirJyLeisA==
X-CSE-MsgGUID: CrFy/DzhTk+NvEY3j8zkTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="23751069"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 20 Apr 2024 20:44:11 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ryO7c-000BfO-2g;
	Sun, 21 Apr 2024 03:44:08 +0000
Date: Sun, 21 Apr 2024 11:43:37 +0800
From: kernel test robot <lkp@intel.com>
To: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>, hdegoede@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	corentin.chary@gmail.com, ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Luke D . Jones" <luke@ljones.dev>,
	Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for vivobook
 fan profiles
Message-ID: <202404211110.YaZAJhfU-lkp@intel.com>
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
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240421/202404211110.YaZAJhfU-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240421/202404211110.YaZAJhfU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404211110.YaZAJhfU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/x86/asus-wmi.c:3730:49: error: use of undeclared identifier 'asus'
    3730 |         u8 max_mode = throttle_thermal_policy_max_mode(asus);
         |                                                        ^
   1 error generated.


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

