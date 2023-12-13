Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98E481094D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 06:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378517AbjLMFAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 00:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMFAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 00:00:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9094AB7;
        Tue, 12 Dec 2023 21:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702443614; x=1733979614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E2++cigaU5epJz8MvyaCLgexIN/en3jBO7RKWMnmda8=;
  b=hEXyEv+MaRQonEHyWV7MFR+NRwEiNjGZ/fgTwWHn6+P6o7OC+c29qq4t
   QRHdIIXDVQGFq/rOWDIh1Gohh21ZMkAlJKmx/63PHfq7M9vu16yNRJWl7
   YIuF5teDr2pybOWWprndqqLJ8TAdFeitA/7iYfW9dgi+75GkE3kdfHWOr
   8yBiENT4LWSn1FbaqL2iEaNHdLI//7416ZlC6Jj1cBONRp8vnDhJqD/Zi
   CPCeZW75VLqu6KQUWg5pBxSKE7iEIOyqcO4phj1VKnd0kA70Ee3YD+dMe
   2FeSa2JNLOccugsJ/Dgv6zOG1UjjLKhP0/r2L2dw1vu0HNUhNhyqyp9Ar
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8289894"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="8289894"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 21:00:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1105181391"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="1105181391"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2023 21:00:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDHLp-000K5V-2Q;
        Wed, 13 Dec 2023 05:00:05 +0000
Date:   Wed, 13 Dec 2023 12:59:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Harini Katakam <harini.katakam@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v5 3/3] net: phy: add support for PHY package
 MMD read/write
Message-ID: <202312131208.HLapuT6A-lkp@intel.com>
References: <20231212123743.29829-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212123743.29829-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phy-restructure-__phy_write-read_mmd-to-helper-and-phydev-user/20231212-203921
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231212123743.29829-3-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v5 3/3] net: phy: add support for PHY package MMD read/write
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231213/202312131208.HLapuT6A-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231213/202312131208.HLapuT6A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312131208.HLapuT6A-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/phy/phy-core.c:777: warning: expecting prototype for __phy_package_write_mmd(). Prototype was for phy_package_write_mmd() instead


vim +777 drivers/net/phy/phy-core.c

   757	
   758	/**
   759	 * __phy_package_write_mmd - write MMD reg relative to PHY package base addr
   760	 * @phydev: The phy_device struct
   761	 * @addr_offset: The offset to be added to PHY package base_addr
   762	 * @devad: The MMD to write to
   763	 * @regnum: The register on the MMD to write
   764	 * @val: value to write to @regnum
   765	 *
   766	 * Convenience helper for writing a register of an MMD on a given PHY
   767	 * using the PHY package base address. The base address is added to
   768	 * the addr_offset value.
   769	 *
   770	 * Same calling rules as for phy_write();
   771	 *
   772	 * NOTE: It's assumed that the entire PHY package is either C22 or C45.
   773	 */
   774	int phy_package_write_mmd(struct phy_device *phydev,
   775				  unsigned int addr_offset, int devad,
   776				  u32 regnum, u16 val)
 > 777	{
   778		struct phy_package_shared *shared = phydev->shared;
   779		int addr = shared->base_addr + addr_offset;
   780		int ret;
   781	
   782		if (addr >= PHY_MAX_ADDR)
   783			return -EIO;
   784	
   785		if (regnum > (u16)~0 || devad > 32)
   786			return -EINVAL;
   787	
   788		phy_lock_mdio_bus(phydev);
   789		ret = mmd_phy_write(phydev->mdio.bus, addr, phydev->is_c45, devad,
   790				    regnum, val);
   791		phy_unlock_mdio_bus(phydev);
   792	
   793		return ret;
   794	}
   795	EXPORT_SYMBOL(phy_package_write_mmd);
   796	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
