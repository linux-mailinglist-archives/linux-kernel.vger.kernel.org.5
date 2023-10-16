Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBAD7CA6A5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjJPLWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjJPLWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:22:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D14183
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 04:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697455349; x=1728991349;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XVwDVVamUkQm84CTuQLBcLZrHTPopWJ8OShruV6rM8U=;
  b=Fd7xWD9zvb4livlrDPZsHhkw7EmK5ucUo8LsjuBB5XMoOH8lCSvEejVS
   VNbw3Ri9lnnW4lFHnq4bM9hPYjW69A+Ms1qFEGTu89v9TZBYP1JDbDuj+
   NurAXUYIUGuS31MURZXoLXP8ytoMLRWsthF70njFLrz2YdZI89PEbAeTO
   2xSXLP25iged0y4R8wqhdctodgnxoInthJmQkbwdQMxZb8sKzpJjgQxNG
   F7CK+Wbsc50hKdFwilOcPm8fREafy1kDiGMGYpQ9A3TwjYV/PkA82vTCg
   mjaEK1nsFOruox0yX74WsUfung4ffe9VuErL83psv9WES6Ak+HLRVf7mW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="4113747"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="4113747"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 04:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749260204"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="749260204"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Oct 2023 04:22:27 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsLg1-0008Kx-0f;
        Mon, 16 Oct 2023 11:22:25 +0000
Date:   Mon, 16 Oct 2023 19:22:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/mm/proc-v7.S:545: Error: invalid constant
 (fffffffffffffbe8) after fixup
Message-ID: <202310161958.Zb8qeCvr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58720809f52779dc0f08e53e54b014209d13eebb
commit: 84fc863606239d8b434e59e6bbbe805f457e5767 ARM: make ARCH_MULTIPLATFORM user-visible
date:   1 year, 2 months ago
config: arm-randconfig-r025-20230624 (https://download.01.org/0day-ci/archive/20231016/202310161958.Zb8qeCvr-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231016/202310161958.Zb8qeCvr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310161958.Zb8qeCvr-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arm/mm/proc-v7.S: Assembler messages:
>> arch/arm/mm/proc-v7.S:545: Error: invalid constant (fffffffffffffbe8) after fixup


vim +545 arch/arm/mm/proc-v7.S

de4901933f6dfc Gregory CLEMENT 2012-10-03  483  
14eff1812679c7 Daniel Walker   2010-09-17  484  __v7_setup:
95731b8ee63ec9 Ard Biesheuvel  2021-02-11  485  	do_invalidate_l1
1946d6ef9d7bd4 Russell King    2009-06-01  486  
bac51ad9d14f6b Russell King    2015-07-09  487  __v7_setup_cont:
c76f238e261b8d Russell King    2015-04-04  488  	and	r0, r9, #0xff000000		@ ARM?
c76f238e261b8d Russell King    2015-04-04  489  	teq	r0, #0x41000000
17e7bf86690eaa Russell King    2015-04-04  490  	bne	__errata_finish
4419496884ed16 Russell King    2015-04-04  491  	and	r3, r9, #0x00f00000		@ variant
4419496884ed16 Russell King    2015-04-04  492  	and	r6, r9, #0x0000000f		@ revision
b2c3e38a54714e Russell King    2015-04-04  493  	orr	r6, r6, r3, lsr #20-4		@ combine variant and revision
4419496884ed16 Russell King    2015-04-04  494  	ubfx	r0, r9, #4, #12			@ primary part number
1946d6ef9d7bd4 Russell King    2009-06-01  495  
6491848d1ab246 Will Deacon     2010-09-14  496  	/* Cortex-A8 Errata */
6491848d1ab246 Will Deacon     2010-09-14  497  	ldr	r10, =0x00000c08		@ Cortex-A8 primary part number
6491848d1ab246 Will Deacon     2010-09-14  498  	teq	r0, r10
17e7bf86690eaa Russell King    2015-04-04  499  	beq	__ca8_errata
9f05027c7cb3cf Will Deacon     2010-09-14  500  
9f05027c7cb3cf Will Deacon     2010-09-14  501  	/* Cortex-A9 Errata */
17e7bf86690eaa Russell King    2015-04-04  502  	ldr	r10, =0x00000c09		@ Cortex-A9 primary part number
9f05027c7cb3cf Will Deacon     2010-09-14  503  	teq	r0, r10
17e7bf86690eaa Russell King    2015-04-04  504  	beq	__ca9_errata
1946d6ef9d7bd4 Russell King    2009-06-01  505  
62c0f4a53447bc Doug Anderson   2016-04-07  506  	/* Cortex-A12 Errata */
62c0f4a53447bc Doug Anderson   2016-04-07  507  	ldr	r10, =0x00000c0d		@ Cortex-A12 primary part number
62c0f4a53447bc Doug Anderson   2016-04-07  508  	teq	r0, r10
62c0f4a53447bc Doug Anderson   2016-04-07  509  	beq	__ca12_errata
62c0f4a53447bc Doug Anderson   2016-04-07  510  
62c0f4a53447bc Doug Anderson   2016-04-07  511  	/* Cortex-A17 Errata */
62c0f4a53447bc Doug Anderson   2016-04-07  512  	ldr	r10, =0x00000c0e		@ Cortex-A17 primary part number
62c0f4a53447bc Doug Anderson   2016-04-07  513  	teq	r0, r10
62c0f4a53447bc Doug Anderson   2016-04-07  514  	beq	__ca17_errata
62c0f4a53447bc Doug Anderson   2016-04-07  515  
84b6504f560157 Will Deacon     2013-08-20  516  	/* Cortex-A15 Errata */
17e7bf86690eaa Russell King    2015-04-04  517  	ldr	r10, =0x00000c0f		@ Cortex-A15 primary part number
84b6504f560157 Will Deacon     2013-08-20  518  	teq	r0, r10
17e7bf86690eaa Russell King    2015-04-04  519  	beq	__ca15_errata
84b6504f560157 Will Deacon     2013-08-20  520  
17e7bf86690eaa Russell King    2015-04-04  521  __errata_finish:
17e7bf86690eaa Russell King    2015-04-04  522  	mov	r10, #0
bbe888864ec324 Catalin Marinas 2007-05-08  523  	mcr	p15, 0, r10, c7, c5, 0		@ I+BTB cache invalidate
2eb8c82bc492d5 Catalin Marinas 2007-07-20  524  #ifdef CONFIG_MMU
bbe888864ec324 Catalin Marinas 2007-05-08  525  	mcr	p15, 0, r10, c8, c7, 0		@ invalidate I + D TLBs
b2c3e38a54714e Russell King    2015-04-04  526  	v7_ttb_setup r10, r4, r5, r8, r3	@ TTBCR, TTBRx setup
b2c3e38a54714e Russell King    2015-04-04  527  	ldr	r3, =PRRR			@ PRRR
f6b0fa02e8b070 Russell King    2011-02-06  528  	ldr	r6, =NMRR			@ NMRR
b2c3e38a54714e Russell King    2015-04-04  529  	mcr	p15, 0, r3, c10, c2, 0		@ write PRRR
3f69c0c1af288d Russell King    2008-09-15  530  	mcr	p15, 0, r6, c10, c2, 1		@ write NMRR
078c04545ba56d Jonathan Austin 2012-04-12  531  #endif
bae0ca2bc550d1 Will Deacon     2014-02-07  532  	dsb					@ Complete invalidations
078c04545ba56d Jonathan Austin 2012-04-12  533  #ifndef CONFIG_ARM_THUMBEE
078c04545ba56d Jonathan Austin 2012-04-12  534  	mrc	p15, 0, r0, c0, c1, 0		@ read ID_PFR0 for ThumbEE
078c04545ba56d Jonathan Austin 2012-04-12  535  	and	r0, r0, #(0xf << 12)		@ ThumbEE enabled field
078c04545ba56d Jonathan Austin 2012-04-12  536  	teq	r0, #(1 << 12)			@ check if ThumbEE is present
078c04545ba56d Jonathan Austin 2012-04-12  537  	bne	1f
b2c3e38a54714e Russell King    2015-04-04  538  	mov	r3, #0
b2c3e38a54714e Russell King    2015-04-04  539  	mcr	p14, 6, r3, c1, c0, 0		@ Initialize TEEHBR to 0
078c04545ba56d Jonathan Austin 2012-04-12  540  	mrc	p14, 6, r0, c0, c0, 0		@ load TEECR
078c04545ba56d Jonathan Austin 2012-04-12  541  	orr	r0, r0, #1			@ set the 1st bit in order to
078c04545ba56d Jonathan Austin 2012-04-12  542  	mcr	p14, 6, r0, c0, c0, 0		@ stop userspace TEEHBR access
078c04545ba56d Jonathan Austin 2012-04-12  543  1:
bdaaaec39792ee Catalin Marinas 2009-07-24  544  #endif
b2c3e38a54714e Russell King    2015-04-04 @545  	adr	r3, v7_crval
b2c3e38a54714e Russell King    2015-04-04  546  	ldmia	r3, {r3, r6}
457c2403c513c7 Ben Dooks       2013-02-12  547   ARM_BE8(orr	r6, r6, #1 << 25)		@ big-endian page tables
64d2dc384e41e2 Leif Lindholm   2010-09-16  548  #ifdef CONFIG_SWP_EMULATE
b2c3e38a54714e Russell King    2015-04-04  549  	orr     r3, r3, #(1 << 10)              @ set SW bit in "clear"
64d2dc384e41e2 Leif Lindholm   2010-09-16  550  	bic     r6, r6, #(1 << 10)              @ clear it in "mmuset"
26584853a44c58 Catalin Marinas 2009-05-30  551  #endif
bbe888864ec324 Catalin Marinas 2007-05-08  552     	mrc	p15, 0, r0, c1, c0, 0		@ read control register
b2c3e38a54714e Russell King    2015-04-04  553  	bic	r0, r0, r3			@ clear bits them
2eb8c82bc492d5 Catalin Marinas 2007-07-20  554  	orr	r0, r0, r6			@ set them
347c8b70b1d525 Catalin Marinas 2009-07-24  555   THUMB(	orr	r0, r0, #1 << 30	)	@ Thumb exceptions
6ebbf2ce437b33 Russell King    2014-06-30  556  	ret	lr				@ return to head.S:__ret
93ed3970114983 Catalin Marinas 2008-08-28  557  ENDPROC(__v7_setup)
bbe888864ec324 Catalin Marinas 2007-05-08  558  
5085f3ff458521 Russell King    2010-10-01  559  	__INITDATA
5085f3ff458521 Russell King    2010-10-01  560  
f5fe12b1eaee22 Russell King    2018-05-14  561  	.weak cpu_v7_bugs_init
f5fe12b1eaee22 Russell King    2018-05-14  562  
78a8f3c365b885 Dave Martin     2011-06-23  563  	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
f5fe12b1eaee22 Russell King    2018-05-14  564  	define_processor_functions v7, dabort=v7_early_abort, pabort=v7_pabort, suspend=1, bugs=cpu_v7_bugs_init
06c23f5ffe7ad4 Russell King    2018-04-20  565  

:::::: The code at line 545 was first introduced by commit
:::::: b2c3e38a54714e917c9e8675ff5812dca1c0f39d ARM: redo TTBR setup code for LPAE

:::::: TO: Russell King <rmk+kernel@arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
