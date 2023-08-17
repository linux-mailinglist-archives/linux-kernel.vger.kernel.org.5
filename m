Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB633780197
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356041AbjHQXUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356112AbjHQXTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:19:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3792435AF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692314383; x=1723850383;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/KYX+UwxWKqr7686vRenFgYqX4HhSNrxF9dbeQaf+WM=;
  b=PRML3c1g5qu2sCRSOTHBdBl1f0pKTySZB7g50/b9+Rcl1UlR5GtTmMnj
   On6HM4iNs77CShk78UGQVgRnTATrCGReIOuBdppwKaJywxl4+5R2bwWWL
   lpmqSk/z+9Leid5/5Hzn6FRrkWppreHkOrmh/xR5EwiuWTFHHcO4hyFp+
   0KY8+vDxKWPaJU/vLEuJrBHJ3K3SB1bUCWNi3jn5V3uR7U8qJGx1YuG0W
   xfiqAHLh5PTangedF4C+X/9kyZcQ5ofacnzaACO0BhHi/vrP+/FC30Au0
   olemWAuUJtn2GEog23Xwwx2FYvGUQoWxlaQev7W+bucayvD0zDkzD2KFB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371858184"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="371858184"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 16:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="981401467"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="981401467"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2023 16:19:40 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWmHD-0001Xv-2m;
        Thu, 17 Aug 2023 23:19:39 +0000
Date:   Fri, 18 Aug 2023 07:19:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/helpers.c:2112:28: warning: no previous declaration for
 'bpf_cgroup_from_id'
Message-ID: <202308180746.GSehftnY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   16931859a6500d360b90aeacab3b505a3560a3ed
commit: 332ea1f697be148bd5e66475d82b5ecc5084da65 bpf: Add bpf_cgroup_from_id() kfunc
date:   6 months ago
config: x86_64-randconfig-x012-20230816 (https://download.01.org/0day-ci/archive/20230818/202308180746.GSehftnY-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308180746.GSehftnY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308180746.GSehftnY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/helpers.c:1819:19: warning: no previous declaration for 'bpf_obj_new_impl' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
                      ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1833:18: warning: no previous declaration for 'bpf_obj_drop_impl' [-Wmissing-declarations]
    __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
                     ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1854:18: warning: no previous declaration for 'bpf_list_push_front' [-Wmissing-declarations]
    __bpf_kfunc void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node)
                     ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1859:18: warning: no previous declaration for 'bpf_list_push_back' [-Wmissing-declarations]
    __bpf_kfunc void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node)
                     ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1877:35: warning: no previous declaration for 'bpf_list_pop_front' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
                                      ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1882:35: warning: no previous declaration for 'bpf_list_pop_back' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
                                      ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1887:33: warning: no previous declaration for 'bpf_rbtree_remove' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
                                    ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1924:18: warning: no previous declaration for 'bpf_rbtree_add' [-Wmissing-declarations]
    __bpf_kfunc void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
                     ^~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1930:33: warning: no previous declaration for 'bpf_rbtree_first' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
                                    ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1943:33: warning: no previous declaration for 'bpf_task_acquire' [-Wmissing-declarations]
    __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
                                    ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1954:33: warning: no previous declaration for 'bpf_task_acquire_not_zero' [-Wmissing-declarations]
    __bpf_kfunc struct task_struct *bpf_task_acquire_not_zero(struct task_struct *p)
                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2006:33: warning: no previous declaration for 'bpf_task_kptr_get' [-Wmissing-declarations]
    __bpf_kfunc struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
                                    ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2019:18: warning: no previous declaration for 'bpf_task_release' [-Wmissing-declarations]
    __bpf_kfunc void bpf_task_release(struct task_struct *p)
                     ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2034:28: warning: no previous declaration for 'bpf_cgroup_acquire' [-Wmissing-declarations]
    __bpf_kfunc struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
                               ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2046:28: warning: no previous declaration for 'bpf_cgroup_kptr_get' [-Wmissing-declarations]
    __bpf_kfunc struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
                               ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2078:18: warning: no previous declaration for 'bpf_cgroup_release' [-Wmissing-declarations]
    __bpf_kfunc void bpf_cgroup_release(struct cgroup *cgrp)
                     ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2093:28: warning: no previous declaration for 'bpf_cgroup_ancestor' [-Wmissing-declarations]
    __bpf_kfunc struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
                               ^~~~~~~~~~~~~~~~~~~
>> kernel/bpf/helpers.c:2112:28: warning: no previous declaration for 'bpf_cgroup_from_id' [-Wmissing-declarations]
    __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
                               ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2129:33: warning: no previous declaration for 'bpf_task_from_pid' [-Wmissing-declarations]
    __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
                                    ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2142:19: warning: no previous declaration for 'bpf_cast_to_kern_ctx' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
                      ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2147:19: warning: no previous declaration for 'bpf_rdonly_cast' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
                      ^~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2152:18: warning: no previous declaration for 'bpf_rcu_read_lock' [-Wmissing-declarations]
    __bpf_kfunc void bpf_rcu_read_lock(void)
                     ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2157:18: warning: no previous declaration for 'bpf_rcu_read_unlock' [-Wmissing-declarations]
    __bpf_kfunc void bpf_rcu_read_unlock(void)
                     ^~~~~~~~~~~~~~~~~~~


vim +/bpf_cgroup_from_id +2112 kernel/bpf/helpers.c

  2039	
  2040	/**
  2041	 * bpf_cgroup_kptr_get - Acquire a reference on a struct cgroup kptr. A cgroup
  2042	 * kptr acquired by this kfunc which is not subsequently stored in a map, must
  2043	 * be released by calling bpf_cgroup_release().
  2044	 * @cgrpp: A pointer to a cgroup kptr on which a reference is being acquired.
  2045	 */
> 2046	__bpf_kfunc struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
  2047	{
  2048		struct cgroup *cgrp;
  2049	
  2050		rcu_read_lock();
  2051		/* Another context could remove the cgroup from the map and release it
  2052		 * at any time, including after we've done the lookup above. This is
  2053		 * safe because we're in an RCU read region, so the cgroup is
  2054		 * guaranteed to remain valid until at least the rcu_read_unlock()
  2055		 * below.
  2056		 */
  2057		cgrp = READ_ONCE(*cgrpp);
  2058	
  2059		if (cgrp && !cgroup_tryget(cgrp))
  2060			/* If the cgroup had been removed from the map and freed as
  2061			 * described above, cgroup_tryget() will return false. The
  2062			 * cgroup will be freed at some point after the current RCU gp
  2063			 * has ended, so just return NULL to the user.
  2064			 */
  2065			cgrp = NULL;
  2066		rcu_read_unlock();
  2067	
  2068		return cgrp;
  2069	}
  2070	
  2071	/**
  2072	 * bpf_cgroup_release - Release the reference acquired on a cgroup.
  2073	 * If this kfunc is invoked in an RCU read region, the cgroup is guaranteed to
  2074	 * not be freed until the current grace period has ended, even if its refcount
  2075	 * drops to 0.
  2076	 * @cgrp: The cgroup on which a reference is being released.
  2077	 */
  2078	__bpf_kfunc void bpf_cgroup_release(struct cgroup *cgrp)
  2079	{
  2080		if (!cgrp)
  2081			return;
  2082	
  2083		cgroup_put(cgrp);
  2084	}
  2085	
  2086	/**
  2087	 * bpf_cgroup_ancestor - Perform a lookup on an entry in a cgroup's ancestor
  2088	 * array. A cgroup returned by this kfunc which is not subsequently stored in a
  2089	 * map, must be released by calling bpf_cgroup_release().
  2090	 * @cgrp: The cgroup for which we're performing a lookup.
  2091	 * @level: The level of ancestor to look up.
  2092	 */
  2093	__bpf_kfunc struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
  2094	{
  2095		struct cgroup *ancestor;
  2096	
  2097		if (level > cgrp->level || level < 0)
  2098			return NULL;
  2099	
  2100		ancestor = cgrp->ancestors[level];
  2101		cgroup_get(ancestor);
  2102		return ancestor;
  2103	}
  2104	
  2105	/**
  2106	 * bpf_cgroup_from_id - Find a cgroup from its ID. A cgroup returned by this
  2107	 * kfunc which is not subsequently stored in a map, must be released by calling
  2108	 * bpf_cgroup_release().
  2109	 * @cgrp: The cgroup for which we're performing a lookup.
  2110	 * @level: The level of ancestor to look up.
  2111	 */
> 2112	__bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
  2113	{
  2114		struct cgroup *cgrp;
  2115	
  2116		cgrp = cgroup_get_from_id(cgid);
  2117		if (IS_ERR(cgrp))
  2118			return NULL;
  2119		return cgrp;
  2120	}
  2121	#endif /* CONFIG_CGROUPS */
  2122	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
