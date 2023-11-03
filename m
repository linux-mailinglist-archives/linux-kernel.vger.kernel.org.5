Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417B77DFE7D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 04:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjKCD4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 23:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCD4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 23:56:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E7F19F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 20:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698983794; x=1730519794;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BtuSUzRaiy0/TrUIUpXDhVjrFW03Dr9r6CLR6M07x8A=;
  b=OaFaeMcKwF4zaUcpcl83QyyM2hyk3PZFKpi9M6dikW3IO5oPAn6Ml9th
   Y05MEkda2wggE7mujKEh4kYfBXH10SZL+br42Ev5Dt1+jAFGarMB9x5lN
   NZ0mTkFYPU7V1l0bMWvSYGjBq5rbsgHSAIyJ6H+zskevOfpF3jiFvnLyb
   14+QW9vDdbdxTpm91DYQR4MRzhlFqGLqS78lShviGES6i2CYVWhOMowid
   7SpAcgFOhlaf5qyFe38IMpM4R2G39RXPNsFOA/tqU+2ikqrIjRMKBY6I1
   XZh9lrYhkdNmZCH/c7f+d5H9GuzD+gc8hBbmw2LcTum/kMQOgGaif3WVo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="379274148"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="379274148"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 20:56:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="827362106"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="827362106"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Nov 2023 20:56:31 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qylIL-0002C6-2J;
        Fri, 03 Nov 2023 03:56:29 +0000
Date:   Fri, 3 Nov 2023 11:55:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202311031119.Tu92pPc2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bc3012f4e3a9765de81f454cb8f9bb16aafc6ff5
commit: f39db26c54281da6a785259498ca74b5e470476f drm: Add kms driver for loongson display controller
date:   4 months ago
config: mips-randconfig-r121-20231102 (https://download.01.org/0day-ci/archive/20231103/202311031119.Tu92pPc2-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231103/202311031119.Tu92pPc2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311031119.Tu92pPc2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *dst @@     got void *kptr @@
   drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35: sparse:     expected void volatile [noderef] __iomem *dst
   drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35: sparse:     got void *kptr
>> drivers/gpu/drm/loongson/lsdc_benchmark.c:42:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *src @@     got void *kptr @@
   drivers/gpu/drm/loongson/lsdc_benchmark.c:42:51: sparse:     expected void const volatile [noderef] __iomem *src
   drivers/gpu/drm/loongson/lsdc_benchmark.c:42:51: sparse:     got void *kptr

vim +27 drivers/gpu/drm/loongson/lsdc_benchmark.c

    12	
    13	typedef void (*lsdc_copy_proc_t)(struct lsdc_bo *src_bo,
    14					 struct lsdc_bo *dst_bo,
    15					 unsigned int size,
    16					 int n);
    17	
    18	static void lsdc_copy_gtt_to_vram_cpu(struct lsdc_bo *src_bo,
    19					      struct lsdc_bo *dst_bo,
    20					      unsigned int size,
    21					      int n)
    22	{
    23		lsdc_bo_kmap(src_bo);
    24		lsdc_bo_kmap(dst_bo);
    25	
    26		while (n--)
  > 27			memcpy_toio(dst_bo->kptr, src_bo->kptr, size);
    28	
    29		lsdc_bo_kunmap(src_bo);
    30		lsdc_bo_kunmap(dst_bo);
    31	}
    32	
    33	static void lsdc_copy_vram_to_gtt_cpu(struct lsdc_bo *src_bo,
    34					      struct lsdc_bo *dst_bo,
    35					      unsigned int size,
    36					      int n)
    37	{
    38		lsdc_bo_kmap(src_bo);
    39		lsdc_bo_kmap(dst_bo);
    40	
    41		while (n--)
  > 42			memcpy_fromio(dst_bo->kptr, src_bo->kptr, size);
    43	
    44		lsdc_bo_kunmap(src_bo);
    45		lsdc_bo_kunmap(dst_bo);
    46	}
    47	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
