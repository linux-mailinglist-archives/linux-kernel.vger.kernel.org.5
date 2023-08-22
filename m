Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830DD784BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjHVVML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjHVVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:12:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8621CD9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692738728; x=1724274728;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h47jyvY9KIJODj8/IDB8R3btLRf5d4FwKHGpYaDEhg0=;
  b=fe1huxw3UnSywdnt3l8d7b7mKWPguFzmNvUNi3/Qx4QXm82PMvFbfWTl
   3AWSliH4A3R5RWoyo65myJYl7m/G+KoVhRU3VBPWPM+PvEWgr/qpBJVGq
   MYGSd1y8o0SYjsr5y9FenoDkWgsvOHYI7JtFABSpnKBJsyhtayPto4TJk
   ZWe14kd422hb3eJHugimHgNDQiaU/hzxn2SifiPpyToEp7ULnQjx3Dn28
   eFizgkgpIpfvguVydbJGIfbc2gTWWRWDwZLfvYT4fobnRwnVVhYH9Ttc0
   fx/syQXS4VUURx4dDVyAm8HMydlQyEc4WPh7FkIaCrVsbwoo7ah8g/w63
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="404996605"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="404996605"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 14:12:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="736380540"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="736380540"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 22 Aug 2023 14:12:06 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYYfP-0000Wu-36;
        Tue, 22 Aug 2023 21:12:02 +0000
Date:   Wed, 23 Aug 2023 05:11:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: /usr/bin/ld: init/main.o: warning: relocation in read-only section
 `.init.text'
Message-ID: <202308230538.sIoFzSnM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f7757129e3dea336c407551c98f50057c22bb266
commit: 8c6174503c7b7134c22072b45f92724c8a959f06 um: hostfs: define our own API boundary
date:   4 months ago
config: um-randconfig-r036-20230822 (https://download.01.org/0day-ci/archive/20230823/202308230538.sIoFzSnM-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308230538.sIoFzSnM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308230538.sIoFzSnM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> /usr/bin/ld: init/main.o: warning: relocation in read-only section `.init.text'
   /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
   /usr/bin/ld: warning: creating DT_TEXTREL in a PIE
>> /usr/bin/ld: init/main.o: warning: relocation in read-only section `.init.text'
   /usr/bin/ld: warning: .tmp_vmlinux.kallsyms2 has a LOAD segment with RWX permissions
   /usr/bin/ld: warning: creating DT_TEXTREL in a PIE
>> /usr/bin/ld: init/main.o: warning: relocation in read-only section `.init.text'
   /usr/bin/ld: warning: vmlinux has a LOAD segment with RWX permissions
   /usr/bin/ld: warning: creating DT_TEXTREL in a PIE

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
