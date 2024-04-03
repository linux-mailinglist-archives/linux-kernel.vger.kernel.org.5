Return-Path: <linux-kernel+bounces-130506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F47189790A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D883E1F23044
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239CD15530D;
	Wed,  3 Apr 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exdIW46q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05741E519
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172854; cv=none; b=fcItzIFcZJNt8OSAltxVEM61OW4SuonNY93/IY8V48WJe5bJMT5nstXAJk2MuD6pR7ZG5bau6d2U1JddTEhj/jYQ7wVMLhJRA7etQeCX0RlfrA0TLXulUOGvOIJeOmsr3RLnJ308LQOxHTHlQk4zU2b5Ef+D/E8c4cukXFwdIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172854; c=relaxed/simple;
	bh=NYraq4Hm/B7YIP1pPFN0TOVz+G+ZMeDDCt3jVjFKKFo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P/lNgUIt5bQxN7Al3g4yYp9A+lzaYhlfAWeKkWO/gBZ5jaqp1ta3Wc6kwZi0oJURm5k3smevDkE+ndsjpokcve6IlV7D2kKyGnXxI0w0xsmfHj0dHI4xyzgxmQ7PYfr8cFekfxtC3nXocnVsst2fBpI7cRtP2V1Dv5U80VcVZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exdIW46q; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712172852; x=1743708852;
  h=date:from:to:cc:subject:message-id;
  bh=NYraq4Hm/B7YIP1pPFN0TOVz+G+ZMeDDCt3jVjFKKFo=;
  b=exdIW46q1X8Suv+2jaxfNt7jhD2dvEEsQ9vV4x/PkeHP/Qw70jK2fikI
   d+vYHvgaTQm1C6Q4mgtN2kRrqwQBfAK+AhjIaA/+yup1SLR450WbgEpjU
   q35C7J1KEWmkYoY0iKyOcpYIEmGlEjxF5+clK3IBSzvPagWvQWIERLWCm
   ot43tRwWmzRdy8ir5qeMLFaMvF94xevw5W/xOjt9CFmmyuI+2JS1N5ypL
   D1v7ln0VkjEEtifrWoo20FywISROLjN0ofvzmO7dJEV5GE0GJAvTqPf/3
   kP0R2JdtAMhYnoUla4OcnhZY4ZJXfuM2n668Ks/g431J3yuBJ2LGMiEAT
   Q==;
X-CSE-ConnectionGUID: /fPXBkkCTrSxmzBDev54VQ==
X-CSE-MsgGUID: 7CoeUe3rRx+sl22croUcJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="24935081"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="24935081"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 12:34:12 -0700
X-CSE-ConnectionGUID: CPQOG+OCScWWzft7YIm3Ag==
X-CSE-MsgGUID: vfDxQ2DYTeCAO7wfApSQ3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18973430"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 03 Apr 2024 12:34:11 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rs6N6-0000AY-2V;
	Wed, 03 Apr 2024 19:34:08 +0000
Date: Thu, 04 Apr 2024 03:33:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/percpu] BUILD SUCCESS
 9ebe5500d4b25ee4cde04eec59a6764361a60709
Message-ID: <202404040323.kmTTx6Ki-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/percpu
branch HEAD: 9ebe5500d4b25ee4cde04eec59a6764361a60709  x86/percpu: Re-enable named address spaces with sanitizers for GCC 13.3+

elapsed time: 731m

configs tested: 50
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
x86_64       buildonly-randconfig-001-20240403   gcc  
x86_64       buildonly-randconfig-002-20240403   gcc  
x86_64       buildonly-randconfig-003-20240403   clang
x86_64       buildonly-randconfig-004-20240403   gcc  
x86_64       buildonly-randconfig-005-20240403   clang
x86_64       buildonly-randconfig-006-20240403   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240403   gcc  
x86_64                randconfig-002-20240403   clang
x86_64                randconfig-003-20240403   gcc  
x86_64                randconfig-004-20240403   gcc  
x86_64                randconfig-005-20240403   gcc  
x86_64                randconfig-006-20240403   clang
x86_64                randconfig-011-20240403   gcc  
x86_64                randconfig-012-20240403   gcc  
x86_64                randconfig-013-20240403   gcc  
x86_64                randconfig-014-20240403   gcc  
x86_64                randconfig-015-20240403   gcc  
x86_64                randconfig-016-20240403   gcc  
x86_64                randconfig-071-20240403   clang
x86_64                randconfig-072-20240403   gcc  
x86_64                randconfig-073-20240403   clang
x86_64                randconfig-074-20240403   gcc  
x86_64                randconfig-075-20240403   gcc  
x86_64                randconfig-076-20240403   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

