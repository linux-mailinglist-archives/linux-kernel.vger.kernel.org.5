Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9377CBC12
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjJQHNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbjJQHNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:13:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CF795
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697526802; x=1729062802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OcjndigWoYUZeEtnMbkIadupo5rOMlyozMHNgpWU4zg=;
  b=fGS01ESE9PvAPgdWTeu7zHtDCn6StInYHfkOACP2VxPKSW0KadsjP92n
   nOr9GP+tV6b6eQz5gWDbKdhF4xTEL3KrZZEUxDBmTLgt7MKOeniP0a2Or
   LQ2+vYWdjs4zWC+jmbgpFbZkf1dwjYw3XHUgnDNmR/OAJM2j/+ygSwn13
   MBv/xjgCAy2529Gp8TmA9fERLau5ReWNH4t7t6P1kjfkEuXf0JB8a9xVe
   Aa4JV1KKG/U07HQ/la2lZDfrJUeC8d4rzx26T7yhN8j+VHQWDaxhRIVRk
   IyEN7bFlwjlycTbw6dYAE0ysQyRdYjdqlHiaf53HDIuRGSeNYTv/HW7yq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="452193851"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="452193851"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 00:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826325363"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="826325363"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Oct 2023 00:13:19 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qseGT-0009E3-27;
        Tue, 17 Oct 2023 07:13:17 +0000
Date:   Tue, 17 Oct 2023 15:12:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     KaiLong Wang <wangkailong@jari.cn>, mark@fasheh.com,
        jlbec@evilplan.org, akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ocfs2/dlm: Clean up errors in dlmdomain.c
Message-ID: <202310171436.cr0GHO3X-lkp@intel.com>
References: <62e91e34.969.18b27f9ec40.Coremail.wangkailong@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e91e34.969.18b27f9ec40.Coremail.wangkailong@jari.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi KaiLong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.6-rc6 next-20231017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KaiLong-Wang/ocfs2-dlm-Clean-up-errors-in-dlmdomain-c/20231017-115916
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/62e91e34.969.18b27f9ec40.Coremail.wangkailong%40jari.cn
patch subject: [PATCH] ocfs2/dlm: Clean up errors in dlmdomain.c
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310171436.cr0GHO3X-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310171436.cr0GHO3X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310171436.cr0GHO3X-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ocfs2/dlm/dlmdomain.c: In function 'dlm_alloc_pagevec':
>> fs/ocfs2/dlm/dlmdomain.c:78:9: warning: this 'for' clause does not guard... [-Wmisleading-indentation]
      78 |         for (i = 0; i < pages; i++)
         |         ^~~
   fs/ocfs2/dlm/dlmdomain.c:80:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'for'
      80 |                 if (!(vec[i]))
         |                 ^~


vim +/for +78 fs/ocfs2/dlm/dlmdomain.c

03d864c02c3ea8 Daniel Phillips 2006-03-10  69  
03d864c02c3ea8 Daniel Phillips 2006-03-10  70  static void **dlm_alloc_pagevec(int pages)
03d864c02c3ea8 Daniel Phillips 2006-03-10  71  {
6da2ec56059c3c Kees Cook       2018-06-12  72  	void **vec = kmalloc_array(pages, sizeof(void *), GFP_KERNEL);
03d864c02c3ea8 Daniel Phillips 2006-03-10  73  	int i;
03d864c02c3ea8 Daniel Phillips 2006-03-10  74  
03d864c02c3ea8 Daniel Phillips 2006-03-10  75  	if (!vec)
03d864c02c3ea8 Daniel Phillips 2006-03-10  76  		return NULL;
03d864c02c3ea8 Daniel Phillips 2006-03-10  77  
03d864c02c3ea8 Daniel Phillips 2006-03-10 @78  	for (i = 0; i < pages; i++)
8586048e6e9be0 KaiLong Wang    2023-10-13  79  		vec[i] = (void *)__get_free_page(GFP_KERNEL);
8586048e6e9be0 KaiLong Wang    2023-10-13  80  		if (!(vec[i]))
03d864c02c3ea8 Daniel Phillips 2006-03-10  81  			goto out_free;
c8f33b6e86af74 Joel Becker     2006-03-16  82  
685f1adb3872d9 Mark Fasheh     2006-03-23  83  	mlog(0, "Allocated DLM hash pagevec; %d pages (%lu expected), %lu buckets per page\n",
f5a923d1ba648b Mark Fasheh     2006-11-28  84  	     pages, (unsigned long)DLM_HASH_PAGES,
f5a923d1ba648b Mark Fasheh     2006-11-28  85  	     (unsigned long)DLM_BUCKETS_PER_PAGE);
03d864c02c3ea8 Daniel Phillips 2006-03-10  86  	return vec;
03d864c02c3ea8 Daniel Phillips 2006-03-10  87  out_free:
03d864c02c3ea8 Daniel Phillips 2006-03-10  88  	dlm_free_pagevec(vec, i);
03d864c02c3ea8 Daniel Phillips 2006-03-10  89  	return NULL;
03d864c02c3ea8 Daniel Phillips 2006-03-10  90  }
03d864c02c3ea8 Daniel Phillips 2006-03-10  91  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
