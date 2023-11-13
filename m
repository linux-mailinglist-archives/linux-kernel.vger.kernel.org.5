Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646867E9665
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 05:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjKME6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 23:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKME6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 23:58:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFA0107;
        Sun, 12 Nov 2023 20:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699851485; x=1731387485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3rr1CcVA1QVG5RdS7YA8zExN022F8nkhxbs95twph2A=;
  b=dWE7Wk7713GSNdaPB65MHFdOqILpHqeOyiXY0DQmMylDHafMvkS6Olmy
   epPnq/k5WIpmWgC0iG1FZr/gOicf17lW5hXrPbjtR0hAtMuEMRO4MaFwM
   vzfOcBagkyrYxV9klu1j1amcmlnlEwaoZkPl+VYNLYsk6a25X3k/xfHi2
   W47/UUeHWoY8xxfEd/VZhwfEzugSxVdR0iZAklpBo7T8ekp0lfn9Hf0qz
   +cUFERDkRols7GTIESmqLM842MLGhdrtjqmZhIyJXQo+D/ykbiXHNqu0S
   25OcklSOC2VB+N78+TLxs1Zdrl7ZqHRJlzAIme+noc7fAjgwBPgoUT2gH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="3417180"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="3417180"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 20:58:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="764237374"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="764237374"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Nov 2023 20:58:00 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r2P1J-000BpA-1D;
        Mon, 13 Nov 2023 04:57:57 +0000
Date:   Mon, 13 Nov 2023 12:57:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>
Cc:     oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/4] riscv: dts: sophgo: add reset phandle to all uart
 nodes
Message-ID: <202311131220.lnq9Gdut-lkp@intel.com>
References: <20231113005503.2423-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113005503.2423-5-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20231110]
[also build test ERROR on linus/master v6.7-rc1]
[cannot apply to robh/for-next krzk/for-next krzk-dt/for-next pza/reset/next pza/imx-drm/next v6.6 v6.6-rc7 v6.6-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jisheng-Zhang/dt-bindings-reset-Add-binding-for-Sophgo-CV1800B-reset-controller/20231113-091129
base:   next-20231110
patch link:    https://lore.kernel.org/r/20231113005503.2423-5-jszhang%40kernel.org
patch subject: [PATCH 4/4] riscv: dts: sophgo: add reset phandle to all uart nodes
config: riscv-randconfig-001-20231113 (https://download.01.org/0day-ci/archive/20231113/202311131220.lnq9Gdut-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231113/202311131220.lnq9Gdut-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311131220.lnq9Gdut-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/boot/dts/sophgo/cv1800b.dtsi:7,
                    from arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts:8:
>> scripts/dtc/include-prefixes/dt-bindings/reset/sophgo,cv1800b-reset.h:7: error: unterminated #ifndef
       7 | #ifndef _DT_BINDINGS_CV1800B_RESET_H
         | 


vim +7 scripts/dtc/include-prefixes/dt-bindings/reset/sophgo,cv1800b-reset.h

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
