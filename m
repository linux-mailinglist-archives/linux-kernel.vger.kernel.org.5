Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E979F3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjIMVoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjIMVoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:44:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E9A173A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694641454; x=1726177454;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w8pYPEU5ySCBd2IkgwPJpd5edhiFfbd4sBCnimZKkvM=;
  b=X6RQfboZFiQZGm3tB3nNbD4fOynWWtE71fC5L9MLamx74Tj3JNz4BF6o
   JMKTxOVvkFsiw9uBdGSjlaT9KfIM1U1LNS+WCZY5gYkIznxeN2V3HcbmH
   aSd4u3wsiPpx7SJFGZ04wPz7uN+DCZnK5yXXNH0lQtCtHTXZ8j0nhuSzq
   BpYO7f7sJCyoSo66Zk4P1KhQrCncKWeNpRqXFKyB8weqZRm0+ikIQ3Q0o
   kYpNQ8q7sTDXEdh19v68O7qJrTkWcVjfMm9nJ853UucKwzUFpm7vBzNsK
   DYxPgghP9hCjCqxpKyl0J1/E9rwfZV3p4Tsttr0DILKWlgz2M2PpKAoOf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="445225563"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="445225563"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 14:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="887508194"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="887508194"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Sep 2023 14:43:42 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgXeR-0000hb-1x;
        Wed, 13 Sep 2023 21:44:03 +0000
Date:   Thu, 14 Sep 2023 05:43:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: arch/parisc/kernel/pdt.c:65:6: warning: no previous prototype for
 'arch_report_meminfo'
Message-ID: <202309140530.CBISqBas-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23f108dc9ed26100b1489f6a9e99088d4064f56b
commit: ef104443bffa004f631729dfc924f0b84abbd602 procfs: consolidate arch_report_meminfo declaration
date:   4 months ago
config: parisc-randconfig-002-20230914 (https://download.01.org/0day-ci/archive/20230914/202309140530.CBISqBas-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140530.CBISqBas-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309140530.CBISqBas-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/parisc/kernel/pdt.c:65:6: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
      65 | void arch_report_meminfo(struct seq_file *m)
         |      ^~~~~~~~~~~~~~~~~~~


vim +/arch_report_meminfo +65 arch/parisc/kernel/pdt.c

c9c2877d08d9aa Helge Deller 2017-05-11  63  
c9c2877d08d9aa Helge Deller 2017-05-11  64  /* report PDT entries via /proc/meminfo */
c9c2877d08d9aa Helge Deller 2017-05-11 @65  void arch_report_meminfo(struct seq_file *m)
c9c2877d08d9aa Helge Deller 2017-05-11  66  {
c9c2877d08d9aa Helge Deller 2017-05-11  67  	if (pdt_type == PDT_NONE)
c9c2877d08d9aa Helge Deller 2017-05-11  68  		return;
c9c2877d08d9aa Helge Deller 2017-05-11  69  
c9c2877d08d9aa Helge Deller 2017-05-11  70  	seq_printf(m, "PDT_max_entries: %7lu\n",
c9c2877d08d9aa Helge Deller 2017-05-11  71  			pdt_status.pdt_size);
c9c2877d08d9aa Helge Deller 2017-05-11  72  	seq_printf(m, "PDT_cur_entries: %7lu\n",
c9c2877d08d9aa Helge Deller 2017-05-11  73  			pdt_status.pdt_entries);
c9c2877d08d9aa Helge Deller 2017-05-11  74  }
c9c2877d08d9aa Helge Deller 2017-05-11  75  

:::::: The code at line 65 was first introduced by commit
:::::: c9c2877d08d9aa0ca0a5c227ac795fbb76269300 parisc: Add Page Deallocation Table (PDT) support

:::::: TO: Helge Deller <deller@gmx.de>
:::::: CC: Helge Deller <deller@gmx.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
