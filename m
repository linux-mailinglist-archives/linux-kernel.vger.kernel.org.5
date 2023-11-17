Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59BE7EF79A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjKQSyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQSyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:54:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4673390
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700247238; x=1731783238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XQJVq7U2QpOQsjvst6G++Mz561DJSYDLnGw/iqXE0Ec=;
  b=L3bpbXZx5Co94Ev4UEqCuiJmUAVJRJ+WK9TrgU6SPb2KKkp9Q/FRhe79
   GPsOqPesPN99wPKWx83VQ7qb8E9FFvtKQ/yBXNHn+SXGn8MTTQGUWvwBL
   w8W9IyzviG63bwjaW3+SmQOXmjZVZzT+otfDkp+khAVeo0ipP8rl7dVT6
   Ifyh4edLXW5K4Ia6wC0TjoXrTrPErs9iZnM3aJNwoiqli5WuAcjmCCuvz
   OmjnW5X+IHVkXDmnJJzK9uJTbNtA2fvSszx7qgYhLbwWtsAyyzCKSUauc
   pomReN4uR2JqDFCbY8dsqqAsb9RSJ0Y9Ul006bjKnsEB+vjLvmMIRq9qF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="422445084"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="422445084"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 10:53:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="6929406"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 17 Nov 2023 10:53:56 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r43yU-00033F-0X;
        Fri, 17 Nov 2023 18:53:54 +0000
Date:   Sat, 18 Nov 2023 02:53:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/m68k/sun3/sun3ints.c:33:13: sparse: sparse: cast truncates bits
 from constant value (ffffff7f becomes 7f)
Message-ID: <202311180254.il3eWGT9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc40e44f1ddef16a787f3501b97f1fff909177c
commit: 72e70a0e7ac7c422843eb8bbf192e820e9ccd24d m68k: sun3: Change led_pattern[] to unsigned char
date:   6 weeks ago
config: m68k-randconfig-r133-20231117 (https://download.01.org/0day-ci/archive/20231118/202311180254.il3eWGT9-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231118/202311180254.il3eWGT9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311180254.il3eWGT9-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/m68k/sun3/sun3ints.c: note: in included file (through include/linux/mmzone.h, include/linux/topology.h, include/linux/irq.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
>> arch/m68k/sun3/sun3ints.c:33:13: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)

vim +33 arch/m68k/sun3/sun3ints.c

    31	
    32	static unsigned char led_pattern[8] = {
  > 33		(u8)~(0x80), (u8)~(0x01),
    34		(u8)~(0x40), (u8)~(0x02),
    35		(u8)~(0x20), (u8)~(0x04),
    36		(u8)~(0x10), (u8)~(0x08)
    37	};
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
