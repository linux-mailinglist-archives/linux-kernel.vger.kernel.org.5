Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFEA7DFE95
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 05:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjKCEoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 00:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCEoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 00:44:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDD51A1;
        Thu,  2 Nov 2023 21:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698986656; x=1730522656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2SXVdT3QTwh6hC3HDSUujmJLLfviyyyz9kkfzsGyAlA=;
  b=Lb6FgHmY6Z4TFPQwFlaS+DI8xNxptRH+WEQ7NyziNqQUzsdMSc3/rjtO
   mshBNzKU0AnFP8/DbgGOrNMN/mLmKjOJP+OIEgol9Jl2icu9L6TfhZ/7Q
   fBP94hxXuL1oSUnzvkR32eaTZ3Ctwsgj/Lwe3BYiZ0SMV9XL7qA28GRFp
   UsIY8YfrutomBEyU5gnCo7UBD5JYfosw79wpaPUJpghKD5LRviXZ5D0rB
   KmwieFsuPS+dCZptKDWcN7EzDr3wiDXvuc2NX/FWltNu9aAqJRXhvq60q
   Ict16aR7VuYLDvB+LTt48KLPMeU+JLsXgKawjsWGyqB3AVAk0U9xJqeas
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="392757981"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="392757981"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 21:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="9624450"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 02 Nov 2023 21:44:13 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qym2V-0002E4-0G;
        Fri, 03 Nov 2023 04:44:11 +0000
Date:   Fri, 3 Nov 2023 12:43:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Esteban Blanc <eblanc@baylibre.com>, linus.walleij@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, andy.shevchenko@gmail.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, eblanc@baylibre.com,
        u-kumar1@ti.com
Subject: Re: [PATCH v8] pinctrl: tps6594: Add driver for TPS6594 pinctrl and
 GPIOs
Message-ID: <202311031233.sJVCIk08-lkp@intel.com>
References: <20231102101357.977886-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102101357.977886-1-eblanc@baylibre.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esteban,

kernel test robot noticed the following build errors:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next linus/master v6.6 next-20231102]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Esteban-Blanc/pinctrl-tps6594-Add-driver-for-TPS6594-pinctrl-and-GPIOs/20231102-203228
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20231102101357.977886-1-eblanc%40baylibre.com
patch subject: [PATCH v8] pinctrl: tps6594: Add driver for TPS6594 pinctrl and GPIOs
config: i386-buildonly-randconfig-004-20231103 (https://download.01.org/0day-ci/archive/20231103/202311031233.sJVCIk08-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311031233.sJVCIk08-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311031233.sJVCIk08-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/pinctrl/pinctrl-tps6594.o: in function `pinconf_generic_dt_node_to_map_group':
>> pinctrl-tps6594.c:(.text+0x139): undefined reference to `pinconf_generic_dt_node_to_map'
   ld: drivers/pinctrl/pinctrl-tps6594.o:(.rodata+0x14): undefined reference to `pinconf_generic_dt_free_map'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
