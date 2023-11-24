Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B177F86CE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjKXXj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKXXjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:39:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2986B10F6;
        Fri, 24 Nov 2023 15:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700869168; x=1732405168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i+u3ktGe5zN5QBmfkK29yDvJuJLgaXA/mYBLUauJqcE=;
  b=LSXGLvlgqh5Bo8Gh/HXpkhUum4TsLpwd1Ywud0rcT/TZOqMs2S2Q2nvt
   j3U7GSzRSDnpKCR87cVZjMtIZzS2x3lWZBT4YvPmpERMswKSmSTL5dSUR
   ty6zV2UBiMxMEjj0nE8DkuvELjtIYzHt2oQnHkHLP/f6KfNmdc/RqrUR7
   gdJhN+q1HzdApdlXMwVSxq4viooCZAbu+EPK8OqEacUkBStqDQtrEMRBy
   pN5kKXMbkz8W1roujODIkoIkeVrWgIUgqST0sun3CrY4nDMy6AqjlWqx8
   6anrg7fBenE3QEbCJmZxF5TlNg1DWdivb3yqzCst0KzEeZqwMKxNWkDy2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="11170294"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="11170294"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 15:39:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="833793170"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="833793170"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2023 15:39:19 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6flV-0003O6-0f;
        Fri, 24 Nov 2023 23:39:17 +0000
Date:   Sat, 25 Nov 2023 07:39:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
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
        Sean Wang <sean.wang@kernel.org>
Subject: Re: [PATCH v2 12/21] pinctrl: core: Embed struct pingroup into
 struct group_desc
Message-ID: <202311250448.uz5Yom3N-lkp@intel.com>
References: <20231123193355.3400852-13-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123193355.3400852-13-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[also build test ERROR on linusw-pinctrl/for-next next-20231124]
[cannot apply to geert-renesas-drivers/renesas-pinctrl pinctrl-samsung/for-next linus/master v6.7-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-qcom-lpass-lpi-Remove-unused-member-in-struct-lpi_pingroup/20231124-043212
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20231123193355.3400852-13-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v2 12/21] pinctrl: core: Embed struct pingroup into struct group_desc
config: i386-buildonly-randconfig-006-20231125 (https://download.01.org/0day-ci/archive/20231125/202311250448.uz5Yom3N-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231125/202311250448.uz5Yom3N-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311250448.uz5Yom3N-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/pinctrl/pinctrl-ingenic.c:29:0:
   drivers/pinctrl/core.h:217:21: error: initializer element is not constant
    (struct group_desc) {      \
                        ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:200:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("mmc-1bit", jz4730_mmc_1bit, 1),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:21: note: (near initialization for 'jz4730_groups')
    (struct group_desc) {      \
                        ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:200:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("mmc-1bit", jz4730_mmc_1bit, 1),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:21: error: initializer element is not constant
    (struct group_desc) {      \
                        ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:296:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("mmc-1bit", jz4740_mmc_1bit, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:21: note: (near initialization for 'jz4740_groups')
    (struct group_desc) {      \
                        ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:296:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("mmc-1bit", jz4740_mmc_1bit, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from include/linux/gpio/driver.h:13:0,
                    from drivers/pinctrl/pinctrl-ingenic.c:11:
>> include/linux/pinctrl/pinctrl.h:43:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:297:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("mmc-4bit", jz4740_mmc_4bit, 0),
     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:1: note: (near initialization for '(anonymous).grp.name')
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:297:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("mmc-4bit", jz4740_mmc_4bit, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-ingenic.c:29:0:
   drivers/pinctrl/core.h:217:1: warning: missing braces around initializer [-Wmissing-braces]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:297:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("mmc-4bit", jz4740_mmc_4bit, 0),
     ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/core.h:217:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:297:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("mmc-4bit", jz4740_mmc_4bit, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[1].grp.name')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:297:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("mmc-4bit", jz4740_mmc_4bit, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: error: initializer element is not constant
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:297:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("mmc-4bit", jz4740_mmc_4bit, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[1].grp.name')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:297:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("mmc-4bit", jz4740_mmc_4bit, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from include/linux/gpio/driver.h:13:0,
                    from drivers/pinctrl/pinctrl-ingenic.c:11:
>> include/linux/pinctrl/pinctrl.h:43:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:298:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-data", jz4740_uart0_data, 1),
     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:1: note: (near initialization for '(anonymous).grp.name')
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:298:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-data", jz4740_uart0_data, 1),
     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-ingenic.c:29:0:
   drivers/pinctrl/core.h:217:1: warning: missing braces around initializer [-Wmissing-braces]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:298:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-data", jz4740_uart0_data, 1),
     ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/core.h:217:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:298:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-data", jz4740_uart0_data, 1),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[1].grp.pins')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:298:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-data", jz4740_uart0_data, 1),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: error: initializer element is not constant
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:298:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-data", jz4740_uart0_data, 1),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[1].grp.pins')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:298:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-data", jz4740_uart0_data, 1),
     ^~~~~~~~~~~~~~~~~
   In file included from include/linux/gpio/driver.h:13:0,
                    from drivers/pinctrl/pinctrl-ingenic.c:11:
>> include/linux/pinctrl/pinctrl.h:43:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:299:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-hwflow", jz4740_uart0_hwflow, 1),
     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:1: note: (near initialization for '(anonymous).grp.name')
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:299:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-hwflow", jz4740_uart0_hwflow, 1),
     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-ingenic.c:29:0:
   drivers/pinctrl/core.h:217:1: warning: missing braces around initializer [-Wmissing-braces]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:299:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-hwflow", jz4740_uart0_hwflow, 1),
     ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/core.h:217:1: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:299:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-hwflow", jz4740_uart0_hwflow, 1),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[1].grp.npins')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:299:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-hwflow", jz4740_uart0_hwflow, 1),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: error: initializer element is not constant
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:299:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-hwflow", jz4740_uart0_hwflow, 1),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[1].grp.npins')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:299:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart0-hwflow", jz4740_uart0_hwflow, 1),
     ^~~~~~~~~~~~~~~~~
   In file included from include/linux/gpio/driver.h:13:0,
                    from drivers/pinctrl/pinctrl-ingenic.c:11:
>> include/linux/pinctrl/pinctrl.h:43:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:300:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart1-data", jz4740_uart1_data, 2),
     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:1: note: (near initialization for '(anonymous).grp.name')
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:300:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart1-data", jz4740_uart1_data, 2),
     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-ingenic.c:29:0:
   drivers/pinctrl/core.h:217:1: warning: missing braces around initializer [-Wmissing-braces]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:300:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart1-data", jz4740_uart1_data, 2),
     ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/core.h:217:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:300:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart1-data", jz4740_uart1_data, 2),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[1].name')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:300:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart1-data", jz4740_uart1_data, 2),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: error: initializer element is not constant
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:300:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart1-data", jz4740_uart1_data, 2),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[1].name')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:300:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("uart1-data", jz4740_uart1_data, 2),
     ^~~~~~~~~~~~~~~~~
   In file included from include/linux/gpio/driver.h:13:0,
                    from drivers/pinctrl/pinctrl-ingenic.c:11:
>> include/linux/pinctrl/pinctrl.h:43:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:301:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-8bit", jz4740_lcd_8bit, 0),
     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:1: note: (near initialization for '(anonymous).grp.name')
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:301:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-8bit", jz4740_lcd_8bit, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-ingenic.c:29:0:
   drivers/pinctrl/core.h:217:1: warning: missing braces around initializer [-Wmissing-braces]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:301:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-8bit", jz4740_lcd_8bit, 0),
     ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/core.h:217:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:301:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-8bit", jz4740_lcd_8bit, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[1].pins')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:301:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-8bit", jz4740_lcd_8bit, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: error: initializer element is not constant
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:301:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-8bit", jz4740_lcd_8bit, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[1].pins')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:301:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-8bit", jz4740_lcd_8bit, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from include/linux/gpio/driver.h:13:0,
                    from drivers/pinctrl/pinctrl-ingenic.c:11:
>> include/linux/pinctrl/pinctrl.h:43:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:302:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-16bit", jz4740_lcd_16bit, 0),
     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:1: note: (near initialization for '(anonymous).grp.name')
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:302:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-16bit", jz4740_lcd_16bit, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-ingenic.c:29:0:
   drivers/pinctrl/core.h:217:1: warning: missing braces around initializer [-Wmissing-braces]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:302:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-16bit", jz4740_lcd_16bit, 0),
     ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/core.h:217:1: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:302:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-16bit", jz4740_lcd_16bit, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[1].num_pins')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:302:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-16bit", jz4740_lcd_16bit, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: error: initializer element is not constant
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:302:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-16bit", jz4740_lcd_16bit, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[1].num_pins')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:302:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-16bit", jz4740_lcd_16bit, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from include/linux/gpio/driver.h:13:0,
                    from drivers/pinctrl/pinctrl-ingenic.c:11:
>> include/linux/pinctrl/pinctrl.h:43:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:303:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-18bit", jz4740_lcd_18bit, 0),
     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:1: note: (near initialization for '(anonymous).grp.name')
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:303:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-18bit", jz4740_lcd_18bit, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-ingenic.c:29:0:
   drivers/pinctrl/core.h:217:1: warning: missing braces around initializer [-Wmissing-braces]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:303:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-18bit", jz4740_lcd_18bit, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:303:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-18bit", jz4740_lcd_18bit, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: error: initializer element is not constant
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:303:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-18bit", jz4740_lcd_18bit, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[1].data')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:303:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-18bit", jz4740_lcd_18bit, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from include/linux/gpio/driver.h:13:0,
                    from drivers/pinctrl/pinctrl-ingenic.c:11:
>> include/linux/pinctrl/pinctrl.h:43:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:304:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-special", jz4740_lcd_special, 0),
     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:1: note: (near initialization for '(anonymous).grp.name')
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:304:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-special", jz4740_lcd_special, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-ingenic.c:29:0:
   drivers/pinctrl/core.h:217:1: warning: missing braces around initializer [-Wmissing-braces]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:304:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-special", jz4740_lcd_special, 0),
     ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/core.h:217:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:304:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-special", jz4740_lcd_special, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[2].grp.name')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:304:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-special", jz4740_lcd_special, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: error: initializer element is not constant
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:304:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-special", jz4740_lcd_special, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[2].grp.name')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:304:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-special", jz4740_lcd_special, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from include/linux/gpio/driver.h:13:0,
                    from drivers/pinctrl/pinctrl-ingenic.c:11:
>> include/linux/pinctrl/pinctrl.h:43:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:305:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-generic", jz4740_lcd_generic, 0),
     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:1: note: (near initialization for '(anonymous).grp.name')
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:305:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-generic", jz4740_lcd_generic, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-ingenic.c:29:0:
   drivers/pinctrl/core.h:217:1: warning: missing braces around initializer [-Wmissing-braces]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:305:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-generic", jz4740_lcd_generic, 0),
     ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/core.h:217:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:305:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-generic", jz4740_lcd_generic, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[2].grp.pins')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:305:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-generic", jz4740_lcd_generic, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: error: initializer element is not constant
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:305:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-generic", jz4740_lcd_generic, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[2].grp.pins')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:305:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("lcd-generic", jz4740_lcd_generic, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from include/linux/gpio/driver.h:13:0,
                    from drivers/pinctrl/pinctrl-ingenic.c:11:
>> include/linux/pinctrl/pinctrl.h:43:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:306:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs1", jz4740_nand_cs1, 0),
     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:1: note: (near initialization for '(anonymous).grp.name')
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:306:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs1", jz4740_nand_cs1, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-ingenic.c:29:0:
   drivers/pinctrl/core.h:217:1: warning: missing braces around initializer [-Wmissing-braces]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:306:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs1", jz4740_nand_cs1, 0),
     ^~~~~~~~~~~~~~~~~
>> drivers/pinctrl/core.h:217:1: warning: initialization makes integer from pointer without a cast [-Wint-conversion]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:306:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs1", jz4740_nand_cs1, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[2].grp.npins')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:306:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs1", jz4740_nand_cs1, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: error: initializer element is not constant
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:306:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs1", jz4740_nand_cs1, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[2].grp.npins')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:306:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs1", jz4740_nand_cs1, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from include/linux/gpio/driver.h:13:0,
                    from drivers/pinctrl/pinctrl-ingenic.c:11:
>> include/linux/pinctrl/pinctrl.h:43:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:307:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs2", jz4740_nand_cs2, 0),
     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:1: note: (near initialization for '(anonymous).grp.name')
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:307:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs2", jz4740_nand_cs2, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-ingenic.c:29:0:
   drivers/pinctrl/core.h:217:1: warning: missing braces around initializer [-Wmissing-braces]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:307:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs2", jz4740_nand_cs2, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:307:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs2", jz4740_nand_cs2, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[2].name')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:307:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs2", jz4740_nand_cs2, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: error: initializer element is not constant
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:307:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs2", jz4740_nand_cs2, 0),
     ^~~~~~~~~~~~~~~~~
   drivers/pinctrl/core.h:217:1: note: (near initialization for 'jz4740_groups[2].name')
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:307:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs2", jz4740_nand_cs2, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from include/linux/gpio/driver.h:13:0,
                    from drivers/pinctrl/pinctrl-ingenic.c:11:
   include/linux/pinctrl/pinctrl.h:43:1: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:308:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs3", jz4740_nand_cs3, 0),
     ^~~~~~~~~~~~~~~~~
   include/linux/pinctrl/pinctrl.h:43:1: note: (near initialization for '(anonymous).grp.name')
    (struct pingroup) {    \
    ^
   drivers/pinctrl/core.h:218:9: note: in expansion of macro 'PINCTRL_PINGROUP'
     .grp = PINCTRL_PINGROUP(_name, _pins, _num_pins), \
            ^~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'
     PINCTRL_GROUP_DESC(name, id##_pins, ARRAY_SIZE(id##_pins), (void *)(func))
     ^~~~~~~~~~~~~~~~~~
   drivers/pinctrl/pinctrl-ingenic.c:308:2: note: in expansion of macro 'INGENIC_PIN_GROUP'
     INGENIC_PIN_GROUP("nand-cs3", jz4740_nand_cs3, 0),
     ^~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-ingenic.c:29:0:
   drivers/pinctrl/core.h:217:1: warning: missing braces around initializer [-Wmissing-braces]
    (struct group_desc) {      \
    ^
   drivers/pinctrl/pinctrl-ingenic.c:89:2: note: in expansion of macro 'PINCTRL_GROUP_DESC'


vim +43 include/linux/pinctrl/pinctrl.h

003cbe04617159 Basavaraj Natikar 2022-06-01  40  
003cbe04617159 Basavaraj Natikar 2022-06-01  41  /* Convenience macro to define a single named or anonymous pingroup */
003cbe04617159 Basavaraj Natikar 2022-06-01  42  #define PINCTRL_PINGROUP(_name, _pins, _npins)	\
003cbe04617159 Basavaraj Natikar 2022-06-01 @43  (struct pingroup) {				\
003cbe04617159 Basavaraj Natikar 2022-06-01  44  	.name = _name,				\
003cbe04617159 Basavaraj Natikar 2022-06-01  45  	.pins = _pins,				\
003cbe04617159 Basavaraj Natikar 2022-06-01  46  	.npins = _npins,			\
003cbe04617159 Basavaraj Natikar 2022-06-01  47  }
003cbe04617159 Basavaraj Natikar 2022-06-01  48  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
