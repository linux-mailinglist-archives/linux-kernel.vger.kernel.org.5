Return-Path: <linux-kernel+bounces-1799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63087815408
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0601F254D5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDCA18EC3;
	Fri, 15 Dec 2023 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egVSP3DB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A81DDC5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702681049; x=1734217049;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+kwpLQOx8MuuFTHbm1kAaaUZxSHj1aCcQJT3fgF/Pz4=;
  b=egVSP3DBexU9psnf9Gf1u6BqI2EfzgjZnqzz8PqNTb3Zu6uWDPNi34Fd
   3lT7Rr+5fcym3XAXe+NjPf5HoiCyvdGZ2EgyNj/Jsej28+zwo5ouqh35u
   uZawnu2IuQtYkkkf14HKnEvtMVb2WeW0AVpNyX3Stj9phkg564/E2SHye
   xHqdgVuCAVx7pfQf7nOanHmwtI0CNDPeum6Q/bjSGxfcxJuEmiDDPFxB6
   9lqPpaNDvmukDpGSu6vSygW+Ceq+p3bkggzJ6ZdHD4pUNSHvSBJZQ/mkS
   FBbetjP7Tg3HZnFjy0VhL1UUd8zrXN0QPQU7ou51ZCtdF7EIFqTmsU/Pe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="375491216"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="375491216"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 14:57:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="16445248"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 15 Dec 2023 14:57:27 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEH7U-0000ri-2Q;
	Fri, 15 Dec 2023 22:57:24 +0000
Date: Sat, 16 Dec 2023 06:57:24 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kmo@daterainc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/snapshot.c:974:17: sparse: sparse: cast from restricted
 __le32
Message-ID: <202312160608.Di8lWfTr-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3bd7d748816927202268cb335921f7f68b3ca723
commit: 8e877caaad818595ecb6754355cea2058fd9848e bcachefs: Split out snapshot.c
date:   8 weeks ago
config: mips-randconfig-r132-20231115 (https://download.01.org/0day-ci/archive/20231216/202312160608.Di8lWfTr-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231216/202312160608.Di8lWfTr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160608.Di8lWfTr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/bcachefs/snapshot.c:974:17: sparse: sparse: cast from restricted __le32

vim +974 fs/bcachefs/snapshot.c

   916	
   917	static int bch2_snapshot_node_delete(struct btree_trans *trans, u32 id)
   918	{
   919		struct bch_fs *c = trans->c;
   920		struct btree_iter iter, p_iter = (struct btree_iter) { NULL };
   921		struct btree_iter tree_iter = (struct btree_iter) { NULL };
   922		struct bkey_s_c_snapshot s;
   923		u32 parent_id;
   924		unsigned i;
   925		int ret = 0;
   926	
   927		s = bch2_bkey_get_iter_typed(trans, &iter, BTREE_ID_snapshots, POS(0, id),
   928					     BTREE_ITER_INTENT, snapshot);
   929		ret = bkey_err(s);
   930		bch2_fs_inconsistent_on(bch2_err_matches(ret, ENOENT), c,
   931					"missing snapshot %u", id);
   932	
   933		if (ret)
   934			goto err;
   935	
   936		BUG_ON(!BCH_SNAPSHOT_DELETED(s.v));
   937		parent_id = le32_to_cpu(s.v->parent);
   938	
   939		if (parent_id) {
   940			struct bkey_i_snapshot *parent;
   941	
   942			parent = bch2_bkey_get_mut_typed(trans, &p_iter,
   943					     BTREE_ID_snapshots, POS(0, parent_id),
   944					     0, snapshot);
   945			ret = PTR_ERR_OR_ZERO(parent);
   946			if (unlikely(ret)) {
   947				bch2_fs_inconsistent_on(bch2_err_matches(ret, ENOENT), c,
   948							"missing snapshot %u", parent_id);
   949				goto err;
   950			}
   951	
   952			for (i = 0; i < 2; i++)
   953				if (le32_to_cpu(parent->v.children[i]) == id)
   954					break;
   955	
   956			if (i == 2)
   957				bch_err(c, "snapshot %u missing child pointer to %u",
   958					parent_id, id);
   959			else
   960				parent->v.children[i] = 0;
   961	
   962			if (le32_to_cpu(parent->v.children[0]) <
   963			    le32_to_cpu(parent->v.children[1]))
   964				swap(parent->v.children[0],
   965				     parent->v.children[1]);
   966		} else {
   967			/*
   968			 * We're deleting the root of a snapshot tree: update the
   969			 * snapshot_tree entry to point to the new root, or delete it if
   970			 * this is the last snapshot ID in this tree:
   971			 */
   972			struct bkey_i_snapshot_tree *s_t;
   973	
 > 974			BUG_ON(s.v->children[1]);
   975	
   976			s_t = bch2_bkey_get_mut_typed(trans, &tree_iter,
   977					BTREE_ID_snapshot_trees, POS(0, le32_to_cpu(s.v->tree)),
   978					0, snapshot_tree);
   979			ret = PTR_ERR_OR_ZERO(s_t);
   980			if (ret)
   981				goto err;
   982	
   983			if (s.v->children[0]) {
   984				s_t->v.root_snapshot = s.v->children[0];
   985			} else {
   986				s_t->k.type = KEY_TYPE_deleted;
   987				set_bkey_val_u64s(&s_t->k, 0);
   988			}
   989		}
   990	
   991		ret = bch2_btree_delete_at(trans, &iter, 0);
   992	err:
   993		bch2_trans_iter_exit(trans, &tree_iter);
   994		bch2_trans_iter_exit(trans, &p_iter);
   995		bch2_trans_iter_exit(trans, &iter);
   996		return ret;
   997	}
   998	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

