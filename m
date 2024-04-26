Return-Path: <linux-kernel+bounces-159521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FC98B2FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E427A284DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E29613A3EB;
	Fri, 26 Apr 2024 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKhzB73L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494CB13A25D;
	Fri, 26 Apr 2024 05:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714108898; cv=none; b=tzywp7uDjyUdVTWAq/N9ea3aZeIqjt2nhhzDXeqxv4R0yVLYkxWrp9iBkoMbYx2xz7uUNSwW0Py0rDfEyhgbhDTZfcOqr///mJ++enyagLiC4vunkupylog/NkdS8zT0LJTz4RN0gGE+ma5q2J00SqHUhp9OYCnN4sV8tIG3dZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714108898; c=relaxed/simple;
	bh=SLIrhNL07fIq6paa7wR6CFchJgIfijn7oQKw+HQTtDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRPLMsWLO5+9gTAkC1C4q6q34xKo1HhHRiypmhsfZlItb96IewmdFWdQ5niSnVQ3eI3nho63vdgy18Znp+zPtMFtjXR4DPf+sBZaEeW9O7VX6gp8RtuNLfSEhKY2V2oJdQ51bh2E+xQJiEVWlj68pUR7xDjqBzr+d/R46EVOWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKhzB73L; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714108897; x=1745644897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SLIrhNL07fIq6paa7wR6CFchJgIfijn7oQKw+HQTtDc=;
  b=oKhzB73LVCjUSjIwQmXES0M5htNOc9kxptJKEx2fJ8m/G0IEgAMp3P2a
   DXn3WRjj3LllJpVH3SrHugQIIzwc8tLlJIAxUycgeQeR+8ryUkX/pKjQH
   LVr7S4ShpSv3TMu9mtdbObJEOQub08XeyLwIyRDWvdcLmGn9HTImn+n6w
   IW8C/hDi7/jseb2i0UV+DVmmEtOgVvNHwPjYWi8ZmGVIxUHJBjZTe2p2j
   rZLhkmhQqmto1O5cOmKjqNXpx2z3YXQMrA0WnZJd9Nb2vKUfPi6TulZGj
   cWvsrLmX/D+ExkY2YQIGgMZQeeaBHBx+ntdcjXNB9I9M4ztlgxpdbWYFG
   Q==;
X-CSE-ConnectionGUID: 4wV5tlOrSo2UXHKgyZQ+Fg==
X-CSE-MsgGUID: WqcZu8NsQvmY26nSo/2F7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="32332227"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="32332227"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 22:21:36 -0700
X-CSE-ConnectionGUID: rsm/kYDnQU+En24nwWgodg==
X-CSE-MsgGUID: zVUPIdL8QPi/qSowTT4xYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="29971707"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 25 Apr 2024 22:21:33 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0E1a-0003Ik-1N;
	Fri, 26 Apr 2024 05:21:30 +0000
Date: Fri, 26 Apr 2024 13:20:59 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: Remove adjust_link paths
Message-ID: <202404261353.mKEFmDUo-lkp@intel.com>
References: <20240425185336.2084871-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425185336.2084871-3-florian.fainelli@broadcom.com>

Hi Florian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Fainelli/net-dsa-Remove-fixed_link_update-member/20240426-025626
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240425185336.2084871-3-florian.fainelli%40broadcom.com
patch subject: [PATCH net-next 2/2] net: dsa: Remove adjust_link paths
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240426/202404261353.mKEFmDUo-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240426/202404261353.mKEFmDUo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404261353.mKEFmDUo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/dsa/port.c:1600:21: warning: variable 'phydev' set but not used [-Wunused-but-set-variable]
           struct phy_device *phydev = NULL;
                              ^
   1 warning generated.


vim +/phydev +1600 net/dsa/port.c

dd805cf3e80e03 Russell King (Oracle  2023-05-25  1594) 
8ae674964e67eb Florian Fainelli      2019-12-16  1595  static void dsa_port_phylink_mac_link_down(struct phylink_config *config,
77373d49de22e8 Ioana Ciornei         2019-05-28  1596  					   unsigned int mode,
77373d49de22e8 Ioana Ciornei         2019-05-28  1597  					   phy_interface_t interface)
77373d49de22e8 Ioana Ciornei         2019-05-28  1598  {
dd0c9855b41310 Russell King (Oracle  2024-04-10  1599) 	struct dsa_port *dp = dsa_phylink_to_port(config);
0e27921816ad99 Ioana Ciornei         2019-05-28 @1600  	struct phy_device *phydev = NULL;
77373d49de22e8 Ioana Ciornei         2019-05-28  1601  	struct dsa_switch *ds = dp->ds;
77373d49de22e8 Ioana Ciornei         2019-05-28  1602  
57d77986e74287 Vladimir Oltean       2021-10-20  1603  	if (dsa_port_is_user(dp))
6ca80638b90cec Florian Fainelli      2023-10-23  1604  		phydev = dp->user->phydev;
0e27921816ad99 Ioana Ciornei         2019-05-28  1605  
d074ebf637f87c Florian Fainelli      2024-04-25  1606  	if (!ds->ops->phylink_mac_link_down)
77373d49de22e8 Ioana Ciornei         2019-05-28  1607  		return;
77373d49de22e8 Ioana Ciornei         2019-05-28  1608  
77373d49de22e8 Ioana Ciornei         2019-05-28  1609  	ds->ops->phylink_mac_link_down(ds, dp->index, mode, interface);
77373d49de22e8 Ioana Ciornei         2019-05-28  1610  }
77373d49de22e8 Ioana Ciornei         2019-05-28  1611  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

