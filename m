Return-Path: <linux-kernel+bounces-130532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AD589797B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E964A1C2658B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9089015573C;
	Wed,  3 Apr 2024 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcgaR7Nz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306A1553BE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174594; cv=none; b=IX46UoZUXJieU9c58fw2Xf1b9HwiYqN1xabMJ3WEp+0n5NhbzaFA+jmvtxy4MOiOxEagDGFcDiIwwP1k6XwqR1cN8Qr2xdmd+hEfmoEMDqb+XUNaifvjrMLeG18i6pxYMdN01oIS4PRHfUy3ne20dd6WvdTEyl431a6dUR0Vai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174594; c=relaxed/simple;
	bh=eN0BMPJt/yzNeLJkwA6M2eqVeuPw0vmnY2kBYFQl+YE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hzZrE9dLrJ9165+0lNXa4mbe8QX0RcTNGYY9UmNOHzfp8rZy84DrcoDfKvI8LWUToZQvKvbT52QNM+CoYfg587El4uSytoS9Yom7gZ0PSpswzqLQV8YbnWo+OoMPWwNpdPQ1ZaK9KqaRNSUU1kIXD0SdgFiuwMyHYKJhq21UyWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcgaR7Nz; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712174593; x=1743710593;
  h=date:from:to:cc:subject:message-id;
  bh=eN0BMPJt/yzNeLJkwA6M2eqVeuPw0vmnY2kBYFQl+YE=;
  b=KcgaR7NzDCgMyqnDlKOQ6lJ/HLXCvU9D71XTBHrdTFtnPNi+3/rUyyHL
   lHDblGiNtQCBbyH9fZ4HtOKtrBYs5iPx2Ddzcmvf1evhbRAukW2+wlQ/c
   7ZklAhEO8aHj1H7nJh2lJQbzKuGfnpKk3nkinte0N/GuYAlQNS7+QueHa
   eRcdLJrQGWDhPZ6PnF2UcZFckpoxfvqJp1GZnNLX0DNUR98ImNfZLhLsf
   nFAXiP71MKONqQD3+z78su8N8tgQMKzvGRBMh5Yo//pnIZS7XDRYVc9/E
   RmC1gRDqZVpDmye6oaGXGPliJTaj0uDIHcW8x7E58VG48qs2klq9flN+Z
   w==;
X-CSE-ConnectionGUID: 2g1QrUJnSwORsA2xTBzESw==
X-CSE-MsgGUID: 1Wo//m9aRBWDqdaccukRsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7544435"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7544435"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:03:13 -0700
X-CSE-ConnectionGUID: Rr0clMBCSAya6FYE9/ccDg==
X-CSE-MsgGUID: zgkS5qy9Rq2Uy0LQQhXfzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18395852"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 03 Apr 2024 13:03:12 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rs6pB-0000BP-0e;
	Wed, 03 Apr 2024 20:03:09 +0000
Date: Thu, 04 Apr 2024 04:02:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 c3eeb1ffc6a88af9b002e22be0f70851759be03a
Message-ID: <202404040433.FCLrieoq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: c3eeb1ffc6a88af9b002e22be0f70851759be03a  x86/resctrl: Fix uninitialized memory read when last CPU of domain goes offline

elapsed time: 730m

configs tested: 31
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240403   gcc  
i386         buildonly-randconfig-002-20240403   clang
i386         buildonly-randconfig-003-20240403   clang
i386         buildonly-randconfig-004-20240403   clang
i386         buildonly-randconfig-005-20240403   gcc  
i386         buildonly-randconfig-006-20240403   clang
i386                                defconfig   clang
i386                  randconfig-001-20240403   gcc  
i386                  randconfig-002-20240403   clang
i386                  randconfig-003-20240403   gcc  
i386                  randconfig-004-20240403   gcc  
i386                  randconfig-005-20240403   clang
i386                  randconfig-006-20240403   gcc  
i386                  randconfig-011-20240403   gcc  
i386                  randconfig-012-20240403   clang
i386                  randconfig-013-20240403   gcc  
i386                  randconfig-014-20240403   clang
i386                  randconfig-015-20240403   gcc  
i386                  randconfig-016-20240403   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240404   gcc  
x86_64       buildonly-randconfig-002-20240404   gcc  
x86_64       buildonly-randconfig-003-20240404   gcc  
x86_64       buildonly-randconfig-004-20240404   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

