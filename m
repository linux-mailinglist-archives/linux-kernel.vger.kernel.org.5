Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985E47D82BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344897AbjJZMf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjJZMfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:35:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0667C0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698323722; x=1729859722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DIoPWLtOcqdIwIafgzx4Ooxy9UjJ9SD+sC1FwI6+syE=;
  b=NznW7srQn3/MdZ/iFFbhZYrXW4XDKmtAk82nHFMN4NdR4qzZfSSOJ/Kh
   Qfb0XQHCsgoQ6eM1eOoux/xSFtDyFcVtRD7t5XJVjNcLIV5hTVbB//9rd
   QS8LMeAYmZzncinKDRwUOF95HkjMyMoWCeVTcca/895kj8n3sNqQwPF+r
   tXbfUHeaIy2y7/7BKgaMdc5gwNt0SHfDnw6ikCJxlHu721DD9wONG9R2e
   /B9vTaZ4GdBEwlUQTqbmrphA4MdL82XYJbrvNfoKmc2B+8T5oqFm06Rkw
   LFrnI4S7CWFg0CsnP+F3GoBcoGISJJIl+pCEBgG4xpOCgW2he32v9owNM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="384735857"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="384735857"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:35:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1006368162"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="1006368162"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Oct 2023 05:35:20 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvza2-0009md-1T;
        Thu, 26 Oct 2023 12:35:18 +0000
Date:   Thu, 26 Oct 2023 20:34:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] genirq: Own affinity hint
Message-ID: <202310262054.v57mGz1Z-lkp@intel.com>
References: <20231025141517.375378-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025141517.375378-1-jakub@cloudflare.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on linus/master v6.6-rc7 next-20231026]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Sitnicki/genirq-Own-affinity-hint/20231026-001606
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20231025141517.375378-1-jakub%40cloudflare.com
patch subject: [PATCH] genirq: Own affinity hint
config: mips-malta_kvm_defconfig (https://download.01.org/0day-ci/archive/20231026/202310262054.v57mGz1Z-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310262054.v57mGz1Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310262054.v57mGz1Z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/irq/irqdesc.c:75:1: warning: unused label 'err_pending_mask' [-Wunused-label]
   err_pending_mask:
   ^~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/err_pending_mask +75 kernel/irq/irqdesc.c

    68	
    69	#ifdef CONFIG_GENERIC_PENDING_IRQ
    70		if (!zalloc_cpumask_var_node(&desc->pending_mask, GFP_KERNEL, node))
    71			goto err_pending_mask;
    72	#endif
    73		return 0;
    74	
  > 75	err_pending_mask:
    76	#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
    77		free_cpumask_var(desc->irq_common_data.effective_affinity);
    78	#endif
    79	err_effective_affinity:
    80		free_cpumask_var(desc->irq_common_data.affinity_hint);
    81	err_affinity_hint:
    82		free_cpumask_var(desc->irq_common_data.affinity);
    83	err_affinity:
    84		return -ENOMEM;
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
