Return-Path: <linux-kernel+bounces-166872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DAE8BA12C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDE62842B3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A281802BE;
	Thu,  2 May 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XzDVUiBM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD91F17BA0;
	Thu,  2 May 2024 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714679881; cv=none; b=AJ7OMbqXLtCWwj4Hsg6xi3v838j7ZT4lIklUVksapasa1P5v7LPt4mOU/xE93CT7QydOuDLr1izHPaaPwkSO6fD7NBIjE7XwIouJQnEF+olSJ+7XKAOnUOf/uPnnKpfHpALVEIAC0TxOcWBiEr2alL3xSuRV0AyG5AIb5aw8nOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714679881; c=relaxed/simple;
	bh=1S0GzJBiUkMO5OirpjjonQ9h3h9HMGieZ3Re6gFYH6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCDsByCppGItmLEeaArKqkyyukP6z8s3HYIk7enest5hm3hgyRcK4fIxqbYjzWpzgfisQSdPJGa5BjCXiRAHGBYRDD8j8pOacjh3sicxrMEAm9L9hmE8XNvdIHdjkERTESpHWAXr57tMKLoKalduOKOnvYvlvT7joOMLm7LUZcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XzDVUiBM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714679880; x=1746215880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1S0GzJBiUkMO5OirpjjonQ9h3h9HMGieZ3Re6gFYH6Y=;
  b=XzDVUiBM88Fhi9tIgv0kZN6cFn/MgbbbhJq6g8dfKLFmRT0U76RdIgC9
   Y6K6d1vn+4lx2/b6SCKEqDm3gAJtgExSG2Xvkbu24QFCwqeu95ZSmTZda
   ek6kepHVjS0isYJ8C0Q/NGK7ksm0LkWtH9A8szRe26YQJbNZ1X3tGk0m6
   bfIIQQNHaGWp/YxSsGpk61L0DnU/bK9aWpYhSi+Y8VyT8WzkZXYOCwcih
   Hp8uoWBUqlEqIIC50W3SKAhIOxxed+LRY+HD+6yxINGzrqWsAgbikKnlb
   LmWzdY+i4NilekiFyNbhxPeyQIuVWpCJMRLXuC/fOGf9Nvd4MTTbtzfeE
   w==;
X-CSE-ConnectionGUID: eorxqe6yTse3qWnZDQMEWQ==
X-CSE-MsgGUID: 749uCBJuQNuLWFCvVNthIw==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10596931"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10596931"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 12:58:00 -0700
X-CSE-ConnectionGUID: Gp62U2F4QnCUwMTyJqrJKQ==
X-CSE-MsgGUID: f+UFLMA2TNqenvU5e7Kbuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27109402"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 May 2024 12:57:58 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2cZ0-000Awi-1a;
	Thu, 02 May 2024 19:57:54 +0000
Date: Fri, 3 May 2024 03:57:00 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan Denose <jdenose@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	Jonathan Denose <jdenose@google.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeffery Miller <jefferymiller@google.com>
Subject: Re: [PATCH] Input: elantech - fix touchpad state on resume for
 Lenovo N24
Message-ID: <202405030346.3Q7ixiBD-lkp@intel.com>
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
config: powerpc64-randconfig-r122-20240502 (https://download.01.org/0day-ci/archive/20240503/202405030346.3Q7ixiBD-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240503/202405030346.3Q7ixiBD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405030346.3Q7ixiBD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/input/mouse/elantech.c:1509:75: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int timeout @@     got void * @@
   drivers/input/mouse/elantech.c:1509:75: sparse:     expected unsigned int timeout
   drivers/input/mouse/elantech.c:1509:75: sparse:     got void *
   drivers/input/mouse/elantech.c:1515:74: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int timeout @@     got void * @@
   drivers/input/mouse/elantech.c:1515:74: sparse:     expected unsigned int timeout
   drivers/input/mouse/elantech.c:1515:74: sparse:     got void *

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

