Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17E47AC537
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 23:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjIWVdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 17:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWVdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 17:33:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF77180
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695504773; x=1727040773;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JBGlo6WOsz6DkZELNz9eAWy2IQVfyarT9d1nq8dP37A=;
  b=c6tos9E49bCE7ZXCfy7sUjZsxo7s5qpXNmPtupPrSneN6TeAkuBANUl0
   DPGOkWCk5MhfNywZuojUOYspqavz7bM748CB0AAMWScXOifngenipcUQg
   fdJQjVVemvePnnAh+symiodyI9CmTsYjw1ijfc470mCEVJBNFEK2RDsZt
   7NetFM4xYHdOAly8IAZP8zffGb5Z7zdxwuIA2siGLKLMkyVVb2hfp/AW8
   kiJ6xGKLpM+YFSOokRNmZArqZhTpjj0dRWmBX5rFDgkeRhaklqG2oyt70
   QZJhsESfKnrAhnoAC+T5RReajfqFTbTUXBBAykkUXGOGNJKfl7uvcIsaQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="380969959"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="380969959"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2023 14:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10842"; a="921557425"
X-IronPort-AV: E=Sophos;i="6.03,171,1694761200"; 
   d="scan'208";a="921557425"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 23 Sep 2023 14:32:51 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkAF7-0002sn-1y;
        Sat, 23 Sep 2023 21:32:49 +0000
Date:   Sun, 24 Sep 2023 05:32:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rich Felker <dalias@libc.org>
Subject: arch/sh/mm/cache-sh4.c:275:30: warning: variable 'end' set but not
 used
Message-ID: <202309240556.UgGAK6iq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3aba70aed91f2b283f7952be152ad76ec5c34975
commit: ccbb5239d495923cb24b84a73eb814626c5bfa57 sh: remove -Werror from Makefiles
date:   3 years, 1 month ago
config: sh-randconfig-m041-20221209 (https://download.01.org/0day-ci/archive/20230924/202309240556.UgGAK6iq-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230924/202309240556.UgGAK6iq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309240556.UgGAK6iq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from arch/sh/mm/cache-sh4.c:14:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1213:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1213 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1199:27: note: 'mem_section' declared here
    1199 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   arch/sh/mm/cache-sh4.c: In function 'sh4_flush_cache_range':
>> arch/sh/mm/cache-sh4.c:275:30: warning: variable 'end' set but not used [-Wunused-but-set-variable]
     275 |         unsigned long start, end;
         |                              ^~~
>> arch/sh/mm/cache-sh4.c:275:23: warning: variable 'start' set but not used [-Wunused-but-set-variable]
     275 |         unsigned long start, end;
         |                       ^~~~~
   arch/sh/mm/cache-sh4.c: At top level:
>> arch/sh/mm/cache-sh4.c:373:13: warning: no previous prototype for 'sh4_cache_init' [-Wmissing-prototypes]
     373 | void __init sh4_cache_init(void)
         |             ^~~~~~~~~~~~~~
--
   In file included from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from arch/sh/mm/flush-sh4.c:2:
   include/linux/mmzone.h: In function '__nr_to_section':
   include/linux/mmzone.h:1213:13: warning: the comparison will always evaluate as 'true' for the address of 'mem_section' will never be NULL [-Waddress]
    1213 |         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
         |             ^
   include/linux/mmzone.h:1199:27: note: 'mem_section' declared here
    1199 | extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
         |                           ^~~~~~~~~~~
   arch/sh/mm/flush-sh4.c: At top level:
>> arch/sh/mm/flush-sh4.c:106:13: warning: no previous prototype for 'sh4__flush_region_init' [-Wmissing-prototypes]
     106 | void __init sh4__flush_region_init(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~


vim +/end +275 arch/sh/mm/cache-sh4.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  261  
^1da177e4c3f41 Linus Torvalds    2005-04-16  262  /*
^1da177e4c3f41 Linus Torvalds    2005-04-16  263   * Write back and invalidate D-caches.
^1da177e4c3f41 Linus Torvalds    2005-04-16  264   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  265   * START, END: Virtual Address (U0 address)
^1da177e4c3f41 Linus Torvalds    2005-04-16  266   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  267   * NOTE: We need to flush the _physical_ page entry.
^1da177e4c3f41 Linus Torvalds    2005-04-16  268   * Flushing the cache lines for U0 only isn't enough.
^1da177e4c3f41 Linus Torvalds    2005-04-16  269   * We need to flush for P1 too, which may contain aliases.
^1da177e4c3f41 Linus Torvalds    2005-04-16  270   */
f26b2a562b46ab Paul Mundt        2009-08-21  271  static void sh4_flush_cache_range(void *args)
^1da177e4c3f41 Linus Torvalds    2005-04-16  272  {
f26b2a562b46ab Paul Mundt        2009-08-21  273  	struct flusher_data *data = args;
f26b2a562b46ab Paul Mundt        2009-08-21  274  	struct vm_area_struct *vma;
f26b2a562b46ab Paul Mundt        2009-08-21 @275  	unsigned long start, end;
f26b2a562b46ab Paul Mundt        2009-08-21  276  
f26b2a562b46ab Paul Mundt        2009-08-21  277  	vma = data->vma;
f26b2a562b46ab Paul Mundt        2009-08-21  278  	start = data->addr1;
f26b2a562b46ab Paul Mundt        2009-08-21  279  	end = data->addr2;
f26b2a562b46ab Paul Mundt        2009-08-21  280  
e7b8b7f16edc9b Paul Mundt        2009-08-15  281  	if (cpu_context(smp_processor_id(), vma->vm_mm) == NO_CONTEXT)
e7b8b7f16edc9b Paul Mundt        2009-08-15  282  		return;
e7b8b7f16edc9b Paul Mundt        2009-08-15  283  
b638d0b921dc95 Richard Curnow    2006-09-27  284  	/*
b638d0b921dc95 Richard Curnow    2006-09-27  285  	 * If cache is only 4k-per-way, there are never any 'aliases'.  Since
b638d0b921dc95 Richard Curnow    2006-09-27  286  	 * the cache is physically tagged, the data can just be left in there.
b638d0b921dc95 Richard Curnow    2006-09-27  287  	 */
7ec9d6f8c0e693 Paul Mundt        2007-09-21  288  	if (boot_cpu_data.dcache.n_aliases == 0)
b638d0b921dc95 Richard Curnow    2006-09-27  289  		return;
b638d0b921dc95 Richard Curnow    2006-09-27  290  
a252710fc5b63b Paul Mundt        2006-09-27  291  	flush_dcache_all();
b638d0b921dc95 Richard Curnow    2006-09-27  292  
654d364e26c797 Paul Mundt        2009-09-09  293  	if (vma->vm_flags & VM_EXEC)
^1da177e4c3f41 Linus Torvalds    2005-04-16  294  		flush_icache_all();
^1da177e4c3f41 Linus Torvalds    2005-04-16  295  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  296  
b638d0b921dc95 Richard Curnow    2006-09-27  297  /**
a7a7c0e1d12bcf Valentin Sitdikov 2009-10-16  298   * __flush_cache_one
b638d0b921dc95 Richard Curnow    2006-09-27  299   *
b638d0b921dc95 Richard Curnow    2006-09-27  300   * @addr:  address in memory mapped cache array
b638d0b921dc95 Richard Curnow    2006-09-27  301   * @phys:  P1 address to flush (has to match tags if addr has 'A' bit
b638d0b921dc95 Richard Curnow    2006-09-27  302   *         set i.e. associative write)
b638d0b921dc95 Richard Curnow    2006-09-27  303   * @exec_offset: set to 0x20000000 if flush has to be executed from P2
b638d0b921dc95 Richard Curnow    2006-09-27  304   *               region else 0x0
b638d0b921dc95 Richard Curnow    2006-09-27  305   *
b638d0b921dc95 Richard Curnow    2006-09-27  306   * The offset into the cache array implied by 'addr' selects the
b638d0b921dc95 Richard Curnow    2006-09-27  307   * 'colour' of the virtual address range that will be flushed.  The
b638d0b921dc95 Richard Curnow    2006-09-27  308   * operation (purge/write-back) is selected by the lower 2 bits of
b638d0b921dc95 Richard Curnow    2006-09-27  309   * 'phys'.
b638d0b921dc95 Richard Curnow    2006-09-27  310   */
a7a7c0e1d12bcf Valentin Sitdikov 2009-10-16  311  static void __flush_cache_one(unsigned long addr, unsigned long phys,
b638d0b921dc95 Richard Curnow    2006-09-27  312  			       unsigned long exec_offset)
b638d0b921dc95 Richard Curnow    2006-09-27  313  {
b638d0b921dc95 Richard Curnow    2006-09-27  314  	int way_count;
b638d0b921dc95 Richard Curnow    2006-09-27  315  	unsigned long base_addr = addr;
b638d0b921dc95 Richard Curnow    2006-09-27  316  	struct cache_info *dcache;
b638d0b921dc95 Richard Curnow    2006-09-27  317  	unsigned long way_incr;
b638d0b921dc95 Richard Curnow    2006-09-27  318  	unsigned long a, ea, p;
b638d0b921dc95 Richard Curnow    2006-09-27  319  	unsigned long temp_pc;
b638d0b921dc95 Richard Curnow    2006-09-27  320  
7ec9d6f8c0e693 Paul Mundt        2007-09-21  321  	dcache = &boot_cpu_data.dcache;
b638d0b921dc95 Richard Curnow    2006-09-27  322  	/* Write this way for better assembly. */
b638d0b921dc95 Richard Curnow    2006-09-27  323  	way_count = dcache->ways;
b638d0b921dc95 Richard Curnow    2006-09-27  324  	way_incr = dcache->way_incr;
b638d0b921dc95 Richard Curnow    2006-09-27  325  
b638d0b921dc95 Richard Curnow    2006-09-27  326  	/*
b638d0b921dc95 Richard Curnow    2006-09-27  327  	 * Apply exec_offset (i.e. branch to P2 if required.).
b638d0b921dc95 Richard Curnow    2006-09-27  328  	 *
b638d0b921dc95 Richard Curnow    2006-09-27  329  	 * FIXME:
b638d0b921dc95 Richard Curnow    2006-09-27  330  	 *
b638d0b921dc95 Richard Curnow    2006-09-27  331  	 *	If I write "=r" for the (temp_pc), it puts this in r6 hence
b638d0b921dc95 Richard Curnow    2006-09-27  332  	 *	trashing exec_offset before it's been added on - why?  Hence
b638d0b921dc95 Richard Curnow    2006-09-27  333  	 *	"=&r" as a 'workaround'
b638d0b921dc95 Richard Curnow    2006-09-27  334  	 */
b638d0b921dc95 Richard Curnow    2006-09-27  335  	asm volatile("mov.l 1f, %0\n\t"
b638d0b921dc95 Richard Curnow    2006-09-27  336  		     "add   %1, %0\n\t"
b638d0b921dc95 Richard Curnow    2006-09-27  337  		     "jmp   @%0\n\t"
b638d0b921dc95 Richard Curnow    2006-09-27  338  		     "nop\n\t"
b638d0b921dc95 Richard Curnow    2006-09-27  339  		     ".balign 4\n\t"
b638d0b921dc95 Richard Curnow    2006-09-27  340  		     "1:  .long 2f\n\t"
b638d0b921dc95 Richard Curnow    2006-09-27  341  		     "2:\n" : "=&r" (temp_pc) : "r" (exec_offset));
b638d0b921dc95 Richard Curnow    2006-09-27  342  
b638d0b921dc95 Richard Curnow    2006-09-27  343  	/*
b638d0b921dc95 Richard Curnow    2006-09-27  344  	 * We know there will be >=1 iteration, so write as do-while to avoid
b638d0b921dc95 Richard Curnow    2006-09-27  345  	 * pointless nead-of-loop check for 0 iterations.
b638d0b921dc95 Richard Curnow    2006-09-27  346  	 */
b638d0b921dc95 Richard Curnow    2006-09-27  347  	do {
b638d0b921dc95 Richard Curnow    2006-09-27  348  		ea = base_addr + PAGE_SIZE;
b638d0b921dc95 Richard Curnow    2006-09-27  349  		a = base_addr;
b638d0b921dc95 Richard Curnow    2006-09-27  350  		p = phys;
b638d0b921dc95 Richard Curnow    2006-09-27  351  
b638d0b921dc95 Richard Curnow    2006-09-27  352  		do {
b638d0b921dc95 Richard Curnow    2006-09-27  353  			*(volatile unsigned long *)a = p;
b638d0b921dc95 Richard Curnow    2006-09-27  354  			/*
b638d0b921dc95 Richard Curnow    2006-09-27  355  			 * Next line: intentionally not p+32, saves an add, p
b638d0b921dc95 Richard Curnow    2006-09-27  356  			 * will do since only the cache tag bits need to
b638d0b921dc95 Richard Curnow    2006-09-27  357  			 * match.
b638d0b921dc95 Richard Curnow    2006-09-27  358  			 */
b638d0b921dc95 Richard Curnow    2006-09-27  359  			*(volatile unsigned long *)(a+32) = p;
b638d0b921dc95 Richard Curnow    2006-09-27  360  			a += 64;
b638d0b921dc95 Richard Curnow    2006-09-27  361  			p += 64;
b638d0b921dc95 Richard Curnow    2006-09-27  362  		} while (a < ea);
b638d0b921dc95 Richard Curnow    2006-09-27  363  
b638d0b921dc95 Richard Curnow    2006-09-27  364  		base_addr += way_incr;
b638d0b921dc95 Richard Curnow    2006-09-27  365  	} while (--way_count != 0);
b638d0b921dc95 Richard Curnow    2006-09-27  366  }
b638d0b921dc95 Richard Curnow    2006-09-27  367  
37443ef3f0406e Paul Mundt        2009-08-15  368  extern void __weak sh4__flush_region_init(void);
37443ef3f0406e Paul Mundt        2009-08-15  369  
37443ef3f0406e Paul Mundt        2009-08-15  370  /*
37443ef3f0406e Paul Mundt        2009-08-15  371   * SH-4 has virtually indexed and physically tagged cache.
37443ef3f0406e Paul Mundt        2009-08-15  372   */
37443ef3f0406e Paul Mundt        2009-08-15 @373  void __init sh4_cache_init(void)

:::::: The code at line 275 was first introduced by commit
:::::: f26b2a562b46ab186c8383993ab1332673ac4a47 sh: Make cache flushers SMP-aware.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
