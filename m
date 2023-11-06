Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0AD7E1966
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 05:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjKFE1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 23:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFE1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 23:27:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D0CF2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 20:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699244822; x=1730780822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PD252Qejs/t2mZJYzo9LfdUnJhYwQm5BMpOa1cbYOGk=;
  b=jJxfkxCrcP2Oh/ghRfG3Ozg9uMmmwfSB/Ibw5Mh7CsAfE8+cFoQ5pOnK
   yqjV4eP0jGsph+80+itoH88PeM9At2H/zcFxIYOJkeUzsLOYNbnC+9ANk
   aY5WrKH5nmBOIpH9xur59V9zy+8DDpYNBlFYCdUBr/m/CD+3lDftg0t8X
   0ceSo8w7/Vg9Jyu7lRNMfnnifsKWUKlgo8GbPxUBrcfRkOsJBtb851deb
   3ztPnFTjHcOZyruMQlbZaACrWNHCKRBO6F76Ld9BrB6NF+oYF5937nHVl
   G2bpBiMHl1jHwb9ZdQpugHZHILdjPNJDJaCy4KvRZkSRsBSdKacwSKtYA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="389020987"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="389020987"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 20:27:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="755729239"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="755729239"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2023 20:26:59 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzrCT-00066S-0q;
        Mon, 06 Nov 2023 04:26:57 +0000
Date:   Mon, 6 Nov 2023 12:26:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Tai <james.tai@realtek.com>, linux-kernel@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 3/6] irqchip: Introduce RTD1319 support using the Realtek
 Common Interrupt Controller Driver
Message-ID: <202311061208.hJmxGqym-lkp@intel.com>
References: <20231102142731.2087245-4-james.tai@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102142731.2087245-4-james.tai@realtek.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on linus/master v6.6 next-20231106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Tai/dt-bindings-interrupt-controller-Add-support-for-Realtek-DHC-SoCs/20231103-074117
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20231102142731.2087245-4-james.tai%40realtek.com
patch subject: [PATCH 3/6] irqchip: Introduce RTD1319 support using the Realtek Common Interrupt Controller Driver
config: i386-randconfig-062-20231106 (https://download.01.org/0day-ci/archive/20231106/202311061208.hJmxGqym-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061208.hJmxGqym-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311061208.hJmxGqym-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/irqchip/irq-realtek-rtd1319.c:165:25: sparse: sparse: symbol 'realtek_intc_rtd1319_pm_ops' was not declared. Should it be static?

vim +/realtek_intc_rtd1319_pm_ops +165 drivers/irqchip/irq-realtek-rtd1319.c

   164	
 > 165	const struct dev_pm_ops realtek_intc_rtd1319_pm_ops = {
   166		.suspend_noirq = realtek_intc_rtd1319_suspend,
   167		.resume_noirq = realtek_intc_rtd1319_resume,
   168	};
   169	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
