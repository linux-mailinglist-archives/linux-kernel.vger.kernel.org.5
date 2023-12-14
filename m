Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A45981297D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443308AbjLNHgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbjLNHgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:36:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F05110B;
        Wed, 13 Dec 2023 23:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702539406; x=1734075406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ONlWSJNAzSYCT+uKbqhUqpPs1XM4hMwqNY7A9TcTZ8=;
  b=YuMJBlNRe5EHjCD2R1Ai9+e1ALgCrsEdadvzEl2wpz+l/XKXgS8ZfT4A
   9bDGPQhqMf8linmTSDVirSlVGGYokXi04zbS9qgoDJZMe22vsKcLHZ+YA
   WgTBm8YQjbdB5QUnfQIEqI10qLT+/NE89JFxBMexc52lQhg3Y1mVwullC
   uuJGuO+YafCSYu3IEJ+pn+P/y1Ar3F/n747oAyyXMwcZa/1Cc9usgzhLu
   lxa+d/eE0vz7g/Ap+MPgOvDQzNAojhOzCsUfSvofdvnU6dqLHnbr/VzTi
   SLsAnb4Hegf2XH3MvNmXSaq6aHIKt8bULqOhIzTbbVWoDWW10IHbXjRsP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="394828037"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="394828037"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:36:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="917968618"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="917968618"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Dec 2023 23:36:41 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDgGq-000Lka-0V;
        Thu, 14 Dec 2023 07:36:36 +0000
Date:   Thu, 14 Dec 2023 15:35:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: ethtool: add define for link speed
 mode number
Message-ID: <202312141531.bEtUmIwG-lkp@intel.com>
References: <20231213181554.4741-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213181554.4741-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-ethtool-add-define-for-link-speed-mode-number/20231214-021806
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231213181554.4741-2-ansuelsmth%40gmail.com
patch subject: [net-next PATCH 1/2] net: ethtool: add define for link speed mode number
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20231214/202312141531.bEtUmIwG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312141531.bEtUmIwG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141531.bEtUmIwG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/igb/e1000_hw.h:13,
                    from drivers/net/ethernet/intel/igb/e1000_mac.h:7,
                    from drivers/net/ethernet/intel/igb/e1000_82575.c:14:
>> drivers/net/ethernet/intel/igb/e1000_defines.h:256:21: error: expected identifier before numeric constant
     256 | #define SPEED_10    10
         |                     ^~
   include/uapi/linux/ethtool.h:1888:9: note: in expansion of macro 'SPEED_10'
    1888 |         SPEED_10 = 0,
         |         ^~~~~~~~
--
   In file included from drivers/net/ethernet/intel/igc/igc_hw.h:12,
                    from drivers/net/ethernet/intel/igc/igc_base.c:6:
>> drivers/net/ethernet/intel/igc/igc_defines.h:231:33: error: expected identifier before numeric constant
     231 | #define SPEED_10                10
         |                                 ^~
   include/uapi/linux/ethtool.h:1888:9: note: in expansion of macro 'SPEED_10'
    1888 |         SPEED_10 = 0,
         |         ^~~~~~~~


vim +256 drivers/net/ethernet/intel/igb/e1000_defines.h

9d5c824399dea8 drivers/net/igb/e1000_defines.h                Auke Kok        2008-01-24  255  
9d5c824399dea8 drivers/net/igb/e1000_defines.h                Auke Kok        2008-01-24 @256  #define SPEED_10    10
9d5c824399dea8 drivers/net/igb/e1000_defines.h                Auke Kok        2008-01-24  257  #define SPEED_100   100
9d5c824399dea8 drivers/net/igb/e1000_defines.h                Auke Kok        2008-01-24  258  #define SPEED_1000  1000
ceb5f13b70cd6e drivers/net/ethernet/intel/igb/e1000_defines.h Carolyn Wyborny 2013-04-18  259  #define SPEED_2500  2500
9d5c824399dea8 drivers/net/igb/e1000_defines.h                Auke Kok        2008-01-24  260  #define HALF_DUPLEX 1
9d5c824399dea8 drivers/net/igb/e1000_defines.h                Auke Kok        2008-01-24  261  #define FULL_DUPLEX 2
9d5c824399dea8 drivers/net/igb/e1000_defines.h                Auke Kok        2008-01-24  262  
9d5c824399dea8 drivers/net/igb/e1000_defines.h                Auke Kok        2008-01-24  263  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
