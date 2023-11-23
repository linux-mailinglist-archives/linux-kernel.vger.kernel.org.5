Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38037F56DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 04:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344540AbjKWDMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 22:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344441AbjKWDMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 22:12:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166A31A4;
        Wed, 22 Nov 2023 19:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700709139; x=1732245139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3sBlfJImwRaqa6aryIZaVq3UckHfBRFnYA7tVrAvU28=;
  b=HkDkgejSTaKHw0KrfZzucjWPtINUcXlHo85Zfuh6vyo0ndxkUvzr0UUI
   q6qQACLh1E22hnbms7xxvohwvkPnC4Jl3RAgQTVRHwLjdWQPMlm1K14Cb
   vmjD9ftI3+Wo6WTQB4W8aTwPfk3cu1QRXOYO8FsdPae/YErv9QmIgX0lG
   x4ldtN1ReiTmF8MwEwMUM9WmpZ+yvcOzeFclFAfAw5D2UD8uIqTdNCuHS
   Crahd8QZkX9ImMkXRN+4gDWby532nPkAEYHxcRyVvdXuQdEp9hRSdfvyl
   Tm2L0Pq8ehsOSRhMsGK0jrbnnDw7fnM6u0AH5uheCHWVEosZmkCABYzjF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13744904"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="13744904"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 19:12:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="8712749"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 22 Nov 2023 19:12:11 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r608P-00019r-1j;
        Thu, 23 Nov 2023 03:12:09 +0000
Date:   Thu, 23 Nov 2023 11:11:25 +0800
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
Cc:     oe-kbuild-all@lists.linux.dev, Ray Jui <rjui@broadcom.com>,
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
Message-ID: <202311230820.MGDyVHJW-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next geert-renesas-drivers/renesas-pinctrl pinctrl-samsung/for-next linus/master v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-equilibrium-Convert-to-use-struct-pingroup/20231123-005932
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20231122164040.2262742-2-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 01/17] pinctrl: equilibrium: Convert to use struct pingroup
config: i386-randconfig-001-20231123 (https://download.01.org/0day-ci/archive/20231123/202311230820.MGDyVHJW-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231123/202311230820.MGDyVHJW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311230820.MGDyVHJW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-equilibrium.c: In function 'eqbr_build_groups':
   drivers/pinctrl/pinctrl-equilibrium.c:750:17: error: assignment of read-only location '*(grp->pins + (sizetype)((unsigned int)j * 4))'
     750 |    grp->pins[j] = pin_id;
         |                 ^
   drivers/pinctrl/pinctrl-equilibrium.c:761:23: error: 'struct pingroup' has no member named 'num_pins'; did you mean 'npins'?
     761 |       grp->pins, grp->num_pins,
         |                       ^~~~~~~~
         |                       npins
>> drivers/pinctrl/pinctrl-equilibrium.c:761:10: warning: passing argument 3 of 'pinctrl_generic_add_group' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     761 |       grp->pins, grp->num_pins,
         |       ~~~^~~~~~
   In file included from drivers/pinctrl/pinctrl-equilibrium.c:16:
   drivers/pinctrl/core.h:225:15: note: expected 'int *' but argument is of type 'const unsigned int *'
     225 |          int *gpins, int ngpins, void *data);
         |          ~~~~~^~~~~


vim +761 drivers/pinctrl/pinctrl-equilibrium.c

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
   750				grp->pins[j] = pin_id;
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
