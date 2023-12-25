Return-Path: <linux-kernel+bounces-11025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C795A81E032
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1901C21937
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4905103C;
	Mon, 25 Dec 2023 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQCBBETL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E99851028
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703505313; x=1735041313;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XWQ4keVBh9cgWXfKOdckPYZe1qq7Gir5fRY0k1ymAyk=;
  b=XQCBBETLWot5iCQ8Pr0S5wbrAuKKPz3IDmr2ZTjcU6e/ESkQMFSCS0An
   fQO6Co33F3zDIqz2qABKGTjX4PrzY+IlYLqioW3IfazC8q3fifdQxnHAz
   4xLNexz8YEk1qawZeED6i74L/A7pCLDYwrjKxvA98sT/k4TBr9Xgmh6rB
   pfzdvjhuMpOEUNoK8N/C107Tg+kevUcQaAA5rXP/uUDR1bFdXt4kDI+qx
   ytVG26pZiMZKzHsB/g1PRBB0V1PdgFaX8a/aWLOrmJPUBSSZRw+fk8R5Z
   sooNaZMLDc+uo0FWV2mnJFIHLgLXlvel+hzVzM9u/D2614px6V5NREpWv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="482459916"
X-IronPort-AV: E=Sophos;i="6.04,303,1695711600"; 
   d="scan'208";a="482459916"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 03:55:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,303,1695711600"; 
   d="scan'208";a="12186495"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 25 Dec 2023 03:55:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHjY5-000DH7-0r;
	Mon, 25 Dec 2023 11:55:09 +0000
Date: Mon, 25 Dec 2023 19:54:09 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Anna Schumaker <Anna.Schumaker@netapp.com>
Subject: net/sunrpc/auth.c:725:34: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202312251922.sGIFj35A-lkp@intel.com>
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
commit: 5e16923b432bfe79fdfb7cd95ed8e63f6438b663 NFS/SUNRPC: don't lookup machine credential until rpcauth_bindcred().
date:   5 years ago
config: x86_64-randconfig-x001-20230717 (https://download.01.org/0day-ci/archive/20231225/202312251922.sGIFj35A-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231225/202312251922.sGIFj35A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312251922.sGIFj35A-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/sunrpc/auth.c:725:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct cred const *cred @@     got struct cred const [noderef] __rcu *extern [addressable] [toplevel] cred @@
   net/sunrpc/auth.c:725:34: sparse:     expected struct cred const *cred
   net/sunrpc/auth.c:725:34: sparse:     got struct cred const [noderef] __rcu *extern [addressable] [toplevel] cred
   net/sunrpc/auth.c: note: in included file:
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y
   include/linux/slab.h:332:43: sparse: sparse: dubious: x & !y

vim +725 net/sunrpc/auth.c

   718	
   719	static struct rpc_cred *
   720	rpcauth_bind_machine_cred(struct rpc_task *task, int lookupflags)
   721	{
   722		struct rpc_auth *auth = task->tk_client->cl_auth;
   723		struct auth_cred acred = {
   724			.principal = task->tk_client->cl_principal,
 > 725			.cred = init_task.cred,
   726		};
   727	
   728		if (!acred.principal)
   729			return NULL;
   730		dprintk("RPC: %5u looking up %s machine cred\n",
   731			task->tk_pid, task->tk_client->cl_auth->au_ops->au_name);
   732		return auth->au_ops->lookup_cred(auth, &acred, lookupflags);
   733	}
   734	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

