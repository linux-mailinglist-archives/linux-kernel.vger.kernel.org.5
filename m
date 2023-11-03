Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01887E0085
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjKCISy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbjKCISu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:18:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39AD131
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698999523; x=1730535523;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VeliMlNLfOxowAisIjDQwUATydKzMfcmAwGoCYI9NjA=;
  b=ZDkGDpw85HzljiYtmcA69lvKXf3U3/xfR0PPOA3RQ+PRb4Tnor3DTqsh
   bejA0bupV3fFhAR9EJ6ez0gIvC0kyup3Xt5qb90pyXbAH84DwsAYLNL88
   q+4QbPYpDZ8QWVQO4MCFf/dP82pIsQbljC7c5KrMPrnEtWysQb0z8kgdR
   gK6yPtWBCwD85o7ypnLz/f9oRXYjqVzDrUBtn2OMPR8CGOuEe9YUKSd8Y
   4RwJ6VMVKFqXjYfBREOS9tyYeuChbo3hp1/kf3wSM+W+UIC3qGHxW5GTM
   zN0Jcc6lyYnFCaegN9ZM8I1JkR8q31CnN/S+2acEqmWWGQzoEltKJ8wxU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="386072888"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="386072888"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 01:18:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="9293975"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Nov 2023 01:18:42 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qypO3-0002Ma-0r;
        Fri, 03 Nov 2023 08:18:39 +0000
Date:   Fri, 3 Nov 2023 16:18:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/bcachefs_format.h:200:25: warning: 'version' offset 27
 in 'struct bkey' isn't aligned to 4
Message-ID: <202311031653.GRyrZccz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bc3012f4e3a9765de81f454cb8f9bb16aafc6ff5
commit: 1c6fdbd8f2465ddfb73a01ec620cbf3d14044e1a bcachefs: Initial commit
date:   11 days ago
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20231103/202311031653.GRyrZccz-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311031653.GRyrZccz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311031653.GRyrZccz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/bcachefs/bcachefs.h:199,
                    from fs/bcachefs/acl.c:4:
   fs/bcachefs/bcachefs_format.h:198:25: warning: 'p' offset 3 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
     198 |         struct bpos     p;
         |                         ^
>> fs/bcachefs/bcachefs_format.h:200:25: warning: 'version' offset 27 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
     200 |         struct bversion version;
         |                         ^~~~~~~
   In file included from fs/bcachefs/super-io.h:5,
                    from fs/bcachefs/checksum.h:7,
                    from fs/bcachefs/str_hash.h:7,
                    from fs/bcachefs/fs.h:6,
                    from fs/bcachefs/acl.c:13:
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
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
         | ^~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:1480:14: warning: 'BTREE_NODE_LEVEL_MAX' defined but not used [-Wunused-const-variable=]
--
   In file included from fs/bcachefs/bcachefs.h:199,
                    from fs/bcachefs/alloc.c:56:
   fs/bcachefs/bcachefs_format.h:198:25: warning: 'p' offset 3 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
     198 |         struct bpos     p;
         |                         ^
>> fs/bcachefs/bcachefs_format.h:200:25: warning: 'version' offset 27 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
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
         |                         ^~~~
   fs/bcachefs/bcachefs_format.h:1482:1: note: in expansion of macro 'LE64_BITMASK'
    1482 | LE64_BITMASK(BTREE_NODE_SEQ,    struct btree_node, flags, 32, 64);
--
   In file included from fs/bcachefs/bcachefs.h:199,
                    from fs/bcachefs/bkey.c:3:
   fs/bcachefs/bcachefs_format.h:198:25: warning: 'p' offset 3 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
     198 |         struct bpos     p;
         |                         ^
>> fs/bcachefs/bcachefs_format.h:200:25: warning: 'version' offset 27 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
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
    1479 | LE64_BITMASK(BTREE_NODE_ID,     struct btree_node, flags,  0,  4);
         |              ^~~~~~~~~~~~~
   fs/bcachefs/bcachefs_format.h:85:25: note: in definition of macro 'LE_BITMASK'
..


vim +200 fs/bcachefs/bcachefs_format.h

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
 > 200		struct bversion	version;
   201	
   202		__u8		pad[1];
   203	#endif
   204	} __attribute__((packed, aligned(8)));
   205	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
