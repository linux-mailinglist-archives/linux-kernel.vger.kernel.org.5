Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B421F805C42
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442442AbjLEPWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346150AbjLEPVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:21:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FE3D68;
        Tue,  5 Dec 2023 07:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701789700; x=1733325700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zZde1bRSdknyGLGHRWRhusZExHQToaE/lMC8COI/EwY=;
  b=gZdr2H7P25BDGoic+7S1EljOSoQqzmP10hsQgw7CqhYeVU+WmNjRVvnL
   hqYFafw45yeS0W8fWVaEnMs430pSlyzJiRJiYyuIGT2xPUQP3OyB1W5eY
   Mx1lFwq4u75Rj0mmdbPhNhbnStUuuLw+I4IimGlpGR3GXPkON1CVBUCKO
   ehkrwOJ26LXBIry6kL51O1hasEyOejrBktgxlHF44VBLj0++R24DtxZYR
   sqN/VCLNrRji+pr5zjXybtFq+JfLathuF9/cz8RoRUewIq7y93U9uClpH
   G8+1IuFt9EIC2SSaq9Pc+WsycW6Q9HEKSfhppAE2o2X2QPhu8SaybkTj/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="458227715"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="458227715"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:21:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="861775411"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="861775411"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Dec 2023 07:21:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAXEu-0009ES-1f;
        Tue, 05 Dec 2023 15:21:36 +0000
Date:   Tue, 5 Dec 2023 23:20:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] MIPS: Implement microMIPS MT ASE helpers
Message-ID: <202312052344.xESwjhJU-lkp@intel.com>
References: <20231201121101.90714-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201121101.90714-1-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxun,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc4 next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiaxun-Yang/MIPS-Implement-microMIPS-MT-ASE-helpers/20231201-201823
base:   linus/master
patch link:    https://lore.kernel.org/r/20231201121101.90714-1-jiaxun.yang%40flygoat.com
patch subject: [PATCH] MIPS: Implement microMIPS MT ASE helpers
config: mips-xway_defconfig (https://download.01.org/0day-ci/archive/20231205/202312052344.xESwjhJU-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312052344.xESwjhJU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312052344.xESwjhJU-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/mips/kernel/vpe-mt.c:177:7: warning: no previous prototype for 'vpe_alloc' [-Wmissing-prototypes]
     177 | void *vpe_alloc(void)
         |       ^~~~~~~~~
   arch/mips/kernel/vpe-mt.c:195:5: warning: no previous prototype for 'vpe_start' [-Wmissing-prototypes]
     195 | int vpe_start(void *vpe, unsigned long start)
         |     ^~~~~~~~~
   arch/mips/kernel/vpe-mt.c:205:5: warning: no previous prototype for 'vpe_stop' [-Wmissing-prototypes]
     205 | int vpe_stop(void *vpe)
         |     ^~~~~~~~
   arch/mips/kernel/vpe-mt.c:226:5: warning: no previous prototype for 'vpe_free' [-Wmissing-prototypes]
     226 | int vpe_free(void *vpe)
         |     ^~~~~~~~
   vpe-mt.c: Assembler messages:
>> vpe-mt.c:4963: Error: Unable to parse register name 7
   vpe-mt.c:4967:  Info: macro invoked from here
   {standard input}:4972:   Info: macro invoked from here
   vpe-mt.c:5083: Error: Unable to parse register name 6
   vpe-mt.c:5087:  Info: macro invoked from here
   {standard input}:5092:   Info: macro invoked from here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
