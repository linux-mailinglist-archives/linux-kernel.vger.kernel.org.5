Return-Path: <linux-kernel+bounces-21578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E05A829169
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AEE1F26981
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBFA3C35;
	Wed, 10 Jan 2024 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncPPdgjS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A5320A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704846561; x=1736382561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oOvef3zYDJnL3H0BSsrMLlOOVtli/UzCvsvQTmalG3Y=;
  b=ncPPdgjSCchTcNyHncZ7ZhT+Ywu78kJ9cuDfEsMqyYFkEvNxPHLAkWtS
   kufHlRe43G6ERr6PRD3rU+zLAa1kvXN7DjwyRI8FDR3hOU2zqyfwdhN56
   jfU2DIVBznv7d0KXLO0zoTIjo0DId/2KGcKtoYboyhOiXUff0HwsSxQHS
   hmx/+6Jd4gA4UdZeChCVRqWbCGftu82ANgw6Zfyj2s7lORhAkE0XDbVvN
   g97UiYKruYaciETSoeti8t+z6+mwA7ickiqfu67otfXvEFTwBQX8MNQEQ
   2nOZe3j8+IJlhn+02CzAgDkw/ZwyKwfFIL5H/x4SE5NgAGjYAmTsyL8iq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5449019"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5449019"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 16:29:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="900942507"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="900942507"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jan 2024 16:29:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNMT6-0006QL-2I;
	Wed, 10 Jan 2024 00:29:16 +0000
Date: Wed, 10 Jan 2024 08:28:58 +0800
From: kernel test robot <lkp@intel.com>
To: Patricia Alfonso <trishalfonso@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	David Gow <davidgow@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Subject: arch/um/os-Linux/mem.c:28:6: warning: no previous prototype for
 'kasan_map_memory'
Message-ID: <202401100849.Oik8AKkT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Patricia,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6c1dd1fe5d8a1d43ed96e2e0ed44a88c73c5c039
commit: 5b301409e8bc5d7fad2ee138be44c5c529dd0874 UML: add support for KASAN under x86_64
date:   1 year, 6 months ago
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20240110/202401100849.Oik8AKkT-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401100849.Oik8AKkT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401100849.Oik8AKkT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/um/os-Linux/mem.c:28:6: warning: no previous prototype for 'kasan_map_memory' [-Wmissing-prototypes]
      28 | void kasan_map_memory(void *start, size_t len)
         |      ^~~~~~~~~~~~~~~~
   arch/um/os-Linux/mem.c:212:13: warning: no previous prototype for 'check_tmpexec' [-Wmissing-prototypes]
     212 | void __init check_tmpexec(void)
         |             ^~~~~~~~~~~~~


vim +/kasan_map_memory +28 arch/um/os-Linux/mem.c

    19	
    20	/*
    21	 * kasan_map_memory - maps memory from @start with a size of @len.
    22	 * The allocated memory is filled with zeroes upon success.
    23	 * @start: the start address of the memory to be mapped
    24	 * @len: the length of the memory to be mapped
    25	 *
    26	 * This function is used to map shadow memory for KASAN in uml
    27	 */
  > 28	void kasan_map_memory(void *start, size_t len)
    29	{
    30		if (mmap(start,
    31			 len,
    32			 PROT_READ|PROT_WRITE,
    33			 MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
    34			 -1,
    35			 0) == MAP_FAILED) {
    36			os_info("Couldn't allocate shadow memory: %s\n.",
    37				strerror(errno));
    38			exit(1);
    39		}
    40	}
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

