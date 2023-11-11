Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1134C7E8CD6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 22:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjKKVWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 16:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjKKVWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 16:22:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBC79F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 13:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699737765; x=1731273765;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UeBqz1SKWAe5JA7bSe3MeN1sci4Z3cTezzW/EyKhXNk=;
  b=dYup5hq+Jt0eEKAigb+3k2GOZrFhwQgJ3cIgaJ1rbJ4t6j1E/7Pd2vkY
   zdks+NDqo3mrDYUgVLBn0+0Gh6Hcg61UunRIEbw8x+b8JM43gM6X7QMVb
   LjEHf95VxNnqXL9/a7vUYrpOG8tloiVaDFZxuEu7KvdNjU766zJW2U9Qy
   2dlUnXIZ9MZ3RKVI7rYyiDTuRx4j1NZ+rgQ0n33fs8Se+rZ/TZDK/DZZa
   ok5NKa0O0FsiWL2xIIUhcjZfpiEmr5MoPSahyzkUa9kOkue/EfU//ONqQ
   AeaUyEHbne8f/54T4h2JBp+AesQBCTQCOJVMcvnZwLBNjk8/v4DHX3fM9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="454599138"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="454599138"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 13:22:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="1095429068"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="1095429068"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Nov 2023 13:22:43 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1vRA-000Am1-35;
        Sat, 11 Nov 2023 21:22:40 +0000
Date:   Sun, 12 Nov 2023 05:22:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/block/drbd/drbd_main.c:3279:33: sparse: sparse: cast to
 restricted __be64
Message-ID: <202311120516.wfIgNSys-lkp@intel.com>
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
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   2 years, 6 months ago
config: i386-randconfig-062-20230914 (https://download.01.org/0day-ci/archive/20231112/202311120516.wfIgNSys-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311120516.wfIgNSys-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311120516.wfIgNSys-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/block/drbd/drbd_main.c:1393:31: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1406:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1406:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1406:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1407:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1407:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1407:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1422:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1422:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1422:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1424:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1424:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1424:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1440:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1440:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1440:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1442:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1442:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1442:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1455:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1455:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1455:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1457:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1457:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1457:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1680:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1680:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1680:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1682:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] seq_num @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1682:20: sparse:     expected unsigned int [usertype] seq_num
   drivers/block/drbd/drbd_main.c:1682:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1696:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dp_flags @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1696:21: sparse:     expected unsigned int [usertype] dp_flags
   drivers/block/drbd/drbd_main.c:1696:21: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1701:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1701:25: sparse:     expected unsigned int [usertype] size
   drivers/block/drbd/drbd_main.c:1701:25: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1711:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1711:29: sparse:     expected unsigned int [usertype] size
   drivers/block/drbd/drbd_main.c:1711:29: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1787:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1787:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1787:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1810:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] sector @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:1810:19: sparse:     expected unsigned long long [usertype] sector
   drivers/block/drbd/drbd_main.c:1810:19: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:1811:20: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] blksize @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:1811:20: sparse:     expected unsigned int [usertype] blksize
   drivers/block/drbd/drbd_main.c:1811:20: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:1847:40: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_main.c:1847:40: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:1847:40: sparse:    struct net_conf *
   drivers/block/drbd/drbd_main.c:3020:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] la_size_sect @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:3020:30: sparse:     expected unsigned long long [usertype] la_size_sect
   drivers/block/drbd/drbd_main.c:3020:30: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:3022:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:3022:33: sparse:     expected unsigned long long
   drivers/block/drbd/drbd_main.c:3022:33: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:3023:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] flags @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3023:23: sparse:     expected unsigned int [usertype] flags
   drivers/block/drbd/drbd_main.c:3023:23: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3024:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] magic @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3024:23: sparse:     expected unsigned int [usertype] magic
   drivers/block/drbd/drbd_main.c:3024:23: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3026:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] md_size_sect @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3026:31: sparse:     expected unsigned int [usertype] md_size_sect
   drivers/block/drbd/drbd_main.c:3026:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3027:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_offset @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3027:31: sparse:     expected unsigned int [usertype] al_offset
   drivers/block/drbd/drbd_main.c:3027:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3028:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_nr_extents @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3028:31: sparse:     expected unsigned int [usertype] al_nr_extents
   drivers/block/drbd/drbd_main.c:3028:31: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3029:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bm_bytes_per_bit @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3029:34: sparse:     expected unsigned int [usertype] bm_bytes_per_bit
   drivers/block/drbd/drbd_main.c:3029:34: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3030:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] device_uuid @@     got restricted __be64 [usertype] @@
   drivers/block/drbd/drbd_main.c:3030:29: sparse:     expected unsigned long long [usertype] device_uuid
   drivers/block/drbd/drbd_main.c:3030:29: sparse:     got restricted __be64 [usertype]
   drivers/block/drbd/drbd_main.c:3032:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] bm_offset @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3032:27: sparse:     expected unsigned int [usertype] bm_offset
   drivers/block/drbd/drbd_main.c:3032:27: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3033:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] la_peer_max_bio_size @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3033:38: sparse:     expected unsigned int [usertype] la_peer_max_bio_size
   drivers/block/drbd/drbd_main.c:3033:38: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3035:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_stripes @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3035:28: sparse:     expected unsigned int [usertype] al_stripes
   drivers/block/drbd/drbd_main.c:3035:28: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3036:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_stripe_size_4k @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_main.c:3036:35: sparse:     expected unsigned int [usertype] al_stripe_size_4k
   drivers/block/drbd/drbd_main.c:3036:35: sparse:     got restricted __be32 [usertype]
   drivers/block/drbd/drbd_main.c:3089:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3090:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3252:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3253:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3271:13: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3272:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3272:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3272:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3272:17: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_main.c:3279:33: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_main.c:3281:36: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_main.c:3282:26: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3283:32: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_main.c:3285:33: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3286:30: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3287:30: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3294:13: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3295:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3295:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3295:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3295:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3299:13: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3300:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3300:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3300:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3300:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3310:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_main.c:3693:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_main.c:3693:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_main.c:3693:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_main.c:860:9: sparse: sparse: context imbalance in 'drbd_print_uuids' - different lock contexts for basic block
   drivers/block/drbd/drbd_main.c: note: in included file:
   drivers/block/drbd/drbd_int.h:2141:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:2141:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2141:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:2141:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:2141:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2141:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:2141:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:2141:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2141:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_int.h:1722:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:1722:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:1722:14: sparse:    struct disk_conf *
--
   drivers/block/drbd/drbd_receiver.c:1169:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1173:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1174:28: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1179:27: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:1180:28: sparse: sparse: cast to restricted __be16
   drivers/block/drbd/drbd_receiver.c:822:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:822:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:822:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:877:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:877:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:877:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:1042:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:1042:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:1042:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:1434:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:1434:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:1434:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:1588:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:1588:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:1588:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:1893:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1897:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:1909:22: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2157:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2191:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2405:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:2405:22: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:2405:22: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:2415:27: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:2415:27: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:2415:27: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:2594:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2622:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2633:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:2666:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:2666:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:2666:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:2798:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:2798:22: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:2798:22: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:2854:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:2855:18: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3066:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3066:23: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3066:23: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3142:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3142:23: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3142:23: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3199:23: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3199:23: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3199:23: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3545:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3545:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3545:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3677:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3678:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3679:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3680:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3681:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3682:27: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:3703:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3703:22: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3703:22: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3789:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:3789:9: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:3789:9: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:3946:46: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4005:55: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4006:57: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4007:56: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4008:53: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4044:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4044:25: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4044:25: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:4049:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4049:17: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4049:17: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:4055:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4055:17: sparse:    struct fifo_buffer [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4055:17: sparse:    struct fifo_buffer *
   drivers/block/drbd/drbd_receiver.c:4122:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:4123:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:4124:19: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:4132:28: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4132:28: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4132:28: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:4174:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:4174:25: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:4174:25: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_receiver.c:4297:29: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:4397:18: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4398:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4423:18: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4424:17: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4456:24: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:4660:52: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:4987:9: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:4987:9: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5005:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5006:16: sparse: sparse: cast to restricted __be32
>> drivers/block/drbd/drbd_receiver.c:5315:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] protocol_min @@     got restricted __be32 [usertype] @@
>> drivers/block/drbd/drbd_receiver.c:5316:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] protocol_max @@     got restricted __be32 [usertype] @@
>> drivers/block/drbd/drbd_receiver.c:5317:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] feature_flags @@     got restricted __be32 [usertype] @@
   drivers/block/drbd/drbd_receiver.c:5626:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5645:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5690:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5691:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5700:38: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5742:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5743:23: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5751:38: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5788:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5789:20: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5797:38: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5824:27: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5831:38: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5833:9: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5833:9: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5833:9: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5833:9: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5854:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5855:16: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5857:38: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5884:44: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5916:18: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5917:16: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5919:38: sparse: sparse: cast to restricted __be32
   drivers/block/drbd/drbd_receiver.c:5921:13: sparse: sparse: cast to restricted __be64
   drivers/block/drbd/drbd_receiver.c:5970:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:5970:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:5970:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:6060:37: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:6060:37: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:6060:37: sparse:    struct net_conf *
   drivers/block/drbd/drbd_receiver.c:6157:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_receiver.c:6157:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_receiver.c:6157:14: sparse:    struct net_conf *
--
   drivers/scsi/libfc/fc_libfc.c:197:26: sparse: sparse: cast to restricted __be16
>> drivers/scsi/libfc/fc_libfc.c:197:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] fh_seq_cnt @@     got unsigned short [usertype] @@
   drivers/scsi/libfc/fc_libfc.c:197:24: sparse:     expected restricted __be16 [usertype] fh_seq_cnt
   drivers/scsi/libfc/fc_libfc.c:197:24: sparse:     got unsigned short [usertype]
   drivers/scsi/libfc/fc_libfc.c:287:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/scsi/libfc/fc_libfc.c:287:17: sparse:    struct fc4_prov [noderef] __rcu *
   drivers/scsi/libfc/fc_libfc.c:287:17: sparse:    struct fc4_prov *
   drivers/scsi/libfc/fc_libfc.c:289:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/scsi/libfc/fc_libfc.c:289:17: sparse:    struct fc4_prov [noderef] __rcu *
   drivers/scsi/libfc/fc_libfc.c:289:17: sparse:    struct fc4_prov *

vim +3279 drivers/block/drbd/drbd_main.c

c04ccaa669e147 Lars Ellenberg      2013-03-19  3208  
c04ccaa669e147 Lars Ellenberg      2013-03-19  3209  
b411b3637fa71f Philipp Reisner     2009-09-25  3210  /**
b411b3637fa71f Philipp Reisner     2009-09-25  3211   * drbd_md_read() - Reads in the meta data super block
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3212   * @device:	DRBD device.
b411b3637fa71f Philipp Reisner     2009-09-25  3213   * @bdev:	Device from which the meta data should be read in.
b411b3637fa71f Philipp Reisner     2009-09-25  3214   *
3a4d4eb3cb03fb Lars Ellenberg      2013-03-19  3215   * Return NO_ERROR on success, and an enum drbd_ret_code in case
d5d7ebd4225062 Lars Ellenberg      2011-07-05  3216   * something goes wrong.
3a4d4eb3cb03fb Lars Ellenberg      2013-03-19  3217   *
c04ccaa669e147 Lars Ellenberg      2013-03-19  3218   * Called exactly once during drbd_adm_attach(), while still being D_DISKLESS,
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3219   * even before @bdev is assigned to @device->ldev.
b411b3637fa71f Philipp Reisner     2009-09-25  3220   */
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3221  int drbd_md_read(struct drbd_device *device, struct drbd_backing_dev *bdev)
b411b3637fa71f Philipp Reisner     2009-09-25  3222  {
b411b3637fa71f Philipp Reisner     2009-09-25  3223  	struct meta_data_on_disk *buffer;
d5d7ebd4225062 Lars Ellenberg      2011-07-05  3224  	u32 magic, flags;
b411b3637fa71f Philipp Reisner     2009-09-25  3225  	int i, rv = NO_ERROR;
b411b3637fa71f Philipp Reisner     2009-09-25  3226  
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3227  	if (device->state.disk != D_DISKLESS)
c04ccaa669e147 Lars Ellenberg      2013-03-19  3228  		return ERR_DISK_CONFIGURED;
b411b3637fa71f Philipp Reisner     2009-09-25  3229  
e37d2438d8e5e4 Lars Ellenberg      2014-04-01  3230  	buffer = drbd_md_get_buffer(device, __func__);
e17117310b73ce Philipp Reisner     2011-06-27  3231  	if (!buffer)
c04ccaa669e147 Lars Ellenberg      2013-03-19  3232  		return ERR_NOMEM;
b411b3637fa71f Philipp Reisner     2009-09-25  3233  
c04ccaa669e147 Lars Ellenberg      2013-03-19  3234  	/* First, figure out where our meta data superblock is located,
c04ccaa669e147 Lars Ellenberg      2013-03-19  3235  	 * and read it. */
3a4d4eb3cb03fb Lars Ellenberg      2013-03-19  3236  	bdev->md.meta_dev_idx = bdev->disk_conf->meta_dev_idx;
3a4d4eb3cb03fb Lars Ellenberg      2013-03-19  3237  	bdev->md.md_offset = drbd_md_ss(bdev);
edb5e5f63d80c3 Lars Ellenberg      2015-03-24  3238  	/* Even for (flexible or indexed) external meta data,
edb5e5f63d80c3 Lars Ellenberg      2015-03-24  3239  	 * initially restrict us to the 4k superblock for now.
edb5e5f63d80c3 Lars Ellenberg      2015-03-24  3240  	 * Affects the paranoia out-of-range access check in drbd_md_sync_page_io(). */
edb5e5f63d80c3 Lars Ellenberg      2015-03-24  3241  	bdev->md.md_size_sect = 8;
b411b3637fa71f Philipp Reisner     2009-09-25  3242  
bb3cc85e16431b Mike Christie       2016-06-05  3243  	if (drbd_md_sync_page_io(device, bdev, bdev->md.md_offset,
bb3cc85e16431b Mike Christie       2016-06-05  3244  				 REQ_OP_READ)) {
25985edcedea63 Lucas De Marchi     2011-03-30  3245  		/* NOTE: can't do normal error processing here as this is
b411b3637fa71f Philipp Reisner     2009-09-25  3246  		   called BEFORE disk is attached */
d01801710265cf Andreas Gruenbacher 2011-07-03  3247  		drbd_err(device, "Error while reading metadata.\n");
b411b3637fa71f Philipp Reisner     2009-09-25  3248  		rv = ERR_IO_MD_DISK;
b411b3637fa71f Philipp Reisner     2009-09-25  3249  		goto err;
b411b3637fa71f Philipp Reisner     2009-09-25  3250  	}
b411b3637fa71f Philipp Reisner     2009-09-25  3251  
d5d7ebd4225062 Lars Ellenberg      2011-07-05  3252  	magic = be32_to_cpu(buffer->magic);
d5d7ebd4225062 Lars Ellenberg      2011-07-05  3253  	flags = be32_to_cpu(buffer->flags);
d5d7ebd4225062 Lars Ellenberg      2011-07-05  3254  	if (magic == DRBD_MD_MAGIC_84_UNCLEAN ||
d5d7ebd4225062 Lars Ellenberg      2011-07-05  3255  	    (magic == DRBD_MD_MAGIC_08 && !(flags & MDF_AL_CLEAN))) {
d5d7ebd4225062 Lars Ellenberg      2011-07-05  3256  			/* btw: that's Activity Log clean, not "all" clean. */
d01801710265cf Andreas Gruenbacher 2011-07-03  3257  		drbd_err(device, "Found unclean meta data. Did you \"drbdadm apply-al\"?\n");
d5d7ebd4225062 Lars Ellenberg      2011-07-05  3258  		rv = ERR_MD_UNCLEAN;
d5d7ebd4225062 Lars Ellenberg      2011-07-05  3259  		goto err;
d5d7ebd4225062 Lars Ellenberg      2011-07-05  3260  	}
3a4d4eb3cb03fb Lars Ellenberg      2013-03-19  3261  
3a4d4eb3cb03fb Lars Ellenberg      2013-03-19  3262  	rv = ERR_MD_INVALID;
d5d7ebd4225062 Lars Ellenberg      2011-07-05  3263  	if (magic != DRBD_MD_MAGIC_08) {
d5d7ebd4225062 Lars Ellenberg      2011-07-05  3264  		if (magic == DRBD_MD_MAGIC_07)
d01801710265cf Andreas Gruenbacher 2011-07-03  3265  			drbd_err(device, "Found old (0.7) meta data magic. Did you \"drbdadm create-md\"?\n");
d5d7ebd4225062 Lars Ellenberg      2011-07-05  3266  		else
d01801710265cf Andreas Gruenbacher 2011-07-03  3267  			drbd_err(device, "Meta data magic not found. Did you \"drbdadm create-md\"?\n");
b411b3637fa71f Philipp Reisner     2009-09-25  3268  		goto err;
b411b3637fa71f Philipp Reisner     2009-09-25  3269  	}
3a4d4eb3cb03fb Lars Ellenberg      2013-03-19  3270  
c04ccaa669e147 Lars Ellenberg      2013-03-19  3271  	if (be32_to_cpu(buffer->bm_bytes_per_bit) != BM_BLOCK_SIZE) {
d01801710265cf Andreas Gruenbacher 2011-07-03  3272  		drbd_err(device, "unexpected bm_bytes_per_bit: %u (expected %u)\n",
c04ccaa669e147 Lars Ellenberg      2013-03-19  3273  		    be32_to_cpu(buffer->bm_bytes_per_bit), BM_BLOCK_SIZE);
b411b3637fa71f Philipp Reisner     2009-09-25  3274  		goto err;
b411b3637fa71f Philipp Reisner     2009-09-25  3275  	}
c04ccaa669e147 Lars Ellenberg      2013-03-19  3276  
c04ccaa669e147 Lars Ellenberg      2013-03-19  3277  
c04ccaa669e147 Lars Ellenberg      2013-03-19  3278  	/* convert to in_core endian */
c04ccaa669e147 Lars Ellenberg      2013-03-19 @3279  	bdev->md.la_size_sect = be64_to_cpu(buffer->la_size_sect);
c04ccaa669e147 Lars Ellenberg      2013-03-19  3280  	for (i = UI_CURRENT; i < UI_SIZE; i++)
c04ccaa669e147 Lars Ellenberg      2013-03-19  3281  		bdev->md.uuid[i] = be64_to_cpu(buffer->uuid[i]);
c04ccaa669e147 Lars Ellenberg      2013-03-19  3282  	bdev->md.flags = be32_to_cpu(buffer->flags);
c04ccaa669e147 Lars Ellenberg      2013-03-19  3283  	bdev->md.device_uuid = be64_to_cpu(buffer->device_uuid);
3a4d4eb3cb03fb Lars Ellenberg      2013-03-19  3284  
c04ccaa669e147 Lars Ellenberg      2013-03-19  3285  	bdev->md.md_size_sect = be32_to_cpu(buffer->md_size_sect);
c04ccaa669e147 Lars Ellenberg      2013-03-19  3286  	bdev->md.al_offset = be32_to_cpu(buffer->al_offset);
c04ccaa669e147 Lars Ellenberg      2013-03-19  3287  	bdev->md.bm_offset = be32_to_cpu(buffer->bm_offset);
c04ccaa669e147 Lars Ellenberg      2013-03-19  3288  
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3289  	if (check_activity_log_stripe_size(device, buffer, &bdev->md))
b411b3637fa71f Philipp Reisner     2009-09-25  3290  		goto err;
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3291  	if (check_offsets_and_sizes(device, bdev))
c04ccaa669e147 Lars Ellenberg      2013-03-19  3292  		goto err;
c04ccaa669e147 Lars Ellenberg      2013-03-19  3293  
b411b3637fa71f Philipp Reisner     2009-09-25  3294  	if (be32_to_cpu(buffer->bm_offset) != bdev->md.bm_offset) {
d01801710265cf Andreas Gruenbacher 2011-07-03  3295  		drbd_err(device, "unexpected bm_offset: %d (expected %d)\n",
b411b3637fa71f Philipp Reisner     2009-09-25  3296  		    be32_to_cpu(buffer->bm_offset), bdev->md.bm_offset);
b411b3637fa71f Philipp Reisner     2009-09-25  3297  		goto err;
b411b3637fa71f Philipp Reisner     2009-09-25  3298  	}
b411b3637fa71f Philipp Reisner     2009-09-25  3299  	if (be32_to_cpu(buffer->md_size_sect) != bdev->md.md_size_sect) {
d01801710265cf Andreas Gruenbacher 2011-07-03  3300  		drbd_err(device, "unexpected md_size: %u (expected %u)\n",
b411b3637fa71f Philipp Reisner     2009-09-25  3301  		    be32_to_cpu(buffer->md_size_sect), bdev->md.md_size_sect);
b411b3637fa71f Philipp Reisner     2009-09-25  3302  		goto err;
b411b3637fa71f Philipp Reisner     2009-09-25  3303  	}
b411b3637fa71f Philipp Reisner     2009-09-25  3304  
3a4d4eb3cb03fb Lars Ellenberg      2013-03-19  3305  	rv = NO_ERROR;
b411b3637fa71f Philipp Reisner     2009-09-25  3306  
0500813fe0c9a6 Andreas Gruenbacher 2011-07-07  3307  	spin_lock_irq(&device->resource->req_lock);
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3308  	if (device->state.conn < C_CONNECTED) {
db141b2f42b485 Lars Ellenberg      2012-06-25  3309  		unsigned int peer;
99432fcc528d7a Philipp Reisner     2011-05-20  3310  		peer = be32_to_cpu(buffer->la_peer_max_bio_size);
db141b2f42b485 Lars Ellenberg      2012-06-25  3311  		peer = max(peer, DRBD_MAX_BIO_SIZE_SAFE);
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3312  		device->peer_max_bio_size = peer;
99432fcc528d7a Philipp Reisner     2011-05-20  3313  	}
0500813fe0c9a6 Andreas Gruenbacher 2011-07-07  3314  	spin_unlock_irq(&device->resource->req_lock);
b411b3637fa71f Philipp Reisner     2009-09-25  3315  
b411b3637fa71f Philipp Reisner     2009-09-25  3316   err:
b30ab7913b0a7b Andreas Gruenbacher 2011-07-03  3317  	drbd_md_put_buffer(device);
b411b3637fa71f Philipp Reisner     2009-09-25  3318  
b411b3637fa71f Philipp Reisner     2009-09-25  3319  	return rv;
b411b3637fa71f Philipp Reisner     2009-09-25  3320  }
b411b3637fa71f Philipp Reisner     2009-09-25  3321  

:::::: The code at line 3279 was first introduced by commit
:::::: c04ccaa669e147ffb66e4e74d82c7dbfc100ec5e drbd: read meta data early, base on-disk offsets on super block

:::::: TO: Lars Ellenberg <lars.ellenberg@linbit.com>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
