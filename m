Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11FB7FF909
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346726AbjK3SFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346700AbjK3SFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:05:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF53F10EA;
        Thu, 30 Nov 2023 10:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701367536; x=1732903536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NHcq8r0ujAMVjVSz+Sfa4tzu6xFi8PFYYoULDY5G8d8=;
  b=hbLev35n3bW0j65o3hivoxxzDMTgq6fo7y3ZhoUExDySpjfPrz46e+Td
   kJ/HYV3jifQZyGuF+B6kNl1dpYsKj7uPEaNuO678lOnwmDaIlQbCavvPQ
   hfcl+1CSvsiMzfI2LYLNUfCSea9wAx2I9IXft3HT1WZpswqoaKZE3D0q8
   GFMTjsIjpsft0OIN3GLjoOYhpiFaZ7GSRnX75htCOaaeaWMQC8KedcNG1
   h+/UPbbImzmBSeFB1d5baqXV1Ayj6A0vg1MuhYN/bAuAU/ftuAmMZbBGu
   dhaITHhyKLuOB9fQNFyUhgF+Ah33vbNGHjarXnWUuohYyreKxiad7XNQ9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="396174991"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="396174991"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 10:05:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="887327390"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="887327390"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 30 Nov 2023 10:05:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8lPk-0002Vo-04;
        Thu, 30 Nov 2023 18:05:28 +0000
Date:   Fri, 1 Dec 2023 02:04:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shengyang Chen <shengyang.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de,
        minda.chen@starfivetech.com, changhuang.liang@starfivetech.com,
        rogerq@kernel.org, geert+renesas@glider.be,
        keith.zhao@starfivetech.com, shengyang.chen@starfivetech.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] phy: starfive: Add mipi dphy tx support
Message-ID: <202312010130.u41enWR4-lkp@intel.com>
References: <20231117130421.79261-3-shengyang.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117130421.79261-3-shengyang.chen@starfivetech.com>
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

Hi Shengyang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.7-rc3 next-20231130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shengyang-Chen/dt-bindings-phy-Add-starfive-jh7110-dphy-tx/20231117-210751
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231117130421.79261-3-shengyang.chen%40starfivetech.com
patch subject: [PATCH v1 2/2] phy: starfive: Add mipi dphy tx support
config: csky-randconfig-r111-20231118 (https://download.01.org/0day-ci/archive/20231201/202312010130.u41enWR4-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231201/202312010130.u41enWR4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312010130.u41enWR4-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:189:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:189:40: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:189:40: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:197:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:197:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:197:30: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:222:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:222:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:222:30: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:224:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:224:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:224:30: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:226:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:226:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:226:30: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:228:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:228:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:228:30: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:230:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:230:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:230:30: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:232:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:232:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:232:30: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:234:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:234:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:234:30: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:236:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:236:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:236:30: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:238:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:238:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:238:30: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:240:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:240:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:240:30: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:250:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:250:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:250:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:254:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:254:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:254:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:260:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:260:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:260:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:263:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:263:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:263:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:266:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:266:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:266:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:269:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:269:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:269:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:272:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:272:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:272:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:276:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:276:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:276:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:279:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:279:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:279:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:282:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:282:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:282:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:286:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:286:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:286:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:289:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:289:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:289:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:292:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:292:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:292:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:295:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:295:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:295:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:298:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:298:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:298:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:302:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:302:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:302:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:306:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:306:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:306:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:310:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:310:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:310:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:314:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:314:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:314:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:318:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:318:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:318:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:322:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:322:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:322:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:326:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:326:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:326:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:330:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:330:46: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:330:46: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:348:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:348:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:348:30: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:350:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:350:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:350:30: sparse:     got void [noderef] __iomem *topsys
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:353:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *io_addr @@     got void [noderef] __iomem *topsys @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:353:30: sparse:     expected void *io_addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:353:30: sparse:     got void [noderef] __iomem *topsys
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:172:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *io_addr @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:172:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:172:15: sparse:     got void *io_addr
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:181:15: sparse:     got void *
>> drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/phy/starfive/phy-jh7110-dphy-tx.c:184:9: sparse:     got void *

vim +189 drivers/phy/starfive/phy-jh7110-dphy-tx.c

   167	
   168	static inline u32 stf_dphy_get_reg(void *io_addr, u32 addr, u32 shift, u32 mask)
   169	{
   170		u32 tmp;
   171	
 > 172		tmp = readl(io_addr);
   173		tmp = (tmp & mask) >> shift;
   174		return tmp;
   175	}
   176	
   177	static inline void stf_dphy_set_reg(void *io_addr, u32 addr, u32 data, u32 shift, u32 mask)
   178	{
   179		u32 tmp;
   180	
 > 181		tmp = readl(io_addr + addr);
   182		tmp &= ~mask;
   183		tmp |= (data << shift) & mask;
 > 184		writel(tmp, (io_addr + addr));
   185	}
   186	
   187	static int is_pll_locked(struct stf_dphy *dphy)
   188	{
 > 189		int tmp = stf_dphy_get_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(8),
   190					  STF_DPHY_RGS_CDTX_PLL_UNLOCK_SHIFT,
   191					  STF_DPHY_RGS_CDTX_PLL_UNLOCK_MASK);
   192		return !tmp;
   193	}
   194	
   195	static void stf_dphy_hw_reset(struct stf_dphy *dphy, int assert)
   196	{
   197		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(100),
   198				 !assert, STF_DPHY_RESETB_SHIFT, STF_DPHY_RESETB_MASK);
   199	
   200		if (!assert) {
   201			/*the lock-in time of pll of M31 is 20us-50ms*/
   202			while ((!is_pll_locked(dphy)) && msecs_to_jiffies(50))
   203				;
   204			dev_err(dphy->dev, "MIPI dphy-tx # PLL Locked\n");
   205		}
   206	}
   207	
   208	static int stf_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
   209	{
   210		struct stf_dphy *dphy;
   211		u32 bitrate;
   212		unsigned long alignment;
   213		int i;
   214		const struct m31_dphy_config *p;
   215		const u32 STF_DPHY_AON_POWER_READY_N_active = 0;
   216		const struct stf_dphy_info *info;
   217	
   218		dphy = phy_get_drvdata(phy);
   219		info = dphy->info;
   220		bitrate = opts->mipi_dphy.hs_clk_rate;
   221	
   222		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(8), 0x10,
   223				 STF_DPHY_RG_CDTX_L0N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L0N_HSTX_RES_MASK);
   224		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
   225				 STF_DPHY_RG_CDTX_L0N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L0N_HSTX_RES_MASK);
   226		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
   227				 STF_DPHY_RG_CDTX_L2N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L2N_HSTX_RES_MASK);
   228		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
   229				 STF_DPHY_RG_CDTX_L3N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L3N_HSTX_RES_MASK);
   230		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(16), 0x10,
   231				 STF_DPHY_RG_CDTX_L4N_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L4N_HSTX_RES_MASK);
   232		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(8), 0x10,
   233				 STF_DPHY_RG_CDTX_L0P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L0P_HSTX_RES_MASK);
   234		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
   235				 STF_DPHY_RG_CDTX_L1P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L1P_HSTX_RES_MASK);
   236		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
   237				 STF_DPHY_RG_CDTX_L2P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L2P_HSTX_RES_MASK);
   238		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(12), 0x10,
   239				 STF_DPHY_RG_CDTX_L3P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L3P_HSTX_RES_MASK);
   240		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(16), 0x10,
   241				 STF_DPHY_RG_CDTX_L4P_HSTX_RES_SHIFT, STF_DPHY_RG_CDTX_L4P_HSTX_RES_MASK);
   242	
   243		alignment = STF_DPHY_BITRATE_ALIGN;
   244		if (bitrate % alignment)
   245			bitrate += alignment - (bitrate % alignment);
   246	
   247		p = m31_dphy_configs;
   248		for (i = 0; i < ARRAY_SIZE(m31_dphy_configs); i++, p++) {
   249			if (p->bitrate == bitrate) {
   250				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(100),
   251						 STF_DPHY_REFCLK_12M, STF_DPHY_REFCLK_IN_SEL_SHIFT,
   252						 STF_DPHY_REFCLK_IN_SEL_MASK);
   253	
   254				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0),
   255						 STF_DPHY_AON_POWER_READY_N_active,
   256						 STF_DPHY_AON_POWER_READY_N_SHIFT,
   257						 STF_DPHY_AON_POWER_READY_N_MASK);
   258	
   259				/*Lane setting*/
   260				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[0],
   261						 STF_DPHY_CFG_L0_SWAP_SEL_SHIFT,
   262						 STF_DPHY_CFG_L0_SWAP_SEL_MASK);
   263				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[1],
   264						 STF_DPHY_CFG_L1_SWAP_SEL_SHIFT,
   265						 STF_DPHY_CFG_L1_SWAP_SEL_MASK);
   266				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[2],
   267						 STF_DPHY_CFG_L2_SWAP_SEL_SHIFT,
   268						 STF_DPHY_CFG_L2_SWAP_SEL_MASK);
   269				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[3],
   270						 STF_DPHY_CFG_L3_SWAP_SEL_SHIFT,
   271						 STF_DPHY_CFG_L3_SWAP_SEL_MASK);
   272				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(0), info->maps[4],
   273						 STF_DPHY_CFG_L4_SWAP_SEL_SHIFT,
   274						 STF_DPHY_CFG_L4_SWAP_SEL_MASK);
   275				/*PLL setting*/
   276				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(28), 0x0,
   277						 STF_DPHY_RG_CDTX_PLL_SSC_EN_SHIFT,
   278						 STF_DPHY_RG_CDTX_PLL_SSC_EN_MASK);
   279				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(24), 0x1,
   280						 STF_DPHY_RG_CDTX_PLL_LDO_STB_X2_EN_SHIFT,
   281						 STF_DPHY_RG_CDTX_PLL_LDO_STB_X2_EN_MASK);
   282				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(24), 0x1,
   283						 STF_DPHY_RG_CDTX_PLL_FM_EN_SHIFT,
   284						 STF_DPHY_RG_CDTX_PLL_FM_EN_MASK);
   285	
   286				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(24),
   287						 p->pll_prev_div, STF_DPHY_RG_CDTX_PLL_PRE_DIV_SHIFT,
   288						 STF_DPHY_RG_CDTX_PLL_PRE_DIV_MASK);
   289				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(24),
   290						 p->pll_fbk_int, STF_DPHY_RG_CDTX_PLL_FBK_INT_SHIFT,
   291						 STF_DPHY_RG_CDTX_PLL_FBK_INT_MASK);
   292				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(20),
   293						 p->pll_fbk_fra, STF_DPHY_RG_CDTX_PLL_FBK_FRA_SHIFT,
   294						 STF_DPHY_RG_CDTX_PLL_FBK_FRA_MASK);
   295				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(40),
   296						 p->extd_cycle_sel, STF_DPHY_RG_EXTD_CYCLE_SEL_SHIFT,
   297						 STF_DPHY_RG_EXTD_CYCLE_SEL_MASK);
   298				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
   299						 p->dlane_hs_pre_time,
   300						 STF_DPHY_RG_DLANE_HS_PRE_TIME_SHIFT,
   301						 STF_DPHY_RG_DLANE_HS_PRE_TIME_MASK);
   302				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
   303						 p->dlane_hs_pre_time,
   304						 STF_DPHY_RG_DLANE_HS_PRE_TIME_SHIFT,
   305						 STF_DPHY_RG_DLANE_HS_PRE_TIME_MASK);
   306				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
   307						 p->dlane_hs_zero_time,
   308						 STF_DPHY_RG_DLANE_HS_ZERO_TIME_SHIFT,
   309						 STF_DPHY_RG_DLANE_HS_ZERO_TIME_MASK);
   310				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
   311						 p->dlane_hs_trail_time,
   312						 STF_DPHY_RG_DLANE_HS_TRAIL_TIME_SHIFT,
   313						 STF_DPHY_RG_DLANE_HS_TRAIL_TIME_MASK);
   314				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(32),
   315						 p->clane_hs_pre_time,
   316						 STF_DPHY_RG_CLANE_HS_PRE_TIME_SHIFT,
   317						 STF_DPHY_RG_CLANE_HS_PRE_TIME_MASK);
   318				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(36),
   319						 p->clane_hs_zero_time,
   320						 STF_DPHY_RG_CLANE_HS_ZERO_TIME_SHIFT,
   321						 STF_DPHY_RG_CLANE_HS_ZERO_TIME_MASK);
   322				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(32),
   323						 p->clane_hs_trail_time,
   324						 STF_DPHY_RG_CLANE_HS_TRAIL_TIME_SHIFT,
   325						 STF_DPHY_RG_CLANE_HS_TRAIL_TIME_MASK);
   326				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(32),
   327						 p->clane_hs_clk_pre_time,
   328						 STF_DPHY_RG_CLANE_HS_CLK_PRE_TIME_SHIFT,
   329						 STF_DPHY_RG_CLANE_HS_CLK_PRE_TIME_MASK);
   330				stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(32),
   331						 p->clane_hs_clk_post_time,
   332						 STF_DPHY_RG_CLANE_HS_CLK_POST_TIME_SHIFT,
   333						 STF_DPHY_RG_CLANE_HS_CLK_POST_TIME_MASK);
   334	
   335				break;
   336			}
   337		}
   338	
   339		return 0;
   340	}
   341	
   342	static int stf_dphy_init(struct phy *phy)
   343	{
   344		struct stf_dphy *dphy = phy_get_drvdata(phy);
   345		int ret;
   346	
   347		stf_dphy_hw_reset(dphy, 0);
 > 348		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(48), 0,
   349				 STF_DPHY_SCFG_PPI_C_READY_SEL_SHIFT, STF_DPHY_SCFG_PPI_C_READY_SEL_MASK);
 > 350		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(48), 0,
   351				 STF_DPHY_SCFG_DSI_TXREADY_ESC_SEL_SHIFT,
   352				 STF_DPHY_SCFG_DSI_TXREADY_ESC_SEL_MASK);
 > 353		stf_dphy_set_reg(dphy->topsys, STF_DPHY_APBIFSAIF_SYSCFG(44), 0x30,
   354				 STF_DPHY_SCFG_C_HS_PRE_ZERO_TIME_SHIFT,
   355				 STF_DPHY_SCFG_C_HS_PRE_ZERO_TIME_MASK);
   356	
   357		ret = clk_prepare_enable(dphy->txesc_clk);
   358		if (ret) {
   359			dev_err(dphy->dev, "Failed to prepare/enable txesc_clk\n");
   360			return ret;
   361		}
   362	
   363		ret = reset_control_deassert(dphy->sys_rst);
   364		if (ret) {
   365			dev_err(dphy->dev, "Failed to deassert sys_rst\n");
   366			return ret;
   367		}
   368	
   369		ret = reset_control_deassert(dphy->txbytehs_rst);
   370		if (ret < 0) {
   371			dev_err(dphy->dev, "Failed to deassert txbytehs_rst\n");
   372			return ret;
   373		}
   374	
   375		return 0;
   376	}
   377	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
