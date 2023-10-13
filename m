Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE14B7C910C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjJMWxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjJMWxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:53:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CDACF;
        Fri, 13 Oct 2023 15:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697237585; x=1728773585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2C5UrgkdXJHfjfoqNAM4SPZu5C0wbXCYHnYx7Cjk8OU=;
  b=QIobGk0vrvjP9DUEc4lMNykP6fid709P0alhU4tlHcI+dizFmSG6/TOr
   PkffopnbUHRqtiiIxazBHBOpB5o9XGJhkQhER3v/IZ3trJ8ObDZwGWU7R
   ZcP4sGFk3mnnKyslB7pu3NJBBKeJrj7EDKmpt0B2zPMy9rMZCAGRsySL8
   NlpTbpkoMoevRDn15r1Gktx2zR6GShKzFeNZrVk7SVg08ugjLYs80E2P8
   igujlAk7rNMGsm/uf69M2l+B6H/MSjcI5jWvGZO/wHOVxN5adbrvWoG3p
   8pdu886R4eDkVi5yQLRTMo3PtMfaQSVjE6+wyTQi8p4NVgT4qxYLhmIB3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="388134476"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="388134476"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 15:53:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="871267063"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="871267063"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Oct 2023 15:52:57 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrR1b-0005US-1U;
        Fri, 13 Oct 2023 22:52:55 +0000
Date:   Sat, 14 Oct 2023 06:52:04 +0800
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
Subject: Re: [PATCH net-next v5 10/16] net: ethtool: Add a command to list
 available time stamping layers
Message-ID: <202310140615.H4ByVgnr-lkp@intel.com>
References: <20231009155138.86458-11-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009155138.86458-11-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20231009155138.86458-11-kory.maincent%40bootlin.com
patch subject: [PATCH net-next v5 10/16] net: ethtool: Add a command to list available time stamping layers
reproduce: (https://download.01.org/0day-ci/archive/20231014/202310140615.H4ByVgnr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310140615.H4ByVgnr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/networking/ethtool-netlink.rst:2022: WARNING: Title underline too short.

vim +2022 Documentation/networking/ethtool-netlink.rst

  2020	
  2021	TS_LIST_GET
> 2022	==========
  2023	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
