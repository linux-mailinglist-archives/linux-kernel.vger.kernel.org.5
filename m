Return-Path: <linux-kernel+bounces-907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C1C8147DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA57F1C233F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439A824B51;
	Fri, 15 Dec 2023 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZHRmTJV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF328E23;
	Fri, 15 Dec 2023 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702642650; x=1734178650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pUyNt8FQZR9lsKTCweECilg+l2czXPW9uXOg35IhVcI=;
  b=YZHRmTJVYjI66Nlk4rex22+xBeD+2wwCrq9LTnCVYgQecQXCT5Lz/zDQ
   rmvIT6OZWwEY6YRSRGYTwqas3Aohn3VF8MRkDZ+Ho5RsKxBmBaFS1jN+m
   HQIQLLSITu6RzUtu4yXOL8VXWS3J+yAYi4+5RWizH+TBbOxFwTPkTbG29
   bzxBtqwRWRFroXaWOsCxIDJwMfJCk2Bz8sbhwm56G80njh4j/I93KIo71
   GKFO1OL6YKZoWbL8+53n+4EqveYOc2TBZWWATMkikuDWxQQulzXHXHb4U
   vULsB2S89ayIGxF/RDQ0j5vYOQQCx7mFCwWNBAd/wPj6koGNim0rKCC3p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8682794"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="8682794"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 04:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="808949143"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="808949143"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Dec 2023 04:17:22 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rE783-0000BO-2c;
	Fri, 15 Dec 2023 12:17:19 +0000
Date: Fri, 15 Dec 2023 20:16:55 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [net-next PATCH v2 2/3] net: phy: add simple helper to return
 count of supported speeds
Message-ID: <202312152053.bbqS93v4-lkp@intel.com>
References: <20231214154906.29436-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214154906.29436-3-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phy-refactor-and-better-document-phy_speeds-function/20231215-064112
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231214154906.29436-3-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v2 2/3] net: phy: add simple helper to return count of supported speeds
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20231215/202312152053.bbqS93v4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312152053.bbqS93v4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312152053.bbqS93v4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/phy.c:239:14: warning: no previous prototype for 'phy_supported_speeds_num' [-Wmissing-prototypes]
     239 | unsigned int phy_supported_speeds_num(struct phy_device *phy)
         |              ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/phy_supported_speeds_num +239 drivers/net/phy/phy.c

   231	
   232	/**
   233	 * phy_supported_speeds_num - return the number of all speeds currently
   234	 *			      supported by a phy device
   235	 * @phy: The phy device to return supported speeds of.
   236	 *
   237	 * Description: Returns the number of supported speeds.
   238	 */
 > 239	unsigned int phy_supported_speeds_num(struct phy_device *phy)
   240	{
   241		return phy_speeds(NULL, 0, phy->supported);
   242	}
   243	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

