Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741237DDD08
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjKAHP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKAHP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:15:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945DDE4;
        Wed,  1 Nov 2023 00:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698822922; x=1730358922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YOamUtZBvPGFSqT3bJhAUQfsVZzAHn/s7THLW6Z58ac=;
  b=VSRldrmCVUGDArECpCQC9ivs+24d3vxD5FiS9uZpT5BU4Ip3LcybJEr9
   AQI+M6GAOrI4ebsEIAAV5gTCe0JrXPmzgkKLzMUJUdTdn5PfaA6z5keHr
   dF8y3sVX7wrFcWZdYG5nwlmQb+MARD6xLAWgFCOvN73DQKVFBzVstfA+y
   Csz1uVVNL/wtpMIXEde0jgb7YFoOpt8E2A3knIuoUeNn0E3AInRtl7ZNH
   lZnu4OjfEfC3rvhZzC9TyHvJN9sFvYy/or5evlcxqdqrRXgv1NVQtgt1r
   URHLRED4SWJ8GNPh4sRhoVU4U9GqJuRiMScQeVrht7tCQXio5QEZEso5h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="7075759"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="7075759"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 00:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="831280524"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="831280524"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2023 00:15:16 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qy5RZ-0000f2-2m;
        Wed, 01 Nov 2023 07:15:13 +0000
Date:   Wed, 1 Nov 2023 15:15:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        asutoshd@codeaurora.org, p.zabel@pengutronix.de
Cc:     oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com, jyanchou@realtek.com
Subject: Re: [PATCH V4][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
Message-ID: <202311011551.QtHtdWmG-lkp@intel.com>
References: <20231030062749.2840-3-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030062749.2840-3-jyanchou@realtek.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jyan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on ulf-hansson-mmc-mirror/next v6.6 next-20231031]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jyan-Chou/mmc-Add-Synopsys-DesignWare-mmc-cmdq-host-driver/20231030-144300
base:   linus/master
patch link:    https://lore.kernel.org/r/20231030062749.2840-3-jyanchou%40realtek.com
patch subject: [PATCH V4][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
config: sparc64-allyesconfig (https://download.01.org/0day-ci/archive/20231101/202311011551.QtHtdWmG-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231101/202311011551.QtHtdWmG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311011551.QtHtdWmG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mmc/host/dw_mmc_cqe.c:227:10: error: 'const struct cqhci_host_ops' has no member named 'setup_tran_desc'
     227 |         .setup_tran_desc = dw_mci_cqe_setup_tran_desc,
         |          ^~~~~~~~~~~~~~~
>> drivers/mmc/host/dw_mmc_cqe.c:227:28: error: initialization of 'int (*)(struct cqhci_host *, const union cqhci_crypto_cfg_entry *, int)' from incompatible pointer type 'void (*)(struct mmc_data *, struct cqhci_host *, u8 *, int)' {aka 'void (*)(struct mmc_data *, struct cqhci_host *, unsigned char *, int)'} [-Werror=incompatible-pointer-types]
     227 |         .setup_tran_desc = dw_mci_cqe_setup_tran_desc,
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/dw_mmc_cqe.c:227:28: note: (near initialization for 'dw_mci_cqhci_host_ops.program_key')
   In file included from include/linux/debugfs.h:16,
                    from drivers/mmc/host/dw_mmc_cqe.c:12:
   drivers/mmc/host/dw_mmc_cqe.c:96:23: warning: 'dw_mci_cqe_req_fops' defined but not used [-Wunused-const-variable=]
      96 | DEFINE_SHOW_ATTRIBUTE(dw_mci_cqe_req);
         |                       ^~~~~~~~~~~~~~
   include/linux/seq_file.h:202:37: note: in definition of macro 'DEFINE_SHOW_ATTRIBUTE'
     202 | static const struct file_operations __name ## _fops = {                 \
         |                                     ^~~~~~
   cc1: some warnings being treated as errors


vim +227 drivers/mmc/host/dw_mmc_cqe.c

   221	
   222	static const struct cqhci_host_ops dw_mci_cqhci_host_ops = {
   223		.enable = dw_mci_cqe_enable,
   224		.dumpregs = dw_mci_cqe_dumpregs,
   225		.pre_enable = dw_mci_cqe_pre_enable,
   226		.post_disable = dw_mci_cqe_post_disable,
 > 227		.setup_tran_desc = dw_mci_cqe_setup_tran_desc,
   228	};
   229	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
