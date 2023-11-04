Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0714E7E0E9E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjKDJgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKDJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:36:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812B51B2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699090559; x=1730626559;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5uyF9+HgS39a11AZWj9SwW9/OVuzZ/sByUPDsPJIKVw=;
  b=KK421ZPxhInf4/fHCZpWrDA48kB73hYpLBXl1A901nIJyWv056EG2YtH
   KeX4ODcrrNC15YgQtcaL2ys7Pe9SdaOvLxBIR5Mfkegcp/UagTgmUeMT0
   xse81DLgflBHJpYAQf7t/o02OVdpWvzmlvcklBBJXxYxIYpC/6R7rvFWM
   GUYKu/RSpY5SxLZS9GnzBplVDRvNkcQT7VNGNh8VkMs8e8a6oiiq5sLaT
   MF9ZAjTNRC0bMCoVnERAbhwXRJXpogVi41nNpCrToqQq+XlyaCQ6of6Uy
   A6qS09/paZYjc8HJDPyoJ5w1/KUrzryr2zqumLjhxslKq2mb8MUtAV0Pc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="475307846"
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="475307846"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 02:35:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,276,1694761200"; 
   d="scan'208";a="3159053"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 04 Nov 2023 02:35:58 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzD4N-0003jt-1n;
        Sat, 04 Nov 2023 09:35:55 +0000
Date:   Sat, 4 Nov 2023 17:34:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: arch/x86/kernel/apic/apic.c:2135: warning: Excess function parameter
 'regs' description in 'DEFINE_IDTENTRY_IRQ'
Message-ID: <202311041727.4OfKWbk6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90b0c2b2edd1adff742c621e246562fbefa11b70
commit: fa5e5c409213265da8a188b4a5e4e641b1382eb4 x86/entry: Use idtentry for interrupts
date:   3 years, 5 months ago
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20231104/202311041727.4OfKWbk6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311041727.4OfKWbk6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311041727.4OfKWbk6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/x86/kernel/apic/apic.c:2135: warning: Function parameter or member 'spurious_interrupt' not described in 'DEFINE_IDTENTRY_IRQ'
>> arch/x86/kernel/apic/apic.c:2135: warning: Excess function parameter 'regs' description in 'DEFINE_IDTENTRY_IRQ'
>> arch/x86/kernel/apic/apic.c:2135: warning: Excess function parameter 'vector' description in 'DEFINE_IDTENTRY_IRQ'


vim +2135 arch/x86/kernel/apic/apic.c

c0104d38a740b2 arch/x86/kernel/apic/apic.c Yinghai Lu      2010-12-07  2118  
^1da177e4c3f41 arch/x86_64/kernel/apic.c   Linus Torvalds  2005-04-16  2119  /*
0e078e2f5060e0 arch/x86/kernel/apic_64.c   Thomas Gleixner 2008-01-30  2120   * Local APIC interrupts
^1da177e4c3f41 arch/x86_64/kernel/apic.c   Linus Torvalds  2005-04-16  2121   */
^1da177e4c3f41 arch/x86_64/kernel/apic.c   Linus Torvalds  2005-04-16  2122  
633260fa143bbe arch/x86/kernel/apic/apic.c Thomas Gleixner 2020-05-21  2123  /**
fa5e5c40921326 arch/x86/kernel/apic/apic.c Thomas Gleixner 2020-05-21  2124   * spurious_interrupt - Catch all for interrupts raised on unused vectors
633260fa143bbe arch/x86/kernel/apic/apic.c Thomas Gleixner 2020-05-21  2125   * @regs:	Pointer to pt_regs on stack
fa5e5c40921326 arch/x86/kernel/apic/apic.c Thomas Gleixner 2020-05-21  2126   * @vector:	The vector number
633260fa143bbe arch/x86/kernel/apic/apic.c Thomas Gleixner 2020-05-21  2127   *
633260fa143bbe arch/x86/kernel/apic/apic.c Thomas Gleixner 2020-05-21  2128   * This is invoked from ASM entry code to catch all interrupts which
633260fa143bbe arch/x86/kernel/apic/apic.c Thomas Gleixner 2020-05-21  2129   * trigger on an entry which is routed to the common_spurious idtentry
633260fa143bbe arch/x86/kernel/apic/apic.c Thomas Gleixner 2020-05-21  2130   * point.
633260fa143bbe arch/x86/kernel/apic/apic.c Thomas Gleixner 2020-05-21  2131   *
633260fa143bbe arch/x86/kernel/apic/apic.c Thomas Gleixner 2020-05-21  2132   * Also called from smp_spurious_apic_interrupt().
0e078e2f5060e0 arch/x86/kernel/apic_64.c   Thomas Gleixner 2008-01-30  2133   */
fa5e5c40921326 arch/x86/kernel/apic/apic.c Thomas Gleixner 2020-05-21  2134  DEFINE_IDTENTRY_IRQ(spurious_interrupt)
^1da177e4c3f41 arch/x86_64/kernel/apic.c   Linus Torvalds  2005-04-16 @2135  {
dc1528dd864a0b arch/x86/kernel/apic_64.c   Yinghai Lu      2008-08-24  2136  	u32 v;
dc1528dd864a0b arch/x86/kernel/apic_64.c   Yinghai Lu      2008-08-24  2137  
61069de7a3252b arch/x86/kernel/apic/apic.c Thomas Gleixner 2017-08-28  2138  	trace_spurious_apic_entry(vector);
61069de7a3252b arch/x86/kernel/apic/apic.c Thomas Gleixner 2017-08-28  2139  
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2140  	inc_irq_stat(irq_spurious_count);
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2141  
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2142  	/*
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2143  	 * If this is a spurious interrupt then do not acknowledge
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2144  	 */
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2145  	if (vector == SPURIOUS_APIC_VECTOR) {
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2146  		/* See SDM vol 3 */
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2147  		pr_info("Spurious APIC interrupt (vector 0xFF) on CPU#%d, should never happen.\n",
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2148  			smp_processor_id());
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2149  		goto out;
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2150  	}
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2151  
0e078e2f5060e0 arch/x86/kernel/apic_64.c   Thomas Gleixner 2008-01-30  2152  	/*
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2153  	 * If it is a vectored one, verify it's set in the ISR. If set,
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2154  	 * acknowledge it.
0e078e2f5060e0 arch/x86/kernel/apic_64.c   Thomas Gleixner 2008-01-30  2155  	 */
2414e021ac8d58 arch/x86/kernel/apic/apic.c Jan Beulich     2014-11-03  2156  	v = apic_read(APIC_ISR + ((vector & ~0x1f) >> 1));
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2157  	if (v & (1 << (vector & 0x1f))) {
fa5e5c40921326 arch/x86/kernel/apic/apic.c Thomas Gleixner 2020-05-21  2158  		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Acked\n",
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2159  			vector, smp_processor_id());
0e078e2f5060e0 arch/x86/kernel/apic_64.c   Thomas Gleixner 2008-01-30  2160  		ack_APIC_irq();
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2161  	} else {
fa5e5c40921326 arch/x86/kernel/apic/apic.c Thomas Gleixner 2020-05-21  2162  		pr_info("Spurious interrupt (vector 0x%02x) on CPU#%d. Not pending!\n",
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2163  			vector, smp_processor_id());
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2164  	}
f8a8fe61fec800 arch/x86/kernel/apic/apic.c Thomas Gleixner 2019-06-28  2165  out:
2414e021ac8d58 arch/x86/kernel/apic/apic.c Jan Beulich     2014-11-03  2166  	trace_spurious_apic_exit(vector);
0e078e2f5060e0 arch/x86/kernel/apic_64.c   Thomas Gleixner 2008-01-30  2167  }
c4d58cbd158dc9 arch/x86/kernel/apic_64.c   Thomas Gleixner 2007-10-12  2168  

:::::: The code at line 2135 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
