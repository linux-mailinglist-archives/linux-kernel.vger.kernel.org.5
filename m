Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EF57F98F9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjK0F6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjK0F6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:58:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A505FC1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 21:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701064708; x=1732600708;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RhyW4+Mhi0cJL2MXZ/zTtjv+hnfL+CvGrjxiHhcx898=;
  b=ji53LW4aLBBt2maEY0KD+WfQ8VXD4wrj4x6m9n/583fvgvco9HTBEaMQ
   v5G1o3WlcGtAp9dwBdTqMGTJHcxFFGNKvkMqxDgPMxHcf52B9tWjqV/1d
   PTWUbGpSdq/jAW6yQx6/nJMGoeenOSDVwsLoJRG3d8eqKTXCJPjmg/KEN
   oplRptHHjEi22VhT9Ir2VImaYHmkFuv/z+1+o2YBhzGmH+5WbFD+6+Pfi
   3UopfYni/nXYdwXy2TNqU34O9a/f5pbYgFfTi/tz3XEMniQ/BsWKLTQDE
   3y4FGxZcj50Fpf7nKuPfEcFMaab4X2UEzayjYcWzKrQARK5xxKke+Jjam
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="5824470"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="5824470"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 21:58:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="834224092"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="834224092"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Nov 2023 21:58:23 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r7UdR-0005s2-1D;
        Mon, 27 Nov 2023 05:58:21 +0000
Date:   Mon, 27 Nov 2023 13:57:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse: sparse:
 incorrect type in argument 2 (different address spaces)
Message-ID: <202311271238.cLKdFm8M-lkp@intel.com>
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
head:   2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
commit: 90db9dbedd26ce029f3a0f8d2cbd3a142f452408 kasan, powerpc: don't rename memintrinsics if compiler adds prefixes
date:   8 months ago
config: powerpc-randconfig-r131-20231127 (https://download.01.org/0day-ci/archive/20231127/202311271238.cLKdFm8M-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231127/202311271238.cLKdFm8M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311271238.cLKdFm8M-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/powerpc/platforms/512x/mpc512x_shared.c:239:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:239:25: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:239:25: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c:245:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:245:38: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:245:38: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] vaddr @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse:     expected void const *
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse:     got void [noderef] __iomem *[assigned] vaddr
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] vaddr @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse:     expected void const *
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse:     got void [noderef] __iomem *[assigned] vaddr
>> arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got void [noderef] __iomem *[assigned] vaddr @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse:     expected void const *q
   arch/powerpc/platforms/512x/mpc512x_shared.c:251:9: sparse:     got void [noderef] __iomem *[assigned] vaddr
   arch/powerpc/platforms/512x/mpc512x_shared.c:256:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:256:24: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:256:24: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c:264:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:264:25: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:264:25: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] vaddr @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse:     expected void const *
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse:     got void [noderef] __iomem *[assigned] vaddr
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *[assigned] vaddr @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse:     expected void const *
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse:     got void [noderef] __iomem *[assigned] vaddr
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *q @@     got void [noderef] __iomem *[assigned] vaddr @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse:     expected void const *q
   arch/powerpc/platforms/512x/mpc512x_shared.c:271:9: sparse:     got void [noderef] __iomem *[assigned] vaddr
   arch/powerpc/platforms/512x/mpc512x_shared.c:277:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:277:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:277:19: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c:278:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:278:32: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:278:32: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c:279:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:279:32: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:279:32: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c:280:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/512x/mpc512x_shared.c:280:32: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/512x/mpc512x_shared.c:280:32: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/512x/mpc512x_shared.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:246:46: sparse: sparse: self-comparison always evaluates to false

vim +251 arch/powerpc/platforms/512x/mpc512x_shared.c

4b5006ec7bb73c Anatolij Gustschin 2010-07-23  208  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  209  /*
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  210   * Check if DIU was pre-initialized. If so, perform steps
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  211   * needed to continue displaying through the whole boot process.
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  212   * Move area descriptor and gamma table elsewhere, they are
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  213   * destroyed by bootmem allocator otherwise. The frame buffer
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  214   * address range will be reserved in setup_arch() after bootmem
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  215   * allocator is up.
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  216   */
7e198197ec878c Brian Norris       2013-10-11  217  static void __init mpc512x_init_diu(void)
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  218  {
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  219  	struct device_node *np;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  220  	struct diu __iomem *diu_reg;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  221  	phys_addr_t desc;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  222  	void __iomem *vaddr;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  223  	unsigned long mode, pix_fmt, res, bpp;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  224  	unsigned long dst;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  225  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  226  	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-diu");
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  227  	if (!np) {
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  228  		pr_err("No DIU node\n");
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  229  		return;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  230  	}
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  231  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  232  	diu_reg = of_iomap(np, 0);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  233  	of_node_put(np);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  234  	if (!diu_reg) {
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  235  		pr_err("Can't map DIU\n");
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  236  		return;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  237  	}
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  238  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  239  	mode = in_be32(&diu_reg->diu_mode);
c4e5a0232763db Timur Tabi         2011-09-28  240  	if (mode == MFB_MODE0) {
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  241  		pr_info("%s: DIU OFF\n", __func__);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  242  		goto out;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  243  	}
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  244  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  245  	desc = in_be32(&diu_reg->desc[0]);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  246  	vaddr = ioremap(desc, sizeof(struct diu_ad));
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  247  	if (!vaddr) {
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  248  		pr_err("Can't map DIU area desc.\n");
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  249  		goto out;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  250  	}
4b5006ec7bb73c Anatolij Gustschin 2010-07-23 @251  	memcpy(&diu_shared_fb.ad0, vaddr, sizeof(struct diu_ad));
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  252  	/* flush fb area descriptor */
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  253  	dst = (unsigned long)&diu_shared_fb.ad0;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  254  	flush_dcache_range(dst, dst + sizeof(struct diu_ad) - 1);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  255  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  256  	res = in_be32(&diu_reg->disp_size);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  257  	pix_fmt = in_le32(vaddr);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  258  	bpp = ((pix_fmt >> 16) & 0x3) + 1;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  259  	diu_shared_fb.fb_phys = in_le32(vaddr + 4);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  260  	diu_shared_fb.fb_len = ((res & 0xfff0000) >> 16) * (res & 0xfff) * bpp;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  261  	diu_shared_fb.in_use = true;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  262  	iounmap(vaddr);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  263  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  264  	desc = in_be32(&diu_reg->gamma);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  265  	vaddr = ioremap(desc, sizeof(diu_shared_fb.gamma));
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  266  	if (!vaddr) {
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  267  		pr_err("Can't map DIU area desc.\n");
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  268  		diu_shared_fb.in_use = false;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  269  		goto out;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  270  	}
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  271  	memcpy(&diu_shared_fb.gamma, vaddr, sizeof(diu_shared_fb.gamma));
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  272  	/* flush gamma table */
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  273  	dst = (unsigned long)&diu_shared_fb.gamma;
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  274  	flush_dcache_range(dst, dst + sizeof(diu_shared_fb.gamma) - 1);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  275  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  276  	iounmap(vaddr);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  277  	out_be32(&diu_reg->gamma, virt_to_phys(&diu_shared_fb.gamma));
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  278  	out_be32(&diu_reg->desc[1], 0);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  279  	out_be32(&diu_reg->desc[2], 0);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  280  	out_be32(&diu_reg->desc[0], virt_to_phys(&diu_shared_fb.ad0));
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  281  
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  282  out:
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  283  	iounmap(diu_reg);
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  284  }
4b5006ec7bb73c Anatolij Gustschin 2010-07-23  285  

:::::: The code at line 251 was first introduced by commit
:::::: 4b5006ec7bb73cd9d4c8a723d484b4c87fad4123 powerpc/5121: shared DIU framebuffer support

:::::: TO: Anatolij Gustschin <agust@denx.de>
:::::: CC: Grant Likely <grant.likely@secretlab.ca>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
