Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716397AC3BE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 18:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjIWQiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 12:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjIWQh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 12:37:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2667E92
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695487072; x=1727023072;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/U0BBXUGSXtYBRVUuDYHEmPFSBC8+/HGXI9RvbTCa6Y=;
  b=GUk6V+kOynR8bb8guSH0bMGZpiSeG1DDlO9gluQsYSLvr+n3YnRAbFbq
   841YJ1/WHWYvPgdlqyG4sv4zcKZeef0Oo675jhe7DSjJ795CzL6cU3HQs
   J2J72Eet3Sk2kzkDOGWGe4eevTKZVBVgn91etFrlzPIExKQ2Ys+Czf/6B
   Wz6qGqTRtBbxB1P04p7smEFTCO7hKQmFdHJOHlXH4L20aROcLGOfakX4D
   eu+Tnt/O2y/pdS3+DLagBacW4Zi2q/fkHiuZOOrfS2cRAwm9uNxNM8zmC
   rYZh1sBVctQP9mp3vyhuV9uDbkbkzh1iIGgLEz12siupTIn2VGkAj3RFh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="380943008"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="380943008"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 09:37:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="921517636"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="921517636"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 23 Sep 2023 09:37:50 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qk5dc-0002dW-0L;
        Sat, 23 Sep 2023 16:37:48 +0000
Date:   Sun, 24 Sep 2023 00:37:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rich Felker <dalias@libc.org>
Subject: arch/sh/boards/mach-landisk/setup.c:86:9: error: implicit
 declaration of function '__set_io_port_base'
Message-ID: <202309240004.TQItBMlc-lkp@intel.com>
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
head:   d90b0276af8f25a0b8ae081a30d1b2a61263393b
commit: 0c64a0dce51faa9c706fdf1f957d6f19878f4b81 sh: landisk: Add missing initialization of sh_io_port_base
date:   3 years, 1 month ago
config: sh-randconfig-r021-20220916 (https://download.01.org/0day-ci/archive/20230924/202309240004.TQItBMlc-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309240004.TQItBMlc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309240004.TQItBMlc-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sh/boards/mach-landisk/setup.c: In function 'landisk_setup':
>> arch/sh/boards/mach-landisk/setup.c:86:9: error: implicit declaration of function '__set_io_port_base' [-Werror=implicit-function-declaration]
      86 |         __set_io_port_base(0);
         |         ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/__set_io_port_base +86 arch/sh/boards/mach-landisk/setup.c

    82	
    83	static void __init landisk_setup(char **cmdline_p)
    84	{
    85		/* I/O port identity mapping */
  > 86		__set_io_port_base(0);
    87	
    88		/* LED ON */
    89		__raw_writeb(__raw_readb(PA_LED) | 0x03, PA_LED);
    90	
    91		printk(KERN_INFO "I-O DATA DEVICE, INC. \"LANDISK Series\" support.\n");
    92		pm_power_off = landisk_power_off;
    93	}
    94	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
