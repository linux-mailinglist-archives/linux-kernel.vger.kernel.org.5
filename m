Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5F7E123D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 05:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjKEEaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 00:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKEEaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 00:30:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B2B136
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 21:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699158617; x=1730694617;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EY2Gs5xBvIo5vBXVpgmGEUl+PSu6ha5JUGIZxFU7y4s=;
  b=GFDtMt4BLVrEtT1IVuGk3VpgZBJapZm7Vt1V4FKgp6YCyjrtkBFu7bEP
   O9zF/XL0ySHGNl00a1Zb+SwcIRxIzmb0aeCtomzmM9Y7FzMhCxI+XteyC
   TmpYLLh8kzzbA98rh+gm1IGXbeL4y2LYSqSksYPuRH7OcnlKBPw8cBbmn
   5NoHl9JLXTndyxvQB3nZ9nrVEyN30XTaJboFXpsFlm0bfhf6OI2QP5ImR
   R9tgWW7b89MqpO9YA/0xyDxL2VAjBPUtFkIU4H+kH/JS3+6h2Pl7Z+Fyi
   upR7Hj52ydxKEqFQGzZtF8g44T45yp3JtV3+eiJc8NjM5bOjbQnq5k26/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="7758386"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="7758386"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 21:30:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="796991868"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="796991868"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Nov 2023 21:30:15 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzUm4-00050q-2I;
        Sun, 05 Nov 2023 04:30:12 +0000
Date:   Sun, 5 Nov 2023 12:29:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/dma/contiguous.c:45:26: warning: 'size_bytes' defined but not
 used
Message-ID: <202311051203.BxWQ2ZeM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   aea6bf908d730b01bd264a8821159db9463c111c
commit: cf65a0f6f6ff7631ba0ac0513a14ca5b65320d80 dma-mapping: move all DMA mapping code to kernel/dma
date:   5 years ago
config: x86_64-buildonly-randconfig-r006-20211211 (https://download.01.org/0day-ci/archive/20231105/202311051203.BxWQ2ZeM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311051203.BxWQ2ZeM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311051203.BxWQ2ZeM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/dma/contiguous.c:45:26: warning: 'size_bytes' defined but not used [-Wunused-const-variable=]
      45 | static const phys_addr_t size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
         |                          ^~~~~~~~~~


vim +/size_bytes +45 kernel/dma/contiguous.c

a254129e8686bf drivers/base/dma-contiguous.c Joonsoo Kim        2014-08-06  34  
c64be2bb1c6eb4 drivers/base/dma-contiguous.c Marek Szyprowski   2011-12-29  35  /*
c64be2bb1c6eb4 drivers/base/dma-contiguous.c Marek Szyprowski   2011-12-29  36   * Default global CMA area size can be defined in kernel's .config.
73678804f4e525 drivers/base/dma-contiguous.c Michael Opdenacker 2013-09-18  37   * This is useful mainly for distro maintainers to create a kernel
c64be2bb1c6eb4 drivers/base/dma-contiguous.c Marek Szyprowski   2011-12-29  38   * that works correctly for most supported systems.
c64be2bb1c6eb4 drivers/base/dma-contiguous.c Marek Szyprowski   2011-12-29  39   * The size can be set in bytes or as a percentage of the total memory
c64be2bb1c6eb4 drivers/base/dma-contiguous.c Marek Szyprowski   2011-12-29  40   * in the system.
c64be2bb1c6eb4 drivers/base/dma-contiguous.c Marek Szyprowski   2011-12-29  41   *
c64be2bb1c6eb4 drivers/base/dma-contiguous.c Marek Szyprowski   2011-12-29  42   * Users, who want to set the size of global CMA area for their system
c64be2bb1c6eb4 drivers/base/dma-contiguous.c Marek Szyprowski   2011-12-29  43   * should use cma= kernel parameter.
c64be2bb1c6eb4 drivers/base/dma-contiguous.c Marek Szyprowski   2011-12-29  44   */
a785ce9c90bc7d drivers/base/dma-contiguous.c Tan Xiaojun        2015-09-24 @45  static const phys_addr_t size_bytes = (phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
4009793e15d444 drivers/base/dma-contiguous.c Vitaly Andrianov   2012-12-05  46  static phys_addr_t size_cmdline = -1;
5ea3b1b2f8ad91 drivers/base/dma-contiguous.c Akinobu Mita       2014-06-04  47  static phys_addr_t base_cmdline;
5ea3b1b2f8ad91 drivers/base/dma-contiguous.c Akinobu Mita       2014-06-04  48  static phys_addr_t limit_cmdline;
c64be2bb1c6eb4 drivers/base/dma-contiguous.c Marek Szyprowski   2011-12-29  49  

:::::: The code at line 45 was first introduced by commit
:::::: a785ce9c90bc7d73b5cae4388641b310948509cb CMA: fix CONFIG_CMA_SIZE_MBYTES overflow in 64bit

:::::: TO: Tan Xiaojun <tanxiaojun@huawei.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
