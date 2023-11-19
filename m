Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8187B7F04EC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 10:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjKSJOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 04:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjKSJO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 04:14:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025D1AF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700385265; x=1731921265;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7CSTD1NnoSbzmP0U+Un0yGi4BEceSmPaTdjXFGOkcPo=;
  b=Y/Qg4USFbG/DS6GmpaFiSIG8OTOFa9vfgseagAV1UV0tp4ocXOfDQaU7
   r+W+jotCjC3dEEvwrFN6cDIeLlqfiud/3YUeKcEnf9hSy6m019IOzr7nF
   Mf3hONbJUpNwZ7ZvOEbeZizg03M4KWPE9KN+L4zyGb9GvxEjfAVRJY/bn
   rWSCP6eW1GQiOsMgfMnc+Jge6OsgoV/P6SM0A7xHgeBA+8DDP4B9SKIPi
   +HOebkuXamAS+gIob6F9iDyCHuPfwQZX9btbl1cw79zMeFae63sU+2q0n
   5y/fphxumvsE0wwwB4BSHVwqERu4sGgWSVkab+KJq3RXuhtl8WyHlW1nG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="394327581"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="394327581"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 01:14:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="759552939"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="759552939"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 19 Nov 2023 01:14:22 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4dsi-0004tN-1y;
        Sun, 19 Nov 2023 09:14:20 +0000
Date:   Sun, 19 Nov 2023 17:13:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: fs/bcachefs/btree_key_cache.c:113:7: warning: result of comparison
 of constant 9223372036854775807 with expression of type 'unsigned int' is
 always true
Message-ID: <202311191651.u4v7ULB0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   037266a5f7239ead1530266f7d7af153d2a867fa
commit: b2f83e769f607409753888c95a9b46dc927dc856 bcachefs: Btree key cache shrinker fix
date:   4 weeks ago
config: s390-randconfig-001-20231119 (https://download.01.org/0day-ci/archive/20231119/202311191651.u4v7ULB0-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311191651.u4v7ULB0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311191651.u4v7ULB0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/bcachefs/btree_key_cache.c:4:
   fs/bcachefs/btree_iter.h:220:8: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
   static inline int btree_trans_restart_nounlock(struct btree_trans *trans, int err)
          ^
   include/linux/compiler_types.h:215:16: note: expanded from macro 'inline'
   #define inline inline __gnu_inline __inline_maybe_unused notrace
                  ^
   In file included from fs/bcachefs/btree_key_cache.c:4:
   fs/bcachefs/btree_iter.h:230:8: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
   static inline int btree_trans_restart(struct btree_trans *trans, int err)
          ^
   include/linux/compiler_types.h:215:16: note: expanded from macro 'inline'
   #define inline inline __gnu_inline __inline_maybe_unused notrace
                  ^
   In file included from fs/bcachefs/btree_key_cache.c:6:
   fs/bcachefs/btree_locking.h:88:46: warning: implicit conversion from enumeration type 'enum six_lock_type' to different enumeration type 'enum btree_node_locked_type' [-Wenum-conversion]
           mark_btree_node_locked_noreset(path, level, type);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~              ^~~~
   fs/bcachefs/btree_locking.h:175:51: warning: implicit conversion from enumeration type 'enum six_lock_type' to different enumeration type 'enum btree_node_locked_type' [-Wenum-conversion]
           mark_btree_node_locked_noreset(path, b->c.level, SIX_LOCK_intent);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                   ^~~~~~~~~~~~~~~
   fs/bcachefs/btree_locking.h:239:33: warning: implicit conversion from enumeration type 'enum btree_node_locked_type' to different enumeration type 'enum six_lock_type' [-Wenum-conversion]
                           six_lock_increment(&b->lock, want);
                           ~~~~~~~~~~~~~~~~~~           ^~~~
   fs/bcachefs/btree_locking.h:259:49: warning: implicit conversion from enumeration type 'enum six_lock_type' to different enumeration type 'enum btree_node_locked_type' [-Wenum-conversion]
               btree_node_lock_increment(trans, b, level, type) ||
               ~~~~~~~~~~~~~~~~~~~~~~~~~                  ^~~~
   fs/bcachefs/btree_locking.h:286:49: warning: implicit conversion from enumeration type 'enum six_lock_type' to different enumeration type 'enum btree_node_locked_type' [-Wenum-conversion]
           mark_btree_node_locked_noreset(path, b->level, SIX_LOCK_write);
           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                 ^~~~~~~~~~~~~~
>> fs/bcachefs/btree_key_cache.c:113:7: warning: result of comparison of constant 9223372036854775807 with expression of type 'unsigned int' is always true [-Wtautological-constant-out-of-range-compare]
                   if (ULONG_CMP_GE(ck->btree_trans_barrier_seq,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:35:43: note: expanded from macro 'ULONG_CMP_GE'
   #define ULONG_CMP_GE(a, b)      (ULONG_MAX / 2 >= (a) - (b))
                                    ~~~~~~~~~~~~~ ^  ~~~~~~~~~
   8 warnings generated.


vim +113 fs/bcachefs/btree_key_cache.c

   105	
   106	#ifdef __KERNEL__
   107	static void __bkey_cached_move_to_freelist_ordered(struct btree_key_cache *bc,
   108							   struct bkey_cached *ck)
   109	{
   110		struct bkey_cached *pos;
   111	
   112		list_for_each_entry_reverse(pos, &bc->freed_nonpcpu, list) {
 > 113			if (ULONG_CMP_GE(ck->btree_trans_barrier_seq,
   114					 pos->btree_trans_barrier_seq)) {
   115				list_move(&ck->list, &pos->list);
   116				return;
   117			}
   118		}
   119	
   120		list_move(&ck->list, &bc->freed_nonpcpu);
   121	}
   122	#endif
   123	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
