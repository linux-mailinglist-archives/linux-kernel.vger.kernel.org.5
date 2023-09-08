Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2FC79921A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245553AbjIHWWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245534AbjIHWWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:22:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1749B4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 15:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694211754; x=1725747754;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9MOHj62qLG31z2GwNyly7FlwKCL7IxM1i/szrCKmoFM=;
  b=n7fCXLYV6CHpMGupdJ20+aVbqKJZvHpb83LmpJU92qh6Cr0y8N5/ygMR
   B47Knrobk33YlRk23gGC/a33GqoY0puzipMjoyYcBckq2kP/74JtOTya5
   YSdGGfhxgUxrW/qdjtzpUUFZDvWR5gshxQjbycdCXDZyO2d/uQDd7FQer
   QEUtSuOpxIAAL6pUezMLXBfvFSlZRaFuGY5McNtLwq4B8JHrZqv5LqjHI
   cGD/F4FLCFui8BG9RQXWzMnDaFkRAwMvuqqQU9VOb0p1QVHwZxsF6SXMW
   SlBMTHOeToSs58a6U52PxOIzP/dULoEoKIAHQJBpX/Mvy4YP+VnU32uRl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="464129459"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="464129459"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 15:22:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="832807019"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="832807019"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Sep 2023 15:22:32 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qejry-0002f4-0t;
        Fri, 08 Sep 2023 22:22:30 +0000
Date:   Sat, 9 Sep 2023 06:22:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: powerpc64-linux-ld: warning: orphan section `.stubs' from
 `drivers/dma/fsl-edma-common.o' being placed in section `.stubs'
Message-ID: <202309090600.2Q2WxuSD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a48fa7efaf1161c1c898931fe4c7f0070964233a
commit: 66aac8ea0a6c79729f99087b1c5a596938e5d838 dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
date:   2 weeks ago
config: powerpc64-randconfig-r003-20230908 (https://download.01.org/0day-ci/archive/20230909/202309090600.2Q2WxuSD-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309090600.2Q2WxuSD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309090600.2Q2WxuSD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc64-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-common.o' being placed in section `.stubs'
>> powerpc64-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-common.o' being placed in section `.stubs'
>> powerpc64-linux-ld: warning: orphan section `.stubs' from `drivers/dma/fsl-edma-common.o' being placed in section `.stubs'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
