Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB9A7A9F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjIUURn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjIUURX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:17:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BE015A38
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695316304; x=1726852304;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=K8aT+q7wtoz10QSssy7pwQ123juZ7rH0zeFJAAkQI3U=;
  b=OQ6J6W2uAQGvNswfo5gUskYbgpkycskDobgJIZEnULcv9LCet7qOrOgD
   xhx/V13woId9q+8Wol/zHwx8jTpJVonGH40wuFN0d6tFZ9J4HzrYa6E1v
   CCUdvWW9pfMjLD0i/yLuSRF/JIuG/0/QfIYJ0GujYQyOn+BDWyoFsbyq0
   KjlW+xWpwIye2zoh5tHC51fWQ44mdnUxKxT0XCJWii3hVL9q/KcCjAwet
   qL1VB9xOmMDW7ADpG0fDgRUpUulrwCixz2sPuQrFbGzm75uGJ4Y7tHYuf
   TlJof/R1LjToaYhDN8NfBgn0L5OYtr6tqJlN6sPCKekUC5QsEkzoPOAhC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="370813750"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="370813750"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="696697976"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="696697976"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Sep 2023 04:48:24 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjIAQ-0009va-0a;
        Thu, 21 Sep 2023 11:48:22 +0000
Date:   Thu, 21 Sep 2023 19:47:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: ld: cannot find libpcap.a: No such file or directory
Message-ID: <202309211916.BjQsfSM8-lkp@intel.com>
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

Hi Ignat,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42dc814987c1feb6410904e58cfd4c36c4146150
commit: 5e1121cd43d4d3436140a462bfc230ff8aeb1693 um: Some fixes to build UML with musl
date:   2 years, 11 months ago
config: um-randconfig-r033-20230730 (https://download.01.org/0day-ci/archive/20230921/202309211916.BjQsfSM8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230921/202309211916.BjQsfSM8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309211916.BjQsfSM8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld: cannot find libpcap.a: No such file or directory

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
