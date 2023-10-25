Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0157D738D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjJYSt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYSt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:49:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BB1DC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 11:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698259766; x=1729795766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A920Hyiiee/QDSjMBa5FulAMIKTEKe/GTe44BYBFeTI=;
  b=NDGhkT52j8iLfwJejYhbPm6CNovN1emb7B8RLa8qJUWVGiye6+G0Y+ue
   X14TXM7S2jPbiMa4XQgchGcgxhdvZg/61/ehqdKnnswN7XF6ZfMC3fj18
   sVEhcbZkVyOkdGPJSVt57inA/+sNxIKuz038zRufNcfHFSSJ7m6Z09Zln
   k49hAtf7FoVJkot+dQjOt3Jbdo6I3ucazt9TcwRdw4yGakteB2hqnEzPq
   tOrgdHxEw0tX7KxCtmYLgmMq7fvuFtyNxHCJpdO4SErtMiaOKVTqURfyw
   pcn5okmP1+3UP44J8J0XmB2LPE2ujlz/TljahxzNSDfD8KUbajubu4Usv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="377742730"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="377742730"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:49:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="708785677"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="708785677"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2023 11:49:23 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qviwT-00096q-1N;
        Wed, 25 Oct 2023 18:49:21 +0000
Date:   Thu, 26 Oct 2023 02:48:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] genirq: Own affinity hint
Message-ID: <202310260237.0IF4S81f-lkp@intel.com>
References: <20231025141517.375378-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025141517.375378-1-jakub@cloudflare.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on linus/master v6.6-rc7 next-20231025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jakub-Sitnicki/genirq-Own-affinity-hint/20231026-001606
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20231025141517.375378-1-jakub%40cloudflare.com
patch subject: [PATCH] genirq: Own affinity hint
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20231026/202310260237.0IF4S81f-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310260237.0IF4S81f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310260237.0IF4S81f-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/irq/irqdesc.c: In function 'alloc_masks':
>> kernel/irq/irqdesc.c:79:1: warning: label 'err_effective_affinity' defined but not used [-Wunused-label]
      79 | err_effective_affinity:
         | ^~~~~~~~~~~~~~~~~~~~~~
>> kernel/irq/irqdesc.c:75:1: warning: label 'err_pending_mask' defined but not used [-Wunused-label]
      75 | err_pending_mask:
         | ^~~~~~~~~~~~~~~~


vim +/err_effective_affinity +79 kernel/irq/irqdesc.c

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
  > 79	err_effective_affinity:
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
