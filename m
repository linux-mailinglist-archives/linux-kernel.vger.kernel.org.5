Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051C380F59E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjLLSnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjLLSnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:43:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934A1BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702406629; x=1733942629;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IEO21lVidRSfn1FGhr1zGlPze/gGm/qWc0vGuIIGC+M=;
  b=bklKpxwtJqVZr2OlbNZLuAcueQWD/mbh1HaZusr0B8Fl/11McuqUv3UP
   PF+u1rCTis1c0cUIJE2NlexN/HrJwcWniSPDLo0Wzr0gFv2viGs/vVwEA
   vdqhby6x5jBKAM+P+AOpPgaS9CYY1QH1uDUG+obzEMeu6shBO92QHcw4/
   9iH/fCywGrDw68QdsFyebEARUlobekIksYxLvG03OA2imo+Fu0uzaV3W9
   fPTpnltC5SHiikjZCSK6eJfNNw9XM7E0a/tRV6DN4iJJd0xRQXc0PZ3C9
   jcCBvHy5kKAz0Z5qSAM0eU+YRSbfLKLbXhL4EMEDa7ZSbgnNfeCwCSd1L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="459170517"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="459170517"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 10:43:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="844008949"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="844008949"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2023 10:43:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rD7jN-000JZa-0W;
        Tue, 12 Dec 2023 18:43:45 +0000
Date:   Wed, 13 Dec 2023 02:43:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: arch/mips/include/asm/mips-cpc.h:153:1: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202312130247.3Zy1HRN6-lkp@intel.com>
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
head:   26aff849438cebcd05f1a647390c4aa700d5c0f1
commit: d15155824c5014803d91b829736d249c500bdda6 linux/compiler.h: Split into compiler.h and compiler_types.h
date:   6 years ago
config: mips-randconfig-r122-20231108 (https://download.01.org/0day-ci/archive/20231213/202312130247.3Zy1HRN6-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231213/202312130247.3Zy1HRN6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312130247.3Zy1HRN6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/mips/kernel/smp-cps.c: note: in included file (through arch/mips/include/asm/mips-cps.h, arch/mips/include/asm/smp-ops.h, arch/mips/include/asm/smp.h, ...):
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:295:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:295:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:295:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:295:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:295:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:295:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:295:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:295:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:295:1: sparse:     got void [noderef] __iomem *
   arch/mips/kernel/smp-cps.c: note: in included file (through arch/mips/include/asm/mips-cps.h, arch/mips/include/asm/smp-ops.h, arch/mips/include/asm/smp.h, ...):
>> arch/mips/include/asm/mips-cpc.h:153:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     got void *
>> arch/mips/include/asm/mips-cpc.h:153:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     got void *
>> arch/mips/include/asm/mips-cpc.h:153:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     got void *
>> arch/mips/include/asm/mips-cpc.h:153:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     got void *
   arch/mips/include/asm/mips-cpc.h:153:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     expected void *
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cpc.h:153:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     expected void *
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cpc.h:153:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     expected void *
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cpc.h:153:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     expected void *
   arch/mips/include/asm/mips-cpc.h:153:1: sparse:     got void [noderef] __iomem *
   arch/mips/kernel/smp-cps.c: note: in included file (through arch/mips/include/asm/mips-cps.h, arch/mips/include/asm/smp-ops.h, arch/mips/include/asm/smp.h, ...):
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:134:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:134:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:134:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:134:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:134:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:134:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:134:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:134:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:155:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:155:1: sparse:     got void [noderef] __iomem *
   arch/mips/include/asm/mips-cm.h:134:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:134:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:134:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:134:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mips-cm.h:134:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:134:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] __iomem * @@
--
   drivers/gpu/drm/drm_bufs.c:213:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *handle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/drm_bufs.c:213:45: sparse:     expected void *handle
   drivers/gpu/drm/drm_bufs.c:213:45: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/drm_bufs.c:216:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *handle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/drm_bufs.c:216:45: sparse:     expected void *handle
   drivers/gpu/drm/drm_bufs.c:216:45: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/drm_bufs.c:331:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *handle @@
   drivers/gpu/drm/drm_bufs.c:331:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/drm_bufs.c:331:36: sparse:     got void *handle
   drivers/gpu/drm/drm_bufs.c:348:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *handle @@
   drivers/gpu/drm/drm_bufs.c:348:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/drm_bufs.c:348:36: sparse:     got void *handle
   drivers/gpu/drm/drm_bufs.c:514:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *handle @@
   drivers/gpu/drm/drm_bufs.c:514:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/drm_bufs.c:514:28: sparse:     got void *handle
   In file included from include/linux/workqueue.h:8,
                    from include/linux/srcu.h:34,
                    from include/linux/notifier.h:15,
                    from include/linux/memory_hotplug.h:6,
                    from include/linux/mmzone.h:779,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:14,
                    from drivers/gpu/drm/drm_bufs.c:32:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:178:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     178 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                              ^
   include/linux/timer.h:143:39: note: in definition of macro '__setup_timer'
     143 |                 (_timer)->function = (_fn);                             30-      |                                       ^~~
   drivers/gpu/drm/drm_bufs.c:125: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Core function to create a range of memory available for mapping by a
   drivers/gpu/drm/drm_bufs.c:379: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Ioctl to specify a range of memory that is available for mapping by a
   drivers/gpu/drm/drm_bufs.c:480: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Remove a map private from list and deallocate resources if the mapping
   drivers/gpu/drm/drm_bufs.c:633: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Cleanup after an error on one of the addbufs() functions.
   drivers/gpu/drm/drm_bufs.c:668: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Add AGP buffers for DMA transfers.
   drivers/gpu/drm/drm_bufs.c:1204: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Add buffers for DMA transfers (ioctl).
   drivers/gpu/drm/drm_bufs.c:1245: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Get information about the buffer mappings.
   drivers/gpu/drm/drm_bufs.c:1333: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Specifies a low and high water mark for buffer allocation
   drivers/gpu/drm/drm_bufs.c:1382: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Unreserve the buffers in list, previously reserved using drmDMA.
   drivers/gpu/drm/drm_bufs.c:1451: warning: Function parameter or member 'dev' not described in '__drm_legacy_mapbufs'
   drivers/gpu/drm/drm_bufs.c:1451: warning: Function parameter or member 'data' not described in '__drm_legacy_mapbufs'
   drivers/gpu/drm/drm_bufs.c:1451: warning: Function parameter or member 'p' not described in '__drm_legacy_mapbufs'
   drivers/gpu/drm/drm_bufs.c:1451: warning: Function parameter or member 'v' not described in '__drm_legacy_mapbufs'
   drivers/gpu/drm/drm_bufs.c:1451: warning: Function parameter or member 'f' not described in '__drm_legacy_mapbufs'
   drivers/gpu/drm/drm_bufs.c:1451: warning: Function parameter or member 'file_priv' not described in '__drm_legacy_mapbufs'
   drivers/gpu/drm/drm_bufs.c:1451: warning: expecting prototype for Maps all of the DMA buffers into client(). Prototype was for __drm_legacy_mapbufs() instead
--
   drivers/gpu/drm/drm_memory.c:128:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *handle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/drm_memory.c:128:29: sparse:     expected void *handle
   drivers/gpu/drm/drm_memory.c:128:29: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/drm_memory.c:137:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *handle @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/drm_memory.c:137:29: sparse:     expected void *handle
   drivers/gpu/drm/drm_memory.c:137:29: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/drm_memory.c:149:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *handle @@
   drivers/gpu/drm/drm_memory.c:149:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/drm_memory.c:149:28: sparse:     got void *handle
   In file included from include/linux/workqueue.h:8,
                    from include/linux/mm_types.h:15,
                    from include/linux/fs.h:21,
                    from include/linux/highmem.h:4,
                    from drivers/gpu/drm/drm_memory.c:36:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:178:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     178 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                              ^
   include/linux/timer.h:143:39: note: in definition of macro '__setup_timer'
     143 |                 (_timer)->function = (_fn);                             21-      |                                       ^~~
   drivers/gpu/drm/drm_memory.c:2: warning: Cannot understand  * file drm_memory.c
    on line 2 - I thought it was a doc line
--
>> drivers/gpu/drm/drm_vm.c:265:44: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void *handle @@
   drivers/gpu/drm/drm_vm.c:265:44: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/gpu/drm/drm_vm.c:265:44: sparse:     got void *handle
   drivers/gpu/drm/drm_vm.c:476:51: sparse: sparse: undefined identifier '_PAGE_RW'
   drivers/gpu/drm/drm_vm.c:560:51: sparse: sparse: undefined identifier '_PAGE_RW'
   In file included from include/linux/workqueue.h:8,
                    from include/linux/srcu.h:34,
                    from include/linux/notifier.h:15,
                    from include/linux/memory_hotplug.h:6,
                    from include/linux/mmzone.h:779,
                    from include/linux/gfp.h:5,
                    from include/linux/idr.h:16,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:15,
                    from include/linux/kobject.h:21,
                    from include/linux/cdev.h:4,
                    from include/drm/drmP.h:36,
                    from drivers/gpu/drm/drm_vm.c:36:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:178:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
     178 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                              ^
   include/linux/timer.h:143:39: note: in definition of macro '__setup_timer'
     143 |                 (_timer)->function = (_fn);                             25-      |                                       ^~~
   drivers/gpu/drm/drm_vm.c: In function 'drm_mmap_locked':
   drivers/gpu/drm/drm_vm.c:575:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
     575 |                 if (dev->agp && dev->agp->cant_use_aperture) {
         |                    ^
   drivers/gpu/drm/drm_vm.c:589:9: note: here
     589 |         case _DRM_FRAME_BUFFER:
         |         ^~~~
   drivers/gpu/drm/drm_vm.c:612:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
     612 |                 vma->vm_page_prot = drm_dma_prot(map->type, vma);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/drm_vm.c:614:9: note: here
     614 |         case _DRM_SHM:
         |         ^~~~
   drivers/gpu/drm/drm_vm.c:2: warning: Cannot understand  * file drm_vm.c
    on line 2 - I thought it was a doc line
   drivers/gpu/drm/drm_vm.c:93: warning: Cannot understand  * c fault method for AGP virtual memory.
    on line 93 - I thought it was a doc line
   drivers/gpu/drm/drm_vm.c:183: warning: Cannot understand  * c nopage method for shared virtual memory.
    on line 183 - I thought it was a doc line
   drivers/gpu/drm/drm_vm.c:216: warning: Cannot understand  * c close method for shared virtual memory.
    on line 216 - I thought it was a doc line
   drivers/gpu/drm/drm_vm.c:287: warning: Cannot understand  * c fault method for DMA virtual memory.
    on line 287 - I thought it was a doc line
   drivers/gpu/drm/drm_vm.c:322: warning: Cannot understand  * c fault method for scatter-gather virtual memory.
    on line 322 - I thought it was a doc line
   drivers/gpu/drm/drm_vm.c:428: warning: Cannot understand  * c close method for all virtual memory types.
    on line 428 - I thought it was a doc line
   drivers/gpu/drm/drm_vm.c:446: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * mmap DMA memory.
   drivers/gpu/drm/drm_vm.c:506: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * mmap DMA memory.

vim +153 arch/mips/include/asm/mips-cpc.h

9c38cf44712af9 Paul Burton 2014-01-15  151  
23cb600e3fd406 Paul Burton 2017-08-12  152  /* CPC_Cx_CONFIG - Mirrors GCR_Cx_CONFIG */
23cb600e3fd406 Paul Burton 2017-08-12 @153  CPC_CX_ACCESSOR_RW(32, 0x090, config)
23cb600e3fd406 Paul Burton 2017-08-12  154  

:::::: The code at line 153 was first introduced by commit
:::::: 23cb600e3fd4068697d6fa207848d93e74ec7333 MIPS: CPS: Add CM/CPC 3.5 register definitions

:::::: TO: Paul Burton <paul.burton@imgtec.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
