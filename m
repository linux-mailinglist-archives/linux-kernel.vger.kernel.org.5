Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38B07791E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbjHKOa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHKOa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:30:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8862F2728
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691764255; x=1723300255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y8HM4+QIL1Qz6aicWkSwlO6H08dkoJC8TGkzJ+8KK1o=;
  b=TVw33prYQ3oz+nnJQSCNY8IlW2auwH+r5Xn/Dp1ejExpH3YcfaDLIW7j
   qoRB3ktHIgHGqCwvzUy95pITXuxV9duFycEMpWkrnw4iAEfYxvBrZAnhg
   8Fu9h3f/s0P6Y21SCg7QYJoeCw7CplQLFQecDNFxLqfeZoWhVnYvXmYDK
   n1z7X08mossUqVXm+p93sRjmdNWrUpYarCdBMYyNrBMtSyyKJol82xggD
   pd4HDJSY6W7RsyO2ecWtHtqo0At3CVKytXZkTswdMxpl1n3/hx30NjSLI
   CBgbJmuE9G666FapWfF5ZB7F4scNmAGrnzTQx9Hu2Uj40JtLTvoLsjjVV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="435580368"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="435580368"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:30:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="979251331"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="979251331"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Aug 2023 07:30:44 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUTA3-0007pw-0g;
        Fri, 11 Aug 2023 14:30:43 +0000
Date:   Fri, 11 Aug 2023 22:30:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/common/sa1111.c:802: warning: expecting prototype for
 sa1111_probe(). Prototype was for __sa1111_probe() instead
Message-ID: <202308112255.SK1J0rze-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   25aa0bebba72b318e71fe205bfd1236550cc9534
commit: 8faf91c48ca20c714e0dd8cc5f510e3819852912 ARM: sa1100: un-deprecate jornada720
date:   7 months ago
config: arm-jornada720_defconfig (https://download.01.org/0day-ci/archive/20230811/202308112255.SK1J0rze-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230811/202308112255.SK1J0rze-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308112255.SK1J0rze-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/arm/common/sa1111.c:802: warning: Function parameter or member 'me' not described in '__sa1111_probe'
   arch/arm/common/sa1111.c:802: warning: Function parameter or member 'mem' not described in '__sa1111_probe'
   arch/arm/common/sa1111.c:802: warning: Function parameter or member 'irq' not described in '__sa1111_probe'
>> arch/arm/common/sa1111.c:802: warning: expecting prototype for sa1111_probe(). Prototype was for __sa1111_probe() instead

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for SA1100_SSP
   Depends on [n]: ARCH_SA1100 [=y] && UNUSED_BOARD_FILES [=n]
   Selected by [y]:
   - SA1100_JORNADA720_SSP [=y] && ARCH_SA1100 [=y] && SA1100_JORNADA720 [=y]


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
