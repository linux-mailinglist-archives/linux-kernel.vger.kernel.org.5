Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AF47FDBC3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343891AbjK2Pog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343849AbjK2Pod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:44:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B80FD4A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701272680; x=1732808680;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AsXCdeoPw+hdpRPy/RfrIaS9MtAA4PykZfK2PqrCbto=;
  b=aXFt5CU9rU4c0SRUYbxGDd50Ko8QbldADC5ztNbZ18Te48dESUDpBlUE
   asKPCvc7xpZz1VWp3lCHo4BGBkzjObcvzTRqfjUVVOrXxGGSnd5w1FOGe
   dnZnGq9QQDwmr5nEVPCSIE62/MjZ/2G0O+YormBR5B+zV31gtnwObPqTK
   06avfKFdllAPzG6UbZ8IOgklpFX6MYTvgxI/4hrSCNMd9v+W43qudx6ut
   djPON81QrY4jbUf7HoLSJs36mHwb7bhBHOwWEh/GbjGktC0sGglIdxeps
   6NNLtahmBuY48k7I5/fGlEYFZt6S4t//Sdn3+DpGz+nrZotxapacG+uWW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="83293"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="83293"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 07:43:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="839470241"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="839470241"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2023 07:43:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8Miu-0000PD-02;
        Wed, 29 Nov 2023 15:43:36 +0000
Date:   Wed, 29 Nov 2023 23:42:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/powerpc/kernel/time.c:788:9: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202311292258.2P0hVLX1-lkp@intel.com>
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
head:   18d46e76d7c2eedd8577fae67e3f1d4db25018b0
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   4 months ago
config: powerpc-randconfig-c042-20230517 (https://download.01.org/0day-ci/archive/20231129/202311292258.2P0hVLX1-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231129/202311292258.2P0hVLX1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311292258.2P0hVLX1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/kernel/time.c:788:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:788:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:788:9: sparse:     got unsigned long long *
>> arch/powerpc/kernel/time.c:788:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:788:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:788:9: sparse:     got unsigned long long *
>> arch/powerpc/kernel/time.c:788:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:788:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:788:9: sparse:     got unsigned long long *
>> arch/powerpc/kernel/time.c:788:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:788:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:788:9: sparse:     got unsigned long long *
>> arch/powerpc/kernel/time.c:788:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:788:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:788:9: sparse:     got unsigned long long *
   arch/powerpc/kernel/time.c:796:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:796:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:796:9: sparse:     got unsigned long long *
   arch/powerpc/kernel/time.c:796:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:796:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:796:9: sparse:     got unsigned long long *
   arch/powerpc/kernel/time.c:796:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:796:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:796:9: sparse:     got unsigned long long *
   arch/powerpc/kernel/time.c:796:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:796:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:796:9: sparse:     got unsigned long long *
   arch/powerpc/kernel/time.c:796:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:796:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:796:9: sparse:     got unsigned long long *
   arch/powerpc/kernel/time.c:504:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got unsigned long long * @@
   arch/powerpc/kernel/time.c:504:24: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/powerpc/kernel/time.c:504:24: sparse:     got unsigned long long *

vim +788 arch/powerpc/kernel/time.c

4a4cfe3836916e Tony Breeds            2007-09-22  784  
d831d0b83f2058 Tony Breeds            2007-09-21  785  static int decrementer_set_next_event(unsigned long evt,
d831d0b83f2058 Tony Breeds            2007-09-21  786  				      struct clock_event_device *dev)
d831d0b83f2058 Tony Breeds            2007-09-21  787  {
6601ec1c2ba929 Christophe Leroy       2020-09-29 @788  	__this_cpu_write(decrementers_next_tb, get_tb() + evt);
25aa145856cd0d Nicholas Piggin        2021-11-23  789  	set_dec_or_work(evt);
0215f7d8c53fb1 Benjamin Herrenschmidt 2014-01-14  790  
d831d0b83f2058 Tony Breeds            2007-09-21  791  	return 0;
d831d0b83f2058 Tony Breeds            2007-09-21  792  }
d831d0b83f2058 Tony Breeds            2007-09-21  793  

:::::: The code at line 788 was first introduced by commit
:::::: 6601ec1c2ba929430f5585ce7f9d9960b0e0a01d powerpc: Remove get_tb_or_rtc()

:::::: TO: Christophe Leroy <christophe.leroy@csgroup.eu>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
