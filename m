Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D99F7F56E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344586AbjKWDMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344563AbjKWDMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:12:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302331A4;
        Wed, 22 Nov 2023 19:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700709142; x=1732245142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UnGQBf6lO2CjcsVhvS6vUPaT2j1YbZBexAjYz4DyprU=;
  b=I1yR1pwaKdHVoXDejrbL6aHmyTeIuwTDb9hN8wdUdxBALB3QkxC8N3Xv
   kCA+pSMcBBg/apLLIyX9G/fHgB220wbabaUdyDAuqwsCkTXZ/Taqxhlxb
   885v2X3swhjOUeYnf0TsLq0K+pLNF67x19OMlvnINfAhA0tcbeXtlI1vT
   xnJoLDymQe3rvQ4XFSSkhl71PFYpvY7RvYRd2Dafz6VUKQPIIkvP/Jgar
   BdnD2NCoK8AMY+rvsHvkC76XlkjiEJ+1ii0TdL+I2SwcjmmRGFJzbgJTP
   nwpQNygh7ZHtvC3EZ4RADxUqEkG40UhiO0jmFApIJSMSj9sFSf2CNlX5t
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="458685599"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="458685599"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 19:12:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="716933921"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="716933921"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Nov 2023 19:12:12 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r608Q-0001AC-0r;
        Thu, 23 Nov 2023 03:12:10 +0000
Date:   Thu, 23 Nov 2023 11:11:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH v1 01/17] pinctrl: equilibrium: Convert to use struct
 pingroup
Message-ID: <202311230820.oBQop844-lkp@intel.com>
References: <20231122164040.2262742-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122164040.2262742-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next geert-renesas-drivers/renesas-pinctrl pinctrl-samsung/for-next linus/master v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-equilibrium-Convert-to-use-struct-pingroup/20231123-005932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20231122164040.2262742-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 01/17] pinctrl: equilibrium: Convert to use struct pingroup
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231123/202311230820.oBQop844-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231123/202311230820.oBQop844-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311230820.oBQop844-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pinctrl/pinctrl-equilibrium.c:750:17: error: read-only variable is not assignable
                           grp->pins[j] = pin_id;
                           ~~~~~~~~~~~~ ^
>> drivers/pinctrl/pinctrl-equilibrium.c:761:23: error: no member named 'num_pins' in 'struct pingroup'
                                                   grp->pins, grp->num_pins,
                                                              ~~~  ^
   2 errors generated.


vim +750 drivers/pinctrl/pinctrl-equilibrium.c

   702	
   703	static int eqbr_build_groups(struct eqbr_pinctrl_drv_data *drvdata)
   704	{
   705		struct device *dev = drvdata->dev;
   706		struct device_node *node = dev->of_node;
   707		unsigned int *pinmux, pin_id, pinmux_id;
   708		struct pingroup group, *grp = &group;
   709		struct device_node *np;
   710		struct property *prop;
   711		int j, err;
   712	
   713		for_each_child_of_node(node, np) {
   714			prop = of_find_property(np, "groups", NULL);
   715			if (!prop)
   716				continue;
   717	
   718			grp->npins = of_property_count_u32_elems(np, "pins");
   719			if (grp->npins < 0) {
   720				dev_err(dev, "No pins in the group: %s\n", prop->name);
   721				of_node_put(np);
   722				return -EINVAL;
   723			}
   724			grp->name = prop->value;
   725			grp->pins = devm_kcalloc(dev, grp->npins, sizeof(*grp->pins), GFP_KERNEL);
   726			if (!grp->pins) {
   727				of_node_put(np);
   728				return -ENOMEM;
   729			}
   730	
   731			pinmux = devm_kcalloc(dev, grp->npins, sizeof(*pinmux), GFP_KERNEL);
   732			if (!pinmux) {
   733				of_node_put(np);
   734				return -ENOMEM;
   735			}
   736	
   737			for (j = 0; j < grp->npins; j++) {
   738				if (of_property_read_u32_index(np, "pins", j, &pin_id)) {
   739					dev_err(dev, "Group %s: Read intel pins id failed\n",
   740						grp->name);
   741					of_node_put(np);
   742					return -EINVAL;
   743				}
   744				if (pin_id >= drvdata->pctl_desc.npins) {
   745					dev_err(dev, "Group %s: Invalid pin ID, idx: %d, pin %u\n",
   746						grp->name, j, pin_id);
   747					of_node_put(np);
   748					return -EINVAL;
   749				}
 > 750				grp->pins[j] = pin_id;
   751				if (of_property_read_u32_index(np, "pinmux", j, &pinmux_id)) {
   752					dev_err(dev, "Group %s: Read intel pinmux id failed\n",
   753						grp->name);
   754					of_node_put(np);
   755					return -EINVAL;
   756				}
   757				pinmux[j] = pinmux_id;
   758			}
   759	
   760			err = pinctrl_generic_add_group(drvdata->pctl_dev, grp->name,
 > 761							grp->pins, grp->num_pins,
   762							pinmux);
   763			if (err < 0) {
   764				dev_err(dev, "Failed to register group %s\n", grp->name);
   765				of_node_put(np);
   766				return err;
   767			}
   768			memset(&group, 0, sizeof(group));
   769			pinmux = NULL;
   770		}
   771	
   772		return 0;
   773	}
   774	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
