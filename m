Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679F076AA8B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjHAIIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjHAIIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:08:44 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDBC11D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690877323; x=1722413323;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UilbQUR1V8YSg01IAQ1ji1PBg/PJm/4tp4wFo8Cbirw=;
  b=MvBfB519P+hQwOm0cE6pUeFSbsuJ9wFaJRxWk3FUz2Ilqs8nWYZa3WbU
   /wtWopMTA5kWk1yjSYa8XmQqVSHYb82CTPAy8FVcPCe57G0GUzI/kriUd
   BO8/JsXuvwHebkhumLcWcgYsQAfuYLDPbLb5GoqQ3kTeJDYdENUVixCUM
   W0nu9jSkn3dwHiEU3xqj2hRwOSJdnXCcsUdC3QWIWVvL9dDltQKoC7AfG
   r+T/cY1ZQZgPLjePbXk50cjmn8XlHzaG381hvRwNDJSJpApITS+fiIAIS
   NjzQcKc9HbUBucdzya4CcgDNoJVB8ykPeFnkYdMrEaq3zeT3vjwl6Tzua
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="369225321"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="369225321"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 01:08:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="794071752"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="794071752"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2023 01:08:41 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQkQq-00005j-2W;
        Tue, 01 Aug 2023 08:08:40 +0000
Date:   Tue, 1 Aug 2023 16:08:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: arch/sparc/kernel/adi_64.c:125:21: error: no previous prototype for
 'find_tag_store'
Message-ID: <202308011527.n4aoUAHF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
commit: 74a04967482faa7144b93dae3b2e913870dd421c sparc64: Add support for ADI (Application Data Integrity)
date:   5 years ago
config: sparc64-randconfig-r021-20230731 (https://download.01.org/0day-ci/archive/20230801/202308011527.n4aoUAHF-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230801/202308011527.n4aoUAHF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308011527.n4aoUAHF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/sparc/kernel/adi_64.c:125:21: error: no previous prototype for 'find_tag_store' [-Werror=missing-prototypes]
     125 | tag_storage_desc_t *find_tag_store(struct mm_struct *mm,
         |                     ^~~~~~~~~~~~~~
>> arch/sparc/kernel/adi_64.c:157:21: error: no previous prototype for 'alloc_tag_store' [-Werror=missing-prototypes]
     157 | tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
         |                     ^~~~~~~~~~~~~~~
   arch/sparc/kernel/adi_64.c:300:6: error: no previous prototype for 'del_tag_store' [-Werror=missing-prototypes]
     300 | void del_tag_store(tag_storage_desc_t *tag_desc, struct mm_struct *mm)
         |      ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/find_tag_store +125 arch/sparc/kernel/adi_64.c

   124	
 > 125	tag_storage_desc_t *find_tag_store(struct mm_struct *mm,
   126					   struct vm_area_struct *vma,
   127					   unsigned long addr)
   128	{
   129		tag_storage_desc_t *tag_desc = NULL;
   130		unsigned long i, max_desc, flags;
   131	
   132		/* Check if this vma already has tag storage descriptor
   133		 * allocated for it.
   134		 */
   135		max_desc = PAGE_SIZE/sizeof(tag_storage_desc_t);
   136		if (mm->context.tag_store) {
   137			tag_desc = mm->context.tag_store;
   138			spin_lock_irqsave(&mm->context.tag_lock, flags);
   139			for (i = 0; i < max_desc; i++) {
   140				if ((addr >= tag_desc->start) &&
   141				    ((addr + PAGE_SIZE - 1) <= tag_desc->end))
   142					break;
   143				tag_desc++;
   144			}
   145			spin_unlock_irqrestore(&mm->context.tag_lock, flags);
   146	
   147			/* If no matching entries were found, this must be a
   148			 * freshly allocated page
   149			 */
   150			if (i >= max_desc)
   151				tag_desc = NULL;
   152		}
   153	
   154		return tag_desc;
   155	}
   156	
 > 157	tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
   158					    struct vm_area_struct *vma,
   159					    unsigned long addr)
   160	{
   161		unsigned char *tags;
   162		unsigned long i, size, max_desc, flags;
   163		tag_storage_desc_t *tag_desc, *open_desc;
   164		unsigned long end_addr, hole_start, hole_end;
   165	
   166		max_desc = PAGE_SIZE/sizeof(tag_storage_desc_t);
   167		open_desc = NULL;
   168		hole_start = 0;
   169		hole_end = ULONG_MAX;
   170		end_addr = addr + PAGE_SIZE - 1;
   171	
   172		/* Check if this vma already has tag storage descriptor
   173		 * allocated for it.
   174		 */
   175		spin_lock_irqsave(&mm->context.tag_lock, flags);
   176		if (mm->context.tag_store) {
   177			tag_desc = mm->context.tag_store;
   178	
   179			/* Look for a matching entry for this address. While doing
   180			 * that, look for the first open slot as well and find
   181			 * the hole in already allocated range where this request
   182			 * will fit in.
   183			 */
   184			for (i = 0; i < max_desc; i++) {
   185				if (tag_desc->tag_users == 0) {
   186					if (open_desc == NULL)
   187						open_desc = tag_desc;
   188				} else {
   189					if ((addr >= tag_desc->start) &&
   190					    (tag_desc->end >= (addr + PAGE_SIZE - 1))) {
   191						tag_desc->tag_users++;
   192						goto out;
   193					}
   194				}
   195				if ((tag_desc->start > end_addr) &&
   196				    (tag_desc->start < hole_end))
   197					hole_end = tag_desc->start;
   198				if ((tag_desc->end < addr) &&
   199				    (tag_desc->end > hole_start))
   200					hole_start = tag_desc->end;
   201				tag_desc++;
   202			}
   203	
   204		} else {
   205			size = sizeof(tag_storage_desc_t)*max_desc;
   206			mm->context.tag_store = kzalloc(size, GFP_NOWAIT|__GFP_NOWARN);
   207			if (mm->context.tag_store == NULL) {
   208				tag_desc = NULL;
   209				goto out;
   210			}
   211			tag_desc = mm->context.tag_store;
   212			for (i = 0; i < max_desc; i++, tag_desc++)
   213				tag_desc->tag_users = 0;
   214			open_desc = mm->context.tag_store;
   215			i = 0;
   216		}
   217	
   218		/* Check if we ran out of tag storage descriptors */
   219		if (open_desc == NULL) {
   220			tag_desc = NULL;
   221			goto out;
   222		}
   223	
   224		/* Mark this tag descriptor slot in use and then initialize it */
   225		tag_desc = open_desc;
   226		tag_desc->tag_users = 1;
   227	
   228		/* Tag storage has not been allocated for this vma and space
   229		 * is available in tag storage descriptor. Since this page is
   230		 * being swapped out, there is high probability subsequent pages
   231		 * in the VMA will be swapped out as well. Allocate pages to
   232		 * store tags for as many pages in this vma as possible but not
   233		 * more than TAG_STORAGE_PAGES. Each byte in tag space holds
   234		 * two ADI tags since each ADI tag is 4 bits. Each ADI tag
   235		 * covers adi_blksize() worth of addresses. Check if the hole is
   236		 * big enough to accommodate full address range for using
   237		 * TAG_STORAGE_PAGES number of tag pages.
   238		 */
   239		size = TAG_STORAGE_PAGES * PAGE_SIZE;
   240		end_addr = addr + (size*2*adi_blksize()) - 1;
   241		/* Check for overflow. If overflow occurs, allocate only one page */
   242		if (end_addr < addr) {
   243			size = PAGE_SIZE;
   244			end_addr = addr + (size*2*adi_blksize()) - 1;
   245			/* If overflow happens with the minimum tag storage
   246			 * allocation as well, adjust ending address for this
   247			 * tag storage.
   248			 */
   249			if (end_addr < addr)
   250				end_addr = ULONG_MAX;
   251		}
   252		if (hole_end < end_addr) {
   253			/* Available hole is too small on the upper end of
   254			 * address. Can we expand the range towards the lower
   255			 * address and maximize use of this slot?
   256			 */
   257			unsigned long tmp_addr;
   258	
   259			end_addr = hole_end - 1;
   260			tmp_addr = end_addr - (size*2*adi_blksize()) + 1;
   261			/* Check for underflow. If underflow occurs, allocate
   262			 * only one page for storing ADI tags
   263			 */
   264			if (tmp_addr > addr) {
   265				size = PAGE_SIZE;
   266				tmp_addr = end_addr - (size*2*adi_blksize()) - 1;
   267				/* If underflow happens with the minimum tag storage
   268				 * allocation as well, adjust starting address for
   269				 * this tag storage.
   270				 */
   271				if (tmp_addr > addr)
   272					tmp_addr = 0;
   273			}
   274			if (tmp_addr < hole_start) {
   275				/* Available hole is restricted on lower address
   276				 * end as well
   277				 */
   278				tmp_addr = hole_start + 1;
   279			}
   280			addr = tmp_addr;
   281			size = (end_addr + 1 - addr)/(2*adi_blksize());
   282			size = (size + (PAGE_SIZE-adi_blksize()))/PAGE_SIZE;
   283			size = size * PAGE_SIZE;
   284		}
   285		tags = kzalloc(size, GFP_NOWAIT|__GFP_NOWARN);
   286		if (tags == NULL) {
   287			tag_desc->tag_users = 0;
   288			tag_desc = NULL;
   289			goto out;
   290		}
   291		tag_desc->start = addr;
   292		tag_desc->tags = tags;
   293		tag_desc->end = end_addr;
   294	
   295	out:
   296		spin_unlock_irqrestore(&mm->context.tag_lock, flags);
   297		return tag_desc;
   298	}
   299	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
