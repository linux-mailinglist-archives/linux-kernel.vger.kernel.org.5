Return-Path: <linux-kernel+bounces-139109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3243289FEB2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47276B286FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF51617F375;
	Wed, 10 Apr 2024 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mk302nIC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC0617BB2B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770533; cv=none; b=jM+Q9zYNvu1IQM7xfiUyfdIrdb29bROvLnjD6f52ThqWmZ/2PWu/jyJTUDewaaDyol2SmAgTCsfn0HNe/Mx8oncV7ci2RXRFrmjeJJ4z17UgByRAtj+x5C36w5pEcoNh7+lbJDr/6HsvGAJ9ROk+SxTckbbytSlrM7X5WEs3kLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770533; c=relaxed/simple;
	bh=kSsnprb5ot5xTSzm+63wz6uK88AXMiaUB1TKq2hEgyw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e7zL5MrzYC6lRafdRC2pCjnGsdoeu7KVIC3Qd3sBbkfdfCXEe+ahUWFPrIBxaPmuwV/dN9wU7442u8Ul/LP/5LaorSLtAewWwqtY5ya7hsBItoylEifDEVgaF+0FVgziw3o8vn4+WF6zKQtjCUiwg4DbT4T8Jg1sdJWIWoXflK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mk302nIC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712770531; x=1744306531;
  h=date:from:to:cc:subject:message-id;
  bh=kSsnprb5ot5xTSzm+63wz6uK88AXMiaUB1TKq2hEgyw=;
  b=mk302nICNKEf7Svw6PdO1fQtYCilnvGlaPyp4OzQ6IkAYnP1ll6T+bfe
   Rz51yvdndRon+j8oYVRO4MtMVc5DRvSUNlOSyCLqmBJZVqUnB1OLhOnH4
   ISk5ZBdRjZhhIQVXnlGEpesxe8qXEc0ChrapCPbF48Y368NDQkl6cw25m
   fRDdMitgkQLuCB5PC2NjIuatih5AYspToieAvSokTEux747g9hXTWLTib
   FFxk914wQbKKDkjWejf3XJhX0TnLeI9fPTqrrZXah5VFN8baoY/Mms/IE
   u5DQq+ZO5Hyg4Tb/TlHnfcqqsBp/2cW9Lz2/YNMGJGqLj4uAVtxgNi/HP
   Q==;
X-CSE-ConnectionGUID: rZfHn7vZSBC2Xsw+Q3XFxw==
X-CSE-MsgGUID: MHZUC78wQY2iaqpOzTKuaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8007388"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8007388"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 10:35:21 -0700
X-CSE-ConnectionGUID: tFgysQJURzOd0fWhE0tFog==
X-CSE-MsgGUID: NygBX2pXR6mnu/Jy7K+pwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="21062382"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Apr 2024 10:35:21 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rubqv-0007dh-2d;
	Wed, 10 Apr 2024 17:35:17 +0000
Date: Thu, 11 Apr 2024 01:34:24 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 dec8ced871e17eea46f097542dd074d022be4bd1
Message-ID: <202404110122.jhn2oyMn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/urgent
branch HEAD: dec8ced871e17eea46f097542dd074d022be4bd1  perf/x86: Fix out of range data

elapsed time: 737m

configs tested: 26
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240410   gcc  
i386         buildonly-randconfig-002-20240410   clang
i386         buildonly-randconfig-003-20240410   clang
i386         buildonly-randconfig-004-20240410   clang
i386         buildonly-randconfig-005-20240410   gcc  
i386         buildonly-randconfig-006-20240410   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240410   clang
i386                  randconfig-002-20240410   clang
i386                  randconfig-003-20240410   gcc  
i386                  randconfig-004-20240410   gcc  
i386                  randconfig-005-20240410   gcc  
i386                  randconfig-006-20240410   clang
i386                  randconfig-011-20240410   clang
i386                  randconfig-012-20240410   clang
i386                  randconfig-013-20240410   gcc  
i386                  randconfig-014-20240410   clang
i386                  randconfig-015-20240410   gcc  
i386                  randconfig-016-20240410   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

