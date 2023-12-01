Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683F980067E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377972AbjLAJEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377855AbjLAJEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:04:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB65128
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701421451; x=1732957451;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WCLNj8svC4av8QeeiaxxaFGMBsZIKM1ZQh1Rtc0PVbA=;
  b=d2Ts74PSo8Cf1HkeexsBh21Zz7GRCiQirMFnev4ZRH6fiTGWHqac7BpL
   EJHaVgnSUn0NmMMn7kHwQKHlPPaEE+Jx8c/gK8CvKfBhpFAwVyQDPXS/a
   ++aOOGb2On8U/14fSx3c88mny+T1lQsp7wvAQEIDT+wHbIzdJEkBf0TF/
   mi7PAg24DpWuBcDSRaXgAG+D5c6cLQqRZ1nIa14X8ay0km8DeWTSyEtAP
   u/OYV45eVtG/9ev+SnMihh70C/gEX/I32Cc6kbFzOrkv1T9xk/H3ZbRMs
   x2luiaY5DO3qhHyzprf//RZ/dc24LtIDC06vTzcHXKy6OKSkIgBHXARnL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="397357253"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="397357253"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 01:04:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="887571281"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="887571281"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 01 Dec 2023 01:04:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8zRO-0003N6-2l;
        Fri, 01 Dec 2023 09:04:06 +0000
Date:   Fri, 1 Dec 2023 17:03:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tim Bird <tim.bird@sonymobile.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: undefined reference to `_init'
Message-ID: <202312011721.kLbSzwWM-lkp@intel.com>
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
head:   994d5c58e50e91bb02c7be4a91d5186292a895c8
commit: 3ce51050fadd63737c03627293ca2dc4be238891 selftest: size: Add size test for Linux kernel
date:   9 years ago
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231201/202312011721.kLbSzwWM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312011721.kLbSzwWM-lkp@intel.com/

All errors (new ones prefixed by >>):

   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/libc.a(libc-start.o): in function `__libc_start_main_impl':
>> (.text+0x1938): undefined reference to `_init'
   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/libc.a(libc-start.o): in function `call_fini':
>> (.text+0x39): undefined reference to `_fini'
   /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/12/../../../x86_64-linux-gnu/libc.a(dl-reloc-static-pie.o): in function `_dl_relocate_static_pie':
>> (.text+0x2d): undefined reference to `_DYNAMIC'
   /usr/bin/ld: (.text+0x89): undefined reference to `_DYNAMIC'
   /usr/bin/ld: (.text+0x94): undefined reference to `_DYNAMIC'
>> collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
