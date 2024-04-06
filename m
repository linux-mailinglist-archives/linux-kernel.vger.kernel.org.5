Return-Path: <linux-kernel+bounces-133887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C42689AA4E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38591F21B62
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE532561D;
	Sat,  6 Apr 2024 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Quk6eXg0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631F81C69E
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712398653; cv=none; b=rQewWUJHvWzQ4tn27Ea+3tLWM19qdj+LRQV1B+13riAvtrPs8sAU0NcsByBo/CgsPvOI53ylJ6Cp8ehae4seMcwI3QJ144L+v15mTciTJ0GgdTIXaRRs4kABaCKSPf7zUSHXO/Gn4wLkcXQKMTFlOaSFbd3oNsxyFmV0uAXNp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712398653; c=relaxed/simple;
	bh=47wmldWy9W+CT7uc8Qu5UQCGSachdUOnlEj8ghBDVmM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=t41d6sTi5r9fPm8S2I/vzpgSiCuvpsWvHFv2wYLp2VpW9Xn8F9tHUU59uZ1wjTkId5a+Ongl22lDFaYVgdogJ5RnZH+k9Gg4Mrz+Ne1PjEAheCIOl9eTHGW7Sf7SAf30RLIz8G4ffxqsjcyjGhGqR7Rtvot6lGFQdDfx9kwndqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Quk6eXg0; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712398652; x=1743934652;
  h=date:from:to:cc:subject:message-id;
  bh=47wmldWy9W+CT7uc8Qu5UQCGSachdUOnlEj8ghBDVmM=;
  b=Quk6eXg0MM1XvSS7vbDND3rwduYpTXY+B+wtXkzskpZXYM8JImXIrNe1
   hFNJyJP6xUA42b4Q72tNMgvrqK/6jNw0UDp0jZGjs2yPjmKfi87qN5/Id
   6MRSwad+QJcx5Wx1akAPB7gh1Erjbd84RD6/ELoNHXVFfLjRGTXYFB6nb
   4Want3FTCiA4u4y89IjF/6HAw3epq2ECdhWdMOCBugXBjQwXRCEpHQhiI
   0FBzB9HCYn9TaeAiNF3HUMbR7hwimybik1xynWPb/cuxy3BWDl4QRbR3s
   jnVx8IbQFURVEaqdqm/4ki93biBhHm7fGZ0o0Kh7dd+NTydvRp5AX/ttS
   g==;
X-CSE-ConnectionGUID: PdkSw1RCTyebyyx/lY/aCA==
X-CSE-MsgGUID: BnDXu/3IR6u98MFVcPHHRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7586013"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7586013"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 03:17:31 -0700
X-CSE-ConnectionGUID: /ZuDlKmTTWOD/ofeJLSSbA==
X-CSE-MsgGUID: Jhai1cHpTtOPv53gGzjGNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19845407"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 06 Apr 2024 03:17:30 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rt371-0003N6-2H;
	Sat, 06 Apr 2024 10:17:27 +0000
Date: Sat, 06 Apr 2024 18:17:12 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ab346a37d39324c48e1e1555275eca44b816f95a
Message-ID: <202404061810.wnxkUgWd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: ab346a37d39324c48e1e1555275eca44b816f95a  Merge x86/microcode into tip/master

elapsed time: 725m

configs tested: 8
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                                defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

