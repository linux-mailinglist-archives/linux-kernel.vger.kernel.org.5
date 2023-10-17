Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34D87CC7AD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344460AbjJQPns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344341AbjJQPnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:43:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6820CED;
        Tue, 17 Oct 2023 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697557424; x=1729093424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3zgnkPb30qFQTZnkkw9rToLJvEbV50eWvdkwGa4jPW4=;
  b=T3uY9uEWfzyQmuhX2mlC0FdT2uRISIRlYZSK5l9ItiQc6yhefFM3K1zH
   Aj9LWi/gkayZNzOtcruL3e3+VNylmLsUkC/OcAD5fUMlqZ2dcS83exnmX
   PPdoLvY6/R96OSlr8ejH34Mh21JpePRpCvtZQCPMerBG+PJMtLimcDADp
   YZmS/l+OXd3rOscC0oyFzuXNk/gxoN3SwMyIjAWwI9UlGvS8FbXXpr5Kn
   7ItI3RLH47pn5nCTdWl7ozM4aehGN3tUl5rvbcdCSD3dgS2KCAFPXfAXB
   dhgDeu1fwc7p/UjlZXnEkgm521spjgWZUligy+gf69Y06G7p4taAGGLFU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388671424"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="388671424"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 08:43:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="929809702"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="929809702"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Oct 2023 08:43:39 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsmEL-0009kp-0l;
        Tue, 17 Oct 2023 15:43:37 +0000
Date:   Tue, 17 Oct 2023 23:42:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 1/3] pinctrl: renesas: rzg2l: Include pinmap in
 RZG2L_GPIO_PORT_PACK() macro
Message-ID: <202310172321.wccxqLkr-lkp@intel.com>
References: <20231017104638.201260-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017104638.201260-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231017]
[cannot apply to geert-renesas-drivers/renesas-pinctrl geert-renesas-devel/next linusw-pinctrl/devel linusw-pinctrl/for-next v6.6-rc6 v6.6-rc5 v6.6-rc4 linus/master v6.6-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prabhakar/pinctrl-renesas-rzg2l-Include-pinmap-in-RZG2L_GPIO_PORT_PACK-macro/20231017-184850
base:   next-20231017
patch link:    https://lore.kernel.org/r/20231017104638.201260-2-prabhakar.mahadev-lad.rj%40bp.renesas.com
patch subject: [PATCH v2 1/3] pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK() macro
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310172321.wccxqLkr-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172321.wccxqLkr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172321.wccxqLkr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/bits.h:6,
                    from include/linux/bitops.h:6,
                    from drivers/pinctrl/renesas/pinctrl-rzg2l.c:8:
   drivers/pinctrl/renesas/pinctrl-rzg2l.c: In function 'rzg2l_pinctrl_set_mux':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:99:58: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      99 | #define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)       ((cfg) & RZG2L_SINGLE_PIN ? \
         |                                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:292:27: note: in expansion of macro 'RZG2L_PIN_CFG_TO_PORT_OFFSET'
     292 |                 u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c: In function 'rzg2l_validate_gpio_pin':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:99:58: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      99 | #define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)       ((cfg) & RZG2L_SINGLE_PIN ? \
         |                                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:544:19: note: in expansion of macro 'RZG2L_PIN_CFG_TO_PORT_OFFSET'
     544 |         u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:99:58: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      99 | #define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)       ((cfg) & RZG2L_SINGLE_PIN ? \
         |                                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:551:20: note: in expansion of macro 'RZG2L_PIN_CFG_TO_PORT_OFFSET'
     551 |         if (off != RZG2L_PIN_CFG_TO_PORT_OFFSET(data))
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c: In function 'rzg2l_pinctrl_pinconf_get':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:99:58: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      99 | #define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)       ((cfg) & RZG2L_SINGLE_PIN ? \
         |                                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:757:15: note: in expansion of macro 'RZG2L_PIN_CFG_TO_PORT_OFFSET'
     757 |         off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:759:25: note: in expansion of macro 'RZG2L_SINGLE_PIN'
     759 |         if (*pin_data & RZG2L_SINGLE_PIN) {
         |                         ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c: In function 'rzg2l_pinctrl_pinconf_set':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:99:58: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      99 | #define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)       ((cfg) & RZG2L_SINGLE_PIN ? \
         |                                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:855:15: note: in expansion of macro 'RZG2L_PIN_CFG_TO_PORT_OFFSET'
     855 |         off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:857:25: note: in expansion of macro 'RZG2L_SINGLE_PIN'
     857 |         if (*pin_data & RZG2L_SINGLE_PIN) {
         |                         ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c: In function 'rzg2l_gpio_request':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:99:58: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      99 | #define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)       ((cfg) & RZG2L_SINGLE_PIN ? \
         |                                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1050:19: note: in expansion of macro 'RZG2L_PIN_CFG_TO_PORT_OFFSET'
    1050 |         u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c: In function 'rzg2l_gpio_set_direction':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:99:58: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      99 | #define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)       ((cfg) & RZG2L_SINGLE_PIN ? \
         |                                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1082:19: note: in expansion of macro 'RZG2L_PIN_CFG_TO_PORT_OFFSET'
    1082 |         u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c: In function 'rzg2l_gpio_get_direction':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:99:58: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      99 | #define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)       ((cfg) & RZG2L_SINGLE_PIN ? \
         |                                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1103:19: note: in expansion of macro 'RZG2L_PIN_CFG_TO_PORT_OFFSET'
    1103 |         u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c: In function 'rzg2l_gpio_set':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:99:58: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      99 | #define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)       ((cfg) & RZG2L_SINGLE_PIN ? \
         |                                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1134:19: note: in expansion of macro 'RZG2L_PIN_CFG_TO_PORT_OFFSET'
    1134 |         u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c: In function 'rzg2l_gpio_get':
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:99:58: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      99 | #define RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg)       ((cfg) & RZG2L_SINGLE_PIN ? \
         |                                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1167:19: note: in expansion of macro 'RZG2L_PIN_CFG_TO_PORT_OFFSET'
    1167 |         u32 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c: At top level:
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1360:26: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1360 |                 { "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0,
         |                          ^~~~~~~~~~~~~~~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1362:32: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1362 |                 { "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x2, 0,
         |                                ^~~~~~~~~~~~~~~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1364:26: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1364 |                 { "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 0,
         |                          ^~~~~~~~~~~~~~~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1366:33: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1366 |                 { "AUDIO_CLK1", RZG2L_SINGLE_PIN_PACK(0x4, 0, PIN_CFG_IEN) },
         |                                 ^~~~~~~~~~~~~~~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1367:33: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1367 |                 { "AUDIO_CLK2", RZG2L_SINGLE_PIN_PACK(0x4, 1, PIN_CFG_IEN) },
         |                                 ^~~~~~~~~~~~~~~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1368:30: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1368 |                 { "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x6, 0,
         |                              ^~~~~~~~~~~~~~~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1370:30: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1370 |                 { "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x6, 1,
         |                              ^~~~~~~~~~~~~~~~~~~~~
>> include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1372:31: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1372 |                 { "SD0_RST#", RZG2L_SINGLE_PIN_PACK(0x6, 2,
         |                               ^~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1374:32: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1374 |                 { "SD0_DATA0", RZG2L_SINGLE_PIN_PACK(0x7, 0,
         |                                ^~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1376:32: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1376 |                 { "SD0_DATA1", RZG2L_SINGLE_PIN_PACK(0x7, 1,
         |                                ^~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1378:32: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1378 |                 { "SD0_DATA2", RZG2L_SINGLE_PIN_PACK(0x7, 2,
         |                                ^~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1380:32: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1380 |                 { "SD0_DATA3", RZG2L_SINGLE_PIN_PACK(0x7, 3,
         |                                ^~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1382:32: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1382 |                 { "SD0_DATA4", RZG2L_SINGLE_PIN_PACK(0x7, 4,
         |                                ^~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1384:32: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1384 |                 { "SD0_DATA5", RZG2L_SINGLE_PIN_PACK(0x7, 5,
         |                                ^~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)
         |                                         ^~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:94:42: note: in expansion of macro 'RZG2L_SINGLE_PIN'
      94 | #define RZG2L_SINGLE_PIN_PACK(p, b, f)  (RZG2L_SINGLE_PIN | \
         |                                          ^~~~~~~~~~~~~~~~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:1386:32: note: in expansion of macro 'RZG2L_SINGLE_PIN_PACK'
    1386 |                 { "SD0_DATA6", RZG2L_SINGLE_PIN_PACK(0x7, 6,
         |                                ^~~~~~~~~~~~~~~~~~~~~
   include/vdso/bits.h:7:40: warning: left shift count >= width of type [-Wshift-count-overflow]
       7 | #define BIT(nr)                 (UL(1) << (nr))
         |                                        ^~
   drivers/pinctrl/renesas/pinctrl-rzg2l.c:93:41: note: in expansion of macro 'BIT'
      93 | #define RZG2L_SINGLE_PIN                BIT(63)


vim +7 include/vdso/bits.h

3945ff37d2f48d Vincenzo Frascino 2020-03-20  6  
3945ff37d2f48d Vincenzo Frascino 2020-03-20 @7  #define BIT(nr)			(UL(1) << (nr))
cbdb1f163af2bb Andy Shevchenko   2022-11-28  8  #define BIT_ULL(nr)		(ULL(1) << (nr))
3945ff37d2f48d Vincenzo Frascino 2020-03-20  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
