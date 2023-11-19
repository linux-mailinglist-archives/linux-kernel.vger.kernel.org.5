Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3B17F0599
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjKSLMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSLMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:12:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B3C4;
        Sun, 19 Nov 2023 03:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700392364; x=1731928364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l6MB7KR6Wqu2v79BBJpxIM6CND7+cD3U13FwZlh4YFU=;
  b=X6m0PWVDLhkbRuM3U2CSB76y42cxK8lwbr1DyEpRryEAIN9xaAQA9kSJ
   Gj1NzlHWZMyXCu/p7+tB7zOyNzMOUbeGCG8AIILEkRKj8C6c+9u8ua78o
   7PtrHBA8vHEwO0i3b45kHmbfA8pjQnS0FBrGBLyskoHRSTU3epPEUPOE0
   DbvayQEByVdeqG23Oul10GyDlguNF8RIPnV/htEwUpswLELJjE122Oq+B
   OSm8hlVeH2hnrwi7QCD2eyvgQfR/7gJ4aAXly5tWt6K4I6XtdKhdVxgxD
   O6XU2ASPo9d2YHYDIawfmPcfyDn2ZC4H9IlP3PlJHvLJIUPWlg0YB1/gE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="376523988"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="376523988"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 03:12:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="769628656"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="769628656"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 19 Nov 2023 03:12:39 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4fjB-00051h-08;
        Sun, 19 Nov 2023 11:12:37 +0000
Date:   Sun, 19 Nov 2023 19:11:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH 4/5] clk: sophgo: Add SG2042 clock generator driver
Message-ID: <202311191920.5xIUxW5n-lkp@intel.com>
References: <1000e8d546514973364478271564356352a46ed5.1699879741.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1000e8d546514973364478271564356352a46ed5.1699879741.git.unicorn_wang@outlook.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Wang/dt-bindings-clock-sophgo-Add-SG2042-clock-definitions/20231113-212401
base:   b85ea95d086471afb4ad062012a4d73cd328fa86
patch link:    https://lore.kernel.org/r/1000e8d546514973364478271564356352a46ed5.1699879741.git.unicorn_wang%40outlook.com
patch subject: [PATCH 4/5] clk: sophgo: Add SG2042 clock generator driver
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20231119/202311191920.5xIUxW5n-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311191920.5xIUxW5n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311191920.5xIUxW5n-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/sophgo/clk-sophgo-sg2042.c:217:44: warning: overflow in expression; result is -1094967296 with type 'long' [-Winteger-overflow]
     217 |                         if (foutvco < PLL_FREQ_MIN || foutvco > PLL_FREQ_MAX
         |                                                                 ^
   drivers/clk/sophgo/clk-sophgo-sg2042.c:25:28: note: expanded from macro 'PLL_FREQ_MAX'
      25 | #define PLL_FREQ_MAX (3200 * MHZ)
         |                            ^
   1 warning generated.


vim +/long +217 drivers/clk/sophgo/clk-sophgo-sg2042.c

   201	
   202	static int __sg2042_get_pll_ctl_setting(
   203		struct sg2042_pll_ctrl *best,
   204		unsigned long req_rate,
   205		unsigned long parent_rate)
   206	{
   207		int ret;
   208		unsigned int fbdiv, refdiv, fref, postdiv1, postdiv2;
   209		unsigned long tmp = 0, foutvco;
   210	
   211		fref = parent_rate;
   212	
   213		for (refdiv = REFDIV_MIN; refdiv < REFDIV_MAX + 1; refdiv++) {
   214			for (fbdiv = FBDIV_MIN; fbdiv < FBDIV_MAX + 1; fbdiv++) {
   215				foutvco = fref * fbdiv / refdiv;
   216				/* check fpostdiv pfd */
 > 217				if (foutvco < PLL_FREQ_MIN || foutvco > PLL_FREQ_MAX
   218						|| (fref / refdiv) < 10)
   219					continue;
   220	
   221				ret = __sg2042_pll_get_postdiv_1_2(req_rate, fref, fbdiv,
   222						refdiv, &postdiv1, &postdiv2);
   223				if (ret)
   224					continue;
   225	
   226				tmp = foutvco / (postdiv1 * postdiv2);
   227				if (abs_diff(tmp, req_rate) < abs_diff(best->freq, req_rate)) {
   228					best->freq = tmp;
   229					best->refdiv = refdiv;
   230					best->fbdiv = fbdiv;
   231					best->postdiv1 = postdiv1;
   232					best->postdiv2 = postdiv2;
   233					if (tmp == req_rate)
   234						return 0;
   235				}
   236				continue;
   237			}
   238		}
   239	
   240		return 0;
   241	}
   242	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
