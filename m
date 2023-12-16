Return-Path: <linux-kernel+bounces-1957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C138815656
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020B11F258D1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB90E1877;
	Sat, 16 Dec 2023 02:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LinrVYFE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087C6FB7;
	Sat, 16 Dec 2023 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702693378; x=1734229378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mEC98lmsh5St9/tHWxs0j1MduPJpAlDqdLxHQQxI6Cw=;
  b=LinrVYFEXHvaEjBqj9FsSB0WQGCakERAmewP2W7fEMXDlibZiW40bGY/
   9lW5v0iDfajdqmNB3jJj+RQcYv0Lw1V4QqJxLpWUlJWBa+SizZdHEUlUd
   Vc3AjrkH8q5EfZ0SsFaS2N6CixCKAA77r/uWMjIQc2BIZijSEt0/Ja5+J
   uDRGiOOr5K1VeID1+wiSeGJ03ofy2coPSZCpczzqV/kOyQXqn4hDSXkly
   ZqXb3eJ81juAhRRIDJyTa3fLUF98vSG4XImMqfT0PAHAz8JQIssr75SbT
   lUsXpworv7sAGOTTiXmht+SBShWmAB+1genjlhoEqLVYpgEZIs95wd7EM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="8773847"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="8773847"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 18:22:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="774953827"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="774953827"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Dec 2023 18:22:54 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEKKJ-00013I-2w;
	Sat, 16 Dec 2023 02:22:51 +0000
Date: Sat, 16 Dec 2023 10:21:52 +0800
From: kernel test robot <lkp@intel.com>
To: RD Babiera <rdbabiera@google.com>, heikki.krogerus@linux.intel.com,
	linux@roeck-us.net, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, badhri@google.com,
	bryan.odonoghue@linaro.org, agross@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org
Subject: Re: [PATCH v2 01/12] usb: typec: altmodes: add typec_cable_ops to
 typec_altmode
Message-ID: <202312161038.P8GnRTgA-lkp@intel.com>
References: <20231214230850.379863-15-rdbabiera@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214230850.379863-15-rdbabiera@google.com>

Hi RD,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/RD-Babiera/usb-typec-altmodes-add-typec_cable_ops-to-typec_altmode/20231215-071339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20231214230850.379863-15-rdbabiera%40google.com
patch subject: [PATCH v2 01/12] usb: typec: altmodes: add typec_cable_ops to typec_altmode
config: alpha-randconfig-r071-20231216 (https://download.01.org/0day-ci/archive/20231216/202312161038.P8GnRTgA-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312161038.P8GnRTgA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312161038.P8GnRTgA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/typec/bus.c:260: warning: expecting prototype for typec_altmode_enter(). Prototype was for typec_cable_altmode_enter() instead
>> drivers/usb/typec/bus.c:290: warning: expecting prototype for typec_altmode_exit(). Prototype was for typec_cable_altmode_exit() instead
>> drivers/usb/typec/bus.c:323: warning: expecting prototype for typec_altmode_vdm(). Prototype was for typec_cable_altmode_vdm() instead


vim +260 drivers/usb/typec/bus.c

   249	
   250	/**
   251	 * typec_altmode_enter - Enter Mode
   252	 * @adev: The alternate mode
   253	 * @sop: Cable plug target for Enter Mode command
   254	 * @vdo: VDO for the Enter Mode command
   255	 *
   256	 * Alternate mode drivers use this function to enter mode on the cable plug.
   257	 * If the alternate mode does not require VDO, @vdo must be NULL.
   258	 */
   259	int typec_cable_altmode_enter(struct typec_altmode *adev, enum typec_plug_index sop, u32 *vdo)
 > 260	{
   261		struct altmode *partner = to_altmode(adev)->partner;
   262		struct typec_altmode *pdev;
   263	
   264		if (!adev || adev->active)
   265			return 0;
   266	
   267		if (!partner)
   268			return -ENODEV;
   269	
   270		pdev = &partner->adev;
   271	
   272		if (!pdev->active)
   273			return -EPERM;
   274	
   275		if (!pdev->cable_ops || !pdev->cable_ops->enter)
   276			return -EOPNOTSUPP;
   277	
   278		return pdev->cable_ops->enter(pdev, sop, vdo);
   279	}
   280	EXPORT_SYMBOL_GPL(typec_cable_altmode_enter);
   281	
   282	/**
   283	 * typec_altmode_exit - Exit Mode
   284	 * @adev: The alternate mode
   285	 * @sop: Cable plug target for Exit Mode command
   286	 *
   287	 * The alternate mode drivers use this function to exit mode on the cable plug.
   288	 */
   289	int typec_cable_altmode_exit(struct typec_altmode *adev, enum typec_plug_index sop)
 > 290	{
   291		struct altmode *partner = to_altmode(adev)->partner;
   292		struct typec_altmode *pdev;
   293	
   294		if (!adev || !adev->active)
   295			return 0;
   296	
   297		if (!partner)
   298			return -ENODEV;
   299	
   300		pdev = &partner->adev;
   301	
   302		if (!pdev->cable_ops || !pdev->cable_ops->exit)
   303			return -EOPNOTSUPP;
   304	
   305		return pdev->cable_ops->exit(pdev, sop);
   306	}
   307	EXPORT_SYMBOL_GPL(typec_cable_altmode_exit);
   308	
   309	/**
   310	 * typec_altmode_vdm - Send Vendor Defined Messages (VDM) between the cable plug and port.
   311	 * @adev: Alternate mode handle
   312	 * @sop: Cable plug target for VDM
   313	 * @header: VDM Header
   314	 * @vdo: Array of Vendor Defined Data Objects
   315	 * @count: Number of Data Objects
   316	 *
   317	 * The alternate mode drivers use this function for SVID specific communication
   318	 * with the cable plugs. The port drivers use it to deliver the Structured VDMs
   319	 * received from the cable plugs to the alternate mode drivers.
   320	 */
   321	int typec_cable_altmode_vdm(struct typec_altmode *adev, enum typec_plug_index sop,
   322				    const u32 header, const u32 *vdo, int count)
 > 323	{
   324		struct altmode *altmode;
   325		struct typec_altmode *pdev;
   326	
   327		if (!adev)
   328			return 0;
   329	
   330		altmode = to_altmode(adev);
   331	
   332		if (is_typec_plug(adev->dev.parent)) {
   333			if (!altmode->partner)
   334				return -ENODEV;
   335			pdev = &altmode->partner->adev;
   336		} else {
   337			if (!altmode->plug[sop])
   338				return -ENODEV;
   339			pdev = &altmode->plug[sop]->adev;
   340		}
   341	
   342		if (!pdev->cable_ops || !pdev->cable_ops->vdm)
   343			return -EOPNOTSUPP;
   344	
   345		return pdev->cable_ops->vdm(pdev, sop, header, vdo, count);
   346	}
   347	EXPORT_SYMBOL_GPL(typec_cable_altmode_vdm);
   348	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

