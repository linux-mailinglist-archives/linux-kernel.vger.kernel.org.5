Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E8C760DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjGYJBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjGYJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:01:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C41199B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690275664; x=1721811664;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tnxCFCV/aLbDw+NKc00oca3RQMIZA9zkZYTEMGwv4TU=;
  b=dbRQA7wErfEcqOk+Gk/FzHr2pvuG8uW5uN4y08hZTLhiOX+dubbjzNDx
   8VWODRzV8I+9++wr+XIRHDT92zmjM+RcBvu3oTHDj907XVVHzceAoEOYV
   HmysvvCr7kzkLxJ6KIdumLQ+mla3lhO+iwaMW9xNA6ddcPMBCmWwfJ3Zl
   iYQn3UjSfcQElEd16RZxUG+xyHEjVX2gTcYHpBcGEpq5LcZ81B+D7t8zP
   1OoUQ5Dpbs8/UgAmDCOQwwbqbVSR0GbNqpOwxd7rsXi85AaHWPfuVITAf
   Qk+/qrGWyPxTToLYiHtEoODjGjg1/JBKrNsKu3o9dNZbxRvCtE56GOFTX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="365121843"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="365121843"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:00:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="676158587"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="676158587"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2023 02:00:48 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qODuR-000ATc-1Y;
        Tue, 25 Jul 2023 09:00:47 +0000
Date:   Tue, 25 Jul 2023 17:00:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: drivers/clocksource/timer-loongson1-pwm.c:31:1: sparse: sparse:
 symbol 'ls1x_timer_lock' was not declared. Should it be static?
Message-ID: <202307251657.9eVSnR8x-lkp@intel.com>
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
commit: e738521a11f13e40af89f66527e59306c4169782 clocksource/drivers/loongson1: Move PWM timer to clocksource framework
date:   5 weeks ago
config: nios2-randconfig-r093-20230723 (https://download.01.org/0day-ci/archive/20230725/202307251657.9eVSnR8x-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307251657.9eVSnR8x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307251657.9eVSnR8x-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/clocksource/timer-loongson1-pwm.c:31:1: sparse: sparse: symbol 'ls1x_timer_lock' was not declared. Should it be static?

vim +/ls1x_timer_lock +31 drivers/clocksource/timer-loongson1-pwm.c

    30	
  > 31	DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
    32	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
