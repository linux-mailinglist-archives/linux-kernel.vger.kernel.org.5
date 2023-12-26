Return-Path: <linux-kernel+bounces-11464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D676C81E6B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EFDDB21985
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7844D113;
	Tue, 26 Dec 2023 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBpXuAtn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B95B4D123
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703584382; x=1735120382;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OUsGGBZlDcFTUNj0SM8ZrNEwP/ExInmKWdxHb8dEvCY=;
  b=WBpXuAtnCdnixoZ/7a3JffzGbQOW4udUevwuUmRzWgLrflQp7P4SDKV1
   okYFmbsga+/UA/KYD1sE2UDxMYv/vhHpP2cnwUXVruaQ8C5WOfI7CU9uJ
   +dGhT7sMrRURJ4MIVqKBgk6MWtTRXji+tQlxDu1rm2B6xjWn0VPnnYjvn
   NQLfMCdda3s07ymx0iqoPpg1v8GMlNb748H4gWyN4M/VFqsohbAN47vcQ
   z6cHsyeExubRY/ksNjt6JmFWhA+WOfTKZQ459U2qhvBNPBZS80QsTgtuc
   Yw/jt1tU8AzysL8Ht5O6Bamsg11FlitYhbGdwN321Rkv1VyrfHbTMybp0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3150988"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="3150988"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 01:53:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="26261767"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 26 Dec 2023 01:52:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rI47M-000EOn-28;
	Tue, 26 Dec 2023 09:52:56 +0000
Date: Tue, 26 Dec 2023 17:52:13 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Potapenko <glider@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: include/net/checksum.h:31:39: sparse: sparse: incorrect type in
 argument 3 (different base types)
Message-ID: <202312261711.KKO6zAnz-lkp@intel.com>
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
commit: d911c67e10b47eb1ace08dcf95ce98fe4d408c88 x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on x86, enable it for KASAN/KMSAN
date:   1 year, 3 months ago
config: x86_64-randconfig-122-20231101 (https://download.01.org/0day-ci/archive/20231226/202312261711.KKO6zAnz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312261711.KKO6zAnz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312261711.KKO6zAnz-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   lib/iov_iter.c: note: in included file:
>> include/net/checksum.h:31:39: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:31:39: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:31:39: sparse:     got unsigned int
>> include/net/checksum.h:31:39: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:31:39: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:31:39: sparse:     got unsigned int
   include/net/checksum.h:39:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:39:45: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:39:45: sparse:     got unsigned int
   include/net/checksum.h:39:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:39:45: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:39:45: sparse:     got unsigned int

vim +31 include/net/checksum.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  23  
^1da177e4c3f41 Linus Torvalds   2005-04-16  24  #ifndef _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
5486f5bf790b5c Christophe Leroy 2022-02-17  25  static __always_inline
56649d5d3c4cb0 Al Viro          2006-11-14  26  __wsum csum_and_copy_from_user (const void __user *src, void *dst,
c693cc4676a055 Al Viro          2020-07-11  27  				      int len)
^1da177e4c3f41 Linus Torvalds   2005-04-16  28  {
5904122c46581a Al Viro          2020-02-18  29  	if (copy_from_user(dst, src, len))
c693cc4676a055 Al Viro          2020-07-11  30  		return 0;
c693cc4676a055 Al Viro          2020-07-11 @31  	return csum_partial(dst, len, ~0U);
^1da177e4c3f41 Linus Torvalds   2005-04-16  32  }
^1da177e4c3f41 Linus Torvalds   2005-04-16  33  #endif
^1da177e4c3f41 Linus Torvalds   2005-04-16  34  

:::::: The code at line 31 was first introduced by commit
:::::: c693cc4676a055c4126e487b30b0a96ea7ec9936 saner calling conventions for csum_and_copy_..._user()

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

