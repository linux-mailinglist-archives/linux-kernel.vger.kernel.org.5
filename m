Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EF07DE571
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344536AbjKARh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjKARhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:37:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6919B11A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698860239; x=1730396239;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hOPKkHCJ+o+UeFMFB4byS0F9TqviMzsGykBBAtSqEyA=;
  b=ZMd0BMWwO+V5cj/l/Fjqsgz4HE1/lETA91at/ifDsZfyjmSrBg2wKVq+
   7AZG1j7w4o4AO23cQ2SEiiIP5cQ6E5otuCZJj588xF5uNHr1YjShlblOl
   ZaM7qoJ6xdp0iUuiyX+NOCyub0zR+x7SFSmYysjQiUWIzg6e+CD9KTJ3f
   tb2gL1xKIrxYCPJbJefEkvgsf3Tgh7hSVVNqMas7lt+N+TY9yFu24YutJ
   OA0X8PeEn4YUnzJRGj5N6NmfXjs1FiAulGzmtIP8vkCcyj4lSF4LcYcd7
   L2HGjQAe0VZojD3Gz0bYo2RfovqJWw/+B6KLsd47DKDlcobVhq6GW2tCu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452833104"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="452833104"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 10:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="904713300"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="904713300"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Nov 2023 10:37:05 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyF9L-0000tQ-0e;
        Wed, 01 Nov 2023 17:37:03 +0000
Date:   Thu, 2 Nov 2023 01:36:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/bcachefs_format.h:198:25: warning: 'p' offset 3 in
 'struct bkey' isn't aligned to 4
Message-ID: <202311020159.7wky7Xit-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8bc9e6515183935fa0cccaf67455c439afe4982b
commit: 1c6fdbd8f2465ddfb73a01ec620cbf3d14044e1a bcachefs: Initial commit
date:   10 days ago
config: m68k-randconfig-r003-20211010 (https://download.01.org/0day-ci/archive/20231102/202311020159.7wky7Xit-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311020159.7wky7Xit-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311020159.7wky7Xit-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/bcachefs/bcachefs.h:199,
                    from fs/bcachefs/alloc.c:56:
>> fs/bcachefs/bcachefs_format.h:198:25: warning: 'p' offset 3 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
     198 |         struct bpos     p;
         |                         ^
   fs/bcachefs/bcachefs_format.h:200:25: warning: 'version' offset 27 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
     200 |         struct bversion version;
         |                         ^~~~~~~
   In file included from fs/bcachefs/btree_cache.h:7,
                    from fs/bcachefs/alloc.c:58:
   fs/bcachefs/extents.h: In function 'bch2_extent_devs':
   fs/bcachefs/extents.h:403:40: warning: variable '_crc' set but not used [-Wunused-but-set-variable]
     403 |         struct bch_extent_crc_unpacked _crc;                            \
         |                                        ^~~~
   fs/bcachefs/extents.h:410:24: note: in expansion of macro 'extent_ptr_next'
     410 |              ((_ptr) = extent_ptr_next(_e, _ptr));                      \
         |                        ^~~~~~~~~~~~~~~
   fs/bcachefs/extents.h:462:9: note: in expansion of macro 'extent_for_each_ptr'
     462 |         extent_for_each_ptr(e, ptr)
         |         ^~~~~~~~~~~~~~~~~~~
   fs/bcachefs/extents.h: In function 'bch2_extent_dirty_devs':
   fs/bcachefs/extents.h:403:40: warning: variable '_crc' set but not used [-Wunused-but-set-variable]
     403 |         struct bch_extent_crc_unpacked _crc;                            \
         |                                        ^~~~
   fs/bcachefs/extents.h:410:24: note: in expansion of macro 'extent_ptr_next'
     410 |              ((_ptr) = extent_ptr_next(_e, _ptr));                      \
         |                        ^~~~~~~~~~~~~~~
   fs/bcachefs/extents.h:473:9: note: in expansion of macro 'extent_for_each_ptr'
     473 |         extent_for_each_ptr(e, ptr)
         |         ^~~~~~~~~~~~~~~~~~~
   fs/bcachefs/extents.h: In function 'bch2_extent_cached_devs':
   fs/bcachefs/extents.h:403:40: warning: variable '_crc' set but not used [-Wunused-but-set-variable]
     403 |         struct bch_extent_crc_unpacked _crc;                            \
         |                                        ^~~~
   fs/bcachefs/extents.h:410:24: note: in expansion of macro 'extent_ptr_next'
     410 |              ((_ptr) = extent_ptr_next(_e, _ptr));                      \
         |                        ^~~~~~~~~~~~~~~
   fs/bcachefs/extents.h:485:9: note: in expansion of macro 'extent_for_each_ptr'
     485 |         extent_for_each_ptr(e, ptr)
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from fs/bcachefs/alloc.c:60:
   fs/bcachefs/alloc.c: In function '__bch2_alloc_write_key':
   fs/bcachefs/btree_update.h:72:35: error: implicit declaration of function 'COUNT_ARGS' [-Werror=implicit-function-declaration]
      72 |                 .nr             = COUNT_ARGS(__VA_ARGS__),              \
         |                                   ^~~~~~~~~~
   fs/bcachefs/alloc.c:332:23: note: in expansion of macro 'bch2_btree_insert_at'
     332 |                 ret = bch2_btree_insert_at(c, NULL, NULL, journal_seq, flags,
         |                       ^~~~~~~~~~~~~~~~~~~~
   In file included from fs/bcachefs/bcachefs.h:201:
   fs/bcachefs/opts.h: At top level:
   fs/bcachefs/opts.h:194:30: warning: 'bch2_opts_default' defined but not used [-Wunused-const-variable=]
     194 | static const struct bch_opts bch2_opts_default = {
         |                              ^~~~~~~~~~~~~~~~~
   fs/bcachefs/opts.h:33:14: warning: 'NO_SB_OPT_MAX' defined but not used [-Wunused-const-variable=]
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         |              ^~~~~~~~~
   fs/bcachefs/bcachefs_format.h:86:25: note: in definition of macro 'LE_BITMASK'
      86 | static const __u##_bits name##_MAX = (1ULL << (end - offset)) - 1;      \
         |                         ^~~~
   fs/bcachefs/opts.h:33:1: note: in expansion of macro 'LE64_BITMASK'
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         | ^~~~~~~~~~~~
   fs/bcachefs/opts.h:33:14: warning: 'NO_SB_OPT_BITS' defined but not used [-Wunused-const-variable=]
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         |              ^~~~~~~~~
   fs/bcachefs/bcachefs_format.h:85:25: note: in definition of macro 'LE_BITMASK'
      85 | static const unsigned   name##_BITS = (end - offset);                   \
         |                         ^~~~
   fs/bcachefs/opts.h:33:1: note: in expansion of macro 'LE64_BITMASK'
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         | ^~~~~~~~~~~~
   fs/bcachefs/opts.h:33:14: warning: 'NO_SB_OPT_OFFSET' defined but not used [-Wunused-const-variable=]
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         |              ^~~~~~~~~
   fs/bcachefs/bcachefs_format.h:84:25: note: in definition of macro 'LE_BITMASK'
      84 | static const unsigned   name##_OFFSET = offset;                         \
         |                         ^~~~
   fs/bcachefs/opts.h:33:1: note: in expansion of macro 'LE64_BITMASK'
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1482:14: warning: 'BTREE_NODE_SEQ_MAX' defined but not used [-Wunused-const-variable=]
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         |              ^~~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:86:25: note: in definition of macro 'LE_BITMASK'
      86 | static const __u##_bits name##_MAX = (1ULL << (end - offset)) - 1;      \
         |                         ^~~~
   fs/bcachefs/bcachefs_format.h:1482:1: note: in expansion of macro 'LE64_BITMASK'
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1482:14: warning: 'BTREE_NODE_SEQ_BITS' defined but not used [-Wunused-const-variable=]
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         |              ^~~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:85:25: note: in definition of macro 'LE_BITMASK'
      85 | static const unsigned   name##_BITS = (end - offset);                   \
         |                         ^~~~
   fs/bcachefs/bcachefs_format.h:1482:1: note: in expansion of macro 'LE64_BITMASK'
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1482:14: warning: 'BTREE_NODE_SEQ_OFFSET' defined but not used [-Wunused-const-variable=]
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         |              ^~~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:84:25: note: in definition of macro 'LE_BITMASK'
      84 | static const unsigned   name##_OFFSET = offset;                         \
--
   In file included from fs/bcachefs/bcachefs.h:199,
                    from fs/bcachefs/bkey.c:3:
>> fs/bcachefs/bcachefs_format.h:198:25: warning: 'p' offset 3 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
     198 |         struct bpos     p;
         |                         ^
   fs/bcachefs/bcachefs_format.h:200:25: warning: 'version' offset 27 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
     200 |         struct bversion version;
         |                         ^~~~~~~
   In file included from fs/bcachefs/bcachefs.h:201:
   fs/bcachefs/opts.h:194:30: warning: 'bch2_opts_default' defined but not used [-Wunused-const-variable=]
     194 | static const struct bch_opts bch2_opts_default = {
         |                              ^~~~~~~~~~~~~~~~~
   fs/bcachefs/opts.h:33:14: warning: 'NO_SB_OPT_MAX' defined but not used [-Wunused-const-variable=]
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         |              ^~~~~~~~~
   fs/bcachefs/bcachefs_format.h:86:25: note: in definition of macro 'LE_BITMASK'
      86 | static const __u##_bits name##_MAX = (1ULL << (end - offset)) - 1;      \
         |                         ^~~~
   fs/bcachefs/opts.h:33:1: note: in expansion of macro 'LE64_BITMASK'
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         | ^~~~~~~~~~~~
   fs/bcachefs/opts.h:33:14: warning: 'NO_SB_OPT_BITS' defined but not used [-Wunused-const-variable=]
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         |              ^~~~~~~~~
   fs/bcachefs/bcachefs_format.h:85:25: note: in definition of macro 'LE_BITMASK'
      85 | static const unsigned   name##_BITS = (end - offset);                   \
         |                         ^~~~
   fs/bcachefs/opts.h:33:1: note: in expansion of macro 'LE64_BITMASK'
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         | ^~~~~~~~~~~~
   fs/bcachefs/opts.h:33:14: warning: 'NO_SB_OPT_OFFSET' defined but not used [-Wunused-const-variable=]
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         |              ^~~~~~~~~
   fs/bcachefs/bcachefs_format.h:84:25: note: in definition of macro 'LE_BITMASK'
      84 | static const unsigned   name##_OFFSET = offset;                         \
         |                         ^~~~
   fs/bcachefs/opts.h:33:1: note: in expansion of macro 'LE64_BITMASK'
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1482:14: warning: 'BTREE_NODE_SEQ_MAX' defined but not used [-Wunused-const-variable=]
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         |              ^~~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:86:25: note: in definition of macro 'LE_BITMASK'
      86 | static const __u##_bits name##_MAX = (1ULL << (end - offset)) - 1;      \
         |                         ^~~~
   fs/bcachefs/bcachefs_format.h:1482:1: note: in expansion of macro 'LE64_BITMASK'
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1482:14: warning: 'BTREE_NODE_SEQ_BITS' defined but not used [-Wunused-const-variable=]
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         |              ^~~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:85:25: note: in definition of macro 'LE_BITMASK'
      85 | static const unsigned   name##_BITS = (end - offset);                   \
         |                         ^~~~
   fs/bcachefs/bcachefs_format.h:1482:1: note: in expansion of macro 'LE64_BITMASK'
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1482:14: warning: 'BTREE_NODE_SEQ_OFFSET' defined but not used [-Wunused-const-variable=]
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         |              ^~~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:84:25: note: in definition of macro 'LE_BITMASK'
      84 | static const unsigned   name##_OFFSET = offset;                         \
         |                         ^~~~
   fs/bcachefs/bcachefs_format.h:1482:1: note: in expansion of macro 'LE64_BITMASK'
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1480:14: warning: 'BTREE_NODE_LEVEL_MAX' defined but not used [-Wunused-const-variable=]
    1480 | LE64_BITMASK(BTREE_NODE_LEVEL,  struct btree_node, flags,  4,  8);
         |              ^~~~~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:86:25: note: in definition of macro 'LE_BITMASK'
      86 | static const __u##_bits name##_MAX = (1ULL << (end - offset)) - 1;      \
         |                         ^~~~
   fs/bcachefs/bcachefs_format.h:1480:1: note: in expansion of macro 'LE64_BITMASK'
    1480 | LE64_BITMASK(BTREE_NODE_LEVEL,  struct btree_node, flags,  4,  8);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1480:14: warning: 'BTREE_NODE_LEVEL_BITS' defined but not used [-Wunused-const-variable=]
    1480 | LE64_BITMASK(BTREE_NODE_LEVEL,  struct btree_node, flags,  4,  8);
         |              ^~~~~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:85:25: note: in definition of macro 'LE_BITMASK'
      85 | static const unsigned   name##_BITS = (end - offset);                   \
         |                         ^~~~
   fs/bcachefs/bcachefs_format.h:1480:1: note: in expansion of macro 'LE64_BITMASK'
    1480 | LE64_BITMASK(BTREE_NODE_LEVEL,  struct btree_node, flags,  4,  8);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1480:14: warning: 'BTREE_NODE_LEVEL_OFFSET' defined but not used [-Wunused-const-variable=]
    1480 | LE64_BITMASK(BTREE_NODE_LEVEL,  struct btree_node, flags,  4,  8);
         |              ^~~~~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:84:25: note: in definition of macro 'LE_BITMASK'
      84 | static const unsigned   name##_OFFSET = offset;                         \
         |                         ^~~~
   fs/bcachefs/bcachefs_format.h:1480:1: note: in expansion of macro 'LE64_BITMASK'
    1480 | LE64_BITMASK(BTREE_NODE_LEVEL,  struct btree_node, flags,  4,  8);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1479:14: warning: 'BTREE_NODE_ID_MAX' defined but not used [-Wunused-const-variable=]
    1479 | LE64_BITMASK(BTREE_NODE_ID,     struct btree_node, flags,  0,  4);
         |              ^~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:86:25: note: in definition of macro 'LE_BITMASK'
      86 | static const __u##_bits name##_MAX = (1ULL << (end - offset)) - 1;      \
         |                         ^~~~
   fs/bcachefs/bcachefs_format.h:1479:1: note: in expansion of macro 'LE64_BITMASK'
    1479 | LE64_BITMASK(BTREE_NODE_ID,     struct btree_node, flags,  0,  4);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1479:14: warning: 'BTREE_NODE_ID_BITS' defined but not used [-Wunused-const-variable=]
--
   In file included from fs/bcachefs/bcachefs.h:199,
                    from fs/bcachefs/bkey_methods.c:3:
>> fs/bcachefs/bcachefs_format.h:198:25: warning: 'p' offset 3 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
     198 |         struct bpos     p;
         |                         ^
   fs/bcachefs/bcachefs_format.h:200:25: warning: 'version' offset 27 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
     200 |         struct bversion version;
         |                         ^~~~~~~
   In file included from fs/bcachefs/super-io.h:5,
                    from fs/bcachefs/checksum.h:7,
                    from fs/bcachefs/str_hash.h:7,
                    from fs/bcachefs/dirent.h:5,
                    from fs/bcachefs/bkey_methods.c:7:
   fs/bcachefs/extents.h: In function 'bch2_extent_devs':
   fs/bcachefs/extents.h:403:40: warning: variable '_crc' set but not used [-Wunused-but-set-variable]
     403 |         struct bch_extent_crc_unpacked _crc;                            \
         |                                        ^~~~
   fs/bcachefs/extents.h:410:24: note: in expansion of macro 'extent_ptr_next'
     410 |              ((_ptr) = extent_ptr_next(_e, _ptr));                      \
         |                        ^~~~~~~~~~~~~~~
   fs/bcachefs/extents.h:462:9: note: in expansion of macro 'extent_for_each_ptr'
     462 |         extent_for_each_ptr(e, ptr)
         |         ^~~~~~~~~~~~~~~~~~~
   fs/bcachefs/extents.h: In function 'bch2_extent_dirty_devs':
   fs/bcachefs/extents.h:403:40: warning: variable '_crc' set but not used [-Wunused-but-set-variable]
     403 |         struct bch_extent_crc_unpacked _crc;                            \
         |                                        ^~~~
   fs/bcachefs/extents.h:410:24: note: in expansion of macro 'extent_ptr_next'
     410 |              ((_ptr) = extent_ptr_next(_e, _ptr));                      \
         |                        ^~~~~~~~~~~~~~~
   fs/bcachefs/extents.h:473:9: note: in expansion of macro 'extent_for_each_ptr'
     473 |         extent_for_each_ptr(e, ptr)
         |         ^~~~~~~~~~~~~~~~~~~
   fs/bcachefs/extents.h: In function 'bch2_extent_cached_devs':
   fs/bcachefs/extents.h:403:40: warning: variable '_crc' set but not used [-Wunused-but-set-variable]
     403 |         struct bch_extent_crc_unpacked _crc;                            \
         |                                        ^~~~
   fs/bcachefs/extents.h:410:24: note: in expansion of macro 'extent_ptr_next'
     410 |              ((_ptr) = extent_ptr_next(_e, _ptr));                      \
         |                        ^~~~~~~~~~~~~~~
   fs/bcachefs/extents.h:485:9: note: in expansion of macro 'extent_for_each_ptr'
     485 |         extent_for_each_ptr(e, ptr)
         |         ^~~~~~~~~~~~~~~~~~~
   fs/bcachefs/checksum.h: At top level:
   fs/bcachefs/checksum.h:95:23: warning: 'bch2_compression_opt_to_type' defined but not used [-Wunused-const-variable=]
      95 | static const unsigned bch2_compression_opt_to_type[] = {
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from fs/bcachefs/bcachefs.h:201:
   fs/bcachefs/opts.h:194:30: warning: 'bch2_opts_default' defined but not used [-Wunused-const-variable=]
     194 | static const struct bch_opts bch2_opts_default = {
         |                              ^~~~~~~~~~~~~~~~~
   fs/bcachefs/opts.h:33:14: warning: 'NO_SB_OPT_MAX' defined but not used [-Wunused-const-variable=]
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         |              ^~~~~~~~~
   fs/bcachefs/bcachefs_format.h:86:25: note: in definition of macro 'LE_BITMASK'
      86 | static const __u##_bits name##_MAX = (1ULL << (end - offset)) - 1;      \
         |                         ^~~~
   fs/bcachefs/opts.h:33:1: note: in expansion of macro 'LE64_BITMASK'
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         | ^~~~~~~~~~~~
   fs/bcachefs/opts.h:33:14: warning: 'NO_SB_OPT_BITS' defined but not used [-Wunused-const-variable=]
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         |              ^~~~~~~~~
   fs/bcachefs/bcachefs_format.h:85:25: note: in definition of macro 'LE_BITMASK'
      85 | static const unsigned   name##_BITS = (end - offset);                   \
         |                         ^~~~
   fs/bcachefs/opts.h:33:1: note: in expansion of macro 'LE64_BITMASK'
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         | ^~~~~~~~~~~~
   fs/bcachefs/opts.h:33:14: warning: 'NO_SB_OPT_OFFSET' defined but not used [-Wunused-const-variable=]
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         |              ^~~~~~~~~
   fs/bcachefs/bcachefs_format.h:84:25: note: in definition of macro 'LE_BITMASK'
      84 | static const unsigned   name##_OFFSET = offset;                         \
         |                         ^~~~
   fs/bcachefs/opts.h:33:1: note: in expansion of macro 'LE64_BITMASK'
      33 | LE64_BITMASK(NO_SB_OPT,         struct bch_sb, flags[0], 0, 0);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1482:14: warning: 'BTREE_NODE_SEQ_MAX' defined but not used [-Wunused-const-variable=]
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         |              ^~~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:86:25: note: in definition of macro 'LE_BITMASK'
      86 | static const __u##_bits name##_MAX = (1ULL << (end - offset)) - 1;      \
         |                         ^~~~
   fs/bcachefs/bcachefs_format.h:1482:1: note: in expansion of macro 'LE64_BITMASK'
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1482:14: warning: 'BTREE_NODE_SEQ_BITS' defined but not used [-Wunused-const-variable=]
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         |              ^~~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:85:25: note: in definition of macro 'LE_BITMASK'
      85 | static const unsigned   name##_BITS = (end - offset);                   \
         |                         ^~~~
   fs/bcachefs/bcachefs_format.h:1482:1: note: in expansion of macro 'LE64_BITMASK'
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1482:14: warning: 'BTREE_NODE_SEQ_OFFSET' defined but not used [-Wunused-const-variable=]
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         |              ^~~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:84:25: note: in definition of macro 'LE_BITMASK'
      84 | static const unsigned   name##_OFFSET = offset;                         \
         |                         ^~~~
   fs/bcachefs/bcachefs_format.h:1482:1: note: in expansion of macro 'LE64_BITMASK'
..


vim +198 fs/bcachefs/bcachefs_format.h

   187	
   188		/* Type of the value */
   189		__u8		type;
   190	
   191	#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
   192		__u8		pad[1];
   193	
   194		struct bversion	version;
   195		__u32		size;		/* extent size, in sectors */
   196		struct bpos	p;
   197	#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 > 198		struct bpos	p;
   199		__u32		size;		/* extent size, in sectors */
   200		struct bversion	version;
   201	
   202		__u8		pad[1];
   203	#endif
   204	} __attribute__((packed, aligned(8)));
   205	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
