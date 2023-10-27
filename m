Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC8F7DA322
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjJ0WHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjJ0WHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:07:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817C31A6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 15:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698444420; x=1729980420;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M3TKMmesEsHXhFf0rPsbz+ry91Zer0RoBEvG/eMU538=;
  b=eTrfzkal3Jvs8Lg2wGSzVAJBVyQrh6sb9H2dEXMXu/spOZZAFaF3SBBs
   kjfCDcosL6jrnRQvZsmy8YxSUI13qhr+gvG+hAThaNhrtYcKfPjv0j1YW
   cv3tvDCqStDxeNTbMnLjO7C4sCJ5d2iMNgNcp+1vsq9fI/xzmrQfQMEq3
   Tfob5tkcAUf32joHcI1B485uT5CBSfSZnRrYdSpXjO9LblW758UjuheHf
   F0XcPDNpxkEXFg7/ZH9wEbg1xwtdLqXVK4WVll3ghGfHtF+pGJUWGv8pi
   LMW44UQFz8U0F7kJn4uhOYIoMKrU8l3ZDRthCyppEk7lEXapjflPXL80l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="418965483"
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="418965483"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 15:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,257,1694761200"; 
   d="scan'208";a="7345254"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Oct 2023 15:05:35 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwUym-000BEB-14;
        Fri, 27 Oct 2023 22:06:56 +0000
Date:   Sat, 28 Oct 2023 06:06:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: pmem.c:undefined reference to `noncoherent_cache_ops'
Message-ID: <202310280552.Yiukmvy2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   888cf78c29e223fd808682f477c18cf8f61ad995
commit: fd962781270e6452dd5b30c8aa0b3b0fbee06244 riscv: RISCV_NONSTANDARD_CACHE_OPS shouldn't depend on RISCV_DMA_NONCOHERENT
date:   2 days ago
config: riscv-randconfig-001-20231028 (https://download.01.org/0day-ci/archive/20231028/202310280552.Yiukmvy2-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231028/202310280552.Yiukmvy2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310280552.Yiukmvy2-lkp@intel.com/

All errors (new ones prefixed by >>):

   riscv64-linux-ld: arch/riscv/mm/pmem.o: in function `arch_wb_cache_pmem':
>> pmem.c:(.text+0x0): undefined reference to `noncoherent_cache_ops'
   riscv64-linux-ld: arch/riscv/mm/pmem.o: in function `arch_invalidate_pmem':
   pmem.c:(.text+0x9c): undefined reference to `noncoherent_cache_ops'
   riscv64-linux-ld: drivers/cache/ax45mp_cache.o: in function `.L8':
>> ax45mp_cache.c:(.init.text+0x104): undefined reference to `riscv_noncoherent_register_cache_ops'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
