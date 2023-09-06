Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A5979420D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbjIFRbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjIFRbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:31:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEA219A0;
        Wed,  6 Sep 2023 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694021507; x=1725557507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P7Ojj2nkB1I7IVeMxWzMpXw+Jr2i7iyNnkbN3p4MMTs=;
  b=kFYoNuGYXLu+bwvf1KfBW0CQQqI3Nyvcd/iGNd3q5I5NV6JVbCSdEmDe
   JcPMdqeqTAEOApzJdMnpyyfVJW16+sxVq076WhZHlvuczIv+RRsZxA8EB
   kWzplGu0kZ05d+ryGk/9Y+OKfweIpMT2OaPcCGapWs3T6tQnU1p8bneVT
   VNQvJw4jb/sQJ+lMU/qcC5iSfHQCS2lw7ypvR9Yvu5TXkbjodRq+9damE
   uFTDLJ3QHXmzGv800U5ua0KUNz7VeWd1vTCAitrlY+HeYDzidedpkGbod
   mg5+/QcVb87kKTB0lFEKTXJWc6WFzqiDE9pN1WW9hP+58MIk+JiEwFliB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="441111882"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="441111882"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 10:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="741642648"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="741642648"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2023 10:31:42 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdwNQ-0000Rh-1F;
        Wed, 06 Sep 2023 17:31:40 +0000
Date:   Thu, 7 Sep 2023 01:31:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kartik <kkartik@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, sumitg@nvidia.com, arnd@arndb.de,
        pshete@nvidia.com, andriy.shevchenko@linux.intel.com,
        digetx@gmail.com, petlozup@nvidia.com, windhl@126.com,
        frank.li@vivo.com, robh@kernel.org, stefank@nvidia.com,
        pdeschrijver@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 2/6] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
Message-ID: <202309070129.gFw1OFMp-lkp@intel.com>
References: <20230905125824.2947-3-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905125824.2947-3-kkartik@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kartik,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tegra/for-next]
[also build test WARNING on linus/master v6.5 next-20230906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kartik/soc-tegra-fuse-Refactor-resource-mapping/20230906-032546
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
patch link:    https://lore.kernel.org/r/20230905125824.2947-3-kkartik%40nvidia.com
patch subject: [PATCH v2 2/6] soc/tegra: fuse: Add tegra_acpi_init_apbmisc()
config: arm64-randconfig-r023-20230906 (https://download.01.org/0day-ci/archive/20230907/202309070129.gFw1OFMp-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309070129.gFw1OFMp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309070129.gFw1OFMp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/soc/tegra/fuse/tegra-apbmisc.c:133:36: warning: unused variable 'apbmisc_acpi_match' [-Wunused-const-variable]
   static const struct acpi_device_id apbmisc_acpi_match[] = {
                                      ^
   1 warning generated.


vim +/apbmisc_acpi_match +133 drivers/soc/tegra/fuse/tegra-apbmisc.c

   132	
 > 133	static const struct acpi_device_id apbmisc_acpi_match[] = {
   134		{ "NVDA2010" },
   135		{ /* sentinel */ }
   136	};
   137	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
