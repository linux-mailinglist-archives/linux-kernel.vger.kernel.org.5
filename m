Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13617FCC48
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376697AbjK2BM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2BM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:12:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257E619A6;
        Tue, 28 Nov 2023 17:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701220353; x=1732756353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=STFBo+zgE+pMyFPtzum89vP4OwZb2dxh/ad617/2AUA=;
  b=Q6GAGwI9LCQbNbG4O0D5KBolX6iXovVNgWhzdQJM0T5Z8QqVI3nQSu0u
   k9RzgbsT0GiZuKUB0e3Os6SdrJyKPDqMhCDmUrGrlDNpc9vxlS+u5lBSt
   fnDCi5NOfVYI2hjGwbBU8OCSCIGFEOIYHEmcg7A7ob8M3w5rPPfHErpgg
   XxndHLyLeHwA8Ym2CaKwyL/zzWyuztlxnYlUu7xnaL6xQuKMz/hNWAShC
   KZ++pb3Dm1HQV6aJ0PrNHVjfi8RnN8rHxdR/WhuxKWgcn8ZahK1wDZTRd
   5PBS8YjMFz/FYNjTzwNc9T3S6iZgpdGU6mg5T7hv/GooFsUho3SiAZ/ju
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="391929198"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="391929198"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 17:12:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="745084464"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="745084464"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Nov 2023 17:12:29 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r897q-0008Ng-2J;
        Wed, 29 Nov 2023 01:12:26 +0000
Date:   Wed, 29 Nov 2023 09:11:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
Subject: Re: [PATCH v2 3/4] arm64: dts: nuvoton: Add pinctrl support for
 ma35d1
Message-ID: <202311290626.fFZShqCp-lkp@intel.com>
References: <20231128061118.575847-4-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128061118.575847-4-ychuang570808@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacky,

kernel test robot noticed the following build errors:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next robh/for-next linus/master v6.7-rc3 next-20231128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacky-Huang/dt-bindings-reset-Add-syscon-to-nuvoton-ma35d1-system-management-node/20231128-141443
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20231128061118.575847-4-ychuang570808%40gmail.com
patch subject: [PATCH v2 3/4] arm64: dts: nuvoton: Add pinctrl support for ma35d1
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231129/202311290626.fFZShqCp-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311290626.fFZShqCp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311290626.fFZShqCp-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts:9:
>> arch/arm64/boot/dts/nuvoton/ma35d1.dtsi:13:10: fatal error: dt-bindings/pinctrl/ma35d1-pinfunc.h: No such file or directory
      13 | #include <dt-bindings/pinctrl/ma35d1-pinfunc.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +13 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi

  > 13	#include <dt-bindings/pinctrl/ma35d1-pinfunc.h>
    14	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
