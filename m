Return-Path: <linux-kernel+bounces-25285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6969282CCB4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 13:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D741C21756
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFE021108;
	Sat, 13 Jan 2024 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="euTGOcpa"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68AA18E03
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705149343; x=1736685343;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=usKIZbizhgqVoWIwBsn59W/HWPvosNw1FQOK/lfJ4jA=;
  b=euTGOcpa7hQSkfrQekwGMRhLWs0O3Z7GLBz/AJr/Ki5YW+BMw5VHj9v4
   UOk8rOzZRuvEP7pHkk9VCWiyzwiSk/Lpi9BKQl/5zHZceSBfr6WKQ3ob2
   4lhVcD0R0Aade46clNCVIOPxEvIp6cv+fs8Ysk9ppyMr6cqWc7S7gHnv/
   cIaKDD+GTlENvHVRiM1aJ1BXt2k2ZPGIumftTTVt9wXg4fqztxtk1cs/W
   DwDirwRDfTwjdehaSr1jjbEL7awUl3syUJNp90miDcDEZ/jVKnxguCAGB
   ETJfwO/g/FMgJtxK20NSGDue1zPtTEhdPptBns2LF53XsuZx+zlt58G6V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="465758215"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="465758215"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 04:35:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="817362831"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="817362831"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2024 04:35:41 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOdEg-000ATM-30;
	Sat, 13 Jan 2024 12:35:38 +0000
Date: Sat, 13 Jan 2024 20:35:04 +0800
From: kernel test robot <lkp@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: mm/slub.c:1946:34: error: unused function 'memcg_from_slab_obj'
Message-ID: <202401132054.I2L6evrk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   052d534373b7ed33712a63d5e17b2b6cdbce84fd
commit: 0bedcc66d2a43a50ab660273842f4737a293dd8a mm/slab: move memcg related functions from slab.h to slub.c
date:   5 weeks ago
config: x86_64-sof-customedconfig-edison-defconfig (https://download.01.org/0day-ci/archive/20240113/202401132054.I2L6evrk-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240113/202401132054.I2L6evrk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401132054.I2L6evrk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/slub.c:1946:34: error: unused function 'memcg_from_slab_obj' [-Werror,-Wunused-function]
    1946 | static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
         |                                  ^~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +/memcg_from_slab_obj +1946 mm/slub.c

  1915	
  1916	static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
  1917						void **p, int objects)
  1918	{
  1919		struct obj_cgroup **objcgs;
  1920		int i;
  1921	
  1922		if (!memcg_kmem_online())
  1923			return;
  1924	
  1925		objcgs = slab_objcgs(slab);
  1926		if (!objcgs)
  1927			return;
  1928	
  1929		for (i = 0; i < objects; i++) {
  1930			struct obj_cgroup *objcg;
  1931			unsigned int off;
  1932	
  1933			off = obj_to_index(s, slab, p[i]);
  1934			objcg = objcgs[off];
  1935			if (!objcg)
  1936				continue;
  1937	
  1938			objcgs[off] = NULL;
  1939			obj_cgroup_uncharge(objcg, obj_full_size(s));
  1940			mod_objcg_state(objcg, slab_pgdat(slab), cache_vmstat_idx(s),
  1941					-obj_full_size(s));
  1942			obj_cgroup_put(objcg);
  1943		}
  1944	}
  1945	#else /* CONFIG_MEMCG_KMEM */
> 1946	static inline struct mem_cgroup *memcg_from_slab_obj(void *ptr)
  1947	{
  1948		return NULL;
  1949	}
  1950	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

