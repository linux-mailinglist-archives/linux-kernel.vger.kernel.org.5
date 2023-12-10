Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3882080B951
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjLJGga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 01:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjLJGg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 01:36:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9479C1BB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 22:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702190193; x=1733726193;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wtaW89UM9RckN1fUT98Fx+IUAET44dhNHfswr76Kb8s=;
  b=MII8ffH1/7KZIVQUM9gF3L/S08CLjsYPXHJDKjhvHr8xFp+kRWVSWFF9
   8MfL3ntfLNgtzt12RoFURrgezfcVvFqGUzBgpEm89mG4pnFf52v7J6aAW
   komYpv24dXR5jk3/rDsqiF7zCF9fJwLpVWwNexebsygQWAgBNNgqFstz/
   AFLh/kPoATXEU8mq4tRsX4FjBhdJBkN4xhFXFKgrIRZ8gJp0NQJkTH4nL
   0zKjYQA7df7bFLHfFmy0uI4OTg+ejrJTUQ7cLozQPrhbKb0yTaFKsSaM7
   qh7wdnGxcI0/Nz0bJmun9A8/cBtHIhzGARDqXKmhJeLadybM9tEMr7Ed+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="1412871"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="1412871"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 22:36:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748818161"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748818161"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2023 22:36:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCDQS-000GTv-3D;
        Sun, 10 Dec 2023 06:36:28 +0000
Date:   Sun, 10 Dec 2023 14:35:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>
Subject: powerpc-linux-ld: warning: orphan section `.init.plt' from
 `drivers/hid/hid-uclogic-rdesc.o' being placed in section `.init.plt'
Message-ID: <202312101402.A4EgFTn7-lkp@intel.com>
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
commit: 08809e482a1c44d95d1322b9fbc94c8e58ae9015 HID: uclogic: KUnit best practices and naming conventions
date:   1 year, 4 months ago
config: powerpc-randconfig-r052-20231210 (https://download.01.org/0day-ci/archive/20231210/202312101402.A4EgFTn7-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312101402.A4EgFTn7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312101402.A4EgFTn7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.init.plt' from `drivers/hid/hid-uclogic-rdesc.o' being placed in section `.init.plt'
   powerpc-linux-ld: warning: drivers/of/unittest-data/overlay_gpio_04b.dtb.o: missing .note.GNU-stack section implies executable stack
   powerpc-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   powerpc-linux-ld: block/blk-iocost.o: in function `ioc_refresh_params.isra.0':
   blk-iocost.c:(.text+0x1b5c): undefined reference to `__udivdi3'
   powerpc-linux-ld: block/blk-iocost.o: in function `transfer_surpluses':
   blk-iocost.c:(.text+0x3cd4): undefined reference to `__udivdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
