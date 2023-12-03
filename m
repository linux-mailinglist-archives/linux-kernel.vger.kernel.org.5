Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECAF802541
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 16:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjLCPsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 10:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLCPsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 10:48:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A0BD7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 07:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701618534; x=1733154534;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rTXkXe84fKCKWIgjxlTWsd7qjtszTAoU0qEs/cHZZbM=;
  b=gcbStJVFvMxAUQezGkwN182DIak/Z7mrPLac7k4ftuRpa6f7Y/pD4d3X
   U8SI3H9usP2aHB7EJ2vY2jy8b8BR9TP6s8O0DuzmTcNVI3qUlvOQMLRam
   kifytPcvBhnX37dv5JmsEH1jbCKjUVS4DqlTyA9/vw8KJZCm/O3XBtmwq
   BKF2K4eJBXI+2paw3/ITd/JOnMEJE8cPLmyH0EZuQ0kjSWyZVYSikrGju
   8qZp/v+Vcjpfj2hOKeCOmxIDoxtWg+X5tS1eOnDgGvIeB0iuptItT2uDV
   Z+MDqRiPQbYSxLDZ/HZxcXxm4xSeUQeZ0VgSEtVQZs10PugBFo9+V9Lx6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="378683561"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="378683561"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 07:48:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="893737728"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="893737728"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 03 Dec 2023 07:48:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9oi9-0006nU-1P;
        Sun, 03 Dec 2023 15:48:49 +0000
Date:   Sun, 3 Dec 2023 23:48:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: kernel/irq/irqdomain.c:70: warning: Function parameter or member
 'fwnode' not described in 'irq_domain_free_fwnode'
Message-ID: <202312032328.bQoJiekV-lkp@intel.com>
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
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: b145dcc45a6af0abfcf9b4de8006d40559c50fc6 irqdomain: Add a fwnode_handle allocator
date:   8 years ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231203/202312032328.bQoJiekV-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231203/202312032328.bQoJiekV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312032328.bQoJiekV-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/kobject.h:21,
                    from include/linux/of.h:21,
                    from include/linux/irqdomain.h:37,
                    from kernel/irq/irqdomain.c:8:
   include/linux/sysfs.h: In function 'sysfs_get_dirent':
   include/linux/sysfs.h:496:44: warning: pointer targets in passing argument 2 of 'kernfs_find_and_get' differ in signedness [-Wpointer-sign]
     496 |         return kernfs_find_and_get(parent, name);
         |                                            ^~~~
         |                                            |
         |                                            const unsigned char *
   In file included from include/linux/sysfs.h:15:
   include/linux/kernfs.h:428:57: note: expected 'const char *' but argument is of type 'const unsigned char *'
     428 | kernfs_find_and_get(struct kernfs_node *kn, const char *name)
         |                                             ~~~~~~~~~~~~^~~~
>> kernel/irq/irqdomain.c:70: warning: Function parameter or member 'fwnode' not described in 'irq_domain_free_fwnode'
   kernel/irq/irqdomain.c:98: warning: Function parameter or member 'fwnode' not described in '__irq_domain_add'
   kernel/irq/irqdomain.c:98: warning: Excess function parameter 'of_node' description in '__irq_domain_add'
   kernel/irq/irqdomain.c:779: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:779: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:779: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:779: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:779: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:779: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:798: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:798: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:798: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:798: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:798: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:798: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:822: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:822: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:822: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:822: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:822: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:822: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:1258: warning: Function parameter or member 'domain' not described in 'irq_domain_alloc_irqs_parent'
   kernel/irq/irqdomain.c:1280: warning: Function parameter or member 'domain' not described in 'irq_domain_free_irqs_parent'


vim +70 kernel/irq/irqdomain.c

    63	
    64	/**
    65	 * irq_domain_free_fwnode - Free a non-OF-backed fwnode_handle
    66	 *
    67	 * Free a fwnode_handle allocated with irq_domain_alloc_fwnode.
    68	 */
    69	void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
  > 70	{
    71		struct irqchip_fwid *fwid;
    72	
    73		if (WARN_ON(fwnode->type != FWNODE_IRQCHIP))
    74			return;
    75	
    76		fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
    77		kfree(fwid->name);
    78		kfree(fwid);
    79	}
    80	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
