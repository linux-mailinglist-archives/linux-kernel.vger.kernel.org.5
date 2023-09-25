Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE6B7ACEC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 05:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjIYDwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 23:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIYDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:52:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9CDDF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695613913; x=1727149913;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c2nsTQabWIZSoymMtO1lsyYjHA+lqbzHR4igcmf5WPs=;
  b=Kx/ed6EtsXXj89w2EzZAkAo63+O+Ie0TzzYIpDOVDyFQQInv4/nZE4zF
   n3nhSHhvCX5KiJ4zn5dqzx5Bz5O9HnITAbWHPhQY1t2EkOI91yJFmbPKx
   yHlYX2+AbYXzHcd6bSpbyHHpnnh7CJxocDU/7uKPhrPvDjBRqYixxoQpX
   v0xg1VEu6ZfikooQScWTUU8Bm7/4hZeZAwZFaWxyzkisjghNF1qwJFPkt
   HBz0XIlyQ5EPXkTRxECM0ZkcVHiab4zU+fg49Lf4LVDSDWwProWT1Aasy
   pSXKXxhr/48wdrLZA5IQ5hKSu+Is1JoNoB7KEd/IIx9Yei9FS+c65+p41
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447646289"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="447646289"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 20:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="863714553"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="863714553"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2023 20:51:51 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkcdR-0001A9-0M;
        Mon, 25 Sep 2023 03:51:49 +0000
Date:   Mon, 25 Sep 2023 11:51:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Brian Masney <masneyb@onstation.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: kernel/irq/irqdomain.c:985: warning: Function parameter or member
 'd' not described in 'irq_domain_translate_twocell'
Message-ID: <202309251106.wRRxZioD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6465e260f48790807eef06b583b38ca9789b6072
commit: b5c231d8c8037f63d34199ea1667bbe1cd9f940f genirq: introduce irq_domain_translate_twocell
date:   4 years, 7 months ago
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20230925/202309251106.wRRxZioD-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230925/202309251106.wRRxZioD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309251106.wRRxZioD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/irq/irqdomain.c:104: warning: Function parameter or member 'fwnode' not described in 'irq_domain_free_fwnode'
   kernel/irq/irqdomain.c:914: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:914: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:914: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:914: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:914: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:914: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:933: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:933: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:933: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:933: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:933: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:933: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:956: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:956: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:956: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:956: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:956: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:956: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_onetwocell'
>> kernel/irq/irqdomain.c:985: warning: Function parameter or member 'd' not described in 'irq_domain_translate_twocell'
>> kernel/irq/irqdomain.c:985: warning: Function parameter or member 'fwspec' not described in 'irq_domain_translate_twocell'
>> kernel/irq/irqdomain.c:985: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_translate_twocell'
>> kernel/irq/irqdomain.c:985: warning: Function parameter or member 'out_type' not described in 'irq_domain_translate_twocell'
   kernel/irq/irqdomain.c:1564: warning: Function parameter or member 'domain' not described in 'irq_domain_alloc_irqs_parent'
   kernel/irq/irqdomain.c:1583: warning: Function parameter or member 'domain' not described in 'irq_domain_free_irqs_parent'


vim +985 kernel/irq/irqdomain.c

   922	
   923	/**
   924	 * irq_domain_xlate_twocell() - Generic xlate for direct two cell bindings
   925	 *
   926	 * Device Tree IRQ specifier translation function which works with two cell
   927	 * bindings where the cell values map directly to the hwirq number
   928	 * and linux irq flags.
   929	 */
   930	int irq_domain_xlate_twocell(struct irq_domain *d, struct device_node *ctrlr,
   931				const u32 *intspec, unsigned int intsize,
   932				irq_hw_number_t *out_hwirq, unsigned int *out_type)
 > 933	{
   934		struct irq_fwspec fwspec;
   935	
   936		of_phandle_args_to_fwspec(ctrlr, intspec, intsize, &fwspec);
   937		return irq_domain_translate_twocell(d, &fwspec, out_hwirq, out_type);
   938	}
   939	EXPORT_SYMBOL_GPL(irq_domain_xlate_twocell);
   940	
   941	/**
   942	 * irq_domain_xlate_onetwocell() - Generic xlate for one or two cell bindings
   943	 *
   944	 * Device Tree IRQ specifier translation function which works with either one
   945	 * or two cell bindings where the cell values map directly to the hwirq number
   946	 * and linux irq flags.
   947	 *
   948	 * Note: don't use this function unless your interrupt controller explicitly
   949	 * supports both one and two cell bindings.  For the majority of controllers
   950	 * the _onecell() or _twocell() variants above should be used.
   951	 */
   952	int irq_domain_xlate_onetwocell(struct irq_domain *d,
   953					struct device_node *ctrlr,
   954					const u32 *intspec, unsigned int intsize,
   955					unsigned long *out_hwirq, unsigned int *out_type)
 > 956	{
   957		if (WARN_ON(intsize < 1))
   958			return -EINVAL;
   959		*out_hwirq = intspec[0];
   960		if (intsize > 1)
   961			*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
   962		else
   963			*out_type = IRQ_TYPE_NONE;
   964		return 0;
   965	}
   966	EXPORT_SYMBOL_GPL(irq_domain_xlate_onetwocell);
   967	
   968	const struct irq_domain_ops irq_domain_simple_ops = {
   969		.xlate = irq_domain_xlate_onetwocell,
   970	};
   971	EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
   972	
   973	/**
   974	 * irq_domain_translate_twocell() - Generic translate for direct two cell
   975	 * bindings
   976	 *
   977	 * Device Tree IRQ specifier translation function which works with two cell
   978	 * bindings where the cell values map directly to the hwirq number
   979	 * and linux irq flags.
   980	 */
   981	int irq_domain_translate_twocell(struct irq_domain *d,
   982					 struct irq_fwspec *fwspec,
   983					 unsigned long *out_hwirq,
   984					 unsigned int *out_type)
 > 985	{
   986		if (WARN_ON(fwspec->param_count < 2))
   987			return -EINVAL;
   988		*out_hwirq = fwspec->param[0];
   989		*out_type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
   990		return 0;
   991	}
   992	EXPORT_SYMBOL_GPL(irq_domain_translate_twocell);
   993	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
