Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EE37E8A76
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 12:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjKKLEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 06:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjKKLEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 06:04:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E403C0C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 03:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699700684; x=1731236684;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/cQP6OUL8SiUIpuaqvofKt2MCRKems7KPpSi6bvUQ6M=;
  b=NxF3fNSawNYOsgnz2V3Ey0AhEwTp0KaycXwjRH89TQjb6JoIgLYIDRBt
   2y0MYXlnhEP7amaDWrbGOt6dYx4DdhA3bv4ckawEkYjsoMt/Sql8+cDC2
   NiaZaOnECUUAYExyyDezcvQuDHgHjvQxQEWJX2+WORZrLm+J62kGavzDr
   XhS4TQmR69zqiBI+WXgm8pGcZAqANERl4FtbIJGDZv+J4f8okv5iO/kBd
   XZMnVSUvfVTKeBPn052vFMW28wzBwaZN4KQSb7zbi4+PI+ZIAPsF+2sK/
   gw4RvhX3HQarN67+2QS7oF55nN5sLsL5vyrvtCjGQYo3h6eU4UJEKi+kz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="369601037"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="369601037"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 03:04:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="12050367"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 11 Nov 2023 03:04:42 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1ln6-000AOL-0G;
        Sat, 11 Nov 2023 11:04:40 +0000
Date:   Sat, 11 Nov 2023 19:03:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202311111802.ZGyZEDyi-lkp@intel.com>
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
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: 7e94eeffe0e79a54e525ad05302eb454fb96affd bcachefs: Inline fastpath of bch2_disk_reservation_add()
date:   3 weeks ago
config: loongarch-randconfig-r132-20231107 (https://download.01.org/0day-ci/archive/20231111/202311111802.ZGyZEDyi-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231111/202311111802.ZGyZEDyi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111802.ZGyZEDyi-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/bcachefs/extent_update.c: note: in included file:
   fs/bcachefs/bcachefs.h:786:9: sparse: sparse: array of flexible structures
   fs/bcachefs/extent_update.c: note: in included file:
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
--
   fs/bcachefs/btree_update_interior.c: note: in included file (through fs/bcachefs/bcachefs.h):
   fs/bcachefs/bcachefs_format.h:1101:45: sparse: sparse: array of flexible structures
   fs/bcachefs/bcachefs_format.h:1116:42: sparse: sparse: array of flexible structures
   fs/bcachefs/btree_update_interior.c: note: in included file:
   fs/bcachefs/bcachefs.h:786:9: sparse: sparse: array of flexible structures
   fs/bcachefs/btree_update_interior.c:1810:6: sparse: sparse: symbol 'async_btree_node_rewrite_work' was not declared. Should it be static?
   fs/bcachefs/btree_update_interior.c: note: in included file:
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
   fs/bcachefs/btree_update_interior.c: note: in included file:
   fs/bcachefs/btree_cache.h:45:54: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __le64 const [usertype] seq @@
   fs/bcachefs/btree_cache.h:45:54: sparse:     expected unsigned long long
   fs/bcachefs/btree_cache.h:45:54: sparse:     got restricted __le64 const [usertype] seq
   fs/bcachefs/btree_cache.h:45:54: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned long long @@     got restricted __le64 const [usertype] seq @@
   fs/bcachefs/btree_cache.h:45:54: sparse:     expected unsigned long long
   fs/bcachefs/btree_cache.h:45:54: sparse:     got restricted __le64 const [usertype] seq
--
   fs/bcachefs/ec.c: note: in included file (through fs/bcachefs/bcachefs.h):
   fs/bcachefs/bcachefs_format.h:1101:45: sparse: sparse: array of flexible structures
   fs/bcachefs/bcachefs_format.h:1116:42: sparse: sparse: array of flexible structures
   fs/bcachefs/ec.c:401:26: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted blk_opf_t [usertype] opf @@     got unsigned int rw @@
   fs/bcachefs/ec.c:401:26: sparse:     expected restricted blk_opf_t [usertype] opf
   fs/bcachefs/ec.c:401:26: sparse:     got unsigned int rw
   fs/bcachefs/ec.c: note: in included file:
   fs/bcachefs/bcachefs.h:786:9: sparse: sparse: array of flexible structures
   fs/bcachefs/ec.c:401:26: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted blk_opf_t [usertype] opf @@     got unsigned int rw @@
   fs/bcachefs/ec.c:401:26: sparse:     expected restricted blk_opf_t [usertype] opf
   fs/bcachefs/ec.c:401:26: sparse:     got unsigned int rw
   fs/bcachefs/ec.c:401:26: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted blk_opf_t [usertype] opf @@     got unsigned int rw @@
   fs/bcachefs/ec.c:401:26: sparse:     expected restricted blk_opf_t [usertype] opf
   fs/bcachefs/ec.c:401:26: sparse:     got unsigned int rw
   fs/bcachefs/ec.c:499:37: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int rw @@     got restricted blk_opf_t @@
   fs/bcachefs/ec.c:499:37: sparse:     expected unsigned int rw
   fs/bcachefs/ec.c:499:37: sparse:     got restricted blk_opf_t
   fs/bcachefs/ec.c:934:48: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int rw @@     got restricted blk_opf_t @@
   fs/bcachefs/ec.c:934:48: sparse:     expected unsigned int rw
   fs/bcachefs/ec.c:934:48: sparse:     got restricted blk_opf_t
   fs/bcachefs/ec.c:1243:23: sparse: sparse: symbol '__bch2_ec_stripe_head_get' was not declared. Should it be static?
   fs/bcachefs/ec.c:1423:9: sparse: sparse: restricted __le16 degrades to integer
   fs/bcachefs/ec.c: note: in included file:
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
--
   fs/bcachefs/fs-io.c: note: in included file (through fs/bcachefs/bcachefs.h):
   fs/bcachefs/bcachefs_format.h:1101:45: sparse: sparse: array of flexible structures
   fs/bcachefs/bcachefs_format.h:1116:42: sparse: sparse: array of flexible structures
   fs/bcachefs/fs-io.c: note: in included file:
   fs/bcachefs/bcachefs.h:786:9: sparse: sparse: array of flexible structures
   fs/bcachefs/fs-io.c:550:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int ret @@     got restricted vm_fault_t @@
   fs/bcachefs/fs-io.c:550:13: sparse:     expected int ret
   fs/bcachefs/fs-io.c:550:13: sparse:     got restricted vm_fault_t
   fs/bcachefs/fs-io.c:553:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted vm_fault_t @@     got int ret @@
   fs/bcachefs/fs-io.c:553:16: sparse:     expected restricted vm_fault_t
   fs/bcachefs/fs-io.c:553:16: sparse:     got int ret
   fs/bcachefs/fs-io.c:566:19: sparse: sparse: incorrect type in initializer (different base types) @@     expected int ret @@     got restricted vm_fault_t @@
   fs/bcachefs/fs-io.c:566:19: sparse:     expected int ret
   fs/bcachefs/fs-io.c:566:19: sparse:     got restricted vm_fault_t
   fs/bcachefs/fs-io.c:586:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected int ret @@     got restricted vm_fault_t @@
   fs/bcachefs/fs-io.c:586:21: sparse:     expected int ret
   fs/bcachefs/fs-io.c:586:21: sparse:     got restricted vm_fault_t
   fs/bcachefs/fs-io.c:594:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected int ret @@     got restricted vm_fault_t @@
   fs/bcachefs/fs-io.c:594:21: sparse:     expected int ret
   fs/bcachefs/fs-io.c:594:21: sparse:     got restricted vm_fault_t
   fs/bcachefs/fs-io.c:606:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted vm_fault_t @@     got int ret @@
   fs/bcachefs/fs-io.c:606:16: sparse:     expected restricted vm_fault_t
   fs/bcachefs/fs-io.c:606:16: sparse:     got int ret
   fs/bcachefs/fs-io.c: note: in included file:
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
   fs/bcachefs/fs-io.c: note: in included file (through fs/bcachefs/super.h, fs/bcachefs/buckets.h):
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
   fs/bcachefs/fs-io.c: note: in included file:
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
--
   fs/bcachefs/move.c: note: in included file (through fs/bcachefs/bcachefs.h):
   fs/bcachefs/bcachefs_format.h:1101:45: sparse: sparse: array of flexible structures
   fs/bcachefs/bcachefs_format.h:1116:42: sparse: sparse: array of flexible structures
   fs/bcachefs/move.c: note: in included file:
   fs/bcachefs/bcachefs.h:786:9: sparse: sparse: array of flexible structures
   fs/bcachefs/move.c:928:42: sparse: sparse: invalid assignment: |=
   fs/bcachefs/move.c:928:42: sparse:    left side has type restricted __le64
   fs/bcachefs/move.c:928:42: sparse:    right side has type unsigned long long
   fs/bcachefs/move.c:929:42: sparse: sparse: invalid assignment: |=
   fs/bcachefs/move.c:929:42: sparse:    left side has type restricted __le64
   fs/bcachefs/move.c:929:42: sparse:    right side has type unsigned long long
   fs/bcachefs/move.c: note: in included file (through fs/bcachefs/super.h, fs/bcachefs/buckets.h):
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
   fs/bcachefs/move.c: note: in included file:
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
   fs/bcachefs/move.c: note: in included file (through fs/bcachefs/super.h, fs/bcachefs/buckets.h):
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
   fs/bcachefs/move.c: note: in included file:
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
   fs/bcachefs/move.c: note: in included file (through fs/bcachefs/super.h, fs/bcachefs/buckets.h):
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
--
   fs/bcachefs/io.c: note: in included file (through fs/bcachefs/bcachefs.h):
   fs/bcachefs/bcachefs_format.h:1101:45: sparse: sparse: array of flexible structures
   fs/bcachefs/bcachefs_format.h:1116:42: sparse: sparse: array of flexible structures
   fs/bcachefs/io.c: note: in included file:
   fs/bcachefs/bcachefs.h:786:9: sparse: sparse: array of flexible structures
   fs/bcachefs/io.c: note: in included file:
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
--
   fs/bcachefs/journal.c: note: in included file (through fs/bcachefs/bcachefs.h):
   fs/bcachefs/bcachefs_format.h:1101:45: sparse: sparse: array of flexible structures
   fs/bcachefs/bcachefs_format.h:1116:42: sparse: sparse: array of flexible structures
   fs/bcachefs/journal.c: note: in included file:
   fs/bcachefs/bcachefs.h:786:9: sparse: sparse: array of flexible structures
   fs/bcachefs/journal.c:861:17: sparse: sparse: context imbalance in '__bch2_set_nr_journal_buckets' - different lock contexts for basic block
   fs/bcachefs/journal.c: note: in included file:
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *
>> fs/bcachefs/buckets.h:282:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned long long [noderef] __percpu * @@
   fs/bcachefs/buckets.h:282:23: sparse:     expected void *ptr
   fs/bcachefs/buckets.h:282:23: sparse:     got unsigned long long [noderef] __percpu *

vim +282 fs/bcachefs/buckets.h

   271	
   272	int __bch2_disk_reservation_add(struct bch_fs *,
   273					struct disk_reservation *,
   274					u64, int);
   275	
   276	static inline int bch2_disk_reservation_add(struct bch_fs *c, struct disk_reservation *res,
   277						    u64 sectors, int flags)
   278	{
   279		u64 old, new;
   280	
   281		do {
 > 282			old = this_cpu_read(c->pcpu->sectors_available);
   283			if (sectors > old)
   284				return __bch2_disk_reservation_add(c, res, sectors, flags);
   285	
   286			new = old - sectors;
   287		} while (this_cpu_cmpxchg(c->pcpu->sectors_available, old, new) != old);
   288	
   289		this_cpu_add(*c->online_reserved, sectors);
   290		res->sectors			+= sectors;
   291		return 0;
   292	}
   293	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
