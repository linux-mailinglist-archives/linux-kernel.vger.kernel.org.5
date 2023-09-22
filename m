Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48067AB486
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjIVPNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjIVPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:13:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB834100
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695395619; x=1726931619;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6as250FBlZwcBEVHGkKBKuBwXCf/x9I0ugw7kYM2uU4=;
  b=LJ4AWhH/T374IqWsWM0cv7pV29w3ahSbZ4vyurtQsPrNcj4urdLCWH0d
   sfTxDzCx1sc5hAB8g/haAljHWj3A81qSCfyysweJLAGh6HAHKvf9itgAV
   EdVjfgcSSvr6FL9wXBcqvOpXS7jx5Sj1q5W7eXQZphU6tTtR9sHlULyLp
   Wi3xUQNxuqVhWfoVkIeZlyoOpAtatbwtpiuFz/JmHI/rLjJN95MgKJI/O
   HC3PLCMOfahK6Wdh6FpH+r9cI7sSJbYdlDvzw1iOiaVnto1SbGrsHYbmK
   uKopVViEb9M54QquC1DctyfvwKl+UvIvEIDfButBSfAE8acxakFkiBY8i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="444948739"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="444948739"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 08:13:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="741130120"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="741130120"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 22 Sep 2023 08:13:31 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjhqT-0000sb-0o;
        Fri, 22 Sep 2023 15:13:29 +0000
Date:   Fri, 22 Sep 2023 23:12:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: {standard input}:1198: Error: value of ffffff6c too large for field
 of 1 byte at 00000533
Message-ID: <202309222350.hCUFrIQ1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27bbf45eae9ca98877a2d52a92a188147cd61b07
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   9 weeks ago
config: m68k-randconfig-r025-20230123 (https://download.01.org/0day-ci/archive/20230922/202309222350.hCUFrIQ1-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230922/202309222350.hCUFrIQ1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309222350.hCUFrIQ1-lkp@intel.com/

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
   {standard input}:1198: Error: value -148 out of range
>> {standard input}:1198: Error: value of ffffff6c too large for field of 1 byte at 00000533

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
