Return-Path: <linux-kernel+bounces-163267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA2C8B67FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD421C22326
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60452D529;
	Tue, 30 Apr 2024 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxnNJ87j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6DF205E06;
	Tue, 30 Apr 2024 02:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714444507; cv=none; b=Tfjw0d1KJRrvG5xM5cnv+OaxjcmgnEmanLz+bpokuVPv9xeRJ1uoq37tlt3j0gt6AfMsRu5rI4H/fjViWMdOp25PXsCfCbaEYiAoRqzmPiGIhKbOH33xhXqM3kg41S8El+cfpuoCo4dQi4R3gFC1mI+z6vHKhKydPHPY2fNHZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714444507; c=relaxed/simple;
	bh=mBW04Q10joVZ1ZQMyWnTefjJ26duJvYfVCzyImQtuCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxQFfuo6djJ/UG5/d0NgwoDWF4/tRjVpHVSURnEpO309SyjwdmODGvUdBft/T1a2IYmucMnZ4gAgv0A8sQBSHA3OvYGyWyujkJtV7tq/2F7fEDj2hDkQvIm7ZyVM0saFYIOUepc9HEmeceknmyQTF4C+w+P/5u0YPwccGQf4moA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxnNJ87j; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714444506; x=1745980506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mBW04Q10joVZ1ZQMyWnTefjJ26duJvYfVCzyImQtuCg=;
  b=YxnNJ87jCLffby67u8kJvWTzysyiu+QNz7BN0M6e0G8taFSixl9k3CUc
   3EIf7idpfRMCFDQFb8bEAqxppAT1Lj7zOJmlxS6PtXIwedxUslgM7V4wC
   qsZkLAnOaz3XxdQjw545z9oYLNH58RQsD8pFHnambdpm7AO/AVOeGDupz
   Ma80h/aLjtRcijkanGjQ2E4oveFsPyZUeg0pPjio0ifgW4bLsyXmfRJ9o
   yqYZcOBBrp8f7clOCUHH5B3G3EMIjMFW+P/ezGm1MxsOhR9vzcp/R3mYZ
   qGvF/wMJ71PgSLWe2k1kfkxiZHvxZBjqH4VI2UKB3rBqikfstjkht9fhi
   Q==;
X-CSE-ConnectionGUID: dAEBi3WnSHqU39Gs1Zpdvg==
X-CSE-MsgGUID: efvmGPrZT8Gpe8SKYZTkWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21279196"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21279196"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:35:05 -0700
X-CSE-ConnectionGUID: D0PpkDjPSAaWH09WHdchXg==
X-CSE-MsgGUID: O77IF/3oRzKaWpgL7k7Ugg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="31001051"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 Apr 2024 19:35:01 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1dKd-0007dQ-1U;
	Tue, 30 Apr 2024 02:34:59 +0000
Date: Tue, 30 Apr 2024 10:33:58 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: dsa: Remove adjust_link paths
Message-ID: <202404301046.whP44a3U-lkp@intel.com>
References: <20240429165405.2298962-3-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429165405.2298962-3-florian.fainelli@broadcom.com>

Hi Florian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Fainelli/net-dsa-Remove-fixed_link_update-member/20240430-005631
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240429165405.2298962-3-florian.fainelli%40broadcom.com
patch subject: [PATCH net-next v2 2/2] net: dsa: Remove adjust_link paths
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240430/202404301046.whP44a3U-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240430/202404301046.whP44a3U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404301046.whP44a3U-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/dsa/port.c: In function 'dsa_port_phylink_mac_link_down':
>> net/dsa/port.c:1603:17: error: 'phydev' undeclared (first use in this function)
    1603 |                 phydev = dp->user->phydev;
         |                 ^~~~~~
   net/dsa/port.c:1603:17: note: each undeclared identifier is reported only once for each function it appears in


vim +/phydev +1603 net/dsa/port.c

dd805cf3e80e03 Russell King (Oracle  2023-05-25  1594) 
8ae674964e67eb Florian Fainelli      2019-12-16  1595  static void dsa_port_phylink_mac_link_down(struct phylink_config *config,
77373d49de22e8 Ioana Ciornei         2019-05-28  1596  					   unsigned int mode,
77373d49de22e8 Ioana Ciornei         2019-05-28  1597  					   phy_interface_t interface)
77373d49de22e8 Ioana Ciornei         2019-05-28  1598  {
dd0c9855b41310 Russell King (Oracle  2024-04-10  1599) 	struct dsa_port *dp = dsa_phylink_to_port(config);
77373d49de22e8 Ioana Ciornei         2019-05-28  1600  	struct dsa_switch *ds = dp->ds;
77373d49de22e8 Ioana Ciornei         2019-05-28  1601  
57d77986e74287 Vladimir Oltean       2021-10-20  1602  	if (dsa_port_is_user(dp))
6ca80638b90cec Florian Fainelli      2023-10-23 @1603  		phydev = dp->user->phydev;
0e27921816ad99 Ioana Ciornei         2019-05-28  1604  
e9829e26ff2c61 Florian Fainelli      2024-04-29  1605  	if (!ds->ops->phylink_mac_link_down)
77373d49de22e8 Ioana Ciornei         2019-05-28  1606  		return;
77373d49de22e8 Ioana Ciornei         2019-05-28  1607  
77373d49de22e8 Ioana Ciornei         2019-05-28  1608  	ds->ops->phylink_mac_link_down(ds, dp->index, mode, interface);
77373d49de22e8 Ioana Ciornei         2019-05-28  1609  }
77373d49de22e8 Ioana Ciornei         2019-05-28  1610  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

