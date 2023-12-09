Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A878580B602
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 20:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjLITSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 14:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLITSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 14:18:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6195CA2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 11:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702149489; x=1733685489;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FSiTq+R7K6AtJ/tXHCs+/XVoB/rsfopmIkdivPR1OZU=;
  b=g8hVf07VsnltFbnA+LQJXAhfDGuqhEcZuv3+E3uYYuwJl2sJDTrMc4nJ
   LkQmpbxLYw8pQUgT0M9BIiaRItngt76sYHEyL/kbNb2fx2Va/WeqaSWHq
   esZ8rhCJWm3Ely4H16nyfqKn210ID6BTn8RX2mC7y2kaNzluF0rUrRU43
   PXmafjUVB1OYZZWkLRwPPYcmsCkUzu3UqjJvLzvPi5QwuiRf0Fwg1ss5v
   ONIcFsPmg9K3HjYte//61lrH0q7R4G+OYhyKmmiyJp2cgL/0eBoMz51Cs
   SV1MiXTXC0BIr8MTcon8M2YP6n7+uaBeermPBhS1c5Oi5cdNx8ARsMiHS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="1396771"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="1396771"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 11:18:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="838483692"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="838483692"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2023 11:18:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC2px-000Fov-1c;
        Sat, 09 Dec 2023 19:18:05 +0000
Date:   Sun, 10 Dec 2023 03:17:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202312100315.ToF8OHaM-lkp@intel.com>
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
head:   f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e
commit: f39db26c54281da6a785259498ca74b5e470476f drm: Add kms driver for loongson display controller
date:   5 months ago
config: powerpc-randconfig-r113-20231106 (https://download.01.org/0day-ci/archive/20231210/202312100315.ToF8OHaM-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231210/202312100315.ToF8OHaM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100315.ToF8OHaM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got void *kptr @@
   drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35: sparse:     expected void volatile [noderef] __iomem *d
   drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35: sparse:     got void *kptr
>> drivers/gpu/drm/loongson/lsdc_benchmark.c:42:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got void *kptr @@
   drivers/gpu/drm/loongson/lsdc_benchmark.c:42:51: sparse:     expected void const volatile [noderef] __iomem *s
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
