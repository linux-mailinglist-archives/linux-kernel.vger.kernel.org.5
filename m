Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE7B7CF47A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbjJSJyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJSJyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:54:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC2B106
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697709248; x=1729245248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DpWoKFS1wco1iGTyAsYaK+amZcKbFRnsbYOwb1MRs9M=;
  b=mbPDrQNyiXl9xRFkp55e2+YhiE0yNOWSmjgQyjoco+lB/SUr527d2WfP
   c3azCLeuPLm0QdiuwlbPIYWZjXt0nja14KoDsBGbpVTuEICVfk+R7+kC6
   n/eYvcnK9eQ1s2sRgfk9m0Zji51UBOVahMCJvJf7C0Te8ZC6ulV1pC17d
   RpOyaKvtRkGNnYazImU1ZAbr6ko1/thwZ0SILU24VxmMl36Cv1qFt40yA
   aDHoFjJoKpQSnruf9adclpzcf4kCtNCvODBToTiBU5aj0p6J01IWhknDT
   EosBqGWQDYU2SlKLmGAgfflF81X2OqG6Ij996Kk2D2x//G1yv2FKTl4e8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="365565821"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="365565821"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 02:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="900681484"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="900681484"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 19 Oct 2023 02:51:57 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtPj7-0001wc-2L;
        Thu, 19 Oct 2023 09:54:01 +0000
Date:   Thu, 19 Oct 2023 17:53:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     KaiLong Wang <wangkailong@jari.cn>, mark@fasheh.com,
        jlbec@evilplan.org, akpm@linux-foundation.org
Cc:     oe-kbuild-all@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ocfs2/dlm: Clean up errors in dlmdomain.c
Message-ID: <202310191736.myy5k3i6-lkp@intel.com>
References: <62e91e34.969.18b27f9ec40.Coremail.wangkailong@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62e91e34.969.18b27f9ec40.Coremail.wangkailong@jari.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi KaiLong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.6-rc6 next-20231019]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KaiLong-Wang/ocfs2-dlm-Clean-up-errors-in-dlmdomain-c/20231017-115916
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/62e91e34.969.18b27f9ec40.Coremail.wangkailong%40jari.cn
patch subject: [PATCH] ocfs2/dlm: Clean up errors in dlmdomain.c
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231019/202310191736.myy5k3i6-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310191736.myy5k3i6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191736.myy5k3i6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ocfs2/dlm/dlmdomain.c: In function 'dlm_alloc_pagevec':
   fs/ocfs2/dlm/dlmdomain.c:78:9: warning: this 'for' clause does not guard... [-Wmisleading-indentation]
      78 |         for (i = 0; i < pages; i++)
         |         ^~~
   fs/ocfs2/dlm/dlmdomain.c:80:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'for'
      80 |                 if (!(vec[i]))
         |                 ^~
   fs/ocfs2/dlm/dlmdomain.c: In function 'dlm_alloc_pagevec.constprop':
>> fs/ocfs2/dlm/dlmdomain.c:80:26: warning: array subscript 32 is outside array bounds of 'void[128]' [-Warray-bounds=]
      80 |                 if (!(vec[i]))
         |                      ~~~~^~~~
   In file included from fs/ocfs2/dlm/dlmdomain.c:12:
   In function 'kmalloc',
       inlined from 'kmalloc_array' at include/linux/slab.h:635:10,
       inlined from 'dlm_alloc_pagevec.constprop' at fs/ocfs2/dlm/dlmdomain.c:72:15:
   include/linux/slab.h:599:24: note: at offset 128 into object of size 128 allocated by 'kmalloc_trace'
     599 |                 return kmalloc_trace(
         |                        ^~~~~~~~~~~~~~
     600 |                                 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     601 |                                 flags, size);
         |                                 ~~~~~~~~~~~~


vim +80 fs/ocfs2/dlm/dlmdomain.c

    69	
    70	static void **dlm_alloc_pagevec(int pages)
    71	{
    72		void **vec = kmalloc_array(pages, sizeof(void *), GFP_KERNEL);
    73		int i;
    74	
    75		if (!vec)
    76			return NULL;
    77	
    78		for (i = 0; i < pages; i++)
    79			vec[i] = (void *)__get_free_page(GFP_KERNEL);
  > 80			if (!(vec[i]))
    81				goto out_free;
    82	
    83		mlog(0, "Allocated DLM hash pagevec; %d pages (%lu expected), %lu buckets per page\n",
    84		     pages, (unsigned long)DLM_HASH_PAGES,
    85		     (unsigned long)DLM_BUCKETS_PER_PAGE);
    86		return vec;
    87	out_free:
    88		dlm_free_pagevec(vec, i);
    89		return NULL;
    90	}
    91	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
