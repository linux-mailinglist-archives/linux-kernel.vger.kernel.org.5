Return-Path: <linux-kernel+bounces-1771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CD28153C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E690287437
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96E520EC;
	Fri, 15 Dec 2023 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iXFuaSqL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF318EBF;
	Fri, 15 Dec 2023 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702679794; x=1734215794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=81ICkebormZ0Z0Ct1dTYfN2Re+TIgDgSB9gIT28pAKg=;
  b=iXFuaSqLd1s2hyXfHgq8AZegeGD8JmnE0qmwz0D3pG4LbVSp/mirfLUB
   qeZlfp+1j5xWa+KRmfawDFlkIq5MDuQL8DTBXeIwyooDQEVLZhWbOAg0D
   odrNwhcpqa8tqAYzH+VVgiZt8N+wkCGbqd5oYT8akdzsRcOsEyQ8RaJ9K
   WYvzvENJN6EJmhuCcdkQOrFs7Sf0ntPZdHS4LNRFIuRKKxrKl/T3TGhx9
   2YR713Rtb3BYsLErOnwr+XzuhzZIF2f76Z5NE2SR8wQFSolcwJNpPZK5S
   P9zoldvuqldRX6YPEE1C3FcDg+krJieNnzqRhCi3Ovvgl+XlHQpatLCqr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="16891900"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="16891900"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 14:36:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="768144404"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="768144404"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2023 14:36:26 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEGnA-0000r2-15;
	Fri, 15 Dec 2023 22:36:24 +0000
Date: Sat, 16 Dec 2023 06:35:39 +0800
From: kernel test robot <lkp@intel.com>
To: Elad Nachman <enachman@marvell.com>, wim@linux-watchdog.org,
	linux@roeck-us.net, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	gregory.clement@bootlin.com, chris.packham@alliedtelesis.co.nz,
	andrew@lunn.ch, fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com,
	al.stone@linaro.org, timur@codeaurora.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	enachman@marvell.com, cyuval@marvell.com
Subject: Re: [PATCH 3/3] watchdog: sbsa_gwdt: add support for Marvell ac5
Message-ID: <202312160648.h1CrZxtx-lkp@intel.com>
References: <20231214150414.1849058-4-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214150414.1849058-4-enachman@marvell.com>

Hi Elad,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on groeck-staging/hwmon-next linus/master v6.7-rc5 next-20231215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elad-Nachman/dt-bindings-watchdog-add-Marvell-AC5-watchdog/20231214-230812
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231214150414.1849058-4-enachman%40marvell.com
patch subject: [PATCH 3/3] watchdog: sbsa_gwdt: add support for Marvell ac5
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231216/202312160648.h1CrZxtx-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312160648.h1CrZxtx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160648.h1CrZxtx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/watchdog/sbsa_gwdt.c:434:11: error: incompatible integer to pointer conversion assigning to 'void *' from 'resource_size_t' (aka 'unsigned long long') [-Wint-conversion]
     434 |                 cf_base = res->start;
         |                         ^ ~~~~~~~~~~
   drivers/watchdog/sbsa_gwdt.c:439:11: error: incompatible integer to pointer conversion assigning to 'void *' from 'resource_size_t' (aka 'unsigned long long') [-Wint-conversion]
     439 |                 rf_base = res->start;
         |                         ^ ~~~~~~~~~~
   drivers/watchdog/sbsa_gwdt.c:444:17: error: incompatible integer to pointer conversion assigning to 'void *' from 'resource_size_t' (aka 'unsigned long long') [-Wint-conversion]
     444 |                 cpu_ctrl_base = res->start;
         |                               ^ ~~~~~~~~~~
   3 errors generated.


vim +434 drivers/watchdog/sbsa_gwdt.c

   408	
   409	static int sbsa_gwdt_probe(struct platform_device *pdev)
   410	{
   411		void __iomem *rf_base, *cf_base;
   412		void __iomem *cpu_ctrl_base = NULL, *mng_base = NULL,
   413			     *rst_ctrl_base = NULL;
   414		struct device *dev = &pdev->dev;
   415		struct device_node *np = pdev->dev.of_node;
   416		struct watchdog_device *wdd;
   417		struct sbsa_gwdt *gwdt;
   418		struct resource *res;
   419		int ret, irq;
   420		bool marvell = false;
   421		u32 status, id, val;
   422	
   423		gwdt = devm_kzalloc(dev, sizeof(*gwdt), GFP_KERNEL);
   424		if (!gwdt)
   425			return -ENOMEM;
   426		platform_set_drvdata(pdev, gwdt);
   427	
   428		if (of_device_is_compatible(np, "marvell,ac5-wd")) {
   429			marvell = true;
   430			gwdt->soc_reg_ops = &smc_reg_ops;
   431			res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   432			if (IS_ERR(res))
   433				return PTR_ERR(res);
 > 434			cf_base = res->start;
   435	
   436			res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
   437			if (IS_ERR(res))
   438				return PTR_ERR(res);
   439			rf_base = res->start;
   440	
   441			res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
   442			if (IS_ERR(res))
   443				return PTR_ERR(res);
   444			cpu_ctrl_base = res->start;
   445			mng_base = devm_platform_ioremap_resource(pdev, 3);
   446			if (IS_ERR(mng_base))
   447				return PTR_ERR(mng_base);
   448			rst_ctrl_base = devm_platform_ioremap_resource(pdev, 4);
   449			if (IS_ERR(rst_ctrl_base))
   450				return PTR_ERR(rst_ctrl_base);
   451		} else {
   452			gwdt->soc_reg_ops = &direct_reg_ops;
   453			cf_base = devm_platform_ioremap_resource(pdev, 0);
   454			if (IS_ERR(cf_base))
   455				return PTR_ERR(cf_base);
   456	
   457			rf_base = devm_platform_ioremap_resource(pdev, 1);
   458			if (IS_ERR(rf_base))
   459				return PTR_ERR(rf_base);
   460		}
   461	
   462		/*
   463		 * Get the frequency of system counter from the cp15 interface of ARM
   464		 * Generic timer. We don't need to check it, because if it returns "0",
   465		 * system would panic in very early stage.
   466		 */
   467		gwdt->clk = arch_timer_get_cntfrq();
   468		gwdt->refresh_base = rf_base;
   469		gwdt->control_base = cf_base;
   470	
   471		wdd = &gwdt->wdd;
   472		wdd->parent = dev;
   473		wdd->info = &sbsa_gwdt_info;
   474		wdd->ops = &sbsa_gwdt_ops;
   475		wdd->min_timeout = 1;
   476		wdd->timeout = DEFAULT_TIMEOUT;
   477		watchdog_set_drvdata(wdd, gwdt);
   478		watchdog_set_nowayout(wdd, nowayout);
   479		sbsa_gwdt_get_version(wdd);
   480		if (gwdt->version == 0)
   481			wdd->max_hw_heartbeat_ms = U32_MAX / gwdt->clk * 1000;
   482		else
   483			wdd->max_hw_heartbeat_ms = GENMASK_ULL(47, 0) / gwdt->clk * 1000;
   484	
   485		status = gwdt->soc_reg_ops->reg_read32(cf_base + SBSA_GWDT_WCS);
   486		if (status & SBSA_GWDT_WCS_WS1) {
   487			dev_warn(dev, "System reset by WDT.\n");
   488			wdd->bootstatus |= WDIOF_CARDRESET;
   489		}
   490		if (status & SBSA_GWDT_WCS_EN)
   491			set_bit(WDOG_HW_RUNNING, &wdd->status);
   492	
   493		if (action) {
   494			irq = platform_get_irq(pdev, 0);
   495			if (irq < 0) {
   496				action = 0;
   497				dev_warn(dev, "unable to get ws0 interrupt.\n");
   498			} else {
   499				/*
   500				 * In case there is a pending ws0 interrupt, just ping
   501				 * the watchdog before registering the interrupt routine
   502				 */
   503				gwdt->soc_reg_ops->reg_write32(0, rf_base + SBSA_GWDT_WRR);
   504				if (devm_request_irq(dev, irq, sbsa_gwdt_interrupt, 0,
   505						     pdev->name, gwdt)) {
   506					action = 0;
   507					dev_warn(dev, "unable to request IRQ %d.\n",
   508						 irq);
   509				}
   510			}
   511			if (!action)
   512				dev_warn(dev, "falling back to single stage mode.\n");
   513		}
   514		/*
   515		 * In the single stage mode, The first signal (WS0) is ignored,
   516		 * the timeout is (WOR * 2), so the maximum timeout should be doubled.
   517		 */
   518		if (!action)
   519			wdd->max_hw_heartbeat_ms *= 2;
   520	
   521		watchdog_init_timeout(wdd, timeout, dev);
   522		/*
   523		 * Update timeout to WOR.
   524		 * Because of the explicit watchdog refresh mechanism,
   525		 * it's also a ping, if watchdog is enabled.
   526		 */
   527		sbsa_gwdt_set_timeout(wdd, wdd->timeout);
   528	
   529		watchdog_stop_on_reboot(wdd);
   530		ret = devm_watchdog_register_device(dev, wdd);
   531		if (ret)
   532			return ret;
   533		/*
   534		 * Marvell AC5/X/IM: need to configure the watchdog
   535		 * HW to trigger reset on WS1 (Watchdog Signal 1):
   536		 *
   537		 * 1. Configure the watchdog signal enable (routing)
   538		 *    according to configuration
   539		 * 2. Unmask the wd_rst input signal to the reset unit
   540		 */
   541		if (marvell) {
   542			gwdt->soc_reg_ops->reg_write32(reset, cpu_ctrl_base +
   543						       SBSA_GWDT_MARVELL_CPU_WD_RST_EN_REG);
   544			id = readl(mng_base + SBSA_GWDT_MARVELL_MNG_ID_REG) &
   545				   SBSA_GWDT_MARVELL_ID_MASK;
   546	
   547			if (id == SBSA_GWDT_MARVELL_AC5_ID)
   548				val = SBSA_GWDT_MARVELL_AC5_RST_UNIT_WD_BIT;
   549			else
   550				val = SBSA_GWDT_MARVELL_IRONMAN_RST_UNIT_WD_BIT;
   551	
   552			writel(readl(rst_ctrl_base + SBSA_GWDT_MARVELL_RST_CTRL_REG) & ~val,
   553			       rst_ctrl_base + SBSA_GWDT_MARVELL_RST_CTRL_REG);
   554		}
   555		dev_info(dev, "Initialized with %ds timeout @ %u Hz, action=%d.%s\n",
   556			 wdd->timeout, gwdt->clk, action,
   557			 status & SBSA_GWDT_WCS_EN ? " [enabled]" : "");
   558	
   559		return 0;
   560	}
   561	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

