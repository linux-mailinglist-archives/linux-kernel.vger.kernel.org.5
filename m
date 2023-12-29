Return-Path: <linux-kernel+bounces-13191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CE48200F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5D32821BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C5B12B8B;
	Fri, 29 Dec 2023 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XO6OqFw+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8912B82
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703872132; x=1735408132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gD4Waq4JAKpu9j8/VS57ViNcFT1weUAfHOM6HezPVK4=;
  b=XO6OqFw+LUqq+5hpn6XRt+gmkzIIpK4y/8KBXHjnqvW1qUzli8UftfRv
   hw6L/mjzZJ6J0KbfoKOzd476GRPpXuGP6GsHWJ3p9QpvKZ5fwb8Sj6ba1
   NVNPSB/LVVle9Gsh6YLTJtRk24iF1ArA2HYF388SO3yL+OFi6TgAFeNQJ
   G1z4GlnzlR52w5XeqUFxYb76pomWZzYHYrLTiYiOBbNgemHikFtNZg1O1
   jwVmQ5RXFpBaQJI7A4wycgx2hNFhtRkAz0undkYfu3moDO+1Be7XmeAHv
   0IFL0jGNxm0rTBNJjR+Tpg3aN9kBMU8Gt1bh3zvOD2LHhCv0EbTsuzd0k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="395552038"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="395552038"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 09:48:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="1110222855"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="1110222855"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 29 Dec 2023 09:48:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJGyW-000He5-0V;
	Fri, 29 Dec 2023 17:48:48 +0000
Date: Sat, 30 Dec 2023 01:47:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH, REBASED 1/2] mm, treewide: Introduce NR_PAGE_ORDERS
Message-ID: <202312300143.DOaFj2Yb-lkp@intel.com>
References: <20231228144704.14033-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228144704.14033-1-kirill.shutemov@linux.intel.com>

Hi Kirill,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc7 next-20231222]
[cannot apply to akpm-mm/mm-everything drm-misc/drm-misc-next powerpc/next powerpc/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kirill-A-Shutemov/mm-treewide-Rename-MAX_ORDER-to-MAX_PAGE_ORDER/20231228-224916
base:   linus/master
patch link:    https://lore.kernel.org/r/20231228144704.14033-1-kirill.shutemov%40linux.intel.com
patch subject: [PATCH, REBASED 1/2] mm, treewide: Introduce NR_PAGE_ORDERS
reproduce: (https://download.01.org/0day-ci/archive/20231230/202312300143.DOaFj2Yb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312300143.DOaFj2Yb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/kdump/vmcoreinfo.rst:193: WARNING: Title underline too short.

vim +193 Documentation/admin-guide/kdump/vmcoreinfo.rst

f263245a0ce2c4 Documentation/kdump/vmcoreinfo.txt             Lianbo Jiang       2019-01-10  191  
fff97f56344c04 Documentation/admin-guide/kdump/vmcoreinfo.rst Kirill A. Shutemov 2023-12-28  192  (zone.free_area, NR_PAGE_ORDERS)
23baf831a32c04 Documentation/admin-guide/kdump/vmcoreinfo.rst Kirill A. Shutemov 2023-03-15 @193  -------------------------------
f263245a0ce2c4 Documentation/kdump/vmcoreinfo.txt             Lianbo Jiang       2019-01-10  194  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

