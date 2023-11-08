Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C6F7E503D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjKHGLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHGLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:11:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD2CD41
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699423858; x=1730959858;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KtklnxTpq9D901SpvUbW9estfdRjNF/Br7Kbnw9BtfE=;
  b=a4hZhE7BJ1WXCAdHOcasnO5vW5wEXikU9Ztyq079XYNRCxOhfoXgxjgF
   /M2jY/pofUj4+0IigjE3q4CNjEV+qEVTEBWJOc08p8Rv5SaXpWq6haxWB
   74cxOpMQc1EL/iEzwBoApzGxF+ihB6nXW5cCY4EnR5hTRfoj+nLsw/d1w
   AEZ2tJHt1GiRNUp+Tl2Gv7J016Uyhvnkg8o/Q0kohG8KxTrZS77Q8JYdg
   3P+kkuIfI2VF+5tJ+hEGSrICMkxYI9jri6yts4uR/pw2GYCUHpcvhUGHY
   bErtipbXwuydSphKWHkHEonQX9x9bPvBe89spSit7jb2PVZkwgWMzbCam
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="369036038"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="369036038"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 22:10:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="762953545"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="762953545"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 07 Nov 2023 22:10:54 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r0bm8-0007j9-2M;
        Wed, 08 Nov 2023 06:10:52 +0000
Date:   Wed, 8 Nov 2023 14:10:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/util.h:867:9: sparse: sparse: incorrect type in argument
 1 (different address spaces)
Message-ID: <202311081415.GURBBbjx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   305230142ae0637213bf6e04f6d9f10bbcb74af8
commit: 3598c56eb93b9774d3aa06b3e3c0eab0bbbc26f0 bcachefs: Consolidate trigger code a bit
date:   2 weeks ago
config: loongarch-randconfig-r132-20231107 (https://download.01.org/0day-ci/archive/20231108/202311081415.GURBBbjx-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231108/202311081415.GURBBbjx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311081415.GURBBbjx-lkp@intel.com/

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
