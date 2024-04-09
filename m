Return-Path: <linux-kernel+bounces-136126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA1989D04E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AFC283FFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34A4F5FA;
	Tue,  9 Apr 2024 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYos4gYH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF94F1E2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629037; cv=none; b=HSIpcHFm/9LFrW9J9XiHqweQCJWSKGa+l+H2HxjxN4MYU5B2kYUH2sh8cjVClGSBYWAIDHAsOzjeUdgcnbM5Xlt6BJXlN5rcuEP+9blLvvRx5aPkCRn2A4zMvHW0VZVXdlmT787tUHfdIeOAm3dwKcqd2CiRnenKxxUVKFN5pU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629037; c=relaxed/simple;
	bh=UxX5KRwDRVfqoVh4ST7w5DTPG742TYox9063YHVVErA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YMeENz9tVE6OxF2HlOSF2sGW5/Dtin6AaTFhWUoMEglnY3Ym26IsnSWNviQPd6Xcn5EGdDWow6+n6lE7Yg5oqlqjkesweZ+GDPkdPsMbHkWTWtTL6f0SyaI3kENcGKKrPeuoit7V30/sexmYVN0gYRcmiONe4iFcwAPGLv2h73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYos4gYH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712629036; x=1744165036;
  h=date:from:to:cc:subject:message-id;
  bh=UxX5KRwDRVfqoVh4ST7w5DTPG742TYox9063YHVVErA=;
  b=mYos4gYHqzdepItakDPJIgQWCvC+c6uZL4um5dQfgPKzu4ngHF512AP3
   +4Uu6HBNUA9phHHWxAsjjIWWDYWoazC0c0Mi9D6BYSTRBGZlX/uBY+/+D
   FI+pCLjjuuVBigoPsclhhk1QBGrCa7QRXHA7WYkemBVk1wl3lqt91Qf2+
   qWNpib8Ovp+Fa2Tm+31efcN2Ei5NQrEofEGFEMYSdNlegaNYNxhijIbOI
   EcxnfAa52j8u5rb8Qr9Bay1zXe1YrxV7Os3x55sVI75G/qE+Ml+b7QV+1
   GEN1C/E+iilNLXrVjtZ9oPBrF8wv+2I9OyR/ccJz3nNp7kZOgxkAKQNX1
   w==;
X-CSE-ConnectionGUID: IlWacbXcS2OpUr3RsS2LJA==
X-CSE-MsgGUID: +gc0PmGPS6SJLifdcctEXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7802966"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="7802966"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 19:17:16 -0700
X-CSE-ConnectionGUID: 7C2ihBw/TB+QGbHpzYzrLQ==
X-CSE-MsgGUID: s6l2xcHzRMqO6RrUwF2JIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="43272646"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Apr 2024 19:17:14 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ru12u-0005d2-02;
	Tue, 09 Apr 2024 02:17:12 +0000
Date: Tue, 09 Apr 2024 10:16:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 e0ca9353a86c0459a9c3fc8d65f7c88e96217cea
Message-ID: <202404091023.n67kyuI2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: e0ca9353a86c0459a9c3fc8d65f7c88e96217cea  x86/math-emu: Fix function cast warnings

elapsed time: 726m

configs tested: 16
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240409   clang
i386         buildonly-randconfig-002-20240409   clang
i386         buildonly-randconfig-003-20240409   gcc  
i386         buildonly-randconfig-004-20240409   clang
i386         buildonly-randconfig-005-20240409   gcc  
i386         buildonly-randconfig-006-20240409   gcc  
i386                                defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

