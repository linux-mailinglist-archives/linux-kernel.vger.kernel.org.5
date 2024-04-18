Return-Path: <linux-kernel+bounces-149533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7B28A9288
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BE1283716
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177296A8A0;
	Thu, 18 Apr 2024 05:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbsBlSwE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADCB55E49;
	Thu, 18 Apr 2024 05:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713418823; cv=none; b=B8aQ+M0ee1puchO5X4YmL/aat9XQd7DFsSpzfnvtwfGaQnDgGbKVLsX1fPdiyd/qU3VbihCkwdbJY0GDvUo2JdV8kMKjcpfOAcZ2M9SkH/cEn1t0cftABc+1NORWpBMrAO6DoS1RCIZ1KcEA44NRX66WCq69rEk7YRE052ZBJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713418823; c=relaxed/simple;
	bh=bTjx8rndt/PSO/6dNSTUflavw32jLsFtA0qjmagKIOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmEBwPgc4RZm8RFeK/YzvmW0kbl5w1VO7kNe3MjFJjXeUZ2U/yCRTHG7o8ba5aIAkI3LKHHjVOk8a5lmCTQMGdy1/+SP8eo2rTs9IMpBHSZlb/ziMu786965DZFGkIvDCaYIlrycCTPr5S0SlFIpy9VdqXV5MLqqHL/WQ4vtL6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbsBlSwE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713418822; x=1744954822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bTjx8rndt/PSO/6dNSTUflavw32jLsFtA0qjmagKIOI=;
  b=ZbsBlSwEXVavazRS/M4VImHj0fTs0v03gt4zG8BxnDQef9bSo7uvxxYe
   ZoWDjXjzk5VhSly+rmkivOTZW/J3Up98egaMHyPH0Koo6oyo0o1yyHEwo
   9vUaQEB8JT5DumzG7cBxhn0Rh1+dLaPzUSn3SyGcD38vo5r+0dqKk0V6K
   rEr2e2rdwlBxucVnvLXPsVH8JZydsNEU/xn41JEEgi5USsjr5LZhxt7SE
   d6tRZTtyCCjuSiQO7aqMVAiCaRJoOUemn0MdjzqxCgBueXa58BI8Yoe8w
   i4tgOexL1NnuIeMkQSD4maCsYPn/E103MaBTtHiO+EcP2d9MuFNI7H6Q0
   w==;
X-CSE-ConnectionGUID: d1HcYO+rQmK1pPkQTf93bw==
X-CSE-MsgGUID: Nlx0fj+iTS+azCAE/Nc5xA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19549964"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="19549964"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 22:40:19 -0700
X-CSE-ConnectionGUID: ofsmR+8sRcG/x+ClL/kPeQ==
X-CSE-MsgGUID: QhL2448uQ9S0pi825yf5Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="22958156"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 17 Apr 2024 22:40:14 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxKVF-0007Ls-1r;
	Thu, 18 Apr 2024 05:40:10 +0000
Date: Thu, 18 Apr 2024 13:39:33 +0800
From: kernel test robot <lkp@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v1 3/4] net: phy: realtek: provide TimeSync data
 path delays for RTL8211E
Message-ID: <202404181340.89g7TIG1-lkp@intel.com>
References: <20240417164316.1755299-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417164316.1755299-4-o.rempel@pengutronix.de>

Hi Oleksij,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleksij-Rempel/net-phy-Add-TimeSync-delay-query-support-to-PHYlib-API/20240418-004607
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240417164316.1755299-4-o.rempel%40pengutronix.de
patch subject: [PATCH net-next v1 3/4] net: phy: realtek: provide TimeSync data path delays for RTL8211E
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240418/202404181340.89g7TIG1-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240418/202404181340.89g7TIG1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404181340.89g7TIG1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/realtek.c:278:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           default:
           ^
   drivers/net/phy/realtek.c:278:2: note: insert 'break;' to avoid fall-through
           default:
           ^
           break; 
   1 warning generated.


vim +278 drivers/net/phy/realtek.c

   245	
   246	static int rtl8211e_get_timesync_data_path_delays(struct phy_device *phydev,
   247							  struct phy_timesync_delay *tsd)
   248	{
   249		phydev_warn(phydev, "Time stamping is not supported\n");
   250	
   251		switch (phydev->interface) {
   252		case PHY_INTERFACE_MODE_RGMII:
   253		case PHY_INTERFACE_MODE_RGMII_RXID:
   254		case PHY_INTERFACE_MODE_RGMII_TXID:
   255		case PHY_INTERFACE_MODE_RGMII_ID:
   256			/* The values are measured with RTL8211E and LAN8841 as link
   257			 * partners and confirmed with i211 to be in sane range.
   258			 */
   259			if (phydev->speed == SPEED_1000) {
   260				tsd->tx_min_delay_ns = 326;
   261				tsd->rx_min_delay_ns = 406;
   262				return 0;
   263			} else if (phydev->speed == SPEED_100) {
   264				tsd->tx_min_delay_ns = 703;
   265				tsd->rx_min_delay_ns = 621;
   266				return 0;
   267			} else if (phydev->speed == SPEED_10) {
   268				/* This value is suspiciously big, with atypical
   269				 * shift to Egress side. This value is confirmed
   270				 * by measuring RGMII-PHY-PHY-RGMII path delay.
   271				 * Similar results are confirmed with LAN8841 and i211
   272				 * as link partners.
   273				 */
   274				tsd->tx_min_delay_ns = 920231;
   275				tsd->rx_min_delay_ns = 1674;
   276				return 0;
   277			}
 > 278		default:
   279			break;
   280		}
   281	
   282		phydev_warn(phydev, "Not tested or not supported modes for path delay values\n");
   283	
   284		return -EOPNOTSUPP;
   285	}
   286	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

