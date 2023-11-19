Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52D7F03C8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 01:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjKSAZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 19:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKSAZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 19:25:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5EF131
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 16:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700353547; x=1731889547;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xe7/oYrFAzeKbvmIbj20khlDsQwQANsaoH/Og4XQSII=;
  b=QzrgBgHmlv+55023GEanlD8xH7I11uxiIUN679q4o7B4G8EDmJg51B5c
   sMNInbUXM+MX07jiOsaPtMSgyX4Jbog9ZDPrl214mc/WsnOURoHDX7YF3
   2upfmEASQkPUZ606KRshVXHS4t0TWf52TXCXLlMCwAJDZAXfieRCpKguL
   bjugz7A9fJ7nTnZ1bHPM8WGr0A8eOMmp8q/6gCns1h6c8GMFpAi0Zf0xv
   WjVgSOaDnEA7hTWAJB7VG9zIGeIJhfJZhu+J8qyB5tzkwWqsNy10KUEvt
   rlR1kHH154OZnFjtcBUE9wFX8mipNwKiNGN/JTE7mUhAs5Pzjw67Gq4nV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="388609731"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="388609731"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 16:25:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="795141615"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="795141615"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Nov 2023 16:25:45 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Vd8-0004T9-1g;
        Sun, 19 Nov 2023 00:25:42 +0000
Date:   Sun, 19 Nov 2023 08:24:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: kismet: WARNING: unmet direct dependencies detected for ADB_CUDA
 when selected by PPC_PMAC
Message-ID: <202311190853.4Bo76T6U-lkp@intel.com>
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
head:   b8f1fa2419c19c81bc386a6b350879ba54a573e1
commit: a3ef2fef198c25c1d9ac6ff89fd50230e9507207 powerpc/32: Add dependencies of POWER_RESET for pmac32
date:   9 weeks ago
config: powerpc-kismet-CONFIG_ADB_CUDA-CONFIG_PPC_PMAC-0-0 (https://download.01.org/0day-ci/archive/20231119/202311190853.4Bo76T6U-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231119/202311190853.4Bo76T6U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311190853.4Bo76T6U-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for ADB_CUDA when selected by PPC_PMAC
   
   WARNING: unmet direct dependencies detected for ADB_CUDA
     Depends on [n]: MACINTOSH_DRIVERS [=n] && (ADB [=n] || PPC_PMAC [=y]) && !PPC_PMAC64 [=n]
     Selected by [y]:
     - PPC_PMAC [=y] && PPC_BOOK3S [=y] && CPU_BIG_ENDIAN [=y] && POWER_RESET [=y] && PPC32 [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
