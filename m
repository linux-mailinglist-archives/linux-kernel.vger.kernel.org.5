Return-Path: <linux-kernel+bounces-168438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C68BB899
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3FDC285B94
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C4BA38;
	Sat,  4 May 2024 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDb8/mhD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1873336D;
	Sat,  4 May 2024 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714781172; cv=none; b=m4ZHOtVXmchGmKYa2kjXC9L/rPQzKVHcMfd0hZowh2yncNIt5Pmyh+ZeQ4z4+UalEnOcCnm16To0ClBKzD0thFYCgjCLr3u+Z0rjGQrXb/R9MPTPkYRtQPbDKYPXfK39FRILP0fBppl4jAcfpbPskfLL3Fa6IrzGjy64SC9t908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714781172; c=relaxed/simple;
	bh=n2SZEuocUgy6py23Dq0fblkTnaWOTleAfvkXP/zWG4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcbMGs+CXcvlw4hg2vub965fH5bnb0CQMOEXe0aVom5h+hIzTwnDOvfId5RMr87uQKjstAbfrg1he223o7Rvx6UgTEuLOHLNl2HEorDo4YPa36BVzQM3htXQWkZFrX7L+UOpwipdofLYj1R4l3LDcFJ414uvA8AEkVbwlxUzi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDb8/mhD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714781169; x=1746317169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=n2SZEuocUgy6py23Dq0fblkTnaWOTleAfvkXP/zWG4w=;
  b=mDb8/mhDeQTzq1YyotxCVAuH4HUk8rnVAg93GOUceRH3wZYmtleLC+OX
   HRd+Zdgzpuz60QbZUxaMsxd/rq3ItCC4mu968kOm+B3qLiEo9Q8ForWzQ
   gxFvLPVx4ACyFJXp9oD6hF3qRt/JrSQV70XCehppwCsNz9wCCNJhAuRBa
   HwvVWIHy8v3plbzk7unlYhuViN6ipyFxAjpAOQeYBop4K73TUMz12rBD3
   3ttt/rJTqILVm7PJ8V/GdlQrosZaNz4QqvObqMmU7BQQzJ2+JvxTKQyq8
   3yzi0WMUhydQ/IV7k8xpb8CNHVX0s0gUSLAoCLlZ54oErXpvmg5/f2DjR
   A==;
X-CSE-ConnectionGUID: kI8li5/RQxyFqC5vvpokng==
X-CSE-MsgGUID: mC/DL4+pQ2Gcn8szgbM3yQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10484738"
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="10484738"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 17:06:08 -0700
X-CSE-ConnectionGUID: p034Rb+aRSuA6Wp5F0QbcA==
X-CSE-MsgGUID: GO5xY0pnR9+AFPmMFE9Y+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,252,1708416000"; 
   d="scan'208";a="65027667"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 May 2024 17:06:06 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s32uh-000CE0-0t;
	Sat, 04 May 2024 00:06:03 +0000
Date: Sat, 4 May 2024 08:05:22 +0800
From: kernel test robot <lkp@intel.com>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, kamilh@axis.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach
 link modes
Message-ID: <202405040748.9mCHwtzA-lkp@intel.com>
References: <20240503083719.899312-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503083719.899312-4-kamilh@axis.com>

Hi Kamil,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master v6.9-rc6 next-20240503]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamil-Hor-k-2N/net-phy-bcm54811-New-link-mode-for-BroadR-Reach/20240503-164308
base:   net/main
patch link:    https://lore.kernel.org/r/20240503083719.899312-4-kamilh%40axis.com
patch subject: [PATCH v2 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach link modes
config: powerpc-randconfig-r081-20240504 (https://download.01.org/0day-ci/archive/20240504/202405040748.9mCHwtzA-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 37ae4ad0eef338776c7e2cffb3896153d43dcd90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240504/202405040748.9mCHwtzA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405040748.9mCHwtzA-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/phy/broadcom.c:13:
   In file included from drivers/net/phy/bcm-phy-lib.h:9:
   In file included from include/linux/brcmphy.h:5:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/powerpc/include/asm/cacheflush.h:7:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/phy/broadcom.c:619:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     619 |         if (of_property_read_bool(np, "enet-phy-lane-swap")) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/broadcom.c:627:9: note: uninitialized use occurs here
     627 |         return ret;
         |                ^~~
   drivers/net/phy/broadcom.c:619:2: note: remove the 'if' if its condition is always true
     619 |         if (of_property_read_bool(np, "enet-phy-lane-swap")) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/phy/broadcom.c:614:9: note: initialize the variable 'ret' to silence this warning
     614 |         int ret;
         |                ^
         |                 = 0
   2 warnings generated.


vim +619 drivers/net/phy/broadcom.c

b0ed0bbfb3046e Kevin Lo         2020-05-16  610  
f1e9c8e593d6ea Kamil Horák - 2N 2024-05-03  611  static int bcm5481x_config_delay_swap(struct phy_device *phydev)
57bb7e222804c6 Anton Vorontsov  2008-03-04  612  {
b14995ac2527b4 Jon Mason        2016-11-04  613  	struct device_node *np = phydev->mdio.dev.of_node;
57bb7e222804c6 Anton Vorontsov  2008-03-04  614  	int ret;
57bb7e222804c6 Anton Vorontsov  2008-03-04  615  
f1e9c8e593d6ea Kamil Horák - 2N 2024-05-03  616  	/* Set up the delay. */
042cb56478152b Tao Ren          2018-11-05  617  	bcm54xx_config_clock_delay(phydev);
57bb7e222804c6 Anton Vorontsov  2008-03-04  618  
b14995ac2527b4 Jon Mason        2016-11-04 @619  	if (of_property_read_bool(np, "enet-phy-lane-swap")) {
b14995ac2527b4 Jon Mason        2016-11-04  620  		/* Lane Swap - Undocumented register...magic! */
b14995ac2527b4 Jon Mason        2016-11-04  621  		ret = bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_SEL_ER + 0x9,
b14995ac2527b4 Jon Mason        2016-11-04  622  					0x11B);
b14995ac2527b4 Jon Mason        2016-11-04  623  		if (ret < 0)
b14995ac2527b4 Jon Mason        2016-11-04  624  			return ret;
b14995ac2527b4 Jon Mason        2016-11-04  625  	}
b14995ac2527b4 Jon Mason        2016-11-04  626  
57bb7e222804c6 Anton Vorontsov  2008-03-04  627  	return ret;
57bb7e222804c6 Anton Vorontsov  2008-03-04  628  }
57bb7e222804c6 Anton Vorontsov  2008-03-04  629  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

