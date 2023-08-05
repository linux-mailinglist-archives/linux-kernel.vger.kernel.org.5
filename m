Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22097770CB9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 02:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjHEAfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 20:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjHEAfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 20:35:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB1546B3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 17:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691195700; x=1722731700;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PX8h316IUNx7SbXQVu0PIA1xTMpFKHufAY5eTFI+CuM=;
  b=GmMNBa2Oeq7PzN4mbT+pR4uyt8l+ZgEAkWnQlmB5H605OgLEOnkjKjVE
   F0X7ZIXfdiJuVHU5qTvNOsxb2rb/K5zJ0TQOLdjM1zek1/0s5r0YfGzLg
   t15mlpTsWWBadbU0YE3eXMHTsVTkbHeoQGulyY221HmWtkbiYCi/eTzxp
   pw5Et1h70eKTn0q2SWU2kDTqkCRa6uQOI0B68xh6K6+mcipLuqkO8wvA7
   VazZe04yXAWWJ5kgqDjXXqmA9T2KZtL/MVtKYUQkkmRijqiAC/ijnq46o
   dQHANsRvXd/DmhglifR7JghFKsJ+uaO5dEK5vIaSYSB1XHcCsHDInWubt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="369171156"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="369171156"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 17:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="873594263"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2023 17:35:00 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qS5Fx-0003DT-0W;
        Sat, 05 Aug 2023 00:34:57 +0000
Date:   Sat, 5 Aug 2023 08:34:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: arch/arm/common/locomo.c:368: warning: expecting prototype for
 locomo_probe(). Prototype was for __locomo_probe() instead
Message-ID: <202308050851.zAvHe6y7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e6fda526d9db2c7897dacb9daff8c80e13ce893d
commit: 5eb6e280432ddc9b755193552f3a070da8d7455c ARM: 9289/1: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer
date:   6 months ago
config: arm-collie_defconfig (https://download.01.org/0day-ci/archive/20230805/202308050851.zAvHe6y7-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230805/202308050851.zAvHe6y7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308050851.zAvHe6y7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm/common/locomo.c:368: warning: Function parameter or member 'me' not described in '__locomo_probe'
   arch/arm/common/locomo.c:368: warning: Function parameter or member 'mem' not described in '__locomo_probe'
   arch/arm/common/locomo.c:368: warning: Function parameter or member 'irq' not described in '__locomo_probe'
>> arch/arm/common/locomo.c:368: warning: expecting prototype for locomo_probe(). Prototype was for __locomo_probe() instead
--
>> drivers/pcmcia/pxa2xx_sharpsl.c:206:5: warning: no previous prototype for function 'pcmcia_collie_init' [-Wmissing-prototypes]
     206 | int pcmcia_collie_init(struct device *dev)
         |     ^
   drivers/pcmcia/pxa2xx_sharpsl.c:206:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     206 | int pcmcia_collie_init(struct device *dev)
         | ^
         | static 
   1 warning generated.


vim +368 arch/arm/common/locomo.c

b38d950d3aedf9 John Lenz         2005-09-08  352  
4ebf2d00260bac Pavel Machek      2006-03-15  353  
^1da177e4c3f41 Linus Torvalds    2005-04-16  354  /**
^1da177e4c3f41 Linus Torvalds    2005-04-16  355   *	locomo_probe - probe for a single LoCoMo chip.
^1da177e4c3f41 Linus Torvalds    2005-04-16  356   *	@phys_addr: physical address of device.
^1da177e4c3f41 Linus Torvalds    2005-04-16  357   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  358   *	Probe for a LoCoMo chip.  This must be called
^1da177e4c3f41 Linus Torvalds    2005-04-16  359   *	before any other locomo-specific code.
^1da177e4c3f41 Linus Torvalds    2005-04-16  360   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  361   *	Returns:
^1da177e4c3f41 Linus Torvalds    2005-04-16  362   *	%-ENODEV	device not found.
^1da177e4c3f41 Linus Torvalds    2005-04-16  363   *	%-EBUSY		physical address already marked in-use.
^1da177e4c3f41 Linus Torvalds    2005-04-16  364   *	%0		successful.
^1da177e4c3f41 Linus Torvalds    2005-04-16  365   */
^1da177e4c3f41 Linus Torvalds    2005-04-16  366  static int
^1da177e4c3f41 Linus Torvalds    2005-04-16  367  __locomo_probe(struct device *me, struct resource *mem, int irq)
^1da177e4c3f41 Linus Torvalds    2005-04-16 @368  {
ac609d266e4af4 Eric Miao         2010-02-04  369  	struct locomo_platform_data *pdata = me->platform_data;
^1da177e4c3f41 Linus Torvalds    2005-04-16  370  	struct locomo *lchip;
^1da177e4c3f41 Linus Torvalds    2005-04-16  371  	unsigned long r;
^1da177e4c3f41 Linus Torvalds    2005-04-16  372  	int i, ret = -ENODEV;
^1da177e4c3f41 Linus Torvalds    2005-04-16  373  
d2a02b93cf7820 Russell King      2006-03-20  374  	lchip = kzalloc(sizeof(struct locomo), GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  375  	if (!lchip)
^1da177e4c3f41 Linus Torvalds    2005-04-16  376  		return -ENOMEM;
^1da177e4c3f41 Linus Torvalds    2005-04-16  377  
^1da177e4c3f41 Linus Torvalds    2005-04-16  378  	spin_lock_init(&lchip->lock);
^1da177e4c3f41 Linus Torvalds    2005-04-16  379  
^1da177e4c3f41 Linus Torvalds    2005-04-16  380  	lchip->dev = me;
^1da177e4c3f41 Linus Torvalds    2005-04-16  381  	dev_set_drvdata(lchip->dev, lchip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  382  
^1da177e4c3f41 Linus Torvalds    2005-04-16  383  	lchip->phys = mem->start;
^1da177e4c3f41 Linus Torvalds    2005-04-16  384  	lchip->irq = irq;
ac609d266e4af4 Eric Miao         2010-02-04  385  	lchip->irq_base = (pdata) ? pdata->irq_base : NO_IRQ;
^1da177e4c3f41 Linus Torvalds    2005-04-16  386  
^1da177e4c3f41 Linus Torvalds    2005-04-16  387  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  388  	 * Map the whole region.  This also maps the
^1da177e4c3f41 Linus Torvalds    2005-04-16  389  	 * registers for our children.
^1da177e4c3f41 Linus Torvalds    2005-04-16  390  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  391  	lchip->base = ioremap(mem->start, PAGE_SIZE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  392  	if (!lchip->base) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  393  		ret = -ENOMEM;
^1da177e4c3f41 Linus Torvalds    2005-04-16  394  		goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  395  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  396  
^1da177e4c3f41 Linus Torvalds    2005-04-16  397  	/* locomo initialize */
^1da177e4c3f41 Linus Torvalds    2005-04-16  398  	locomo_writel(0, lchip->base + LOCOMO_ICR);
^1da177e4c3f41 Linus Torvalds    2005-04-16  399  	/* KEYBOARD */
^1da177e4c3f41 Linus Torvalds    2005-04-16  400  	locomo_writel(0, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  401  
^1da177e4c3f41 Linus Torvalds    2005-04-16  402  	/* GPIO */
^1da177e4c3f41 Linus Torvalds    2005-04-16  403  	locomo_writel(0, lchip->base + LOCOMO_GPO);
2a52efb2cecf78 Thomas Kunze      2008-04-29  404  	locomo_writel((LOCOMO_GPIO(1) | LOCOMO_GPIO(2) | LOCOMO_GPIO(13) | LOCOMO_GPIO(14))
^1da177e4c3f41 Linus Torvalds    2005-04-16  405  			, lchip->base + LOCOMO_GPE);
2a52efb2cecf78 Thomas Kunze      2008-04-29  406  	locomo_writel((LOCOMO_GPIO(1) | LOCOMO_GPIO(2) | LOCOMO_GPIO(13) | LOCOMO_GPIO(14))
^1da177e4c3f41 Linus Torvalds    2005-04-16  407  			, lchip->base + LOCOMO_GPD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  408  	locomo_writel(0, lchip->base + LOCOMO_GIE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  409  
e4423781850025 Richard Purdie    2006-06-26  410  	/* Frontlight */
^1da177e4c3f41 Linus Torvalds    2005-04-16  411  	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
^1da177e4c3f41 Linus Torvalds    2005-04-16  412  	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
4ebf2d00260bac Pavel Machek      2006-03-15  413  
^1da177e4c3f41 Linus Torvalds    2005-04-16  414  	/* Longtime timer */
^1da177e4c3f41 Linus Torvalds    2005-04-16  415  	locomo_writel(0, lchip->base + LOCOMO_LTINT);
^1da177e4c3f41 Linus Torvalds    2005-04-16  416  	/* SPI */
1b0d76cb9d5a65 H Hartley Sweeten 2010-03-22  417  	locomo_writel(0, lchip->base + LOCOMO_SPI + LOCOMO_SPIIE);
^1da177e4c3f41 Linus Torvalds    2005-04-16  418  
^1da177e4c3f41 Linus Torvalds    2005-04-16  419  	locomo_writel(6 + 8 + 320 + 30 - 10, lchip->base + LOCOMO_ASD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  420  	r = locomo_readl(lchip->base + LOCOMO_ASD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  421  	r |= 0x8000;
^1da177e4c3f41 Linus Torvalds    2005-04-16  422  	locomo_writel(r, lchip->base + LOCOMO_ASD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  423  
^1da177e4c3f41 Linus Torvalds    2005-04-16  424  	locomo_writel(6 + 8 + 320 + 30 - 10 - 128 + 4, lchip->base + LOCOMO_HSD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  425  	r = locomo_readl(lchip->base + LOCOMO_HSD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  426  	r |= 0x8000;
^1da177e4c3f41 Linus Torvalds    2005-04-16  427  	locomo_writel(r, lchip->base + LOCOMO_HSD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  428  
^1da177e4c3f41 Linus Torvalds    2005-04-16  429  	locomo_writel(128 / 8, lchip->base + LOCOMO_HSC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  430  
^1da177e4c3f41 Linus Torvalds    2005-04-16  431  	/* XON */
^1da177e4c3f41 Linus Torvalds    2005-04-16  432  	locomo_writel(0x80, lchip->base + LOCOMO_TADC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  433  	udelay(1000);
^1da177e4c3f41 Linus Torvalds    2005-04-16  434  	/* CLK9MEN */
^1da177e4c3f41 Linus Torvalds    2005-04-16  435  	r = locomo_readl(lchip->base + LOCOMO_TADC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  436  	r |= 0x10;
^1da177e4c3f41 Linus Torvalds    2005-04-16  437  	locomo_writel(r, lchip->base + LOCOMO_TADC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  438  	udelay(100);
^1da177e4c3f41 Linus Torvalds    2005-04-16  439  
^1da177e4c3f41 Linus Torvalds    2005-04-16  440  	/* init DAC */
^1da177e4c3f41 Linus Torvalds    2005-04-16  441  	r = locomo_readl(lchip->base + LOCOMO_DAC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  442  	r |= LOCOMO_DAC_SCLOEB | LOCOMO_DAC_SDAOEB;
^1da177e4c3f41 Linus Torvalds    2005-04-16  443  	locomo_writel(r, lchip->base + LOCOMO_DAC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  444  
^1da177e4c3f41 Linus Torvalds    2005-04-16  445  	r = locomo_readl(lchip->base + LOCOMO_VER);
^1da177e4c3f41 Linus Torvalds    2005-04-16  446  	printk(KERN_INFO "LoCoMo Chip: %lu%lu\n", (r >> 8), (r & 0xff));
^1da177e4c3f41 Linus Torvalds    2005-04-16  447  
^1da177e4c3f41 Linus Torvalds    2005-04-16  448  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  449  	 * The interrupt controller must be initialised before any
^1da177e4c3f41 Linus Torvalds    2005-04-16  450  	 * other device to ensure that the interrupts are available.
^1da177e4c3f41 Linus Torvalds    2005-04-16  451  	 */
ac609d266e4af4 Eric Miao         2010-02-04  452  	if (lchip->irq != NO_IRQ && lchip->irq_base != NO_IRQ)
^1da177e4c3f41 Linus Torvalds    2005-04-16  453  		locomo_setup_irq(lchip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  454  
^1da177e4c3f41 Linus Torvalds    2005-04-16  455  	for (i = 0; i < ARRAY_SIZE(locomo_devices); i++)
^1da177e4c3f41 Linus Torvalds    2005-04-16  456  		locomo_init_one_child(lchip, &locomo_devices[i]);
^1da177e4c3f41 Linus Torvalds    2005-04-16  457  	return 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  458  
^1da177e4c3f41 Linus Torvalds    2005-04-16  459   out:
^1da177e4c3f41 Linus Torvalds    2005-04-16  460  	kfree(lchip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  461  	return ret;
^1da177e4c3f41 Linus Torvalds    2005-04-16  462  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  463  

:::::: The code at line 368 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
