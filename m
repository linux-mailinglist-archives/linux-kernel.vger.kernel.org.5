Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04377FD2D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354064AbjHQRoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbjHQRnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:43:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D370430F1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692294217; x=1723830217;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JvCAfXEIHvjOtrojd/0S1iPX39C9Pu3GuAJ0GCS1BM8=;
  b=ghgx4H8DbFZF6zxUKjxBtGp/RU5BeqqJ+h9UaDUFFCTJYnt6WG6tbaF1
   9EEykW/KRBFgt3sCwNtfSFZO8E3wqdcfwEhj8lmru/GLO4D+39JKSiNcT
   qFgl1np14NqN5Rc8aIl+jvR41++BJcY9JtGg+I5isWeBJ79JXiJpHzW5Y
   6uClexL9dks+j9DNjD8VTzh+f6qFTRDlqN1e02QXobGP09hKwSZwuOEJA
   HUZIvNvbzTvb5XEHSNEIEHtEPb8YIiee1RYmanC3t6LwoiwHOpIhpeVaY
   mYJJpZ62IoMLf0Rh1e9It7WwO62MzD1fB/bI9nZGkLX5Pb5caLc4PYT3j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="439264534"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="439264534"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 10:43:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="764196689"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="764196689"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2023 10:43:35 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWh1z-0001M3-0j;
        Thu, 17 Aug 2023 17:43:35 +0000
Date:   Fri, 18 Aug 2023 01:43:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/bpf/helpers.c:1993:6: warning: no previous declaration for
 'bpf_rcu_read_lock'
Message-ID: <202308180156.XOZHWYw5-lkp@intel.com>
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
commit: 9bb00b2895cbfe0ad410457b605d0a72524168c1 bpf: Add kfunc bpf_rcu_read_lock/unlock()
date:   9 months ago
config: x86_64-randconfig-x012-20230816 (https://download.01.org/0day-ci/archive/20230818/202308180156.XOZHWYw5-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230818/202308180156.XOZHWYw5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308180156.XOZHWYw5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/helpers.c:1760:7: warning: no previous declaration for 'bpf_obj_new_impl' [-Wmissing-declarations]
    void *bpf_obj_new_impl(u64 local_type_id__k, void *meta__ign)
          ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1774:6: warning: no previous declaration for 'bpf_obj_drop_impl' [-Wmissing-declarations]
    void bpf_obj_drop_impl(void *p__alloc, void *meta__ign)
         ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1795:6: warning: no previous declaration for 'bpf_list_push_front' [-Wmissing-declarations]
    void bpf_list_push_front(struct bpf_list_head *head, struct bpf_list_node *node)
         ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1800:6: warning: no previous declaration for 'bpf_list_push_back' [-Wmissing-declarations]
    void bpf_list_push_back(struct bpf_list_head *head, struct bpf_list_node *node)
         ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1818:23: warning: no previous declaration for 'bpf_list_pop_front' [-Wmissing-declarations]
    struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
                          ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1823:23: warning: no previous declaration for 'bpf_list_pop_back' [-Wmissing-declarations]
    struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
                          ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1834:21: warning: no previous declaration for 'bpf_task_acquire' [-Wmissing-declarations]
    struct task_struct *bpf_task_acquire(struct task_struct *p)
                        ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1846:21: warning: no previous declaration for 'bpf_task_kptr_get' [-Wmissing-declarations]
    struct task_struct *bpf_task_kptr_get(struct task_struct **pp)
                        ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1877:6: warning: no previous declaration for 'bpf_task_release' [-Wmissing-declarations]
    void bpf_task_release(struct task_struct *p)
         ^~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1892:16: warning: no previous declaration for 'bpf_cgroup_acquire' [-Wmissing-declarations]
    struct cgroup *bpf_cgroup_acquire(struct cgroup *cgrp)
                   ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1904:16: warning: no previous declaration for 'bpf_cgroup_kptr_get' [-Wmissing-declarations]
    struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
                   ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1936:6: warning: no previous declaration for 'bpf_cgroup_release' [-Wmissing-declarations]
    void bpf_cgroup_release(struct cgroup *cgrp)
         ^~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1951:16: warning: no previous declaration for 'bpf_cgroup_ancestor' [-Wmissing-declarations]
    struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
                   ^~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1970:21: warning: no previous declaration for 'bpf_task_from_pid' [-Wmissing-declarations]
    struct task_struct *bpf_task_from_pid(s32 pid)
                        ^~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1983:7: warning: no previous declaration for 'bpf_cast_to_kern_ctx' [-Wmissing-declarations]
    void *bpf_cast_to_kern_ctx(void *obj)
          ^~~~~~~~~~~~~~~~~~~~
   kernel/bpf/helpers.c:1988:7: warning: no previous declaration for 'bpf_rdonly_cast' [-Wmissing-declarations]
    void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
          ^~~~~~~~~~~~~~~
>> kernel/bpf/helpers.c:1993:6: warning: no previous declaration for 'bpf_rcu_read_lock' [-Wmissing-declarations]
    void bpf_rcu_read_lock(void)
         ^~~~~~~~~~~~~~~~~
>> kernel/bpf/helpers.c:1998:6: warning: no previous declaration for 'bpf_rcu_read_unlock' [-Wmissing-declarations]
    void bpf_rcu_read_unlock(void)
         ^~~~~~~~~~~~~~~~~~~


vim +/bpf_rcu_read_lock +1993 kernel/bpf/helpers.c

  1963	
  1964	/**
  1965	 * bpf_task_from_pid - Find a struct task_struct from its pid by looking it up
  1966	 * in the root pid namespace idr. If a task is returned, it must either be
  1967	 * stored in a map, or released with bpf_task_release().
  1968	 * @pid: The pid of the task being looked up.
  1969	 */
> 1970	struct task_struct *bpf_task_from_pid(s32 pid)
  1971	{
  1972		struct task_struct *p;
  1973	
  1974		rcu_read_lock();
  1975		p = find_task_by_pid_ns(pid, &init_pid_ns);
  1976		if (p)
  1977			bpf_task_acquire(p);
  1978		rcu_read_unlock();
  1979	
  1980		return p;
  1981	}
  1982	
> 1983	void *bpf_cast_to_kern_ctx(void *obj)
  1984	{
  1985		return obj;
  1986	}
  1987	
  1988	void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k)
  1989	{
  1990		return obj__ign;
  1991	}
  1992	
> 1993	void bpf_rcu_read_lock(void)
  1994	{
  1995		rcu_read_lock();
  1996	}
  1997	
> 1998	void bpf_rcu_read_unlock(void)
  1999	{
  2000		rcu_read_unlock();
  2001	}
  2002	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
