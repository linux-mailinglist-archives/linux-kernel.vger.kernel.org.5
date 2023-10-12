Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2527C7A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443072AbjJLXLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443024AbjJLXLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:11:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7DFA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697152295; x=1728688295;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GquWiZPGPQECdXXaLpW5xHiCfYqYw4Wy3Mhhm56S1LE=;
  b=gv8qtq7P1mvtKuB5xHC6GI2XklIvYLiYdMBXxC8FNGppm2TTMtLOgSOe
   1sPnAdWTHREkpiTnZ0MYs1/PJqDbMo44QEw0dXakaum/M8DdxKg8j92Uj
   vM1bJxuPgOxFewJ9yDuGheR1m4ltncCcst/XrOC50dKACMm9YU8yLAhBO
   jdp28rwqKIdFNjAfnfwMzGwCIV1ZUVjExkFd0yXJZ498PyNHqU5rx5DY3
   kEDYVyuslYYike4d2yUQHez5wKgoPcThSwCzVb28hehT8ojv1prw14MYk
   rKVTsVuj8yV6+vc7gi/RJQBTrhsA/dE/ikNQ98X7aj2xgRkIb8SPhEoJi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="382288626"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="382288626"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 16:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="758240760"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="758240760"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2023 16:11:34 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qr4q4-00040j-0G;
        Thu, 12 Oct 2023 23:11:32 +0000
Date:   Fri, 13 Oct 2023 07:11:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: vmlinux.o: warning: objtool: sja1105_fast_age() falls through to
 next function sja1105_mgmt_xmit.constprop.0.isra.0.cold()
Message-ID: <202310130710.e8aldrhL-lkp@intel.com>
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
head:   e8c127b0576660da9195504fe8393fe9da3de9ce
commit: c27cd083cfb9d392f304657ed00fcde1136704e7 Compiler attributes: GCC cold function alignment workarounds
date:   9 months ago
config: x86_64-randconfig-004-20231013 (https://download.01.org/0day-ci/archive/20231013/202310130710.e8aldrhL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231013/202310130710.e8aldrhL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310130710.e8aldrhL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: sja1105_fast_age() falls through to next function sja1105_mgmt_xmit.constprop.0.isra.0.cold()

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
