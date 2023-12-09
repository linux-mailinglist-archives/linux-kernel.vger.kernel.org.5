Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B41D80B22C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 06:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjLIFUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 00:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLIFUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 00:20:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DF192
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 21:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702099247; x=1733635247;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=itSDpXH72I3FTYHBhj6+XQ+muCzGwhGWrNEQjpPzZ9c=;
  b=cs4LPaCj3C2FkOpRxJj/EFKzGtjHoC2LFFNaiRA+C7ot2HUbV/nOZ+eC
   KSGkcY8WQotzJozAnESLQs0ZworKR283gqqLHo8XHwvpbiULtTbxiruJ+
   5v6Xnh7z0hJEB/8iVKljPlY6brVSAnlZGffBlmBJzKOOv+mfNU8CyZ66m
   tK0sFcrhcK7ocZI76y2b41sATZaV81QjB/i7D0W6MVwbdwft0sckkwiY9
   V4CINaP/Yfy4vhd7vokUfXXSQpo5hRYIP+mhGvcF1A4/OdhadMtZL1OEb
   ZsJsLzlI9vjMe0/vZ4kkYVhzLVLt/HEe1UWjnzv8HO8kgRBH30bc6FKvu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="460968704"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="460968704"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 21:20:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="945633863"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="945633863"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Dec 2023 21:20:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBplP-000Es3-0X;
        Sat, 09 Dec 2023 05:20:34 +0000
Date:   Sat, 9 Dec 2023 13:19:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kernel/time.c:846:9: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202312091358.yxVj2uev-lkp@intel.com>
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
head:   f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e
commit: 4ebbd075bcde7884e078d4360510b989f559bfec KVM: PPC: Book3S HV P9: Use host timer accounting to avoid decrementer read
date:   2 years ago
config: powerpc-randconfig-r113-20231106 (https://download.01.org/0day-ci/archive/20231209/202312091358.yxVj2uev-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231209/202312091358.yxVj2uev-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312091358.yxVj2uev-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/kernel/time.c:846:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:846:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:846:9: sparse:     got unsigned long long *
>> arch/powerpc/kernel/time.c:846:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:846:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:846:9: sparse:     got unsigned long long *
>> arch/powerpc/kernel/time.c:846:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:846:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:846:9: sparse:     got unsigned long long *
>> arch/powerpc/kernel/time.c:846:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:846:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:846:9: sparse:     got unsigned long long *
>> arch/powerpc/kernel/time.c:846:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:846:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:846:9: sparse:     got unsigned long long *
   arch/powerpc/kernel/time.c:557:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:557:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:557:24: sparse:     got unsigned long long *

vim +846 arch/powerpc/kernel/time.c

4a4cfe3836916e Tony Breeds            2007-09-22  842  
d831d0b83f2058 Tony Breeds            2007-09-21  843  static int decrementer_set_next_event(unsigned long evt,
d831d0b83f2058 Tony Breeds            2007-09-21  844  				      struct clock_event_device *dev)
d831d0b83f2058 Tony Breeds            2007-09-21  845  {
6601ec1c2ba929 Christophe Leroy       2020-09-29 @846  	__this_cpu_write(decrementers_next_tb, get_tb() + evt);
d831d0b83f2058 Tony Breeds            2007-09-21  847  	set_dec(evt);
0215f7d8c53fb1 Benjamin Herrenschmidt 2014-01-14  848  
0215f7d8c53fb1 Benjamin Herrenschmidt 2014-01-14  849  	/* We may have raced with new irq work */
0215f7d8c53fb1 Benjamin Herrenschmidt 2014-01-14  850  	if (test_irq_work_pending())
0215f7d8c53fb1 Benjamin Herrenschmidt 2014-01-14  851  		set_dec(1);
0215f7d8c53fb1 Benjamin Herrenschmidt 2014-01-14  852  
d831d0b83f2058 Tony Breeds            2007-09-21  853  	return 0;
d831d0b83f2058 Tony Breeds            2007-09-21  854  }
d831d0b83f2058 Tony Breeds            2007-09-21  855  

:::::: The code at line 846 was first introduced by commit
:::::: 6601ec1c2ba929430f5585ce7f9d9960b0e0a01d powerpc: Remove get_tb_or_rtc()

:::::: TO: Christophe Leroy <christophe.leroy@csgroup.eu>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
