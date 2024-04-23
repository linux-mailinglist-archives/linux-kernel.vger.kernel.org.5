Return-Path: <linux-kernel+bounces-155389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97E88AE9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598EE1F2462C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96AF8593E;
	Tue, 23 Apr 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKqKEqFF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C3135414
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883297; cv=none; b=Tgv2hPAEJhryxKy2qWzUm5niyOjn0sasL7+UdDlOxtXBJ07kZVORz6/DQ47s5+4qezQnShY+JgUi0yQMjxWGrhP71v0Ge5P07rR9sfnkM/y06XMK6JYV2aXLlrc+9W00S0oAVifDU5Iilmk7pykAiitSv8GOhps1XOHGwUAQxU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883297; c=relaxed/simple;
	bh=2MFEdQx8PJfmmWmol+/toruOTDUBS8sWIUsI92/p5zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyJ/W9Sw8gB+MxMaRnjMuf1GBXLk+4PNR+Y1+dmzxUWRjb4g1bfceLUrZCiBBZYEP3xERHWyAJcO/M0AfWLYScmFZmyx9pn4BlnMQRBiuak2a/8GoLY0iR4V1dkH73EOyi0sG579v7nUoTtGvUAXLSIY/O7jgoop90OkMG+8mwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKqKEqFF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713883296; x=1745419296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2MFEdQx8PJfmmWmol+/toruOTDUBS8sWIUsI92/p5zU=;
  b=XKqKEqFFvd/fr0R4i9f07EosLJpMQ7rHVGT1J6ZhuQccN6xQhWryAcjG
   YT20sNHLQzg3/NbqPdgunwBOS0vJmeCMOiEHjIDQkDVmCma4B7dkomrUZ
   FeqyGrWcTRb7Dlr75R8wyE4dOChayp4t4nnAFIPglmxHXup3mxKGYz7HP
   hRC3wjEjb5AFOU9TkRBH+ueq+wByxhLyFjNoYk1Cp0fiPIvi4ikT1Bd2a
   //go2GM5ATDxkHpyTg2C+2E3jA7p2ILQLWIMD4Fa3ROPZLalz5hUbuK31
   v0qOYCVlHmZZcDbV3nj4YV+qMYM1SwtMQeOx3VcqQFjvuM5bh7xq+IRcg
   w==;
X-CSE-ConnectionGUID: ZJ0ElKiZRJSYzQjuglBA6A==
X-CSE-MsgGUID: TaNiRe72TpSpoAeNtViVLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20871603"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20871603"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:41:36 -0700
X-CSE-ConnectionGUID: VcsInWyQT7eIjCZmisbxQQ==
X-CSE-MsgGUID: WUAU15WtSuGKJA5MQLX14A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24363957"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 23 Apr 2024 07:41:33 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzHKs-0000Eu-1Q;
	Tue, 23 Apr 2024 14:41:30 +0000
Date: Tue, 23 Apr 2024 22:40:38 +0800
From: kernel test robot <lkp@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] memcg: reduce memory for the lruvec and memcg stats
Message-ID: <202404232230.94gQwAI2-lkp@intel.com>
References: <20240423051826.791934-3-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423051826.791934-3-shakeel.butt@linux.dev>

Hi Shakeel,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240422]
[cannot apply to akpm-mm/mm-everything linus/master v6.9-rc5 v6.9-rc4 v6.9-rc3 v6.9-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shakeel-Butt/mm-rearrange-node_stat_item-to-put-memcg-stats-at-start/20240423-132451
base:   next-20240422
patch link:    https://lore.kernel.org/r/20240423051826.791934-3-shakeel.butt%40linux.dev
patch subject: [PATCH 2/4] memcg: reduce memory for the lruvec and memcg stats
config: x86_64-buildonly-randconfig-002-20240423 (https://download.01.org/0day-ci/archive/20240423/202404232230.94gQwAI2-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240423/202404232230.94gQwAI2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404232230.94gQwAI2-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/memcontrol.c:1651:2: error: call to '__compiletime_assert_963' declared with 'error' attribute: BUILD_BUG_ON failed: ARRAY_SIZE(memory_stats) != MEMCG_NR_STAT - 1
    1651 |         BUILD_BUG_ON(ARRAY_SIZE(memory_stats) != MEMCG_NR_STAT - 1);
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:460:2: note: expanded from macro 'compiletime_assert'
     460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:448:2: note: expanded from macro '_compiletime_assert'
     448 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:441:4: note: expanded from macro '__compiletime_assert'
     441 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:40:1: note: expanded from here
      40 | __compiletime_assert_963
         | ^
   1 error generated.


vim +1651 mm/memcontrol.c

  1645	
  1646	static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
  1647	{
  1648		int i;
  1649	
  1650		/* Reduce by 1 for MEMCG_SWAP as that is not exposed in v2. */
> 1651		BUILD_BUG_ON(ARRAY_SIZE(memory_stats) != MEMCG_NR_STAT - 1);
  1652	
  1653		/*
  1654		 * Provide statistics on the state of the memory subsystem as
  1655		 * well as cumulative event counters that show past behavior.
  1656		 *
  1657		 * This list is ordered following a combination of these gradients:
  1658		 * 1) generic big picture -> specifics and details
  1659		 * 2) reflecting userspace activity -> reflecting kernel heuristics
  1660		 *
  1661		 * Current memory state:
  1662		 */
  1663		mem_cgroup_flush_stats(memcg);
  1664	
  1665		for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
  1666			u64 size;
  1667	
  1668			size = memcg_page_state_output(memcg, memory_stats[i].idx);
  1669			seq_buf_printf(s, "%s %llu\n", memory_stats[i].name, size);
  1670	
  1671			if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
  1672				size += memcg_page_state_output(memcg,
  1673								NR_SLAB_RECLAIMABLE_B);
  1674				seq_buf_printf(s, "slab %llu\n", size);
  1675			}
  1676		}
  1677	
  1678		/* Accumulated memory events */
  1679		seq_buf_printf(s, "pgscan %lu\n",
  1680			       memcg_events(memcg, PGSCAN_KSWAPD) +
  1681			       memcg_events(memcg, PGSCAN_DIRECT) +
  1682			       memcg_events(memcg, PGSCAN_KHUGEPAGED));
  1683		seq_buf_printf(s, "pgsteal %lu\n",
  1684			       memcg_events(memcg, PGSTEAL_KSWAPD) +
  1685			       memcg_events(memcg, PGSTEAL_DIRECT) +
  1686			       memcg_events(memcg, PGSTEAL_KHUGEPAGED));
  1687	
  1688		for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++) {
  1689			if (memcg_vm_event_stat[i] == PGPGIN ||
  1690			    memcg_vm_event_stat[i] == PGPGOUT)
  1691				continue;
  1692	
  1693			seq_buf_printf(s, "%s %lu\n",
  1694				       vm_event_name(memcg_vm_event_stat[i]),
  1695				       memcg_events(memcg, memcg_vm_event_stat[i]));
  1696		}
  1697	
  1698		/* The above should easily fit into one page */
  1699		WARN_ON_ONCE(seq_buf_has_overflowed(s));
  1700	}
  1701	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

