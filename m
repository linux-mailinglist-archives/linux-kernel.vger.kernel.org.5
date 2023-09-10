Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAA4799FFC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 22:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjIJUzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 16:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIJUz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 16:55:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5156F188
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694379324; x=1725915324;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VTlQ7Avn/wsMkcwD2OrnENNJ1DrZLgE2BLeybRCP/rw=;
  b=Qs3/ZBMiCh+6y3OS9hgsiCDV2BF2h1lb6cfno0s3Nl6+rAmBHozRRGdr
   gMpzmPl0sf2G9hVctCsa2bugigUcqsQRbvgnOvI6hBD/1R8bG9qWJszOs
   ivHeeBezwDrQbVDepg3YHFLYwcCA3nM9qSoT7y5HMC0HDsNIkuPxK9dDm
   mBOlhbNR0aJqYQOgvvhtCHOWJ/Qt9ND5+tnda+nwbcWxxNfGSnrMbgqYR
   7hJoV9ygCtDYE6wJc9A9dQx37tEmfacwnX6jnmgIYCKFAft65DNKGmLVX
   8wdRPQPN6Qo0m8Lz4ACyiVkrpbq0y2w8lL5S2r/LYemYqomeNCyMZIgRs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="381744825"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="381744825"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 13:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="989847922"
X-IronPort-AV: E=Sophos;i="6.02,242,1688454000"; 
   d="scan'208";a="989847922"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Sep 2023 13:55:22 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfRSi-0005Od-1L;
        Sun, 10 Sep 2023 20:55:20 +0000
Date:   Mon, 11 Sep 2023 04:54:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: drivers/net/dsa/sja1105/sja1105.o: warning: objtool:
 sja1105_fast_age() falls through to next function sja1105_setup.cold()
Message-ID: <202309110440.cYGeoXqE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1548b060d6f32a00a2f7e2c11328205fb66fc4fa
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   8 months ago
config: x86_64-buildonly-randconfig-003-20230911 (https://download.01.org/0day-ci/archive/20230911/202309110440.cYGeoXqE-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230911/202309110440.cYGeoXqE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309110440.cYGeoXqE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/dsa/sja1105/sja1105.o: warning: objtool: sja1105_fast_age() falls through to next function sja1105_setup.cold()

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
