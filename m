Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647387AADCD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjIVJ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjIVJ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:26:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0D4195
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695374756; x=1726910756;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=guXUGf1mDoqbSRpGVzuqDiG+Tmo1gFAK8fnXm8atabU=;
  b=Nt0D5PaTHOWSlmHfbd4i2vVBrugxyQhC56HX8j59lEkE935zW33rMzcN
   lZeLq2j5jp6gqmANxCIB0wMLAGX7D8r1VscdVwRKPJnupERxP+XWY15EC
   Ib9cbahDO+Qq0QXMeVaXx5uKqDcNKJqWcvyd4wELNenYWFrgadrQP89PB
   ejqWw1zQxWl/SyoD6MY1aYh9wQpCucs744td9BTbBakWWPAhx5uoD+j0G
   PoMgp+BHLb1Fj6hE2g8ImT2VCXTh3a4ipz4cxOYSvJSiB/xc/0vrN4Q43
   qwyZtFaUAJs6aWl+uFpCr7boyBp3Qpp1Rve6rmuTlrygIdPinqYyHbhDw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="384620793"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="384620793"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:25:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="741029753"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="741029753"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 22 Sep 2023 02:25:54 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjcQ4-0000TB-1h;
        Fri, 22 Sep 2023 09:25:52 +0000
Date:   Fri, 22 Sep 2023 17:25:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     WANG Xuerui <git@xen0n.name>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>
Subject: arch/loongarch/include/asm/percpu.h:20:4: error: #error compiler
 support for the model attribute is necessary when a recent assembler is used
Message-ID: <202309221713.iTLkJPrI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27bbf45eae9ca98877a2d52a92a188147cd61b07
commit: 38b10b269d04540aee05c34a059dcf304cfce0a8 LoongArch: Tweak CFLAGS for Clang compatibility
date:   3 months ago
config: loongarch-loongson3_defconfig (https://download.01.org/0day-ci/archive/20230922/202309221713.iTLkJPrI-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230922/202309221713.iTLkJPrI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309221713.iTLkJPrI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/percpu.h:12,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from sound/pci/bt87x.c:11:
>> arch/loongarch/include/asm/percpu.h:20:4: error: #error compiler support for the model attribute is necessary when a recent assembler is used
      20 | #  error compiler support for the model attribute is necessary when a recent assembler is used
         |    ^~~~~


vim +20 arch/loongarch/include/asm/percpu.h

    10	
    11	/*
    12	 * The "address" (in fact, offset from $r21) of a per-CPU variable is close to
    13	 * the loading address of main kernel image, but far from where the modules are
    14	 * loaded. Tell the compiler this fact when using explicit relocs.
    15	 */
    16	#if defined(MODULE) && defined(CONFIG_AS_HAS_EXPLICIT_RELOCS)
    17	# if __has_attribute(model)
    18	#  define PER_CPU_ATTRIBUTES __attribute__((model("extreme")))
    19	# else
  > 20	#  error compiler support for the model attribute is necessary when a recent assembler is used
    21	# endif
    22	#endif
    23	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
