Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5200F80F54B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377064AbjLLSNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjLLSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:13:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2EB9B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702404828; x=1733940828;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wQ6po8XR6kxc8kjalpM1O07dRhIZCPTjApcbxiK/KEU=;
  b=ngxw6D8YFhfqCgohuXtGNwj7KiKlysW/U52RaZAkidFjhAdfnYL1xzfe
   lh6pZFWXIrWsoH7NmUabH+9R3sgd7HZ7cXy91gBU/0hRA+5mTywhyFbMG
   8VKHV+ekN8Jd3tUCd7XNwdViqtsddIdO5O446gJaALskpFkR18qsEHzTP
   +BR+YINT5mKTbfHtj7MLfF9I0QzF0FEJSpw+b0fH4ip+QahtSaPiSIN2A
   jnV8NHKcRD9+rX51qdMEx9c5LTWTkFgYMErNUB8s9eT2wXTbZOeY5X/z4
   r9VRagJmZlHRJA+8K2DjVFuutcBp/mVCAIjL/aAaXuY5ZqIgfrdXD59dI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="16401684"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="16401684"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 10:13:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="807860390"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="807860390"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 12 Dec 2023 10:13:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rD7GJ-000JXb-2l;
        Tue, 12 Dec 2023 18:13:43 +0000
Date:   Wed, 13 Dec 2023 02:13:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Stafford Horne <shorne@gmail.com>
Subject: drivers/irqchip/irq-ompic.c:83:1: sparse: sparse: symbol
 '__pcpu_scope_ops' was not declared. Should it be static?
Message-ID: <202312130224.3JuJk7LB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26aff849438cebcd05f1a647390c4aa700d5c0f1
commit: 8e6d08e0a15e7d4d4b608b56597350d4cdd77710 openrisc: initial SMP support
date:   6 years ago
config: openrisc-randconfig-r122-20231111 (https://download.01.org/0day-ci/archive/20231213/202312130224.3JuJk7LB-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231213/202312130224.3JuJk7LB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312130224.3JuJk7LB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/irqchip/irq-ompic.c:83:1: sparse: sparse: symbol '__pcpu_scope_ops' was not declared. Should it be static?
   drivers/irqchip/irq-ompic.c:198:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] <asn:2> *static [assigned] [toplevel] ompic_base @@
   drivers/irqchip/irq-ompic.c:198:17: sparse:     expected void *addr
   drivers/irqchip/irq-ompic.c:198:17: sparse:     got void [noderef] <asn:2> *static [assigned] [toplevel] ompic_base
   In file included from include/linux/workqueue.h:8,
                    from include/linux/mm_types.h:15,
                    from include/asm-generic/pgtable.h:9,
                    from arch/openrisc/include/asm/pgtable.h:444,
                    from arch/openrisc/include/asm/io.h:33,
                    from include/linux/io.h:25,
                    from drivers/irqchip/irq-ompic.c:61:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:178:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     178 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                              ^
   include/linux/timer.h:143:39: note: in definition of macro '__setup_timer'
     143 |                 (_timer)->function = (_fn);                             18-      |                                       ^~~

vim +/__pcpu_scope_ops +83 drivers/irqchip/irq-ompic.c

9b54470afd8362 Stafford Horne 2017-10-30  82  
9b54470afd8362 Stafford Horne 2017-10-30 @83  DEFINE_PER_CPU(unsigned long, ops);
9b54470afd8362 Stafford Horne 2017-10-30  84  

:::::: The code at line 83 was first introduced by commit
:::::: 9b54470afd836278a7e6f0f08194e2e2dca4b6eb irqchip: add initial support for ompic

:::::: TO: Stafford Horne <shorne@gmail.com>
:::::: CC: Stafford Horne <shorne@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
