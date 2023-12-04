Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A9B80312F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbjLDLCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbjLDLCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:02:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19DAD8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701687764; x=1733223764;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GfTG6PhHyWq+c8W1anqoMuoZzq2FA8a6AZwZq6IUnQM=;
  b=mujY2WEWsk/gr/i1ZEQOJBV2WJlj4ay/bOnCnlA/9zYgzLIrPNO+6AWR
   Rtl4CF6MSz9iDEFchpjF4lP742+1xjNWE1POVf/Mjc4FfrpQKut3qPAC8
   M1o33cgec8+258NomxOXjoxxgUakeLDVQKKcLVg/g/6c/YxKzcjyEoiRD
   D6F9npRWk9X+PVATA1wmfIuefyLQxC2vLOAmjIjJ9bhvdbRh4XAuFJyeY
   seeJtqomuDw0RWcC3nfhw889t3cLQ2oiZWe2nUTDpvCbf7BfUZDSajZZj
   bCM9DHIyNEbU2YN23A1+rQ1JfqgZmvWdJ3IPNQsxPa+FhSpYEA2907KzH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="7041006"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="7041006"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 03:02:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="763911023"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="763911023"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2023 03:02:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rA6ij-0007gM-1a;
        Mon, 04 Dec 2023 11:02:37 +0000
Date:   Mon, 4 Dec 2023 19:02:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: arch/powerpc/platforms/powermac/nvram.c:304:24: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202312041835.DSQPXMaZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 0a2b782a00f33e7d06dc43d099fa071ae97bee77 fortify: Make pointer arguments const
date:   1 year, 10 months ago
config: powerpc64-randconfig-r122-20231117 (https://download.01.org/0day-ci/archive/20231204/202312041835.DSQPXMaZ-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231204/202312041835.DSQPXMaZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312041835.DSQPXMaZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/platforms/powermac/nvram.c:304:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got unsigned char [noderef] [usertype] __iomem *base @@
   arch/powerpc/platforms/powermac/nvram.c:304:24: sparse:     expected void const *const p
   arch/powerpc/platforms/powermac/nvram.c:304:24: sparse:     got unsigned char [noderef] [usertype] __iomem *base
   arch/powerpc/platforms/powermac/nvram.c:338:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got unsigned char [noderef] [usertype] __iomem *base @@
   arch/powerpc/platforms/powermac/nvram.c:338:20: sparse:     expected void const *const p
   arch/powerpc/platforms/powermac/nvram.c:338:20: sparse:     got unsigned char [noderef] [usertype] __iomem *base
   arch/powerpc/platforms/powermac/nvram.c:384:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got unsigned char [noderef] [usertype] __iomem *base @@
   arch/powerpc/platforms/powermac/nvram.c:384:24: sparse:     expected void const *const p
   arch/powerpc/platforms/powermac/nvram.c:384:24: sparse:     got unsigned char [noderef] [usertype] __iomem *base
   arch/powerpc/platforms/powermac/nvram.c:429:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *const p @@     got unsigned char [noderef] [usertype] __iomem *base @@
   arch/powerpc/platforms/powermac/nvram.c:429:20: sparse:     expected void const *const p
   arch/powerpc/platforms/powermac/nvram.c:429:20: sparse:     got unsigned char [noderef] [usertype] __iomem *base
   arch/powerpc/platforms/powermac/nvram.c:480:35: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/powermac/nvram.c:526:35: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/powermac/nvram.c:527:35: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/powermac/nvram.c:534:44: sparse: sparse: dereference of noderef expression

vim +304 arch/powerpc/platforms/powermac/nvram.c

14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  279  
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  280  static int sm_erase_bank(int bank)
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  281  {
2d4b971287cbce arch/powerpc/platforms/powermac/nvram.c      Akinobu Mita     2012-01-27  282  	int stat;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  283  	unsigned long timeout;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  284  
af308377e204e2 arch/powerpc/platforms/powermac/nvram.c      Stephen Rothwell 2006-03-23  285  	u8 __iomem *base = (u8 __iomem *)nvram_data + core99_bank*NVRAM_SIZE;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  286  
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  287         	DBG("nvram: Sharp/Micron Erasing bank %d...\n", bank);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  288  
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  289  	out_8(base, SM_FLASH_CMD_ERASE_SETUP);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  290  	out_8(base, SM_FLASH_CMD_ERASE_CONFIRM);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  291  	timeout = 0;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  292  	do {
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  293  		if (++timeout > 1000000) {
35499c0195e46f arch/powerpc/platforms/powermac/nvram.c      Paul Mackerras   2005-10-22  294  			printk(KERN_ERR "nvram: Sharp/Micron flash erase timeout !\n");
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  295  			break;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  296  		}
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  297  		out_8(base, SM_FLASH_CMD_READ_STATUS);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  298  		stat = in_8(base);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  299  	} while (!(stat & SM_FLASH_STATUS_DONE));
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  300  
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  301  	out_8(base, SM_FLASH_CMD_CLEAR_STATUS);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  302  	out_8(base, SM_FLASH_CMD_RESET);
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  303  
2d4b971287cbce arch/powerpc/platforms/powermac/nvram.c      Akinobu Mita     2012-01-27 @304  	if (memchr_inv(base, 0xff, NVRAM_SIZE)) {
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  305  		printk(KERN_ERR "nvram: Sharp/Micron flash erase failed !\n");
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  306  		return -ENXIO;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  307  	}
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  308  	return 0;
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  309  }
14cf11af6cf608 arch/powerpc/platforms/powermac/pmac_nvram.c Paul Mackerras   2005-09-26  310  

:::::: The code at line 304 was first introduced by commit
:::::: 2d4b971287cbce16585acda4b76308faa8da0950 powerpc/pmac: Use string library in nvram code

:::::: TO: Akinobu Mita <akinobu.mita@gmail.com>
:::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
