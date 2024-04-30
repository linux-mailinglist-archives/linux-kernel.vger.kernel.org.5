Return-Path: <linux-kernel+bounces-163320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 432F18B6964
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07521F22306
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0872E13FEE;
	Tue, 30 Apr 2024 04:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLiXInXE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A87101C5;
	Tue, 30 Apr 2024 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714450875; cv=none; b=opV8hmDywBWDIY+c1TRcBseNd9qZ6sw52hxxkjDTTxBeRw3+05SE65ILs0BzeugH+1+tXc/ddKmbedg1okkrndzD6uCoi6HkkglwctW/I8+dTslO2nGKpNPsmYKAIgQugnlWD3eeKeyHV7By3XpyVGYMta0jBZEmH8G/ABo1Ncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714450875; c=relaxed/simple;
	bh=hU07u6vJ9l8n11SuyOXIdCwqdzqefxDRN0xbudc8VGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djVvk6Pt83juI5+taoX+O5Q1tap7aiWA+e3g27oC8AQVAc6DIu7FzGaruG9axB8plTN2qJ3xsfTc0/4H+Y2dvNnhQvPPY1voDEWBGRE0x0S2rAJC/ybYXna4QrEiVNGEPBjwzfb+9bdU8p+6wIFd8h6BgG0LpjgNurFlLrsl4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLiXInXE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714450873; x=1745986873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hU07u6vJ9l8n11SuyOXIdCwqdzqefxDRN0xbudc8VGU=;
  b=HLiXInXEfCRqQa1sPZoTn9JOmcJ9QsyPx8eHoW0bxzdb3qnX7T2tbuyz
   gMM9LAkRBxEz4Z/eERQEx/OwHYdtSVe+tnPCC8U26tPUfAfvslSDIB9vJ
   /xIK3ItZ7VvT1yeOe+3d6yz5bUNwoEMQlSZnc84lZ36KRs6Yv7ReodzbT
   sGCU4u1AblTMLqEfDSMnz0dkqZI2Tp44PXrbtcqXGHiosDBJdBaqGHgEC
   1b7836Uh2An5Fe5WZMEMsm7wPR2aKtP6zDzDv0pvI4byxoali9vtuidX6
   aaQAfT5VRLz8h5E81H1ZswzgdpMs1zLULkxTyrNQeFQ068wKHRlck0Mt4
   w==;
X-CSE-ConnectionGUID: uqX/zhD/TRuOG7vhLEU6hg==
X-CSE-MsgGUID: b4HJWcusQDq6yj1dbHIL1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10673500"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10673500"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 21:21:12 -0700
X-CSE-ConnectionGUID: yokDMzv5RnmqzwEuUZaCLg==
X-CSE-MsgGUID: X32MPSgDSf26GrmfvU/jqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="57197286"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Apr 2024 21:21:09 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1ezK-0007ia-2a;
	Tue, 30 Apr 2024 04:21:06 +0000
Date: Tue, 30 Apr 2024 12:20:27 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: dsa: Remove adjust_link paths
Message-ID: <202404301234.CUZfd15j-lkp@intel.com>
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240430/202404301234.CUZfd15j-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240430/202404301234.CUZfd15j-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404301234.CUZfd15j-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/dsa/port.c:1603:3: error: use of undeclared identifier 'phydev'
                   phydev = dp->user->phydev;
                   ^
   1 error generated.


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

