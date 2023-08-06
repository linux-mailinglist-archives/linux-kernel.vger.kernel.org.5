Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B747713B0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 07:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjHFFMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 01:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFFMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 01:12:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28481FCB;
        Sat,  5 Aug 2023 22:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691298726; x=1722834726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PyntLaLBLC94wFX1lFmqWsYNfnYmddus6IUHc4nSyaM=;
  b=IOp36way2gp5NP9sHWA5N/mlFBoDEPCwlCWvT10q8oXR3S4tkGq6jgyc
   +8tK7S/tUDlO1a6r7PkWJHnoY0Mi+FpW99sCEjAgNfqhU9xTNZns0uDRM
   uydHA6uwOXDW1gqLPgX4Fr5uhm0bJCQ8zZT9vq5RcjJnMKaABa9gLyTDO
   DxQg0MYaP1Sfa5jtkm4gCJ0UW5ydE+mVmIyuMJtAL7dyhTdfzTtW5UbYS
   mpB3NRnDW2o2fJ2Ezm9kt0yaF3M7Voe91wwiircVicgR4Qi3YbhT4Ngtp
   OhB9fnPdumXeciJt9qncnF0+hAmMnb0HMFkuAABSd3b2iuD+VRSPwsj7p
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="456735977"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="456735977"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2023 22:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="730516340"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="730516340"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Aug 2023 22:12:01 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qSW3c-00042R-1b;
        Sun, 06 Aug 2023 05:12:00 +0000
Date:   Sun, 6 Aug 2023 13:11:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Da Xue <da@libre.computer>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        Da Xue <da@libre.computer>, Luke Lu <luke.lu@libre.computer>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH v2] net: phy: meson-gxl: implement
 meson_gxl_phy_resume()
Message-ID: <202308061204.L4tEEJAa-lkp@intel.com>
References: <20230804201903.1303713-1-da@libre.computer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804201903.1303713-1-da@libre.computer>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Da,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.5-rc4 next-20230804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Da-Xue/net-phy-meson-gxl-implement-meson_gxl_phy_resume/20230805-042033
base:   net-next/main
patch link:    https://lore.kernel.org/r/20230804201903.1303713-1-da%40libre.computer
patch subject: [PATCH] [PATCH v2] net: phy: meson-gxl: implement meson_gxl_phy_resume()
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230806/202308061204.L4tEEJAa-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230806/202308061204.L4tEEJAa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308061204.L4tEEJAa-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/phy/meson-gxl.c: In function 'meson_gxl_phy_resume':
>> drivers/net/phy/meson-gxl.c:139:9: error: too few arguments to function 'genphy_resume'
     139 |         genphy_resume();
         |         ^~~~~~~~~~~~~
   In file included from drivers/net/phy/meson-gxl.c:13:
   include/linux/phy.h:1794:5: note: declared here
    1794 | int genphy_resume(struct phy_device *phydev);
         |     ^~~~~~~~~~~~~


vim +/genphy_resume +139 drivers/net/phy/meson-gxl.c

   134	
   135	static int meson_gxl_phy_resume(struct phy_device *phydev)
   136	{
   137		int ret;
   138	
 > 139		genphy_resume();
   140		ret = meson_gxl_config_init(phydev);
   141		if (ret)
   142			return ret;
   143	
   144		return 0;
   145	}
   146	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
