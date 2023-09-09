Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63F5799783
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 13:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbjIILBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 07:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344674AbjIILBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:01:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF49CCFD
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694257274; x=1725793274;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bWYFh3R0xNe5KLzrae2y3MAyY4PaR0XHBbdayXWcTJQ=;
  b=DfGd2eugDfkH936kj5kqC5EkQMLOQhThmR8VXdDkflt8GO7vI9YzGUeg
   sF/P6kNEU1MYWdDPBctmLuuCBG5hg3NKM8f4VzAKF5bfZrz0zQPnnZnVB
   Quto7UVEshPT49o0+OeifSYSjz+PM7zgbud/277zwo2+o/WtttfdvNHYu
   0kEK9SQQ7oMR+OX/hok/Gj+nifxURhfjVvWY1RgpG7tx//0I79ML+5gbv
   +1EGYcxoAnpFeEhwnT9PbFJ2g81vMIXTRriMdmW1eGZJTenY8/5dFJsjH
   O4K8oNaAAbS/3sKV3YYc7Tw6M8/9z96g+LmHGsby6xH9Z2UxD1kl2qGgm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="368073146"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="368073146"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 04:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="916464745"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="916464745"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Sep 2023 04:01:12 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeviA-0003Ly-1o;
        Sat, 09 Sep 2023 11:01:10 +0000
Date:   Sat, 9 Sep 2023 19:01:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: drivers/iommu/io-pgtable-dart.c:157:25: warning: variable 'new' set
 but not used
Message-ID: <202309091804.8DRVOiw1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6099776f9f268e61fe5ecd721f994a8cfce5306f
commit: 9257959a6e5b4fca6fc8e985790bff62c2046f20 locking/atomic: scripts: restructure fallback ifdeffery
date:   3 months ago
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20230909/202309091804.8DRVOiw1-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309091804.8DRVOiw1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309091804.8DRVOiw1-lkp@intel.com/

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
