Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913DB809268
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443917AbjLGUeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjLGUdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:33:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248D71723;
        Thu,  7 Dec 2023 12:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701981239; x=1733517239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4utBiV134gRoO48soBfJ8QpcFZDaar9aUc6yImhniHw=;
  b=OuOWf1S/rc/fSKyuTcALyRBVjkqAnpIi8pPEVTbcOIqCV4FWhOSpoG88
   vEU+gOIc1Y6axwVDk1818+nSCRXV/3S/nwREg8cKDIzcd+ttaRlKpurLG
   tulEuSn+Lrpn8zY/DaB+Xp11sNXpaaK9cvWIHiPEHzbHQWQ3/apJNeKkC
   FUkh2azS2fi1qw4SAWGlHibm+wUOjDwnPdLAgK2rFOOdzhGSwSkC2gFpO
   WnM7KDnhKypLVBfWRaJhr5Bwjzk7vChN4PuGqqjwFTbjMOXraWUzZ5Flp
   RABGiwnjS6d0BHBGp7G8ywbEzzJVUB7KgbRTw0bS8tcwfm0KpOTrfMV4d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1410463"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1410463"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 12:33:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="771876772"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="771876772"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Dec 2023 12:33:53 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBL4B-000Cnf-1i;
        Thu, 07 Dec 2023 20:33:51 +0000
Date:   Fri, 8 Dec 2023 04:33:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
Cc:     oe-kbuild-all@lists.linux.dev, Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v5 3/4] clk: sophgo: Add SG2042 clock generator driver
Message-ID: <202312080441.KewnhdyO-lkp@intel.com>
References: <975f9995584dfa8af751e96a1f4d2c7991551a35.1701938395.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <975f9995584dfa8af751e96a1f4d2c7991551a35.1701938395.git.unicorn_wang@outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on b85ea95d086471afb4ad062012a4d73cd328fa86]

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Wang/dt-bindings-soc-sophgo-Add-Sophgo-system-control-module/20231207-165948
base:   b85ea95d086471afb4ad062012a4d73cd328fa86
patch link:    https://lore.kernel.org/r/975f9995584dfa8af751e96a1f4d2c7991551a35.1701938395.git.unicorn_wang%40outlook.com
patch subject: [PATCH v5 3/4] clk: sophgo: Add SG2042 clock generator driver
config: riscv-randconfig-r113-20231208 (https://download.01.org/0day-ci/archive/20231208/202312080441.KewnhdyO-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231208/202312080441.KewnhdyO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080441.KewnhdyO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zihintpause'
>> drivers/clk/sophgo/clk-sophgo-sg2042.c:1037:1: sparse: sparse: symbol 'sg2042_clk_lock' was not declared. Should it be static?
   drivers/clk/sophgo/clk-sophgo-sg2042.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +/sg2042_clk_lock +1037 drivers/clk/sophgo/clk-sophgo-sg2042.c

  1036	
> 1037	DEFINE_SPINLOCK(sg2042_clk_lock);
  1038	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
