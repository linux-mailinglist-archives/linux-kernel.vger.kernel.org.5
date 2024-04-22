Return-Path: <linux-kernel+bounces-152736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97208AC39B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178C01C2120C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7798E179AA;
	Mon, 22 Apr 2024 05:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rrn3TRY2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14E118E1F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 05:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763440; cv=none; b=DXkprm9KkvDIZuNaUHvXZIfSxYxdig4X0DpT3lBLVsuBNKlsnewsVnwo2M5mO5v/p9cwni5JXqFR34EgnGs/INHfHUBe3dk43cKbQXqwiURkjRsrrcaNDIJHGIJgGAzvlFzKjhsOHzdMF7J7Ti7ZJwVNmRidPsCMK1QnbqgNtsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763440; c=relaxed/simple;
	bh=ws8ghrScDQH/cHrr4yJgWATvJicvs5lwl7kWzUMqkIs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uf8CW+KHoAn/3dWSn7Z97ukSctPVAEsa6I03ToxZZvPClhCs0h3ry5zfVop+c3RJZg6rUu91O+ZP86isgxrwx4spmFylUNtlmKUaCzWOP1IJvZ9FLS1NCeemTVqQgolyiPmGoKqaUFWdGo879yO2hL5x1jZz+pBTDye7ZINp7C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rrn3TRY2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713763439; x=1745299439;
  h=date:from:to:cc:subject:message-id;
  bh=ws8ghrScDQH/cHrr4yJgWATvJicvs5lwl7kWzUMqkIs=;
  b=Rrn3TRY2jZPprzIlRcy/bBaB0UDiPnKcjJ3YpILScz+cWJwuaJafQNyX
   D923N8x9emOguti8KHFKBt8klK57DmWnJ2ss1hlSueWLfE76ugf36tlMx
   Sd+DCUCSdZmC1F7purHaTDKuIRSRmExGAn5sVxGPWDPltJJ3F6ivoaicP
   BAJoS1I8CAV6OppOirSxXRJ6GN2UEMG5CXo12pwGFEFEY5jrtN7LNDGuV
   ted0l/NwIWdB3bYat4wYKUzFaIPFv3riTxmLUHutRoB/Hz+WFx+Ib/n41
   uG5S4ZThYPiqQ3q9pK3OQJS5yYO9VaQ6gSFi3qnYKwToaZzpycDL5d/VM
   g==;
X-CSE-ConnectionGUID: JvfQVhy9TLaqWewZBJIUhw==
X-CSE-MsgGUID: x+6VFXRATTK+JErLdCO5Uw==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="19978070"
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="19978070"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 22:23:58 -0700
X-CSE-ConnectionGUID: YAxhs0M/TrmCDd7HuFZK2w==
X-CSE-MsgGUID: XMULCfX2SVK67P8FGrsi9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,219,1708416000"; 
   d="scan'208";a="23880185"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 21 Apr 2024 22:23:57 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rym9i-000CKY-10;
	Mon, 22 Apr 2024 05:23:54 +0000
Date: Mon, 22 Apr 2024 13:23:53 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 71d99ea47fbd3179e01f8037aad1d1367a821de2
Message-ID: <202404221351.yh9bJe2z-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: 71d99ea47fbd3179e01f8037aad1d1367a821de2  x86/Kconfig: Merge the two CONFIG_X86_EXTENDED_PLATFORM entries

elapsed time: 722m

configs tested: 50
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240422   clang
i386         buildonly-randconfig-002-20240422   gcc  
i386         buildonly-randconfig-003-20240422   clang
i386         buildonly-randconfig-004-20240422   gcc  
i386         buildonly-randconfig-005-20240422   gcc  
i386         buildonly-randconfig-006-20240422   clang
i386                                defconfig   clang
i386                  randconfig-001-20240422   clang
i386                  randconfig-002-20240422   clang
i386                  randconfig-003-20240422   gcc  
i386                  randconfig-004-20240422   clang
i386                  randconfig-005-20240422   gcc  
i386                  randconfig-006-20240422   gcc  
i386                  randconfig-011-20240422   clang
i386                  randconfig-012-20240422   clang
i386                  randconfig-013-20240422   clang
i386                  randconfig-014-20240422   clang
i386                  randconfig-015-20240422   clang
i386                  randconfig-016-20240422   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240422   clang
x86_64       buildonly-randconfig-002-20240422   gcc  
x86_64       buildonly-randconfig-003-20240422   gcc  
x86_64       buildonly-randconfig-004-20240422   clang
x86_64       buildonly-randconfig-005-20240422   gcc  
x86_64       buildonly-randconfig-006-20240422   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240422   clang
x86_64                randconfig-002-20240422   gcc  
x86_64                randconfig-003-20240422   clang
x86_64                randconfig-004-20240422   gcc  
x86_64                randconfig-005-20240422   gcc  
x86_64                randconfig-006-20240422   clang
x86_64                randconfig-011-20240422   gcc  
x86_64                randconfig-012-20240422   clang
x86_64                randconfig-013-20240422   gcc  
x86_64                randconfig-014-20240422   clang
x86_64                randconfig-015-20240422   gcc  
x86_64                randconfig-016-20240422   gcc  
x86_64                randconfig-071-20240422   clang
x86_64                randconfig-072-20240422   gcc  
x86_64                randconfig-073-20240422   gcc  
x86_64                randconfig-074-20240422   gcc  
x86_64                randconfig-075-20240422   gcc  
x86_64                randconfig-076-20240422   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

