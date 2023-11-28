Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572EC7FC13E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbjK1QWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjK1QWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:22:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18B7131
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 08:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701188527; x=1732724527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kkj3XaIBhumPeERmIo13qRy1gqgQbcz4xJqxHlZYauY=;
  b=h9G4v0F6IFllldsbe/TTRRUBNhD2afIYxTc0t5GAwbCQURl1L97WJh0e
   N+oICluR0C1basV/PcwWDoBMf0TXWqM0ePYDEHLJIvYd7JlpCBMAR6qnU
   4FE5HeMulKKjxfKlW+0WfrKjWTP2wIIqO1V1cwNuSSn+GK7x0IlNEBq1A
   BoJ76V0tFLlZ1Mvj3WcI6oL7sw4ESR7U2Rr4MV66k2LnXzBXHp53t1qQo
   gHPaue/vk5LKrbGblQqo6PSznGskO+PDN5HeE0zFKBLl0koxRHyjlqofe
   b7E0FHBjt0g98lRdgD/DPxjiSAzuS87sKi9EKsIQKjCkk53uhsWgFqAjN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="14519050"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="14519050"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:22:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="718433083"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="718433083"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Nov 2023 08:22:04 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r80qY-0007jD-0a;
        Tue, 28 Nov 2023 16:22:02 +0000
Date:   Wed, 29 Nov 2023 00:21:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     cuiyangpei <cuiyangpei@gmail.com>, sj@kernel.org,
        akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        cuiyangpei <cuiyangpei@xiaomi.com>
Subject: Re: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
Message-ID: <202311290021.Jo3VlA8D-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/cuiyangpei/mm-damon-core-add-sysfs-nodes-to-set-last_nr_accesses-weight/20231128-194153
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20231128073440.11894-1-cuiyangpei%40xiaomi.com
patch subject: [PATCH 1/2] mm/damon/sysfs: Implement recording feature
config: i386-buildonly-randconfig-001-20231128 (https://download.01.org/0day-ci/archive/20231129/202311290021.Jo3VlA8D-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311290021.Jo3VlA8D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311290021.Jo3VlA8D-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/damon/sysfs.c:1415:6: warning: variable 'count' set but not used [-Wunused-but-set-variable]
           int count = 0;
               ^
   In file included from mm/damon/sysfs.c:2139:
>> mm/damon/sysfs-test.h:15:21: error: redefinition of 'nr_damon_targets'
   static unsigned int nr_damon_targets(struct damon_ctx *ctx)
                       ^
   mm/damon/sysfs.c:1411:21: note: previous definition is here
   static unsigned int nr_damon_targets(struct damon_ctx *ctx)
                       ^
   1 warning and 1 error generated.


vim +/nr_damon_targets +15 mm/damon/sysfs-test.h

b8ee5575f763c2 SeongJae Park 2023-10-22  14  
b8ee5575f763c2 SeongJae Park 2023-10-22 @15  static unsigned int nr_damon_targets(struct damon_ctx *ctx)
b8ee5575f763c2 SeongJae Park 2023-10-22  16  {
b8ee5575f763c2 SeongJae Park 2023-10-22  17  	struct damon_target *t;
b8ee5575f763c2 SeongJae Park 2023-10-22  18  	unsigned int nr_targets = 0;
b8ee5575f763c2 SeongJae Park 2023-10-22  19  
b8ee5575f763c2 SeongJae Park 2023-10-22  20  	damon_for_each_target(t, ctx)
b8ee5575f763c2 SeongJae Park 2023-10-22  21  		nr_targets++;
b8ee5575f763c2 SeongJae Park 2023-10-22  22  
b8ee5575f763c2 SeongJae Park 2023-10-22  23  	return nr_targets;
b8ee5575f763c2 SeongJae Park 2023-10-22  24  }
b8ee5575f763c2 SeongJae Park 2023-10-22  25  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
