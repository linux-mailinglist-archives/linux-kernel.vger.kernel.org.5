Return-Path: <linux-kernel+bounces-129067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8C589643D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7F228325C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6813E4D133;
	Wed,  3 Apr 2024 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hfuvdwrc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759804CB4E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712123490; cv=none; b=G+vS8m3V0O4EAMASFz3HZcbwQA7hHkb+R6HW8milQski20+rV2INu9RgNdU/rz72lR4uh2AMP2QJ6Ok1uqqHIWhmpVr41uUGC/PC1Z1VsamVD5EQr987ebJ2OPF0wUQyoE1mqD8eVgqtSo+5HPLz7rSM1aK2zJJd2SKUb3UsCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712123490; c=relaxed/simple;
	bh=OxMshxWIOb7rbcOYQfD6FuAS2wldHxN4NxeHZY7rEyU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s9MeRzdTp7AkvQ2yeh0VBNwBwCMu1+52lZsev34k62wcElQEuQPnks0Z4MzPEBQ7Ops+qmWTxSqk2XOLwN3VzvX18d1+feFd7pHprWsTY5GGp5k8asyaMQVkgs2Kdospst6YCdL+awO3a75WYEfNFmzmhC6wU1AbBHB2IebCuj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hfuvdwrc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712123487; x=1743659487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OxMshxWIOb7rbcOYQfD6FuAS2wldHxN4NxeHZY7rEyU=;
  b=HfuvdwrcvdbXq14cM/y0lgZVSriX4P2TSL+5U+2Bg1MBwM9+VyBkVlcn
   RiLoiyVqRuZhxZ5EZZIC0KfoDhFpKdwy0FbKH6mL2M1yGVsaeq6ESaLR6
   TKxWKD6NSs55f1coKB0okXh0LKfEGP0vG0oCYdTWkO4/2LnlyKh0qRq7O
   UiQ5hYvyV3IHO6NGRpYJMNQTLKiP9I8DqX355wwf98WsrZugZXB1/bwLY
   e3TJlF0+9js6sDojF3yml3iB7iKNHJ+1soTWT9zy+wt8RA6YfwUrGeEor
   qb1rlIVATG896QV58AMtlF9tZhlrv3UM8eTj0+koeFbRLSSl6zg+5TLEi
   A==;
X-CSE-ConnectionGUID: jw/pCNckSJi1hwQ9ELwu3w==
X-CSE-MsgGUID: dEqbiyVxRaikDiiKm7nBog==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10302044"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="10302044"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 22:51:14 -0700
X-CSE-ConnectionGUID: J+/Q29ccTzaVHChz+AXlsg==
X-CSE-MsgGUID: BcF1SbUIRa2ueZoakOj6XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="49295703"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 02 Apr 2024 22:51:13 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrtWg-0001u9-2y;
	Wed, 03 Apr 2024 05:51:10 +0000
Date: Wed, 3 Apr 2024 13:50:45 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>
Subject: powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data33'
 from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data33'
Message-ID: <202404031349.nmKhyuUG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e92c1e6cd876754b64d1998ec0a01800ed954a6
commit: 5431fdd2c181dd2eac218e45b44deb2925fa48f0 ptrace: Convert ptrace_attach() to use lock guards
date:   4 months ago
config: powerpc64-buildonly-randconfig-r006-20220201 (https://download.01.org/0day-ci/archive/20240403/202404031349.nmKhyuUG-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240403/202404031349.nmKhyuUG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404031349.nmKhyuUG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data33' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data33'
>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data33' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data33'
>> powerpc64-linux-ld: warning: orphan section `.bss..Lubsan_data33' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data33'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

