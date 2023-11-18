Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FE87EFD62
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjKRDKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRDKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:10:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1AF120
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700277049; x=1731813049;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k1pdNEvj+Wq6UzFW3DfVYO3iWwVtpSz7zaznBuWvaw8=;
  b=NZbctxmXSEhrTuKW9yk2OKTNQi6H+gq41k9mKeufeq19FTtT9bAXg5PO
   ey9knO6HtPizILs6Cmp9MujGeFkgg8L/HBSvcdpzqfosjcvh704NA/5av
   r7gIKUQP4IXaI0XTYXU24yzSm69Ny0oW6NFiQ8Kdc6ySsD6yhTFCVeWkn
   EJSh26Fsibjq32BE2X38zsQumhy348VWz7aZ+qA3+g+Yjnc7H/lmfvPc/
   uIcX/q1qHwC+Cwzj+TUHW/V3NaoSoiKuQryJXetm2s6NQwpdWdzOBVjx5
   I648wQr9tN9ZXzC/H2X+VN1N7qzKmCq7YrccwbRQfxFJ4wWXmgvbgPVYr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="455698659"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="455698659"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 19:10:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1013102337"
X-IronPort-AV: E=Sophos;i="6.04,207,1695711600"; 
   d="scan'208";a="1013102337"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Nov 2023 19:10:48 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4BjI-0003T8-1A;
        Sat, 18 Nov 2023 03:10:45 +0000
Date:   Sat, 18 Nov 2023 11:10:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/snapshot.c:962:9: sparse: sparse: cast from restricted
 __le32
Message-ID: <202311181146.DJCFO6rR-lkp@intel.com>
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
head:   791c8ab095f71327899023223940dd52257a4173
commit: f55d6e07bc6c9b90f58586daf9c432adb5f5ce25 bcachefs: Cleanup redundant snapshot nodes
date:   4 weeks ago
config: mips-randconfig-r132-20231115 (https://download.01.org/0day-ci/archive/20231118/202311181146.DJCFO6rR-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231118/202311181146.DJCFO6rR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311181146.DJCFO6rR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/bcachefs/snapshot.c:962:9: sparse: sparse: cast from restricted __le32
   fs/bcachefs/snapshot.c:989:41: sparse: sparse: cast to restricted __le32
   fs/bcachefs/snapshot.c:989:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 @@     got unsigned int [usertype] @@
   fs/bcachefs/snapshot.c:989:39: sparse:     expected restricted __le32
   fs/bcachefs/snapshot.c:989:39: sparse:     got unsigned int [usertype]
   fs/bcachefs/snapshot.c:1023:17: sparse: sparse: cast from restricted __le32
   fs/bcachefs/snapshot.c:942:5: sparse: sparse: symbol 'bch2_snapshot_node_delete' was not declared. Should it be static?

vim +962 fs/bcachefs/snapshot.c

   941	
   942	int bch2_snapshot_node_delete(struct btree_trans *trans, u32 id)
   943	{
   944		struct bch_fs *c = trans->c;
   945		struct btree_iter iter, p_iter = (struct btree_iter) { NULL };
   946		struct btree_iter c_iter = (struct btree_iter) { NULL };
   947		struct btree_iter tree_iter = (struct btree_iter) { NULL };
   948		struct bkey_s_c_snapshot s;
   949		u32 parent_id, child_id;
   950		unsigned i;
   951		int ret = 0;
   952	
   953		s = bch2_bkey_get_iter_typed(trans, &iter, BTREE_ID_snapshots, POS(0, id),
   954					     BTREE_ITER_INTENT, snapshot);
   955		ret = bkey_err(s);
   956		bch2_fs_inconsistent_on(bch2_err_matches(ret, ENOENT), c,
   957					"missing snapshot %u", id);
   958	
   959		if (ret)
   960			goto err;
   961	
 > 962		BUG_ON(s.v->children[1]);
   963	
   964		parent_id = le32_to_cpu(s.v->parent);
   965		child_id = le32_to_cpu(s.v->children[0]);
   966	
   967		if (parent_id) {
   968			struct bkey_i_snapshot *parent;
   969	
   970			parent = bch2_bkey_get_mut_typed(trans, &p_iter,
   971					     BTREE_ID_snapshots, POS(0, parent_id),
   972					     0, snapshot);
   973			ret = PTR_ERR_OR_ZERO(parent);
   974			bch2_fs_inconsistent_on(bch2_err_matches(ret, ENOENT), c,
   975						"missing snapshot %u", parent_id);
   976			if (unlikely(ret))
   977				goto err;
   978	
   979			/* find entry in parent->children for node being deleted */
   980			for (i = 0; i < 2; i++)
   981				if (le32_to_cpu(parent->v.children[i]) == id)
   982					break;
   983	
   984			if (bch2_fs_inconsistent_on(i == 2, c,
   985						"snapshot %u missing child pointer to %u",
   986						parent_id, id))
   987				goto err;
   988	
   989			parent->v.children[i] = le32_to_cpu(child_id);
   990	
   991			normalize_snapshot_child_pointers(&parent->v);
   992		}
   993	
   994		if (child_id) {
   995			struct bkey_i_snapshot *child;
   996	
   997			child = bch2_bkey_get_mut_typed(trans, &c_iter,
   998					     BTREE_ID_snapshots, POS(0, child_id),
   999					     0, snapshot);
  1000			ret = PTR_ERR_OR_ZERO(child);
  1001			bch2_fs_inconsistent_on(bch2_err_matches(ret, ENOENT), c,
  1002						"missing snapshot %u", child_id);
  1003			if (unlikely(ret))
  1004				goto err;
  1005	
  1006			child->v.parent = cpu_to_le32(parent_id);
  1007	
  1008			if (!child->v.parent) {
  1009				child->v.skip[0] = 0;
  1010				child->v.skip[1] = 0;
  1011				child->v.skip[2] = 0;
  1012			}
  1013		}
  1014	
  1015		if (!parent_id) {
  1016			/*
  1017			 * We're deleting the root of a snapshot tree: update the
  1018			 * snapshot_tree entry to point to the new root, or delete it if
  1019			 * this is the last snapshot ID in this tree:
  1020			 */
  1021			struct bkey_i_snapshot_tree *s_t;
  1022	
  1023			BUG_ON(s.v->children[1]);
  1024	
  1025			s_t = bch2_bkey_get_mut_typed(trans, &tree_iter,
  1026					BTREE_ID_snapshot_trees, POS(0, le32_to_cpu(s.v->tree)),
  1027					0, snapshot_tree);
  1028			ret = PTR_ERR_OR_ZERO(s_t);
  1029			if (ret)
  1030				goto err;
  1031	
  1032			if (s.v->children[0]) {
  1033				s_t->v.root_snapshot = s.v->children[0];
  1034			} else {
  1035				s_t->k.type = KEY_TYPE_deleted;
  1036				set_bkey_val_u64s(&s_t->k, 0);
  1037			}
  1038		}
  1039	
  1040		ret = bch2_btree_delete_at(trans, &iter, 0);
  1041	err:
  1042		bch2_trans_iter_exit(trans, &tree_iter);
  1043		bch2_trans_iter_exit(trans, &p_iter);
  1044		bch2_trans_iter_exit(trans, &c_iter);
  1045		bch2_trans_iter_exit(trans, &iter);
  1046		return ret;
  1047	}
  1048	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
