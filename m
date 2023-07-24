Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D76575F9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGXOTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjGXOTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:19:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F8BE68
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690208354; x=1721744354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oXD+tPYtdhQvR5GUB3Cciez1he74nY/HgHY4epEFtu0=;
  b=GZZetxqXWPiFn4xcjvkx8lQDCYHvxmJlRjPIT64+He9NmupDGqZvLYWy
   K4py+tDqtFflqjKoCft+8sX5u3RwVvRzXdq/b7O2JL4fdacHoMTrrxxDs
   rL3T3BAvO8nWbAR7Csi6uAIPP7jt6JfDjpWdhSDRKjEmxWgFckDGPiQ4M
   khNWAa7508npDwtHepvupIxPs/2A7FYodALoZAuajtayo2obGfv3CCHmB
   oKMdNGi8Fkb125PHke3NT9VqkSwqP9nXgs6jsBu9xZgrQMcK2QR+iDRsu
   38098giM9xsP4q+e4KMSl6x35S+l5bFEHhEsDmG1r+ooxuKcMqrwbxWjX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398360456"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398360456"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 07:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="790982097"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="790982097"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2023 07:19:12 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNwP1-0009lS-34;
        Mon, 24 Jul 2023 14:19:11 +0000
Date:   Mon, 24 Jul 2023 22:18:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: drivers/iommu/io-pgtable-dart.c:157:25: warning: variable 'new' set
 but not used
Message-ID: <202307242225.d5UjdQao-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6eaae198076080886b9e7d57f4ae06fa782f90ef
commit: 9257959a6e5b4fca6fc8e985790bff62c2046f20 locking/atomic: scripts: restructure fallback ifdeffery
date:   7 weeks ago
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20230724/202307242225.d5UjdQao-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230724/202307242225.d5UjdQao-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307242225.d5UjdQao-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iommu/io-pgtable-dart.c: In function 'dart_install_table':
   drivers/iommu/io-pgtable-dart.c:168:13: error: void value not ignored as it ought to be
     168 |         old = cmpxchg64_relaxed(ptep, curr, new);
         |             ^
>> drivers/iommu/io-pgtable-dart.c:157:25: warning: variable 'new' set but not used [-Wunused-but-set-variable]
     157 |         dart_iopte old, new;
         |                         ^~~


vim +/new +157 drivers/iommu/io-pgtable-dart.c

745ef1092bcfcf Janne Grunau 2022-09-16  151  
745ef1092bcfcf Janne Grunau 2022-09-16  152  static dart_iopte dart_install_table(dart_iopte *table,
745ef1092bcfcf Janne Grunau 2022-09-16  153  					     dart_iopte *ptep,
745ef1092bcfcf Janne Grunau 2022-09-16  154  					     dart_iopte curr,
745ef1092bcfcf Janne Grunau 2022-09-16  155  					     struct dart_io_pgtable *data)
745ef1092bcfcf Janne Grunau 2022-09-16  156  {
745ef1092bcfcf Janne Grunau 2022-09-16 @157  	dart_iopte old, new;
745ef1092bcfcf Janne Grunau 2022-09-16  158  
745ef1092bcfcf Janne Grunau 2022-09-16  159  	new = paddr_to_iopte(__pa(table), data) | APPLE_DART_PTE_VALID;
745ef1092bcfcf Janne Grunau 2022-09-16  160  
745ef1092bcfcf Janne Grunau 2022-09-16  161  	/*
745ef1092bcfcf Janne Grunau 2022-09-16  162  	 * Ensure the table itself is visible before its PTE can be.
745ef1092bcfcf Janne Grunau 2022-09-16  163  	 * Whilst we could get away with cmpxchg64_release below, this
745ef1092bcfcf Janne Grunau 2022-09-16  164  	 * doesn't have any ordering semantics when !CONFIG_SMP.
745ef1092bcfcf Janne Grunau 2022-09-16  165  	 */
745ef1092bcfcf Janne Grunau 2022-09-16  166  	dma_wmb();
745ef1092bcfcf Janne Grunau 2022-09-16  167  
745ef1092bcfcf Janne Grunau 2022-09-16  168  	old = cmpxchg64_relaxed(ptep, curr, new);
745ef1092bcfcf Janne Grunau 2022-09-16  169  
745ef1092bcfcf Janne Grunau 2022-09-16  170  	return old;
745ef1092bcfcf Janne Grunau 2022-09-16  171  }
745ef1092bcfcf Janne Grunau 2022-09-16  172  

:::::: The code at line 157 was first introduced by commit
:::::: 745ef1092bcfcf3bca8d82c260947ca498022dde iommu/io-pgtable: Move Apple DART support to its own file

:::::: TO: Janne Grunau <j@jannau.net>
:::::: CC: Joerg Roedel <jroedel@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
