Return-Path: <linux-kernel+bounces-163196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABDE8B670E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079B71C22D16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FAE1843;
	Tue, 30 Apr 2024 00:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOuMG4wU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050A161
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438305; cv=none; b=Vu8AfS7owKCBWCSxmyQuSF/lQd6cOCAoFqB79uZoseb21lXfumpzPOkbmeIKgIvPlDoLEtDyxY1iMQMHXyrPdx2sv9TiCqq42umwjAIegtRfgxGTsRNosUhywrPag3s4CQt5AF2h92zmIMzfk0KRNu4RniroHPgPuXhhgerPM2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438305; c=relaxed/simple;
	bh=MCOGDhitvdT1hfFurhCMW9UzDeMZrOgdNKty3OtV4BY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jap4J58UZDMAb9vGMRW9vDXyI1PGqY9bPcimcElK/zr0ySHNd/mzcGetv0ZMQUs7fhgbUJ0qvOfcvXRResFJAjx72RPFA696b4tSPQ6hTyHviy0J1RUUpf27LwcjyeW+6iTl3dn+Eg2kSKn18ddwEdm/Koj30Yeh6JnffljhtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOuMG4wU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714438304; x=1745974304;
  h=date:from:to:cc:subject:message-id;
  bh=MCOGDhitvdT1hfFurhCMW9UzDeMZrOgdNKty3OtV4BY=;
  b=EOuMG4wUJJLF/O8QRk2WwuroJUyuheMEnl4beOmlRPMuAZ+YNGVyITam
   Jqe/2FGQk5wi6s6/4iypX5zLCw6WwfZI1WalR8P9BiPbsAJVD0Tvoj6t4
   UmLTCfS85qwrH1Fr1aKNYlD8jdwAK+8GpHcEIocIjpwOej7B3F6aQwXwT
   aA2vpZQs/BUpEjLpOpFbP8lOJT7ZmTPE6o0se/fuck0MjV/EeUd/RAs/j
   PuOVXNhT53ssTzEvvMcicU+VXRZGr28fHggWD3CG/EoZU8FXfcXtc5K1s
   T4KEiu3xbfps4mWAMVJHZR3xX45qGcYqi9DThqXulrJmdiG2kz3+EHKHL
   w==;
X-CSE-ConnectionGUID: CtKCLpMOTv+n4ad4/qXzOw==
X-CSE-MsgGUID: PO42zZCMQJef6ZpSC2Br2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10658851"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10658851"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 17:51:43 -0700
X-CSE-ConnectionGUID: ULsO2KBdQ/KI8U7MqOcb2g==
X-CSE-MsgGUID: s155DH5QS5WMIzlf1I+srQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="31081054"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 29 Apr 2024 17:51:43 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1bid-0007Z9-1s;
	Tue, 30 Apr 2024 00:51:39 +0000
Date: Tue, 30 Apr 2024 08:51:15 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 1e1dd773644e9de88f54386f7147c1068375fc75
Message-ID: <202404300812.NKhVfmmj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 1e1dd773644e9de88f54386f7147c1068375fc75  x86/apic: Don't access the APIC when disabling X2APIC

elapsed time: 730m

configs tested: 26
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240430   gcc  
i386         buildonly-randconfig-002-20240430   clang
i386         buildonly-randconfig-003-20240430   gcc  
i386         buildonly-randconfig-004-20240430   clang
i386         buildonly-randconfig-005-20240430   clang
i386         buildonly-randconfig-006-20240430   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240430   clang
i386                  randconfig-002-20240430   gcc  
i386                  randconfig-003-20240430   gcc  
i386                  randconfig-004-20240430   gcc  
i386                  randconfig-005-20240430   gcc  
i386                  randconfig-006-20240430   gcc  
i386                  randconfig-011-20240430   gcc  
i386                  randconfig-012-20240430   clang
i386                  randconfig-013-20240430   clang
i386                  randconfig-014-20240430   gcc  
i386                  randconfig-015-20240430   gcc  
i386                  randconfig-016-20240430   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

