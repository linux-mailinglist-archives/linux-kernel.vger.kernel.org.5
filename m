Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE07B26EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjI1VAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjI1VAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:00:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918B21A2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695934832; x=1727470832;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=plQZm9Gqmd4pF5S/4ppKbvpUSTgXLph+LF2jDBbgCl0=;
  b=mh1D9NnPkTwe4Nh5VK1y47FbqrCdk28i/K3kjFFseiBWmet7LIZANAWI
   9ESWsTQwwRTgFDGsoSrLEr0RubNpM34AFXKi+2dckxFUQI0trdM9SgbF/
   D7E/AtQvh6IPJAJECrL2josT6owedARTaQ7FAB/sKQauTT6Qkn+RdLAKV
   IyIUAq2sN/pjXH+XW7wfTrvS5nyTJF2nYBxJP1pZrNnOgvu5OS0iLwQxh
   8x2IgpwgUGqd6rL1at2/Nps2q76815bojkVOUTFipNaQCobhdOIIZrvZ1
   Fur3uEg4HkQaqN+XBfMe0MDYyCIyC2Ak77JUpeBI0yy5UVcxm75cgAdkv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="386040035"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="386040035"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 14:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="873436157"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="873436157"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Sep 2023 14:00:30 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qly7Y-0001xS-0K;
        Thu, 28 Sep 2023 21:00:28 +0000
Date:   Fri, 29 Sep 2023 05:00:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: arch/x86/kernel/hpet.c:520:46: error: invalid use of incomplete
 typedef 'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
Message-ID: <202309290439.8R8jcHz5-lkp@intel.com>
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
head:   633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
commit: 70afdab904d2d1e68bffe75fe08e7e48e0b0ff8e irqchip: Add IMX MU MSI controller driver
date:   12 months ago
config: i386-buildonly-randconfig-003-20230915 (https://download.01.org/0day-ci/archive/20230929/202309290439.8R8jcHz5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309290439.8R8jcHz5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309290439.8R8jcHz5-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kernel/hpet.c: In function 'hpet_msi_init':
>> arch/x86/kernel/hpet.c:520:46: error: invalid use of incomplete typedef 'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
     520 |         irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
         |                                              ^~
   arch/x86/kernel/hpet.c:521:49: error: invalid use of incomplete typedef 'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
     521 |                             handle_edge_irq, arg->data, "edge");
         |                                                 ^~
   arch/x86/kernel/hpet.c: In function 'hpet_create_irq_domain':
>> arch/x86/kernel/hpet.c:550:13: error: 'x86_vector_domain' undeclared (first use in this function)
     550 |         if (x86_vector_domain == NULL)
         |             ^~~~~~~~~~~~~~~~~
   arch/x86/kernel/hpet.c:550:13: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/kernel/hpet.c: In function 'hpet_assign_irq':
>> arch/x86/kernel/hpet.c:598:31: error: storage size of 'info' isn't known
     598 |         struct irq_alloc_info info;
         |                               ^~~~
>> arch/x86/kernel/hpet.c:600:9: error: implicit declaration of function 'init_irq_alloc_info' [-Werror=implicit-function-declaration]
     600 |         init_irq_alloc_info(&info, NULL);
         |         ^~~~~~~~~~~~~~~~~~~
>> arch/x86/kernel/hpet.c:601:21: error: 'X86_IRQ_ALLOC_TYPE_HPET' undeclared (first use in this function)
     601 |         info.type = X86_IRQ_ALLOC_TYPE_HPET;
         |                     ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/hpet.c:598:31: warning: unused variable 'info' [-Wunused-variable]
     598 |         struct irq_alloc_info info;
         |                               ^~~~
   arch/x86/kernel/hpet.c:607:1: error: control reaches end of non-void function [-Werror=return-type]
     607 | }
         | ^
   cc1: some warnings being treated as errors


vim +520 arch/x86/kernel/hpet.c

3d7295eb3003aea David Woodhouse 2020-10-24  514  
3d7295eb3003aea David Woodhouse 2020-10-24  515  static int hpet_msi_init(struct irq_domain *domain,
3d7295eb3003aea David Woodhouse 2020-10-24  516  			 struct msi_domain_info *info, unsigned int virq,
3d7295eb3003aea David Woodhouse 2020-10-24  517  			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
3d7295eb3003aea David Woodhouse 2020-10-24  518  {
3d7295eb3003aea David Woodhouse 2020-10-24  519  	irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
3d7295eb3003aea David Woodhouse 2020-10-24 @520  	irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
3d7295eb3003aea David Woodhouse 2020-10-24  521  			    handle_edge_irq, arg->data, "edge");
3d7295eb3003aea David Woodhouse 2020-10-24  522  
3d7295eb3003aea David Woodhouse 2020-10-24  523  	return 0;
3d7295eb3003aea David Woodhouse 2020-10-24  524  }
3d7295eb3003aea David Woodhouse 2020-10-24  525  
3d7295eb3003aea David Woodhouse 2020-10-24  526  static void hpet_msi_free(struct irq_domain *domain,
3d7295eb3003aea David Woodhouse 2020-10-24  527  			  struct msi_domain_info *info, unsigned int virq)
3d7295eb3003aea David Woodhouse 2020-10-24  528  {
3d7295eb3003aea David Woodhouse 2020-10-24  529  	irq_clear_status_flags(virq, IRQ_MOVE_PCNTXT);
3d7295eb3003aea David Woodhouse 2020-10-24  530  }
3d7295eb3003aea David Woodhouse 2020-10-24  531  
3d7295eb3003aea David Woodhouse 2020-10-24  532  static struct msi_domain_ops hpet_msi_domain_ops = {
3d7295eb3003aea David Woodhouse 2020-10-24  533  	.msi_init	= hpet_msi_init,
3d7295eb3003aea David Woodhouse 2020-10-24  534  	.msi_free	= hpet_msi_free,
3d7295eb3003aea David Woodhouse 2020-10-24  535  };
3d7295eb3003aea David Woodhouse 2020-10-24  536  
3d7295eb3003aea David Woodhouse 2020-10-24  537  static struct msi_domain_info hpet_msi_domain_info = {
3d7295eb3003aea David Woodhouse 2020-10-24  538  	.ops		= &hpet_msi_domain_ops,
3d7295eb3003aea David Woodhouse 2020-10-24  539  	.chip		= &hpet_msi_controller,
3d7295eb3003aea David Woodhouse 2020-10-24  540  	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
3d7295eb3003aea David Woodhouse 2020-10-24  541  };
3d7295eb3003aea David Woodhouse 2020-10-24  542  
3d7295eb3003aea David Woodhouse 2020-10-24  543  static struct irq_domain *hpet_create_irq_domain(int hpet_id)
3d7295eb3003aea David Woodhouse 2020-10-24  544  {
3d7295eb3003aea David Woodhouse 2020-10-24  545  	struct msi_domain_info *domain_info;
3d7295eb3003aea David Woodhouse 2020-10-24  546  	struct irq_domain *parent, *d;
3d7295eb3003aea David Woodhouse 2020-10-24  547  	struct fwnode_handle *fn;
c2a5881c28e5bb4 David Woodhouse 2020-10-24  548  	struct irq_fwspec fwspec;
3d7295eb3003aea David Woodhouse 2020-10-24  549  
3d7295eb3003aea David Woodhouse 2020-10-24 @550  	if (x86_vector_domain == NULL)
3d7295eb3003aea David Woodhouse 2020-10-24  551  		return NULL;
3d7295eb3003aea David Woodhouse 2020-10-24  552  
3d7295eb3003aea David Woodhouse 2020-10-24  553  	domain_info = kzalloc(sizeof(*domain_info), GFP_KERNEL);
3d7295eb3003aea David Woodhouse 2020-10-24  554  	if (!domain_info)
3d7295eb3003aea David Woodhouse 2020-10-24  555  		return NULL;
3d7295eb3003aea David Woodhouse 2020-10-24  556  
3d7295eb3003aea David Woodhouse 2020-10-24  557  	*domain_info = hpet_msi_domain_info;
3d7295eb3003aea David Woodhouse 2020-10-24  558  	domain_info->data = (void *)(long)hpet_id;
3d7295eb3003aea David Woodhouse 2020-10-24  559  
3d7295eb3003aea David Woodhouse 2020-10-24  560  	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
3d7295eb3003aea David Woodhouse 2020-10-24  561  					      hpet_id);
3d7295eb3003aea David Woodhouse 2020-10-24  562  	if (!fn) {
3d7295eb3003aea David Woodhouse 2020-10-24  563  		kfree(domain_info);
3d7295eb3003aea David Woodhouse 2020-10-24  564  		return NULL;
3d7295eb3003aea David Woodhouse 2020-10-24  565  	}
3d7295eb3003aea David Woodhouse 2020-10-24  566  
c2a5881c28e5bb4 David Woodhouse 2020-10-24  567  	fwspec.fwnode = fn;
c2a5881c28e5bb4 David Woodhouse 2020-10-24  568  	fwspec.param_count = 1;
c2a5881c28e5bb4 David Woodhouse 2020-10-24  569  	fwspec.param[0] = hpet_id;
c2a5881c28e5bb4 David Woodhouse 2020-10-24  570  
c2a5881c28e5bb4 David Woodhouse 2020-10-24  571  	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
c2a5881c28e5bb4 David Woodhouse 2020-10-24  572  	if (!parent) {
c2a5881c28e5bb4 David Woodhouse 2020-10-24  573  		irq_domain_free_fwnode(fn);
c2a5881c28e5bb4 David Woodhouse 2020-10-24  574  		kfree(domain_info);
c2a5881c28e5bb4 David Woodhouse 2020-10-24  575  		return NULL;
c2a5881c28e5bb4 David Woodhouse 2020-10-24  576  	}
c2a5881c28e5bb4 David Woodhouse 2020-10-24  577  	if (parent != x86_vector_domain)
c2a5881c28e5bb4 David Woodhouse 2020-10-24  578  		hpet_msi_controller.name = "IR-HPET-MSI";
c2a5881c28e5bb4 David Woodhouse 2020-10-24  579  
3d7295eb3003aea David Woodhouse 2020-10-24  580  	d = msi_create_irq_domain(fn, domain_info, parent);
3d7295eb3003aea David Woodhouse 2020-10-24  581  	if (!d) {
3d7295eb3003aea David Woodhouse 2020-10-24  582  		irq_domain_free_fwnode(fn);
3d7295eb3003aea David Woodhouse 2020-10-24  583  		kfree(domain_info);
3d7295eb3003aea David Woodhouse 2020-10-24  584  	}
3d7295eb3003aea David Woodhouse 2020-10-24  585  	return d;
3d7295eb3003aea David Woodhouse 2020-10-24  586  }
3d7295eb3003aea David Woodhouse 2020-10-24  587  
3d7295eb3003aea David Woodhouse 2020-10-24  588  static inline int hpet_dev_id(struct irq_domain *domain)
3d7295eb3003aea David Woodhouse 2020-10-24  589  {
3d7295eb3003aea David Woodhouse 2020-10-24  590  	struct msi_domain_info *info = msi_get_domain_info(domain);
3d7295eb3003aea David Woodhouse 2020-10-24  591  
3d7295eb3003aea David Woodhouse 2020-10-24  592  	return (int)(long)info->data;
3d7295eb3003aea David Woodhouse 2020-10-24  593  }
3d7295eb3003aea David Woodhouse 2020-10-24  594  
3d7295eb3003aea David Woodhouse 2020-10-24  595  static int hpet_assign_irq(struct irq_domain *domain, struct hpet_channel *hc,
3d7295eb3003aea David Woodhouse 2020-10-24  596  			   int dev_num)
3d7295eb3003aea David Woodhouse 2020-10-24  597  {
3d7295eb3003aea David Woodhouse 2020-10-24 @598  	struct irq_alloc_info info;
3d7295eb3003aea David Woodhouse 2020-10-24  599  
3d7295eb3003aea David Woodhouse 2020-10-24 @600  	init_irq_alloc_info(&info, NULL);
3d7295eb3003aea David Woodhouse 2020-10-24 @601  	info.type = X86_IRQ_ALLOC_TYPE_HPET;
3d7295eb3003aea David Woodhouse 2020-10-24  602  	info.data = hc;
3d7295eb3003aea David Woodhouse 2020-10-24  603  	info.devid = hpet_dev_id(domain);
3d7295eb3003aea David Woodhouse 2020-10-24  604  	info.hwirq = dev_num;
3d7295eb3003aea David Woodhouse 2020-10-24  605  
3d7295eb3003aea David Woodhouse 2020-10-24  606  	return irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info);
3d7295eb3003aea David Woodhouse 2020-10-24  607  }
3d7295eb3003aea David Woodhouse 2020-10-24  608  

:::::: The code at line 520 was first introduced by commit
:::::: 3d7295eb3003aea9f89de35304b3a88ae4d5036b x86/hpet: Move MSI support into hpet.c

:::::: TO: David Woodhouse <dwmw@amazon.co.uk>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
