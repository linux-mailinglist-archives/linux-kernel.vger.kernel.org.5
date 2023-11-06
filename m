Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5027E29B5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 17:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbjKFQ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 11:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjKFQ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 11:26:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B085D70
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 08:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699287989; x=1730823989;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VnLUr2ELFffFPUSWPC7vxjhEJmwWLdvN09D3uZsgyys=;
  b=LokGWYUyuGnjWEku1N4iBtY6ZKTaFeIdRV+2hBgmfiq/bW6pusYaTFS5
   ocODKlNXSWvKa4kWvdZbPBDRyRKK9A7gUcLq/CicFA5902M6//gz+0rSK
   ayYW9ndhmHAOSaBXAZuzUesDazSJ27rM7/lMf1cgANrUE7/fF8uq7Gztu
   D3jseD1HuyXgfoXGA1SH3fNZAu1k6BWVaDz2TvWyjOOgr2QvVhc80Mja1
   iRNCOdnziOaYeW279inbaxVKOfApDM5VsLYiFC17S1ZprVdWYmi34JqxM
   sfyMRcDOtj6FtixWftJAO0Wu5uwnLrt3jR5vyqEywtpMp3nQo7u3B3IOd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="2229556"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="2229556"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 08:26:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="791501059"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="791501059"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2023 08:26:26 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r02Qh-0006YD-2i;
        Mon, 06 Nov 2023 16:26:23 +0000
Date:   Tue, 7 Nov 2023 00:25:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: kismet: WARNING: unmet direct dependencies detected for
 DMA_GLOBAL_POOL when selected by ARCH_R9A07G043
Message-ID: <202311070002.6ydT46IS-lkp@intel.com>
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
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: da323d4640704001f2287f729124e1cd9d5684d0 dma-direct: add dependencies to CONFIG_DMA_GLOBAL_POOL
date:   2 weeks ago
config: riscv-kismet-CONFIG_DMA_GLOBAL_POOL-CONFIG_ARCH_R9A07G043-0-0 (https://download.01.org/0day-ci/archive/20231107/202311070002.6ydT46IS-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231107/202311070002.6ydT46IS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311070002.6ydT46IS-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL when selected by ARCH_R9A07G043
   .config:5065:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
   .config:6176:warning: symbol value 'ONFIG_ARCH_MMAP_RND_COMPAT_BITS_MI' invalid for ARCH_MMAP_RND_COMPAT_BITS
   
   WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL
     Depends on [n]: !ARCH_HAS_DMA_SET_UNCACHED [=n] && !DMA_DIRECT_REMAP [=y]
     Selected by [y]:
     - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y] && NONPORTABLE [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
