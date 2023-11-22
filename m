Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D987F3CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 05:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjKVEpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 23:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVEpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 23:45:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D29F4;
        Tue, 21 Nov 2023 20:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700628347; x=1732164347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HLMmaO5eRFcQjJshfZEl2KySYxKXTveeGm/s8aORDZk=;
  b=X/24BhVmgeaz8t/OJ8vIL0sxWN19uBPipWRlNsgGOVLwXMJhYESqUB/Y
   hXcabcDqUQB67a0yySP5SVAakX6Ij1mpDuHwi4eVsnoLf40SXp/oDqDqe
   0QZJfxet7bJop3sTlDDlfpjgDDdoflZjEYdYOOFiU4h/P2FZm7RO8erKl
   yP5BXzaUrOlI+1KlxTitGONDu/+3AexLk0j3yknSsLIeT7fPty820hYks
   TrQ8oCpwCDv/Ss8QDMNgT3NiCE5UVo7wdv92mZOe7uI46W7vDYWKca34f
   kxN6hiQ/ElNgVVjGAy1bc9BIvC/FrKtd7KGAbC+Hx16U0t/ZHQGaFmdD8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5116611"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="5116611"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 20:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="801780556"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="801780556"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Nov 2023 20:45:40 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5f7K-0008f4-1R;
        Wed, 22 Nov 2023 04:45:38 +0000
Date:   Wed, 22 Nov 2023 12:45:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomer Maimon <tmaimon77@gmail.com>, davem@davemloft.net,
        edumazet@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alexandre.torgue@foss.st.com,
        peppe.cavallaro@st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, andrew@codeconstruct.com.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        j.neuschaefer@gmx.net
Cc:     oe-kbuild-all@lists.linux.dev, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH v1 2/2] net: stmmac: Add NPCM support
Message-ID: <202311221228.eaAlsztJ-lkp@intel.com>
References: <20231121151733.2015384-3-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121151733.2015384-3-tmaimon77@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomer,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on net-next/main net/main linus/master v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tomer-Maimon/dt-bindings-net-Add-support-NPCM-dwmac/20231121-231908
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231121151733.2015384-3-tmaimon77%40gmail.com
patch subject: [PATCH v1 2/2] net: stmmac: Add NPCM support
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20231122/202311221228.eaAlsztJ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311221228.eaAlsztJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311221228.eaAlsztJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/stmicro/stmmac/dwmac-npcm.c:53:6: warning: no previous prototype for 'npcm_dwmac_pcs_init' [-Wmissing-prototypes]
      53 | void npcm_dwmac_pcs_init(struct npcm_dwmac *dwmac, struct device *dev,
         |      ^~~~~~~~~~~~~~~~~~~


vim +/npcm_dwmac_pcs_init +53 drivers/net/ethernet/stmicro/stmmac/dwmac-npcm.c

    52	
  > 53	void npcm_dwmac_pcs_init(struct npcm_dwmac *dwmac, struct device *dev,
    54				 struct plat_stmmacenet_data *plat_dat)
    55	{
    56		u16 val;
    57	
    58		iowrite16((u16)(SR_MII_CTRL >> 9), dwmac->reg + IND_AC_BA_REG);
    59		val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
    60		val |= PCS_RST;
    61		iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
    62	
    63		while (val & PCS_RST)
    64			val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
    65	
    66		val &= ~(PCS_AN_ENABLE);
    67		iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
    68	}
    69	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
