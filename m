Return-Path: <linux-kernel+bounces-137868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F6589E899
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C077D1C217D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341ACBE62;
	Wed, 10 Apr 2024 03:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ds8d+PZi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0020EB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712721156; cv=none; b=tseu4RjLlVuoCDnJKCtoDDesG33iHpb6FIpjTr/R6NB+FlAav6eoJI6t3ab1Ld6Sc1tN8IivCMER/LYTzY6pRcNUPM+SgubHnClCpFW43PrwQJQHiLX5vtkolz9/ZB+ovkVi8/+ROrPEXYPA/OVuppVVzLyuLA+GRtaNthTw8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712721156; c=relaxed/simple;
	bh=TBmvAyavlMrXYjppcFN7SlkWkVZLo3siETk+87ZCtc4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e8SfOMTIfa37KGa1HtQ8bmWKz9C4FoVjTBgOA2RPulwhUeet6PB23vxwqYGP5lwW9OLVMUhvSvSs/jO2PTKkO4fW3YR6QrfOkvp8feJe4/LyeIp7oJxezT+Ie522+L5CuLFG5EVy1AiJ/WLdhFdHPFlspPqZNFMbuzWCsOTQRkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ds8d+PZi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712721155; x=1744257155;
  h=date:from:to:cc:subject:message-id;
  bh=TBmvAyavlMrXYjppcFN7SlkWkVZLo3siETk+87ZCtc4=;
  b=Ds8d+PZi+4ETyK9w/iwZJvx1Wxhoc5ikjAclMzAwiw0Nr3vEyPKhkmR5
   0cI3p69DMRETfOnBMh8ljbotvrJfeyh+AfQqB7rdTNvUmqR0bT5hOgvDK
   fJ+g26GzegvfYMFgBhShNK6TBUKIL/Y0Hoh2lXF49z6mvwQUQshgHT1mI
   i0Ij88YKyc98q4AO4ARyjBf5WB+zLBG2CwP/Gl/mk4spseT1NDnNEDmpk
   QKXqbHGHdI6c5d01ZUBku8y7f51wKAhYFxxjPJ5Drf97RdGRMeCrnnQjC
   vIdina18XIPF38uZlZIbozpWPVF50HQa9030+trUqbU3uBNWV3XSQzikQ
   A==;
X-CSE-ConnectionGUID: 5ibNw4utSzOPR7owyW7cyA==
X-CSE-MsgGUID: TZxpdVM9R4e8cEae0iI9Pg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18630890"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18630890"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 20:52:34 -0700
X-CSE-ConnectionGUID: qh5jgO7rQsK7i4doKXWXaA==
X-CSE-MsgGUID: /MG/GfS9SruhA/oowz+jYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20451303"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Apr 2024 20:52:33 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ruP0h-0006lm-0D;
	Wed, 10 Apr 2024 03:52:31 +0000
Date: Wed, 10 Apr 2024 11:52:25 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 53bc516ade85a764edef3d6c8a51e880820e3d9d
Message-ID: <202404101123.RrL4MRkh-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 53bc516ade85a764edef3d6c8a51e880820e3d9d  x86/msr: Move ARCH_CAP_XAPIC_DISABLE bit definition to its rightful place

elapsed time: 727m

configs tested: 12
configs skipped: 134

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
i386                                defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

