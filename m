Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF12777EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjHJRDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjHJRDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:03:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CECB2694
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691686986; x=1723222986;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yZUQC/i01eHrobuGyun5mknspu3akskzXyMpJwyD+NE=;
  b=bMFdBKEQ7nTXm9JItryz28fsXUxFRn28HuGL2mW+PYlCCROuUIpw7qQv
   GzcMQmTVKb7TMXTit89jzeac0gDI+EUjsDhSHy2hZ7P4Ya8L5N68o7LOi
   oEKzWdd6qXSONkMk62JS4o1ZaWRJyrDWmQ6i1UcOSjae0FaHIkglhi+oc
   OJOBSnniiZ7ANRsY0dLZkWaIyRD49rRziE4KFR12aWKk45KO+Sfas/e5u
   22pwi10phB4WBfV6+Z4MHn7dfhukz8nv8HznLummPIsNCfkN71S4Z0NBI
   NiUDOLE3mS7yvV03UxMCP2Li5p46yulR/a4byKQ/0lIbePKVStKufAYIT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="435358008"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="435358008"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 10:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="1062988615"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="1062988615"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 Aug 2023 10:02:15 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qU938-00077w-0K;
        Thu, 10 Aug 2023 17:02:14 +0000
Date:   Fri, 11 Aug 2023 01:01:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:311:16: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202308110052.GRrF9sM5-lkp@intel.com>
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
head:   374a7f47bf401441edff0a64465e61326bf70a82
commit: 57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb LoongArch: Add PCI controller support
date:   12 months ago
config: loongarch-randconfig-r091-20230810 (https://download.01.org/0day-ci/archive/20230811/202308110052.GRrF9sM5-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308110052.GRrF9sM5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308110052.GRrF9sM5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c: note: in included file:
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:311:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:311:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:311:16: sparse:     got restricted __le32 [usertype]
>> drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:311:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:311:16: sparse:     expected unsigned int [usertype] value
   drivers/infiniband/hw/vmw_pvrdma/pvrdma.h:311:16: sparse:     got restricted __le32 [usertype]

vim +311 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h

29c8d9eba550c6 Adit Ranadive 2016-10-02  308  
29c8d9eba550c6 Adit Ranadive 2016-10-02  309  static inline void pvrdma_write_uar_cq(struct pvrdma_dev *dev, u32 val)
29c8d9eba550c6 Adit Ranadive 2016-10-02  310  {
29c8d9eba550c6 Adit Ranadive 2016-10-02 @311  	writel(cpu_to_le32(val), dev->driver_uar.map + PVRDMA_UAR_CQ_OFFSET);
29c8d9eba550c6 Adit Ranadive 2016-10-02  312  }
29c8d9eba550c6 Adit Ranadive 2016-10-02  313  

:::::: The code at line 311 was first introduced by commit
:::::: 29c8d9eba550c6d73d17cc1618a9f5f2a7345aa1 IB: Add vmw_pvrdma driver

:::::: TO: Adit Ranadive <aditr@vmware.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
