Return-Path: <linux-kernel+bounces-139638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8F48A05A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E79B1F22A98
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C7F626CB;
	Thu, 11 Apr 2024 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfVJ55Ja"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5713362147
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 01:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712799663; cv=none; b=UYmWvfbHl4J2sTWsy/T1EEvuB5b1uVIv7uWzz1BeG3DNesBc1cbkoEGNmfQ5MZUV/EJpn5CYL7JPsyHoQRL1eHmvu73ciHKPT6D2XjvxXEi9OsGSshtVGpIZ7FJJ+him3fDlxDCKa7jhV5EQkoyMrV5BaEddWGXcseFYq+1bLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712799663; c=relaxed/simple;
	bh=FGAA23fwz/WwvlZ+U9Sfg0S3aK2pVO+ut0dhhQJQv5c=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hfqxZ4UeJQsADOSn9VOA3j1G02Uq5/ca6MYHj8sVsHpiJYoQXo186muMN3YZGxK4FLv9lHVIbqhmTY8fHu/Z9iyaFVpvm0UBCS19B8SCYLM+kv8ANn627nFrVphKwCr4iFCo8T4sH8fVPMttaRTocguOJr/NbIGvOwflhxHiP3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfVJ55Ja; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712799661; x=1744335661;
  h=date:from:to:cc:subject:message-id;
  bh=FGAA23fwz/WwvlZ+U9Sfg0S3aK2pVO+ut0dhhQJQv5c=;
  b=XfVJ55Jaz9shyk8nf8hwc5gPKb14pXD3FeoyOgIp7F4zbByxkR7U1Ae+
   E8us9Bs62px14WBsuMRQ58Yn5KMllvaTFXpxEIMQK5XmO/vKX57FdEg5d
   3IXdnwf15ni0W5rZ6n/EJihm/sxIhb3jTrhUSr+2nmj0Vl5fgeoMtiGyA
   rWN6UeODNPtNyF8Fiy5pemwblAjib7ymlh/JXFU4BrB86pER4+J5+Mwc+
   LLyP2gNYOie0AqNULo5NjXrsyqVDqnf6lUsbs3pUtcMIJF2LWOjvxDeZv
   DqaSMsd67jfxQXbBIUuysQAfxSaXxyylTqRgaNTh8FIuHgSOJ0FHKDHXP
   w==;
X-CSE-ConnectionGUID: k6kizcdSQmuiV5JcDjR2Mg==
X-CSE-MsgGUID: m7ErUsKTRT+/AN3Q9HcrxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8369329"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8369329"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 18:41:00 -0700
X-CSE-ConnectionGUID: GkUKEn5dTASjgiDQpXOX1A==
X-CSE-MsgGUID: KF2v78pJSGSHMJwma2seRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="25519110"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Apr 2024 18:40:59 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rujQv-00084o-0G;
	Thu, 11 Apr 2024 01:40:57 +0000
Date: Thu, 11 Apr 2024 09:40:13 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 801549ed6abe7586eb9ad0cf7147b0bef383ad22
Message-ID: <202404110911.CVVe5R0d-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/platform
branch HEAD: 801549ed6abe7586eb9ad0cf7147b0bef383ad22  x86/platform/olpc-xo1-sci: Convert to platform remove callback returning void

elapsed time: 737m

configs tested: 26
configs skipped: 132

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240411   clang
i386         buildonly-randconfig-002-20240411   clang
i386         buildonly-randconfig-003-20240411   clang
i386         buildonly-randconfig-004-20240411   clang
i386         buildonly-randconfig-005-20240411   clang
i386         buildonly-randconfig-006-20240411   clang
i386                                defconfig   clang
i386                  randconfig-001-20240411   gcc  
i386                  randconfig-002-20240411   gcc  
i386                  randconfig-003-20240411   clang
i386                  randconfig-004-20240411   clang
i386                  randconfig-005-20240411   gcc  
i386                  randconfig-006-20240411   clang
i386                  randconfig-011-20240411   clang
i386                  randconfig-012-20240411   gcc  
i386                  randconfig-013-20240411   gcc  
i386                  randconfig-014-20240411   gcc  
i386                  randconfig-015-20240411   clang
i386                  randconfig-016-20240411   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

