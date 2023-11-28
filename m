Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B467FBBB3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345459AbjK1Ngt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345922AbjK1Ngq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:36:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B75610EC;
        Tue, 28 Nov 2023 05:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701178611; x=1732714611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jJ9Pn7GCzs4O8oxUA7N3FdeyLvZkwkc1tJNo8CJGWFs=;
  b=VLqMm8Ghbvy8pvkegUV+2JDH0Z1pD7FNSQDu2F4kgZC7eyy/IsO78Ff3
   RNCHU/6svp2qPANu0KaQEPQlaNq4E4qhd0BMCEijkzsBYJC8K5/Rq9Zed
   pHkDu6RilPYaRlpn09zB64aD8r1yruRahUbcCh3AUvWDlG4GFT97Q5J9V
   SjZqdhVKAogshnyCvuzfodCQTVZO36UYZAdOx5VY65ze+PmxpLHeSBPZU
   DyL3QGyBrvWJ5UO2QUlQwQPLWPBg4OUjowosVz7OXBO+4lZwj+2p13+yY
   pDt6PyiwxKgz/31lRyPxOlpOW0n/rvmhS04TYJMCuq56l6g/TPFavzpMO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="14484673"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="14484673"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 05:36:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="1100100561"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="1100100561"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 28 Nov 2023 05:36:48 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r7yGc-0007bU-2O;
        Tue, 28 Nov 2023 13:36:46 +0000
Date:   Tue, 28 Nov 2023 21:36:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
        reibax@gmail.com, davem@davemloft.net, rrameshbabu@nvidia.com
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maheshb@google.com,
        maimon.sagi@gmail.com
Subject: Re: [PATCH v2] posix-timers: add multi_clock_gettime system call
Message-ID: <202311282046.3hMwdKes-lkp@intel.com>
References: <20231127153901.6399-1-maimon.sagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127153901.6399-1-maimon.sagi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on tip/timers/core linus/master v6.7-rc3]
[cannot apply to tip/x86/asm next-20231128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Maimon/posix-timers-add-multi_clock_gettime-system-call/20231128-000215
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20231127153901.6399-1-maimon.sagi%40gmail.com
patch subject: [PATCH v2] posix-timers: add multi_clock_gettime system call
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231128/202311282046.3hMwdKes-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231128/202311282046.3hMwdKes-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311282046.3hMwdKes-lkp@intel.com/

All warnings (new ones prefixed by >>):

   <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>> <stdin>:1585:2: warning: #warning syscall multi_clock_gettime not implemented [-Wcpp]
--
   kernel/time/posix-timers.c: In function '__do_sys_multi_clock_gettime':
>> kernel/time/posix-timers.c:1458:1: warning: the frame size of 2004 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1458 | }
         | ^
   kernel/time/posix-timers.c: In function '__do_sys_multi_clock_gettime32':
   kernel/time/posix-timers.c:1489:1: warning: the frame size of 2004 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1489 | }
         | ^
--
   <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>> <stdin>:1585:2: warning: #warning syscall multi_clock_gettime not implemented [-Wcpp]
--
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>> <stdin>:1585:2: warning: #warning syscall multi_clock_gettime not implemented [-Wcpp]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
