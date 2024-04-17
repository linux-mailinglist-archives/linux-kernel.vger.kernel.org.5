Return-Path: <linux-kernel+bounces-149136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167A8A8C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC1B1F22783
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198DE36AE4;
	Wed, 17 Apr 2024 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjJbvxeD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E4C28DD5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713383388; cv=none; b=ukc2wJr0KoyV8EAQzgiIu2MEaP6HI3t3jgfInWonacNNNzj6r4Ln8WKKQv3b7xEHgwmH8zLuP40npgfgrx+o7nDX48DVPVfse8m/otcbstOSw8Uff0HLKtGwHXz0zjA2vGK++IyuOl6JFqMNadKA6l+5pAKRYXdizSJhMAewHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713383388; c=relaxed/simple;
	bh=S7JlLxeut6x1KWTpxGEHLu6tTGDE+NbAJLWh5S/S8aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzX3twy7nqjq31ojczoDnLSoyvuBR4Z+JxL99Kh1G/rQVAk9BL+KtBhPRZIMi0CgPEiAbsXq7M54wQKO48/agQLb3Tr9yr2MmJrr2HodoStOfgLfWvP35+1Zyt1SkQ9KDTOIIl0JGz9Dz2YN+21sWyh3oa64ciFjhXkrVUu92xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjJbvxeD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713383386; x=1744919386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S7JlLxeut6x1KWTpxGEHLu6tTGDE+NbAJLWh5S/S8aA=;
  b=OjJbvxeDEIBLWNSsgNZ8jJU8FNXsLtRoWKXvnbIHlu3iJF87sAq2ZQg1
   0xjzkmKXWTr8KlsI34VCg+ZoWMNUksPtcCXKirAZHUpkHflleXbVjNaTP
   1IwgGL9w9gSETI1VuJMlGDVRDczTTM9sG/Cl1sRB4PvB22i/tMIfSa0wY
   Elbe/vThHPDQG0h4c61tcAWrtUiZhAu9rQWa7wVjKzmh25Q9A0uSYzPCP
   lXQEmAsPus0HW+/oLEKKjGqEMqv3PlI1an71OJwXxd/mR4n3mUn3Mm+WB
   XBnD2jLsHqjunGwH04nLIuT62E0WSe4lscNYLoaYPJieNnXKollZux5ml
   g==;
X-CSE-ConnectionGUID: iZasQlWYR0u6sFxI+oBsqQ==
X-CSE-MsgGUID: 9n4deEKBQT2a3GaPRUVW3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9055357"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="9055357"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 12:49:45 -0700
X-CSE-ConnectionGUID: 5BVBRTY9TROBMxm7LNxmUA==
X-CSE-MsgGUID: kffHsbaVTrezpol5G+TesQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22774902"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 17 Apr 2024 12:49:40 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxBHm-0006wO-0I;
	Wed, 17 Apr 2024 19:49:38 +0000
Date: Thu, 18 Apr 2024 03:49:36 +0800
From: kernel test robot <lkp@intel.com>
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	ying.huang@intel.com, vernhao@tencent.com,
	mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
	david@redhat.com, peterz@infradead.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [PATCH v9 7/8] mm: add folio_put_mgen() to deliver migrc's
 generation number to pcp or buddy
Message-ID: <202404180327.oqZWEtEn-lkp@intel.com>
References: <20240417071847.29584-8-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417071847.29584-8-byungchul@sk.com>

Hi Byungchul,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0bbac3facb5d6cc0171c45c9873a2dc96bea9680]

url:    https://github.com/intel-lab-lkp/linux/commits/Byungchul-Park/x86-tlb-add-APIs-manipulating-tlb-batch-s-arch-data/20240417-152211
base:   0bbac3facb5d6cc0171c45c9873a2dc96bea9680
patch link:    https://lore.kernel.org/r/20240417071847.29584-8-byungchul%40sk.com
patch subject: [PATCH v9 7/8] mm: add folio_put_mgen() to deliver migrc's generation number to pcp or buddy
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240418/202404180327.oqZWEtEn-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7089c359a3845323f6f30c44a47dd901f2edfe63)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240418/202404180327.oqZWEtEn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404180327.oqZWEtEn-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/page_alloc.c:19:
   In file included from include/linux/mm.h:2230:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/page_alloc.c:44:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
   mm/page_alloc.c:2812:2: warning: arithmetic between different enumeration types ('enum vm_event_item' and 'enum zone_type') [-Wenum-enum-conversion]
    2812 |         __count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:135:34: note: expanded from macro '__count_zid_vm_events'
     135 |         __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
         |                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   mm/page_alloc.c:2934:3: warning: arithmetic between different enumeration types ('enum vm_event_item' and 'enum zone_type') [-Wenum-enum-conversion]
    2934 |                 __count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:135:34: note: expanded from macro '__count_zid_vm_events'
     135 |         __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
         |                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   mm/page_alloc.c:4575:2: warning: arithmetic between different enumeration types ('enum vm_event_item' and 'enum zone_type') [-Wenum-enum-conversion]
    4575 |         __count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:135:34: note: expanded from macro '__count_zid_vm_events'
     135 |         __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
         |                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   In file included from mm/page_alloc.c:58:
>> mm/internal.h:1404:9: error: call to '__compiletime_assert_368' declared with 'error' attribute: BUILD_BUG failed
    1404 |         return xchg(&current->mgen, 0);
         |                ^
   include/linux/atomic/atomic-instrumented.h:4758:2: note: expanded from macro 'xchg'
    4758 |         raw_xchg(__ai_ptr, __VA_ARGS__); \
         |         ^
   include/linux/atomic/atomic-arch-fallback.h:12:18: note: expanded from macro 'raw_xchg'
      12 | #define raw_xchg arch_xchg
         |                  ^
   arch/riscv/include/asm/cmpxchg.h:145:23: note: expanded from macro 'arch_xchg'
     145 |         (__typeof__(*(ptr))) __arch_xchg((ptr), _x_, sizeof(*(ptr)));   \
         |                              ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:437:2: note: expanded from macro '_compiletime_assert'
     437 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:430:4: note: expanded from macro '__compiletime_assert'
     430 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:124:1: note: expanded from here
     124 | __compiletime_assert_368
         | ^
   In file included from mm/page_alloc.c:58:
>> mm/internal.h:1404:9: error: call to '__compiletime_assert_368' declared with 'error' attribute: BUILD_BUG failed
   include/linux/atomic/atomic-instrumented.h:4758:2: note: expanded from macro 'xchg'
    4758 |         raw_xchg(__ai_ptr, __VA_ARGS__); \
         |         ^
   include/linux/atomic/atomic-arch-fallback.h:12:18: note: expanded from macro 'raw_xchg'
      12 | #define raw_xchg arch_xchg
         |                  ^
   arch/riscv/include/asm/cmpxchg.h:145:23: note: expanded from macro 'arch_xchg'
     145 |         (__typeof__(*(ptr))) __arch_xchg((ptr), _x_, sizeof(*(ptr)));   \
         |                              ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:437:2: note: expanded from macro '_compiletime_assert'
     437 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:430:4: note: expanded from macro '__compiletime_assert'
     430 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:124:1: note: expanded from here
     124 | __compiletime_assert_368
         | ^
   6 warnings and 2 errors generated.


vim +1404 mm/internal.h

  1401	
  1402	static inline unsigned int hand_over_task_mgen(void)
  1403	{
> 1404		return xchg(&current->mgen, 0);
  1405	}
  1406	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

