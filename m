Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C627B7FF8DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346664AbjK3RyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjK3RyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:54:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8071CD40
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701366868; x=1732902868;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FtVzoq4uYrvOdw5xzVOph1HqgMO+PQ7GXkGBVMzIM4M=;
  b=bDKewhnQAAXq0o1DtBooGPqITKtRmwo2di+5/dwiV+pxGHIuAcLhDBXN
   xYRQZtIIL9TsNxToCRjQXdoNvjXLmhuuw25rKDnBMkO4tI2nrRxQB3glZ
   IAB3/HYIy99ZzPbgzXNqxkau/5Ye+fYQxyMz5C7TmUUTXvtb2uZduXFPb
   y7Uhr4aaN8+bg3fXLIFebbcvPiRDO1DEQbkWLcjA3w1X8Uj+6GskJDjqY
   jR6iytgwW8rGcsbgf0w40TXDwj+MBBTyTr2rWYE5oxPXImDfVknQE+1uQ
   dUcCOZ3qQXNeA5how/lSW+9e33LHP3m6XPBMfnuMoQSwrh8UqS2NmnSG8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="392231085"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="392231085"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 09:54:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="942789271"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="942789271"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 30 Nov 2023 09:54:26 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8lF1-0002Us-1z;
        Thu, 30 Nov 2023 17:54:23 +0000
Date:   Fri, 1 Dec 2023 01:53:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>
Subject: arch/loongarch/kernel/relocate.c:166:38: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202312010123.vwEMnB5J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: e5f02b51fa0cb785e352e77271a65e96051b789b LoongArch: Add support for kernel address space layout randomization (KASLR)
date:   9 months ago
config: loongarch-randconfig-r034-20230511 (https://download.01.org/0day-ci/archive/20231201/202312010123.vwEMnB5J-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231201/202312010123.vwEMnB5J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312010123.vwEMnB5J-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/loongarch/kernel/relocate.c:166:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *cmdline @@     got void [noderef] __iomem * @@
   arch/loongarch/kernel/relocate.c:166:38: sparse:     expected char *cmdline
   arch/loongarch/kernel/relocate.c:166:38: sparse:     got void [noderef] __iomem *

vim +166 arch/loongarch/kernel/relocate.c

   159	
   160	void * __init relocate_kernel(void)
   161	{
   162		unsigned long kernel_length;
   163		unsigned long random_offset = 0;
   164		void *location_new = _text; /* Default to original kernel start */
   165		void *kernel_entry = start_kernel; /* Default to original kernel entry point */
 > 166		char *cmdline = early_ioremap(fw_arg1, COMMAND_LINE_SIZE); /* Boot command line is passed in fw_arg1 */
   167	
   168		strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
   169	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
