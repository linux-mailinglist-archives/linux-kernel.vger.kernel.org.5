Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7197E3755
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjKGJRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjKGJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:17:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81331113;
        Tue,  7 Nov 2023 01:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699348664; x=1730884664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P71XwON/JZ6FXbku3xz98s//Jj44TIH+098MqA3/xKw=;
  b=M/t536hovMpT9bVbl2AwmcJp33m2cv6JkJBw0YoHQJYhAFlTm7t+9Vj3
   7L0nJmwzrPp+vXuy2hpkVgX3lQTVJEF6z2M+85zEqbdE+v/pz765pksfZ
   D3Ph2B9IqIc1BGKuGQNEH2fK7UPLWw9Hy5e3MrLfbeYFuZqntHptY6CS3
   ZQgJiHDp7idJCliD15fSBiP7dl8kZEKcBewUbva879VPdiF0ZQlzRbG7/
   7O5ebsK3AnhlwVHXH8+BgrNHy+6R8QzdFK/CsU+eh+ZxK2VwJZZFcdYhl
   vb+K00VUhaiSr+MjnfLfyP5wPTM/uYEDzMVmzg5w8ZrEylwdr3/Wz4/0G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="369662257"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="369662257"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 01:17:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="906357335"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="906357335"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Nov 2023 01:17:42 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0IDL-00070S-2U;
        Tue, 07 Nov 2023 09:17:39 +0000
Date:   Tue, 7 Nov 2023 17:16:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ashish Mhetre <amhetre@nvidia.com>, krzysztof.kozlowski@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        dmitry.osipenko@collabora.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH 1/2] memory: tegra: Add SID override programming for MC
 clients
Message-ID: <202311071607.IzbwSn2f-lkp@intel.com>
References: <20231107052824.29418-1-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107052824.29418-1-amhetre@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashish,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tegra/for-next]
[also build test WARNING on linus/master v6.6 next-20231107]
[cannot apply to tegra-drm/drm/tegra/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ashish-Mhetre/memory-tegra-Skip-SID-programming-if-SID-registers-aren-t-set/20231107-133149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
patch link:    https://lore.kernel.org/r/20231107052824.29418-1-amhetre%40nvidia.com
patch subject: [PATCH 1/2] memory: tegra: Add SID override programming for MC clients
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231107/202311071607.IzbwSn2f-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231107/202311071607.IzbwSn2f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311071607.IzbwSn2f-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/memory/tegra/tegra186.c: In function 'tegra186_mc_resume':
   drivers/memory/tegra/tegra186.c:78:17: error: implicit declaration of function 'tegra186_mc_client_sid_override' [-Werror=implicit-function-declaration]
      78 |                 tegra186_mc_client_sid_override(mc, client, client->sid);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/memory/tegra/tegra186.c: At top level:
>> drivers/memory/tegra/tegra186.c:85:13: warning: conflicting types for 'tegra186_mc_client_sid_override'; have 'void(struct tegra_mc *, const struct tegra_mc_client *, unsigned int)'
      85 | static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/memory/tegra/tegra186.c:85:13: error: static declaration of 'tegra186_mc_client_sid_override' follows non-static declaration
   drivers/memory/tegra/tegra186.c:78:17: note: previous implicit declaration of 'tegra186_mc_client_sid_override' with type 'void(struct tegra_mc *, const struct tegra_mc_client *, unsigned int)'
      78 |                 tegra186_mc_client_sid_override(mc, client, client->sid);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +85 drivers/memory/tegra/tegra186.c

7355c7b9ae0d45 Thierry Reding 2021-06-02   70  
142620fbbbbba0 Ashish Mhetre  2023-11-07   71  static int tegra186_mc_resume(struct tegra_mc *mc)
142620fbbbbba0 Ashish Mhetre  2023-11-07   72  {
142620fbbbbba0 Ashish Mhetre  2023-11-07   73  	unsigned int i;
142620fbbbbba0 Ashish Mhetre  2023-11-07   74  
142620fbbbbba0 Ashish Mhetre  2023-11-07   75  	for (i = 0; i < mc->soc->num_clients; i++) {
142620fbbbbba0 Ashish Mhetre  2023-11-07   76  		const struct tegra_mc_client *client = &mc->soc->clients[i];
142620fbbbbba0 Ashish Mhetre  2023-11-07   77  
142620fbbbbba0 Ashish Mhetre  2023-11-07  @78  		tegra186_mc_client_sid_override(mc, client, client->sid);
142620fbbbbba0 Ashish Mhetre  2023-11-07   79  	}
142620fbbbbba0 Ashish Mhetre  2023-11-07   80  
142620fbbbbba0 Ashish Mhetre  2023-11-07   81  	return 0;
142620fbbbbba0 Ashish Mhetre  2023-11-07   82  }
142620fbbbbba0 Ashish Mhetre  2023-11-07   83  
eaf89f1cd38cf7 Arnd Bergmann  2021-07-22   84  #if IS_ENABLED(CONFIG_IOMMU_API)
393d66fd2cacba Thierry Reding 2021-06-03  @85  static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
393d66fd2cacba Thierry Reding 2021-06-03   86  					    const struct tegra_mc_client *client,
393d66fd2cacba Thierry Reding 2021-06-03   87  					    unsigned int sid)
393d66fd2cacba Thierry Reding 2021-06-03   88  {
393d66fd2cacba Thierry Reding 2021-06-03   89  	u32 value, old;
393d66fd2cacba Thierry Reding 2021-06-03   90  
393d66fd2cacba Thierry Reding 2021-06-03   91  	value = readl(mc->regs + client->regs.sid.security);
393d66fd2cacba Thierry Reding 2021-06-03   92  	if ((value & MC_SID_STREAMID_SECURITY_OVERRIDE) == 0) {
393d66fd2cacba Thierry Reding 2021-06-03   93  		/*
393d66fd2cacba Thierry Reding 2021-06-03   94  		 * If the secure firmware has locked this down the override
393d66fd2cacba Thierry Reding 2021-06-03   95  		 * for this memory client, there's nothing we can do here.
393d66fd2cacba Thierry Reding 2021-06-03   96  		 */
393d66fd2cacba Thierry Reding 2021-06-03   97  		if (value & MC_SID_STREAMID_SECURITY_WRITE_ACCESS_DISABLED)
393d66fd2cacba Thierry Reding 2021-06-03   98  			return;
393d66fd2cacba Thierry Reding 2021-06-03   99  
393d66fd2cacba Thierry Reding 2021-06-03  100  		/*
393d66fd2cacba Thierry Reding 2021-06-03  101  		 * Otherwise, try to set the override itself. Typically the
393d66fd2cacba Thierry Reding 2021-06-03  102  		 * secure firmware will never have set this configuration.
393d66fd2cacba Thierry Reding 2021-06-03  103  		 * Instead, it will either have disabled write access to
393d66fd2cacba Thierry Reding 2021-06-03  104  		 * this field, or it will already have set an explicit
393d66fd2cacba Thierry Reding 2021-06-03  105  		 * override itself.
393d66fd2cacba Thierry Reding 2021-06-03  106  		 */
393d66fd2cacba Thierry Reding 2021-06-03  107  		WARN_ON((value & MC_SID_STREAMID_SECURITY_OVERRIDE) == 0);
393d66fd2cacba Thierry Reding 2021-06-03  108  
393d66fd2cacba Thierry Reding 2021-06-03  109  		value |= MC_SID_STREAMID_SECURITY_OVERRIDE;
393d66fd2cacba Thierry Reding 2021-06-03  110  		writel(value, mc->regs + client->regs.sid.security);
393d66fd2cacba Thierry Reding 2021-06-03  111  	}
393d66fd2cacba Thierry Reding 2021-06-03  112  
393d66fd2cacba Thierry Reding 2021-06-03  113  	value = readl(mc->regs + client->regs.sid.override);
393d66fd2cacba Thierry Reding 2021-06-03  114  	old = value & MC_SID_STREAMID_OVERRIDE_MASK;
393d66fd2cacba Thierry Reding 2021-06-03  115  
393d66fd2cacba Thierry Reding 2021-06-03  116  	if (old != sid) {
393d66fd2cacba Thierry Reding 2021-06-03  117  		dev_dbg(mc->dev, "overriding SID %x for %s with %x\n", old,
393d66fd2cacba Thierry Reding 2021-06-03  118  			client->name, sid);
393d66fd2cacba Thierry Reding 2021-06-03  119  		writel(sid, mc->regs + client->regs.sid.override);
393d66fd2cacba Thierry Reding 2021-06-03  120  	}
393d66fd2cacba Thierry Reding 2021-06-03  121  }
eaf89f1cd38cf7 Arnd Bergmann  2021-07-22  122  #endif
393d66fd2cacba Thierry Reding 2021-06-03  123  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
