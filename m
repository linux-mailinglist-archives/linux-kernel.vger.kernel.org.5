Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A2C797AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245518AbjIGR6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbjIGR6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:58:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF651CE7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694109457; x=1725645457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pDtULivygmuz21qFzpXs9W9IExF112gmZhDj5Kr7DaU=;
  b=f6BLnjPVnKG9f4+c1VtVdXfmvijMdFPZi/huxrSLh2LTH42sy9f27HUf
   fw/nj5p9J7kI8/DVnr+4xJoM/dMBOV5db0nzo0HQUCwo+QSDs8GoTfc8v
   yU/l4F09LT67h/p2nNSDI4w2FR5XO+VL654Mh/VUXnDpC+VuWrIOkjduW
   6OXtIBCoaVUonC/gb2+M1mV3ldZqFiYpbfNEDcqTdfdBDxu6WwCrPqjqs
   CeWDpf1OvD8bMEYtZuADGpVyUPyrBH4R00Bx2PUESKou2eXtb0/GJdKDS
   Io5UJHN5wDqJlNChhAJoLV+ss2x8SKRAfgJDhx+ihxSaq3HkUwNyCGmF/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="367506541"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="367506541"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 00:36:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="776963647"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="776963647"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 07 Sep 2023 00:36:43 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qe9ZB-000102-0w;
        Thu, 07 Sep 2023 07:36:41 +0000
Date:   Thu, 7 Sep 2023 15:36:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     advantech.susiteam@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, wenkai.chung@advantech.com.tw,
        Susi.Driver@advantech.com, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mfd: eiois200: Add EIO-IS200 Series EC Core Driver
Message-ID: <202309071531.rvllWPZ0-lkp@intel.com>
References: <20230907031320.6814-5-advantech.susiteam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907031320.6814-5-advantech.susiteam@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-mfd/for-mfd-next]
[also build test WARNING on linus/master next-20230907]
[cannot apply to lee-mfd/for-mfd-fixes v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/advantech-susiteam-gmail-com/mfd-eiois200-Insert-EIO-IS200-core-driver-to-Kconfig/20230907-111628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
patch link:    https://lore.kernel.org/r/20230907031320.6814-5-advantech.susiteam%40gmail.com
patch subject: [PATCH 4/4] mfd: eiois200: Add EIO-IS200 Series EC Core Driver
config: i386-randconfig-014-20230907 (https://download.01.org/0day-ci/archive/20230907/202309071531.rvllWPZ0-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309071531.rvllWPZ0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309071531.rvllWPZ0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mfd/eiois200_core.c:438:5: warning: no previous prototype for 'eiois200_probe' [-Wmissing-prototypes]
     438 | int eiois200_probe(struct device *dev, unsigned int id)
         |     ^~~~~~~~~~~~~~


vim +/eiois200_probe +438 drivers/mfd/eiois200_core.c

   437	
 > 438	int eiois200_probe(struct device *dev, unsigned int id)
   439	{
   440		int  ret = 0;
   441		void __iomem *iomem;
   442	
   443		iomem = devm_ioport_map(dev, 0, EIOIS200_SUB_PNP_DATA + 1);
   444		if (!iomem)
   445			return -ENOMEM;
   446	
   447		regmap_is200 = devm_regmap_init_mmio(dev, iomem, &pnp_regmap_config);
   448		if (!regmap_is200)
   449			return -ENOMEM;
   450	
   451		eiois200_dev = devm_kzalloc(dev,
   452					    sizeof(struct eiois200_dev),
   453					    GFP_KERNEL);
   454		if (!eiois200_dev)
   455			return -ENOMEM;
   456	
   457		mutex_init(&eiois200_dev->mutex);
   458	
   459		if (eiois200_exist(dev))
   460			return -ENODEV;
   461	
   462		if (firmware_code_base(dev)) {
   463			dev_err(dev, "Chip code base check fail\n");
   464			return -EIO;
   465		}
   466	
   467		dev_set_drvdata(dev, eiois200_dev);
   468	
   469		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, susi_mfd_devs,
   470					   ARRAY_SIZE(susi_mfd_devs),
   471					   NULL, 0, NULL);
   472		if (ret)
   473			dev_err(dev, "Cannot register child devices (error = %d)\n", ret);
   474	
   475		pr_info("%s started", KBUILD_MODNAME);
   476	
   477		return 0;
   478	}
   479	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
