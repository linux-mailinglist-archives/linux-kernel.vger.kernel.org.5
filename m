Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0596F7E72C2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 21:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345147AbjKIU10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 15:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344938AbjKIU1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 15:27:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985193A98
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 12:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699561642; x=1731097642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=enHXLPDZchUeKaed5qrSorYY9iKUN/ksSXTR4yNaJGA=;
  b=bjK0629XMr5+KTsle2Ul0gh59WctGD+4a67rijgGL/hU5QFgDeig6g2J
   mcz2kVbrQ3lgnBwszjhhSuO7HOHd00W7LsgaRKFYZU660GRMtYq3RFHT7
   N9tao4adJeSCki+TD+EKVZQvGMply/wHRCqrPn3C+zOn2icfh1yyuT0ct
   NfCGZUb82F8F98bjJVkhS+vF6mzNXRELfxXTNmFNN4eNU0v8IoCJwKJRu
   ngdF4bz6+IXdIGhl03sCRZfmVXLnKlKhSI4RVFa7rWhx+QbCdmF9a3eIi
   gUwAv/AgB7eIyUbuESQKKtUeGQVy6iN9FGKHnXbBT7dzwJ0AGxeVvKRBx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="389873992"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="389873992"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 12:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="880724957"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="880724957"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Nov 2023 12:27:17 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1BcR-00097K-2H;
        Thu, 09 Nov 2023 20:27:15 +0000
Date:   Fri, 10 Nov 2023 04:26:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     oe-kbuild-all@lists.linux.dev, kernel_team@skhynix.com,
        akpm@linux-foundation.org, ying.huang@intel.com, namit@vmware.com,
        xhao@linux.alibaba.com, mgorman@techsingularity.net,
        hughd@google.com, willy@infradead.org, david@redhat.com,
        peterz@infradead.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [v4 1/3] mm/rmap: Recognize read-only TLB entries during batched
 TLB flush
Message-ID: <202311100429.nc4jJoNu-lkp@intel.com>
References: <20231109045908.54996-2-byungchul@sk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109045908.54996-2-byungchul@sk.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Byungchul,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tip/x86/core tip/x86/mm linus/master v6.6 next-20231109]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/mm-rmap-Recognize-read-only-TLB-entries-during-batched-TLB-flush/20231109-163706
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20231109045908.54996-2-byungchul%40sk.com
patch subject: [v4 1/3] mm/rmap: Recognize read-only TLB entries during batched TLB flush
config: arm64-randconfig-002-20231109 (https://download.01.org/0day-ci/archive/20231110/202311100429.nc4jJoNu-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231110/202311100429.nc4jJoNu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311100429.nc4jJoNu-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/rmap.c: In function 'fold_ubc_ro':
>> mm/rmap.c:620:9: error: implicit declaration of function 'arch_tlbbatch_fold'; did you mean 'arch_tlbbatch_flush'? [-Werror=implicit-function-declaration]
     620 |         arch_tlbbatch_fold(&tlb_ubc->arch, &tlb_ubc_ro->arch);
         |         ^~~~~~~~~~~~~~~~~~
         |         arch_tlbbatch_flush
>> mm/rmap.c:626:9: error: implicit declaration of function 'arch_tlbbatch_clear'; did you mean 'arch_tlbbatch_flush'? [-Werror=implicit-function-declaration]
     626 |         arch_tlbbatch_clear(&tlb_ubc_ro->arch);
         |         ^~~~~~~~~~~~~~~~~~~
         |         arch_tlbbatch_flush
   cc1: some warnings being treated as errors


vim +620 mm/rmap.c

   608	
   609	void fold_ubc_ro(void)
   610	{
   611		struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
   612		struct tlbflush_unmap_batch *tlb_ubc_ro = &current->tlb_ubc_ro;
   613	
   614		if (!tlb_ubc_ro->flush_required)
   615			return;
   616	
   617		/*
   618		 * Fold tlb_ubc_ro's data to tlb_ubc.
   619		 */
 > 620		arch_tlbbatch_fold(&tlb_ubc->arch, &tlb_ubc_ro->arch);
   621		tlb_ubc->flush_required = true;
   622	
   623		/*
   624		 * Reset tlb_ubc_ro's data.
   625		 */
 > 626		arch_tlbbatch_clear(&tlb_ubc_ro->arch);
   627		tlb_ubc_ro->flush_required = false;
   628	}
   629	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
