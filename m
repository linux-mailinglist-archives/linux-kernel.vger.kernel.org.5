Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A19F7F2187
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjKTXlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjKTXlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:41:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348DDC8;
        Mon, 20 Nov 2023 15:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700523661; x=1732059661;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=feSvV0+cWNC4uBEcbTGoSvkz6BJZ9IxEyyejxLx6g5U=;
  b=X/E/EXn6ytwwsm68rT5YFQE9HNEeA+Xy56ZrZgL2H7RL3aUmVP/d9YWj
   jpzrFQ+smvXbUvvDQ09nZdho6mp2u4c/0hrcwu4OdyGxbgycG1T0H1EQx
   7W79D1VRkV6LSIrEfI3TwILPXcN2zN1t4dMboFrluUy8u4XP/H+NGm2wL
   GKAjcaE24XtpIPKHxf+NB6MfKez3b9YEFsN4MGKu0hyGwte98ImzbKcmF
   rOI/gEcORdzUJ0OazmRgKYYwMOHPNyPjTNbYng43sADceq+jH+4O7F0RC
   DcD4eIu3sJ7vI5xIl1wJBSl/YMPiJWOwSpIFTy/jD34/R7uJ6K+w+9slk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="422830576"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="422830576"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 15:41:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="7875005"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 20 Nov 2023 15:41:00 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5Dsv-00074I-1T;
        Mon, 20 Nov 2023 23:40:57 +0000
Date:   Tue, 21 Nov 2023 07:39:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Young <sean@mess.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: drivers/media/rc/ttusbir.c:1: warning: no structured comments found
Message-ID: <202311210746.QM5MR14D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: b9e1486e0e4b5e0fc0cde214ceecec8a5734f620 media: rc-core: do not depend on MEDIA_SUPPORT
date:   6 years ago
config: i386-randconfig-005-20231120 (https://download.01.org/0day-ci/archive/20231121/202311210746.QM5MR14D-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210746.QM5MR14D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311210746.QM5MR14D-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/rc/ttusbir.c:1: warning: no structured comments found


vim +1 drivers/media/rc/ttusbir.c

0938069fa08970 Sean Young 2012-08-13  @1  /*
0938069fa08970 Sean Young 2012-08-13   2   * TechnoTrend USB IR Receiver
0938069fa08970 Sean Young 2012-08-13   3   *
0938069fa08970 Sean Young 2012-08-13   4   * Copyright (C) 2012 Sean Young <sean@mess.org>
0938069fa08970 Sean Young 2012-08-13   5   *
0938069fa08970 Sean Young 2012-08-13   6   * This program is free software; you can redistribute it and/or modify
0938069fa08970 Sean Young 2012-08-13   7   * it under the terms of the GNU General Public License as published by
0938069fa08970 Sean Young 2012-08-13   8   * the Free Software Foundation; either version 2 of the License, or
0938069fa08970 Sean Young 2012-08-13   9   * (at your option) any later version.
0938069fa08970 Sean Young 2012-08-13  10   *
0938069fa08970 Sean Young 2012-08-13  11   * This program is distributed in the hope that it will be useful,
0938069fa08970 Sean Young 2012-08-13  12   * but WITHOUT ANY WARRANTY; without even the implied warranty of
0938069fa08970 Sean Young 2012-08-13  13   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
0938069fa08970 Sean Young 2012-08-13  14   * GNU General Public License for more details.
0938069fa08970 Sean Young 2012-08-13  15   */
0938069fa08970 Sean Young 2012-08-13  16  

:::::: The code at line 1 was first introduced by commit
:::::: 0938069fa08970f1c898970c1331a029efe9a1ce [media] rc: Add support for the TechnoTrend USB IR Receiver

:::::: TO: Sean Young <sean@mess.org>
:::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
