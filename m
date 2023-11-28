Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8499C7FC1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjK1QLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjK1QLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:11:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7944131
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701187909; x=1732723909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rzhcoBiNb5sbw/XALIsMKDW7hxWSx0E3Q5HsqhBi5L8=;
  b=n4QgqJiZ1HcjpVza9bn2YysyaMi2SYDi9qwbFTjZ7LYHBtNV+Tv/2f9+
   6Z6cucwDa32s94Z0HOpqFsIUoyEXfwkeUYiikMex4b52JchFtad74tLsO
   vCmlwQmOTbTgZmenGGJcbqHeY3IZD0FHV49kySA/ASYvOERR0y53FIqN6
   A1B9JnU2X1uMMzHjeP8lMp2tZTHrYvSBKxpm5piwgNpIqKnVSsnTgTt9v
   YzRgHB2QRv3R89AZ3YKQ2BLtC9LfI1vD7EZjpzilOJp/iAgfxGOYflq4N
   zMGB4suTi9ncb4Ap/vMg6Yu0ku8zZBsWdQ86f7zwprUBL4fP5VyVbNWq3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="11649516"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="11649516"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:11:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="941971415"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="941971415"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2023 08:11:45 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r80gZ-0007ik-1R;
        Tue, 28 Nov 2023 16:11:43 +0000
Date:   Wed, 29 Nov 2023 00:11:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     cuiyangpei <cuiyangpei@gmail.com>, sj@kernel.org,
        akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        cuiyangpei <cuiyangpei@xiaomi.com>
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <202311290004.B2GD9Xbd-lkp@intel.com>
References: <20231128073440.11894-1-cuiyangpei@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128073440.11894-1-cuiyangpei@xiaomi.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi cuiyangpei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/cuiyangpei/mm-damon-core-add-sysfs-nodes-to-set-last_nr_accesses-weight/20231128-194153
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231128073440.11894-1-cuiyangpei%40xiaomi.com
patch subject: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
config: i386-buildonly-randconfig-002-20231128 (https://download.01.org/0day-ci/archive/20231129/202311290004.B2GD9Xbd-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311290004.B2GD9Xbd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311290004.B2GD9Xbd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/damon/sysfs.c:1415:6: warning: variable 'count' set but not used [-Wunused-but-set-variable]
           int count = 0;
               ^
   1 warning generated.


vim +/count +1415 mm/damon/sysfs.c

  1410	
  1411	static unsigned int nr_damon_targets(struct damon_ctx *ctx)
  1412	{
  1413		struct damon_target *t;
  1414		unsigned int nr_targets = 0;
> 1415		int count = 0;
  1416	
  1417		damon_for_each_target(t, ctx) {
  1418			count++;
  1419			nr_targets++;
  1420		}
  1421	
  1422		return nr_targets;
  1423	}
  1424	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
