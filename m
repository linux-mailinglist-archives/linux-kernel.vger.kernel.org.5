Return-Path: <linux-kernel+bounces-17527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5052824EDD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2521C20F70
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3781DDE9;
	Fri,  5 Jan 2024 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9Cdzlwn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E841D685
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704437772; x=1735973772;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C/N0FKh5OKbPbltDCk1Qqa9te6zo3abVHsX6TgIK5WI=;
  b=h9Cdzlwn4DeRSPJC+ns193N+XHPvPi69zQB4EO75W0XLV64gqkL2xulg
   pbXPADRgj6YhiBVU0Da2eAzrsIgId3FM8WpTFh+GhTZyjgRq/YLlY/bPh
   jNfB9plXO3ZkLLnwqP0RNI4OXZzfjzI09RZVHyXsk9RRpbtxdy6EpD5A7
   jdaLUQUHkjAGAucLru9FVw5sJZuJTHN8cYuvOK3RBXarZXdCjc0u1bDfe
   Vxf9JmaZIQLfUNhlu/E65I+e1zZ38382nyBZGM+dsBUDtfZ/gv1iq2M2k
   aUrQ8YcjVqOYh1+6u7M/AMOVL8ZTaD0T6qYuCqdLPLGClaH/3NmpnNEB9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="483619166"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="483619166"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 22:56:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="15164526"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 04 Jan 2024 22:56:10 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rLe7f-0000uh-1K;
	Fri, 05 Jan 2024 06:56:05 +0000
Date: Fri, 5 Jan 2024 14:55:25 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: lib/iov_iter.c:27:40: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202401051457.EDSUSsof-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1f874787ed9a2d78ed59cb21d0d90ac0178eceb0
commit: f1982740f5e77090bde41a9b84e257d69ec46598 iov_iter: Convert iterate*() to inline funcs
date:   3 months ago
config: csky-randconfig-r111-20231115 (https://download.01.org/0day-ci/archive/20240105/202401051457.EDSUSsof-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240105/202401051457.EDSUSsof-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401051457.EDSUSsof-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/iov_iter.c:27:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *iter_to @@
   lib/iov_iter.c:27:40: sparse:     expected void *to
   lib/iov_iter.c:27:40: sparse:     got void [noderef] __user *iter_to
   lib/iov_iter.c:57:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void [noderef] __user *iter_from @@
   lib/iov_iter.c:57:46: sparse:     expected void const *from
   lib/iov_iter.c:57:46: sparse:     got void [noderef] __user *iter_from
   lib/iov_iter.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:87:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   include/linux/uaccess.h:87:38: sparse:     expected void const *from
   include/linux/uaccess.h:87:38: sparse:     got void const [noderef] __user *from
   lib/iov_iter.c: note: in included file:
   include/net/checksum.h:33:39: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:33:39: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:33:39: sparse:     got unsigned int
   include/net/checksum.h:41:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:41:45: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:41:45: sparse:     got unsigned int

vim +27 lib/iov_iter.c

    17	
    18	static __always_inline
    19	size_t copy_to_user_iter(void __user *iter_to, size_t progress,
    20				 size_t len, void *from, void *priv2)
    21	{
    22		if (should_fail_usercopy())
    23			return len;
    24		if (access_ok(iter_to, len)) {
    25			from += progress;
    26			instrument_copy_to_user(iter_to, from, len);
  > 27			len = raw_copy_to_user(iter_to, from, len);
    28		}
    29		return len;
    30	}
    31	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

