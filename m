Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B067AF7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 03:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjI0BiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 21:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjI0BgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 21:36:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213CB46BC;
        Tue, 26 Sep 2023 17:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695775372; x=1727311372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=abfoQSPVt17fR8DX8fA1zsxuQ00F/MRzLbn6R8vvj7k=;
  b=FG4fq4NkbRWghmkBy3wRifnJDOumpeyVtljMdR7NpQdOIDF0rLZsnNS7
   FMYxH0c1W5IPAm3HmkjQah2sahyH5ZvNL8YWJDMs5UJUSP35xZoTvQuyY
   c+w8kaDkJ4Xt6Ysp/DBrpzQhA8s8L9qBNObHGPia4RSIDfCaUcYHW7VcK
   usX5Oxe90Dy9kYsYFiHDcuf6mc5kH3NfBHz4MXI712WYeY0j3wQXlptFG
   20AgQg7ge0U+KAohZwMeVi3hfGg42jweePpOdLHGX9RTFC+gaH1uN/A9F
   IgsoDNxU2d1G74X787NwMxBb8KKhtkppxqBV0VgwIqq1b6xDRoPuV7Hmn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="372030157"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="372030157"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 17:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725613690"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="725613690"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2023 17:42:48 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlIda-0003Xl-28;
        Wed, 27 Sep 2023 00:42:46 +0000
Date:   Wed, 27 Sep 2023 08:42:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sergey Khimich <serghox@gmail.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jyan Chou <jyanchou@realtek.com>
Subject: Re: [PATCH v2 1/2] mmc: cqhci: Add cqhci_set_tran_desc() callback
Message-ID: <202309270807.VoVn81m6-lkp@intel.com>
References: <20230926090242.105020-2-serghox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926090242.105020-2-serghox@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on ulf-hansson-mmc-mirror/next v6.6-rc3 next-20230926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sergey-Khimich/mmc-cqhci-Add-cqhci_set_tran_desc-callback/20230926-170331
base:   linus/master
patch link:    https://lore.kernel.org/r/20230926090242.105020-2-serghox%40gmail.com
patch subject: [PATCH v2 1/2] mmc: cqhci: Add cqhci_set_tran_desc() callback
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230927/202309270807.VoVn81m6-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230927/202309270807.VoVn81m6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309270807.VoVn81m6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/mmc/host/sdhci_am654.c:17:
>> drivers/mmc/host/cqhci.h:296:39: warning: 'struct mmc_data' declared inside parameter list will not be visible outside of this definition or declaration
     296 |         void (*prep_tran_desc)(struct mmc_data *data, struct cqhci_host *cq_host,
         |                                       ^~~~~~~~


vim +296 drivers/mmc/host/cqhci.h

   281	
   282	struct cqhci_host_ops {
   283		void (*dumpregs)(struct mmc_host *mmc);
   284		void (*write_l)(struct cqhci_host *host, u32 val, int reg);
   285		u32 (*read_l)(struct cqhci_host *host, int reg);
   286		void (*enable)(struct mmc_host *mmc);
   287		void (*disable)(struct mmc_host *mmc, bool recovery);
   288		void (*update_dcmd_desc)(struct mmc_host *mmc, struct mmc_request *mrq,
   289					 u64 *data);
   290		void (*pre_enable)(struct mmc_host *mmc);
   291		void (*post_disable)(struct mmc_host *mmc);
   292	#ifdef CONFIG_MMC_CRYPTO
   293		int (*program_key)(struct cqhci_host *cq_host,
   294				   const union cqhci_crypto_cfg_entry *cfg, int slot);
   295	#endif
 > 296		void (*prep_tran_desc)(struct mmc_data *data, struct cqhci_host *cq_host,
   297				       u8 *desc, int sg_count);
   298	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
