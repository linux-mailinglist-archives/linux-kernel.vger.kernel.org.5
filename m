Return-Path: <linux-kernel+bounces-163065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4388B6477
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1191C21517
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F06181CF1;
	Mon, 29 Apr 2024 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPBroeAG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A1181332
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425602; cv=none; b=Wa8SWAs7xbcWb8QVVbnOoQBx/u2EY97QZCeeg28MuWcrFFaJm+rh8ixmwKC70ui9oSV7uPp5neAn/F9dazZDa+K/Kdcw7/aVcZCenBnP63ANqa5o9CLMi7v40j4am18DouQIL7Hnhv8MbMD4Owe8JreQ1qulkdyHBkXgD7MdA3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425602; c=relaxed/simple;
	bh=7aixiPWAUGT/ZAvZfH65Uhx9mhW9+M/65jQ0Vz/6pQg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GvD2DvX/dNrQ4N2oZL9v6w+QuXm94lolCJgLM0Fy/8UiNQvFsfi2hqLwUK1AfWsEoWSnOHu1sDqhnEIacY7+E3486N5zPprQfFlT4MZndWY1fgtM+OBu+x5OWqiqPrF5jJXuPnIiTueuPGe6TzARG0yLn4FxnhPkj3fIx6yy6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPBroeAG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714425601; x=1745961601;
  h=date:from:to:cc:subject:message-id;
  bh=7aixiPWAUGT/ZAvZfH65Uhx9mhW9+M/65jQ0Vz/6pQg=;
  b=DPBroeAGdF5kgkGV3oxUHCoUpW0b2wF+/dfga3afzJWcBeVgePWrfDSg
   qkhijCcYTF3KHg92QDkXUaUeTeMyUR4SS0JRT3jezHtn2DrPdR4DHP4Kn
   gqoF7Asf9mgnvYZNe91mMurWwnYsoC+ySsjYnWlJFC30oABO+ek7GXiMm
   aSmT5dKImA4QRKUVQd886hTZnB9Y6EW5t3A7Laz1nWd+onMquT7E1I+Fc
   vWopsxtxmmioauYGMJDdcd32KLbNI2nF+hrx3hmKm22Hp4UJcgXk/vCIE
   C405ANf46lSON2O/m8i5ajYaMyHKo2EkOHqL7ClQPRF8mfEUYfymoEPsN
   Q==;
X-CSE-ConnectionGUID: enIC9RaITrGEwgbPrSH+ZA==
X-CSE-MsgGUID: OA/SOhnRSSqBze40w5EaEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="27557755"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="27557755"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 14:20:01 -0700
X-CSE-ConnectionGUID: n8ckxYP+T9KQVXTEOd322g==
X-CSE-MsgGUID: L3yKQvHmSqmNptPeMqOTqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="30877063"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 29 Apr 2024 14:19:59 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1YPl-0007RY-1G;
	Mon, 29 Apr 2024 21:19:57 +0000
Date: Tue, 30 Apr 2024 05:19:55 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 2eda374e883ad297bd9fe575a16c1dc850346075
Message-ID: <202404300552.UPIZdKyy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 2eda374e883ad297bd9fe575a16c1dc850346075  x86/mm: Switch to new Intel CPU model defines

elapsed time: 729m

configs tested: 41
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240429   clang
i386         buildonly-randconfig-002-20240429   clang
i386         buildonly-randconfig-003-20240429   gcc  
i386         buildonly-randconfig-004-20240429   clang
i386         buildonly-randconfig-005-20240429   gcc  
i386         buildonly-randconfig-006-20240429   clang
i386                                defconfig   clang
i386                  randconfig-001-20240429   clang
i386                  randconfig-002-20240429   clang
i386                  randconfig-003-20240429   clang
i386                  randconfig-004-20240429   clang
i386                  randconfig-005-20240429   gcc  
i386                  randconfig-006-20240429   clang
i386                  randconfig-011-20240429   gcc  
i386                  randconfig-012-20240429   gcc  
i386                  randconfig-013-20240429   clang
i386                  randconfig-014-20240429   gcc  
i386                  randconfig-015-20240429   clang
i386                  randconfig-016-20240429   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240429   clang
x86_64       buildonly-randconfig-002-20240429   gcc  
x86_64       buildonly-randconfig-003-20240429   clang
x86_64       buildonly-randconfig-004-20240429   gcc  
x86_64       buildonly-randconfig-005-20240429   clang
x86_64       buildonly-randconfig-006-20240429   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240429   clang
x86_64                randconfig-002-20240429   gcc  
x86_64                randconfig-003-20240429   clang
x86_64                randconfig-004-20240429   gcc  
x86_64                randconfig-005-20240429   clang
x86_64                randconfig-006-20240429   gcc  
x86_64                randconfig-011-20240429   gcc  
x86_64                randconfig-012-20240429   gcc  
x86_64                randconfig-013-20240429   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

