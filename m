Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 655807F0878
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjKSTaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjKSTaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:30:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A081E5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700422212; x=1731958212;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qFxr+/4CMEPIRZML3/Xa1WsTsz984n64GblEadV2PaY=;
  b=f/7YzihdLdLnZty8n7yugpjEj9TfDJ2S0ENWWMhwj4kf1lTHUQOR3PT6
   cJZGEtTj7WCEGhiwAbNjo6D5SWhUSwiu1PZlzDgRYc2Y3fjNYf+DiBaPx
   u0+h8wB3q+GDrbHgQnqZr/mPa5GE6tVMKmGVrJyqS4YPIb/rNZrN3YZxd
   QXLYOvyVPHtxrAloCcVM1Rrd38LA+zzDio8A9zGK/9zPCB6nZAyoR50GW
   9TAn/fUP6QnmBDRsDmNEJZVXXbOaxYizo97qZ78FIH/Av/l3TFXgzfNZA
   /8VECm37rmjvy0Er/Mm6xydad3B4TMhAig5M8qoCdh32ejf87eNGpTQRN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="13071991"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="13071991"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 11:30:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="939608785"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="939608785"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2023 11:30:10 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4nUd-0005To-2k;
        Sun, 19 Nov 2023 19:30:07 +0000
Date:   Mon, 20 Nov 2023 03:29:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: fs/bcachefs/fsck.c:434:12: warning: stack frame size (1040) exceeds
 limit (1024) in 'reattach_inode'
Message-ID: <202311200325.hyLM4Sx8-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   037266a5f7239ead1530266f7d7af153d2a867fa
commit: a8b3a677e786fa869d220a6a78b5532a36dc2f4d bcachefs: Nocow support
date:   4 weeks ago
config: arm-randconfig-002-20231120 (https://download.01.org/0day-ci/archive/20231120/202311200325.hyLM4Sx8-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231120/202311200325.hyLM4Sx8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311200325.hyLM4Sx8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/bcachefs/fsck.c:5:
   In file included from fs/bcachefs/btree_update.h:5:
   fs/bcachefs/btree_iter.h:248:8: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
   static inline int btree_trans_restart_nounlock(struct btree_trans *trans, int err)
          ^
   include/linux/compiler_types.h:215:16: note: expanded from macro 'inline'
   #define inline inline __gnu_inline __inline_maybe_unused notrace
                  ^
   In file included from fs/bcachefs/fsck.c:5:
   In file included from fs/bcachefs/btree_update.h:5:
   fs/bcachefs/btree_iter.h:258:8: warning: duplicate 'inline' declaration specifier [-Wduplicate-decl-specifier]
   static inline int btree_trans_restart(struct btree_trans *trans, int err)
          ^
   include/linux/compiler_types.h:215:16: note: expanded from macro 'inline'
   #define inline inline __gnu_inline __inline_maybe_unused notrace
                  ^
   fs/bcachefs/fsck.c:1001:12: warning: stack frame size (1104) exceeds limit (1024) in 'check_inodes' [-Wframe-larger-than]
   static int check_inodes(struct bch_fs *c, bool full)
              ^
   fs/bcachefs/fsck.c:1672:12: warning: stack frame size (1192) exceeds limit (1024) in 'check_dirents' [-Wframe-larger-than]
   static int check_dirents(struct bch_fs *c)
              ^
>> fs/bcachefs/fsck.c:434:12: warning: stack frame size (1040) exceeds limit (1024) in 'reattach_inode' [-Wframe-larger-than]
   static int reattach_inode(struct btree_trans *trans,
              ^
   5 warnings generated.


vim +/reattach_inode +434 fs/bcachefs/fsck.c

285b181ad460bb Kent Overstreet 2021-10-28  433  
285b181ad460bb Kent Overstreet 2021-10-28 @434  static int reattach_inode(struct btree_trans *trans,
285b181ad460bb Kent Overstreet 2021-10-28  435  			  struct bch_inode_unpacked *inode,
285b181ad460bb Kent Overstreet 2021-10-28  436  			  u32 inode_snapshot)
285b181ad460bb Kent Overstreet 2021-10-28  437  {
e68914ca849fa5 Kent Overstreet 2022-07-13  438  	int ret = commit_do(trans, NULL, NULL,
285b181ad460bb Kent Overstreet 2021-10-28  439  				  BTREE_INSERT_LAZY_RW|
285b181ad460bb Kent Overstreet 2021-10-28  440  				  BTREE_INSERT_NOFAIL,
285b181ad460bb Kent Overstreet 2021-10-28  441  			__reattach_inode(trans, inode, inode_snapshot));
58686a259ed28f Kent Overstreet 2021-04-19  442  	if (ret) {
d4bf5eecd78a90 Kent Overstreet 2022-07-18  443  		bch_err(trans->c, "error reattaching inode %llu: %s",
d4bf5eecd78a90 Kent Overstreet 2022-07-18  444  			inode->bi_inum, bch2_err_str(ret));
58686a259ed28f Kent Overstreet 2021-04-19  445  		return ret;
58686a259ed28f Kent Overstreet 2021-04-19  446  	}
58686a259ed28f Kent Overstreet 2021-04-19  447  
285b181ad460bb Kent Overstreet 2021-10-28  448  	return ret;
58686a259ed28f Kent Overstreet 2021-04-19  449  }
58686a259ed28f Kent Overstreet 2021-04-19  450  

:::::: The code at line 434 was first introduced by commit
:::::: 285b181ad460bb240041a9ca7935f9e884040405 bcachefs: Improve transaction restart handling in fsck code

:::::: TO: Kent Overstreet <kent.overstreet@gmail.com>
:::::: CC: Kent Overstreet <kent.overstreet@linux.dev>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
