Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FCC80B395
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjLIKVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 05:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjLIKVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 05:21:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B29812E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 02:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702117313; x=1733653313;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/ksl0sdPrEXa+KPusl2nMjqXcvg9LCAN3e0GNe+nZig=;
  b=AxIHGw9SwMjhWBVg9vdPVGkG1c09l1KN6wBgk9QlNUOzdLaLokMvr5Tw
   q7awAzt9zCpkPjdbKLI3Cvj/M5yZgHuCIiCLpmazdrZ+QJXXk5bf1pJHo
   FTehaMdyxCplV8I4aeyQutJUutmRYPnHXCGBoT+oHEcaCZrpO6DnGW7WY
   EPBvQcpQoV4IfPyUGA963hsujOgWEJ42Tg0JgSD2QZS8oMdLxd82/gNY3
   WHtXYkflN8UfOSqXHMtcTH0Iz8Ej6uAzeJKEoTB9FOjvVxjjFZnmZ3AfO
   jqk1IZLreV5g8/2Rf4hFzYlyvaKVn+uaKbG8AXG66SHEmaeIAghhVHnly
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="1576258"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="1576258"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 02:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="13760149"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 09 Dec 2023 02:21:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBuSM-000FBp-0B;
        Sat, 09 Dec 2023 10:21:47 +0000
Date:   Sat, 9 Dec 2023 18:20:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: [paulmck-rcu:frederic.2023.12.08a 29/37]
 fs/btrfs/transaction.c:496:6: error: call to '__compiletime_assert_329'
 declared with 'error' attribute: Need native word sized stores/loads for
 atomicity.
Message-ID: <202312091837.cKaPw0Tf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git frederic.2023.12.08a
head:   37843b5f561a08ae899fb791eeeb5abd992eabe2
commit: 7dd87072d40809e26503f04b79d63290288dbbac [29/37] btrfs: Adjust ->last_trans ordering in btrfs_record_root_in_trans()
config: riscv-rv32_defconfig (https://download.01.org/0day-ci/archive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091837.cKaPw0Tf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312091837.cKaPw0Tf-lkp@intel.com/

All errors (new ones prefixed by >>):

   warning: unknown warning option '-Wpacked-not-aligned'; did you mean '-Wpacked-non-pod'? [-Wunknown-warning-option]
   warning: unknown warning option '-Wstringop-truncation'; did you mean '-Wstring-concatenation'? [-Wunknown-warning-option]
   warning: unknown warning option '-Wmaybe-uninitialized'; did you mean '-Wuninitialized'? [-Wunknown-warning-option]
>> fs/btrfs/transaction.c:496:6: error: call to '__compiletime_assert_329' declared with 'error' attribute: Need native word sized stores/loads for atomicity.
     496 |         if (smp_load_acquire(&root->last_trans) == trans->transid && /* ^^^ */
         |             ^
   include/asm-generic/barrier.h:176:29: note: expanded from macro 'smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^
   arch/riscv/include/asm/barrier.h:42:2: note: expanded from macro '__smp_load_acquire'
      42 |         compiletime_assert_atomic_type(*p);                             \
         |         ^
   include/linux/compiler_types.h:438:2: note: expanded from macro 'compiletime_assert_atomic_type'
     438 |         compiletime_assert(__native_word(t),                            \
         |         ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:423:2: note: expanded from macro '_compiletime_assert'
     423 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:416:4: note: expanded from macro '__compiletime_assert'
     416 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:60:1: note: expanded from here
      60 | __compiletime_assert_329
         | ^
   fs/btrfs/transaction.c:434:3: error: call to '__compiletime_assert_326' declared with 'error' attribute: Need native word sized stores/loads for atomicity.
     434 |                 smp_store_release(&root->last_trans, trans->transid); /* ^^^ */
         |                 ^
   include/asm-generic/barrier.h:172:55: note: expanded from macro 'smp_store_release'
     172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^
   arch/riscv/include/asm/barrier.h:34:2: note: expanded from macro '__smp_store_release'
      34 |         compiletime_assert_atomic_type(*p);                             \
         |         ^
   include/linux/compiler_types.h:438:2: note: expanded from macro 'compiletime_assert_atomic_type'
     438 |         compiletime_assert(__native_word(t),                            \
         |         ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:423:2: note: expanded from macro '_compiletime_assert'
     423 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:416:4: note: expanded from macro '__compiletime_assert'
     416 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:46:1: note: expanded from here
      46 | __compiletime_assert_326
         | ^
>> fs/btrfs/transaction.c:496:6: error: call to '__compiletime_assert_329' declared with 'error' attribute: Need native word sized stores/loads for atomicity.
     496 |         if (smp_load_acquire(&root->last_trans) == trans->transid && /* ^^^ */
         |             ^
   include/asm-generic/barrier.h:176:29: note: expanded from macro 'smp_load_acquire'
     176 | #define smp_load_acquire(p) __smp_load_acquire(p)
         |                             ^
   arch/riscv/include/asm/barrier.h:42:2: note: expanded from macro '__smp_load_acquire'
      42 |         compiletime_assert_atomic_type(*p);                             \
         |         ^
   include/linux/compiler_types.h:438:2: note: expanded from macro 'compiletime_assert_atomic_type'
     438 |         compiletime_assert(__native_word(t),                            \
         |         ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:423:2: note: expanded from macro '_compiletime_assert'
     423 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:416:4: note: expanded from macro '__compiletime_assert'
     416 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:60:1: note: expanded from here
      60 | __compiletime_assert_329
         | ^
   3 warnings and 3 errors generated.


vim +496 fs/btrfs/transaction.c

   481	
   482	int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
   483				       struct btrfs_root *root)
   484	{
   485		struct btrfs_fs_info *fs_info = root->fs_info;
   486		int ret;
   487	
   488		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
   489			return 0;
   490	
   491		/*
   492		 * see record_root_in_trans for comments about IN_TRANS_SETUP usage
   493		 * and barriers.  The smp_load_acquire() pairs with the smp_wmb()
   494		 * and the test_bit_acquire pairs with the smp_mb__before_atomic().
   495		 */
 > 496		if (smp_load_acquire(&root->last_trans) == trans->transid && /* ^^^ */
   497		    !test_bit_acquire(BTRFS_ROOT_IN_TRANS_SETUP, &root->state)) /* ^^^ */
   498			return 0;
   499	
   500		mutex_lock(&fs_info->reloc_mutex);
   501		ret = record_root_in_trans(trans, root, 0);
   502		mutex_unlock(&fs_info->reloc_mutex);
   503	
   504		return ret;
   505	}
   506	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
