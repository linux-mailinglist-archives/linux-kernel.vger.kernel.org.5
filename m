Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EBF7B5678
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbjJBPUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbjJBPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:20:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE791A6;
        Mon,  2 Oct 2023 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696260007; x=1727796007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ViEnJFsAYC4Sd3hBb8pdkYegu06ey+mxuYeTKl37N9Y=;
  b=Z7d17xZ68Qzp3c+5+RK+ukt+Eq2NNnMr8MGlrDSdG8z53mmwF5nsPSiU
   6sgoHUt2Bhr8qVkM4zgK8zar8XU/45pO1siEPGhgu5pzQiRjpdhoQQMLK
   bag45KO5QHtI7RNnC5co+7XxcL2pKd1oaHSJK13nWwakGGDmM1e63c23n
   NoJFzhafGWgwKkcZIRtoKWWjJ2wIFr/cuVyxBDdaaVSgLzdYlbpEt/cTD
   D6crKkJYEGx2REN/JTi2IR7Cu6QQ2xNoM6cA/e9HtoL2k0lXAGg0DHXxZ
   qE34qyFbLyaPUiQ15ldlB5aT2QGYP/3BlTT920L4gA8gOA8qHlEp6r/kv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="381549810"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="381549810"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 08:20:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="744142194"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="744142194"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Oct 2023 08:20:02 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnKiG-00069P-0q;
        Mon, 02 Oct 2023 15:20:00 +0000
Date:   Mon, 2 Oct 2023 23:19:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Frank Rowand <frowand.list@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/2] amba: bus: Enable compile testing
Message-ID: <202310022317.qmuYgpwj-lkp@intel.com>
References: <20231002132635.2595382-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002132635.2595382-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on robh/for-next soc/for-next linus/master v6.6-rc4 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/amba-bus-Enable-compile-testing/20231002-213425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20231002132635.2595382-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v2 2/2] amba: bus: Enable compile testing
config: powerpc-randconfig-002-20231002 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231002/202310022317.qmuYgpwj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310022317.qmuYgpwj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/amba/Kconfig:4: syntax error
   drivers/amba/Kconfig:3: invalid statement
   make[3]: *** [scripts/kconfig/Makefile:77: oldconfig] Error 1 shuffle=3457451660
   make[2]: *** [Makefile:697: oldconfig] Error 2 shuffle=3457451660
   make[1]: *** [Makefile:234: __sub-make] Error 2 shuffle=3457451660
   make[1]: Target 'oldconfig' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2 shuffle=3457451660
   make: Target 'oldconfig' not remade because of errors.
--
>> drivers/amba/Kconfig:4: syntax error
   drivers/amba/Kconfig:3: invalid statement
   make[3]: *** [scripts/kconfig/Makefile:77: olddefconfig] Error 1 shuffle=3457451660
   make[2]: *** [Makefile:697: olddefconfig] Error 2 shuffle=3457451660
   make[1]: *** [Makefile:234: __sub-make] Error 2 shuffle=3457451660
   make[1]: Target 'olddefconfig' not remade because of errors.
   make: *** [Makefile:234: __sub-make] Error 2 shuffle=3457451660
   make: Target 'olddefconfig' not remade because of errors.


vim +4 drivers/amba/Kconfig

bd968d59ad1bf0 Thierry Reding 2014-07-29 @4  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
