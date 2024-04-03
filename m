Return-Path: <linux-kernel+bounces-130483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 910BC8978C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3083F1F283E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA159154BE3;
	Wed,  3 Apr 2024 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YorW5imp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F51D54B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171054; cv=none; b=disD+z92dxp2tw//zTdDJmUUFRFEHX2QheMcqTrpoJkP4FkkpHC861ExHmyYA0yVZN3FgNMO96p6NVRFeYUsD5XJd4OmadZqkBfHyCMP4UT+VTJBmw/ig1TyxcZpRsIz6Y89yLnZ98B1oj7oXR0r/Vc2KA2QYnJSZe00EjQEmnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171054; c=relaxed/simple;
	bh=PBPBhv2Tv4g2AyXREUb3Ywt0eu/nJrDMAD4EQlyciec=;
	h=Date:From:To:Cc:Subject:Message-ID; b=rPNeqShOtJYko1sKcqQYX8hWJaA6Daby99mkwP05NsG1lGflO6KFLZ02zRn9tkNwCmh4Bwga4YoPxltaP0sEb2UpsK5agl5gVpp8uCFod2QhRME/qownzmC4I0teDA3UBmTiNA2J2427KTXvxbGb9+gEAAYRElhFYFwd21fh9jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YorW5imp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712171053; x=1743707053;
  h=date:from:to:cc:subject:message-id;
  bh=PBPBhv2Tv4g2AyXREUb3Ywt0eu/nJrDMAD4EQlyciec=;
  b=YorW5imp9swK7xCI5EC1zYE9Q5XZ9aHFt3gZJTqHw+Q4/O4ZmBVK3AnI
   1jBUSjFulRYStaPuo+l52Anu2FpOkLpMrYoJaaADfxW8bBwF34AGzRlWS
   UU1tpchwYdItL8nFyVTZxM2KhWSE/pztvjwX4YR03hoKtS5uFeqx5xiyK
   6rO10jZ4/OqkJt8u2vML2mWghds1OAYz2154tLrDAsNqb0ByCJfwopqOX
   dqosU3M5wkNd3gsUIpprkm1qmFU3h6Lyjz/T4eXctg92uFHjLva47NZpc
   ocCUoSHhSjsVo3bKDTZddzP2w/UllH6tzSarxxYgR7c95g1iRwZiroPiQ
   A==;
X-CSE-ConnectionGUID: 22M6rLBPRwiUhuCHiRAcCA==
X-CSE-MsgGUID: 9YaTzNANTDGiFynapagDmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7540133"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7540133"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 12:04:12 -0700
X-CSE-ConnectionGUID: A5dJYbiiRaegsrIgI1I2Ig==
X-CSE-MsgGUID: ZgT1ibioSs+HL8Te1s7XXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="23293635"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Apr 2024 12:04:11 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rs5u4-00009Y-0c;
	Wed, 03 Apr 2024 19:04:08 +0000
Date: Thu, 04 Apr 2024 03:03:09 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 f87136c05714836f1b659365443caccc1bbfce2d
Message-ID: <202404040307.0axrLlZn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: f87136c05714836f1b659365443caccc1bbfce2d  x86/of: Change x86_dtb_parse_smp_config() to static

elapsed time: 731m

configs tested: 49
configs skipped: 135

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

