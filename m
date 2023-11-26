Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498337F95DA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 23:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjKZWkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 17:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKZWkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:40:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA36E3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 14:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701038420; x=1732574420;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lI0i2hUF6jaFfQyRgx40o2gktRaRAwK5/2wQaf8RUh8=;
  b=JJmtQ1wBQFxCmq3qTTs5yISvrBgD7DZbXCHfa7wZjvm8+WrYhZBz3cvs
   V3IHpFb5kWYRabtclecAV7Tlly7W9V/4Qiww5sPQWnt4D1FGF5JTmonsr
   aKnZOUWCsAunV45HIsQjzyTm/H+jd9HRQ+w8f/ZMEomV3YKj7z+gcGLXp
   yET8FE6xZAiPgWtuTtwjRKAf6yMYb7TvzU1TFoyBqvZPzthVZSXVKRUXq
   qn/Wof+UFxw3veVqShOCx18i4JMT+nPoJJR7Ow/aRPii82TCbZki0QzNI
   5wCrUBzSAXfWOBYkSYjZO0G/zDuobZ74Dc7rH7wQ+HnFCq3LQDMudtwfM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="383006574"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="383006574"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 14:40:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="885824018"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="885824018"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 Nov 2023 14:40:18 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r7NnU-0005ah-1s;
        Sun, 26 Nov 2023 22:40:16 +0000
Date:   Mon, 27 Nov 2023 06:39:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: undefined reference to `utf8s_to_utf16s'
Message-ID: <202311270303.oEoMVSFp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2da77f431ac49b5763b88751a75f70daa46296c
commit: f83705a51275ed29117d46e1d68e8b16dcb40507 Driver: VMBus: Add Devicetree support
date:   7 months ago
config: x86_64-buildonly-randconfig-003-20231127 (https://download.01.org/0day-ci/archive/20231127/202311270303.oEoMVSFp-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231127/202311270303.oEoMVSFp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311270303.oEoMVSFp-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `rndis_filter_set_device_mac':
>> (.text+0x9b5d37): undefined reference to `utf8s_to_utf16s'
>> ld: (.text+0x9b5d75): undefined reference to `utf8s_to_utf16s'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
