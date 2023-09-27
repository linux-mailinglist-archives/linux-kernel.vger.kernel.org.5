Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66DC7B0CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjI0Tpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjI0Tpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:45:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFC5136
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695843930; x=1727379930;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QL+6Mbq6vYuX+eOp/4QYmhHnszAZ5043aOjwapjkEQ4=;
  b=RQU8CQVXYzRFuKE1NPu6UmFydh4ci+M7ZQna3dQ71JXY6EqVN1d9XEOt
   LZBOAOphMG1G01x4BCsFLurYF641AyddZnSR9JmXM5TAYoG+t/wkafJdr
   JwGOIPhlujgeowovjDzePG2bAtT7k0LKcCCDZQ3lHeMssI7BhcC4S17Pj
   JbNtenvjaG5xwI+lyPHiUGk+BqLAzkKVGN15lkVFm9OhcGAhEfas5Rrbv
   +mM59Z9Dq3ywJNasIvWLzouO/Dy+7BJTXTVytyMYWi0kaoMoz5zAtb2zY
   pHcz6DtXiMdG5iXolTjZlvRIK5CJIkFY+m9m0vmjC8OKuj3Nf8eY2By+r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="366966515"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="366966515"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 12:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="778655897"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="778655897"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 27 Sep 2023 12:45:24 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlaTK-0000ab-05;
        Wed, 27 Sep 2023 19:45:22 +0000
Date:   Thu, 28 Sep 2023 03:45:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: kernel/irq/irqdomain.c:997: warning: Function parameter or member
 'd' not described in 'irq_domain_translate_onecell'
Message-ID: <202309280333.zqeI0H4x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
commit: b01ecceaf2c0c4b3f2d24aa0adcf096ab1648253 genirq: Introduce irq_domain_translate_onecell
date:   3 years, 8 months ago
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20230928/202309280333.zqeI0H4x-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230928/202309280333.zqeI0H4x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309280333.zqeI0H4x-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/irq/irqdomain.c:105: warning: Function parameter or member 'fwnode' not described in 'irq_domain_free_fwnode'
   kernel/irq/irqdomain.c:930: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:930: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:930: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:930: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:930: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:930: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:949: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:949: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:949: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:949: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:949: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:949: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:972: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:972: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:972: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:972: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:972: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:972: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_onetwocell'
>> kernel/irq/irqdomain.c:997: warning: Function parameter or member 'd' not described in 'irq_domain_translate_onecell'
>> kernel/irq/irqdomain.c:997: warning: Function parameter or member 'fwspec' not described in 'irq_domain_translate_onecell'
>> kernel/irq/irqdomain.c:997: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_translate_onecell'
>> kernel/irq/irqdomain.c:997: warning: Function parameter or member 'out_type' not described in 'irq_domain_translate_onecell'
   kernel/irq/irqdomain.c:1018: warning: Function parameter or member 'd' not described in 'irq_domain_translate_twocell'
   kernel/irq/irqdomain.c:1018: warning: Function parameter or member 'fwspec' not described in 'irq_domain_translate_twocell'
   kernel/irq/irqdomain.c:1018: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_translate_twocell'
   kernel/irq/irqdomain.c:1018: warning: Function parameter or member 'out_type' not described in 'irq_domain_translate_twocell'
   kernel/irq/irqdomain.c:1597: warning: Function parameter or member 'domain' not described in 'irq_domain_alloc_irqs_parent'
   kernel/irq/irqdomain.c:1616: warning: Function parameter or member 'domain' not described in 'irq_domain_free_irqs_parent'


vim +997 kernel/irq/irqdomain.c

   938	
   939	/**
   940	 * irq_domain_xlate_twocell() - Generic xlate for direct two cell bindings
   941	 *
   942	 * Device Tree IRQ specifier translation function which works with two cell
   943	 * bindings where the cell values map directly to the hwirq number
   944	 * and linux irq flags.
   945	 */
   946	int irq_domain_xlate_twocell(struct irq_domain *d, struct device_node *ctrlr,
   947				const u32 *intspec, unsigned int intsize,
   948				irq_hw_number_t *out_hwirq, unsigned int *out_type)
 > 949	{
   950		struct irq_fwspec fwspec;
   951	
   952		of_phandle_args_to_fwspec(ctrlr, intspec, intsize, &fwspec);
   953		return irq_domain_translate_twocell(d, &fwspec, out_hwirq, out_type);
   954	}
   955	EXPORT_SYMBOL_GPL(irq_domain_xlate_twocell);
   956	
   957	/**
   958	 * irq_domain_xlate_onetwocell() - Generic xlate for one or two cell bindings
   959	 *
   960	 * Device Tree IRQ specifier translation function which works with either one
   961	 * or two cell bindings where the cell values map directly to the hwirq number
   962	 * and linux irq flags.
   963	 *
   964	 * Note: don't use this function unless your interrupt controller explicitly
   965	 * supports both one and two cell bindings.  For the majority of controllers
   966	 * the _onecell() or _twocell() variants above should be used.
   967	 */
   968	int irq_domain_xlate_onetwocell(struct irq_domain *d,
   969					struct device_node *ctrlr,
   970					const u32 *intspec, unsigned int intsize,
   971					unsigned long *out_hwirq, unsigned int *out_type)
 > 972	{
   973		if (WARN_ON(intsize < 1))
   974			return -EINVAL;
   975		*out_hwirq = intspec[0];
   976		if (intsize > 1)
   977			*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
   978		else
   979			*out_type = IRQ_TYPE_NONE;
   980		return 0;
   981	}
   982	EXPORT_SYMBOL_GPL(irq_domain_xlate_onetwocell);
   983	
   984	const struct irq_domain_ops irq_domain_simple_ops = {
   985		.xlate = irq_domain_xlate_onetwocell,
   986	};
   987	EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
   988	
   989	/**
   990	 * irq_domain_translate_onecell() - Generic translate for direct one cell
   991	 * bindings
   992	 */
   993	int irq_domain_translate_onecell(struct irq_domain *d,
   994					 struct irq_fwspec *fwspec,
   995					 unsigned long *out_hwirq,
   996					 unsigned int *out_type)
 > 997	{
   998		if (WARN_ON(fwspec->param_count < 1))
   999			return -EINVAL;
  1000		*out_hwirq = fwspec->param[0];
  1001		*out_type = IRQ_TYPE_NONE;
  1002		return 0;
  1003	}
  1004	EXPORT_SYMBOL_GPL(irq_domain_translate_onecell);
  1005	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
