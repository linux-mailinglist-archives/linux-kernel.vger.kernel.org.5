Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8037C7B3B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 03:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJMBiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 21:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMBix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 21:38:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0345FBB;
        Thu, 12 Oct 2023 18:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697161132; x=1728697132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PVBal4Ud504RnPl1p/A+A7FV7TwvMJzp6ahO+CuDunM=;
  b=Hp5VrZDtB2Cozp7ahJb+Sp1OzHnuQcoYy4HiKFPhVwRty6Hj9sPqTaYp
   dKjSYuJQrXUKysq+9PANgvqNv2nBTOPD2h9uFQuodpdf2ZXi5fiiRV54Q
   8okQVAsQ+7dgCa0H+itfznPif44HylcJIE8UfX4AD+mkYtGFHBnE6Mtzv
   cAy5S3rnVFpT0xqaJ69UCRF8omk9VNlTdncfGQOPtJb1kGDe/oCYE+0dg
   ZPsd2zk2WIdPlnyNcNo4Yc87nAFpnAA/Pi3svyOvsVy1aUOcR6Uz36WBb
   tcUBdVsJ8SlmBXVDB1UGob8QbYWdCq/Zgf28bEJE3t/8uNpgE7jsUoViO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="364446500"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="364446500"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 18:38:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="783946831"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="783946831"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2023 18:38:44 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qr78Q-0004Br-1m;
        Fri, 13 Oct 2023 01:38:39 +0000
Date:   Fri, 13 Oct 2023 09:37:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next v5 13/16] net: Change the API of PHY default
 timestamp to MAC
Message-ID: <202310130914.kppQjKFp-lkp@intel.com>
References: <20231009155138.86458-14-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009155138.86458-14-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Köry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/K-ry-Maincent/net-Convert-PHYs-hwtstamp-callback-to-use-kernel_hwtstamp_config/20231009-235451
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231009155138.86458-14-kory.maincent%40bootlin.com
patch subject: [PATCH net-next v5 13/16] net: Change the API of PHY default timestamp to MAC
config: i386-randconfig-063-20231012 (https://download.01.org/0day-ci/archive/20231013/202310130914.kppQjKFp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231013/202310130914.kppQjKFp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310130914.kppQjKFp-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/phy/phy_device.c:1419:12: sparse: sparse: symbol 'phy_timestamping_allowlist' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
