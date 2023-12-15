Return-Path: <linux-kernel+bounces-953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F78814872
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F2E1F23BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FE82DB7F;
	Fri, 15 Dec 2023 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaN8Ko8S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300BC2C6AB;
	Fri, 15 Dec 2023 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702644687; x=1734180687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IXxi6ICpVIOD8cotQkNPnEsduzVGrflHgp1nX0wIlyY=;
  b=KaN8Ko8SWvg9Rve1AZ6bipcZ/c3imoV3SO6nJ1UV//Qjd/bn1irm1S9K
   /M9O+m0ybA4RWurkwHgKv0ht/4/3YMTohZUMbDAwbhsrzo66gteoNEOD2
   QOB28H+dDT3wlYdxeeGjyeL99skmf9LIQiTIfmpM+Q/0uLWP2RCzeTpL3
   ji0g02oRudgcgoBlZbG3rOAbt+ryXDniqUCEaYzATi4Qs7qfAM68cDGu+
   rmmpCFskDkwXeODklIBSO6RqIb21OoHxR0uFyZj3a85bXBlmdHMwB6gg6
   +hGbefIJ7dMMtGt3nW8jjAeCmLRFbzWPSDsgi65CJLXfiVFXp4XzybRU3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="380266706"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="380266706"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 04:51:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="898128674"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="898128674"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Dec 2023 04:51:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rE7ey-0000DS-2w;
	Fri, 15 Dec 2023 12:51:20 +0000
Date: Fri, 15 Dec 2023 20:50:30 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [net-next PATCH v2 3/3] net: phy: led: dynamically allocate
 speed modes array
Message-ID: <202312152044.iRWfyQXJ-lkp@intel.com>
References: <20231214154906.29436-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214154906.29436-4-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/net-phy-refactor-and-better-document-phy_speeds-function/20231215-064112
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231214154906.29436-4-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v2 3/3] net: phy: led: dynamically allocate speed modes array
config: arm-randconfig-003-20231215 (https://download.01.org/0day-ci/archive/20231215/202312152044.iRWfyQXJ-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312152044.iRWfyQXJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312152044.iRWfyQXJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/phy/phy_led_triggers.c:89:30: error: implicit declaration of function 'phy_supported_speeds_num' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           phy->phy_num_led_triggers = phy_supported_speeds_num(phy);
                                       ^
   drivers/net/phy/phy_led_triggers.c:89:30: note: did you mean 'phy_supported_speeds'?
   include/linux/phy.h:208:14: note: 'phy_supported_speeds' declared here
   unsigned int phy_supported_speeds(struct phy_device *phy,
                ^
>> drivers/net/phy/phy_led_triggers.c:133:2: error: implicitly declaring library function 'free' with type 'void (void *)' [-Werror,-Wimplicit-function-declaration]
           free(speeds);
           ^
   drivers/net/phy/phy_led_triggers.c:133:2: note: include the header <stdlib.h> or explicitly provide a declaration for 'free'
   2 errors generated.


vim +/phy_supported_speeds_num +89 drivers/net/phy/phy_led_triggers.c

    83	
    84	int phy_led_triggers_register(struct phy_device *phy)
    85	{
    86		unsigned int *speeds;
    87		int i, err;
    88	
  > 89		phy->phy_num_led_triggers = phy_supported_speeds_num(phy);
    90		if (!phy->phy_num_led_triggers)
    91			return 0;
    92	
    93		speeds = kmalloc_array(phy->phy_num_led_triggers, sizeof(*speeds),
    94				       GFP_KERNEL);
    95		if (!speeds)
    96			return -ENOMEM;
    97	
    98		/* Presence of speed modes already checked up */
    99		phy_supported_speeds(phy, speeds, phy->phy_num_led_triggers);
   100	
   101		phy->led_link_trigger = devm_kzalloc(&phy->mdio.dev,
   102						     sizeof(*phy->led_link_trigger),
   103						     GFP_KERNEL);
   104		if (!phy->led_link_trigger) {
   105			err = -ENOMEM;
   106			goto out_clear;
   107		}
   108	
   109		err = phy_led_trigger_register(phy, phy->led_link_trigger, 0, "link");
   110		if (err)
   111			goto out_free_link;
   112	
   113		phy->phy_led_triggers = devm_kcalloc(&phy->mdio.dev,
   114						    phy->phy_num_led_triggers,
   115						    sizeof(struct phy_led_trigger),
   116						    GFP_KERNEL);
   117		if (!phy->phy_led_triggers) {
   118			err = -ENOMEM;
   119			goto out_unreg_link;
   120		}
   121	
   122		for (i = 0; i < phy->phy_num_led_triggers; i++) {
   123			err = phy_led_trigger_register(phy, &phy->phy_led_triggers[i],
   124						       speeds[i],
   125						       phy_speed_to_str(speeds[i]));
   126			if (err)
   127				goto out_unreg;
   128		}
   129	
   130		phy->last_triggered = NULL;
   131		phy_led_trigger_change_speed(phy);
   132	
 > 133		free(speeds);
   134	
   135		return 0;
   136	out_unreg:
   137		while (i--)
   138			phy_led_trigger_unregister(&phy->phy_led_triggers[i]);
   139		devm_kfree(&phy->mdio.dev, phy->phy_led_triggers);
   140	out_unreg_link:
   141		phy_led_trigger_unregister(phy->led_link_trigger);
   142	out_free_link:
   143		devm_kfree(&phy->mdio.dev, phy->led_link_trigger);
   144		phy->led_link_trigger = NULL;
   145	out_clear:
   146		free(speeds);
   147		phy->phy_num_led_triggers = 0;
   148		return err;
   149	}
   150	EXPORT_SYMBOL_GPL(phy_led_triggers_register);
   151	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

