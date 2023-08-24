Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728BB78700B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbjHXNPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbjHXNPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:15:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B699A1BD4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692882916; x=1724418916;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HLtSQzorvekjVAi0PvIJApzeCXrGB+ljwyl3KphrlBI=;
  b=R/jA+SOCy3vVgblAgXwFKdSFyI55Txgyw9+vj46HXtKZI8fcNXxwx5FI
   XAQKlODa2ItnVLOgdiLRMf65yl4rdegkzuwIXdyRRQpVM4iTTI3foMi2x
   3FjDqtbac1r6wmHH7mm0l5dKM+X9djfhJmDlnUhK0pFdBcYim0wnyym3D
   MOEGqSaaI9+us6gw8mR0wX6BzRVXv84EvTGT4vXT3LHpSBRqllMZblfNk
   ZTvsWLCCFkVs7Ek0LwmKKqjCWplgtgLcJFcwLHShN5k+Xmz/dOzKPtrjp
   pItyFhbxhAce6Ynd+rQQHGhQxZj7yeybZPmSP2GUL+wF7BjM3yr9nVq9c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="460792018"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="460792018"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:15:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="1067815186"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1067815186"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2023 06:15:10 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZAB2-0002hG-32;
        Thu, 24 Aug 2023 13:15:08 +0000
Date:   Thu, 24 Aug 2023 21:14:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/base/regmap/regmap-raw-ram.c:24:24: sparse: sparse: cast to
 restricted __be16
Message-ID: <202308242106.UpZawCLc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   93f5de5f648d2b1ce3540a4ac71756d4a852dc23
commit: 65dd2f671875b1d97b6fa9bcf7677f5e1c55f776 regmap: Provide a ram backed regmap with raw support
date:   2 months ago
config: i386-randconfig-061-20230823 (https://download.01.org/0day-ci/archive/20230824/202308242106.UpZawCLc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230824/202308242106.UpZawCLc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308242106.UpZawCLc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/base/regmap/regmap-raw-ram.c:24:24: sparse: sparse: cast to restricted __be16
>> drivers/base/regmap/regmap-raw-ram.c:26:24: sparse: sparse: cast to restricted __le16

vim +24 drivers/base/regmap/regmap-raw-ram.c

    18	
    19	static unsigned int decode_reg(enum regmap_endian endian, const void *reg)
    20	{
    21		const u16 *r = reg;
    22	
    23		if (endian == REGMAP_ENDIAN_BIG)
  > 24			return be16_to_cpu(*r);
    25		else
  > 26			return le16_to_cpu(*r);
    27	}
    28	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
