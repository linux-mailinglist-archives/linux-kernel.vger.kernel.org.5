Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1466580B99B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 08:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjLJHSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 02:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJHSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 02:18:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929FDC1;
        Sat,  9 Dec 2023 23:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702192717; x=1733728717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XEDe53FhnKOoAuCE2jD8tTR9AUPAF2wP57RC8AH32QQ=;
  b=Otc6hUtQny9PcQb+GQUCcbex4rKmBmFDggyfkmNbGMhzf4PAi64BM5F2
   AUu54FnOij32AL2BIXPythSSIGxizDzgafjzX2ZSN9V6hxTKmafdhnKzJ
   ydYO38Pqhlu0E4BPwDdXMfqddMV1WGiwoZiZelOm2gZadBJsJBaJmUTh+
   IiTZog4HPUVq7cNzQsrPLC0O6JA3bXqu1SfaeI5VZYVhuem2Qwr9DjU3F
   DUxuKywsGAuNyON3yCtjVKy+yLgPZlztx69HR8KTsbUVbVxTNnt8BdajL
   K8BoZwrzaspH1Qw8o1uK9JL4r9lbcAQtdyBs8y6j6zmi9h1kk2+Pjs5Af
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="13236063"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="13236063"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 23:18:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="776266363"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="776266363"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 09 Dec 2023 23:18:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCE59-000GWT-1h;
        Sun, 10 Dec 2023 07:18:31 +0000
Date:   Sun, 10 Dec 2023 15:18:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Yan <andyshrk@163.com>, heiko@sntech.de
Cc:     oe-kbuild-all@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Andy Yan <andyshrk@163.com>
Subject: Re: [PATCH 3/5] arm64: dts: rockchip: Add support for rk3588s based
 board CoolPi 4B
Message-ID: <202312101526.ApwoImlf-lkp@intel.com>
References: <20231209103802.1568552-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209103802.1568552-1-andyshrk@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on robh/for-next linus/master v6.7-rc4 next-20231208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Yan/dt-bindings-vendor-prefixes-Add-Cool-Pi/20231209-184214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20231209103802.1568552-1-andyshrk%40163.com
patch subject: [PATCH 3/5] arm64: dts: rockchip: Add support for rk3588s based board CoolPi 4B
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231210/202312101526.ApwoImlf-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312101526.ApwoImlf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312101526.ApwoImlf-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts:696.1-7 Label or path hdmi0 not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
