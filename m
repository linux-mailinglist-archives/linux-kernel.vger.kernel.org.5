Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B061980B9BD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 09:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjLJHxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 02:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJHxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 02:53:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DCEE9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 23:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702194817; x=1733730817;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PgT6u/9cTkD8RWpz7dxjiaUCaGvTAgaemhBmQy6F/MA=;
  b=Ku+LleqAb6cfzjGXkBf2dRc838c821tzYW3/lPrl7Mbmg6rFvqNUp7de
   vIZzjQqeY2z6Tdbj81tUEPrFYWM0VVuU04ZS2OkoeSTcal5fu1RazQtfX
   S5i98MyAi4SFYbr4VOkhEV4sYX78K0hxagveXXajKSYPwZvVUZbRRl3/l
   PToi8mftLTcOzRcnv9j3WiHShte8OwkkNjyYyzRfvEEShrq2beHn4HOPt
   tQqwfUEYIyA4dUxEqBBEqxGjxWvD7tz9SesgRmP8oRSWDO1xQLuFBNbbt
   3NgE2CXCQwJMI/28br7NMW/mLVNsVXEYYrPI4qVaoIQ0BwaIlCwDGw+LS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="384952486"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="384952486"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 23:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="722349925"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="722349925"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 09 Dec 2023 23:53:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCEd3-000GZp-0g;
        Sun, 10 Dec 2023 07:53:33 +0000
Date:   Sun, 10 Dec 2023 15:52:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: powerpc64le-linux-ld: warning: orphan section `.stubs' from
 `drivers/dma/fsl-edma-common.o' being placed in section `.stubs'
Message-ID: <202312101552.Ac77VEGj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c527f5606aa545233a4d2c6d5c636ed82b8633ef
commit: 66aac8ea0a6c79729f99087b1c5a596938e5d838 dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
date:   4 months ago
config: powerpc64-randconfig-r015-20220512 (https://download.01.org/0day-ci/archive/20231210/202312101552.Ac77VEGj-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312101552.Ac77VEGj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312101552.Ac77VEGj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-common.o' being placed in section `.stubs'
   powerpc64le-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/dma/fsl-edma-common.o' being placed in section `.ftrace.tramp'
>> powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-common.o' being placed in section `.stubs'
   powerpc64le-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/dma/fsl-edma-common.o' being placed in section `.ftrace.tramp'
>> powerpc64le-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-common.o' being placed in section `.stubs'
   powerpc64le-linux-ld: warning: orphan section `.ftrace.tramp' from `drivers/dma/fsl-edma-common.o' being placed in section `.ftrace.tramp'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
