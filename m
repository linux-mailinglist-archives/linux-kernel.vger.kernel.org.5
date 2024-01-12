Return-Path: <linux-kernel+bounces-24281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AD682BA3F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0271F26238
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54881B283;
	Fri, 12 Jan 2024 04:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1yQCgDo"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7911B281
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 04:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705032582; x=1736568582;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k2xPkD/FPcG7prDILRuXLVVPQP+wBUE/8Pe3Qtuj2SE=;
  b=Z1yQCgDoXjvsRip1qjmpl8ewC5v7489u5p8KuCQFF40TXSpZ3DDR378D
   Kkr8J6JbgW6Sv7jofiV+OysQUMmY6cYeeTGxxrjiaPZUyz9Q/vA9H3FHX
   k7D2ZQwsYcbfyQAzMBO52bwNgSl4/TwCgHkxjmxJtRumXOPO/ABpjGIP1
   a/p2mx1F3v+gKaG8NXcIIBsHOsfIgqKoxq0b0hXcFa3vP+GAu1LeMXB5s
   7Fr4IrXAesrXk4EVj0Tqa4JyM14qmK9SQwliZ+MYeVjTR4ggWDzhHrWXi
   70LZdukj1wvDNtWi5sRqzM0ibW7sfSM77MmWQzd+01254NNDnzABfQJOy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="389519598"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="389519598"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 20:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="786226711"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="786226711"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jan 2024 20:09:39 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rO8rQ-000935-2x;
	Fri, 12 Jan 2024 04:09:36 +0000
Date: Fri, 12 Jan 2024 12:09:34 +0800
From: kernel test robot <lkp@intel.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Baoquan He <bhe@redhat.com>
Subject: ld.lld: error: undefined symbol: arch_phys_to_idmap_offset
Message-ID: <202401121124.9QvF22yh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   22d29f1112c85c1ad519a8c0403f7f7289cf060c
commit: c41bd2514184d75db087fe4c1221237fb7922875 kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP
date:   4 weeks ago
config: arm-randconfig-001-20240112 (https://download.01.org/0day-ci/archive/20240112/202401121124.9QvF22yh-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121124.9QvF22yh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401121124.9QvF22yh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: arch_phys_to_idmap_offset
   >>> referenced by kexec_core.c
   >>>               kernel/kexec_core.o:(kimage_alloc_control_pages) in archive vmlinux.a
   >>> referenced by kexec_core.c
   >>>               kernel/kexec_core.o:(kimage_alloc_control_pages) in archive vmlinux.a
   >>> referenced by kexec_core.c
   >>>               kernel/kexec_core.o:(kimage_free) in archive vmlinux.a
   >>> referenced 15 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

