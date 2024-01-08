Return-Path: <linux-kernel+bounces-20194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6987B827BB3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ACC6B22F2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF7B56764;
	Mon,  8 Jan 2024 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OohADDPi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891856473
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704757644; x=1736293644;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cS0e90lxe9GfuGeMm7Jn5Bpl0k9OHSzEn6lS/X9gOzk=;
  b=OohADDPiMrCgsxn+r9B8dVMPUpIzMQdQTxu/1j4NXKF1D84aOnFFve+d
   YifjNiTPWfoIhzBFLtdSoNhjavZsfAnAS62sv+ovASswv8Ep7PnKrjEnV
   lMqCDW9AVsvBdgljalEjsDmGniL+nX7+YLXXKZlFY3VckhCa1M22C2DSf
   HnTXXIDn4AYWfiksEvyqHUv8LazDMuPYoQ3blSWjmfvhMHrn5TwRIOu47
   mJwOBMaM/1EoyiOOSaSgjfGDmAsCdJ7pgHVLJDAFk7eWXbRB4PwzZBGYf
   bOG7st4HoHitvaQ6mYa7JqdpSnonV34fnXu09F1Y/k4AkfoA+iQtCN9fO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11520960"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="11520960"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 15:47:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="785014923"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="785014923"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jan 2024 15:47:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMzKu-0005ES-1q;
	Mon, 08 Jan 2024 23:47:16 +0000
Date: Tue, 9 Jan 2024 07:47:00 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/file.c:947:31: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202401090732.whbm84HZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5db8752c3b81bd33a549f6f812bab81e3bb61b20
commit: 61d4fb0b349ec1b33119913c3b0bd109de30142c file, i915: fix file reference for mmap_singleton()
date:   3 months ago
config: x86_64-randconfig-123-20240106 (https://download.01.org/0day-ci/archive/20240109/202401090732.whbm84HZ-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401090732.whbm84HZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401090732.whbm84HZ-lkp@intel.com/

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
   fs/file.c:649:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:844:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *file @@     got struct file [noderef] __rcu * @@
   fs/file.c:865:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file [noderef] __rcu *file @@     got struct file * @@
   fs/file.c:869:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic64_t [usertype] *v @@     got struct atomic64_t [noderef] __rcu * @@
   fs/file.c:872:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file [noderef] __rcu *file_reloaded @@     got struct file * @@
   fs/file.c:895:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct file * @@     got struct file [noderef] __rcu *file_reloaded @@
   fs/file.c:897:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct file * @@     got struct file [noderef] __rcu *file @@
   fs/file.c:918:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file [noderef] __rcu *file @@     got struct file * @@
   fs/file.c:925:24: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct file * @@     got struct file [noderef] __rcu *file @@
>> fs/file.c:947:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct file [noderef] __rcu **f @@     got struct file **f @@
   fs/file.c:947:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file [noderef] __rcu *file @@     got struct file * @@
>> fs/file.c:951:16: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected struct file * @@     got struct file [noderef] __rcu *[assigned] file @@
   fs/file.c:1240:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct file *tofree @@     got struct file [noderef] __rcu * @@

vim +947 fs/file.c

   929	
   930	/**
   931	 * get_file_active - try go get a reference to a file
   932	 * @f: the file to get a reference on
   933	 *
   934	 * In contast to get_file_rcu() the pointer itself isn't part of the
   935	 * reference counting.
   936	 *
   937	 * This function should rarely have to be used and only by users who
   938	 * understand the implications of SLAB_TYPESAFE_BY_RCU. Try to avoid it.
   939	 *
   940	 * Return: Returns @f with the reference count increased or NULL.
   941	 */
   942	struct file *get_file_active(struct file **f)
   943	{
   944		struct file __rcu *file;
   945	
   946		rcu_read_lock();
 > 947		file = __get_file_rcu(f);
   948		rcu_read_unlock();
   949		if (IS_ERR(file))
   950			file = NULL;
 > 951		return file;
   952	}
   953	EXPORT_SYMBOL_GPL(get_file_active);
   954	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

