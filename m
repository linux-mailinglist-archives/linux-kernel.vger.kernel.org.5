Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF227AC5D2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 01:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjIWXLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 19:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIWXLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 19:11:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786C983;
        Sat, 23 Sep 2023 16:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695510676; x=1727046676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iP6hYCKOBexc8AVWr4kAh1Iv4qVnYnMqC7Y/Tlnd+yk=;
  b=Faq4EH4pKi8/2hMngrAS70PG4W6halgGXghWRl+FBVTPFk6IvaB2xXUj
   I+3/nLANui3C4khTAoiRmMq9H5texDZMAkuO4vS+LaIpeMQPc0ofLWK5P
   0SJWFUYC337HjX3bdnAWIcw98twfz0w3o/RGVihKbyd238HlNuiiJZpQQ
   Sx0FnUn7CvfmVsyDm/LS3EN17k3cegAPGLJnoNU++9G1qvTca0DXbSWsw
   VSue/HCOoewQZVKdfVwRvqQ8gHVbEoqHi35EHbcQLIzxqHo0pSVEFbM1k
   b7C5Dwq7cApMpAtHAJHKpyYf+Q31d3JfNUQUqPmoBeoI2gbMCBFzuBXls
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="360453148"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="360453148"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 16:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="1078790376"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="1078790376"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 23 Sep 2023 16:11:10 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkBmF-0002yn-3B;
        Sat, 23 Sep 2023 23:11:08 +0000
Date:   Sun, 24 Sep 2023 07:11:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v9 3/3] clk: wpcm450: Add Nuvoton WPCM450 clock/reset
 controller driver
Message-ID: <202309240640.6iNEdfCX-lkp@intel.com>
References: <20230923143438.1895461-4-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923143438.1895461-4-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on robh/for-next pza/reset/next linus/master v6.6-rc2 next-20230921]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Neusch-fer/dt-bindings-clock-Add-Nuvoton-WPCM450-clock-reset-controller/20230923-223751
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20230923143438.1895461-4-j.neuschaefer%40gmx.net
patch subject: [PATCH v9 3/3] clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller driver
config: nios2-randconfig-002-20230924 (https://download.01.org/0day-ci/archive/20230924/202309240640.6iNEdfCX-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309240640.6iNEdfCX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309240640.6iNEdfCX-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/clk/nuvoton/clk-wpcm450.o: in function `wpcm450_clk_init':
   clk-wpcm450.c:(.init.text+0x384): undefined reference to `reset_simple_ops'
>> nios2-linux-ld: clk-wpcm450.c:(.init.text+0x388): undefined reference to `reset_simple_ops'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
