Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B477CECBA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjJSAWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJSAWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:22:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B81FA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 17:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697674958; x=1729210958;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Utyrp8eUxVz0/SKUmPWDVAn7mVAHUWs4Es1jRrphH7M=;
  b=ZrFT6DwdDkSH4WpPm15hscsssZJ54vh2nNZGAYKezP3ilT7sNdGPsPcX
   1h+4iee23M0Xo+cxe89nKe1HoPB5Iu4G65nlrNlJKarb+YsldXzJpFx16
   UGdqr+GTH6NY5tpDEWulJSZcQIuBLxYwQUb2xKXbr97qAggnoJ42JEMDi
   piabyLAq/wOqkievHZR5ZkVw4m/vsWQxvvh1KhT52qst4MrU2BrSCEiOC
   u9c+EIoUofi88iKga0VF4qFrNSUHVPpQ03oEp26IImDoqm9SEFegFyqOa
   rFJu2CdiFpdEoAVwGf+dtONJaFvMsg26Tw0YIj5yZa+9K+M6NVIeM064z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="376519344"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="376519344"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 17:22:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="760442115"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="760442115"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Oct 2023 17:22:36 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtGo6-0001KA-0q;
        Thu, 19 Oct 2023 00:22:34 +0000
Date:   Thu, 19 Oct 2023 08:21:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/arm/include/asm/memory.h:298:23: warning: array subscript -1 is
 outside array bounds of 'const void[2147483647]'
Message-ID: <202310190854.yTRUMqLL-lkp@intel.com>
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
head:   dd72f9c7e512da377074d47d990564959b772643
commit: a9ff6961601d9aa0c42b6eb7d850371f31b1f5e6 ARM: mm: Make virt_to_pfn() a static inline
date:   5 months ago
config: arm-randconfig-r022-20230725 (https://download.01.org/0day-ci/archive/20231019/202310190854.yTRUMqLL-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310190854.yTRUMqLL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310190854.yTRUMqLL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm/include/asm/page.h:166,
                    from arch/arm/include/asm/thread_info.h:14,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/arm/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from arch/arm/kernel/hibernate.c:17:
   In function 'virt_to_pfn',
       inlined from 'pfn_is_nosave' at arch/arm/kernel/hibernate.c:29:33:
>> arch/arm/include/asm/memory.h:298:23: warning: array subscript -1 is outside array bounds of 'const void[2147483647]' [-Warray-bounds=]
     298 |         unsigned long kaddr = (unsigned long)p;
         |                       ^~~~~
   In file included from arch/arm/include/asm/sections.h:5,
                    from include/linux/interrupt.h:21,
                    from include/linux/kernel_stat.h:9,
                    from include/linux/cgroup.h:26,
                    from include/linux/memcontrol.h:13,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from arch/arm/kernel/hibernate.c:18:
   include/asm-generic/sections.h: In function 'pfn_is_nosave':
   include/asm-generic/sections.h:59:45: note: at offset -1 into object '__nosave_end' of size [0, 2147483647]
      59 | extern __visible const void __nosave_begin, __nosave_end;
         |                                             ^~~~~~~~~~~~


vim +298 arch/arm/include/asm/memory.h

   295	
   296	static inline unsigned long virt_to_pfn(const void *p)
   297	{
 > 298		unsigned long kaddr = (unsigned long)p;
   299		return (((kaddr - PAGE_OFFSET) >> PAGE_SHIFT) +
   300			PHYS_PFN_OFFSET);
   301	}
   302	#define __pa_symbol_nodebug(x)	__virt_to_phys_nodebug((x))
   303	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
