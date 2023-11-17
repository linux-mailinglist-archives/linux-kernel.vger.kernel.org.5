Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50EC7EF4DF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjKQPDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:03:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C8FD50
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700233424; x=1731769424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TEJAgOt2XWSBUz2XPQPntlNht60e24ViT0YPSawe9e0=;
  b=HZpPItomTV65q+RTPebNu4AWx30Mtw97k+MKaMTmlo+4at1w2pvcHfDu
   O7zQsUHC+wIX0frCVQoll22bDcqSU/6xYL3n/4nG0HIA4N6ILf64nZ2qZ
   h6YktW1vUX8pe8kOgu2LhK4MGAVwV/LMGfGrrhfXTVUE+vfLuUJAU9Vby
   Kf0L0OmeMpk6/WX+P8NeL6FNRUVRUno1Qh0fi9jNeJE4OK7kQBeH67rmj
   tcnQY6/e+GtJbQOM40cZ+uduIEVIIeGBrea/YrBiXiLDHRUnqHixsDfre
   kfZhylVYCq1ZEIDCc546MozE29yPPZtcbxBzxXftkNP1uSIHPscqAml+S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="12860973"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="12860973"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 07:03:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="889261608"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="889261608"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Nov 2023 07:03:41 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r40Ne-0002rj-3C;
        Fri, 17 Nov 2023 15:03:38 +0000
Date:   Fri, 17 Nov 2023 23:02:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Enlin Mu <enlin.mu@outlook.com>, catalin.marinas@arm.com,
        will@kernel.org, enlin.mu@unisoc.com, enlinmu@gmail.com,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: remove kaslr-seed node when it had used
Message-ID: <202311172203.QJYSLPKE-lkp@intel.com>
References: <TYSPR04MB7084AFDB414AA7AE49A02D608AB2A@TYSPR04MB7084.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYSPR04MB7084AFDB414AA7AE49A02D608AB2A@TYSPR04MB7084.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enlin,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Enlin-Mu/arm64-remove-kaslr-seed-node-when-it-had-used/20231114-220115
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/TYSPR04MB7084AFDB414AA7AE49A02D608AB2A%40TYSPR04MB7084.apcprd04.prod.outlook.com
patch subject: [PATCH] arm64: remove kaslr-seed node when it had used
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20231117/202311172203.QJYSLPKE-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231117/202311172203.QJYSLPKE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311172203.QJYSLPKE-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: arch/arm64/kernel/pi/kaslr_early.pi.o: in function `get_kaslr_seed':
>> arch/arm64/kernel/pi/kaslr_early.c:84:(.init.text+0x18c): undefined reference to `__pi_fdt_nop_property'
   arch/arm64/kernel/pi/kaslr_early.c:84:(.init.text+0x18c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `__pi_fdt_nop_property'
   aarch64-linux-ld: .tmp_vmlinux.kallsyms1: hidden symbol `__pi_fdt_nop_property' isn't defined
   aarch64-linux-ld: final link failed: bad value


vim +84 arch/arm64/kernel/pi/kaslr_early.c

    68	
    69	static u64 get_kaslr_seed(void *fdt)
    70	{
    71		int node, len;
    72		fdt64_t *prop;
    73		u64 ret;
    74	
    75		node = fdt_path_offset(fdt, "/chosen");
    76		if (node < 0)
    77			return 0;
    78	
    79		prop = fdt_getprop_w(fdt, node, "kaslr-seed", &len);
    80		if (!prop || len != sizeof(u64))
    81			return 0;
    82	
    83		ret = fdt64_to_cpu(*prop);
  > 84		fdt_nop_property(fdt, node, "kaslr-seed");
    85		return ret;
    86	}
    87	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
