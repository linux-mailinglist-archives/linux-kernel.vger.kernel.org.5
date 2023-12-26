Return-Path: <linux-kernel+bounces-11328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8592381E4A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 03:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE8BB21B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E625E10793;
	Tue, 26 Dec 2023 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N18fyBxn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE33F4E6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 02:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703558874; x=1735094874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZYF6kebOzV1mB1DRu6/8nFqkUD+BoP5Csob2t3M7eSc=;
  b=N18fyBxnJEfjIz+2WHIs6uK8Yqy/WwwZ7zhSBCn1kWRx1IllltnAeurN
   KSIVFEXPyLbBQh0W6a3Z6/n7SrLTF3+Dq84NHGaP9OJg7IA4/zBZR1KOL
   6zvMdqvL8Eyzv7b86sIn3G25Jnp9Xu280N8+x8PhQC9o0QTV6toffZOGY
   LThbJcF1vEYvE55oM0/9LmMf8O7GJmNO5qiKNM5Appr+iyBz3KuEPo8A3
   zueiG9cWu3sD8Nz+43ktCp6PcmAjbIyZk/NsTpLq9x0Gvm7XOki++2N4e
   kxo6DjNVvmLvemN7iBveKiuA1WlhtdGs3zYVgaFRtlnCdZ5U5gt5JFyL2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="399101120"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="399101120"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:47:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="727633773"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="727633773"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Dec 2023 18:47:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHxTy-000Dtt-1A;
	Tue, 26 Dec 2023 02:47:50 +0000
Date: Tue, 26 Dec 2023 10:47:03 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Anna Schumaker <Anna.Schumaker@netapp.com>
Subject: net/sunrpc/auth.c:725:34: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202312261006.VIxuWJPi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
commit: 5e16923b432bfe79fdfb7cd95ed8e63f6438b663 NFS/SUNRPC: don't lookup machine credential until rpcauth_bindcred().
date:   5 years ago
config: x86_64-randconfig-003-20231011 (https://download.01.org/0day-ci/archive/20231226/202312261006.VIxuWJPi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312261006.VIxuWJPi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312261006.VIxuWJPi-lkp@intel.com/

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

