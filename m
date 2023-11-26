Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ABB7F927F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 12:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjKZLbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 06:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZLbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 06:31:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0018FE;
        Sun, 26 Nov 2023 03:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700998306; x=1732534306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ROwRrhRWbLg8ydg2IqYW9JIlNogCdtYYyRIfLiHGP9I=;
  b=fQ5BOAT34bkEVMROU1KQFUcpkjLTorWm0kvyocBFM/oCIZ0BygfjsQa8
   HiDo1+A7hTMMdcBCTos3Qmw0ZEjfpfz3HdqQtNU4TheGBx6w+/3sVW91A
   A4rkw3M6Iy5QMC1XSVabpYfuVmwonPkEnx5Jmm3LFPoW2eDDrG1Dz1mRC
   gDHR/jb6GYIe3awOKzVESwUOmn6QmWAAJ8mMeTtCjHIDw2R03DRwi+7MF
   myMJy4A4usp6Xm+GyvpBx0Tabf3D+am2WhdvJpAabiBrdvKrWlzlJ/p6k
   d/TSZ7yIKco56xF8EQTbT5JzGaJ18ETvD292sEtOVka61AvworJF4Jit5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="389715625"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="389715625"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 03:31:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="1015283094"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="1015283094"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Nov 2023 03:31:42 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r7DMS-00053i-2K;
        Sun, 26 Nov 2023 11:31:40 +0000
Date:   Sun, 26 Nov 2023 19:31:34 +0800
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH v2 13/21] MIPS: traps: Give more explanations if ebase
 doesn't belong to KSEG0
Message-ID: <202311261838.wgZG2yvS-lkp@intel.com>
References: <20231123152639.561231-14-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123152639.561231-14-gregory.clement@bootlin.com>
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
[also build test WARNING on lee-mfd/for-mfd-next linus/master v6.7-rc2 next-20231124]
[cannot apply to lee-mfd/for-mfd-fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gregory-CLEMENT/MIPS-Export-higher-highest-relocation-functions-in-uasm/20231124-002644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231123152639.561231-14-gregory.clement%40bootlin.com
patch subject: [PATCH v2 13/21] MIPS: traps: Give more explanations if ebase doesn't belong to KSEG0
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20231126/202311261838.wgZG2yvS-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231126/202311261838.wgZG2yvS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311261838.wgZG2yvS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/mips/kernel/traps.c:371:6: warning: no previous prototype for 'show_registers' [-Wmissing-prototypes]
     371 | void show_registers(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~
   arch/mips/kernel/traps.c:448:17: warning: no previous prototype for 'do_be' [-Wmissing-prototypes]
     448 | asmlinkage void do_be(struct pt_regs *regs)
         |                 ^~~~~
   arch/mips/kernel/traps.c:753:17: warning: no previous prototype for 'do_ov' [-Wmissing-prototypes]
     753 | asmlinkage void do_ov(struct pt_regs *regs)
         |                 ^~~~~
   arch/mips/kernel/traps.c:875:17: warning: no previous prototype for 'do_fpe' [-Wmissing-prototypes]
     875 | asmlinkage void do_fpe(struct pt_regs *regs, unsigned long fcr31)
         |                 ^~~~~~
   arch/mips/kernel/traps.c:1028:17: warning: no previous prototype for 'do_bp' [-Wmissing-prototypes]
    1028 | asmlinkage void do_bp(struct pt_regs *regs)
         |                 ^~~~~
   arch/mips/kernel/traps.c:1115:17: warning: no previous prototype for 'do_tr' [-Wmissing-prototypes]
    1115 | asmlinkage void do_tr(struct pt_regs *regs)
         |                 ^~~~~
   arch/mips/kernel/traps.c:1152:17: warning: no previous prototype for 'do_ri' [-Wmissing-prototypes]
    1152 | asmlinkage void do_ri(struct pt_regs *regs)
         |                 ^~~~~
   arch/mips/kernel/traps.c:1403:17: warning: no previous prototype for 'do_cpu' [-Wmissing-prototypes]
    1403 | asmlinkage void do_cpu(struct pt_regs *regs)
         |                 ^~~~~~
   arch/mips/kernel/traps.c:1508:17: warning: no previous prototype for 'do_msa_fpe' [-Wmissing-prototypes]
    1508 | asmlinkage void do_msa_fpe(struct pt_regs *regs, unsigned int msacsr)
         |                 ^~~~~~~~~~
   arch/mips/kernel/traps.c:1528:17: warning: no previous prototype for 'do_msa' [-Wmissing-prototypes]
    1528 | asmlinkage void do_msa(struct pt_regs *regs)
         |                 ^~~~~~
   arch/mips/kernel/traps.c:1549:17: warning: no previous prototype for 'do_mdmx' [-Wmissing-prototypes]
    1549 | asmlinkage void do_mdmx(struct pt_regs *regs)
         |                 ^~~~~~~
   arch/mips/kernel/traps.c:1561:17: warning: no previous prototype for 'do_watch' [-Wmissing-prototypes]
    1561 | asmlinkage void do_watch(struct pt_regs *regs)
         |                 ^~~~~~~~
   arch/mips/kernel/traps.c:1588:17: warning: no previous prototype for 'do_mcheck' [-Wmissing-prototypes]
    1588 | asmlinkage void do_mcheck(struct pt_regs *regs)
         |                 ^~~~~~~~~
   arch/mips/kernel/traps.c: In function 'do_mcheck':
   arch/mips/kernel/traps.c:1591:24: warning: variable 'prev_state' set but not used [-Wunused-but-set-variable]
    1591 |         enum ctx_state prev_state;
         |                        ^~~~~~~~~~
   arch/mips/kernel/traps.c: At top level:
   arch/mips/kernel/traps.c:1613:17: warning: no previous prototype for 'do_mt' [-Wmissing-prototypes]
    1613 | asmlinkage void do_mt(struct pt_regs *regs)
         |                 ^~~~~
   arch/mips/kernel/traps.c:1649:17: warning: no previous prototype for 'do_dsp' [-Wmissing-prototypes]
    1649 | asmlinkage void do_dsp(struct pt_regs *regs)
         |                 ^~~~~~
   arch/mips/kernel/traps.c:1657:17: warning: no previous prototype for 'do_reserved' [-Wmissing-prototypes]
    1657 | asmlinkage void do_reserved(struct pt_regs *regs)
         |                 ^~~~~~~~~~~
   arch/mips/kernel/traps.c:1833:17: warning: no previous prototype for 'cache_parity_error' [-Wmissing-prototypes]
    1833 | asmlinkage void cache_parity_error(void)
         |                 ^~~~~~~~~~~~~~~~~~
   arch/mips/kernel/traps.c:1881:17: warning: no previous prototype for 'do_ftlb' [-Wmissing-prototypes]
    1881 | asmlinkage void do_ftlb(void)
         |                 ^~~~~~~
   arch/mips/kernel/traps.c:1910:17: warning: no previous prototype for 'do_gsexc' [-Wmissing-prototypes]
    1910 | asmlinkage void do_gsexc(struct pt_regs *regs, u32 diag1)
         |                 ^~~~~~~~
   arch/mips/kernel/traps.c:1945:6: warning: no previous prototype for 'ejtag_exception_handler' [-Wmissing-prototypes]
    1945 | void ejtag_exception_handler(struct pt_regs *regs)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   arch/mips/kernel/traps.c:1990:17: warning: no previous prototype for 'nmi_exception_handler' [-Wmissing-prototypes]
    1990 | void __noreturn nmi_exception_handler(struct pt_regs *regs)
         |                 ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/mips/include/asm/bug.h:42,
                    from include/linux/bug.h:5,
                    from arch/mips/kernel/traps.c:16:
   arch/mips/kernel/traps.c: In function 'trap_init':
>> include/linux/kern_levels.h:5:25: warning: format '%llX' expects argument of type 'long long unsigned int', but argument 2 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:427:25: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:508:9: note: in expansion of macro 'printk'
     508 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:508:16: note: in expansion of macro 'KERN_WARNING'
     508 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~~~~
   arch/mips/kernel/traps.c:2428:25: note: in expansion of macro 'pr_warn'
    2428 |                         pr_warn("ebase(0x%llX) should better be in KSeg0",
         |                         ^~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
