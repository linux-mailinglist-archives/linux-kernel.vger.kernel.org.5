Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389FB80B541
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 17:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjLIQgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 11:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLIQgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 11:36:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5AF10C9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 08:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702139807; x=1733675807;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6px28xq4dTv2hdDQeNq7ySIt5tpdO8edT6O3y40wlC4=;
  b=VOVx8ijnSz18KuadSvCMV2ZZn/8HpAqnxaekyCCmMMizRYIUa4ouls3j
   zJbTr5zhtFZQPQipQ9mu0oUrTrfk9z6D1NkDX8ljpBfltDyAmkHA0FX0T
   1IF7E2zPXmCZKv+uPeW9CCJ+jUEVCS+kcYyqDxkt0erzqVdNagbNFABq8
   sbR4lAPAPWPcu+pCO3NUBkCwa5uFAiUacvseXwpkSPZVZ/iyJxByOslz0
   KBh6e2y1soTWA2zEqAYmMolCj8ZlMZ3silSRZHgrIicg4q1CMiTROBHVs
   xgaJdiZ3Mm2ultBFzQ9Dq1Jcihj4cbrvmoKoBkG3bG/ZqGP5zs7Fye5Yo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480710974"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="480710974"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 08:36:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="838460849"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="838460849"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2023 08:36:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC0Jn-000Fcu-2d;
        Sat, 09 Dec 2023 16:36:43 +0000
Date:   Sun, 10 Dec 2023 00:36:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 __trace_event_discard_commit+0x17c (section: .text.unlikely) ->
 initcall_level_names (section: .init.data)
Message-ID: <202312100019.bDPk8Vy2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   5 months ago
config: xtensa-randconfig-r021-20220202 (https://download.01.org/0day-ci/archive/20231210/202312100019.bDPk8Vy2-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312100019.bDPk8Vy2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100019.bDPk8Vy2-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>> WARNING: modpost: vmlinux: section mismatch in reference: __trace_event_discard_commit+0x17c (section: .text.unlikely) -> initcall_level_names (section: .init.data)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
