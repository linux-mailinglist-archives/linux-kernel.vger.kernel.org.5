Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E527DEF60
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjKBKCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjKBKCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:02:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EBE112
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698919347; x=1730455347;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aFo0suJkDSesfg0ajQNzVJsE+QDDTVmbGJlbAz0snEw=;
  b=ERYwOX/LrSoNfu+dUiKe8dSwOMr5jcozgwrAtKhcUQSxVcu+jCJnB1k5
   lkeD5qv9eNSgoksjk5cFzfOu3y3EKPl7dGsFJrYPWbmdvDL7jzDgCUMKW
   XUvEUawIbIlfOm52xXr7iODze6sR91luDSg45GSt4l/KuZTIdUItxM/vZ
   vsxiWLuEMx4+38hIBECNGZ7afLupOrDxTg5Z64LuhnPBEUo+too6rZ6Au
   xxit794qfC8EejXEimV3QznHHkgYCKt0r5xmYbYp3sJ+ht1mmY49LODIP
   9SY0QnTqCDVfoX8wl6JLL8ecSk49lAaCjc2ocxwvvNcg6BYZKo8Gpa8dy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="385852977"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="385852977"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1092669660"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1092669660"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Nov 2023 03:02:24 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyUWs-0001MS-1n;
        Thu, 02 Nov 2023 10:02:22 +0000
Date:   Thu, 2 Nov 2023 18:01:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>
Subject: include/linux/io-64-nonatomic-lo-hi.h:21:16: sparse: sparse: cast
 truncates bits from constant value (8000000000000000 becomes 0)
Message-ID: <202311021707.h1qwxfew-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
commit: 01278cb6fa82083000a9e0b56c8b004caf5b6a73 ASoC: SOF: ops: fallback to mmio in helpers
date:   1 year ago
config: nios2-randconfig-r132-20231102 (https://download.01.org/0day-ci/archive/20231102/202311021707.h1qwxfew-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231102/202311021707.h1qwxfew-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311021707.h1qwxfew-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   sound/soc/sof/intel/atom.c: note: in included file (through include/sound/hdaudio.h, sound/soc/sof/intel/../sof-priv.h, sound/soc/sof/intel/../ops.h):
>> include/linux/io-64-nonatomic-lo-hi.h:21:16: sparse: sparse: cast truncates bits from constant value (8000000000000000 becomes 0)

vim +21 include/linux/io-64-nonatomic-lo-hi.h

797a796a13df6b8 include/asm-generic/io-64-nonatomic-lo-hi.h Hitoshi Mitake 2012-02-07  18  
3a044178cccfeb8 include/asm-generic/io-64-nonatomic-lo-hi.h Jason Baron    2014-07-04  19  static inline void lo_hi_writeq(__u64 val, volatile void __iomem *addr)
797a796a13df6b8 include/asm-generic/io-64-nonatomic-lo-hi.h Hitoshi Mitake 2012-02-07  20  {
797a796a13df6b8 include/asm-generic/io-64-nonatomic-lo-hi.h Hitoshi Mitake 2012-02-07 @21  	writel(val, addr);
797a796a13df6b8 include/asm-generic/io-64-nonatomic-lo-hi.h Hitoshi Mitake 2012-02-07  22  	writel(val >> 32, addr + 4);
797a796a13df6b8 include/asm-generic/io-64-nonatomic-lo-hi.h Hitoshi Mitake 2012-02-07  23  }
3a044178cccfeb8 include/asm-generic/io-64-nonatomic-lo-hi.h Jason Baron    2014-07-04  24  

:::::: The code at line 21 was first introduced by commit
:::::: 797a796a13df6b84a4791e57306737059b5b2384 asm-generic: architecture independent readq/writeq for 32bit environment

:::::: TO: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
