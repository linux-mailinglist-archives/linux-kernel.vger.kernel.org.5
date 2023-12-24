Return-Path: <linux-kernel+bounces-10642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C9681D7F8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 06:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175E11F21BFC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 05:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE63ED4;
	Sun, 24 Dec 2023 05:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7FX/DAM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71A5EC4
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 05:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703395150; x=1734931150;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gNlBu1wLGB+Avd3i6iAsUdA0xxO7lmcOZjw3VSkITq4=;
  b=b7FX/DAMjHFF1/rCiBqvsFKPwZfWZckTBrT0Xl0xGWQZs46JP/VK/dS1
   gqdY6d2A9DXU6qTIvWCX5aUFJLiHfcGZhcQdUZD3E8zI3E1fKaBrXl3sF
   hHMr0/DQ7kSxZcTQNjiFJbHsPzNyqDCdB4IiRDX2TlxwdZ0MQvRtk62E3
   bhPYi5JnWLB8Q/M1LKNR+jUgLb5Z2JZfHOA2+vJlMvMRkZCFS1vAZ4K3S
   ZTk6IBerZJ2NwSInooh6r+HZ4s5dggbKqvhTDpb/zHP31xzYDi6f6WtoI
   M0v4kFPfocNLJYJESyC/m+rOwgJcN79NqDsht7H1+Fd1f/IFRDgUQyGBo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="386656464"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="386656464"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 21:19:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="843390888"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="843390888"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 23 Dec 2023 21:19:08 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHGtE-000BrN-1v;
	Sun, 24 Dec 2023 05:19:05 +0000
Date: Sun, 24 Dec 2023 13:16:31 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy'
 specified bound 4294967295 exceeds maximum object size 2147483647
Message-ID: <202312241346.T8Nf06n1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Mickaël,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861deac3b092f37b2c5e6871732f3e11486f7082
commit: ae271c1b14de343b888e77f74f640e3dcbdeb4c9 landlock: Add ruleset and domain management
date:   2 years, 8 months ago
config: i386-buildonly-randconfig-r002-20220101 (https://download.01.org/0day-ci/archive/20231224/202312241346.T8Nf06n1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231224/202312241346.T8Nf06n1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312241346.T8Nf06n1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/string.h:3,
                    from include/linux/string.h:21,
                    from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from security/landlock/ruleset.c:15:
   security/landlock/ruleset.c: In function 'create_rule':
>> arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' specified bound 4294967295 exceeds maximum object size 2147483647 [-Wstringop-overflow=]
     182 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   security/landlock/ruleset.c:96:9: note: in expansion of macro 'memcpy'
      96 |         memcpy(new_rule->layers, layers,
         |         ^~~~~~


vim +/__builtin_memcpy +182 arch/x86/include/asm/string_32.h

^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  177  
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  178  /*
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  179   *	No 3D Now!
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  180   */
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  181  
ff60fab71bb3b4 arch/x86/include/asm/string_32.h Arjan van de Ven 2009-09-28 @182  #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
^1da177e4c3f41 include/asm-i386/string.h        Linus Torvalds   2005-04-16  183  

:::::: The code at line 182 was first introduced by commit
:::::: ff60fab71bb3b4fdbf8caf57ff3739ffd0887396 x86: Use __builtin_memset and __builtin_memcpy for memset/memcpy

:::::: TO: Arjan van de Ven <arjan@infradead.org>
:::::: CC: H. Peter Anvin <hpa@zytor.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

