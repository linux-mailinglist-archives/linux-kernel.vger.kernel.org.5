Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7F97718A9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjHGC7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHGC7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:59:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91B51BC9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691377149; x=1722913149;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hhK8/eSkfPAY2j7QLmWTNFc3IKIknwQ0SMdG8chi5Ms=;
  b=NyuFAubPG4UVAqNpvA0q+N7a3/gk6K8oD/vgNTPCKeKCrQuQ6EtFBaMp
   YqGj2OKiOthVNZHvf+Vk+PnQXK/Mr+ZczYCvDctnVuJeB5P/3G/MlXvM6
   p+B4m0C9I+IAPqeG7hqDs3Fvz5Y429hWOgGlixg97xS3uvagYwiyYDPGs
   ZYEAHmNopRNsJrfdDIiK3jj9NDK6CA69/ob8GnKM1lE/hVuZu0oPTQ3H2
   e5sjSAmgw41i0dLvB2lILCJm7re+MbqMXwwIe7is6gwLQP/ZsrH3FxWKl
   cvy5eVpDhOMynLlf6da7Xp+/ezeuAknFuFJhIUGC10VT+UNilRfhKUMPS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="434287516"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="434287516"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 19:59:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="977268350"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
   d="scan'208";a="977268350"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2023 19:59:07 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qSqSY-0004VD-2A;
        Mon, 07 Aug 2023 02:59:06 +0000
Date:   Mon, 7 Aug 2023 10:58:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Benjamin Gray <bgray@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: arch/powerpc/platforms/powermac/time.c:210:24: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202308071025.KCEf7Mhd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52a93d39b17dc7eb98b6aa3edb93943248e03b2f
commit: 86582e6189dd8f9f52c25d46c70fe5d111da6345 powerpc/powermac: Use early_* IO variants in via_calibrate_decr()
date:   5 days ago
config: powerpc-randconfig-r071-20230807 (https://download.01.org/0day-ci/archive/20230807/202308071025.KCEf7Mhd-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230807/202308071025.KCEf7Mhd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308071025.KCEf7Mhd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/platforms/powermac/time.c:210:24: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/powermac/time.c:210:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   arch/powerpc/platforms/powermac/time.c:210:24: sparse:     expected void [noderef] __iomem *addr
   arch/powerpc/platforms/powermac/time.c:210:24: sparse:     got void *
   arch/powerpc/platforms/powermac/time.c:192:30: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/powermac/time.c:192:30: sparse: sparse: dereference of noderef expression
   arch/powerpc/platforms/powermac/time.c:196:27: sparse: sparse: cast truncates bits from constant value (b798 becomes 98)

vim +/__iomem +210 arch/powerpc/platforms/powermac/time.c

   161	
   162	#ifdef CONFIG_PPC32
   163	/*
   164	 * Calibrate the decrementer register using VIA timer 1.
   165	 * This is used both on powermacs and CHRP machines.
   166	 */
   167	static int __init via_calibrate_decr(void)
   168	{
   169		struct device_node *vias;
   170		volatile unsigned char __iomem *via;
   171		int count = VIA_TIMER_FREQ_6 / 100;
   172		unsigned int dstart, dend;
   173		struct resource rsrc;
   174	
   175		vias = of_find_node_by_name(NULL, "via-cuda");
   176		if (vias == NULL)
   177			vias = of_find_node_by_name(NULL, "via-pmu");
   178		if (vias == NULL)
   179			vias = of_find_node_by_name(NULL, "via");
   180		if (vias == NULL || of_address_to_resource(vias, 0, &rsrc)) {
   181		        of_node_put(vias);
   182			return 0;
   183		}
   184		of_node_put(vias);
   185		via = early_ioremap(rsrc.start, resource_size(&rsrc));
   186		if (via == NULL) {
   187			printk(KERN_ERR "Failed to map VIA for timer calibration !\n");
   188			return 0;
   189		}
   190	
   191		/* set timer 1 for continuous interrupts */
   192		out_8(&via[ACR], (via[ACR] & ~T1MODE) | T1MODE_CONT);
   193		/* set the counter to a small value */
   194		out_8(&via[T1CH], 2);
   195		/* set the latch to `count' */
   196		out_8(&via[T1LL], count);
   197		out_8(&via[T1LH], count >> 8);
   198		/* wait until it hits 0 */
   199		while ((in_8(&via[IFR]) & T1_INT) == 0)
   200			;
   201		dstart = get_dec();
   202		/* clear the interrupt & wait until it hits 0 again */
   203		in_8(&via[T1CL]);
   204		while ((in_8(&via[IFR]) & T1_INT) == 0)
   205			;
   206		dend = get_dec();
   207	
   208		ppc_tb_freq = (dstart - dend) * 100 / 6;
   209	
 > 210		early_iounmap((void *)via, resource_size(&rsrc));
   211	
   212		return 1;
   213	}
   214	#endif
   215	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
