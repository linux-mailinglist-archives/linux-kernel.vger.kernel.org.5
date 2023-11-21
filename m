Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2447E7F2402
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjKUCby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKUCbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:31:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEB39C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700533909; x=1732069909;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=baLNOK6OWoB6I0nKO7Av6CpZRL/Nkzz/JGpYp4rey/A=;
  b=dwlXhWNo2nr1ovJ3RzzIERoxrxsDWER6LSgBoF2Md5tlfuhXex2Yvs8u
   G7RxJIjAvHr+H/q/rSo96LV0643UzeUC5BYXhkB3JM4gxH9p0AfUDT4vx
   gvW8/AxvGnXv5HK1IoT5wbKBTXyevqDJJ6xylL5XL9mVIP1gNcXjGwjqi
   t3ksJYqpwCaDIceb8UMcbihWnHoKVqzWXs63oVbu4ZgAUh07Fv4hRhKuY
   NN2+vdNlkogHEqQ/46jeiTJH0Fju0oatCLAnGpkVDR2lCAadaHvmAVQHM
   wP/5vDEileanJKuAHMzcLm9VsqLCug+FT6yK076Q1xluFq0wK1KMVPWap
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371090755"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371090755"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:31:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="939959086"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="939959086"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2023 18:31:45 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5GYB-0007C0-1L;
        Tue, 21 Nov 2023 02:31:43 +0000
Date:   Tue, 21 Nov 2023 10:31:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: drivers/usb/gadget/function/f_uac1_legacy.c:1: warning: no
 structured comments found
Message-ID: <202311211052.RsFuk4Gr-lkp@intel.com>
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

Hi Ruslan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: d355339eecd986648420e05f8c958fbc78dbb382 usb: gadget: function: make current f_uac1 implementation legacy
date:   6 years ago
config: i386-randconfig-002-20231120 (https://download.01.org/0day-ci/archive/20231121/202311211052.RsFuk4Gr-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311211052.RsFuk4Gr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311211052.RsFuk4Gr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/gadget/function/f_uac1_legacy.c:1: warning: no structured comments found
--
>> drivers/usb/gadget/function/u_uac1_legacy.c:33: warning: No description found for parameter 'i'
>> drivers/usb/gadget/function/u_uac1_legacy.c:33: warning: No description found for parameter 'val'
>> drivers/usb/gadget/function/u_uac1_legacy.c:96: warning: No description found for parameter 'snd'
>> drivers/usb/gadget/function/u_uac1_legacy.c:156: warning: No description found for parameter 'card'
>> drivers/usb/gadget/function/u_uac1_legacy.c:156: warning: No description found for parameter 'buf'
>> drivers/usb/gadget/function/u_uac1_legacy.c:156: warning: No description found for parameter 'count'
   drivers/usb/gadget/function/u_uac1_legacy.c:205: warning: No description found for parameter 'card'
>> drivers/usb/gadget/function/u_uac1_legacy.c:265: warning: No description found for parameter 'gau'
   drivers/usb/gadget/function/u_uac1_legacy.c:294: warning: No description found for parameter 'card'
>> drivers/usb/gadget/function/u_uac1_legacy.c:311: warning: No description found for parameter 'the_card'


vim +1 drivers/usb/gadget/function/f_uac1_legacy.c

c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03  @1  /*
c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   2   * f_audio.c -- USB Audio class function driver
c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   3    *
c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   4   * Copyright (C) 2008 Bryan Wu <cooloney@kernel.org>
c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   5   * Copyright (C) 2008 Analog Devices, Inc
c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   6   *
c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   7   * Enter bugs at http://blackfin.uclinux.org/
c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   8   *
c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03   9   * Licensed under the GPL-2 or later.
c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03  10   */
c6994e6f067cf0 drivers/usb/gadget/f_audio.c Bryan Wu 2009-06-03  11  

:::::: The code at line 1 was first introduced by commit
:::::: c6994e6f067cf0fc4c6cca3d164018b1150916f8 USB: gadget: add USB Audio Gadget driver

:::::: TO: Bryan Wu <cooloney@kernel.org>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
