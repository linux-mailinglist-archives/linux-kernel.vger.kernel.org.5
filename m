Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09F27DA95D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 22:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjJ1U4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 16:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1U4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 16:56:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31A9B8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 13:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698526603; x=1730062603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2xdmOX1+nYScj0V27GtRPbDInoXKHqK1zJN9coZYscc=;
  b=D617wmcMboMR9JrcNL/kziIAVnEIgLyqYGuJB/yPm8oXmVaMC88d6SJ9
   A+8pY5XN2OZY0ujhPzkNDGwyu2lPDTxuXSwpXdnAXuI/3Sa1Asw0yFO4L
   OFpbZCTDSv+/4QBKwEpJC7pA5P6On76LKHKVYNJLEbgeOFnI1axwDg3+8
   aPWWmXubqm5S+oCWaNUyYfI1YxAbB/KsaWxabEfcvn4LL/KQKZNZcIhr5
   nQWHp12eEokFzA0zyhIrWKgZRrxCKvvru+8K0fkRU1fHbkwQWeOG32qKM
   3lDgunriEqZiApZ7+tiHjd+kE1r65G5jKEOEMUyYDXXqQFsMh3LyZrxjX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="452168104"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="452168104"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 13:56:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="1106760"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2023 13:56:02 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwqMG-000C4y-38;
        Sat, 28 Oct 2023 20:56:36 +0000
Date:   Sun, 29 Oct 2023 04:56:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baojun Xu <baojun.xu@ti.com>, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz
Cc:     oe-kbuild-all@lists.linux.dev,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kevin-lu@ti.com,
        shenghao-ding@ti.com, baojun.xu@ti.com, peeyush@ti.com,
        navada@ti.com, tiwai@suse.de
Subject: Re: [PATCH v3] ASoC: tas2783: Add source files for tas2783 driver.
Message-ID: <202310290433.ay15yHii-lkp@intel.com>
References: <20231028092409.96813-1-baojun.xu@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028092409.96813-1-baojun.xu@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baojun,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-sound/for-next]
[also build test ERROR on linus/master v6.6-rc7 next-20231027]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baojun-Xu/ASoC-tas2783-Add-source-files-for-tas2783-driver/20231028-172643
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20231028092409.96813-1-baojun.xu%40ti.com
patch subject: [PATCH v3] ASoC: tas2783: Add source files for tas2783 driver.
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20231029/202310290433.ay15yHii-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231029/202310290433.ay15yHii-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310290433.ay15yHii-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `__kernel_entry':
   (.text+0x0): relocation truncated to fit: R_MIPS_26 against `kernel_entry'
   arch/mips/kernel/head.o: in function `smp_bootstrap':
   (.ref.text+0xd8): relocation truncated to fit: R_MIPS_26 against `start_secondary'
   init/main.o: in function `set_reset_devices':
   main.c:(.init.text+0x10): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x18): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `debug_kernel':
   main.c:(.init.text+0x50): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x58): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `quiet_kernel':
   main.c:(.init.text+0x90): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0x98): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `warn_bootconfig':
   main.c:(.init.text+0xd0): relocation truncated to fit: R_MIPS_26 against `_mcount'
   main.c:(.init.text+0xd8): relocation truncated to fit: R_MIPS_26 against `__sanitizer_cov_trace_pc'
   init/main.o: in function `init_setup':
   main.c:(.init.text+0x108): additional relocation overflows omitted from the output
   mips-linux-ld: sound/soc/codecs/tas2783-sdw.o: in function `tas2783_calibration.isra.0':
>> tas2783-sdw.c:(.text.tas2783_calibration.isra.0+0x50): undefined reference to `efi'
>> mips-linux-ld: tas2783-sdw.c:(.text.tas2783_calibration.isra.0+0x80): undefined reference to `efi'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
