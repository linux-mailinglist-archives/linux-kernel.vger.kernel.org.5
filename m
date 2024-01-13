Return-Path: <linux-kernel+bounces-25192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA1282C951
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 05:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40081C227CB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 04:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4604E544;
	Sat, 13 Jan 2024 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jjn9bnnF"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3457DF4F
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705119025; x=1736655025;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YKX6ELWIIbxvgyZPCwfBcAyQ41ZMYr9iqHmtEXYo1M4=;
  b=Jjn9bnnFuxLx3EfCY3kgTuCtpO49vr6o3r7pU4n+ECBRaDi22zU+D6Eg
   mHRd+51KCBTZC9u7ZnIOSLDLr8ITZ+33dzw+7EZeLI8NlPzDUkKNnvCes
   4hFVopBjycjYoxvf3X0xA36yMacGBqSXBFp25aBVAdXLIWPzltIoZYnlQ
   baztcbT7p3kYKFQqyP+EdPQwdNH9l+Z/4n3YUetgH/yPnDqlLupcZEMvZ
   Q52HKeLd5qJ5xDI6tYQbM5Bf12kN82oQeaEG3262EW3fkG3Dy7aSuMovI
   hVSsAAZmVWB/io3pMSeEiDDHitZEyJ0/mjzQx8abnq/hFFnLdqrPz5uaE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="389792704"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="389792704"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 20:10:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="1114415882"
X-IronPort-AV: E=Sophos;i="6.04,191,1695711600"; 
   d="scan'208";a="1114415882"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jan 2024 20:10:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOVLh-000A4e-15;
	Sat, 13 Jan 2024 04:10:21 +0000
Date: Sat, 13 Jan 2024 12:09:53 +0800
From: kernel test robot <lkp@intel.com>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Baoquan He <bhe@redhat.com>
Subject: /tmp/ccGfww2D.s:234: Error: selected processor does not support
 requested special purpose register -- `mrs r1,cpsr'
Message-ID: <202401131221.Hxl4DN46-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   052d534373b7ed33712a63d5e17b2b6cdbce84fd
commit: c41bd2514184d75db087fe4c1221237fb7922875 kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP
date:   4 weeks ago
config: arm-randconfig-003-20240113 (https://download.01.org/0day-ci/archive/20240113/202401131221.Hxl4DN46-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240113/202401131221.Hxl4DN46-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401131221.Hxl4DN46-lkp@intel.com/

All errors (new ones prefixed by >>):

   /tmp/ccGfww2D.s: Assembler messages:
>> /tmp/ccGfww2D.s:234: Error: selected processor does not support requested special purpose register -- `mrs r1,cpsr'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

