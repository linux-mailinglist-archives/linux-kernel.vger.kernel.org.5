Return-Path: <linux-kernel+bounces-23679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2258782AFF3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9270428C659
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5F432C91;
	Thu, 11 Jan 2024 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lifmaGlP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0B2E636;
	Thu, 11 Jan 2024 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704981015; x=1736517015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4hrJy3nMlZELyZXYI0OSdCP1LFkw90PNqcYzG1I5ekg=;
  b=lifmaGlPoJ0mg1SKkAYL+QFZDL8lY6vFJh5OQmymMMfIJCd9YD5PLOyE
   /9LADfoiAJFIl4cV8EzpXkRK86ZTSWCixdFPR+HIwseSr/+1EExef01y2
   jznTteg/77bGidmxLDeLfuUackia+wvOpZHjbiwRiL6H06b85Rfgz2oTJ
   jjZw711pVxoLthsG2DNAi2WqMeCxk1OPDeofoeANJxlbCEiQK0rtnaLue
   A8K4tA/BM28EdIFIji1XU8+GjhAwpx7LeTAeZtoEC6EJUADO1BA3opWD5
   loSZCdpBZnOE+Vsa5BYMvEebNTJzzyc1zwvq4IySmYv2A/Qcdb63FHV7E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="6206843"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="6206843"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 05:50:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029554128"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1029554128"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jan 2024 05:50:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNvRh-0008Ja-2J;
	Thu, 11 Jan 2024 13:50:09 +0000
Date: Thu, 11 Jan 2024 21:49:21 +0800
From: kernel test robot <lkp@intel.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next 5/5] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2220 PHY
Message-ID: <202401112120.tfRSOQJm-lkp@intel.com>
References: <20240108093702.13476-6-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108093702.13476-6-dima.fedrau@gmail.com>

Hi Dimitri,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Dimitri-Fedrau/net-phy-Add-BaseT1-auto-negotiation-constants/20240108-174130
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240108093702.13476-6-dima.fedrau%40gmail.com
patch subject: [PATCH v4 net-next 5/5] net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
config: i386-randconfig-063-20240111 (https://download.01.org/0day-ci/archive/20240111/202401112120.tfRSOQJm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240111/202401112120.tfRSOQJm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401112120.tfRSOQJm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/phy/marvell-88q2xxx.c:45:22: sparse: sparse: symbol 'mv88q222x_revb0_init_seq0' was not declared. Should it be static?
>> drivers/net/phy/marvell-88q2xxx.c:56:22: sparse: sparse: symbol 'mv88q222x_revb0_init_seq1' was not declared. Should it be static?

vim +/mv88q222x_revb0_init_seq0 +45 drivers/net/phy/marvell-88q2xxx.c

    44	
  > 45	const struct mmd_val mv88q222x_revb0_init_seq0[] = {
    46		{ MDIO_MMD_PCS, 0x8033, 0x6801 },
    47		{ MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0 },
    48		{ MDIO_MMD_PMAPMD, MDIO_CTRL1,
    49		  MDIO_CTRL1_LPOWER | MDIO_PMA_CTRL1_SPEED1000 },
    50		{ MDIO_MMD_PCS, 0xfe1b, 0x48 },
    51		{ MDIO_MMD_PCS, 0xffe4, 0x6b6 },
    52		{ MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x0 },
    53		{ MDIO_MMD_PCS, MDIO_CTRL1, 0x0 },
    54	};
    55	
  > 56	const struct mmd_val mv88q222x_revb0_init_seq1[] = {
    57		{ MDIO_MMD_PCS, 0xfe79, 0x0 },
    58		{ MDIO_MMD_PCS, 0xfe07, 0x125a },
    59		{ MDIO_MMD_PCS, 0xfe09, 0x1288 },
    60		{ MDIO_MMD_PCS, 0xfe08, 0x2588 },
    61		{ MDIO_MMD_PCS, 0xfe11, 0x1105 },
    62		{ MDIO_MMD_PCS, 0xfe72, 0x042c },
    63		{ MDIO_MMD_PCS, 0xfbba, 0xcb2 },
    64		{ MDIO_MMD_PCS, 0xfbbb, 0xc4a },
    65		{ MDIO_MMD_AN, 0x8032, 0x2020 },
    66		{ MDIO_MMD_AN, 0x8031, 0xa28 },
    67		{ MDIO_MMD_AN, 0x8031, 0xc28 },
    68		{ MDIO_MMD_PCS, 0xffdb, 0xfc10 },
    69		{ MDIO_MMD_PCS, 0xfe1b, 0x58 },
    70		{ MDIO_MMD_PCS, 0xfe79, 0x4 },
    71		{ MDIO_MMD_PCS, 0xfe5f, 0xe8 },
    72		{ MDIO_MMD_PCS, 0xfe05, 0x755c },
    73	};
    74	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

