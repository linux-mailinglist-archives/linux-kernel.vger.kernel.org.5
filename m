Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBAA7E8532
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 22:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjKJVl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 16:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjKJVl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 16:41:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C36F131
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 13:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699652484; x=1731188484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2j7CJJ56KtAuv4IFO7UAathuBSQQLXvHDcuKEMKgnEU=;
  b=DD1tulao9OXM7Fp0m3zgjJEd4tFpVi+7SUbdCv3w22NV/Rd47b9TKua4
   pQcIPZ5MGdpebta7Y3WT8d32ygjN5vx6LN8AVX70ERdHne8gr3edSiJ4I
   Aw1wiy/9WJiC05C+ikqw0qnMpjw1d+/e8vqDs8zFKyt66m0cFbFbl9mKO
   cQE254zncN0zYtE7BowrKqj46bPz9nNR8T/caCm98S5i9htUuARG4EajV
   QkjYz4co/zGjM9wet5clnxkvXEpM4qE2P8pBNcvxAPETlTcBNzB074nLk
   fqhxCodscYPzkXup7ZfyQtjavTVAx7d2HfLnCxqrz+LeYfzFafj0GqnSv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="454537103"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="454537103"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 13:41:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="763836864"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="763836864"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Nov 2023 13:41:22 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1ZFf-0009vS-36;
        Fri, 10 Nov 2023 21:41:19 +0000
Date:   Sat, 11 Nov 2023 05:40:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     York Jasper Niebuhr <yjnworkstation@gmail.com>,
        akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        York Jasper Niebuhr <yjnworkstation@gmail.com>
Subject: Re: [PATCH] mm: exitz syscall
Message-ID: <202311110549.g5gj4ZVU-lkp@intel.com>
References: <20231110184720.39780-1-yjnworkstation@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110184720.39780-1-yjnworkstation@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi York,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8728c14129df7a6e29188a2e737b4774fb200953]

url:    https://github.com/intel-lab-lkp/linux/commits/York-Jasper-Niebuhr/mm-exitz-syscall/20231111-031729
base:   8728c14129df7a6e29188a2e737b4774fb200953
patch link:    https://lore.kernel.org/r/20231110184720.39780-1-yjnworkstation%40gmail.com
patch subject: [PATCH] mm: exitz syscall
config: loongarch-randconfig-001-20231111 (https://download.01.org/0day-ci/archive/20231111/202311110549.g5gj4ZVU-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311110549.g5gj4ZVU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311110549.g5gj4ZVU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/exitz.c:73:6: warning: no previous prototype for 'exit_memz' [-Wmissing-prototypes]
      73 | void exit_memz(void)
         |      ^~~~~~~~~


vim +/exit_memz +73 kernel/exitz.c

    69	
    70	/*
    71	 * Overwrite any memory associated to current process with zeros.
    72	 */
  > 73	void exit_memz(void)
    74	{
    75		if (!(current->ezflags & EZ_MEM))
    76			return;
    77	
    78		struct vm_area_struct *vma;
    79	
    80		VMA_ITERATOR(vmi, current->mm, 0);
    81	
    82		for_each_vma(vmi, vma) {
    83			memz_range(vma->vm_start, vma->vm_end);
    84		}
    85	}
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
