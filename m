Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F61F79C445
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbjILDjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbjILDjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:39:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E44CA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 20:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694489956; x=1726025956;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tlwQYAwjaAqORhilkHpfLu4gmZvmbrwEoNwxGZImP9s=;
  b=UyqGBR1v8xsuVXDYR7b4ZBalp2h5ZOTS8Jl2RuvEJxdx3ALx6+XQ5tE4
   r2RBQ+rj6d18JzWUsEMbYTrc3SXgo4ZoU3XHsnP2YTJX//jdZ5dZQnrfd
   KZWXdlwRPW+N9FuixPanI/kYlH4yYG3ms/yOAymILK+XJnifuBuMpXDRf
   Ba7HdKGgK/uNWxU64s+7k56biTmiqHqoKEHXmUE/0X4osSIsRT0koryOH
   b4ASV5jt0OGpF5G/uiJ14oOsEmHcF3zrF9jl08l96Aj99f2U6uPmhAApA
   5r/NAnS3BtmYiOADkfF6q1TRBxs2YrIDriS6Sj20sI01EFIw2LEA9518J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="377182553"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="377182553"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 20:39:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="833743281"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="833743281"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2023 20:39:14 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfuF6-0007Fc-1w;
        Tue, 12 Sep 2023 03:39:12 +0000
Date:   Tue, 12 Sep 2023 11:38:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/helpers.c:1954:17: warning: no previous declaration for
 'bpf_list_push_front_impl'
Message-ID: <202309121112.nDSyrFtd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: d2dcc67df910dd85253a701b6a5b747f955d28f5 bpf: Migrate bpf_rbtree_add and bpf_list_push_{front,back} to possibly fail
date:   5 months ago
config: x86_64-randconfig-002-20230910 (https://download.01.org/0day-ci/archive/20230912/202309121112.nDSyrFtd-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309121112.nDSyrFtd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309121112.nDSyrFtd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/helpers.c:1882:19: warning: no previous declaration for 'bpf_obj_new_impl' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
                      ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1912:18: warning: no previous declaration for 'bpf_obj_drop_impl' [-Wmissing-declarations]
    __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
                     ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1920:19: warning: no previous declaration for 'bpf_refcount_acquire_impl' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/helpers.c:1954:17: warning: no previous declaration for 'bpf_list_push_front_impl' [-Wmissing-declarations]
    __bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
                    ^~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/bpf/helpers.c:1964:17: warning: no previous declaration for 'bpf_list_push_back_impl' [-Wmissing-declarations]
    __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
                    ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1987:35: warning: no previous declaration for 'bpf_list_pop_front' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
                                      ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1992:35: warning: no previous declaration for 'bpf_list_pop_back' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
                                      ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1997:33: warning: no previous declaration for 'bpf_rbtree_remove' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
                                    ^~~~~~~~~~~~~~~~~
>> kernel/bpf/helpers.c:2043:17: warning: no previous declaration for 'bpf_rbtree_add_impl' [-Wmissing-declarations]
    __bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
                    ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2052:33: warning: no previous declaration for 'bpf_rbtree_first' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
                                    ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2065:33: warning: no previous declaration for 'bpf_task_acquire' [-Wmissing-declarations]
    __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
                                    ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2076:18: warning: no previous declaration for 'bpf_task_release' [-Wmissing-declarations]
    __bpf_kfunc void bpf_task_release(struct task_struct *p)
                     ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2088:28: warning: no previous declaration for 'bpf_cgroup_acquire' [-Wmissing-declarations]
    __bpf_kfunc struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
                               ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2100:18: warning: no previous declaration for 'bpf_cgroup_release' [-Wmissing-declarations]
    __bpf_kfunc void bpf_cgroup_release(struct cgroup *cgrp)
                     ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2112:28: warning: no previous declaration for 'bpf_cgroup_ancestor' [-Wmissing-declarations]
    __bpf_kfunc struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
                               ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2132:28: warning: no previous declaration for 'bpf_cgroup_from_id' [-Wmissing-declarations]
    __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
                               ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2149:33: warning: no previous declaration for 'bpf_task_from_pid' [-Wmissing-declarations]
    __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
                                    ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2188:19: warning: no previous declaration for 'bpf_dynptr_slice' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
                      ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2265:19: warning: no previous declaration for 'bpf_dynptr_slice_rdwr' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
                      ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2296:19: warning: no previous declaration for 'bpf_cast_to_kern_ctx' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
                      ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2301:19: warning: no previous declaration for 'bpf_rdonly_cast' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
                      ^~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2306:18: warning: no previous declaration for 'bpf_rcu_read_lock' [-Wmissing-declarations]
    __bpf_kfunc void bpf_rcu_read_lock(void)
                     ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2311:18: warning: no previous declaration for 'bpf_rcu_read_unlock' [-Wmissing-declarations]
    __bpf_kfunc void bpf_rcu_read_unlock(void)
                     ^~~~~~~~~~~~~~~~~~~


vim +/bpf_list_push_front_impl +1954 kernel/bpf/helpers.c

  1953	
> 1954	__bpf_kfunc int bpf_list_push_front_impl(struct bpf_list_head *head,
  1955						 struct bpf_list_node *node,
  1956						 void *meta__ign, u64 off)
  1957	{
  1958		struct btf_struct_meta *meta = meta__ign;
  1959	
  1960		return __bpf_list_add(node, head, false,
  1961				      meta ? meta->record : NULL, off);
  1962	}
  1963	
> 1964	__bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
  1965						struct bpf_list_node *node,
  1966						void *meta__ign, u64 off)
  1967	{
  1968		struct btf_struct_meta *meta = meta__ign;
  1969	
  1970		return __bpf_list_add(node, head, true,
  1971				      meta ? meta->record : NULL, off);
  1972	}
  1973	
  1974	static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tail)
  1975	{
  1976		struct list_head *n, *h = (void *)head;
  1977	
  1978		if (unlikely(!h->next))
  1979			INIT_LIST_HEAD(h);
  1980		if (list_empty(h))
  1981			return NULL;
  1982		n = tail ? h->prev : h->next;
  1983		list_del_init(n);
  1984		return (struct bpf_list_node *)n;
  1985	}
  1986	
  1987	__bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
  1988	{
  1989		return __bpf_list_del(head, false);
  1990	}
  1991	
  1992	__bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
  1993	{
  1994		return __bpf_list_del(head, true);
  1995	}
  1996	
  1997	__bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
  1998							  struct bpf_rb_node *node)
  1999	{
  2000		struct rb_root_cached *r = (struct rb_root_cached *)root;
  2001		struct rb_node *n = (struct rb_node *)node;
  2002	
  2003		rb_erase_cached(n, r);
  2004		RB_CLEAR_NODE(n);
  2005		return (struct bpf_rb_node *)n;
  2006	}
  2007	
  2008	/* Need to copy rbtree_add_cached's logic here because our 'less' is a BPF
  2009	 * program
  2010	 */
  2011	static int __bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
  2012				    void *less, struct btf_record *rec, u64 off)
  2013	{
  2014		struct rb_node **link = &((struct rb_root_cached *)root)->rb_root.rb_node;
  2015		struct rb_node *parent = NULL, *n = (struct rb_node *)node;
  2016		bpf_callback_t cb = (bpf_callback_t)less;
  2017		bool leftmost = true;
  2018	
  2019		if (!n->__rb_parent_color)
  2020			RB_CLEAR_NODE(n);
  2021	
  2022		if (!RB_EMPTY_NODE(n)) {
  2023			/* Only called from BPF prog, no need to migrate_disable */
  2024			__bpf_obj_drop_impl(n - off, rec);
  2025			return -EINVAL;
  2026		}
  2027	
  2028		while (*link) {
  2029			parent = *link;
  2030			if (cb((uintptr_t)node, (uintptr_t)parent, 0, 0, 0)) {
  2031				link = &parent->rb_left;
  2032			} else {
  2033				link = &parent->rb_right;
  2034				leftmost = false;
  2035			}
  2036		}
  2037	
  2038		rb_link_node(n, parent, link);
  2039		rb_insert_color_cached(n, (struct rb_root_cached *)root, leftmost);
  2040		return 0;
  2041	}
  2042	
> 2043	__bpf_kfunc int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *node,
  2044					    bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b),
  2045					    void *meta__ign, u64 off)
  2046	{
  2047		struct btf_struct_meta *meta = meta__ign;
  2048	
  2049		return __bpf_rbtree_add(root, node, (void *)less, meta ? meta->record : NULL, off);
  2050	}
  2051	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
