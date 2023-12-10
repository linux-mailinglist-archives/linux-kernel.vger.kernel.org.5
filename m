Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16B480BA03
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 10:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjLJJ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 04:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjLJJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 04:29:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292ACC5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 01:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702200580; x=1733736580;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/DTbFwW2w81UfDAshjf96AoO2doTCHGvtPmSFuJKCoE=;
  b=EoU5Don51G6SzDyhnnoE3NtDWi7lIVTXI7qygoTl9t/uQVAg+LPeZqN4
   f/Ua+H0HHI4iyCG0LzyOnugSDiVqD6yST9UwwVMyZjndffZypPP6cLuoX
   I4K/mG3k4o3jdEjOhlkLHaCkpLtM11BSBNTlw81ZGeIFXEn5nqcr108fZ
   knVM9YVWbovUIeoWo61E7E+2LLuP2FDnrQjz3aUP6Q3++77CbsuZKOaDj
   0d7fXZ4/HZrtPPAM1nLBBvU4q5bHdPyJwebFu2YsHbkM9SzvSCPXEnKwt
   7aGsI4CLHaIhU5W0DcbzWHm1bJMeJGDFrJRRLL4LzRQzSjWTlBw9Xkw4s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="393411294"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="393411294"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 01:29:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="772626128"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="772626128"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2023 01:29:38 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCG80-000Gf4-0L;
        Sun, 10 Dec 2023 09:29:36 +0000
Date:   Sun, 10 Dec 2023 17:29:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data3' from
 `drivers/mtd/nand/raw/diskonchip.o' being placed in section
 `.bss..Lubsan_data3'
Message-ID: <202312101759.4FggPZcP-lkp@intel.com>
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
head:   c527f5606aa545233a4d2c6d5c636ed82b8633ef
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   11 months ago
config: powerpc-randconfig-r016-20230107 (https://download.01.org/0day-ci/archive/20231210/202312101759.4FggPZcP-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312101759.4FggPZcP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312101759.4FggPZcP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data3' from `drivers/mtd/nand/raw/diskonchip.o' being placed in section `.bss..Lubsan_data3'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data3' from `drivers/mtd/nand/raw/diskonchip.o' being placed in section `.bss..Lubsan_data3'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data3' from `drivers/mtd/nand/raw/diskonchip.o' being placed in section `.bss..Lubsan_data3'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data3' from `drivers/mtd/nand/raw/diskonchip.o' being placed in section `.bss..Lubsan_data3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
