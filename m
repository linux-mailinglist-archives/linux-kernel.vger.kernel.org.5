Return-Path: <linux-kernel+bounces-133561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70EF89A59E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC7E1F21A52
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A6E174ECD;
	Fri,  5 Apr 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5HQZl/c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06ED174EC2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712348644; cv=none; b=ZJCAP+qoCfUIQGKwSZWAvlR5IwGMqV5s20zK/rPXiF52a1w3H3rC2RqanbR8HFYcX/tdqHen//uvUpF7IB5EW7RkoPLrBGGsJLYxxMlRUc/08ulvx/fgsEkBRStS1IpJOev3Seo8wc6ukLW5CidP7ol267ojz1HVDMSmS9py3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712348644; c=relaxed/simple;
	bh=Dw4JPIXlD0rrP8zv2l2cW7VTI4jVcNnThSj8nYZebo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEUguid8Vv1f0x9Uy5karFl/60F6I9lCWIWDDzqP7WmkxySB8PjoQL3n4Iq0RLYciWAJgyHJgcjR6zPlcWzSNda5sysXxnLfP+fPYaOYCi5be+9gVccbt3oRqU+qlRO1DHPcSxillWB1fKrO1jiU4TVNIH/JBWDfrxH5cOklrHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5HQZl/c; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712348641; x=1743884641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dw4JPIXlD0rrP8zv2l2cW7VTI4jVcNnThSj8nYZebo0=;
  b=F5HQZl/cSGEr6YP59T6EQppSLYHLRbW+BgXaHVpziFyiotxpgcz/SlKE
   fpkP0GLUVQAZ86kpldnl1ZxvyU+ItvRpTMWnRMZKd5dLGPbfUN/2ddINl
   wMMGmWvsDpPDdvmyZniMh2diCkYi7xXRJss5Yk/uELw9BbbrhYyWRRSxY
   HgsUc2678GM3qm19qUoLskheAF/fssdyYOcxbzqOkUORYcTGhv2N8BS/G
   jdkG467vzgWHIFxbNZEPsp9drmpcbUXM3CNLzvtd2rLrBqeyaTxEVywle
   VsGFt2Ma8KjMIolLgsAE9Zsq8nlW5sA0Z0sockFAXiGOQuZEaCjx7qZVY
   A==;
X-CSE-ConnectionGUID: mem9opVVTkq1hfJTdcihsw==
X-CSE-MsgGUID: eL8O7mRqSEaDH1I3doG/sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7789086"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7789086"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 13:24:01 -0700
X-CSE-ConnectionGUID: LK0yzfpbTsu4u8NnnfJGcQ==
X-CSE-MsgGUID: XTB8CfXqQwOSqMzhOI9Yfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="24000510"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 05 Apr 2024 13:23:59 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsq6P-0002fw-2Z;
	Fri, 05 Apr 2024 20:23:57 +0000
Date: Sat, 6 Apr 2024 04:23:54 +0800
From: kernel test robot <lkp@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v2 2/5] mm: zswap: calculate limits only when updated
Message-ID: <202404060445.zMPxumi9-lkp@intel.com>
References: <20240405053510.1948982-3-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405053510.1948982-3-yosryahmed@google.com>

Hi Yosry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20240405]
[cannot apply to linus/master v6.9-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-zswap-always-shrink-in-zswap_store-if-zswap_pool_reached_full/20240405-133623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240405053510.1948982-3-yosryahmed%40google.com
patch subject: [PATCH v2 2/5] mm: zswap: calculate limits only when updated
config: i386-randconfig-061-20240405 (https://download.01.org/0day-ci/archive/20240406/202404060445.zMPxumi9-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240406/202404060445.zMPxumi9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404060445.zMPxumi9-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/zswap.c:132:15: sparse: sparse: symbol 'zswap_accept_thr_pages' was not declared. Should it be static?
   mm/zswap.c:1188:23: sparse: sparse: context imbalance in 'shrink_memcg_cb' - unexpected unlock

vim +/zswap_accept_thr_pages +132 mm/zswap.c

   120	
   121	static int zswap_max_pool_param_set(const char *,
   122					       const struct kernel_param *);
   123	static const struct kernel_param_ops zswap_max_pool_param_ops = {
   124		.set =		zswap_max_pool_param_set,
   125		.get =		param_get_uint,
   126	};
   127	module_param_cb(max_pool_percent, &zswap_max_pool_param_ops,
   128			&zswap_max_pool_percent, 0644);
   129	
   130	/* The threshold for accepting new pages after the max_pool_percent was hit */
   131	static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
 > 132	unsigned long zswap_accept_thr_pages;
   133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

