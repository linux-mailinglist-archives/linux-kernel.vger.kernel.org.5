Return-Path: <linux-kernel+bounces-19829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC10E8274D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3251B1F210AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC8853807;
	Mon,  8 Jan 2024 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGR2s7QZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ED453E11;
	Mon,  8 Jan 2024 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704730582; x=1736266582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=251D0xs+2EVLtHQUAaCVy+BCj5c0RfrNYEzxjBj2mwc=;
  b=jGR2s7QZznRPRB/u+G9Xurag3yOC+DnnU1d76GJ6pWQ3ZmwOhrnzTv12
   WttNeoQRmgvsklVG7myI/ZHBLWPqbX7YxhqqBd2xykn46ctAfq0WTwN8S
   LqG4YAmHUyv9lStY73oczngpeREs6VQtEovXVOuL7DGs+BQV3ndTLgDav
   yvYxlab2pt2+HPEkCzSt1qQvCORilX4aKHq3j3LY7240bHrgJF4KpHKOv
   GrrlqNrjiDDEw3sj3zSoghGeVdA1urvklJFKGAZhNlDYMMd/UHlDhJcdW
   mRjZhmZW5mBr5LvUg4F2AdMz3P0AK3xtNd5HZalL8t8RXSFmqlkcZfGR3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="16522184"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="16522184"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 08:16:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="757660582"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="757660582"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Jan 2024 08:16:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMsIL-0004rK-37;
	Mon, 08 Jan 2024 16:16:09 +0000
Date: Tue, 9 Jan 2024 00:15:56 +0800
From: kernel test robot <lkp@intel.com>
To: Elad Nachman <enachman@marvell.com>, stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, enachman@marvell.com
Subject: Re: [PATCH] usb: host: Add ac5 to EHCI Orion
Message-ID: <202401090012.KFgRr4iR-lkp@intel.com>
References: <20240107163307.3677347-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240107163307.3677347-1-enachman@marvell.com>

Hi Elad,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus westeri-thunderbolt/next linus/master v6.7 next-20240108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elad-Nachman/usb-host-Add-ac5-to-EHCI-Orion/20240108-003512
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240107163307.3677347-1-enachman%40marvell.com
patch subject: [PATCH] usb: host: Add ac5 to EHCI Orion
config: s390-randconfig-r071-20240108 (https://download.01.org/0day-ci/archive/20240109/202401090012.KFgRr4iR-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 7e186d366d6c7def0543acc255931f617e76dff0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401090012.KFgRr4iR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401090012.KFgRr4iR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/usb/host/ehci-orion.c:18:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/usb/host/ehci-orion.c:18:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/usb/host/ehci-orion.c:18:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/usb/host/ehci-orion.c:241:15: error: assigning to 'u64 *' (aka 'unsigned long long *') from 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
     241 |         dma_mask_ptr = of_device_get_match_data(&pdev->dev);
         |                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   12 warnings and 1 error generated.


vim +241 drivers/usb/host/ehci-orion.c

   211	
   212	static int ehci_orion_drv_probe(struct platform_device *pdev)
   213	{
   214		struct orion_ehci_data *pd = dev_get_platdata(&pdev->dev);
   215		const struct mbus_dram_target_info *dram;
   216		struct resource *res;
   217		struct usb_hcd *hcd;
   218		struct ehci_hcd *ehci;
   219		void __iomem *regs;
   220		int irq, err;
   221		enum orion_ehci_phy_ver phy_version;
   222		struct orion_ehci_hcd *priv;
   223		u64 *dma_mask_ptr;
   224	
   225		if (usb_disabled())
   226			return -ENODEV;
   227	
   228		pr_debug("Initializing Orion-SoC USB Host Controller\n");
   229	
   230		irq = platform_get_irq(pdev, 0);
   231		if (irq < 0) {
   232			err = irq;
   233			goto err;
   234		}
   235	
   236		/*
   237		 * Right now device-tree probed devices don't get dma_mask
   238		 * set. Since shared usb code relies on it, set it here for
   239		 * now. Once we have dma capability bindings this can go away.
   240		 */
 > 241		dma_mask_ptr = of_device_get_match_data(&pdev->dev);
   242		err = dma_coerce_mask_and_coherent(&pdev->dev, *dma_mask_ptr);
   243		if (err)
   244			goto err;
   245	
   246		regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
   247		if (IS_ERR(regs)) {
   248			err = PTR_ERR(regs);
   249			goto err;
   250		}
   251	
   252		hcd = usb_create_hcd(&ehci_orion_hc_driver,
   253				&pdev->dev, dev_name(&pdev->dev));
   254		if (!hcd) {
   255			err = -ENOMEM;
   256			goto err;
   257		}
   258	
   259		hcd->rsrc_start = res->start;
   260		hcd->rsrc_len = resource_size(res);
   261		hcd->regs = regs;
   262	
   263		ehci = hcd_to_ehci(hcd);
   264		ehci->caps = hcd->regs + 0x100;
   265		hcd->has_tt = 1;
   266	
   267		priv = hcd_to_orion_priv(hcd);
   268		/*
   269		 * Not all platforms can gate the clock, so it is not an error if
   270		 * the clock does not exists.
   271		 */
   272		priv->clk = devm_clk_get(&pdev->dev, NULL);
   273		if (!IS_ERR(priv->clk)) {
   274			err = clk_prepare_enable(priv->clk);
   275			if (err)
   276				goto err_put_hcd;
   277		}
   278	
   279		priv->phy = devm_phy_optional_get(&pdev->dev, "usb");
   280		if (IS_ERR(priv->phy)) {
   281			err = PTR_ERR(priv->phy);
   282			if (err != -ENOSYS)
   283				goto err_dis_clk;
   284		}
   285	
   286		/*
   287		 * (Re-)program MBUS remapping windows if we are asked to.
   288		 */
   289		dram = mv_mbus_dram_info();
   290		if (dram)
   291			ehci_orion_conf_mbus_windows(hcd, dram);
   292	
   293		/*
   294		 * setup Orion USB controller.
   295		 */
   296		if (pdev->dev.of_node)
   297			phy_version = EHCI_PHY_NA;
   298		else
   299			phy_version = pd->phy_version;
   300	
   301		switch (phy_version) {
   302		case EHCI_PHY_NA:	/* dont change USB phy settings */
   303			break;
   304		case EHCI_PHY_ORION:
   305			orion_usb_phy_v1_setup(hcd);
   306			break;
   307		case EHCI_PHY_DD:
   308		case EHCI_PHY_KW:
   309		default:
   310			dev_warn(&pdev->dev, "USB phy version isn't supported.\n");
   311		}
   312	
   313		err = usb_add_hcd(hcd, irq, IRQF_SHARED);
   314		if (err)
   315			goto err_dis_clk;
   316	
   317		device_wakeup_enable(hcd->self.controller);
   318		return 0;
   319	
   320	err_dis_clk:
   321		if (!IS_ERR(priv->clk))
   322			clk_disable_unprepare(priv->clk);
   323	err_put_hcd:
   324		usb_put_hcd(hcd);
   325	err:
   326		dev_err(&pdev->dev, "init %s fail, %d\n",
   327			dev_name(&pdev->dev), err);
   328	
   329		return err;
   330	}
   331	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

