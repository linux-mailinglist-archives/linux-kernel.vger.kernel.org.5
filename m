Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E30A7F339B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjKUQZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUQZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:25:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CCFCB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700583909; x=1732119909;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L9snDENl6Ku35vVsrKoshsx/cygBW4RDkKP7KeUhH8g=;
  b=T38vEP0l08dMfB4fwbC/nQSrXW/Yf9t3VqdrlmFkqp0/VsXV61y5V19T
   wBwuCBRWZE5syQyYGyXeBIjd4EQWiHd3YOhZLqRd7pIUACvjVa+7DqUyU
   QvxFahfqVo48mijg4AmOrnCvSW3e7Sbh4zvUC3F/tk+F2OI6Xec4Hh4ey
   XEnqrNTGdzF00yUfsCDcdkNYU+naJBSgqtIS3OHGgq2hF0r1PXDRJ5LCE
   8BI7JN3oFNEW3q8yE3dbsi/Drm/cJ4aFaY30MqlS6FUQcH/hYc3r6HDRr
   qH/2M3t9wdky5GSPwNAkebVpnsFNHP4GO8+QW2IdjlBPGSUnjj1y7BmYi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="389023648"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="389023648"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 08:25:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="14951671"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2023 08:25:07 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5TYf-00081Q-1q;
        Tue, 21 Nov 2023 16:25:05 +0000
Date:   Wed, 22 Nov 2023 00:24:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: drivers/md/dm-zoned-reclaim.c:1: warning: no structured comments
 found
Message-ID: <202311220042.vAKxDlUW-lkp@intel.com>
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
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: 3b1a94c88b798d4f3bd1a5b61f5c8fb9d987c242 dm zoned: drive-managed zoned block device target
date:   6 years ago
config: i386-randconfig-011-20231120 (https://download.01.org/0day-ci/archive/20231122/202311220042.vAKxDlUW-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231122/202311220042.vAKxDlUW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220042.vAKxDlUW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/md/dm-zoned-reclaim.c:1: warning: no structured comments found
--
   arch/x86/include/asm/bitops.h: Assembler messages:
   arch/x86/include/asm/bitops.h:224: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
   arch/x86/include/asm/bitops.h:224: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
   arch/x86/include/asm/bitops.h:224: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
   arch/x86/include/asm/bitops.h:224: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
   arch/x86/include/asm/bitops.h:270: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
>> drivers/md/dm-zoned-metadata.c:1: warning: no structured comments found
--
>> drivers/md/dm-zoned-target.c:1: warning: no structured comments found


vim +1 drivers/md/dm-zoned-reclaim.c

   > 1	/*
     2	 * Copyright (C) 2017 Western Digital Corporation or its affiliates.
     3	 *
     4	 * This file is released under the GPL.
     5	 */
     6	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
