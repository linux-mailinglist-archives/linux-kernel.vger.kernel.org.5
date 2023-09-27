Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E907B0CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 21:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjI0Tpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 15:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0Tpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 15:45:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092A311D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695843927; x=1727379927;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nWSmREyDVhRSp1uWLtKSMWEUWOz7hBQ0DnZ3JqnebXE=;
  b=K8eUgOxmfiBRgqn2lSVSHQ2qqXLXCf4Ok9GHgmPYKyTGMBHEXwX8/0vg
   9N8U+ybcY96ZuRzF1X6qF8j0heVajfzemkYHCCe2K4xnC3jkSgk1YUcgn
   tcL7qZeLf5VUjql/GqNCspfM6usgykpgkYd87j5MpVz1ngLV4OyFWFJRP
   tvS4bwoNwTrLjmJ7SoP6t4S4KmkOlCV0vZo2Ngd8no7/0ikF/Dq1lDctF
   cZm/2py5CIA0vt7kwiszrHHEGBuqWHxR13XsGfGf53hICoxmWJvdsvu0D
   A1MMGMM5AVbNDgeGMWYe/Ut6Ih1cTYn/8GLgvDK2wTdgNzklTy08zqekt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="366966511"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="366966511"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 12:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="778655896"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="778655896"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 27 Sep 2023 12:45:24 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlaTK-0000ad-0P;
        Wed, 27 Sep 2023 19:45:22 +0000
Date:   Thu, 28 Sep 2023 03:45:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: kernel/irq/irqdomain.c:997: warning: Function parameter or member
 'd' not described in 'irq_domain_translate_onecell'
Message-ID: <202309280353.SfuAs9tD-lkp@intel.com>
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
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20230928/202309280353.SfuAs9tD-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230928/202309280353.SfuAs9tD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309280353.SfuAs9tD-lkp@intel.com/

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
