Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744EC7E0EB8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 11:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjKDKLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 06:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjKDKLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 06:11:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6E9D44
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699092665; x=1730628665;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dzJktJFHYlcT3caCKh0aqY+Rcb7gfGJbsh8LL7rbaAg=;
  b=ZxWkeTE0IMJsyeZlVqqm5yRjB2KIv2uKYP8uma2BNHbutTUCs3wDnU/e
   x4VA1YfVm+IXtnd0DycDTXxJbOCbbBbCEkdPAx+wYT16aERIwWh2KoyPX
   qBusOwwTTHdboxp2f8Q8VKZ6FUd7CObNs4BootOgxEs4a3jkWXAvbFw+t
   iBwj30mm0KPwH4keIoNSOOM9P44RLjWff95SqQaNgTodBobax5ucxcoj2
   I0J2wiEkxy4UyzhKCks3zkhtxXSx0oSJ0bxNDls6uNpXd5Hq8adcGENpR
   BUTOTA2u6tz0yxKTDrHic34XILzZHxCxyzLKXy49F++Lq4OCmMRY2HLtD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="386249903"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="386249903"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 03:11:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="791012490"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="791012490"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Nov 2023 03:11:02 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzDcJ-0003lY-37;
        Sat, 04 Nov 2023 10:10:59 +0000
Date:   Sat, 4 Nov 2023 18:10:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: drivers/clk/mvebu/clk-cpu.c:200:41: warning: 'sprintf' may write a
 terminating nul past the end of the destination
Message-ID: <202311041722.oU3dQNqT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90b0c2b2edd1adff742c621e246562fbefa11b70
commit: bd73d1fd63d4f67dc78640c9ae4f83e20a021d76 clk: mvebu: Iterate over possible CPUs instead of DT CPU nodes
date:   5 months ago
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231104/202311041722.oU3dQNqT-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311041722.oU3dQNqT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311041722.oU3dQNqT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/mvebu/clk-cpu.c: In function 'of_cpu_clk_setup':
>> drivers/clk/mvebu/clk-cpu.c:200:41: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
     200 |                 sprintf(clk_name, "cpu%d", cpu);
         |                                         ^
   drivers/clk/mvebu/clk-cpu.c:200:17: note: 'sprintf' output between 5 and 6 bytes into a destination of size 5
     200 |                 sprintf(clk_name, "cpu%d", cpu);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sprintf +200 drivers/clk/mvebu/clk-cpu.c

ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  165  
9ac81751d67b2a Sachin Kamat     2013-10-08  166  static void __init of_cpu_clk_setup(struct device_node *node)
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  167  {
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  168  	struct cpu_clk *cpuclk;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  169  	void __iomem *clock_complex_base = of_iomap(node, 0);
ee2d8ea1e9bb27 Thomas Petazzoni 2014-07-09  170  	void __iomem *pmu_dfs_base = of_iomap(node, 1);
bd73d1fd63d4f6 Rob Herring      2023-06-09  171  	int ncpus = num_possible_cpus();
bd73d1fd63d4f6 Rob Herring      2023-06-09  172  	int cpu;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  173  
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  174  	if (clock_complex_base == NULL) {
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  175  		pr_err("%s: clock-complex base register not set\n",
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  176  			__func__);
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  177  		return;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  178  	}
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  179  
ee2d8ea1e9bb27 Thomas Petazzoni 2014-07-09  180  	if (pmu_dfs_base == NULL)
ee2d8ea1e9bb27 Thomas Petazzoni 2014-07-09  181  		pr_warn("%s: pmu-dfs base register not set, dynamic frequency scaling not available\n",
ee2d8ea1e9bb27 Thomas Petazzoni 2014-07-09  182  			__func__);
ee2d8ea1e9bb27 Thomas Petazzoni 2014-07-09  183  
23826e240ad827 Markus Elfring   2017-04-19  184  	cpuclk = kcalloc(ncpus, sizeof(*cpuclk), GFP_KERNEL);
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  185  	if (WARN_ON(!cpuclk))
f98d007d332b81 Jisheng Zhang    2013-08-23  186  		goto cpuclk_out;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  187  
23826e240ad827 Markus Elfring   2017-04-19  188  	clks = kcalloc(ncpus, sizeof(*clks), GFP_KERNEL);
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  189  	if (WARN_ON(!clks))
d6f620a457aa4c Cong Ding        2013-01-15  190  		goto clks_out;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  191  
bd73d1fd63d4f6 Rob Herring      2023-06-09  192  	for_each_possible_cpu(cpu) {
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  193  		struct clk_init_data init;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  194  		struct clk *clk;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  195  		char *clk_name = kzalloc(5, GFP_KERNEL);
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  196  
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  197  		if (WARN_ON(!clk_name))
d6f620a457aa4c Cong Ding        2013-01-15  198  			goto bail_out;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  199  
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17 @200  		sprintf(clk_name, "cpu%d", cpu);
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  201  
61e22fff647544 Stephen Boyd     2015-10-16  202  		cpuclk[cpu].parent_name = of_clk_get_parent_name(node, 0);
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  203  		cpuclk[cpu].clk_name = clk_name;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  204  		cpuclk[cpu].cpu = cpu;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  205  		cpuclk[cpu].reg_base = clock_complex_base;
ee2d8ea1e9bb27 Thomas Petazzoni 2014-07-09  206  		if (pmu_dfs_base)
ee2d8ea1e9bb27 Thomas Petazzoni 2014-07-09  207  			cpuclk[cpu].pmu_dfs = pmu_dfs_base + 4 * cpu;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  208  		cpuclk[cpu].hw.init = &init;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  209  
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  210  		init.name = cpuclk[cpu].clk_name;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  211  		init.ops = &cpu_ops;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  212  		init.flags = 0;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  213  		init.parent_names = &cpuclk[cpu].parent_name;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  214  		init.num_parents = 1;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  215  
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  216  		clk = clk_register(NULL, &cpuclk[cpu].hw);
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  217  		if (WARN_ON(IS_ERR(clk)))
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  218  			goto bail_out;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  219  		clks[cpu] = clk;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  220  	}
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  221  	clk_data.clk_num = MAX_CPU;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  222  	clk_data.clks = clks;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  223  	of_clk_add_provider(node, of_clk_src_onecell_get, &clk_data);
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  224  
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  225  	return;
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  226  bail_out:
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  227  	kfree(clks);
d6f620a457aa4c Cong Ding        2013-01-15  228  	while(ncpus--)
d6f620a457aa4c Cong Ding        2013-01-15  229  		kfree(cpuclk[ncpus].clk_name);
d6f620a457aa4c Cong Ding        2013-01-15  230  clks_out:
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  231  	kfree(cpuclk);
f98d007d332b81 Jisheng Zhang    2013-08-23  232  cpuclk_out:
f98d007d332b81 Jisheng Zhang    2013-08-23  233  	iounmap(clock_complex_base);
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  234  }
ab8ba01b3fe5e0 Gregory CLEMENT  2012-11-17  235  

:::::: The code at line 200 was first introduced by commit
:::::: ab8ba01b3fe5e0b81bd2da0afe66f7f6968e017b clk: mvebu: add armada-370-xp CPU specific clocks

:::::: TO: Gregory CLEMENT <gregory.clement@free-electrons.com>
:::::: CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
