Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68677D1C03
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjJUJVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjJUJVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:21:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8741D71
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697880061; x=1729416061;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9IscNcB6lrR9gjqVMLXZi5aYfl6rSfp6+lDv3tUFxMM=;
  b=iGREluog1H3roYh9UTHj9gV0qavNrFMvvUKGK8QHooWmL2uHzyjbVj9Q
   lVoT/a6OINZiQNMT8FK2POncDkEmVFMLt92Mwa50YOlFEQuUnYOHhpkIl
   aR0F8yX4sJXIMUJFwv4QmqZI/viY5r355uV9rk2Ght+qa5r4pND0tTnhf
   NHtzp6/1WOcw/JB8FsmsKGKaDXKQ3RJqd+arERvTPA0YAX4V+SakeSDWP
   DB6gcmKHb8EhH9yBN0xgEg+loeu16IrUpkCvnxx/NzlIjZ9oGWkuw5biK
   qcPsnN5M4XUw0+qMN45P8MEX8lXoluABawSn+kH3CRPanyw580B7aeJY7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="386433957"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="386433957"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 02:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="787014224"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="787014224"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Oct 2023 02:21:00 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qu8AD-0004gM-1s;
        Sat, 21 Oct 2023 09:20:57 +0000
Date:   Sat, 21 Oct 2023 17:20:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shannon Nelson <shannon.nelson@amd.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/amd/pds_core/dev.c:257:22: warning: '%s'
 directive output may be truncated writing up to 64 bytes into a region of
 size 23
Message-ID: <202310211736.66syyDpp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shannon,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
commit: ddbcb22055d136f58841c73ca2226dab79eb6101 pds_core: Kconfig and pds_core.rst
date:   6 months ago
config: x86_64-randconfig-r031-20230608 (https://download.01.org/0day-ci/archive/20231021/202310211736.66syyDpp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231021/202310211736.66syyDpp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310211736.66syyDpp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/amd/pds_core/dev.c: In function 'pdsc_identify':
>> drivers/net/ethernet/amd/pds_core/dev.c:257:22: warning: '%s' directive output may be truncated writing up to 64 bytes into a region of size 23 [-Wformat-truncation=]
     257 |                  "%s %s", PDS_CORE_DRV_NAME, utsname()->release);
         |                      ^~
   drivers/net/ethernet/amd/pds_core/dev.c:256:9: note: 'snprintf' output between 10 and 74 bytes into a destination of size 32
     256 |         snprintf(drv.driver_ver_str, sizeof(drv.driver_ver_str),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     257 |                  "%s %s", PDS_CORE_DRV_NAME, utsname()->release);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/net/ethernet/amd/pds_core/core.c: In function 'pdsc_qcq_alloc':
>> drivers/net/ethernet/amd/pds_core/core.c:126:45: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size between 19 and 21 [-Wformat-truncation=]
     126 |         snprintf(name, sizeof(name), "%s-%d-%s",
         |                                             ^~
   In function 'pdsc_qcq_intr_alloc',
       inlined from 'pdsc_qcq_alloc' at drivers/net/ethernet/amd/pds_core/core.c:218:8:
   drivers/net/ethernet/amd/pds_core/core.c:126:9: note: 'snprintf' output between 12 and 45 bytes into a destination of size 32
     126 |         snprintf(name, sizeof(name), "%s-%d-%s",
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     127 |                  PDS_CORE_DRV_NAME, pdsc->pdev->bus->number, qcq->q.name);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +257 drivers/net/ethernet/amd/pds_core/dev.c

523847df1b3718 Shannon Nelson 2023-04-19  248  
523847df1b3718 Shannon Nelson 2023-04-19  249  static int pdsc_identify(struct pdsc *pdsc)
523847df1b3718 Shannon Nelson 2023-04-19  250  {
523847df1b3718 Shannon Nelson 2023-04-19  251  	struct pds_core_drv_identity drv = {};
523847df1b3718 Shannon Nelson 2023-04-19  252  	size_t sz;
523847df1b3718 Shannon Nelson 2023-04-19  253  	int err;
523847df1b3718 Shannon Nelson 2023-04-19  254  
523847df1b3718 Shannon Nelson 2023-04-19  255  	drv.drv_type = cpu_to_le32(PDS_DRIVER_LINUX);
523847df1b3718 Shannon Nelson 2023-04-19  256  	snprintf(drv.driver_ver_str, sizeof(drv.driver_ver_str),
523847df1b3718 Shannon Nelson 2023-04-19 @257  		 "%s %s", PDS_CORE_DRV_NAME, utsname()->release);
523847df1b3718 Shannon Nelson 2023-04-19  258  
523847df1b3718 Shannon Nelson 2023-04-19  259  	/* Next let's get some info about the device
523847df1b3718 Shannon Nelson 2023-04-19  260  	 * We use the devcmd_lock at this level in order to
523847df1b3718 Shannon Nelson 2023-04-19  261  	 * get safe access to the cmd_regs->data before anyone
523847df1b3718 Shannon Nelson 2023-04-19  262  	 * else can mess it up
523847df1b3718 Shannon Nelson 2023-04-19  263  	 */
523847df1b3718 Shannon Nelson 2023-04-19  264  	mutex_lock(&pdsc->devcmd_lock);
523847df1b3718 Shannon Nelson 2023-04-19  265  
523847df1b3718 Shannon Nelson 2023-04-19  266  	sz = min_t(size_t, sizeof(drv), sizeof(pdsc->cmd_regs->data));
523847df1b3718 Shannon Nelson 2023-04-19  267  	memcpy_toio(&pdsc->cmd_regs->data, &drv, sz);
523847df1b3718 Shannon Nelson 2023-04-19  268  
523847df1b3718 Shannon Nelson 2023-04-19  269  	err = pdsc_devcmd_identify_locked(pdsc);
523847df1b3718 Shannon Nelson 2023-04-19  270  	if (!err) {
523847df1b3718 Shannon Nelson 2023-04-19  271  		sz = min_t(size_t, sizeof(pdsc->dev_ident),
523847df1b3718 Shannon Nelson 2023-04-19  272  			   sizeof(pdsc->cmd_regs->data));
523847df1b3718 Shannon Nelson 2023-04-19  273  		memcpy_fromio(&pdsc->dev_ident, &pdsc->cmd_regs->data, sz);
523847df1b3718 Shannon Nelson 2023-04-19  274  	}
523847df1b3718 Shannon Nelson 2023-04-19  275  	mutex_unlock(&pdsc->devcmd_lock);
523847df1b3718 Shannon Nelson 2023-04-19  276  
523847df1b3718 Shannon Nelson 2023-04-19  277  	if (err) {
523847df1b3718 Shannon Nelson 2023-04-19  278  		dev_err(pdsc->dev, "Cannot identify device: %pe\n",
523847df1b3718 Shannon Nelson 2023-04-19  279  			ERR_PTR(err));
523847df1b3718 Shannon Nelson 2023-04-19  280  		return err;
523847df1b3718 Shannon Nelson 2023-04-19  281  	}
523847df1b3718 Shannon Nelson 2023-04-19  282  
523847df1b3718 Shannon Nelson 2023-04-19  283  	if (isprint(pdsc->dev_info.fw_version[0]) &&
523847df1b3718 Shannon Nelson 2023-04-19  284  	    isascii(pdsc->dev_info.fw_version[0]))
523847df1b3718 Shannon Nelson 2023-04-19  285  		dev_info(pdsc->dev, "FW: %.*s\n",
523847df1b3718 Shannon Nelson 2023-04-19  286  			 (int)(sizeof(pdsc->dev_info.fw_version) - 1),
523847df1b3718 Shannon Nelson 2023-04-19  287  			 pdsc->dev_info.fw_version);
523847df1b3718 Shannon Nelson 2023-04-19  288  	else
523847df1b3718 Shannon Nelson 2023-04-19  289  		dev_info(pdsc->dev, "FW: (invalid string) 0x%02x 0x%02x 0x%02x 0x%02x ...\n",
523847df1b3718 Shannon Nelson 2023-04-19  290  			 (u8)pdsc->dev_info.fw_version[0],
523847df1b3718 Shannon Nelson 2023-04-19  291  			 (u8)pdsc->dev_info.fw_version[1],
523847df1b3718 Shannon Nelson 2023-04-19  292  			 (u8)pdsc->dev_info.fw_version[2],
523847df1b3718 Shannon Nelson 2023-04-19  293  			 (u8)pdsc->dev_info.fw_version[3]);
523847df1b3718 Shannon Nelson 2023-04-19  294  
523847df1b3718 Shannon Nelson 2023-04-19  295  	return 0;
523847df1b3718 Shannon Nelson 2023-04-19  296  }
523847df1b3718 Shannon Nelson 2023-04-19  297  

:::::: The code at line 257 was first introduced by commit
:::::: 523847df1b3718d6286dce0ed1c83742fe0ffa94 pds_core: add devcmd device interfaces

:::::: TO: Shannon Nelson <shannon.nelson@amd.com>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
