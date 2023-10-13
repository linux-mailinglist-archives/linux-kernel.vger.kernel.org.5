Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B047C917F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjJMXqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjJMXqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:46:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84369C2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697240778; x=1728776778;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bW1SZWdelds/lkiW3SdokPbSY1AXm9DYvOfwLHYRM18=;
  b=LMPaLZGiG4N3iyfPhnQfRt5rS+3z9X8g5dSdZBMM1XezzLPnZbL4CkMU
   791SVTi5B6qUQWyj6gPQa7FFkvUk5r32j6SDhlPbB+GC+ZYF7luo76721
   L5j6LXp/wXnZgxX8dyOUpfYBxgIWLgyv3NWSFZTDbg6diokvwzmwt9hx7
   /qIZMlC8EomtDBa+BrjcCdUws4AAVz9jhnPxbcE0cUH2C0jikgMC+Kycs
   O/vIVcFbc93zqgvd4fl/k1H9nHJ9T1Mtv3iIj4rpGinNSVWHOBrJNTy3H
   PMMpGX1FxVQWcx7VeHghbU668MzBdB1UkCnwzxHPJl9Ikfp0PXdeiqofo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389146485"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="389146485"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 16:46:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="754884193"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="754884193"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2023 16:46:16 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrRrC-0005Wf-1z;
        Fri, 13 Oct 2023 23:46:14 +0000
Date:   Sat, 14 Oct 2023 07:45:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: cc1: error: AltiVec not supported in this target
Message-ID: <202310140737.65pfgcSI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8cb1f10d8c4b716c88b87ae4402a3305d96e5db2
commit: ebd1d3b74f8542a8f3bb80b453692d6d18f84071 powerpc/32: Move the old 6xx -mcpu logic before the TARGET_CPU logic
date:   4 years, 10 months ago
config: powerpc-randconfig-002-20230923 (https://download.01.org/0day-ci/archive/20231014/202310140737.65pfgcSI-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231014/202310140737.65pfgcSI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310140737.65pfgcSI-lkp@intel.com/

All errors (new ones prefixed by >>):

>> cc1: error: AltiVec not supported in this target

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
