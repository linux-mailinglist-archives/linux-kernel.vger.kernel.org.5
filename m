Return-Path: <linux-kernel+bounces-10709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCDD81DAB2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 13:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F4E282AE6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88AE2592;
	Sun, 24 Dec 2023 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyZ78nIc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB153A2
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703420402; x=1734956402;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WXBRlNPTrG13TK05l0M1K+Aa5vYI0a9DUZ6gojT3Bng=;
  b=NyZ78nIc/MBNYa0M6Pz92+lQwF+Pcf4TRoENa0l37JHGz/cVDPLZuRO0
   sQs3uk0dAUB2d9kx08xnRPNMzqffUygniGqa2LB+40WgFDzg4BvDdWZ7W
   pk3EGyBg+Dp0CaWSLvaQxSG2BQQK+NSAyuVwTa8P4i4djKvvhS9CW3h/2
   +YV2XcL3Z1jnj5L+bqvm0rtKArFRY/Fz/aT77zF+O0xddKTbKYK5MHenv
   t6FixGZZ2/MQSTSPOMc8vqcyDTujNgXwEzFITkZydZTxE69xMIqz+8iQg
   jdqt9FrYgzPOxrgtQ4G2gMHZeqzuOC0EMMWWlsUouqrPG94HORr9JAMNF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="399016238"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="399016238"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 04:20:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="921136581"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="921136581"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 24 Dec 2023 04:20:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHNSF-000CEl-0g;
	Sun, 24 Dec 2023 12:19:53 +0000
Date: Sun, 24 Dec 2023 20:18:16 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: WARN: resolve_btfids: unresolved symbol bpf_dynptr_adjust
Message-ID: <202312242048.UIDTfHDC-lkp@intel.com>
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
commit: 987d0242d189661f78b77cc4d77f843b15600fed bpf: Add bpf_dynptr_adjust
date:   8 months ago
config: powerpc-randconfig-r002-20220613 (https://download.01.org/0day-ci/archive/20231224/202312242048.UIDTfHDC-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312242048.UIDTfHDC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312242048.UIDTfHDC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   WARN: resolve_btfids: unresolved symbol prog_test_ref_kfunc
   WARN: resolve_btfids: unresolved symbol bpf_cpumask
   WARN: resolve_btfids: unresolved symbol bpf_task_release
   WARN: resolve_btfids: unresolved symbol bpf_task_from_pid
   WARN: resolve_btfids: unresolved symbol bpf_task_acquire
   WARN: resolve_btfids: unresolved symbol bpf_refcount_acquire_impl
   WARN: resolve_btfids: unresolved symbol bpf_rdonly_cast
   WARN: resolve_btfids: unresolved symbol bpf_rcu_read_unlock
   WARN: resolve_btfids: unresolved symbol bpf_rcu_read_lock
   WARN: resolve_btfids: unresolved symbol bpf_rbtree_remove
   WARN: resolve_btfids: unresolved symbol bpf_rbtree_first
   WARN: resolve_btfids: unresolved symbol bpf_rbtree_add_impl
   WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
   WARN: resolve_btfids: unresolved symbol bpf_obj_drop_impl
   WARN: resolve_btfids: unresolved symbol bpf_list_push_front_impl
   WARN: resolve_btfids: unresolved symbol bpf_list_push_back_impl
   WARN: resolve_btfids: unresolved symbol bpf_list_pop_front
   WARN: resolve_btfids: unresolved symbol bpf_list_pop_back
   WARN: resolve_btfids: unresolved symbol bpf_iter_num_next
   WARN: resolve_btfids: unresolved symbol bpf_iter_num_new
   WARN: resolve_btfids: unresolved symbol bpf_iter_num_destroy
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_slice_rdwr
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_slice
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
   WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb
>> WARN: resolve_btfids: unresolved symbol bpf_dynptr_adjust
   WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
   WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
   WARN: resolve_btfids: unresolved symbol bpf_cgroup_ancestor
   WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
   WARN: resolve_btfids: unresolved symbol bpf_cast_to_kern_ctx

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

