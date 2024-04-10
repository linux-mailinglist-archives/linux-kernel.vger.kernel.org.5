Return-Path: <linux-kernel+bounces-137745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D968889E69F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088D61C2183E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E05391;
	Wed, 10 Apr 2024 00:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mebwIU1Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C27F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707754; cv=none; b=fbRRQGtst/+l3cMz/iqnfDyMcumB1s9PKOfRcJioO+ba581uYEhc/ccubLADupmvrZewDwv89dfA3ZH2bZo9nk9Z5LsGXEmt0l88OUBMVSmnIg3M9yRj1aur05MBCD6bB2DGJbihEjsILA3PL0M40cHH2ImrB4Xccady+kzPuS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707754; c=relaxed/simple;
	bh=MqRwpCcUTE8ROvGrn0LrVmIiCOJF15TV1p6DAROjZOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W2MVSvcDZYI0yek7YXh0f6zGfhPUaqGKbOKegm4ULHFAhVDWcWTY1AqbSbmm8h6W5oHSw/MX8HAFw8FdhtzWSwFQ3CPSnoFRDbIfyfi3fuvbEvGuRnCbVfY7xGehOSOyZ1N0BLdqocb2Bdpv0Jh7W37S89kap+68uD3izSYKjGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mebwIU1Y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712707753; x=1744243753;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MqRwpCcUTE8ROvGrn0LrVmIiCOJF15TV1p6DAROjZOc=;
  b=mebwIU1Y0N/e6Sb9BxRWATUnHjTamyyFBjZd3nPJsAHhm5W6LCxl1AfK
   51AlIP3LmxtGpwMzNng5L222a8GsYMZPuHqHScM7BY52XM0jqcoie7TLW
   fg0keJU+57HcDl0rvGazmW2XZh4r2e7qV67LTReRpv6nZqVKgGgVtF+q6
   MI1++EcN49nhMWVLVmo3mdxJMwQzmgMO4UZ2JuZAHB4f0gwNxSGtxTGhd
   tR60B9m5YvyBt5s3gJQ8V2AP9JCXHGh0SgF43sVUmjPqLL4vgN4c8qhT4
   bzSXL+FOLD8kIz/4F9o98OSZb81Ttd9iRJIUqTS2U7uxU4Dj4tyKBxuNt
   A==;
X-CSE-ConnectionGUID: esuZZU15R5KPCgfQEJnIuA==
X-CSE-MsgGUID: ib7ITePASG6U05eTr9DZug==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18765928"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18765928"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 17:09:12 -0700
X-CSE-ConnectionGUID: 8s78tHBAR3Oqddjl82D9Bw==
X-CSE-MsgGUID: yD05rYJMRO6QDCqhJnRrAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25143227"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 09 Apr 2024 17:09:11 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruLWW-0006dk-0w;
	Wed, 10 Apr 2024 00:09:08 +0000
Date: Wed, 10 Apr 2024 08:08:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.04.04a 17/74] mm/memcontrol.c:1200:31: sparse:
 sparse: incorrect type in argument 2 (different base types)
Message-ID: <202404100829.OchVjDmF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.04.04a
head:   e2a520f3f3921cb5d3c9631917fccf8c215991ce
commit: 27011e7159ef6e100e9ae1debb01a8e180ee94bf [17/74] riscv: Emulate one-byte cmpxchg
config: riscv-randconfig-r122-20240409 (https://download.01.org/0day-ci/archive/20240410/202404100829.OchVjDmF-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240410/202404100829.OchVjDmF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404100829.OchVjDmF-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/memcontrol.c:1200:31: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned long [usertype] old @@     got struct mem_cgroup *__old @@
   mm/memcontrol.c:1200:31: sparse:     expected unsigned long [usertype] old
   mm/memcontrol.c:1200:31: sparse:     got struct mem_cgroup *__old
>> mm/memcontrol.c:1200:31: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] new @@     got struct mem_cgroup *__new @@
   mm/memcontrol.c:1200:31: sparse:     expected unsigned long [usertype] new
   mm/memcontrol.c:1200:31: sparse:     got struct mem_cgroup *__new
   mm/memcontrol.c:1240:23: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned long [usertype] old @@     got struct mem_cgroup *__old @@
   mm/memcontrol.c:1240:23: sparse:     expected unsigned long [usertype] old
   mm/memcontrol.c:1240:23: sparse:     got struct mem_cgroup *__old
   mm/memcontrol.c:1240:23: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] new @@     got struct mem_cgroup *__new @@
   mm/memcontrol.c:1240:23: sparse:     expected unsigned long [usertype] new
   mm/memcontrol.c:1240:23: sparse:     got struct mem_cgroup *__new
   mm/memcontrol.c:1281:17: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned long [usertype] old @@     got struct mem_cgroup *__old @@
   mm/memcontrol.c:1281:17: sparse:     expected unsigned long [usertype] old
   mm/memcontrol.c:1281:17: sparse:     got struct mem_cgroup *__old
   mm/memcontrol.c:1281:17: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] new @@     got struct mem_cgroup *__new @@
   mm/memcontrol.c:1281:17: sparse:     expected unsigned long [usertype] new
   mm/memcontrol.c:1281:17: sparse:     got struct mem_cgroup *__new
>> mm/memcontrol.c:3184:19: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned long [usertype] old @@     got struct obj_cgroup *__old @@
   mm/memcontrol.c:3184:19: sparse:     expected unsigned long [usertype] old
   mm/memcontrol.c:3184:19: sparse:     got struct obj_cgroup *__old
>> mm/memcontrol.c:3184:19: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] new @@     got struct obj_cgroup *__new @@
   mm/memcontrol.c:3184:19: sparse:     expected unsigned long [usertype] new
   mm/memcontrol.c:3184:19: sparse:     got struct obj_cgroup *__new
   mm/memcontrol.c:4408:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:4408:21: sparse:    struct mem_cgroup_threshold_ary [noderef] __rcu *
   mm/memcontrol.c:4408:21: sparse:    struct mem_cgroup_threshold_ary *
   mm/memcontrol.c:4410:21: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:4410:21: sparse:    struct mem_cgroup_threshold_ary [noderef] __rcu *
   mm/memcontrol.c:4410:21: sparse:    struct mem_cgroup_threshold_ary *
   mm/memcontrol.c:4566:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:4566:9: sparse:    struct mem_cgroup_threshold_ary [noderef] __rcu *
   mm/memcontrol.c:4566:9: sparse:    struct mem_cgroup_threshold_ary *
   mm/memcontrol.c:4660:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   mm/memcontrol.c:4660:9: sparse:    struct mem_cgroup_threshold_ary [noderef] __rcu *
   mm/memcontrol.c:4660:9: sparse:    struct mem_cgroup_threshold_ary *
   mm/memcontrol.c: note: in included file:
   include/linux/memcontrol.h:761:9: sparse: sparse: context imbalance in 'folio_lruvec_lock' - wrong count at exit
   include/linux/memcontrol.h:761:9: sparse: sparse: context imbalance in 'folio_lruvec_lock_irq' - wrong count at exit
   include/linux/memcontrol.h:761:9: sparse: sparse: context imbalance in 'folio_lruvec_lock_irqsave' - wrong count at exit
   mm/memcontrol.c:2185:6: sparse: sparse: context imbalance in 'folio_memcg_lock' - wrong count at exit
   mm/memcontrol.c:2232:17: sparse: sparse: context imbalance in '__folio_memcg_unlock' - unexpected unlock
--
>> fs/fs-writeback.c:291:13: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned long [usertype] old @@     got struct bdi_writeback *__old @@
   fs/fs-writeback.c:291:13: sparse:     expected unsigned long [usertype] old
   fs/fs-writeback.c:291:13: sparse:     got struct bdi_writeback *__old
>> fs/fs-writeback.c:291:13: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] new @@     got struct bdi_writeback *__new @@
   fs/fs-writeback.c:291:13: sparse:     expected unsigned long [usertype] new
   fs/fs-writeback.c:291:13: sparse:     got struct bdi_writeback *__new
   fs/fs-writeback.c:753:15: sparse: sparse: context imbalance in 'wbc_attach_and_unlock_inode' - unexpected unlock
   fs/fs-writeback.c:1804:20: sparse: sparse: context imbalance in 'writeback_single_inode' - different lock contexts for basic block
   fs/fs-writeback.c:1990:9: sparse: sparse: context imbalance in 'writeback_sb_inodes' - different lock contexts for basic block
   fs/fs-writeback.c:2580:20: sparse: sparse: context imbalance in '__mark_inode_dirty' - unexpected unlock
--
   fs/bcachefs/btree_cache.c: note: in included file:
   fs/bcachefs/bcachefs.h:1023:9: sparse: sparse: array of flexible structures
>> fs/bcachefs/btree_cache.c:534:15: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned long [usertype] old @@     got struct task_struct *__old @@
   fs/bcachefs/btree_cache.c:534:15: sparse:     expected unsigned long [usertype] old
   fs/bcachefs/btree_cache.c:534:15: sparse:     got struct task_struct *__old
>> fs/bcachefs/btree_cache.c:534:15: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] new @@     got struct task_struct *__new @@
   fs/bcachefs/btree_cache.c:534:15: sparse:     expected unsigned long [usertype] new
   fs/bcachefs/btree_cache.c:534:15: sparse:     got struct task_struct *__new
   fs/bcachefs/btree_cache.c:546:15: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned long [usertype] old @@     got struct task_struct *__old @@
   fs/bcachefs/btree_cache.c:546:15: sparse:     expected unsigned long [usertype] old
   fs/bcachefs/btree_cache.c:546:15: sparse:     got struct task_struct *__old
   fs/bcachefs/btree_cache.c:546:15: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] new @@     got struct task_struct *__new @@
   fs/bcachefs/btree_cache.c:546:15: sparse:     expected unsigned long [usertype] new
   fs/bcachefs/btree_cache.c:546:15: sparse:     got struct task_struct *__new

vim +1200 mm/memcontrol.c

4b569387c0d566 Nhat Pham         2023-10-06  1138  
5660048ccac873 Johannes Weiner   2012-01-12  1139  /**
5660048ccac873 Johannes Weiner   2012-01-12  1140   * mem_cgroup_iter - iterate over memory cgroup hierarchy
5660048ccac873 Johannes Weiner   2012-01-12  1141   * @root: hierarchy root
5660048ccac873 Johannes Weiner   2012-01-12  1142   * @prev: previously returned memcg, NULL on first invocation
5660048ccac873 Johannes Weiner   2012-01-12  1143   * @reclaim: cookie for shared reclaim walks, NULL for full walks
5660048ccac873 Johannes Weiner   2012-01-12  1144   *
5660048ccac873 Johannes Weiner   2012-01-12  1145   * Returns references to children of the hierarchy below @root, or
5660048ccac873 Johannes Weiner   2012-01-12  1146   * @root itself, or %NULL after a full round-trip.
5660048ccac873 Johannes Weiner   2012-01-12  1147   *
5660048ccac873 Johannes Weiner   2012-01-12  1148   * Caller must pass the return value in @prev on subsequent
5660048ccac873 Johannes Weiner   2012-01-12  1149   * invocations for reference counting, or use mem_cgroup_iter_break()
5660048ccac873 Johannes Weiner   2012-01-12  1150   * to cancel a hierarchy walk before the round-trip is complete.
5660048ccac873 Johannes Weiner   2012-01-12  1151   *
05bdc520b3ad39 Miaohe Lin        2020-10-13  1152   * Reclaimers can specify a node in @reclaim to divide up the memcgs
05bdc520b3ad39 Miaohe Lin        2020-10-13  1153   * in the hierarchy among all concurrent reclaimers operating on the
05bdc520b3ad39 Miaohe Lin        2020-10-13  1154   * same node.
5660048ccac873 Johannes Weiner   2012-01-12  1155   */
694fbc0fe78518 Andrew Morton     2013-09-24  1156  struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
9f3a0d0933de07 Johannes Weiner   2012-01-12  1157  				   struct mem_cgroup *prev,
694fbc0fe78518 Andrew Morton     2013-09-24  1158  				   struct mem_cgroup_reclaim_cookie *reclaim)
7d74b06f240f1b KAMEZAWA Hiroyuki 2010-10-27  1159  {
3f649ab728cda8 Kees Cook         2020-06-03  1160  	struct mem_cgroup_reclaim_iter *iter;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1161  	struct cgroup_subsys_state *css = NULL;
9f3a0d0933de07 Johannes Weiner   2012-01-12  1162  	struct mem_cgroup *memcg = NULL;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1163  	struct mem_cgroup *pos = NULL;
711d3d2c9bc3fb KAMEZAWA Hiroyuki 2010-10-27  1164  
694fbc0fe78518 Andrew Morton     2013-09-24  1165  	if (mem_cgroup_disabled())
694fbc0fe78518 Andrew Morton     2013-09-24  1166  		return NULL;
5660048ccac873 Johannes Weiner   2012-01-12  1167  
9f3a0d0933de07 Johannes Weiner   2012-01-12  1168  	if (!root)
9f3a0d0933de07 Johannes Weiner   2012-01-12  1169  		root = root_mem_cgroup;
9f3a0d0933de07 Johannes Weiner   2012-01-12  1170  
542f85f9ae4acd Michal Hocko      2013-04-29  1171  	rcu_read_lock();
14067bb3e24b96 KAMEZAWA Hiroyuki 2009-04-02  1172  
527a5ec9a53471 Johannes Weiner   2012-01-12  1173  	if (reclaim) {
ef8f2327996b5c Mel Gorman        2016-07-28  1174  		struct mem_cgroup_per_node *mz;
527a5ec9a53471 Johannes Weiner   2012-01-12  1175  
a3747b53b1771a Johannes Weiner   2021-04-29  1176  		mz = root->nodeinfo[reclaim->pgdat->node_id];
9da83f3fc74b80 Yafang Shao       2019-11-30  1177  		iter = &mz->iter;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1178  
a9320aae68a1cd Wei Yang          2022-04-28  1179  		/*
a9320aae68a1cd Wei Yang          2022-04-28  1180  		 * On start, join the current reclaim iteration cycle.
a9320aae68a1cd Wei Yang          2022-04-28  1181  		 * Exit when a concurrent walker completes it.
a9320aae68a1cd Wei Yang          2022-04-28  1182  		 */
a9320aae68a1cd Wei Yang          2022-04-28  1183  		if (!prev)
a9320aae68a1cd Wei Yang          2022-04-28  1184  			reclaim->generation = iter->generation;
a9320aae68a1cd Wei Yang          2022-04-28  1185  		else if (reclaim->generation != iter->generation)
542f85f9ae4acd Michal Hocko      2013-04-29  1186  			goto out_unlock;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1187  
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1188  		while (1) {
4db0c3c2983cc6 Jason Low         2015-04-15  1189  			pos = READ_ONCE(iter->position);
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1190  			if (!pos || css_tryget(&pos->css))
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1191  				break;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1192  			/*
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1193  			 * css reference reached zero, so iter->position will
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1194  			 * be cleared by ->css_released. However, we should not
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1195  			 * rely on this happening soon, because ->css_released
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1196  			 * is called from a work queue, and by busy-waiting we
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1197  			 * might block it. So we clear iter->position right
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1198  			 * away.
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1199  			 */
6df38689e0e9a0 Vladimir Davydov  2015-12-29 @1200  			(void)cmpxchg(&iter->position, pos, NULL);
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1201  		}
89d8330ccf2ad4 Wei Yang          2022-04-28  1202  	} else if (prev) {
89d8330ccf2ad4 Wei Yang          2022-04-28  1203  		pos = prev;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1204  	}
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1205  
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1206  	if (pos)
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1207  		css = &pos->css;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1208  
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1209  	for (;;) {
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1210  		css = css_next_descendant_pre(css, &root->css);
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1211  		if (!css) {
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1212  			/*
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1213  			 * Reclaimers share the hierarchy walk, and a
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1214  			 * new one might jump in right at the end of
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1215  			 * the hierarchy - make sure they see at least
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1216  			 * one group and restart from the beginning.
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1217  			 */
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1218  			if (!prev)
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1219  				continue;
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1220  			break;
542f85f9ae4acd Michal Hocko      2013-04-29  1221  		}
5f578161971863 Michal Hocko      2013-04-29  1222  
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1223  		/*
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1224  		 * Verify the css and acquire a reference.  The root
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1225  		 * is provided by the caller, so we know it's alive
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1226  		 * and kicking, and don't take an extra reference.
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1227  		 */
41555dadbff8d2 Wei Yang          2022-04-28  1228  		if (css == &root->css || css_tryget(css)) {
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1229  			memcg = mem_cgroup_from_css(css);
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1230  			break;
41555dadbff8d2 Wei Yang          2022-04-28  1231  		}
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1232  	}
9f3a0d0933de07 Johannes Weiner   2012-01-12  1233  
527a5ec9a53471 Johannes Weiner   2012-01-12  1234  	if (reclaim) {
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1235  		/*
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1236  		 * The position could have already been updated by a competing
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1237  		 * thread, so check that the value hasn't changed since we read
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1238  		 * it to avoid reclaiming from the same cgroup twice.
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1239  		 */
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1240  		(void)cmpxchg(&iter->position, pos, memcg);
6df38689e0e9a0 Vladimir Davydov  2015-12-29  1241  
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1242  		if (pos)
5ac8fb31ad2ebd Johannes Weiner   2014-12-10  1243  			css_put(&pos->css);
542f85f9ae4acd Michal Hocko      2013-04-29  1244  
19f39402864ea3 Michal Hocko      2013-04-29  1245  		if (!memcg)
527a5ec9a53471 Johannes Weiner   2012-01-12  1246  			iter->generation++;
527a5ec9a53471 Johannes Weiner   2012-01-12  1247  	}
14067bb3e24b96 KAMEZAWA Hiroyuki 2009-04-02  1248  
542f85f9ae4acd Michal Hocko      2013-04-29  1249  out_unlock:
542f85f9ae4acd Michal Hocko      2013-04-29  1250  	rcu_read_unlock();
c40046f3ad5e87 Michal Hocko      2013-04-29  1251  	if (prev && prev != root)
c40046f3ad5e87 Michal Hocko      2013-04-29  1252  		css_put(&prev->css);
c40046f3ad5e87 Michal Hocko      2013-04-29  1253  
9f3a0d0933de07 Johannes Weiner   2012-01-12  1254  	return memcg;
9f3a0d0933de07 Johannes Weiner   2012-01-12  1255  }
14067bb3e24b96 KAMEZAWA Hiroyuki 2009-04-02  1256  

:::::: The code at line 1200 was first introduced by commit
:::::: 6df38689e0e9a07ff4f42c06b302e203b33667e9 mm: memcontrol: fix possible memcg leak due to interrupted reclaim

:::::: TO: Vladimir Davydov <vdavydov@virtuozzo.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

