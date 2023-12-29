Return-Path: <linux-kernel+bounces-13219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AECD7820149
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BD9280F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7A21400A;
	Fri, 29 Dec 2023 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVpvsdeA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBE13AE4;
	Fri, 29 Dec 2023 20:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703880159; x=1735416159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kPgOyksAfpz6W5ln3A5jSAFEQWpaAXI0tVkZqfEyw5U=;
  b=HVpvsdeA2LT3wT8bne8EqtHJtX2tuToGu+AiTfmOiNXlT0cAUWcrAX8L
   W6sVny9dr0dTU7HWJCePHzPJP4q74cPQYI4t5ErTTiGe/lBVHAXxyG0er
   sSkYfqmIDHSp/ThSEwAXpLoYvWBGKvccb0cztHcTEbGAmg+v+t5TsmiFV
   0z7DyWpETBAp8k3Cep9gNI3sA9bl/Pb7HnkfwHlLume6It5IwZ/IOXLx+
   SuTyc4K1KQ1tuspSdbg22I37i78WzmUvC6oxnFbOsBACeumNi8nmVIONU
   58Rg7TTNmW8dP1AhE/UDkxP4XxaD/oDbz8GMrycD1uFFL3Q4hsRt3jj5i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="18221237"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="18221237"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 12:02:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="1110243697"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="1110243697"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 29 Dec 2023 12:02:35 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJJ3x-000Hkd-0D;
	Fri, 29 Dec 2023 20:02:33 +0000
Date: Sat, 30 Dec 2023 04:02:04 +0800
From: kernel test robot <lkp@intel.com>
To: Chunyan Zhang <chunyan.zhang@unisoc.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH 3/3] clk: sprd: add support for UMS9620
Message-ID: <202312300330.yMjWp5Pr-lkp@intel.com>
References: <20231229085156.1490233-4-chunyan.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229085156.1490233-4-chunyan.zhang@unisoc.com>

Hi Chunyan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on robh/for-next krzk-dt/for-next linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunyan-Zhang/dt-bindings-clk-sprd-Add-UMS9620-support/20231229-165718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20231229085156.1490233-4-chunyan.zhang%40unisoc.com
patch subject: [PATCH 3/3] clk: sprd: add support for UMS9620
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231230/202312300330.yMjWp5Pr-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231230/202312300330.yMjWp5Pr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312300330.yMjWp5Pr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/sprd/ums9620-clk.c:2642:37: warning: 'depth_parents' defined but not used [-Wunused-const-variable=]
    2642 | static const struct clk_parent_data depth_parents[] = {
         |                                     ^~~~~~~~~~~~~
>> drivers/clk/sprd/ums9620-clk.c:1671:37: warning: 'pmu_26m_parents' defined but not used [-Wunused-const-variable=]
    1671 | static const struct clk_parent_data pmu_26m_parents[] = {
         |                                     ^~~~~~~~~~~~~~~


vim +/depth_parents +2642 drivers/clk/sprd/ums9620-clk.c

  2568	
  2569	/* mm clocks */
  2570	static const struct clk_parent_data vdsp_parents[] = {
  2571		{ .fw_name = "ext-26m" },
  2572		{ .hw = &tgpll_307m2.hw },
  2573		{ .hw = &tgpll_512m.hw },
  2574		{ .hw = &tgpll_614m4.hw },
  2575		{ .hw = &v4nrpll_819m2.hw },
  2576		{ .hw = &vdsppll.common.hw }
  2577	};
  2578	static SPRD_MUX_CLK_DATA(vdsp, "vdsp", vdsp_parents, 0x28,
  2579			    0, 2, CLK_SET_RATE_NO_REPARENT);
  2580	static SPRD_DIV_CLK_HW(vdsp_m, "vdsp-m", &vdsp.common.hw, 0x30,
  2581			    0, 2, 0);
  2582	
  2583	static const struct clk_parent_data vdma_parents[] = {
  2584		{ .fw_name = "ext-26m" },
  2585		{ .hw = &tgpll_153m6.hw },
  2586		{ .hw = &tgpll_256m.hw },
  2587		{ .hw = &tgpll_307m2.hw },
  2588		{ .hw = &v4nrpll_409m6.hw },
  2589		{ .hw = &tgpll_512m.hw },
  2590	};
  2591	static SPRD_MUX_CLK_DATA(vdma, "vdma", vdma_parents, 0x40,
  2592			    0, 3, UMS9620_MUX_FLAG);
  2593	
  2594	static const struct clk_parent_data vdsp_mtx_data_parents[] = {
  2595		{ .hw = &tgpll_153m6.hw },
  2596		{ .hw = &tgpll_307m2.hw },
  2597		{ .hw = &v4nrpll_409m6.hw },
  2598		{ .hw = &tgpll_512m.hw },
  2599	};
  2600	static SPRD_MUX_CLK_DATA(vdsp_mtx_data, "vdsp-mtx-data", vdsp_mtx_data_parents,
  2601			    0x58, 0, 2, UMS9620_MUX_FLAG);
  2602	
  2603	static const struct clk_parent_data vdsp_blk_cfg_parents[] = {
  2604		{ .fw_name = "ext-26m" },
  2605		{ .hw = &tgpll_48m.hw },
  2606		{ .hw = &tgpll_64m.hw },
  2607		{ .hw = &tgpll_96m.hw },
  2608		{ .hw = &tgpll_128m.hw },
  2609	};
  2610	static SPRD_MUX_CLK_DATA(vdsp_blk_cfg, "vdsp-blk-cfg", vdsp_blk_cfg_parents,
  2611			    0x64, 0, 3, UMS9620_MUX_FLAG);
  2612	
  2613	static const struct clk_parent_data mm_uart_parents[] = {
  2614		{ .fw_name = "ext-26m" },
  2615		{ .hw = &tgpll_48m.hw },
  2616		{ .hw = &tgpll_51m2.hw },
  2617		{ .hw = &tgpll_96m.hw },
  2618	};
  2619	static SPRD_MUX_CLK_DATA(mm_uart, "mm-uart", mm_uart_parents, 0x70,
  2620			    0, 2, UMS9620_MUX_FLAG);
  2621	
  2622	static const struct clk_parent_data isp_parents[] = {
  2623		{ .hw = &tgpll_153m6.hw },
  2624		{ .hw = &tgpll_256m.hw },
  2625		{ .hw = &tgpll_307m2.hw },
  2626		{ .hw = &v4nrpll_409m6.hw },
  2627		{ .hw = &tgpll_512m.hw },
  2628	};
  2629	static SPRD_MUX_CLK_DATA(isp, "isp", isp_parents, 0x7c,
  2630			    0, 3, UMS9620_MUX_FLAG);
  2631	
  2632	static const struct clk_parent_data cpp_parents[] = {
  2633		{ .hw = &tgpll_128m.hw },
  2634		{ .hw = &tgpll_192m.hw },
  2635		{ .hw = &tgpll_256m.hw },
  2636		{ .hw = &tgpll_307m2.hw },
  2637		{ .hw = &tgpll_384m.hw },
  2638	};
  2639	static SPRD_MUX_CLK_DATA(cpp, "cpp", cpp_parents, 0x88,
  2640			    0, 3, UMS9620_MUX_FLAG);
  2641	
> 2642	static const struct clk_parent_data depth_parents[] = {
  2643		{ .hw = &tgpll_128m.hw },
  2644		{ .hw = &tgpll_192m.hw },
  2645		{ .hw = &tgpll_256m.hw },
  2646		{ .hw = &tgpll_307m2.hw },
  2647		{ .hw = &tgpll_384m.hw },
  2648	};
  2649	static SPRD_MUX_CLK_DATA(depth, "depth", cpp_parents, 0xa0,
  2650			    0, 3, UMS9620_MUX_FLAG);
  2651	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

