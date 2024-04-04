Return-Path: <linux-kernel+bounces-132216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3787289918C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687D61C2327D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39A96FE15;
	Thu,  4 Apr 2024 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8PQ034X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3C6F06B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270657; cv=none; b=WVoTNghUY9lDPcn3GQezehIWDG3KLvYXj2yeKrOxgnPh994hROmfUAJA/UEsZdDMklpHeXBRBGd25VJETRsbB710m53Fxbbg8RtujEtbM7z/WhCCZ2J1qb3Cnk2ZeTDk8infsoa62rzblBR8/KeWe7jChq7z7Dg2vUNAb6W1b00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270657; c=relaxed/simple;
	bh=0ngbjv6beLwMJ1ThBWgiLE9/4VilQrGvrDxrwQ+r6uw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MGsgmDkBFeO9Hk8Hp4XgTNPdlYbEmdXmCOGD4H4YzL4NwfrKQ1MaiT185L3iefzkgm0AJ0pfzUEFvjeS5HZpezf9eunPUvPuibeEe7FmpBdiC3nskgCSTRagkyyf/0ZhPyCif0ChzlPCRyKlDEnoaI7VJroiqd+fu/h6IKE+7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8PQ034X; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712270656; x=1743806656;
  h=date:from:to:cc:subject:message-id;
  bh=0ngbjv6beLwMJ1ThBWgiLE9/4VilQrGvrDxrwQ+r6uw=;
  b=l8PQ034XJ7i8o+7wuB4bQqXFj1KkW9Y2qXZnl9vclciucrGUVDsv5GmX
   7gBXtLGV6p/6VoE1XNJoxhsljqwzNFdIADDCFHmF5yxtwazXvv9wYXmwv
   5wfGqpkNTnlqFD3I7NSEF9lYRWBp+U1QC4M38yTQpRJLG+aqwxmJ2jeYq
   wnalYreNdBhRDOinqGDOsE3LxCV8rn1qhfS0QRsKVHlzWgaseqk5MPgWl
   OGyrBWCv3szRYHn7pvKCjkFTeQfiktvVe7xFIhkszF/XXuJCf+ygRvuGb
   IPcCO7YF26ISz1kdfSbYkOmCUHJ2iNeiVqg72IwcNYdH5PjuLDmOsM+zC
   g==;
X-CSE-ConnectionGUID: EMPqSKWPSpOqyuFeSDU1aw==
X-CSE-MsgGUID: 3xEFioJaRbOVjc3pz/QLhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7717497"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7717497"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 15:44:15 -0700
X-CSE-ConnectionGUID: rLpqYOCnRRSeR0AOpUGM6A==
X-CSE-MsgGUID: v9x7Wo2nQHuT2wwCS29OTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="23426260"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 15:44:14 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsVoZ-0001ao-29;
	Thu, 04 Apr 2024 22:44:11 +0000
Date: Fri, 05 Apr 2024 06:43:34 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/alternatives] BUILD SUCCESS
 4175b45dec4cd8ae4563bf724d591ab5cc0ad9ce
Message-ID: <202404050632.Cl9QLEXO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
branch HEAD: 4175b45dec4cd8ae4563bf724d591ab5cc0ad9ce  x86/alternatives: Catch late X86_FEATURE modifiers

elapsed time: 737m

configs tested: 52
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240404   gcc  
i386         buildonly-randconfig-002-20240404   clang
i386         buildonly-randconfig-003-20240404   clang
i386         buildonly-randconfig-004-20240404   gcc  
i386         buildonly-randconfig-005-20240404   clang
i386         buildonly-randconfig-006-20240404   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240404   gcc  
i386                  randconfig-002-20240404   clang
i386                  randconfig-003-20240404   clang
i386                  randconfig-004-20240404   gcc  
i386                  randconfig-005-20240404   clang
i386                  randconfig-006-20240404   clang
i386                  randconfig-011-20240404   gcc  
i386                  randconfig-012-20240404   clang
i386                  randconfig-013-20240404   gcc  
i386                  randconfig-014-20240404   clang
i386                  randconfig-015-20240404   gcc  
i386                  randconfig-016-20240404   gcc  
um                               allyesconfig   gcc  
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240405   clang
x86_64       buildonly-randconfig-002-20240405   clang
x86_64       buildonly-randconfig-003-20240405   gcc  
x86_64       buildonly-randconfig-004-20240405   gcc  
x86_64       buildonly-randconfig-005-20240405   clang
x86_64       buildonly-randconfig-006-20240405   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240405   clang
x86_64                randconfig-002-20240405   clang
x86_64                randconfig-003-20240405   clang
x86_64                randconfig-004-20240405   gcc  
x86_64                randconfig-005-20240405   clang
x86_64                randconfig-006-20240405   gcc  
x86_64                randconfig-011-20240405   clang
x86_64                randconfig-012-20240405   gcc  
x86_64                randconfig-013-20240405   gcc  
x86_64                randconfig-014-20240405   clang
x86_64                randconfig-015-20240405   gcc  
x86_64                randconfig-016-20240405   gcc  
x86_64                randconfig-071-20240405   gcc  
x86_64                randconfig-072-20240405   gcc  
x86_64                randconfig-073-20240405   gcc  
x86_64                randconfig-074-20240405   gcc  
x86_64                randconfig-075-20240405   gcc  
x86_64                randconfig-076-20240405   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

