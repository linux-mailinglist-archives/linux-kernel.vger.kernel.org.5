Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431DD79D15A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjILMqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbjILMps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:45:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3E81738
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694522740; x=1726058740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YGbcus6RopEguJi0pZ8UjWplx7hi8y3G0G6Er2KI+jM=;
  b=I9wPPihtxJZ/XW9wqda1BCYP5+pqH8iUgf8WXm1F5fP6xxaJgSsxeUOl
   fOVjQGWgyGRDeO+OPh2hqARSO32I3OHE7jVBtObek51ATH0SP05/C8HfM
   zCJoccyaBGMTvlM7rej7tSIzm5uQL9euFswirBOoizdVtVmmrWMLM1k3k
   vjCcwfioENYzZ5MBlKeDdn34veaVFiQS8ViftKz/OfEkRH6MJ+JETpCaq
   xIqjUyFNz/EzjE2ZMLd/8Pj/O1itPksjGXuW/07TNQB4S782R9+XbVxVR
   8AgXzxY16pwVWPGnwIsyqUGQzLkFfzxlzJwHLvtoeYBNoWBr7PHBP+28d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="378274593"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378274593"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="858797211"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="858797211"
Received: from lkp-server02.sh.intel.com (HELO 1e56c5165d33) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2023 05:45:37 -0700
Received: from kbuild by 1e56c5165d33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qg2lr-0000Nu-0Y;
        Tue, 12 Sep 2023 12:45:35 +0000
Date:   Tue, 12 Sep 2023 20:45:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     sunying@nj.iscas.ac.cn, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        pengpeng@iscas.ac.cn, renyanjie01@gmail.com,
        Ying Sun <sunying@nj.iscas.ac.cn>
Subject: Re: [PATCH] regulator: mtk-dvfsrc: remove non-existent configuration
 dependency "MTK_DVFSRC"
Message-ID: <202309122031.17TnEn0X-lkp@intel.com>
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
config: arm-randconfig-r024-20230912 (https://download.01.org/0day-ci/archive/20230912/202309122031.17TnEn0X-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309122031.17TnEn0X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309122031.17TnEn0X-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/regulator/mtk-dvfsrc-regulator.c:9:10: fatal error: 'linux/of_.h' file not found
   #include <linux/of_.h>
            ^~~~~~~~~~~~~
   1 error generated.


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
