Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC50761020
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjGYKDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjGYKDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:03:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FFA212A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690279358; x=1721815358;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fZ2HNuI9cgHE0ChE7bdJgutkhB7O1yi1yHGSmKUhE64=;
  b=EZVO2IX5WQDWj95orb7P1MI9mfm+IL29z9DaptMRrr8iQqUxNQa0SS9j
   hwhiJSZ5wX/oCfSbSPWvXZDOs6XMrti92fST2mDL7ztqZLTmanqeqEfMN
   QyJppuj1HSlQmOeAj4l3LPOxoIB2S8YZOax5XlMEeodZWUeYdtJXOpJ3Q
   BHylK9mUsjT+JiLGDW4eeTix43ZQv8PcX/Uo1Q9/q7f6F5FuipHpRDOjC
   LMbDZdgX9VChsk4YnI7HCq4ZS8ORb5jMAwxWfXZDiXEun6V4UgbarM5/L
   l/5JGy6291QZgs1KMtS2XroathjrjihHXCfEMX/ozEst/4VaQmWLsc5u3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="366558530"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="366558530"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 03:02:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="972607891"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972607891"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2023 03:02:30 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOEs9-000AWf-2Q;
        Tue, 25 Jul 2023 10:02:29 +0000
Date:   Tue, 25 Jul 2023 18:01:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: pwm-rz-mtu3.c:undefined reference to `clk_rate_exclusive_put'
Message-ID: <202307251752.vLfmmhYm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0b5547c51827e053cc754db47d3ec3e6c2c451d2
commit: 254d3a727421ccc935f085eaa9bae51cb6c9df25 pwm: Add Renesas RZ/G2L MTU3a PWM driver
date:   5 weeks ago
config: m68k-randconfig-r035-20230725 (https://download.01.org/0day-ci/archive/20230725/202307251752.vLfmmhYm-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307251752.vLfmmhYm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307251752.vLfmmhYm-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: section .rodata VMA [00002000,009a764f] overlaps section .text VMA [00000400,012a124f]
   m68k-linux-ld: drivers/pwm/pwm-rz-mtu3.o: in function `rz_mtu3_pwm_pm_disable':
>> pwm-rz-mtu3.c:(.text+0x114): undefined reference to `clk_rate_exclusive_put'
   m68k-linux-ld: drivers/pwm/pwm-rz-mtu3.o: in function `rz_mtu3_pwm_probe':
>> pwm-rz-mtu3.c:(.text+0x32c): undefined reference to `clk_rate_exclusive_get'
>> m68k-linux-ld: pwm-rz-mtu3.c:(.text+0x380): undefined reference to `clk_rate_exclusive_put'
   m68k-linux-ld: pwm-rz-mtu3.c:(.text+0x400): undefined reference to `clk_rate_exclusive_put'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
