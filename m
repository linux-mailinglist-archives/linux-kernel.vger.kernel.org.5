Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA3C7C6C49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378289AbjJLLay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343858AbjJLLaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:30:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EBF91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 04:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697110250; x=1728646250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8fFjIIgncYuZRw3NirW0Qcb4LFrCgQY2m8fMTaXwKOg=;
  b=e6neXatFlyoJBTGHi4O6TK49xF0yiB8FQMoj2Z331IwkPgwqnNH4rCI4
   ckzS/ZpUPfij166gJ8MT8hO64rpLVQyeh8ihGqWFiu8vTvJrL7s8vRZQ1
   j0gAghzeEbTxeOwNFP4rCH0LyFormatVxbPLmTE2UHoCAeoK+mVHCCvTW
   oRvkaGF13STSvwtU8w8Rzg/W3t0DZvN8vQGQ6bpkNO1trECIy5zTj/mjZ
   7pDcD0wjJw4pwQDUriOF6OxzNwy0kFqwTfmeCIFjzNXFsbmw479u7TxK2
   CdPoDh8EpZLEy7VOvscNEoZQK8PUYOgj2UW2miyHLWh8GsyLE1+aOD081
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="369963390"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="369963390"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 04:30:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="898074077"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="898074077"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2023 04:28:59 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqtts-0003PN-2O;
        Thu, 12 Oct 2023 11:30:44 +0000
Date:   Thu, 12 Oct 2023 19:30:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lu Yao <yaolu@kylinos.cn>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        rdunlap@infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, hpa@zytor.com,
        linux-kernel@vger.kernel.org, Lu Yao <yaolu@kylinos.cn>
Subject: Re: [PATCH v2] x86/msi: Fix compile error caused by GENERIC_MSI_IRQ
 and X86_LOCAL_APIC
Message-ID: <202310121953.G7zdSGxU-lkp@intel.com>
References: <20231011055749.98840-1-yaolu@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011055749.98840-1-yaolu@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/master]
[also build test WARNING on tip/x86/core tip/auto-latest linus/master v6.6-rc5 next-20231012]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lu-Yao/x86-msi-Fix-compile-error-caused-by-GENERIC_MSI_IRQ-and-X86_LOCAL_APIC/20231011-135941
base:   tip/master
patch link:    https://lore.kernel.org/r/20231011055749.98840-1-yaolu%40kylinos.cn
patch subject: [PATCH v2] x86/msi: Fix compile error caused by GENERIC_MSI_IRQ and X86_LOCAL_APIC
config: x86_64-randconfig-076-20231012 (https://download.01.org/0day-ci/archive/20231012/202310121953.G7zdSGxU-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231012/202310121953.G7zdSGxU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310121953.G7zdSGxU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/kernel/hpet.c:509:22: error: 'msi_domain_set_affinity' undeclared here (not in a function); did you mean 'irq_can_set_affinity'?
     .irq_set_affinity = msi_domain_set_affinity,
                         ^~~~~~~~~~~~~~~~~~~~~~~
                         irq_can_set_affinity
   arch/x86/kernel/hpet.c:516:12: warning: 'struct msi_domain_info' declared inside parameter list will not be visible outside of this definition or declaration
        struct msi_domain_info *info, unsigned int virq,
               ^~~~~~~~~~~~~~~
   arch/x86/kernel/hpet.c: In function 'hpet_msi_init':
   arch/x86/kernel/hpet.c:520:52: error: dereferencing pointer to incomplete type 'struct msi_domain_info'
     irq_domain_set_info(domain, virq, arg->hwirq, info->chip, NULL,
                                                       ^~
   arch/x86/kernel/hpet.c: At top level:
   arch/x86/kernel/hpet.c:527:13: warning: 'struct msi_domain_info' declared inside parameter list will not be visible outside of this definition or declaration
         struct msi_domain_info *info, unsigned int virq)
                ^~~~~~~~~~~~~~~
   arch/x86/kernel/hpet.c:532:15: error: variable 'hpet_msi_domain_ops' has initializer but incomplete type
    static struct msi_domain_ops hpet_msi_domain_ops = {
                  ^~~~~~~~~~~~~~
   arch/x86/kernel/hpet.c:533:3: error: 'struct msi_domain_ops' has no member named 'msi_init'
     .msi_init = hpet_msi_init,
      ^~~~~~~~
   arch/x86/kernel/hpet.c:533:14: warning: excess elements in struct initializer
     .msi_init = hpet_msi_init,
                 ^~~~~~~~~~~~~
   arch/x86/kernel/hpet.c:533:14: note: (near initialization for 'hpet_msi_domain_ops')
   arch/x86/kernel/hpet.c:534:3: error: 'struct msi_domain_ops' has no member named 'msi_free'
     .msi_free = hpet_msi_free,
      ^~~~~~~~
   arch/x86/kernel/hpet.c:534:14: warning: excess elements in struct initializer
     .msi_free = hpet_msi_free,
                 ^~~~~~~~~~~~~
   arch/x86/kernel/hpet.c:534:14: note: (near initialization for 'hpet_msi_domain_ops')
   arch/x86/kernel/hpet.c:537:15: error: variable 'hpet_msi_domain_info' has initializer but incomplete type
    static struct msi_domain_info hpet_msi_domain_info = {
                  ^~~~~~~~~~~~~~~
   arch/x86/kernel/hpet.c:538:3: error: 'struct msi_domain_info' has no member named 'ops'
     .ops  = &hpet_msi_domain_ops,
      ^~~
   arch/x86/kernel/hpet.c:538:10: warning: excess elements in struct initializer
     .ops  = &hpet_msi_domain_ops,
             ^
   arch/x86/kernel/hpet.c:538:10: note: (near initialization for 'hpet_msi_domain_info')
   arch/x86/kernel/hpet.c:539:3: error: 'struct msi_domain_info' has no member named 'chip'
     .chip  = &hpet_msi_controller,
      ^~~~
   arch/x86/kernel/hpet.c:539:11: warning: excess elements in struct initializer
     .chip  = &hpet_msi_controller,
              ^
   arch/x86/kernel/hpet.c:539:11: note: (near initialization for 'hpet_msi_domain_info')
   arch/x86/kernel/hpet.c:540:3: error: 'struct msi_domain_info' has no member named 'flags'
     .flags  = MSI_FLAG_USE_DEF_DOM_OPS,
      ^~~~~
   arch/x86/kernel/hpet.c:540:12: error: 'MSI_FLAG_USE_DEF_DOM_OPS' undeclared here (not in a function); did you mean 'SIMPLE_DEV_PM_OPS'?
     .flags  = MSI_FLAG_USE_DEF_DOM_OPS,
               ^~~~~~~~~~~~~~~~~~~~~~~~
               SIMPLE_DEV_PM_OPS
   arch/x86/kernel/hpet.c:540:12: warning: excess elements in struct initializer
   arch/x86/kernel/hpet.c:540:12: note: (near initialization for 'hpet_msi_domain_info')
   arch/x86/kernel/hpet.c: In function 'hpet_create_irq_domain':
   arch/x86/kernel/hpet.c:553:31: error: dereferencing pointer to incomplete type 'struct msi_domain_info'
     domain_info = kzalloc(sizeof(*domain_info), GFP_KERNEL);
                                  ^~~~~~~~~~~~
   arch/x86/kernel/hpet.c:580:6: error: implicit declaration of function 'msi_create_irq_domain'; did you mean 'hpet_create_irq_domain'? [-Werror=implicit-function-declaration]
     d = msi_create_irq_domain(fn, domain_info, parent);
         ^~~~~~~~~~~~~~~~~~~~~
         hpet_create_irq_domain
>> arch/x86/kernel/hpet.c:580:4: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     d = msi_create_irq_domain(fn, domain_info, parent);
       ^
   arch/x86/kernel/hpet.c: In function 'hpet_dev_id':
   arch/x86/kernel/hpet.c:590:33: error: implicit declaration of function 'msi_get_domain_info'; did you mean 'sched_domain_span'? [-Werror=implicit-function-declaration]
     struct msi_domain_info *info = msi_get_domain_info(domain);
                                    ^~~~~~~~~~~~~~~~~~~
                                    sched_domain_span
>> arch/x86/kernel/hpet.c:590:33: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   arch/x86/kernel/hpet.c: At top level:
   arch/x86/kernel/hpet.c:532:30: error: storage size of 'hpet_msi_domain_ops' isn't known
    static struct msi_domain_ops hpet_msi_domain_ops = {
                                 ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/hpet.c:537:31: error: storage size of 'hpet_msi_domain_info' isn't known
    static struct msi_domain_info hpet_msi_domain_info = {
                                  ^~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/hpet.c: In function 'hpet_dev_id':
   arch/x86/kernel/hpet.c:593:1: error: control reaches end of non-void function [-Werror=return-type]
    }
    ^
   cc1: some warnings being treated as errors


vim +580 arch/x86/kernel/hpet.c

3d7295eb3003ae David Woodhouse 2020-10-24  536  
3d7295eb3003ae David Woodhouse 2020-10-24  537  static struct msi_domain_info hpet_msi_domain_info = {
3d7295eb3003ae David Woodhouse 2020-10-24  538  	.ops		= &hpet_msi_domain_ops,
3d7295eb3003ae David Woodhouse 2020-10-24  539  	.chip		= &hpet_msi_controller,
3d7295eb3003ae David Woodhouse 2020-10-24 @540  	.flags		= MSI_FLAG_USE_DEF_DOM_OPS,
3d7295eb3003ae David Woodhouse 2020-10-24  541  };
3d7295eb3003ae David Woodhouse 2020-10-24  542  
3d7295eb3003ae David Woodhouse 2020-10-24  543  static struct irq_domain *hpet_create_irq_domain(int hpet_id)
3d7295eb3003ae David Woodhouse 2020-10-24  544  {
3d7295eb3003ae David Woodhouse 2020-10-24  545  	struct msi_domain_info *domain_info;
3d7295eb3003ae David Woodhouse 2020-10-24  546  	struct irq_domain *parent, *d;
3d7295eb3003ae David Woodhouse 2020-10-24  547  	struct fwnode_handle *fn;
c2a5881c28e5bb David Woodhouse 2020-10-24  548  	struct irq_fwspec fwspec;
3d7295eb3003ae David Woodhouse 2020-10-24  549  
3d7295eb3003ae David Woodhouse 2020-10-24  550  	if (x86_vector_domain == NULL)
3d7295eb3003ae David Woodhouse 2020-10-24  551  		return NULL;
3d7295eb3003ae David Woodhouse 2020-10-24  552  
3d7295eb3003ae David Woodhouse 2020-10-24  553  	domain_info = kzalloc(sizeof(*domain_info), GFP_KERNEL);
3d7295eb3003ae David Woodhouse 2020-10-24  554  	if (!domain_info)
3d7295eb3003ae David Woodhouse 2020-10-24  555  		return NULL;
3d7295eb3003ae David Woodhouse 2020-10-24  556  
3d7295eb3003ae David Woodhouse 2020-10-24  557  	*domain_info = hpet_msi_domain_info;
3d7295eb3003ae David Woodhouse 2020-10-24  558  	domain_info->data = (void *)(long)hpet_id;
3d7295eb3003ae David Woodhouse 2020-10-24  559  
3d7295eb3003ae David Woodhouse 2020-10-24  560  	fn = irq_domain_alloc_named_id_fwnode(hpet_msi_controller.name,
3d7295eb3003ae David Woodhouse 2020-10-24  561  					      hpet_id);
3d7295eb3003ae David Woodhouse 2020-10-24  562  	if (!fn) {
3d7295eb3003ae David Woodhouse 2020-10-24  563  		kfree(domain_info);
3d7295eb3003ae David Woodhouse 2020-10-24  564  		return NULL;
3d7295eb3003ae David Woodhouse 2020-10-24  565  	}
3d7295eb3003ae David Woodhouse 2020-10-24  566  
c2a5881c28e5bb David Woodhouse 2020-10-24  567  	fwspec.fwnode = fn;
c2a5881c28e5bb David Woodhouse 2020-10-24  568  	fwspec.param_count = 1;
c2a5881c28e5bb David Woodhouse 2020-10-24  569  	fwspec.param[0] = hpet_id;
c2a5881c28e5bb David Woodhouse 2020-10-24  570  
c2a5881c28e5bb David Woodhouse 2020-10-24  571  	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
c2a5881c28e5bb David Woodhouse 2020-10-24  572  	if (!parent) {
c2a5881c28e5bb David Woodhouse 2020-10-24  573  		irq_domain_free_fwnode(fn);
c2a5881c28e5bb David Woodhouse 2020-10-24  574  		kfree(domain_info);
c2a5881c28e5bb David Woodhouse 2020-10-24  575  		return NULL;
c2a5881c28e5bb David Woodhouse 2020-10-24  576  	}
c2a5881c28e5bb David Woodhouse 2020-10-24  577  	if (parent != x86_vector_domain)
c2a5881c28e5bb David Woodhouse 2020-10-24  578  		hpet_msi_controller.name = "IR-HPET-MSI";
c2a5881c28e5bb David Woodhouse 2020-10-24  579  
3d7295eb3003ae David Woodhouse 2020-10-24 @580  	d = msi_create_irq_domain(fn, domain_info, parent);
3d7295eb3003ae David Woodhouse 2020-10-24  581  	if (!d) {
3d7295eb3003ae David Woodhouse 2020-10-24  582  		irq_domain_free_fwnode(fn);
3d7295eb3003ae David Woodhouse 2020-10-24  583  		kfree(domain_info);
3d7295eb3003ae David Woodhouse 2020-10-24  584  	}
3d7295eb3003ae David Woodhouse 2020-10-24  585  	return d;
3d7295eb3003ae David Woodhouse 2020-10-24  586  }
3d7295eb3003ae David Woodhouse 2020-10-24  587  
3d7295eb3003ae David Woodhouse 2020-10-24  588  static inline int hpet_dev_id(struct irq_domain *domain)
3d7295eb3003ae David Woodhouse 2020-10-24  589  {
3d7295eb3003ae David Woodhouse 2020-10-24 @590  	struct msi_domain_info *info = msi_get_domain_info(domain);
3d7295eb3003ae David Woodhouse 2020-10-24  591  
3d7295eb3003ae David Woodhouse 2020-10-24  592  	return (int)(long)info->data;
3d7295eb3003ae David Woodhouse 2020-10-24  593  }
3d7295eb3003ae David Woodhouse 2020-10-24  594  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
