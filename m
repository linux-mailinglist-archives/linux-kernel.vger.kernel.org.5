Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A7760DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjGYIxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjGYIwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:52:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4352E131;
        Tue, 25 Jul 2023 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690275051; x=1721811051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HE2TjNN/Y7d6kR/2PBUoTBaoZfVqmELRWlVsIEsmyM0=;
  b=gHKqogG20HYe//0lQY7u5udKoJGvbV+T0m/Yjt5I74mrkZMZ+dwpuR1k
   7ORg64BIOuQHzzDlDR1OTQkrHWDP4riJ5O3R7zWb6gWOjo6z8sMOmmKgJ
   yRKYi31gPuORNxde6y6Psj6oRCBaJNkWR1PKmge0BlIC3vqGorHOm0Thb
   xKPLcBdO8wahvXpffLlClOZoz2xLX90jJmdndg9tyKX3kXScXytALuozv
   EmYq75mB5vuEAFb3PBNAT3P/YontdNlTEosgEGHfy1/Jrtd1Onb/c2nrv
   SWUhd1tBu1yFShwcBMjBWHUUyEqB6Qi2Ui/uNgz6in8N5LMfCMB5sW0bT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="352559195"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="352559195"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:50:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="796074092"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="796074092"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jul 2023 01:50:48 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qODkl-000ATG-10;
        Tue, 25 Jul 2023 08:50:47 +0000
Date:   Tue, 25 Jul 2023 16:49:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Tipton <quic_mdtipton@quicinc.com>, djakov@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_okukatla@quicinc.com,
        quic_viveka@quicinc.com, Mike Tipton <quic_mdtipton@quicinc.com>
Subject: Re: [PATCH 2/3] interconnect: Reintroduce icc_get()
Message-ID: <202307251608.svPOM4UC-lkp@intel.com>
References: <20230725012859.18474-3-quic_mdtipton@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725012859.18474-3-quic_mdtipton@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.5-rc3 next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Tipton/debugfs-Add-write-support-to-debugfs_create_str/20230725-093242
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20230725012859.18474-3-quic_mdtipton%40quicinc.com
patch subject: [PATCH 2/3] interconnect: Reintroduce icc_get()
config: arm-integrator_defconfig (https://download.01.org/0day-ci/archive/20230725/202307251608.svPOM4UC-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307251608.svPOM4UC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307251608.svPOM4UC-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/opp/opp.h:15,
                    from drivers/opp/core.c:23:
>> include/linux/interconnect.h:63:18: warning: no previous prototype for 'icc_get' [-Wmissing-prototypes]
      63 | struct icc_path *icc_get(struct device *dev, const char *src, const char *dst)
         |                  ^~~~~~~
--
   arm-linux-gnueabi-ld: drivers/opp/cpu.o: in function `icc_get':
>> cpu.c:(.text+0x2c8): multiple definition of `icc_get'; drivers/opp/core.o:core.c:(.text+0x2260): first defined here
   arm-linux-gnueabi-ld: drivers/opp/of.o: in function `icc_get':
   of.c:(.text+0x1b20): multiple definition of `icc_get'; drivers/opp/core.o:core.c:(.text+0x2260): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
