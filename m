Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79E6806394
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376334AbjLFAlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376330AbjLFAlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:41:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2217135;
        Tue,  5 Dec 2023 16:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701823273; x=1733359273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1P5IlBr3TTaPR/mI0jj+Cnk7VmQ+gGQJC+aHPUL7cho=;
  b=bnju4Oc44GTV+cnBcYp3bkGV6HZgpIczIb88WL+ea1XeCZAF/wod4+rx
   sEF//RdZaaoIISwgxLfi4/CviazUiYm99h2IFy8CAVvvysuja4iqNbV71
   CUyEnI9A/Y7DYTD3BA7e4YS6gRxM3z4okdfOfiuVfZdfQjiXIQbMJ2v3L
   fu/JxwNf40w3NySWttAD6KVCsToz+p9Fnbw4WE8KgPs0tWkkar+tOT/aH
   a0+A/XrnCs0psSA5wnl1p5xDlHpwClbh9ZWHDFT6cGZ4m2Smy6PxKELfG
   MNEM9vYJ/nEWZ530pTjii6Ltzw8+1t273lG3BCvF+QQWz38OlXhCz5rbt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="391150143"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="391150143"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 16:41:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="861935334"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="861935334"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Dec 2023 16:41:09 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAfyI-0009xu-12;
        Wed, 06 Dec 2023 00:41:02 +0000
Date:   Wed, 6 Dec 2023 08:40:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 12/22] MIPS: Get rid of CONFIG_NO_EXCEPT_FILL
Message-ID: <202312060831.fGiw8m5S-lkp@intel.com>
References: <20231201111512.803120-13-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201111512.803120-13-gregory.clement@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on lee-mfd/for-mfd-next linus/master v6.7-rc4]
[cannot apply to lee-mfd/for-mfd-fixes next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-CLEMENT/MIPS-Export-higher-highest-relocation-functions-in-uasm/20231201-201547
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231201111512.803120-13-gregory.clement%40bootlin.com
patch subject: [PATCH v3 12/22] MIPS: Get rid of CONFIG_NO_EXCEPT_FILL
config: mips-fuloong2e_defconfig (https://download.01.org/0day-ci/archive/20231206/202312060831.fGiw8m5S-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312060831.fGiw8m5S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060831.fGiw8m5S-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/mips/kernel/head.S:63:35: warning: "KSEG0" is not defined, evaluates to 0 [-Wundef]
      63 |         ((VMLINUX_LOAD_ADDRESS == KSEG0) ||     \
         |                                   ^~~~~


vim +/KSEG0 +63 arch/mips/kernel/head.S

    28	
    29		/*
    30		 * For the moment disable interrupts, mark the kernel mode and
    31		 * set ST0_KX so that the CPU does not spit fire when using
    32		 * 64-bit addresses.  A full initialization of the CPU's status
    33		 * register is done later in per_cpu_trap_init().
    34		 */
    35		.macro	setup_c0_status set clr
    36		.set	push
    37		mfc0	t0, CP0_STATUS
    38		or	t0, ST0_KERNEL_CUMASK|\set|0x1f|\clr
    39		xor	t0, 0x1f|\clr
    40		mtc0	t0, CP0_STATUS
    41		.set	noreorder
    42		sll	zero,3				# ehb
    43		.set	pop
    44		.endm
    45	
    46		.macro	setup_c0_status_pri
    47	#ifdef CONFIG_64BIT
    48		setup_c0_status ST0_KX 0
    49	#else
    50		setup_c0_status 0 0
    51	#endif
    52		.endm
    53	
    54		.macro	setup_c0_status_sec
    55	#ifdef CONFIG_64BIT
    56		setup_c0_status ST0_KX ST0_BEV
    57	#else
    58		setup_c0_status 0 ST0_BEV
    59	#endif
    60		.endm
    61	
    62	#if (MIPS_ISA_REV < 2) &&			\
  > 63		((VMLINUX_LOAD_ADDRESS == KSEG0) ||	\
    64		(VMLINUX_LOAD_ADDRESS == CKSEG0))
    65		/*
    66		 * Reserved space for exception handlers.
    67		 * Necessary for machines which link their kernels at KSEG0
    68		 * and incapable of moving ebase.
    69		 */
    70		.fill	0x400
    71	#endif
    72	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
