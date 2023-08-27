Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5558378A385
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjH0Xna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjH0XnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:43:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED42D9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693179789; x=1724715789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fNmyjqdkxR2jHWMWgDRNMlIPPjHHGf2jHqpfKu0Q9IY=;
  b=XoFcRaNm1z+ClegI/rpmDdz1sjSbZr8eT+phLJXeABlHyj9aDLZakkho
   gp0QsZ/UWbJqvFK0GVnjBoCocxQxLChZMAE7Mng9PdhuHubaYbRJSIglv
   IfJ/smWx9w64VrGVp24oz37JN29i/m9bUhLH6iWs/FzjpGSMjzFnTi0ME
   RP8IQkx7DEzXRaGwJXig0Eq4gZJ+6WB5k7RZcC4pHFWdWLQkJl1Gc3gB+
   w/0waL4MNwgDa10I82KD3MB/Bgfzxu60+JQreC4x0rofdDsJ9tYj/Zb1i
   UAxhsmelIlFhVNC46MkyhWJUup8iV0hBsRwdS5DEIFw0yxctG/XW7v/gV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="441323921"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="441323921"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 16:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="773076438"
X-IronPort-AV: E=Sophos;i="6.02,206,1688454000"; 
   d="scan'208";a="773076438"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 27 Aug 2023 16:43:06 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaPPN-0006JP-0y;
        Sun, 27 Aug 2023 23:43:05 +0000
Date:   Mon, 28 Aug 2023 07:42:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oliver Crumrine <ozlinux@hotmail.com>, gregkh@linuxfoundation.org,
        colin.i.king@gmail.com, sumitraartsy@gmail.com,
        u.kleine-koenig@pengutronix.de, geert@linux-m68k.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 6/6] staging: octeon: clean up the octeon ethernet driver
Message-ID: <202308280701.II3T3JeO-lkp@intel.com>
References: <PH7PR11MB7643F9F5DBB6781022CC4F4DBCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB7643F9F5DBB6781022CC4F4DBCE1A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Oliver-Crumrine/staging-octeon-clean-up-the-octeon-ethernet-driver/20230828-051802
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/PH7PR11MB7643F9F5DBB6781022CC4F4DBCE1A%40PH7PR11MB7643.namprd11.prod.outlook.com
patch subject: [PATCH 6/6] staging: octeon: clean up the octeon ethernet driver
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230828/202308280701.II3T3JeO-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230828/202308280701.II3T3JeO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308280701.II3T3JeO-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/staging/octeon/ethernet.c: In function 'cvm_oct_common_get_stats':
   drivers/staging/octeon/ethernet.c:204:39: error: storage size of 'rx_status' isn't known
     204 |         struct cvmx_pip_port_status_t rx_status;
         |                                       ^~~~~~~~~
   In file included from include/linux/string.h:254,
                    from include/linux/bitmap.h:11,
                    from include/linux/cpumask.h:12,
                    from arch/loongarch/include/asm/processor.h:9,
                    from arch/loongarch/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/current.h:5,
                    from ./arch/loongarch/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/platform_device.h:13,
                    from drivers/staging/octeon/ethernet.c:8:
>> include/linux/fortify-string.h:515:65: warning: left-hand operand of comma expression has no effect [-Wunused-value]
     515 |         fortify_memset_chk(__fortify_size, p_size, p_size_field),       \
         |                                                                 ^
   include/linux/fortify-string.h:524:25: note: in expansion of macro '__fortify_memset_chk'
     524 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
         |                         ^~~~~~~~~~~~~~~~~~~~
   drivers/staging/octeon/ethernet.c:211:25: note: in expansion of macro 'memset'
     211 |                         memset(&rx_status, 0, sizeof(rx_status));
         |                         ^~~~~~
   drivers/staging/octeon/ethernet.c:204:39: warning: unused variable 'rx_status' [-Wunused-variable]
     204 |         struct cvmx_pip_port_status_t rx_status;
         |                                       ^~~~~~~~~


vim +515 include/linux/fortify-string.h

28e77cc1c06866 Kees Cook 2021-06-16  512  
28e77cc1c06866 Kees Cook 2021-06-16  513  #define __fortify_memset_chk(p, c, size, p_size, p_size_field) ({	\
28e77cc1c06866 Kees Cook 2021-06-16  514  	size_t __fortify_size = (size_t)(size);				\
28e77cc1c06866 Kees Cook 2021-06-16 @515  	fortify_memset_chk(__fortify_size, p_size, p_size_field),	\
28e77cc1c06866 Kees Cook 2021-06-16  516  	__underlying_memset(p, c, __fortify_size);			\
28e77cc1c06866 Kees Cook 2021-06-16  517  })
28e77cc1c06866 Kees Cook 2021-06-16  518  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
