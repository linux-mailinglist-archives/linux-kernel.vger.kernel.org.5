Return-Path: <linux-kernel+bounces-10978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9FC81DF95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2A11C2183E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB4B1EB34;
	Mon, 25 Dec 2023 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJF0+Of+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABFF179BA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703497931; x=1735033931;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8qe17QdRMGOxCWU+QJIagv0oAbWOr2qmE954N73ToO4=;
  b=AJF0+Of+FKDOzPGAS2/8ij7uSdJ9w9JuV1YMs+rdOrrjyOQiWKqQ2u0+
   iCuVwXYvoea66vpeoIolKlCah08l4sjtkLyIIA8drzeZmxSUx6PTeeSw2
   n803/Sq/q69r1ciE9+OqlYAgh8nbdFqNL3PLkbawbTFMbt8E8c+IvXDvf
   JvyaKVC4tRPEUPn/xCqq9YJb3tNKHZYNSq0/OYsYhzpJ8wZR94iS+24zy
   4L4UqsdEfleM7iXZwLcYbyfEfw/y77tUS5yqfjGJIXPdCELiWAY70G434
   QhHhSz+6WD9um0dIpYuWsqi3wG0yfh567sGYsrnQwdZaDw3QxNhizh1ik
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3112746"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="3112746"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 01:52:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="1024873310"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="1024873310"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 25 Dec 2023 01:52:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHhcz-000DC8-0p;
	Mon, 25 Dec 2023 09:52:05 +0000
Date: Mon, 25 Dec 2023 17:51:48 +0800
From: kernel test robot <lkp@intel.com>
To: Aditi Ghag <aditi.ghag@isovalent.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: WARN: resolve_btfids: unresolved symbol bpf_sock_destroy
Message-ID: <202312251746.AJnSCuzj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: 4ddbcb886268af8d12a23e6640b39d1d9c652b1b bpf: Add bpf_sock_destroy kfunc
date:   7 months ago
config: mips-randconfig-r001-20230703 (https://download.01.org/0day-ci/archive/20231225/202312251746.AJnSCuzj-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231225/202312251746.AJnSCuzj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312251746.AJnSCuzj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   WARN: resolve_btfids: unresolved symbol unix_sock
   WARN: resolve_btfids: unresolved symbol bpf_cpumask
   WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_timestamp
   WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
   WARN: resolve_btfids: unresolved symbol bpf_xdp_ct_lookup
   WARN: resolve_btfids: unresolved symbol bpf_xdp_ct_alloc
   WARN: resolve_btfids: unresolved symbol bpf_task_under_cgroup
   WARN: resolve_btfids: unresolved symbol bpf_task_release
   WARN: resolve_btfids: unresolved symbol bpf_task_from_pid
   WARN: resolve_btfids: unresolved symbol bpf_task_acquire
>> WARN: resolve_btfids: unresolved symbol bpf_sock_destroy
   WARN: resolve_btfids: unresolved symbol bpf_skb_set_fou_encap
   WARN: resolve_btfids: unresolved symbol bpf_skb_get_fou_encap
   WARN: resolve_btfids: unresolved symbol bpf_skb_ct_lookup
   WARN: resolve_btfids: unresolved symbol bpf_skb_ct_alloc
   WARN: resolve_btfids: unresolved symbol bpf_refcount_acquire_impl
   WARN: resolve_btfids: unresolved symbol bpf_rdonly_cast
   WARN: resolve_btfids: unresolved symbol bpf_rcu_read_unlock
   WARN: resolve_btfids: unresolved symbol bpf_rcu_read_lock
   WARN: resolve_btfids: unresolved symbol bpf_rbtree_remove
   WARN: resolve_btfids: unresolved symbol bpf_rbtree_first
   WARN: resolve_btfids: unresolved symbol bpf_rbtree_add_impl
   WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
   WARN: resolve_btfids: unresolved symbol bpf_obj_drop_impl
   WARN: resolve_btfids: unresolved symbol bpf_modify_return_test
   WARN: resolve_btfids: unresolved symbol bpf_list_push_front_impl
   WARN: resolve_btfids: unresolved symbol bpf_list_push_back_impl
   WARN: resolve_btfids: unresolved symbol bpf_list_pop_front
   WARN: resolve_btfids: unresolved symbol bpf_list_pop_back
   WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_release
   WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_memb_release
   WARN: resolve_btfids: unresolved symbol bpf_iter_num_next
   WARN: resolve_btfids: unresolved symbol bpf_iter_num_new
   WARN: resolve_btfids: unresolved symbol bpf_iter_num_destroy
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_slice_rdwr
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_slice
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_size
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_is_rdonly
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_is_null
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_clone
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_adjust
   WARN: resolve_btfids: unresolved symbol bpf_ct_set_timeout
   WARN: resolve_btfids: unresolved symbol bpf_ct_set_status
   WARN: resolve_btfids: unresolved symbol bpf_ct_set_nat_info
   WARN: resolve_btfids: unresolved symbol bpf_ct_release
   WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
   WARN: resolve_btfids: unresolved symbol bpf_ct_change_timeout
   WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
   WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
   WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
   WARN: resolve_btfids: unresolved symbol bpf_cgroup_ancestor
   WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
   WARN: resolve_btfids: unresolved symbol bpf_cast_to_kern_ctx

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

