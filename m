Return-Path: <linux-kernel+bounces-10870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20CF81DDA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 03:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3CF2813C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 02:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EF8A51;
	Mon, 25 Dec 2023 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gu915Kgi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E457805
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703472544; x=1735008544;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XvAvnMtEeu8/4YXReexVsLTnVFqbZ2J/iPfLSByHwQU=;
  b=gu915KgiiyjtP8Q9Ov5LMGXtvh5sDRzb0sAEVP5IRUCtBp3Pc7qvV6OE
   Xii15OOH0qZzCbOOQPmb79Cj9JvOXVhxiM8ft0bzHUqwnAcrffylRzDj7
   A/dDl0co/W8W4DnkxjHgvvQ8crHd/W3wSjEpG05pc1ze7xjgWw5C4+mYa
   KL77FcGrs5xX9PjAMapzxf0fRfAFpMVhsQclgrjlK9At0uEm6B1BkMHm6
   GUJLhItq50hETZxj6pKik7QeFgWqMbh/D7CnBIY8Vpi/RLKVXDf89Ynap
   /KzR76BY9eE7pdUFmZVdJ+G5ILS7BgS/B57PmsYaZ5HPkf6SzrISpR1DR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="381242190"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="381242190"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 18:49:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="901090737"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="901090737"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 24 Dec 2023 18:49:01 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHb1X-000CrL-33;
	Mon, 25 Dec 2023 02:49:00 +0000
Date: Mon, 25 Dec 2023 10:46:06 +0800
From: kernel test robot <lkp@intel.com>
To: Ralph Campbell <rcampbell@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ben Skeggs <bskeggs@redhat.com>
Subject: drivers/gpu/drm/nouveau/nouveau_svm.c:829:13: warning: variable
 'ret' set but not used
Message-ID: <202312251018.JVE0C0kT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ralph,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: e3d8b08904694e9ccae5163d0bb7d35fa66e5bdc drm/nouveau/svm: map pages after migration
date:   3 years, 7 months ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231225/202312251018.JVE0C0kT-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231225/202312251018.JVE0C0kT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312251018.JVE0C0kT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/nouveau/nouveau_svm.c: In function 'nouveau_pfns_map':
>> drivers/gpu/drm/nouveau/nouveau_svm.c:829:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     829 |         int ret;
         |             ^~~


vim +/ret +829 drivers/gpu/drm/nouveau/nouveau_svm.c

   823	
   824	void
   825	nouveau_pfns_map(struct nouveau_svmm *svmm, struct mm_struct *mm,
   826			 unsigned long addr, u64 *pfns, unsigned long npages)
   827	{
   828		struct nouveau_pfnmap_args *args = nouveau_pfns_to_args(pfns);
 > 829		int ret;
   830	
   831		args->p.addr = addr;
   832		args->p.size = npages << PAGE_SHIFT;
   833	
   834		mutex_lock(&svmm->mutex);
   835	
   836		svmm->vmm->vmm.object.client->super = true;
   837		ret = nvif_object_ioctl(&svmm->vmm->vmm.object, args, sizeof(*args) +
   838					npages * sizeof(args->p.phys[0]), NULL);
   839		svmm->vmm->vmm.object.client->super = false;
   840	
   841		mutex_unlock(&svmm->mutex);
   842	}
   843	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

