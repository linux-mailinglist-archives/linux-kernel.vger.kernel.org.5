Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15AD7E685D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjKIKiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIKiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:38:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C84210E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699526283; x=1731062283;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6Mh79SSY0i2vgDbPJPkXco1TojP7hq5jyCTwgZsgy4k=;
  b=n0mdbdHeSzkbbPD61tSsW61rSn/ifyY2suiJDUqdhOqm2e+ckmyAe1rQ
   rOEIr/eZHh2AHTAI4RvO1JtuV6yfYWsvvB++uzJBQxA10HW4givpR/n6u
   46YrnI8KaiXjgV4VVB19sQar/PkNdgMzPD4GIxH3mYIWvTG2NU7odwXWx
   fvzxY16JFvIWGQbY+Ignu90tx1w6mHE+MSuPL0xUmTs4wLTrHux1yZonS
   BuxbEN53yAKKwGjLUY41aGeUITwMbr7rjD1/X+49NeZz1lrVhNhYlaDfh
   /QGhhR+cOA35ZmgjbhtyMpU07XoC4/NH48MsvhAe6DO1UUBt/Orb2mKp/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="389763725"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="389763725"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 02:38:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="792499887"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="792499887"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2023 02:38:01 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r12QA-0008fM-2k;
        Thu, 09 Nov 2023 10:37:58 +0000
Date:   Thu, 9 Nov 2023 18:35:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: sound/soc/codecs/cs42l43.c:2253:1: sparse: sparse: symbol
 'cs42l43_codec_pm_ops' was not declared. Should it be static?
Message-ID: <202311091824.5z6PROGZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bc986ab839c844e78a2333a02e55f02c9e57935
commit: 2b59332ead54870ed0f1a8b122a1d640a4865fdc ASoC: cs42l43: Use new-style PM runtime macros
date:   3 months ago
config: x86_64-randconfig-123-20230907 (https://download.01.org/0day-ci/archive/20231109/202311091824.5z6PROGZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311091824.5z6PROGZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311091824.5z6PROGZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/codecs/cs42l43.c:2253:1: sparse: sparse: symbol 'cs42l43_codec_pm_ops' was not declared. Should it be static?

vim +/cs42l43_codec_pm_ops +2253 sound/soc/codecs/cs42l43.c

  2252	
> 2253	DEFINE_RUNTIME_DEV_PM_OPS(cs42l43_codec_pm_ops, NULL,
  2254				  cs42l43_codec_runtime_resume, NULL);
  2255	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
