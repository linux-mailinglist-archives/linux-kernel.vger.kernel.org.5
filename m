Return-Path: <linux-kernel+bounces-166793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4B18B9F88
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55353B23495
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED9A16FF58;
	Thu,  2 May 2024 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYnVURKx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839416FF43;
	Thu,  2 May 2024 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671054; cv=none; b=KSecCL7e4uBx7TD1L4S49ZMMwggBP0W1s6/DaTcVyVEIRmLZE93Q/+9sMjvh1uk5KHhRYA+FdaZO5mQqFMRGFHP3NY8c1Bjo8pkzyDFyfFqPsq4gKdskVAZDzts+kIOrcOx2vsvY/1KLrYe9RN/K86e7wwRg36yIjROS5fHwoqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671054; c=relaxed/simple;
	bh=fWGbMKNAvOUN21O1ymW4R6KStRYsViEkha7BTMexEiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5N1MtcA0RBRlk7cA7uzjPZZkUZCQV5nhLzFjEw1F5y+Jr85LxI1sNErI+GmA8ZqBeVq7vUIPE0sCZQWsg/15D59MpAxlkCP9o4ZzlCvPeSNf1wwfiJvmOnHMLlG0mXNK50XIAnkap1oF6H0iB8VeKayItIAjyBeoTpZS5z3gpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYnVURKx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714671053; x=1746207053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fWGbMKNAvOUN21O1ymW4R6KStRYsViEkha7BTMexEiI=;
  b=MYnVURKx/7VI8mHFzVmCqso8oZ7gFqYB9c34nd5iglGp2XKR/aCTeuYf
   /wEaot49gO90o3IPGU+W6JC0tyRniuSiykAPnG705OeB7960nCEw5AOX1
   C3ITvypSkhakjcBN1gmVtXnvxnOtNWAw2eMb61Ym7SdWHhVQiQJ2FO8wf
   ktSv+HmQW5bshrVooNPnpG2P/UhAUEZ2Z/dqID3pikNUkwfPkSkIEogFY
   rzY5mHqgeIb+5oaKY/tNCm+DLbIPR+Li5VX4synBMTeRtSbq8fwpgM10C
   bcWKr+7b7vRFYyUtoynSqmy52mLNa2AOxxSf2DypgnLGedEhYk0HIjjiV
   Q==;
X-CSE-ConnectionGUID: OVNUIajeQP6eFCYEr4Wgjw==
X-CSE-MsgGUID: Hi0W65YwT5ecKjCGHRTFZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="14234377"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14234377"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 10:30:52 -0700
X-CSE-ConnectionGUID: hAw8YDL3TESZ+FqgFuOL0Q==
X-CSE-MsgGUID: XtDpE+hHTICECrRXXkDGRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27197934"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 02 May 2024 10:30:49 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2aGd-000ArU-1j;
	Thu, 02 May 2024 17:30:47 +0000
Date: Fri, 3 May 2024 01:29:57 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan Denose <jdenose@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-input@vger.kernel.org, Jonathan Denose <jdenose@google.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeffery Miller <jefferymiller@google.com>
Subject: Re: [PATCH] Input: elantech - fix touchpad state on resume for
 Lenovo N24
Message-ID: <202405030159.u9nJS35h-lkp@intel.com>
References: <20240501140231.1.Ifa0e25ebf968d8f307f58d678036944141ab17e6@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501140231.1.Ifa0e25ebf968d8f307f58d678036944141ab17e6@changeid>

Hi Jonathan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus hid/for-next linus/master v6.9-rc6 next-20240502]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Denose/Input-elantech-fix-touchpad-state-on-resume-for-Lenovo-N24/20240501-220739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20240501140231.1.Ifa0e25ebf968d8f307f58d678036944141ab17e6%40changeid
patch subject: [PATCH] Input: elantech - fix touchpad state on resume for Lenovo N24
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240503/202405030159.u9nJS35h-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405030159.u9nJS35h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405030159.u9nJS35h-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/input/mouse/elantech.c:1509:61: warning: incompatible pointer to integer conversion passing 'void *' to parameter of type 'unsigned int' [-Wint-conversion]
                   err = ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_DISABLE, NULL);
                                                                             ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   include/linux/libps2.h:64:63: note: passing argument to parameter 'timeout' here
   int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout);
                                                                 ^
   drivers/input/mouse/elantech.c:1515:60: warning: incompatible pointer to integer conversion passing 'void *' to parameter of type 'unsigned int' [-Wint-conversion]
                   err = ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_ENABLE, NULL);
                                                                            ^~~~
   include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
   #define NULL ((void *)0)
                ^~~~~~~~~~~
   include/linux/libps2.h:64:63: note: passing argument to parameter 'timeout' here
   int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout);
                                                                 ^
   2 warnings generated.


vim +1509 drivers/input/mouse/elantech.c

  1495	
  1496	/*
  1497	 * Put the touchpad back into absolute mode when reconnecting
  1498	 */
  1499	static int elantech_reconnect(struct psmouse *psmouse)
  1500	{
  1501		psmouse_reset(psmouse);
  1502	
  1503		if (elantech_detect(psmouse, 0))
  1504			return -1;
  1505	
  1506		if (dmi_check_system(elantech_needs_reenable)) {
  1507			int err;
  1508	
> 1509			err = ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_DISABLE, NULL);
  1510	
  1511			if (err)
  1512				psmouse_warn(psmouse, "Failed to deactivate mouse on %s: %d\n",
  1513						psmouse->ps2dev.serio->phys, err);
  1514	
  1515			err = ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_ENABLE, NULL);
  1516	
  1517			if (err)
  1518				psmouse_warn(psmouse, "Failed to reactivate mouse on %s: %d\n",
  1519						psmouse->ps2dev.serio->phys, err);
  1520		}
  1521	
  1522		if (elantech_set_absolute_mode(psmouse)) {
  1523			psmouse_err(psmouse,
  1524				    "failed to put touchpad back into absolute mode.\n");
  1525			return -1;
  1526		}
  1527	
  1528		return 0;
  1529	}
  1530	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

