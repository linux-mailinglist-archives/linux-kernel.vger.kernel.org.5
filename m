Return-Path: <linux-kernel+bounces-18530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3612825ECF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38F51C21C7F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE5A523E;
	Sat,  6 Jan 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdLliv++"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E894428
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704527693; x=1736063693;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MJbYPYyFG10Jn2xVuv0ZuOd+hmT1c4HudNkZXqaVXJY=;
  b=HdLliv++KCnlxHUNPMPmvRk1vVhKtpNC3K5qEE+Rbksg44ZR2X0PVZYO
   5F5Ujj3rUbWitTtpi3b/dav27I2/ZtGU11ezt0Rz9gCUhEjpiHdeGum9b
   MGqUVnGOSSdEsBKpqWIP7Qz8D4anPhPfOqtGMfi1DvlhchVYWQ/CxHfmj
   MHoh2sHr83VWFLW6p+vjpmftZOHj8uP4Bf7qDuPaEIcjtaNITiGwYy2Oo
   EZFBzzZzozbZkx/WunxmjuXKQmIj9Cy0uHtbWp+v5uHqBDF2IHoDR2G1I
   im4TZ/wOFcMLh7LmkXYHw6wskpZhYavspYoZjU/rwtIoXCe1Dslo7Q251
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="4447806"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="4447806"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 23:54:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="784395756"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="784395756"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jan 2024 23:54:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM1W4-0002Cc-25;
	Sat, 06 Jan 2024 07:54:48 +0000
Date: Sat, 6 Jan 2024 15:53:49 +0800
From: kernel test robot <lkp@intel.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: mm/slub.c:2142:15: warning: variable 'partial_slabs' set but not used
Message-ID: <202401061535.b3xgfK51-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Vlastimil,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: bb192ed9aa7191a5d65548f82c42b6750d65f569 mm/slub: Convert most struct page to struct slab by spatch
date:   2 years ago
config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20240106/202401061535.b3xgfK51-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401061535.b3xgfK51-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401061535.b3xgfK51-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/slub.c:2142:15: warning: variable 'partial_slabs' set but not used [-Wunused-but-set-variable]
    2142 |         unsigned int partial_slabs = 0;
         |                      ^
   mm/slub.c:1681:21: warning: unused function 'kmalloc_large_node_hook' [-Wunused-function]
    1681 | static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
         |                     ^~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +/partial_slabs +2142 mm/slub.c

  2132	
  2133	/*
  2134	 * Try to allocate a partial slab from a specific node.
  2135	 */
  2136	static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
  2137				      struct slab **ret_slab, gfp_t gfpflags)
  2138	{
  2139		struct slab *slab, *slab2;
  2140		void *object = NULL;
  2141		unsigned long flags;
> 2142		unsigned int partial_slabs = 0;
  2143	
  2144		/*
  2145		 * Racy check. If we mistakenly see no partial slabs then we
  2146		 * just allocate an empty slab. If we mistakenly try to get a
  2147		 * partial slab and there is none available then get_partial()
  2148		 * will return NULL.
  2149		 */
  2150		if (!n || !n->nr_partial)
  2151			return NULL;
  2152	
  2153		spin_lock_irqsave(&n->list_lock, flags);
  2154		list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
  2155			void *t;
  2156	
  2157			if (!pfmemalloc_match(slab, gfpflags))
  2158				continue;
  2159	
  2160			t = acquire_slab(s, n, slab, object == NULL);
  2161			if (!t)
  2162				break;
  2163	
  2164			if (!object) {
  2165				*ret_slab = slab;
  2166				stat(s, ALLOC_FROM_PARTIAL);
  2167				object = t;
  2168			} else {
  2169				put_cpu_partial(s, slab, 0);
  2170				stat(s, CPU_PARTIAL_NODE);
  2171				partial_slabs++;
  2172			}
  2173	#ifdef CONFIG_SLUB_CPU_PARTIAL
  2174			if (!kmem_cache_has_cpu_partial(s)
  2175				|| partial_slabs > s->cpu_partial_slabs / 2)
  2176				break;
  2177	#else
  2178			break;
  2179	#endif
  2180	
  2181		}
  2182		spin_unlock_irqrestore(&n->list_lock, flags);
  2183		return object;
  2184	}
  2185	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

