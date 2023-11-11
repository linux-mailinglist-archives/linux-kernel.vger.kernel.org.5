Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7278D7E8B0F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 14:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjKKNdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 08:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKKNdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 08:33:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F103862
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 05:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699709588; x=1731245588;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LrU6aC1tDBy136+Qu1na6xZXMIdDQuWTpdq2jHAuDVI=;
  b=irP5GIDnbyGna21jsXgVf0Z3EX7GEIjt8yDHyJXxI2/As9W4ZxR7DZee
   tlFVMU9OiirVcU17ED4hG7FTPIksdsC+OhzrANor0IPfxGIyq0EPhx0B5
   eGxRBHCFILQjHH3ugv1yVueRSfoaLzWXaCXpc6iS8DMD0e1iYnjQgmzlQ
   3vcZxPeoJd6tOw6h15lNf7KBCOl6xe+s3uudxv60iDCJ+RFlw/SeBeoq1
   Gd9HiHNdJZf4OOucyVWRg62VXLRLwbMiyyng6YzO+IqRZEBXgxoKo+Vgd
   MwMjzawcgNbf0grEIF0QDkB1DCFTF5KdyVsA3ZT2Sf1SA5BeViUQB0TDf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="456771929"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="456771929"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 05:33:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="887550870"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="887550870"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 Nov 2023 05:33:06 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1o6i-000ATn-03;
        Sat, 11 Nov 2023 13:33:04 +0000
Date:   Sat, 11 Nov 2023 21:32:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/util.h:867:9: sparse: sparse: incorrect type in argument
 1 (different address spaces)
Message-ID: <202311112141.R7ZXwhYf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 3598c56eb93b9774d3aa06b3e3c0eab0bbbc26f0 bcachefs: Consolidate trigger code a bit
date:   3 weeks ago
config: loongarch-randconfig-r132-20231107 (https://download.01.org/0day-ci/archive/20231111/202311112141.R7ZXwhYf-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231111/202311112141.R7ZXwhYf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311112141.R7ZXwhYf-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/bcachefs/buckets.c: note: in included file:
   fs/bcachefs/bcachefs.h:845:9: sparse: sparse: array of flexible structures
   fs/bcachefs/buckets.c: note: in included file:
   fs/bcachefs/replicas.h:42:34: sparse: sparse: array of flexible structures
   fs/bcachefs/buckets.c:1125:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bch_fs_usage [noderef] __percpu *fs_usage @@     got struct bch_fs_usage * @@
   fs/bcachefs/buckets.c:1125:26: sparse:     expected struct bch_fs_usage [noderef] __percpu *fs_usage
   fs/bcachefs/buckets.c:1125:26: sparse:     got struct bch_fs_usage *
   fs/bcachefs/buckets.c:1154:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bch_fs_usage [noderef] __percpu *fs_usage @@     got struct bch_fs_usage * @@
   fs/bcachefs/buckets.c:1154:18: sparse:     expected struct bch_fs_usage [noderef] __percpu *fs_usage
   fs/bcachefs/buckets.c:1154:18: sparse:     got struct bch_fs_usage *
   fs/bcachefs/buckets.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got unsigned int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
   include/linux/seqlock.h:269:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   include/linux/seqlock.h:269:9: sparse:     expected void *ptr
   include/linux/seqlock.h:269:9: sparse:     got int [noderef] __percpu *
   fs/bcachefs/buckets.c:403:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bch_fs_usage [noderef] __percpu *fs_usage @@     got struct bch_fs_usage * @@
   fs/bcachefs/buckets.c:403:18: sparse:     expected struct bch_fs_usage [noderef] __percpu *fs_usage
   fs/bcachefs/buckets.c:403:18: sparse:     got struct bch_fs_usage *
   fs/bcachefs/buckets.c:404:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bch_fs_usage *fs_usage @@     got struct bch_fs_usage [noderef] __percpu *fs_usage @@
   fs/bcachefs/buckets.c:404:36: sparse:     expected struct bch_fs_usage *fs_usage
   fs/bcachefs/buckets.c:404:36: sparse:     got struct bch_fs_usage [noderef] __percpu *fs_usage
   fs/bcachefs/buckets.c:405:27: sparse: sparse: dereference of noderef expression
   fs/bcachefs/buckets.c:403:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bch_fs_usage [noderef] __percpu *fs_usage @@     got struct bch_fs_usage * @@
   fs/bcachefs/buckets.c:403:18: sparse:     expected struct bch_fs_usage [noderef] __percpu *fs_usage
   fs/bcachefs/buckets.c:403:18: sparse:     got struct bch_fs_usage *
   fs/bcachefs/buckets.c:404:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bch_fs_usage *fs_usage @@     got struct bch_fs_usage [noderef] __percpu *fs_usage @@
   fs/bcachefs/buckets.c:404:36: sparse:     expected struct bch_fs_usage *fs_usage
   fs/bcachefs/buckets.c:404:36: sparse:     got struct bch_fs_usage [noderef] __percpu *fs_usage
   fs/bcachefs/buckets.c:405:27: sparse: sparse: dereference of noderef expression
   fs/bcachefs/buckets.c: note: in included file (through fs/bcachefs/super.h, fs/bcachefs/buckets.h, fs/bcachefs/alloc_background.h):
   fs/bcachefs/extents.h:145:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got unsigned int const [usertype] csum @@
   fs/bcachefs/extents.h:145:44: sparse:     expected restricted __le32 [usertype]
   fs/bcachefs/extents.h:145:44: sparse:     got unsigned int const [usertype] csum
   fs/bcachefs/extents.h:159:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] @@     got unsigned long long const [usertype] csum_hi:16 @@
   fs/bcachefs/extents.h:159:44: sparse:     expected restricted __le16 [usertype]
   fs/bcachefs/extents.h:159:44: sparse:     got unsigned long long const [usertype] csum_hi:16
   fs/bcachefs/extents.h:145:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got unsigned int const [usertype] csum @@
   fs/bcachefs/extents.h:145:44: sparse:     expected restricted __le32 [usertype]
   fs/bcachefs/extents.h:145:44: sparse:     got unsigned int const [usertype] csum
   fs/bcachefs/extents.h:159:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] @@     got unsigned long long const [usertype] csum_hi:16 @@
   fs/bcachefs/extents.h:159:44: sparse:     expected restricted __le16 [usertype]
   fs/bcachefs/extents.h:159:44: sparse:     got unsigned long long const [usertype] csum_hi:16
   fs/bcachefs/buckets.c:403:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bch_fs_usage [noderef] __percpu *fs_usage @@     got struct bch_fs_usage * @@
   fs/bcachefs/buckets.c:403:18: sparse:     expected struct bch_fs_usage [noderef] __percpu *fs_usage
   fs/bcachefs/buckets.c:403:18: sparse:     got struct bch_fs_usage *
   fs/bcachefs/buckets.c:404:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bch_fs_usage *fs_usage @@     got struct bch_fs_usage [noderef] __percpu *fs_usage @@
   fs/bcachefs/buckets.c:404:36: sparse:     expected struct bch_fs_usage *fs_usage
   fs/bcachefs/buckets.c:404:36: sparse:     got struct bch_fs_usage [noderef] __percpu *fs_usage
   fs/bcachefs/buckets.c:405:27: sparse: sparse: dereference of noderef expression
   fs/bcachefs/buckets.c:403:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bch_fs_usage [noderef] __percpu *fs_usage @@     got struct bch_fs_usage * @@
   fs/bcachefs/buckets.c:403:18: sparse:     expected struct bch_fs_usage [noderef] __percpu *fs_usage
   fs/bcachefs/buckets.c:403:18: sparse:     got struct bch_fs_usage *
   fs/bcachefs/buckets.c:404:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bch_fs_usage *fs_usage @@     got struct bch_fs_usage [noderef] __percpu *fs_usage @@
   fs/bcachefs/buckets.c:404:36: sparse:     expected struct bch_fs_usage *fs_usage
   fs/bcachefs/buckets.c:404:36: sparse:     got struct bch_fs_usage [noderef] __percpu *fs_usage
   fs/bcachefs/buckets.c:405:27: sparse: sparse: dereference of noderef expression
   fs/bcachefs/buckets.c:403:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bch_fs_usage [noderef] __percpu *fs_usage @@     got struct bch_fs_usage * @@
   fs/bcachefs/buckets.c:403:18: sparse:     expected struct bch_fs_usage [noderef] __percpu *fs_usage
   fs/bcachefs/buckets.c:403:18: sparse:     got struct bch_fs_usage *
   fs/bcachefs/buckets.c:404:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct bch_fs_usage *fs_usage @@     got struct bch_fs_usage [noderef] __percpu *fs_usage @@
   fs/bcachefs/buckets.c:404:36: sparse:     expected struct bch_fs_usage *fs_usage
   fs/bcachefs/buckets.c:404:36: sparse:     got struct bch_fs_usage [noderef] __percpu *fs_usage
   fs/bcachefs/buckets.c:405:27: sparse: sparse: dereference of noderef expression
   fs/bcachefs/buckets.c:1126:17: sparse: sparse: dereference of noderef expression
   fs/bcachefs/buckets.c:1127:17: sparse: sparse: dereference of noderef expression
   fs/bcachefs/buckets.c:1158:9: sparse: sparse: dereference of noderef expression
   fs/bcachefs/buckets.c:1159:38: sparse: sparse: dereference of noderef expression
   fs/bcachefs/extents.h:145:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got unsigned int const [usertype] csum @@
   fs/bcachefs/extents.h:145:44: sparse:     expected restricted __le32 [usertype]
   fs/bcachefs/extents.h:145:44: sparse:     got unsigned int const [usertype] csum
   fs/bcachefs/extents.h:159:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] @@     got unsigned long long const [usertype] csum_hi:16 @@
   fs/bcachefs/extents.h:159:44: sparse:     expected restricted __le16 [usertype]
   fs/bcachefs/extents.h:159:44: sparse:     got unsigned long long const [usertype] csum_hi:16
   fs/bcachefs/extents.h:145:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] @@     got unsigned int const [usertype] csum @@
   fs/bcachefs/extents.h:145:44: sparse:     expected restricted __le32 [usertype]
   fs/bcachefs/extents.h:145:44: sparse:     got unsigned int const [usertype] csum
   fs/bcachefs/extents.h:159:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] @@     got unsigned long long const [usertype] csum_hi:16 @@
   fs/bcachefs/extents.h:159:44: sparse:     expected restricted __le16 [usertype]
   fs/bcachefs/extents.h:159:44: sparse:     got unsigned long long const [usertype] csum_hi:16
   fs/bcachefs/buckets.c: note: in included file (through fs/bcachefs/vstructs.h, fs/bcachefs/bcachefs_format.h, fs/bcachefs/bcachefs.h):
>> fs/bcachefs/util.h:867:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] [usertype] __percpu *dst @@
   fs/bcachefs/util.h:867:9: sparse:     expected void *ptr
   fs/bcachefs/util.h:867:9: sparse:     got unsigned long long [noderef] [usertype] __percpu *dst
>> fs/bcachefs/util.h:867:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] [usertype] __percpu *dst @@
   fs/bcachefs/util.h:867:9: sparse:     expected void *ptr
   fs/bcachefs/util.h:867:9: sparse:     got unsigned long long [noderef] [usertype] __percpu *dst
>> fs/bcachefs/util.h:867:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] [usertype] __percpu *dst @@
   fs/bcachefs/util.h:867:9: sparse:     expected void *ptr
   fs/bcachefs/util.h:867:9: sparse:     got unsigned long long [noderef] [usertype] __percpu *dst
>> fs/bcachefs/util.h:867:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] [usertype] __percpu *dst @@
   fs/bcachefs/util.h:867:9: sparse:     expected void *ptr
   fs/bcachefs/util.h:867:9: sparse:     got unsigned long long [noderef] [usertype] __percpu *dst

vim +867 fs/bcachefs/util.h

4c97e04aa8818d Kent Overstreet 2019-02-06  860  
4c97e04aa8818d Kent Overstreet 2019-02-06  861  static inline void percpu_u64_set(u64 __percpu *dst, u64 src)
4c97e04aa8818d Kent Overstreet 2019-02-06  862  {
4c97e04aa8818d Kent Overstreet 2019-02-06  863  	int cpu;
4c97e04aa8818d Kent Overstreet 2019-02-06  864  
4c97e04aa8818d Kent Overstreet 2019-02-06  865  	for_each_possible_cpu(cpu)
4c97e04aa8818d Kent Overstreet 2019-02-06  866  		*per_cpu_ptr(dst, cpu) = 0;
109a4277124ca1 Kent Overstreet 2021-06-10 @867  	this_cpu_write(*dst, src);
4c97e04aa8818d Kent Overstreet 2019-02-06  868  }
4c97e04aa8818d Kent Overstreet 2019-02-06  869  

:::::: The code at line 867 was first introduced by commit
:::::: 109a4277124ca1a0ff670b519315c4f381c83ad3 bcachefs: Don't disable preemption unnecessarily

:::::: TO: Kent Overstreet <kent.overstreet@gmail.com>
:::::: CC: Kent Overstreet <kent.overstreet@linux.dev>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
