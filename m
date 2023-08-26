Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44017893BD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 06:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjHZEBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 00:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHZEAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 00:00:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3672698
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 21:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693022447; x=1724558447;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WQoGLO+DxUD1v56xV1IkYJ3w+rw8KOti0D+TWPCD1VU=;
  b=bmlYH89FG1/zwSrpiE6tUJ/l8kQpSoCbldsTlbcGKS5QcfQk5si1uC/6
   RTDH4aC64gP0ctgPgf8+Sa/XJ9o4X+mRkU64kmw49KmQt/oOJyLys8qPY
   lJ/pWBFLIYeXOn4/JGZzuX9XgjKaKSpGAAnk2Q7RWrWy4STS9/iTbbsms
   7DTJdGoCSkOS4BAsuHRjeqCcjUCob3Ry9/BhkI21mDpKGaEo5rBBeeXFF
   XrvzVA6JRR1trCWLB0RMzvSA6k8QoGnmK/VALOTxdTfWzU1yv6Xfke+Oh
   OxMQuZ10pHEE+2wOMTuoO8WW6IuCvdI+HlosCs0tEOE6UlPk2XpCix853
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="461209329"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="461209329"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 21:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="772699502"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="772699502"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Aug 2023 21:00:44 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZkTb-0004Jp-2z;
        Sat, 26 Aug 2023 04:00:43 +0000
Date:   Sat, 26 Aug 2023 12:00:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: arch/arm/common/sa1111.c:802: warning: Function parameter or member
 'me' not described in '__sa1111_probe'
Message-ID: <202308261155.FgVS4Jm3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7d2f353b2682dcfe5f9bc71e5b61d5b61770d98e
commit: 5eb6e280432ddc9b755193552f3a070da8d7455c ARM: 9289/1: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer
date:   7 months ago
config: arm-neponset_defconfig (https://download.01.org/0day-ci/archive/20230826/202308261155.FgVS4Jm3-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230826/202308261155.FgVS4Jm3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308261155.FgVS4Jm3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/arm/common/sa1111.c:802: warning: Function parameter or member 'me' not described in '__sa1111_probe'
>> arch/arm/common/sa1111.c:802: warning: Function parameter or member 'mem' not described in '__sa1111_probe'
>> arch/arm/common/sa1111.c:802: warning: Function parameter or member 'irq' not described in '__sa1111_probe'
   arch/arm/common/sa1111.c:802: warning: expecting prototype for sa1111_probe(). Prototype was for __sa1111_probe() instead
--
>> drivers/gpio/gpio-reg.c:134: warning: Function parameter or member 'reg' not described in 'gpio_reg_init'


vim +802 arch/arm/common/sa1111.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  787  
^1da177e4c3f41 Linus Torvalds     2005-04-16  788  /**
^1da177e4c3f41 Linus Torvalds     2005-04-16  789   *	sa1111_probe - probe for a single SA1111 chip.
^1da177e4c3f41 Linus Torvalds     2005-04-16  790   *	@phys_addr: physical address of device.
^1da177e4c3f41 Linus Torvalds     2005-04-16  791   *
^1da177e4c3f41 Linus Torvalds     2005-04-16  792   *	Probe for a SA1111 chip.  This must be called
^1da177e4c3f41 Linus Torvalds     2005-04-16  793   *	before any other SA1111-specific code.
^1da177e4c3f41 Linus Torvalds     2005-04-16  794   *
^1da177e4c3f41 Linus Torvalds     2005-04-16  795   *	Returns:
^1da177e4c3f41 Linus Torvalds     2005-04-16  796   *	%-ENODEV	device not found.
^1da177e4c3f41 Linus Torvalds     2005-04-16  797   *	%-EBUSY		physical address already marked in-use.
f03ecaa0aa3a3b Russell King       2012-01-16  798   *	%-EINVAL	no platform data passed
^1da177e4c3f41 Linus Torvalds     2005-04-16  799   *	%0		successful.
^1da177e4c3f41 Linus Torvalds     2005-04-16  800   */
351a102dbf489d Greg Kroah-Hartman 2012-12-21  801  static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
^1da177e4c3f41 Linus Torvalds     2005-04-16 @802  {
f03ecaa0aa3a3b Russell King       2012-01-16  803  	struct sa1111_platform_data *pd = me->platform_data;
^1da177e4c3f41 Linus Torvalds     2005-04-16  804  	struct sa1111 *sachip;
^1da177e4c3f41 Linus Torvalds     2005-04-16  805  	unsigned long id;
416112f818afcc David Brownell     2006-08-27  806  	unsigned int has_devs;
^1da177e4c3f41 Linus Torvalds     2005-04-16  807  	int i, ret = -ENODEV;
^1da177e4c3f41 Linus Torvalds     2005-04-16  808  
f03ecaa0aa3a3b Russell King       2012-01-16  809  	if (!pd)
f03ecaa0aa3a3b Russell King       2012-01-16  810  		return -EINVAL;
f03ecaa0aa3a3b Russell King       2012-01-16  811  
7d53c1f01210aa Russell King       2016-09-06  812  	sachip = devm_kzalloc(me, sizeof(struct sa1111), GFP_KERNEL);
^1da177e4c3f41 Linus Torvalds     2005-04-16  813  	if (!sachip)
^1da177e4c3f41 Linus Torvalds     2005-04-16  814  		return -ENOMEM;
^1da177e4c3f41 Linus Torvalds     2005-04-16  815  
deee856a5c6293 Russell King       2016-08-30  816  	sachip->clk = devm_clk_get(me, "SA1111_CLK");
deee856a5c6293 Russell King       2016-08-30  817  	if (IS_ERR(sachip->clk))
deee856a5c6293 Russell King       2016-08-30  818  		return PTR_ERR(sachip->clk);
97d654f8eb4b8f Russell King       2006-03-15  819  
72ae00c970cf1e Russell King       2011-09-22  820  	ret = clk_prepare(sachip->clk);
72ae00c970cf1e Russell King       2011-09-22  821  	if (ret)
deee856a5c6293 Russell King       2016-08-30  822  		return ret;
72ae00c970cf1e Russell King       2011-09-22  823  
^1da177e4c3f41 Linus Torvalds     2005-04-16  824  	spin_lock_init(&sachip->lock);
^1da177e4c3f41 Linus Torvalds     2005-04-16  825  
^1da177e4c3f41 Linus Torvalds     2005-04-16  826  	sachip->dev = me;
^1da177e4c3f41 Linus Torvalds     2005-04-16  827  	dev_set_drvdata(sachip->dev, sachip);
^1da177e4c3f41 Linus Torvalds     2005-04-16  828  
ae99ddbc976572 Russell King       2012-01-26  829  	sachip->pdata = pd;
^1da177e4c3f41 Linus Torvalds     2005-04-16  830  	sachip->phys = mem->start;
^1da177e4c3f41 Linus Torvalds     2005-04-16  831  	sachip->irq = irq;
^1da177e4c3f41 Linus Torvalds     2005-04-16  832  
^1da177e4c3f41 Linus Torvalds     2005-04-16  833  	/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  834  	 * Map the whole region.  This also maps the
^1da177e4c3f41 Linus Torvalds     2005-04-16  835  	 * registers for our children.
^1da177e4c3f41 Linus Torvalds     2005-04-16  836  	 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  837  	sachip->base = ioremap(mem->start, PAGE_SIZE * 2);
^1da177e4c3f41 Linus Torvalds     2005-04-16  838  	if (!sachip->base) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  839  		ret = -ENOMEM;
72ae00c970cf1e Russell King       2011-09-22  840  		goto err_clk_unprep;
^1da177e4c3f41 Linus Torvalds     2005-04-16  841  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  842  
^1da177e4c3f41 Linus Torvalds     2005-04-16  843  	/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  844  	 * Probe for the chip.  Only touch the SBI registers.
^1da177e4c3f41 Linus Torvalds     2005-04-16  845  	 */
a5b549eda2f1f2 Russell King       2016-09-07  846  	id = readl_relaxed(sachip->base + SA1111_SKID);
^1da177e4c3f41 Linus Torvalds     2005-04-16  847  	if ((id & SKID_ID_MASK) != SKID_SA1111_ID) {
^1da177e4c3f41 Linus Torvalds     2005-04-16  848  		printk(KERN_DEBUG "SA1111 not detected: ID = %08lx\n", id);
^1da177e4c3f41 Linus Torvalds     2005-04-16  849  		ret = -ENODEV;
97d654f8eb4b8f Russell King       2006-03-15  850  		goto err_unmap;
^1da177e4c3f41 Linus Torvalds     2005-04-16  851  	}
^1da177e4c3f41 Linus Torvalds     2005-04-16  852  
4ed89f22280614 Russell King       2014-10-28  853  	pr_info("SA1111 Microprocessor Companion Chip: silicon revision %lx, metal revision %lx\n",
4ed89f22280614 Russell King       2014-10-28  854  		(id & SKID_SIREV_MASK) >> 4, id & SKID_MTREV_MASK);
^1da177e4c3f41 Linus Torvalds     2005-04-16  855  
^1da177e4c3f41 Linus Torvalds     2005-04-16  856  	/*
^1da177e4c3f41 Linus Torvalds     2005-04-16  857  	 * We found it.  Wake the chip up, and initialise.
^1da177e4c3f41 Linus Torvalds     2005-04-16  858  	 */
^1da177e4c3f41 Linus Torvalds     2005-04-16  859  	sa1111_wake(sachip);
^1da177e4c3f41 Linus Torvalds     2005-04-16  860  
36d31213022850 Russell King       2012-01-24  861  	/*
36d31213022850 Russell King       2012-01-24  862  	 * The interrupt controller must be initialised before any
36d31213022850 Russell King       2012-01-24  863  	 * other device to ensure that the interrupts are available.
36d31213022850 Russell King       2012-01-24  864  	 */
36d31213022850 Russell King       2012-01-24  865  	ret = sa1111_setup_irq(sachip, pd->irq_base);
36d31213022850 Russell King       2012-01-24  866  	if (ret)
87d5dd62c07f90 Russell King       2016-09-06  867  		goto err_clk;
36d31213022850 Russell King       2012-01-24  868  
17cf50116e10af Russell King       2016-08-31  869  	/* Setup the GPIOs - should really be done after the IRQ setup */
17cf50116e10af Russell King       2016-08-31  870  	ret = sa1111_setup_gpios(sachip);
17cf50116e10af Russell King       2016-08-31  871  	if (ret)
17cf50116e10af Russell King       2016-08-31  872  		goto err_irq;
17cf50116e10af Russell King       2016-08-31  873  

:::::: The code at line 802 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
