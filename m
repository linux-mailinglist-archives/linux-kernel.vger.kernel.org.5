Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA973806392
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376320AbjLFAlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346659AbjLFAlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:41:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B03135
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701823270; x=1733359270;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4Lgj0BPaS1V9htaB3BAuDxFenX4raVWmyMrGsG6EByU=;
  b=lxbAIAmwknMI+PxXWLU0VOV3YK2eP8vi1f6ncqVBoC4yR5dR9WaqBB+D
   j0XmCF4hXXXt6a7NHFyx+8VDfqZJ4UOvKVR17TeuApSfjUNKwAzxZmGZE
   gsMXSTNi9JwV6/EgRLFpmMss0tmM8HZVl2ZMGAui8foEnogwAerQuU37e
   lPAOgdyM8i06L+3QA7axcqIWKufTMa85T0ybGRCeusq8+2yqPWpHFi+gk
   goQNDMq/nTQpavkH4m2y4Ixyx4uY2nhuclQ0hcTf31KX1V8sBhJZRK2ce
   +yE+yEynUedN1qsSL76+S+PwoSad3HOCDlVjTQ2bNBdHQGUlVNlA56D8Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="12698164"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="12698164"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 16:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841650111"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="841650111"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2023 16:41:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAfyI-0009xy-1B;
        Wed, 06 Dec 2023 00:41:02 +0000
Date:   Wed, 6 Dec 2023 08:40:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:
 sparse: incorrect type in argument 2 (different address spaces)
Message-ID: <202312060821.g8eqRm9E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e powerpc: inline iomap accessors
date:   3 years ago
config: powerpc-randconfig-r113-20231106 (https://download.01.org/0day-ci/archive/20231206/202312060821.g8eqRm9E-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312060821.g8eqRm9E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060821.g8eqRm9E-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     got void *
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     expected void const [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     got void *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[assigned] emap @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:     got void *[assigned] emap
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *map @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:     expected void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:     got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:     got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *map @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:     expected void [noderef] __iomem *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:     got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[assigned] map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     got void *[assigned] map

vim +104 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c

07bbc1c5f49b643 Ben Skeggs 2017-11-01  100  
be55287aa5ba689 Ben Skeggs 2017-11-01  101  static void
be55287aa5ba689 Ben Skeggs 2017-11-01  102  nv50_instobj_wr32(struct nvkm_memory *memory, u64 offset, u32 data)
be55287aa5ba689 Ben Skeggs 2017-11-01  103  {
be55287aa5ba689 Ben Skeggs 2017-11-01 @104  	iowrite32_native(data, nv50_instobj(memory)->map + offset);
be55287aa5ba689 Ben Skeggs 2017-11-01  105  }
be55287aa5ba689 Ben Skeggs 2017-11-01  106  
be55287aa5ba689 Ben Skeggs 2017-11-01  107  static u32
be55287aa5ba689 Ben Skeggs 2017-11-01  108  nv50_instobj_rd32(struct nvkm_memory *memory, u64 offset)
be55287aa5ba689 Ben Skeggs 2017-11-01  109  {
be55287aa5ba689 Ben Skeggs 2017-11-01 @110  	return ioread32_native(nv50_instobj(memory)->map + offset);
be55287aa5ba689 Ben Skeggs 2017-11-01  111  }
be55287aa5ba689 Ben Skeggs 2017-11-01  112  

:::::: The code at line 104 was first introduced by commit
:::::: be55287aa5ba6895e9d4d3ed2f08a1be7a065957 drm/nouveau/imem/nv50: embed nvkm_instobj directly into nv04_instobj

:::::: TO: Ben Skeggs <bskeggs@redhat.com>
:::::: CC: Ben Skeggs <bskeggs@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
