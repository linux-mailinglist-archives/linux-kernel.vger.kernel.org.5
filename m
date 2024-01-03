Return-Path: <linux-kernel+bounces-16073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4685B82383A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39022873F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352201EB5E;
	Wed,  3 Jan 2024 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SONJOK+r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE81DDFA;
	Wed,  3 Jan 2024 22:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704320944; x=1735856944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UWtB1gRQtwdmcRcaSKiXS/7N9+STofOIO3C3Hp7vBzc=;
  b=SONJOK+r6qNmMtFQbYjVPJ5054gKb7ndoaIlOnPdqyYCAbjwOnzjBD2o
   vbbz2F3xnD8/TMk60l+keMCsEjigLdEzhooKjyFzmWiNEnrBsIUMC2PJ2
   SoIWzq5hYUqs9HbFSaQwuMGmcFgjisKK6+4oho5M6U2OpBoveiBLq1UAK
   9pmzvpED1VC372q5l3is7vv7sg0ckBiZpVSFBgvBbinap7nd8EvQin20i
   y0Fpv5aB/coeClpdok86gdzAUUdcEi5xBcfmVGhFkaPbl+gwtK/CKMWzy
   V9+5CMzwmmtuU4GlFrFAHi9u9Z4Y2jjkwajLK/01mV0MMClMfbJc50Erl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="387541622"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="387541622"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 14:29:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="903580244"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="903580244"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 03 Jan 2024 14:29:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rL9jO-000Mci-1H;
	Wed, 03 Jan 2024 22:28:58 +0000
Date: Thu, 4 Jan 2024 06:28:40 +0800
From: kernel test robot <lkp@intel.com>
To: Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>,
	mturquette@baylibre.com, sboyd@kernel.org, michal.simek@amd.com,
	abel.vesa@linaro.org, robh@kernel.org,
	krzysztof.kozlowski@linaro.org,
	angelogioacchino.delregno@collabora.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>
Subject: Re: [PATCH] drivers: clk: zynqmp: remove clock name dependency
Message-ID: <202401040635.RiqRRo7w-lkp@intel.com>
References: <20240103072017.1646007-1-naman.trivedimanojbhai@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103072017.1646007-1-naman.trivedimanojbhai@amd.com>

Hi Naman,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v6.7-rc8 next-20240103]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Naman-Trivedi-Manojbhai/drivers-clk-zynqmp-remove-clock-name-dependency/20240103-152152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20240103072017.1646007-1-naman.trivedimanojbhai%40amd.com
patch subject: [PATCH] drivers: clk: zynqmp: remove clock name dependency
config: arm64-randconfig-004-20240103 (https://download.01.org/0day-ci/archive/20240104/202401040635.RiqRRo7w-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240104/202401040635.RiqRRo7w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401040635.RiqRRo7w-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/zynqmp/clkc.c:565:15: error: assigning to 'char *' from 'const char *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                                           clk_name = __clk_get_name(clk_parent);
                                                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/zynqmp/clkc.c:583:15: error: assigning to 'char *' from 'const char *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                                           clk_name = __clk_get_name(clk_parent);
                                                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +565 drivers/clk/zynqmp/clkc.c

   535	
   536	/**
   537	 * zynqmp_get_parent_list() - Create list of parents name
   538	 * @np:			Device node
   539	 * @clk_id:		Clock index
   540	 * @parent_list:	List of parent's name
   541	 * @num_parents:	Total number of parents
   542	 *
   543	 * Return: 0 on success else error+reason
   544	 */
   545	static int zynqmp_get_parent_list(struct device_node *np, u32 clk_id,
   546					  const char **parent_list, u32 *num_parents)
   547	{
   548		int i = 0, ret;
   549		u32 total_parents = clock[clk_id].num_parents;
   550		struct clock_topology *clk_nodes;
   551		struct clock_parent *parents;
   552		struct clk *clk_parent;
   553		char *clk_name;
   554	
   555		clk_nodes = clock[clk_id].node;
   556		parents = clock[clk_id].parent;
   557	
   558		for (i = 0; i < total_parents; i++) {
   559			if (!parents[i].flag) {
   560				ret = of_property_match_string(np, "clock-names",
   561							       parents[i].name);
   562				if (ret >= 0) {
   563					clk_parent = of_clk_get(np, ret);
   564					if (clk_parent) {
 > 565						clk_name = __clk_get_name(clk_parent);
   566						if (clk_name)
   567							strcpy(parents[i].name, clk_name);
   568						else
   569							return 1;
   570					} else {
   571						return 1;
   572					}
   573				}
   574				parent_list[i] = parents[i].name;
   575			} else if (parents[i].flag == PARENT_CLK_EXTERNAL) {
   576				ret = of_property_match_string(np, "clock-names",
   577							       parents[i].name);
   578				if (ret < 0) {
   579					strcpy(parents[i].name, "dummy_name");
   580				} else {
   581					clk_parent = of_clk_get(np, ret);
   582					if (clk_parent) {
   583						clk_name = __clk_get_name(clk_parent);
   584						if (clk_name)
   585							strcpy(parents[i].name, clk_name);
   586						else
   587							return 1;
   588					} else {
   589						return 1;
   590					}
   591				}
   592				parent_list[i] = parents[i].name;
   593			} else {
   594				strcat(parents[i].name,
   595				       clk_type_postfix[clk_nodes[parents[i].flag - 1].
   596				       type]);
   597				parent_list[i] = parents[i].name;
   598			}
   599		}
   600	
   601		*num_parents = total_parents;
   602		return 0;
   603	}
   604	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

