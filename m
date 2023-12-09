Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4089280B45D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjLIMjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjLIMjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:39:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F810C7;
        Sat,  9 Dec 2023 04:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702125561; x=1733661561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=emTJaGRWW8/RVMnzJWgGpG0OkXjrJdQ7ijyM00lmQPA=;
  b=FBIGod2hnJKpaWF15+jHxxPYCcuV7PjWWhBgx5vDA9IWSJKnFb7i8795
   c6gfzjLstQ1MUtGZafGZG/xOu89piJmQCtm5a6+/Oz21QRzvPcDKsN4uI
   LPepA4z6XBIc0cpPWrd9Eeu+Icix8O8vCKxbldC5ISugWFOn0Qn9T8naR
   GBynf9Vj3QVepx3X4h7mZWEcq3XSaHpwKvhDwzErvcbYh2q0C9MwHR9w8
   qGC3zf/c4UewF94Zu6JJuUUOs4DRXN0uQPr/x9S9gizcLb8G9hM5o5dUc
   eRCBErs8omEXzfGbjo1WfMr85xoPQCtwR5hG/+6FNZe/amA4uFDSp5iwn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="397301440"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="397301440"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 04:39:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="945698958"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="945698958"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2023 04:39:17 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBwbz-000FLx-05;
        Sat, 09 Dec 2023 12:39:15 +0000
Date:   Sat, 9 Dec 2023 20:38:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH 2/2] net: phy: at803x: add LED support for
 qca808x
Message-ID: <202312092051.FcBofskz-lkp@intel.com>
References: <20231209014828.28194-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209014828.28194-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phy-at803x-add-LED-support-for-qca808x/20231209-095014
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231209014828.28194-2-ansuelsmth%40gmail.com
patch subject: [net-next PATCH 2/2] net: phy: at803x: add LED support for qca808x
config: arm-randconfig-003-20231209 (https://download.01.org/0day-ci/archive/20231209/202312092051.FcBofskz-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312092051.FcBofskz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312092051.FcBofskz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/bitops.h:68,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from arch/arm/include/asm/div64.h:107,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:14,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/phy.h:15,
                    from drivers/net/phy/at803x.c:10:
   drivers/net/phy/at803x.c: In function 'qca808x_led_hw_control_get':
>> drivers/net/phy/at803x.c:2270:25: error: 'TRIGGER_NETDEV_LINK_2500' undeclared (first use in this function); did you mean 'TRIGGER_NETDEV_LINK_1000'?
    2270 |                 set_bit(TRIGGER_NETDEV_LINK_2500, rules);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/bitops.h:183:31: note: in definition of macro 'ATOMIC_BITOP'
     183 |         (__builtin_constant_p(nr) ? ____atomic_##name(nr, p) : _##name(nr,p))
         |                               ^~
   drivers/net/phy/at803x.c:2270:17: note: in expansion of macro 'set_bit'
    2270 |                 set_bit(TRIGGER_NETDEV_LINK_2500, rules);
         |                 ^~~~~~~
   drivers/net/phy/at803x.c:2270:25: note: each undeclared identifier is reported only once for each function it appears in
    2270 |                 set_bit(TRIGGER_NETDEV_LINK_2500, rules);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/bitops.h:183:31: note: in definition of macro 'ATOMIC_BITOP'
     183 |         (__builtin_constant_p(nr) ? ____atomic_##name(nr, p) : _##name(nr,p))
         |                               ^~
   drivers/net/phy/at803x.c:2270:17: note: in expansion of macro 'set_bit'
    2270 |                 set_bit(TRIGGER_NETDEV_LINK_2500, rules);
         |                 ^~~~~~~


vim +2270 drivers/net/phy/at803x.c

  2242	
  2243	static int qca808x_led_hw_control_get(struct phy_device *phydev, u8 index,
  2244					      unsigned long *rules)
  2245	{
  2246		u16 reg;
  2247		int val;
  2248	
  2249		if (index > 2)
  2250			return -EINVAL;
  2251	
  2252		/* Check if we have hw control enabled */
  2253		if (qca808x_led_hw_control_status(phydev, index))
  2254			return -EINVAL;
  2255	
  2256		reg = QCA808X_MMD7_LED_CTRL(index);
  2257	
  2258		val = phy_read_mmd(phydev, MDIO_MMD_AN, reg);
  2259		if (val & QCA808X_LED_TX_BLINK)
  2260			set_bit(TRIGGER_NETDEV_TX, rules);
  2261		if (val & QCA808X_LED_RX_BLINK)
  2262			set_bit(TRIGGER_NETDEV_RX, rules);
  2263		if (val & QCA808X_LED_SPEED10_ON)
  2264			set_bit(TRIGGER_NETDEV_LINK_10, rules);
  2265		if (val & QCA808X_LED_SPEED100_ON)
  2266			set_bit(TRIGGER_NETDEV_LINK_100, rules);
  2267		if (val & QCA808X_LED_SPEED1000_ON)
  2268			set_bit(TRIGGER_NETDEV_LINK_1000, rules);
  2269		if (val & QCA808X_LED_SPEED2500_ON)
> 2270			set_bit(TRIGGER_NETDEV_LINK_2500, rules);
  2271		if (val & QCA808X_LED_HALF_DUPLEX_ON)
  2272			set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
  2273		if (val & QCA808X_LED_FULL_DUPLEX_ON)
  2274			set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
  2275	
  2276		return 0;
  2277	}
  2278	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
