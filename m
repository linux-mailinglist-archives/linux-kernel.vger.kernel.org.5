Return-Path: <linux-kernel+bounces-18773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8768262D5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 04:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3041FB21BCF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 03:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD4B111A6;
	Sun,  7 Jan 2024 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ia09NX8M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD801118E
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 03:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704598569; x=1736134569;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HRqD2lUnlcGevVzzfpPV9tFg2taamwhKHEr3ONqxqlw=;
  b=ia09NX8M6HvSCOMnjwVBIZDyvX9IobtZZzgiqcDPMf8KEDlYro/spO6Z
   ueMzmGMlXBtTMx7LXWql41s8hziLGkcPVg6J3RQi8YiPoNllEfCo5nRKX
   MR8lBCprXQm6nHFVcuh8RXy/vBumkSx/Hq86lhyp2StcTIrBJEvg35uRB
   Cp/nM8pZrFjxMMFJ/25FaDDaNFJoKuIrNbIN4NP2jgLvKueUy/E2XWvkU
   loWWW3Ug28Hxv+llxv2p6v9qXklQjbRrSEoqvAXopwYTXXurd8VJSoeyu
   rosPC5NB8ZwGWzZpvrYL+euBJnCkfbIaNvBeih4mzC90Ch5dH5g4bzzRx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="382667348"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="382667348"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 19:35:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="851471212"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="851471212"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2024 19:35:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMJwv-0003KS-0X;
	Sun, 07 Jan 2024 03:35:45 +0000
Date: Sun, 7 Jan 2024 11:34:53 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/file.c:862:14: sparse: sparse: incorrect type in assignment
 (different address spaces)
Message-ID: <202401071109.RJ9OQWsn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: 0ede61d8589cc2d93aa78230d74ac58b5b8d0244 file: convert to SLAB_TYPESAFE_BY_RCU
date:   3 months ago
config: x86_64-randconfig-123-20240106 (https://download.01.org/0day-ci/archive/20240107/202401071109.RJ9OQWsn-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401071109.RJ9OQWsn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401071109.RJ9OQWsn-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/file.c:379:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **old_fds @@     got struct file [noderef] __rcu **fd @@
   fs/file.c:379:17: sparse:     expected struct file **old_fds
   fs/file.c:379:17: sparse:     got struct file [noderef] __rcu **fd
   fs/file.c:380:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file **new_fds @@     got struct file [noderef] __rcu **fd @@
   fs/file.c:380:17: sparse:     expected struct file **new_fds
   fs/file.c:380:17: sparse:     got struct file [noderef] __rcu **fd
   fs/file.c:395:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/file.c:395:17: sparse:    struct file [noderef] __rcu *
   fs/file.c:395:17: sparse:    struct file *
   fs/file.c:430:54: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu *[assigned] __ret @@
   fs/file.c:470:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fdtable [noderef] __rcu *fdt @@     got struct fdtable * @@
   fs/file.c:646:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:841:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
>> fs/file.c:862:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file [noderef] __rcu *file @@     got struct file * @@
>> fs/file.c:866:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic64_t [usertype] *v @@     got struct atomic64_t [noderef] __rcu * @@
>> fs/file.c:869:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file [noderef] __rcu *file_reloaded @@     got struct file * @@
>> fs/file.c:892:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct file * @@     got struct file [noderef] __rcu *file_reloaded @@
>> fs/file.c:894:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct file * @@     got struct file [noderef] __rcu *file @@
   fs/file.c:915:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file [noderef] __rcu *file @@     got struct file * @@
>> fs/file.c:922:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct file * @@     got struct file [noderef] __rcu *file @@
   fs/file.c:1212:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *tofree @@     got struct file [noderef] __rcu * @@

vim +862 fs/file.c

   855	
   856	static struct file *__get_file_rcu(struct file __rcu **f)
   857	{
   858		struct file __rcu *file;
   859		struct file __rcu *file_reloaded;
   860		struct file __rcu *file_reloaded_cmp;
   861	
 > 862		file = rcu_dereference_raw(*f);
   863		if (!file)
   864			return NULL;
   865	
 > 866		if (unlikely(!atomic_long_inc_not_zero(&file->f_count)))
   867			return ERR_PTR(-EAGAIN);
   868	
 > 869		file_reloaded = rcu_dereference_raw(*f);
   870	
   871		/*
   872		 * Ensure that all accesses have a dependency on the load from
   873		 * rcu_dereference_raw() above so we get correct ordering
   874		 * between reuse/allocation and the pointer check below.
   875		 */
   876		file_reloaded_cmp = file_reloaded;
   877		OPTIMIZER_HIDE_VAR(file_reloaded_cmp);
   878	
   879		/*
   880		 * atomic_long_inc_not_zero() above provided a full memory
   881		 * barrier when we acquired a reference.
   882		 *
   883		 * This is paired with the write barrier from assigning to the
   884		 * __rcu protected file pointer so that if that pointer still
   885		 * matches the current file, we know we have successfully
   886		 * acquired a reference to the right file.
   887		 *
   888		 * If the pointers don't match the file has been reallocated by
   889		 * SLAB_TYPESAFE_BY_RCU.
   890		 */
   891		if (file == file_reloaded_cmp)
 > 892			return file_reloaded;
   893	
 > 894		fput(file);
   895		return ERR_PTR(-EAGAIN);
   896	}
   897	
   898	/**
   899	 * get_file_rcu - try go get a reference to a file under rcu
   900	 * @f: the file to get a reference on
   901	 *
   902	 * This function tries to get a reference on @f carefully verifying that
   903	 * @f hasn't been reused.
   904	 *
   905	 * This function should rarely have to be used and only by users who
   906	 * understand the implications of SLAB_TYPESAFE_BY_RCU. Try to avoid it.
   907	 *
   908	 * Return: Returns @f with the reference count increased or NULL.
   909	 */
   910	struct file *get_file_rcu(struct file __rcu **f)
   911	{
   912		for (;;) {
   913			struct file __rcu *file;
   914	
   915			file = __get_file_rcu(f);
   916			if (unlikely(!file))
   917				return NULL;
   918	
   919			if (unlikely(IS_ERR(file)))
   920				continue;
   921	
 > 922			return file;
   923		}
   924	}
   925	EXPORT_SYMBOL_GPL(get_file_rcu);
   926	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

