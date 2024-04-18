Return-Path: <linux-kernel+bounces-149505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FB98A921F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC30B1C20DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9504EB46;
	Thu, 18 Apr 2024 04:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="It6sVej3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB151E532
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713415753; cv=none; b=VGlk+LdPP00kVRhh5dpekcaHGDbJqGyvfP2RtCTciaXSj2TNaOZBP8LKxaUKp7KV7vWDjT2/K9M6iA5H1J/fMJw+XbCsHRENBlMMfK6q3wc8ScvTVClDY3cPAwtZju85ytS3RrzKNq/dMLmE5b4UAyAIGzIHSic7xFJ8fR6UXlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713415753; c=relaxed/simple;
	bh=GcuaDwxNQlf9a68JAYJnsbKDA8MYj1nqLrP2pTsfdVs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MeC6Xp9mE+FqcxKJtNlKeNPX4EJLRKMXOmrS8OdX18Kbg2i7Ep4i2Sqg0VZBIH0FaZm1nB92MQYzBR4V/yH4eO9RkzFNNcBDTaP0v3oUG/Imkvztsjobr3n/DUl8CTlBc98EZpY6a6Ed+diOdsvwPHFyJ5GTHlY2ql4Icb/f7Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=It6sVej3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713415751; x=1744951751;
  h=date:from:to:cc:subject:message-id;
  bh=GcuaDwxNQlf9a68JAYJnsbKDA8MYj1nqLrP2pTsfdVs=;
  b=It6sVej3DVCxNUtCpc6ZOWsLQwkqD6Atq0NFvxWG/yaOHV2LuCJogcze
   vZb24EEug2Z/OKSP/kyx/wBKjS31ZAgbSTDPQBhN94Efq7sPXB1/GQqsw
   jc7CKvJIUutfpWEp0sue2eYMxLtZ7bDfE3GHQ30PiWl01IIbSEGWFPV/0
   vXvzKrQp2dtvBN5E2wJ1BI5yfEr+5BGwamA3Kp6GdvDOoJaVHxurMsVaW
   T7tQcRFAMMeVYKhmbsA0aTOKpkmSOF3j1nu4VGqoHTX3G61SrZeYFXKSh
   DYTLHBY3Oup04isqhMogLg/NncIzXzJv8srIYFCp5BsU3y5mGjpuc5anb
   w==;
X-CSE-ConnectionGUID: RQfRJIj4R9efElKhrMK2GA==
X-CSE-MsgGUID: 20l1xXtwRYGQx+23c0fpAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12722395"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="12722395"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 21:49:09 -0700
X-CSE-ConnectionGUID: 3oZmcdehRZOKcu+JvDuGfQ==
X-CSE-MsgGUID: sj90S74QRxKOMGBXKBO72w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="27274801"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 17 Apr 2024 21:49:08 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxJhq-0007Ip-0X;
	Thu, 18 Apr 2024 04:49:06 +0000
Date: Thu, 18 Apr 2024 12:48:28 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 6376306adde5b252ee7c73572e35d13fb13f6f18
Message-ID: <202404181226.TyAjN2q6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 6376306adde5b252ee7c73572e35d13fb13f6f18  x86/retpolines: Enable the default thunk warning only on relevant configs

elapsed time: 741m

configs tested: 26
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240418   gcc  
i386         buildonly-randconfig-002-20240418   gcc  
i386         buildonly-randconfig-003-20240418   clang
i386         buildonly-randconfig-004-20240418   gcc  
i386         buildonly-randconfig-005-20240418   clang
i386         buildonly-randconfig-006-20240418   clang
i386                                defconfig   clang
i386                  randconfig-001-20240418   gcc  
i386                  randconfig-002-20240418   gcc  
i386                  randconfig-003-20240418   clang
i386                  randconfig-004-20240418   gcc  
i386                  randconfig-005-20240418   gcc  
i386                  randconfig-006-20240418   gcc  
i386                  randconfig-011-20240418   clang
i386                  randconfig-012-20240418   clang
i386                  randconfig-013-20240418   gcc  
i386                  randconfig-014-20240418   gcc  
i386                  randconfig-015-20240418   gcc  
i386                  randconfig-016-20240418   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

