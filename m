Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB4277FF3B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 22:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354985AbjHQUnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 16:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354967AbjHQUnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:43:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5CE30F7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692304982; x=1723840982;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TLdHQAYSQg5ovEpK49pxAPWijCO4Xjx/bhjBKTyYxdk=;
  b=WCH1NfphAR3yBPf01ZVNYi7JQatr1WIAQX5G1wjf3OMzBhbd4bRdwVn+
   ci+ehoNgs2+IqeP5/KR/JCiWHSaL9s0jnA4gE4uqZv9e2EXddZAI7Glgv
   44nazVdgwY3INVPJ1qNiI4+/cxOaMMkIyRlE8nhK3mvsouaDTj9igwec7
   hBk8Pmog/cb//YXpsKtDxvarMKLTYs/lSI0Y8kNoGGCJqt5+zR78lovRS
   jDUAqM85Ch3z/+I6ZHFZqM8plq7jdsJ3wjwaTdXqOHtjpOhvn0UiZztib
   5BcG0N+8sNiiacyVQouKf1Sk86e1dcyzin6+SzlDZdvf9oZsuaGCwrjxq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371826886"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="371826886"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 13:43:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="764260032"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="764260032"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2023 13:42:57 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWjpY-0001Sj-2I;
        Thu, 17 Aug 2023 20:42:56 +0000
Date:   Fri, 18 Aug 2023 04:42:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/helpers.c:1887:33: warning: no previous declaration for
 'bpf_rbtree_remove'
Message-ID: <202308180412.Tw9FNVtq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   16931859a6500d360b90aeacab3b505a3560a3ed
commit: bd1279ae8a691d7ec75852c6d0a22139afb034a4 bpf: Add bpf_rbtree_{add,remove,first} kfuncs
date:   6 months ago
config: x86_64-randconfig-x012-20230816 (https://download.01.org/0day-ci/archive/20230818/202308180412.Tw9FNVtq-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308180412.Tw9FNVtq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308180412.Tw9FNVtq-lkp@intel.com/

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
>> kernel/bpf/helpers.c:1887:33: warning: no previous declaration for 'bpf_rbtree_remove' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
                                    ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1924:18: warning: no previous declaration for 'bpf_rbtree_add' [-Wmissing-declarations]
    __bpf_kfunc void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
                     ^~~~~~~~~~~~~~
>> kernel/bpf/helpers.c:1930:33: warning: no previous declaration for 'bpf_rbtree_first' [-Wmissing-declarations]
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
   kernel/bpf/helpers.c:2112:33: warning: no previous declaration for 'bpf_task_from_pid' [-Wmissing-declarations]
    __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
                                    ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2125:19: warning: no previous declaration for 'bpf_cast_to_kern_ctx' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
                      ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2130:19: warning: no previous declaration for 'bpf_rdonly_cast' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
                      ^~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2135:18: warning: no previous declaration for 'bpf_rcu_read_lock' [-Wmissing-declarations]
    __bpf_kfunc void bpf_rcu_read_lock(void)
                     ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2140:18: warning: no previous declaration for 'bpf_rcu_read_unlock' [-Wmissing-declarations]
    __bpf_kfunc void bpf_rcu_read_unlock(void)
                     ^~~~~~~~~~~~~~~~~~~


vim +/bpf_rbtree_remove +1887 kernel/bpf/helpers.c

  1858	
> 1859	__bpf_kfunc void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node)
  1860	{
  1861		return __bpf_list_add(node, head, true);
  1862	}
  1863	
  1864	static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tail)
  1865	{
  1866		struct list_head *n, *h = (void *)head;
  1867	
  1868		if (unlikely(!h->next))
  1869			INIT_LIST_HEAD(h);
  1870		if (list_empty(h))
  1871			return NULL;
  1872		n = tail ? h->prev : h->next;
  1873		list_del_init(n);
  1874		return (struct bpf_list_node *)n;
  1875	}
  1876	
  1877	__bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
  1878	{
  1879		return __bpf_list_del(head, false);
  1880	}
  1881	
> 1882	__bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
  1883	{
  1884		return __bpf_list_del(head, true);
  1885	}
  1886	
> 1887	__bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
  1888							  struct bpf_rb_node *node)
  1889	{
  1890		struct rb_root_cached *r = (struct rb_root_cached *)root;
  1891		struct rb_node *n = (struct rb_node *)node;
  1892	
  1893		rb_erase_cached(n, r);
  1894		RB_CLEAR_NODE(n);
  1895		return (struct bpf_rb_node *)n;
  1896	}
  1897	
  1898	/* Need to copy rbtree_add_cached's logic here because our 'less' is a BPF
  1899	 * program
  1900	 */
  1901	static void __bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
  1902				     void *less)
  1903	{
  1904		struct rb_node **link = &((struct rb_root_cached *)root)->rb_root.rb_node;
  1905		bpf_callback_t cb = (bpf_callback_t)less;
  1906		struct rb_node *parent = NULL;
  1907		bool leftmost = true;
  1908	
  1909		while (*link) {
  1910			parent = *link;
  1911			if (cb((uintptr_t)node, (uintptr_t)parent, 0, 0, 0)) {
  1912				link = &parent->rb_left;
  1913			} else {
  1914				link = &parent->rb_right;
  1915				leftmost = false;
  1916			}
  1917		}
  1918	
  1919		rb_link_node((struct rb_node *)node, parent, link);
  1920		rb_insert_color_cached((struct rb_node *)node,
  1921				       (struct rb_root_cached *)root, leftmost);
  1922	}
  1923	
  1924	__bpf_kfunc void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
  1925					bool (less)(struct bpf_rb_node *a, const struct bpf_rb_node *b))
  1926	{
  1927		__bpf_rbtree_add(root, node, (void *)less);
  1928	}
  1929	
> 1930	__bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
  1931	{
  1932		struct rb_root_cached *r = (struct rb_root_cached *)root;
  1933	
  1934		return (struct bpf_rb_node *)rb_first_cached(r);
  1935	}
  1936	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
