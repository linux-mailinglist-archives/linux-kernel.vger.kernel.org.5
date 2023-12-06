Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED918073DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379294AbjLFPmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379209AbjLFPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:42:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BD9E9;
        Wed,  6 Dec 2023 07:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701877328; x=1733413328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cO0A3WdbHX7R83cIqfmPmfW4uzDk1PAzvzBbmxZCtlE=;
  b=WkE1R4hdJiE5S9aijjeebUWNKa+Zq7qRHCDBH6tRAI6CsYk7K6iZaIIV
   EH7x6zOw5OlvVgoJ9Aa6JeJPqOUXhpkksAHCWB2S4ro8wk2diffqWe6Qg
   FZ8Cy4CBBetl16X+xS8XhxweeT9YcYF2xMoPBxZwPg6wXcCKjs9j0kwyR
   0d2/mhm9VaAjyYHCWwbKSPaQgdDO9yL7PUrp276te4CXZ5ceJUPFEttJg
   7aLaRMagklsa13gZKAHQuE+CeogsaGIT+638AgtKmGsIPzEfRGkU1am60
   9Z64/lesBxVRN1G5b6cLVtk61yLYbh38Stuyd+SUAPhR2SlK/BXcWvR9O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="458401215"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="458401215"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 07:42:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="894770140"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="894770140"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 06 Dec 2023 07:42:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAu2C-000B1L-0T;
        Wed, 06 Dec 2023 15:42:00 +0000
Date:   Wed, 6 Dec 2023 23:39:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Inochi Amaoto <inochiama@outlook.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Jisheng Zhang <jszhang@kernel.org>, qiujingbao.dlmu@gmail.com,
        dlan@gentoo.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/4] clk: sophgo: Add CV1800 series clock controller
 driver
Message-ID: <202312062352.3dWKz9Hm-lkp@intel.com>
References: <IA1PR20MB4953946E2F8D8795DC261DBFBB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953946E2F8D8795DC261DBFBB85A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Inochi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20231205]
[also build test WARNING on linus/master v6.7-rc4]
[cannot apply to clk/clk-next robh/for-next v6.7-rc4 v6.7-rc3 v6.7-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Inochi-Amaoto/dt-bindings-clock-sophgo-Add-CV1800-bindings/20231205-174631
base:   next-20231205
patch link:    https://lore.kernel.org/r/IA1PR20MB4953946E2F8D8795DC261DBFBB85A%40IA1PR20MB4953.namprd20.prod.outlook.com
patch subject: [PATCH 2/4] clk: sophgo: Add CV1800 series clock controller driver
config: i386-buildonly-randconfig-003-20231206 (https://download.01.org/0day-ci/archive/20231206/202312062352.3dWKz9Hm-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312062352.3dWKz9Hm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312062352.3dWKz9Hm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/sophgo/clk-cv18xx-ip.c:347: warning: Function parameter or member 'hw' not described in 'bypass_div_get_parent'
>> drivers/clk/sophgo/clk-cv18xx-ip.c:347: warning: expecting prototype for clokc parent list(). Prototype was for bypass_div_get_parent() instead


vim +347 drivers/clk/sophgo/clk-cv18xx-ip.c

   341	
   342	/**
   343	 * clokc parent list:
   344	 * | osc | div0 | div1 | div2 | div3 |
   345	 */
   346	static u8 bypass_div_get_parent(struct clk_hw *hw)
 > 347	{
   348		struct cv1800_clk_bypass_div *div = hw_to_cv1800_clk_bypass_div(hw);
   349	
   350		if (cv1800_clk_checkbit(&div->div.common, &div->bypass))
   351			return 0;
   352	
   353		return 1;
   354	}
   355	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
