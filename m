Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE7789FAA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 15:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjH0Nxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjH0Nxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:53:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B030CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693144413; x=1724680413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x2/mWGYjOaOJsFCVN/w0DdieBRqnmIkLdF2iZvzrn1A=;
  b=iHlKwb6F8TYUx67s9Y5QjtfVog0DZWctBFAoQ3R9UetwTYdRWapSx7U0
   tJiiTbluf0sFbU+evEh71x/j72SxxbNmx9T8UBuhyeh+LM2LjwRSbRAyF
   x/2rSBEamkr7kV4hsIMRKaxcG48yPMOn3VNJcjloO2+dOJkV32ThFXAIv
   aerbggTaTETxHU7NJngYajaylOL08oonC8843KBSwx2KabnQarJk/SGsC
   IE/gc+xfud6A/mA0oO80qAJCvOvIh9H2No3/oV5lR6ZTdIXMDvMFg86FD
   0jHHBYiYbo/VGr7F2rxqL1jj5ydoT62ZDcClmO5FVUvSmt7uoRIKGvizX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="438899106"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="438899106"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 06:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="852530947"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="852530947"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2023 06:53:29 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaGCm-0005rX-1K;
        Sun, 27 Aug 2023 13:53:28 +0000
Date:   Sun, 27 Aug 2023 21:53:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, thunder.leizhen@huawei.com,
        dyoung@redhat.com, prudo@redhat.com, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 5/8] crash_core: add generic function to do reservation
Message-ID: <202308272150.p3kRkMoF-lkp@intel.com>
References: <20230827101128.70931-6-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827101128.70931-6-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on powerpc/next powerpc/fixes linus/master v6.5-rc7]
[cannot apply to arm64/for-next/core next-20230825]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/crash_core-c-remove-unnecessary-parameter-of-function/20230827-181555
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20230827101128.70931-6-bhe%40redhat.com
patch subject: [PATCH 5/8] crash_core: add generic function to do reservation
config: csky-defconfig (https://download.01.org/0day-ci/archive/20230827/202308272150.p3kRkMoF-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230827/202308272150.p3kRkMoF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308272150.p3kRkMoF-lkp@intel.com/

All errors (new ones prefixed by >>):

     537 | void __weak arch_crash_save_vmcoreinfo(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/crash_core.c:540:20: warning: no previous prototype for 'paddr_vmcoreinfo_note' [-Wmissing-prototypes]
     540 | phys_addr_t __weak paddr_vmcoreinfo_note(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/crash_core.c: In function 'crash_save_vmcoreinfo_init':
   kernel/crash_core.c:554:45: error: 'VMCOREINFO_NOTE_SIZE' undeclared (first use in this function)
     554 |         vmcoreinfo_note = alloc_pages_exact(VMCOREINFO_NOTE_SIZE,
         |                                             ^~~~~~~~~~~~~~~~~~~~
   kernel/crash_core.c:563:9: error: implicit declaration of function 'VMCOREINFO_OSRELEASE' [-Werror=implicit-function-declaration]
     563 |         VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
         |         ^~~~~~~~~~~~~~~~~~~~
   kernel/crash_core.c:564:9: error: implicit declaration of function 'VMCOREINFO_BUILD_ID' [-Werror=implicit-function-declaration]
     564 |         VMCOREINFO_BUILD_ID();
         |         ^~~~~~~~~~~~~~~~~~~
   kernel/crash_core.c:565:9: error: implicit declaration of function 'VMCOREINFO_PAGESIZE' [-Werror=implicit-function-declaration]
     565 |         VMCOREINFO_PAGESIZE(PAGE_SIZE);
         |         ^~~~~~~~~~~~~~~~~~~
   kernel/crash_core.c:567:9: error: implicit declaration of function 'VMCOREINFO_SYMBOL' [-Werror=implicit-function-declaration]
     567 |         VMCOREINFO_SYMBOL(init_uts_ns);
         |         ^~~~~~~~~~~~~~~~~
   kernel/crash_core.c:568:9: error: implicit declaration of function 'VMCOREINFO_OFFSET' [-Werror=implicit-function-declaration]
     568 |         VMCOREINFO_OFFSET(uts_namespace, name);
         |         ^~~~~~~~~~~~~~~~~
   kernel/crash_core.c:568:27: error: 'uts_namespace' undeclared (first use in this function)
     568 |         VMCOREINFO_OFFSET(uts_namespace, name);
         |                           ^~~~~~~~~~~~~
   kernel/crash_core.c:568:42: error: 'name' undeclared (first use in this function)
     568 |         VMCOREINFO_OFFSET(uts_namespace, name);
         |                                          ^~~~
   kernel/crash_core.c:571:9: error: implicit declaration of function 'VMCOREINFO_SYMBOL_ARRAY' [-Werror=implicit-function-declaration]
     571 |         VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/crash_core.c:588:9: error: implicit declaration of function 'VMCOREINFO_STRUCT_SIZE' [-Werror=implicit-function-declaration]
     588 |         VMCOREINFO_STRUCT_SIZE(page);
         |         ^~~~~~~~~~~~~~~~~~~~~~
   kernel/crash_core.c:588:32: error: 'page' undeclared (first use in this function)
     588 |         VMCOREINFO_STRUCT_SIZE(page);
         |                                ^~~~
   kernel/crash_core.c:589:32: error: 'pglist_data' undeclared (first use in this function)
     589 |         VMCOREINFO_STRUCT_SIZE(pglist_data);
         |                                ^~~~~~~~~~~
   kernel/crash_core.c:590:32: error: 'zone' undeclared (first use in this function)
     590 |         VMCOREINFO_STRUCT_SIZE(zone);
         |                                ^~~~
   kernel/crash_core.c:591:32: error: 'free_area' undeclared (first use in this function)
     591 |         VMCOREINFO_STRUCT_SIZE(free_area);
         |                                ^~~~~~~~~
   kernel/crash_core.c:592:32: error: 'list_head' undeclared (first use in this function)
     592 |         VMCOREINFO_STRUCT_SIZE(list_head);
         |                                ^~~~~~~~~
   kernel/crash_core.c:593:9: error: implicit declaration of function 'VMCOREINFO_SIZE' [-Werror=implicit-function-declaration]
     593 |         VMCOREINFO_SIZE(nodemask_t);
         |         ^~~~~~~~~~~~~~~
   kernel/crash_core.c:593:25: error: expected expression before 'nodemask_t'
     593 |         VMCOREINFO_SIZE(nodemask_t);
         |                         ^~~~~~~~~~
   kernel/crash_core.c:594:33: error: 'flags' undeclared (first use in this function); did you mean 'fls'?
     594 |         VMCOREINFO_OFFSET(page, flags);
         |                                 ^~~~~
         |                                 fls
   kernel/crash_core.c:595:33: error: '_refcount' undeclared (first use in this function); did you mean 'seqcount'?
     595 |         VMCOREINFO_OFFSET(page, _refcount);
         |                                 ^~~~~~~~~
         |                                 seqcount
   kernel/crash_core.c:596:33: error: 'mapping' undeclared (first use in this function)
     596 |         VMCOREINFO_OFFSET(page, mapping);
         |                                 ^~~~~~~
   kernel/crash_core.c:597:33: error: 'lru' undeclared (first use in this function)
     597 |         VMCOREINFO_OFFSET(page, lru);
         |                                 ^~~
   kernel/crash_core.c:598:33: error: '_mapcount' undeclared (first use in this function); did you mean 'nmi_count'?
     598 |         VMCOREINFO_OFFSET(page, _mapcount);
         |                                 ^~~~~~~~~
         |                                 nmi_count
   kernel/crash_core.c:599:33: error: 'private' undeclared (first use in this function); did you mean 'PG_private'?
     599 |         VMCOREINFO_OFFSET(page, private);
         |                                 ^~~~~~~
         |                                 PG_private
   kernel/crash_core.c:600:27: error: 'folio' undeclared (first use in this function)
     600 |         VMCOREINFO_OFFSET(folio, _folio_dtor);
         |                           ^~~~~
   kernel/crash_core.c:600:34: error: '_folio_dtor' undeclared (first use in this function)
     600 |         VMCOREINFO_OFFSET(folio, _folio_dtor);
         |                                  ^~~~~~~~~~~
   kernel/crash_core.c:601:34: error: '_folio_order' undeclared (first use in this function); did you mean 'folio_order'?
     601 |         VMCOREINFO_OFFSET(folio, _folio_order);
         |                                  ^~~~~~~~~~~~
         |                                  folio_order
   kernel/crash_core.c:602:33: error: 'compound_head' undeclared (first use in this function); did you mean '_compound_head'?
     602 |         VMCOREINFO_OFFSET(page, compound_head);
         |                                 ^~~~~~~~~~~~~
         |                                 _compound_head
   kernel/crash_core.c:603:40: error: 'node_zones' undeclared (first use in this function); did you mean 'node_zonelist'?
     603 |         VMCOREINFO_OFFSET(pglist_data, node_zones);
         |                                        ^~~~~~~~~~
         |                                        node_zonelist
   kernel/crash_core.c:604:40: error: 'nr_zones' undeclared (first use in this function)
     604 |         VMCOREINFO_OFFSET(pglist_data, nr_zones);
         |                                        ^~~~~~~~
>> kernel/crash_core.c:606:40: error: 'node_mem_map' undeclared (first use in this function); did you mean 'node_remap'?
     606 |         VMCOREINFO_OFFSET(pglist_data, node_mem_map);
         |                                        ^~~~~~~~~~~~
         |                                        node_remap
   kernel/crash_core.c:608:40: error: 'node_start_pfn' undeclared (first use in this function)
     608 |         VMCOREINFO_OFFSET(pglist_data, node_start_pfn);
         |                                        ^~~~~~~~~~~~~~
   kernel/crash_core.c:609:40: error: 'node_spanned_pages' undeclared (first use in this function); did you mean 'zone_managed_pages'?
     609 |         VMCOREINFO_OFFSET(pglist_data, node_spanned_pages);
         |                                        ^~~~~~~~~~~~~~~~~~
         |                                        zone_managed_pages
   kernel/crash_core.c:610:40: error: 'node_id' undeclared (first use in this function)
     610 |         VMCOREINFO_OFFSET(pglist_data, node_id);
         |                                        ^~~~~~~
   kernel/crash_core.c:612:33: error: 'vm_stat' undeclared (first use in this function); did you mean 'vfs_stat'?
     612 |         VMCOREINFO_OFFSET(zone, vm_stat);
         |                                 ^~~~~~~
         |                                 vfs_stat
   kernel/crash_core.c:613:33: error: 'spanned_pages' undeclared (first use in this function); did you mean 'shake_page'?
     613 |         VMCOREINFO_OFFSET(zone, spanned_pages);
         |                                 ^~~~~~~~~~~~~
         |                                 shake_page
   kernel/crash_core.c:614:38: error: 'free_list' undeclared (first use in this function); did you mean 'kfree_link'?
     614 |         VMCOREINFO_OFFSET(free_area, free_list);
         |                                      ^~~~~~~~~
         |                                      kfree_link
   kernel/crash_core.c:615:38: error: 'next' undeclared (first use in this function); did you mean 'net'?
     615 |         VMCOREINFO_OFFSET(list_head, next);
         |                                      ^~~~
         |                                      net
   kernel/crash_core.c:616:38: error: 'prev' undeclared (first use in this function)
     616 |         VMCOREINFO_OFFSET(list_head, prev);
         |                                      ^~~~
   kernel/crash_core.c:617:27: error: 'vmap_area' undeclared (first use in this function)
     617 |         VMCOREINFO_OFFSET(vmap_area, va_start);
         |                           ^~~~~~~~~
   kernel/crash_core.c:617:38: error: 'va_start' undeclared (first use in this function); did you mean '_start'?
     617 |         VMCOREINFO_OFFSET(vmap_area, va_start);
         |                                      ^~~~~~~~
         |                                      _start
   kernel/crash_core.c:618:38: error: 'list' undeclared (first use in this function)
     618 |         VMCOREINFO_OFFSET(vmap_area, list);
         |                                      ^~~~
   kernel/crash_core.c:619:9: error: implicit declaration of function 'VMCOREINFO_LENGTH' [-Werror=implicit-function-declaration]
     619 |         VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER + 1);
         |         ^~~~~~~~~~~~~~~~~
   kernel/crash_core.c:622:9: error: implicit declaration of function 'VMCOREINFO_NUMBER' [-Werror=implicit-function-declaration]
     622 |         VMCOREINFO_NUMBER(NR_FREE_PAGES);
         |         ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +606 kernel/crash_core.c

692f66f26a4c19d Hari Bathini            2017-05-08  545  
692f66f26a4c19d Hari Bathini            2017-05-08  546  static int __init crash_save_vmcoreinfo_init(void)
692f66f26a4c19d Hari Bathini            2017-05-08  547  {
203e9e41219b4e7 Xunlei Pang             2017-07-12  548  	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
203e9e41219b4e7 Xunlei Pang             2017-07-12  549  	if (!vmcoreinfo_data) {
203e9e41219b4e7 Xunlei Pang             2017-07-12  550  		pr_warn("Memory allocation for vmcoreinfo_data failed\n");
203e9e41219b4e7 Xunlei Pang             2017-07-12  551  		return -ENOMEM;
203e9e41219b4e7 Xunlei Pang             2017-07-12  552  	}
203e9e41219b4e7 Xunlei Pang             2017-07-12  553  
203e9e41219b4e7 Xunlei Pang             2017-07-12  554  	vmcoreinfo_note = alloc_pages_exact(VMCOREINFO_NOTE_SIZE,
203e9e41219b4e7 Xunlei Pang             2017-07-12  555  						GFP_KERNEL | __GFP_ZERO);
203e9e41219b4e7 Xunlei Pang             2017-07-12  556  	if (!vmcoreinfo_note) {
203e9e41219b4e7 Xunlei Pang             2017-07-12  557  		free_page((unsigned long)vmcoreinfo_data);
203e9e41219b4e7 Xunlei Pang             2017-07-12  558  		vmcoreinfo_data = NULL;
203e9e41219b4e7 Xunlei Pang             2017-07-12  559  		pr_warn("Memory allocation for vmcoreinfo_note failed\n");
203e9e41219b4e7 Xunlei Pang             2017-07-12  560  		return -ENOMEM;
203e9e41219b4e7 Xunlei Pang             2017-07-12  561  	}
203e9e41219b4e7 Xunlei Pang             2017-07-12  562  
692f66f26a4c19d Hari Bathini            2017-05-08  563  	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
44e8a5e9120bf4f Stephen Boyd            2021-07-07  564  	VMCOREINFO_BUILD_ID();
692f66f26a4c19d Hari Bathini            2017-05-08  565  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
692f66f26a4c19d Hari Bathini            2017-05-08  566  
692f66f26a4c19d Hari Bathini            2017-05-08  567  	VMCOREINFO_SYMBOL(init_uts_ns);
ca4a9241cc5e718 Alexander Egorenkov     2020-12-15  568  	VMCOREINFO_OFFSET(uts_namespace, name);
692f66f26a4c19d Hari Bathini            2017-05-08  569  	VMCOREINFO_SYMBOL(node_online_map);
692f66f26a4c19d Hari Bathini            2017-05-08  570  #ifdef CONFIG_MMU
eff4345e7fba0aa Omar Sandoval           2018-08-21  571  	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
692f66f26a4c19d Hari Bathini            2017-05-08  572  #endif
692f66f26a4c19d Hari Bathini            2017-05-08  573  	VMCOREINFO_SYMBOL(_stext);
692f66f26a4c19d Hari Bathini            2017-05-08  574  	VMCOREINFO_SYMBOL(vmap_area_list);
692f66f26a4c19d Hari Bathini            2017-05-08  575  
a9ee6cf5c60ed10 Mike Rapoport           2021-06-28  576  #ifndef CONFIG_NUMA
692f66f26a4c19d Hari Bathini            2017-05-08  577  	VMCOREINFO_SYMBOL(mem_map);
692f66f26a4c19d Hari Bathini            2017-05-08  578  	VMCOREINFO_SYMBOL(contig_page_data);
692f66f26a4c19d Hari Bathini            2017-05-08  579  #endif
692f66f26a4c19d Hari Bathini            2017-05-08  580  #ifdef CONFIG_SPARSEMEM
a0b1280368d1e91 Kirill A. Shutemov      2018-01-12  581  	VMCOREINFO_SYMBOL_ARRAY(mem_section);
692f66f26a4c19d Hari Bathini            2017-05-08  582  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
692f66f26a4c19d Hari Bathini            2017-05-08  583  	VMCOREINFO_STRUCT_SIZE(mem_section);
692f66f26a4c19d Hari Bathini            2017-05-08  584  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
4f5aecdff25f59f Pingfan Liu             2021-06-15  585  	VMCOREINFO_NUMBER(SECTION_SIZE_BITS);
1d50e5d0c505244 Bhupesh Sharma          2020-05-14  586  	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
692f66f26a4c19d Hari Bathini            2017-05-08  587  #endif
692f66f26a4c19d Hari Bathini            2017-05-08  588  	VMCOREINFO_STRUCT_SIZE(page);
692f66f26a4c19d Hari Bathini            2017-05-08  589  	VMCOREINFO_STRUCT_SIZE(pglist_data);
692f66f26a4c19d Hari Bathini            2017-05-08  590  	VMCOREINFO_STRUCT_SIZE(zone);
692f66f26a4c19d Hari Bathini            2017-05-08  591  	VMCOREINFO_STRUCT_SIZE(free_area);
692f66f26a4c19d Hari Bathini            2017-05-08  592  	VMCOREINFO_STRUCT_SIZE(list_head);
692f66f26a4c19d Hari Bathini            2017-05-08  593  	VMCOREINFO_SIZE(nodemask_t);
692f66f26a4c19d Hari Bathini            2017-05-08  594  	VMCOREINFO_OFFSET(page, flags);
692f66f26a4c19d Hari Bathini            2017-05-08  595  	VMCOREINFO_OFFSET(page, _refcount);
692f66f26a4c19d Hari Bathini            2017-05-08  596  	VMCOREINFO_OFFSET(page, mapping);
692f66f26a4c19d Hari Bathini            2017-05-08  597  	VMCOREINFO_OFFSET(page, lru);
692f66f26a4c19d Hari Bathini            2017-05-08  598  	VMCOREINFO_OFFSET(page, _mapcount);
692f66f26a4c19d Hari Bathini            2017-05-08  599  	VMCOREINFO_OFFSET(page, private);
1c5509be58f636a Matthew Wilcox (Oracle  2023-01-11  600) 	VMCOREINFO_OFFSET(folio, _folio_dtor);
1c5509be58f636a Matthew Wilcox (Oracle  2023-01-11  601) 	VMCOREINFO_OFFSET(folio, _folio_order);
692f66f26a4c19d Hari Bathini            2017-05-08  602  	VMCOREINFO_OFFSET(page, compound_head);
692f66f26a4c19d Hari Bathini            2017-05-08  603  	VMCOREINFO_OFFSET(pglist_data, node_zones);
692f66f26a4c19d Hari Bathini            2017-05-08  604  	VMCOREINFO_OFFSET(pglist_data, nr_zones);
43b02ba93b25b1c Mike Rapoport           2021-06-28  605  #ifdef CONFIG_FLATMEM
692f66f26a4c19d Hari Bathini            2017-05-08 @606  	VMCOREINFO_OFFSET(pglist_data, node_mem_map);
692f66f26a4c19d Hari Bathini            2017-05-08  607  #endif
692f66f26a4c19d Hari Bathini            2017-05-08  608  	VMCOREINFO_OFFSET(pglist_data, node_start_pfn);
692f66f26a4c19d Hari Bathini            2017-05-08  609  	VMCOREINFO_OFFSET(pglist_data, node_spanned_pages);
692f66f26a4c19d Hari Bathini            2017-05-08  610  	VMCOREINFO_OFFSET(pglist_data, node_id);
692f66f26a4c19d Hari Bathini            2017-05-08  611  	VMCOREINFO_OFFSET(zone, free_area);
692f66f26a4c19d Hari Bathini            2017-05-08  612  	VMCOREINFO_OFFSET(zone, vm_stat);
692f66f26a4c19d Hari Bathini            2017-05-08  613  	VMCOREINFO_OFFSET(zone, spanned_pages);
692f66f26a4c19d Hari Bathini            2017-05-08  614  	VMCOREINFO_OFFSET(free_area, free_list);
692f66f26a4c19d Hari Bathini            2017-05-08  615  	VMCOREINFO_OFFSET(list_head, next);
692f66f26a4c19d Hari Bathini            2017-05-08  616  	VMCOREINFO_OFFSET(list_head, prev);
692f66f26a4c19d Hari Bathini            2017-05-08  617  	VMCOREINFO_OFFSET(vmap_area, va_start);
692f66f26a4c19d Hari Bathini            2017-05-08  618  	VMCOREINFO_OFFSET(vmap_area, list);
23baf831a32c04f Kirill A. Shutemov      2023-03-15  619  	VMCOREINFO_LENGTH(zone.free_area, MAX_ORDER + 1);
692f66f26a4c19d Hari Bathini            2017-05-08  620  	log_buf_vmcoreinfo_setup();
692f66f26a4c19d Hari Bathini            2017-05-08  621  	VMCOREINFO_LENGTH(free_area.free_list, MIGRATE_TYPES);
692f66f26a4c19d Hari Bathini            2017-05-08  622  	VMCOREINFO_NUMBER(NR_FREE_PAGES);
692f66f26a4c19d Hari Bathini            2017-05-08  623  	VMCOREINFO_NUMBER(PG_lru);
692f66f26a4c19d Hari Bathini            2017-05-08  624  	VMCOREINFO_NUMBER(PG_private);
692f66f26a4c19d Hari Bathini            2017-05-08  625  	VMCOREINFO_NUMBER(PG_swapcache);
1cbf29da3628b66 Petr Tesarik            2018-04-13  626  	VMCOREINFO_NUMBER(PG_swapbacked);
692f66f26a4c19d Hari Bathini            2017-05-08  627  	VMCOREINFO_NUMBER(PG_slab);
692f66f26a4c19d Hari Bathini            2017-05-08  628  #ifdef CONFIG_MEMORY_FAILURE
692f66f26a4c19d Hari Bathini            2017-05-08  629  	VMCOREINFO_NUMBER(PG_hwpoison);
692f66f26a4c19d Hari Bathini            2017-05-08  630  #endif
692f66f26a4c19d Hari Bathini            2017-05-08  631  	VMCOREINFO_NUMBER(PG_head_mask);
6e292b9be7f4358 Matthew Wilcox          2018-06-07  632  #define PAGE_BUDDY_MAPCOUNT_VALUE	(~PG_buddy)
692f66f26a4c19d Hari Bathini            2017-05-08  633  	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
692f66f26a4c19d Hari Bathini            2017-05-08  634  #ifdef CONFIG_HUGETLB_PAGE
692f66f26a4c19d Hari Bathini            2017-05-08  635  	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
e04b742f74c2362 David Hildenbrand       2019-03-05  636  #define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
e04b742f74c2362 David Hildenbrand       2019-03-05  637  	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
692f66f26a4c19d Hari Bathini            2017-05-08  638  #endif
692f66f26a4c19d Hari Bathini            2017-05-08  639  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
