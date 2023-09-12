Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52B379C1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbjILB20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbjILB2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:28:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBD3194F6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694481184; x=1726017184;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fCMy3r4N1B3+e2GI85Z+5178rGlne1SNJMr8FD9iObA=;
  b=SHQq6F1mCU28lEoxk8hZyHQzLhFRudiD0zu+my3KcaYyD6Esw6O4l2hG
   mjZ05kpLwzwN21L+bfYFwYRTeNGOBfHQ2GGD5LS/8DC8G08aM/WSTM3/R
   UZC9CSiFjioxtieChuFS2dUy6L/iwD143hiafnvwifu4lzRD48AhbqSeN
   P/MwuGEeFHygS2K2E57TNKOb4vUIqKxreQbExJzNVash8AMOnZeIV6vEj
   o7GAW/PuzNftxj8+VIxWfqipRD0rgpFw8SLRcWBQwcTWP0ZzPHRhA6qaP
   tHFTGNXSjkCzJnZvVLH/tE7q8ObMNaAJw5u2Cf+u7PKPrv1Osg5qCdbN5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="377161453"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="377161453"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 17:59:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="833703368"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="833703368"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2023 17:59:04 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfrk5-00070d-2v;
        Tue, 12 Sep 2023 00:59:01 +0000
Date:   Tue, 12 Sep 2023 08:58:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/helpers.c:1920:19: warning: no previous declaration for
 'bpf_refcount_acquire_impl'
Message-ID: <202309120843.Vt687y9F-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 7c50b1cb76aca4540aa917db5f2a302acddcadff bpf: Add bpf_refcount_acquire kfunc
date:   5 months ago
config: x86_64-randconfig-002-20230910 (https://download.01.org/0day-ci/archive/20230912/202309120843.Vt687y9F-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309120843.Vt687y9F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309120843.Vt687y9F-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/helpers.c:1882:19: warning: no previous declaration for 'bpf_obj_new_impl' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
                      ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1912:18: warning: no previous declaration for 'bpf_obj_drop_impl' [-Wmissing-declarations]
    __bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
                     ^~~~~~~~~~~~~~~~~
>> kernel/bpf/helpers.c:1920:19: warning: no previous declaration for 'bpf_refcount_acquire_impl' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1945:18: warning: no previous declaration for 'bpf_list_push_front' [-Wmissing-declarations]
    __bpf_kfunc void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node)
                     ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1950:18: warning: no previous declaration for 'bpf_list_push_back' [-Wmissing-declarations]
    __bpf_kfunc void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node)
                     ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1968:35: warning: no previous declaration for 'bpf_list_pop_front' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
                                      ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1973:35: warning: no previous declaration for 'bpf_list_pop_back' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
                                      ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1978:33: warning: no previous declaration for 'bpf_rbtree_remove' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
                                    ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2015:18: warning: no previous declaration for 'bpf_rbtree_add' [-Wmissing-declarations]
    __bpf_kfunc void bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
                     ^~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2021:33: warning: no previous declaration for 'bpf_rbtree_first' [-Wmissing-declarations]
    __bpf_kfunc struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root)
                                    ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2034:33: warning: no previous declaration for 'bpf_task_acquire' [-Wmissing-declarations]
    __bpf_kfunc struct task_struct *bpf_task_acquire(struct task_struct *p)
                                    ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2045:18: warning: no previous declaration for 'bpf_task_release' [-Wmissing-declarations]
    __bpf_kfunc void bpf_task_release(struct task_struct *p)
                     ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2057:28: warning: no previous declaration for 'bpf_cgroup_acquire' [-Wmissing-declarations]
    __bpf_kfunc struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
                               ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2069:18: warning: no previous declaration for 'bpf_cgroup_release' [-Wmissing-declarations]
    __bpf_kfunc void bpf_cgroup_release(struct cgroup *cgrp)
                     ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2081:28: warning: no previous declaration for 'bpf_cgroup_ancestor' [-Wmissing-declarations]
    __bpf_kfunc struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
                               ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2101:28: warning: no previous declaration for 'bpf_cgroup_from_id' [-Wmissing-declarations]
    __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
                               ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2118:33: warning: no previous declaration for 'bpf_task_from_pid' [-Wmissing-declarations]
    __bpf_kfunc struct task_struct *bpf_task_from_pid(s32 pid)
                                    ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2157:19: warning: no previous declaration for 'bpf_dynptr_slice' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset,
                      ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2234:19: warning: no previous declaration for 'bpf_dynptr_slice_rdwr' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 offset,
                      ^~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2265:19: warning: no previous declaration for 'bpf_cast_to_kern_ctx' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_cast_to_kern_ctx(void *obj)
                      ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2270:19: warning: no previous declaration for 'bpf_rdonly_cast' [-Wmissing-declarations]
    __bpf_kfunc void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
                      ^~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2275:18: warning: no previous declaration for 'bpf_rcu_read_lock' [-Wmissing-declarations]
    __bpf_kfunc void bpf_rcu_read_lock(void)
                     ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:2280:18: warning: no previous declaration for 'bpf_rcu_read_unlock' [-Wmissing-declarations]
    __bpf_kfunc void bpf_rcu_read_unlock(void)
                     ^~~~~~~~~~~~~~~~~~~


vim +/bpf_refcount_acquire_impl +1920 kernel/bpf/helpers.c

  1877	
  1878	__diag_push();
  1879	__diag_ignore_all("-Wmissing-prototypes",
  1880			  "Global functions as their definitions will be in vmlinux BTF");
  1881	
> 1882	__bpf_kfunc void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
  1883	{
  1884		struct btf_struct_meta *meta = meta__ign;
  1885		u64 size = local_type_id__k;
  1886		void *p;
  1887	
  1888		p = bpf_mem_alloc(&bpf_global_ma, size);
  1889		if (!p)
  1890			return NULL;
  1891		if (meta)
  1892			bpf_obj_init(meta->record, p);
  1893		return p;
  1894	}
  1895	
  1896	/* Must be called under migrate_disable(), as required by bpf_mem_free */
  1897	void __bpf_obj_drop_impl(void *p, const struct btf_record *rec)
  1898	{
  1899		if (rec && rec->refcount_off >= 0 &&
  1900		    !refcount_dec_and_test((refcount_t *)(p + rec->refcount_off))) {
  1901			/* Object is refcounted and refcount_dec didn't result in 0
  1902			 * refcount. Return without freeing the object
  1903			 */
  1904			return;
  1905		}
  1906	
  1907		if (rec)
  1908			bpf_obj_free_fields(rec, p);
  1909		bpf_mem_free(&bpf_global_ma, p);
  1910	}
  1911	
  1912	__bpf_kfunc void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
  1913	{
  1914		struct btf_struct_meta *meta = meta__ign;
  1915		void *p = p__alloc;
  1916	
  1917		__bpf_obj_drop_impl(p, meta ? meta->record : NULL);
  1918	}
  1919	
> 1920	__bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta__ign)
  1921	{
  1922		struct btf_struct_meta *meta = meta__ign;
  1923		struct bpf_refcount *ref;
  1924	
  1925		/* Could just cast directly to refcount_t *, but need some code using
  1926		 * bpf_refcount type so that it is emitted in vmlinux BTF
  1927		 */
  1928		ref = (struct bpf_refcount *)p__refcounted_kptr + meta->record->refcount_off;
  1929	
  1930		refcount_inc((refcount_t *)ref);
  1931		return (void *)p__refcounted_kptr;
  1932	}
  1933	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
