Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0B47E4F28
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbjKHCw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjKHCwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:52:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5691734;
        Tue,  7 Nov 2023 18:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699411932; x=1730947932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UjDq3aK7BBV9YtcRKon7ZDWKovhxfGEGI88OP8yJpdQ=;
  b=Yjv6Oha5N/uuzSz5+XJSyiItviNmggLk507Wkf2DL3yWilLU0Lxb4cPk
   Yn/pRsAy/JGP+B9vjGrkPbHPD7e7uOwBnz3t5tlLByhquvd7cbp6ZH6nX
   w7dhd7zUpXTrCiEwzyuT0lt55AbfYATxZYtGn+uQLkWzCw/t5ZUlL0VKu
   g5sxWSVbbPfnnkBjgGZgk1bWFpNqftRdGqiOn0kWpfZ2OvgAqMgxB6RxQ
   iayyn/EpgjvjtBaJU/qmlMoivRfPTELOepX9SAi4fhCjdDezE194RR6Im
   hVkMxjglZ6MJ8UZifkeM4T0gbQFOUVOKdFglBq01BNmxdC3xAbgvzHOv8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="392547047"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="392547047"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 18:52:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="792047435"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="792047435"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Nov 2023 18:52:09 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0Yfm-0007bD-2q;
        Wed, 08 Nov 2023 02:52:06 +0000
Date:   Wed, 8 Nov 2023 10:50:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Esteban Blanc <eblanc@baylibre.com>, linus.walleij@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, eblanc@baylibre.com,
        u-kumar1@ti.com
Subject: Re: [PATCH v9] pinctrl: tps6594: Add driver for TPS6594 pinctrl and
 GPIOs
Message-ID: <202311081058.CGIfVQNO-lkp@intel.com>
References: <20231107094720.2223541-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107094720.2223541-1-eblanc@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esteban,

kernel test robot noticed the following build errors:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next v6.6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Esteban-Blanc/pinctrl-tps6594-Add-driver-for-TPS6594-pinctrl-and-GPIOs/20231107-180907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20231107094720.2223541-1-eblanc%40baylibre.com
patch subject: [PATCH v9] pinctrl: tps6594: Add driver for TPS6594 pinctrl and GPIOs
config: um-randconfig-001-20231107 (https://download.01.org/0day-ci/archive/20231108/202311081058.CGIfVQNO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231108/202311081058.CGIfVQNO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311081058.CGIfVQNO-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: drivers/pinctrl/pinctrl-tps6594.o: in function `pinconf_generic_dt_node_to_map_group':
   pinctrl-tps6594.c:(.text+0x289): undefined reference to `pinconf_generic_dt_node_to_map'
>> /usr/bin/ld: drivers/pinctrl/pinctrl-tps6594.o:(.rodata+0x68): undefined reference to `pinconf_generic_dt_free_map'
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
