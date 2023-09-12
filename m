Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4227C79DB23
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjILVtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjILVtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:49:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C0D10D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694555388; x=1726091388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8c3AlO8PBtO5Q8LR1lCzc5UiCpzDk6phi7ZBAGbhAfA=;
  b=MA+c034N0MR+ORp//Biam6T0zB0HiRNDzCaEaT5aoLZlTrOBFhS38vFH
   mSoG9ZXfyX2LIqRWpTeOnXgWtXhoyf2gFrSCaURPWtrjYeVER5bryKkb7
   yake1Wz67Vl4IfOPC5Sm+ezhN8c6reER27oAsj1XEPWrBnSWml0BPbCjb
   kcE+h97t9gg/fpiEfvHD/Z0zM171kN2pMGa1f36KW1Rvsi4lAbj0eAU8l
   6dsj2tV88hhUOP3wPWuHbBHV1vaVVmaIr30H3Yk297FfaDYB7IJT8k4Yx
   LJINOJUAQdWQKOSQX84gGBSsYK36AD6jtK8pzL22+R1FqBLwN73U9D4Se
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="444939179"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="444939179"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 14:49:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809421557"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="809421557"
Received: from lkp-server02.sh.intel.com (HELO 47e905db7d2b) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Sep 2023 14:49:45 -0700
Received: from kbuild by 47e905db7d2b with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgBGR-0000JF-0o;
        Tue, 12 Sep 2023 21:49:43 +0000
Date:   Wed, 13 Sep 2023 05:49:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     sunying@nj.iscas.ac.cn, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, pengpeng@iscas.ac.cn,
        renyanjie01@gmail.com, Ying Sun <sunying@nj.iscas.ac.cn>
Subject: Re: [PATCH] regulator: mtk-dvfsrc: remove non-existent configuration
 dependency "MTK_DVFSRC"
Message-ID: <202309130559.z9VcY7Ak-lkp@intel.com>
References: <20230912013929.658-1-sunying@nj.iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912013929.658-1-sunying@nj.iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on broonie-regulator/for-next]
[also build test ERROR on linus/master v6.6-rc1 next-20230912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/sunying-nj-iscas-ac-cn/regulator-mtk-dvfsrc-remove-non-existent-configuration-dependency-MTK_DVFSRC/20230912-101109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
patch link:    https://lore.kernel.org/r/20230912013929.658-1-sunying%40nj.iscas.ac.cn
patch subject: [PATCH] regulator: mtk-dvfsrc: remove non-existent configuration dependency "MTK_DVFSRC"
config: sparc64-allyesconfig (https://download.01.org/0day-ci/archive/20230913/202309130559.z9VcY7Ak-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309130559.z9VcY7Ak-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309130559.z9VcY7Ak-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/regulator/mtk-dvfsrc-regulator.c:9:10: fatal error: linux/of_.h: No such file or directory
       9 | #include <linux/of_.h>
         |          ^~~~~~~~~~~~~
   compilation terminated.


vim +9 drivers/regulator/mtk-dvfsrc-regulator.c

a0db6b0aa670ba henryc.chen 2020-12-24   4  
a0db6b0aa670ba henryc.chen 2020-12-24   5  #include <linux/err.h>
a0db6b0aa670ba henryc.chen 2020-12-24   6  #include <linux/init.h>
a0db6b0aa670ba henryc.chen 2020-12-24   7  #include <linux/module.h>
a0db6b0aa670ba henryc.chen 2020-12-24   8  #include <linux/platform_device.h>
045a44d4c9b325 Rob Herring 2023-07-14  @9  #include <linux/of_.h>
a0db6b0aa670ba henryc.chen 2020-12-24  10  #include <linux/regulator/driver.h>
a0db6b0aa670ba henryc.chen 2020-12-24  11  #include <linux/regulator/of_regulator.h>
a0db6b0aa670ba henryc.chen 2020-12-24  12  #include <linux/soc/mediatek/mtk_dvfsrc.h>
a0db6b0aa670ba henryc.chen 2020-12-24  13  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
