Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08C77E6C47
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjKIOO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbjKIOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:14:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC6130D2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699539263; x=1731075263;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CsKO0PVa1TCnRBy/VSilAKj4lQHBGw9d06Y3shR2C1o=;
  b=BXEr+JmQ+GC886YFBr35Mj69fbd39Gy63D+SnbTQH5cfL6pmMiQKhfAe
   CT7lHDAI2awlX5HhZhscIWt/ac/Nu5mXyCg7IhnoCkTR5UOy0vdA8srCS
   GR4bd1+NdVEHN+//R6AanmXJLQo0Ho708IloJtBzdIfiJIEUEuYqemVFa
   fvmOp3Tk5xtOV3D57MfquwGitcJzJUX2K7Xgh0BslG1IIv1W5huJUrQgO
   U7EMUKiwj3JbjQN0hjP+XfIzyrw3ERI2WIK9pwd1ozhzQHAX6OVnUlKei
   WiKOk4mlYnn6mPatr7S9XAo1Z17HSiTqSUlpSf/Ql6cCssivmQ5390AFg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369324452"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="369324452"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 06:14:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="739856784"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="739856784"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Nov 2023 06:14:20 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r15nW-0008m8-1D;
        Thu, 09 Nov 2023 14:14:18 +0000
Date:   Thu, 9 Nov 2023 22:13:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>
Subject: drivers/net/dsa/qca/ar9331.c:502:29: error: implicit declaration of
 function 'irq_find_mapping'
Message-ID: <202311092236.uvirbjcm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc986ab839c844e78a2333a02e55f02c9e57935
commit: ec6698c272debe16c8825c88a5b3c3f68a12ef4a net: dsa: add support for Atheros AR9331 built-in switch
date:   3 years, 11 months ago
config: um-randconfig-001-20231109 (https://download.01.org/0day-ci/archive/20231109/202311092236.uvirbjcm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311092236.uvirbjcm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311092236.uvirbjcm-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
   In file included from include/linux/build_bug.h:5,
                    from include/linux/bitfield.h:10,
                    from drivers/net/dsa/qca/ar9331.c:42:
   include/asm-generic/fixmap.h: In function 'fix_to_virt':
   include/asm-generic/fixmap.h:32:26: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
      32 |         BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |                          ^~
   include/linux/compiler.h:330:23: note: in definition of macro '__compiletime_assert'
     330 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler.h:350:9: note: in expansion of macro '_compiletime_assert'
     350 |         _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/fixmap.h:32:9: note: in expansion of macro 'BUILD_BUG_ON'
      32 |         BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
         |         ^~~~~~~~~~~~
   drivers/net/dsa/qca/ar9331.c: In function 'ar9331_sw_irq':
>> drivers/net/dsa/qca/ar9331.c:502:29: error: implicit declaration of function 'irq_find_mapping' [-Werror=implicit-function-declaration]
     502 |                 child_irq = irq_find_mapping(priv->irqdomain, 0);
         |                             ^~~~~~~~~~~~~~~~
   drivers/net/dsa/qca/ar9331.c: At top level:
>> drivers/net/dsa/qca/ar9331.c:567:18: error: 'irq_domain_xlate_onecell' undeclared here (not in a function)
     567 |         .xlate = irq_domain_xlate_onecell,
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/qca/ar9331.c: In function 'ar9331_sw_irq_init':
>> drivers/net/dsa/qca/ar9331.c:589:27: error: implicit declaration of function 'irq_domain_add_linear' [-Werror=implicit-function-declaration]
     589 |         priv->irqdomain = irq_domain_add_linear(np, 1, &ar9331_sw_irqdomain_ops,
         |                           ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/dsa/qca/ar9331.c:589:25: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     589 |         priv->irqdomain = irq_domain_add_linear(np, 1, &ar9331_sw_irqdomain_ops,
         |                         ^
>> drivers/net/dsa/qca/ar9331.c:596:24: error: implicit declaration of function 'irq_create_mapping'; did you mean 'irq_create_of_mapping'? [-Werror=implicit-function-declaration]
     596 |         irq_set_parent(irq_create_mapping(priv->irqdomain, 0), irq);
         |                        ^~~~~~~~~~~~~~~~~~
         |                        irq_create_of_mapping
   drivers/net/dsa/qca/ar9331.c: In function 'ar9331_sw_probe':
>> drivers/net/dsa/qca/ar9331.c:821:9: error: implicit declaration of function 'irq_domain_remove' [-Werror=implicit-function-declaration]
     821 |         irq_domain_remove(priv->irqdomain);
         |         ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for LOCKDEP
   Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
   Selected by [y]:
   - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
   - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]


vim +/irq_find_mapping +502 drivers/net/dsa/qca/ar9331.c

   482	
   483	static irqreturn_t ar9331_sw_irq(int irq, void *data)
   484	{
   485		struct ar9331_sw_priv *priv = data;
   486		struct regmap *regmap = priv->regmap;
   487		u32 stat;
   488		int ret;
   489	
   490		ret = regmap_read(regmap, AR9331_SW_REG_GINT, &stat);
   491		if (ret) {
   492			dev_err(priv->dev, "can't read interrupt status\n");
   493			return IRQ_NONE;
   494		}
   495	
   496		if (!stat)
   497			return IRQ_NONE;
   498	
   499		if (stat & AR9331_SW_GINT_PHY_INT) {
   500			int child_irq;
   501	
 > 502			child_irq = irq_find_mapping(priv->irqdomain, 0);
   503			handle_nested_irq(child_irq);
   504		}
   505	
   506		ret = regmap_write(regmap, AR9331_SW_REG_GINT, stat);
   507		if (ret) {
   508			dev_err(priv->dev, "can't write interrupt status\n");
   509			return IRQ_NONE;
   510		}
   511	
   512		return IRQ_HANDLED;
   513	}
   514	
   515	static void ar9331_sw_mask_irq(struct irq_data *d)
   516	{
   517		struct ar9331_sw_priv *priv = irq_data_get_irq_chip_data(d);
   518		struct regmap *regmap = priv->regmap;
   519		int ret;
   520	
   521		ret = regmap_update_bits(regmap, AR9331_SW_REG_GINT_MASK,
   522					 AR9331_SW_GINT_PHY_INT, 0);
   523		if (ret)
   524			dev_err(priv->dev, "could not mask IRQ\n");
   525	}
   526	
   527	static void ar9331_sw_unmask_irq(struct irq_data *d)
   528	{
   529		struct ar9331_sw_priv *priv = irq_data_get_irq_chip_data(d);
   530		struct regmap *regmap = priv->regmap;
   531		int ret;
   532	
   533		ret = regmap_update_bits(regmap, AR9331_SW_REG_GINT_MASK,
   534					 AR9331_SW_GINT_PHY_INT,
   535					 AR9331_SW_GINT_PHY_INT);
   536		if (ret)
   537			dev_err(priv->dev, "could not unmask IRQ\n");
   538	}
   539	
   540	static struct irq_chip ar9331_sw_irq_chip = {
   541		.name = AR9331_SW_NAME,
   542		.irq_mask = ar9331_sw_mask_irq,
   543		.irq_unmask = ar9331_sw_unmask_irq,
   544	};
   545	
   546	static int ar9331_sw_irq_map(struct irq_domain *domain, unsigned int irq,
   547				     irq_hw_number_t hwirq)
   548	{
   549		irq_set_chip_data(irq, domain->host_data);
   550		irq_set_chip_and_handler(irq, &ar9331_sw_irq_chip, handle_simple_irq);
   551		irq_set_nested_thread(irq, 1);
   552		irq_set_noprobe(irq);
   553	
   554		return 0;
   555	}
   556	
   557	static void ar9331_sw_irq_unmap(struct irq_domain *d, unsigned int irq)
   558	{
   559		irq_set_nested_thread(irq, 0);
   560		irq_set_chip_and_handler(irq, NULL, NULL);
   561		irq_set_chip_data(irq, NULL);
   562	}
   563	
   564	static const struct irq_domain_ops ar9331_sw_irqdomain_ops = {
   565		.map = ar9331_sw_irq_map,
   566		.unmap = ar9331_sw_irq_unmap,
 > 567		.xlate = irq_domain_xlate_onecell,
   568	};
   569	
   570	static int ar9331_sw_irq_init(struct ar9331_sw_priv *priv)
   571	{
   572		struct device_node *np = priv->dev->of_node;
   573		struct device *dev = priv->dev;
   574		int ret, irq;
   575	
   576		irq = of_irq_get(np, 0);
   577		if (irq <= 0) {
   578			dev_err(dev, "failed to get parent IRQ\n");
   579			return irq ? irq : -EINVAL;
   580		}
   581	
   582		ret = devm_request_threaded_irq(dev, irq, NULL, ar9331_sw_irq,
   583						IRQF_ONESHOT, AR9331_SW_NAME, priv);
   584		if (ret) {
   585			dev_err(dev, "unable to request irq: %d\n", ret);
   586			return ret;
   587		}
   588	
 > 589		priv->irqdomain = irq_domain_add_linear(np, 1, &ar9331_sw_irqdomain_ops,
   590							priv);
   591		if (!priv->irqdomain) {
   592			dev_err(dev, "failed to create IRQ domain\n");
   593			return -EINVAL;
   594		}
   595	
 > 596		irq_set_parent(irq_create_mapping(priv->irqdomain, 0), irq);
   597	
   598		return 0;
   599	}
   600	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
