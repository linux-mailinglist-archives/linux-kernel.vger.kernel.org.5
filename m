Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77912785877
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjHWNDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjHWNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:03:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1098ACD2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692795821; x=1724331821;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BquTohv3LwIJ9ZuikwtYbbBYyyhiYo0Kyiyvy539z84=;
  b=YT5m9OXTQZEuCVAe2Q5qvjWltTHG3ifeIMgqegegTHM2PQJvvDe2FcgT
   LuOFqR9upIOsejGn9SOkk11YRwRoZHPLmWUU6YYrVxOkzNWJuu5dPWxB3
   LzZziE0xbUmvvAgvI1YtRDTfiv71JOrsO13X+io+DYnQzVma1Q0U1xZpj
   gUts4JQNHejLRsJ2EFnZlMJCI6jPIA0JVVUv/BfEHWu1id5FfprPJShSZ
   XyP/s2uaCgY4wvw9qGI0GGnFcfhNb74xjWBoMNcufeNcLc2v3lWBxY07Q
   tiEXUDSjJQIbZaZGIUf5JYKJZcSJRFmQbR2FMPiyO/LqdPTmt5scBazJb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="376880736"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="376880736"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 05:58:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="771709706"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="771709706"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 23 Aug 2023 05:58:08 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYnR1-0001DL-2R;
        Wed, 23 Aug 2023 12:58:07 +0000
Date:   Wed, 23 Aug 2023 20:57:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/cpu/adc.c:22:15: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202308232042.kyTaPvw6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   89bf6209cad66214d3774dac86b6bbf2aec6a30d
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   3 years ago
config: sh-randconfig-r122-20230822 (https://download.01.org/0day-ci/archive/20230823/202308232042.kyTaPvw6-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308232042.kyTaPvw6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308232042.kyTaPvw6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/sh/kernel/cpu/adc.c:22:15: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:22:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:22:15: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:24:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:24:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:24:9: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:27:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:27:23: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:27:23: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:31:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:31:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:31:9: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:33:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:33:19: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:33:19: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:34:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:34:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:34:17: sparse:     got unsigned int
--
   fs/binfmt_flat.c:402:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] __user *[assigned] ptr @@
   fs/binfmt_flat.c:402:9: sparse:     expected unsigned long const *__gu_addr
   fs/binfmt_flat.c:402:9: sparse:     got unsigned long [noderef] __user *[assigned] ptr
>> fs/binfmt_flat.c:402:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   fs/binfmt_flat.c:402:9: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_flat.c:402:9: sparse:     got unsigned long const *__gu_addr
   fs/binfmt_flat.c:775:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *[assigned] rp @@
   fs/binfmt_flat.c:775:29: sparse:     expected unsigned int const *__gu_addr
   fs/binfmt_flat.c:775:29: sparse:     got unsigned int [noderef] [usertype] __user *[assigned] rp
   fs/binfmt_flat.c:775:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/binfmt_flat.c:775:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_flat.c:775:29: sparse:     got unsigned int const *__gu_addr
   fs/binfmt_flat.c:812:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __be32 const *__gu_addr @@     got restricted __be32 [noderef] [usertype] __user * @@
   fs/binfmt_flat.c:812:29: sparse:     expected restricted __be32 const *__gu_addr
   fs/binfmt_flat.c:812:29: sparse:     got restricted __be32 [noderef] [usertype] __user *
   fs/binfmt_flat.c:812:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got restricted __be32 const *__gu_addr @@
   fs/binfmt_flat.c:812:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_flat.c:812:29: sparse:     got restricted __be32 const *__gu_addr
   fs/binfmt_flat.c:855:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __be32 const *__gu_addr @@     got restricted __be32 [noderef] [usertype] __user * @@
   fs/binfmt_flat.c:855:29: sparse:     expected restricted __be32 const *__gu_addr
   fs/binfmt_flat.c:855:29: sparse:     got restricted __be32 [noderef] [usertype] __user *
   fs/binfmt_flat.c:855:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got restricted __be32 const *__gu_addr @@
   fs/binfmt_flat.c:855:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/binfmt_flat.c:855:29: sparse:     got restricted __be32 const *__gu_addr
   fs/binfmt_flat.c:865:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __user *__cl_addr @@
   fs/binfmt_flat.c:865:13: sparse:     expected void *addr
   fs/binfmt_flat.c:865:13: sparse:     got void [noderef] __user *__cl_addr
--
   kernel/locking/lockdep_proc.c:448:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/locking/lockdep_proc.c:448:17: sparse:    char const [noderef] __rcu *
   kernel/locking/lockdep_proc.c:448:17: sparse:    char const *
   kernel/locking/lockdep_proc.c:449:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/locking/lockdep_proc.c:449:17: sparse:    struct lockdep_subclass_key const [noderef] __rcu *
   kernel/locking/lockdep_proc.c:449:17: sparse:    struct lockdep_subclass_key const *
   kernel/locking/lockdep_proc.c:649:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buf @@
   kernel/locking/lockdep_proc.c:649:21: sparse:     expected char const *__gu_addr
   kernel/locking/lockdep_proc.c:649:21: sparse:     got char const [noderef] __user *buf
>> kernel/locking/lockdep_proc.c:649:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   kernel/locking/lockdep_proc.c:649:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/locking/lockdep_proc.c:649:21: sparse:     got char const *__gu_addr
--
   drivers/hid/usbhid/hiddev.c:569:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hid/usbhid/hiddev.c:569:13: sparse:     expected int const *__gu_addr
   drivers/hid/usbhid/hiddev.c:569:13: sparse:     got int [noderef] __user *
>> drivers/hid/usbhid/hiddev.c:569:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/hid/usbhid/hiddev.c:569:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hid/usbhid/hiddev.c:569:13: sparse:     got int const *__gu_addr
   drivers/hid/usbhid/hiddev.c:664:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hid/usbhid/hiddev.c:664:29: sparse:     expected int const *__gu_addr
   drivers/hid/usbhid/hiddev.c:664:29: sparse:     got int [noderef] __user *
   drivers/hid/usbhid/hiddev.c:664:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/hid/usbhid/hiddev.c:664:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hid/usbhid/hiddev.c:664:29: sparse:     got int const *__gu_addr
--
   drivers/media/rc/lirc_dev.c:378:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/media/rc/lirc_dev.c:378:23: sparse:     expected unsigned int const *__gu_addr
   drivers/media/rc/lirc_dev.c:378:23: sparse:     got unsigned int [noderef] [usertype] __user *argp
>> drivers/media/rc/lirc_dev.c:378:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/media/rc/lirc_dev.c:378:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/media/rc/lirc_dev.c:378:23: sparse:     got unsigned int const *__gu_addr
--
   drivers/tee/tee_core.c:683:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:683:13: sparse:     expected unsigned int const *__gu_addr
   drivers/tee/tee_core.c:683:13: sparse:     got unsigned int [noderef] __user *
>> drivers/tee/tee_core.c:683:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tee/tee_core.c:683:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:683:13: sparse:     got unsigned int const *__gu_addr
   drivers/tee/tee_core.c:781:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:781:13: sparse:     expected unsigned int const *__gu_addr
   drivers/tee/tee_core.c:781:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:781:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tee/tee_core.c:781:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:781:13: sparse:     got unsigned int const *__gu_addr
   drivers/tee/tee_core.c:782:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:782:13: sparse:     expected unsigned int const *__gu_addr
   drivers/tee/tee_core.c:782:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:782:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tee/tee_core.c:782:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:782:13: sparse:     got unsigned int const *__gu_addr
--
   sound/soc/uniphier/aio-compress.c:295:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   sound/soc/uniphier/aio-compress.c:295:23: sparse:     expected unsigned int const *__gu_addr
   sound/soc/uniphier/aio-compress.c:295:23: sparse:     got unsigned int [noderef] [usertype] __user *
>> sound/soc/uniphier/aio-compress.c:295:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   sound/soc/uniphier/aio-compress.c:295:23: sparse:     expected void const volatile [noderef] __user *ptr
   sound/soc/uniphier/aio-compress.c:295:23: sparse:     got unsigned int const *__gu_addr
   sound/soc/uniphier/aio-compress.c:309:34: sparse: sparse: cast to restricted __be16
   sound/soc/uniphier/aio-compress.c:309:34: sparse: sparse: cast to restricted __be16
   sound/soc/uniphier/aio-compress.c:309:34: sparse: sparse: cast to restricted __be16
   sound/soc/uniphier/aio-compress.c:309:34: sparse: sparse: cast to restricted __be16
--
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     expected unsigned int const *__gu_addr
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/video/fbdev/s3c-fb.c:1024:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     got unsigned int const *__gu_addr
--
   drivers/watchdog/at91rm9200_wdt.c:174:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/at91rm9200_wdt.c:174:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/at91rm9200_wdt.c:174:21: sparse:     got int [noderef] __user *p
>> drivers/watchdog/at91rm9200_wdt.c:174:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/at91rm9200_wdt.c:174:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/at91rm9200_wdt.c:174:21: sparse:     got int const *__gu_addr
   drivers/watchdog/at91rm9200_wdt.c:185:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/at91rm9200_wdt.c:185:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/at91rm9200_wdt.c:185:21: sparse:     got int [noderef] __user *p
   drivers/watchdog/at91rm9200_wdt.c:185:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/at91rm9200_wdt.c:185:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/at91rm9200_wdt.c:185:21: sparse:     got int const *__gu_addr
   drivers/watchdog/at91rm9200_wdt.c:219:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *write )( ... ) @@     got int ( * )( ... ) @@
   drivers/watchdog/at91rm9200_wdt.c:219:27: sparse:     expected int ( *write )( ... )
   drivers/watchdog/at91rm9200_wdt.c:219:27: sparse:     got int ( * )( ... )
--
>> arch/sh/oprofile/backtrace.c:43:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long *stackaddr @@
   arch/sh/oprofile/backtrace.c:43:14: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/oprofile/backtrace.c:43:14: sparse:     got unsigned long *stackaddr
   arch/sh/oprofile/backtrace.c:46:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got unsigned long *stackaddr @@
   arch/sh/oprofile/backtrace.c:46:51: sparse:     expected void const [noderef] __user *from
   arch/sh/oprofile/backtrace.c:46:51: sparse:     got unsigned long *stackaddr

vim +22 arch/sh/kernel/cpu/adc.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  11  
^1da177e4c3f41 Linus Torvalds 2005-04-16  12  
^1da177e4c3f41 Linus Torvalds 2005-04-16  13  int adc_single(unsigned int channel)
^1da177e4c3f41 Linus Torvalds 2005-04-16  14  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  15  	int off;
^1da177e4c3f41 Linus Torvalds 2005-04-16  16  	unsigned char csr;
^1da177e4c3f41 Linus Torvalds 2005-04-16  17  
^1da177e4c3f41 Linus Torvalds 2005-04-16  18  	if (channel >= 8) return -1;
^1da177e4c3f41 Linus Torvalds 2005-04-16  19  
^1da177e4c3f41 Linus Torvalds 2005-04-16  20  	off = (channel & 0x03) << 2;
^1da177e4c3f41 Linus Torvalds 2005-04-16  21  
9d56dd3b083a3b Paul Mundt     2010-01-26 @22  	csr = __raw_readb(ADCSR);
^1da177e4c3f41 Linus Torvalds 2005-04-16  23  	csr = channel | ADCSR_ADST | ADCSR_CKS;
9d56dd3b083a3b Paul Mundt     2010-01-26  24  	__raw_writeb(csr, ADCSR);
^1da177e4c3f41 Linus Torvalds 2005-04-16  25  
^1da177e4c3f41 Linus Torvalds 2005-04-16  26  	do {
9d56dd3b083a3b Paul Mundt     2010-01-26  27  		csr = __raw_readb(ADCSR);
^1da177e4c3f41 Linus Torvalds 2005-04-16  28  	} while ((csr & ADCSR_ADF) == 0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  29  
^1da177e4c3f41 Linus Torvalds 2005-04-16  30  	csr &= ~(ADCSR_ADF | ADCSR_ADST);
9d56dd3b083a3b Paul Mundt     2010-01-26  31  	__raw_writeb(csr, ADCSR);
^1da177e4c3f41 Linus Torvalds 2005-04-16  32  
9d56dd3b083a3b Paul Mundt     2010-01-26  33  	return (((__raw_readb(ADDRAH + off) << 8) |
9d56dd3b083a3b Paul Mundt     2010-01-26  34  		__raw_readb(ADDRAL + off)) >> 6);
^1da177e4c3f41 Linus Torvalds 2005-04-16  35  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  36  

:::::: The code at line 22 was first introduced by commit
:::::: 9d56dd3b083a3bec56e9da35ce07baca81030b03 sh: Mass ctrl_in/outX to __raw_read/writeX conversion.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
