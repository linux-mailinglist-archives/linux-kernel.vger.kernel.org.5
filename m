Return-Path: <linux-kernel+bounces-130535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF926897982
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7B81C272CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1070155720;
	Wed,  3 Apr 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqfV2Qed"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2311553B3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174655; cv=none; b=VMprWxIzoZDI1oL35O0kZWluxxGEOKdW+1ntHCmUhQUfdZWOYv2J8Ppi2VmEOahH05c+3/Hm2QH7RTPlIHr/HQooIOBMop/Dn+JwgIxgPr/PYBkc2srC5OoWZM1LAJkAzusy8uRGjUOYjdD/769eXP6/imWxp8YANJ/nOlpw0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174655; c=relaxed/simple;
	bh=wF7U7x9K9Z/wKx4iZTup87SVdrn838ErxQrQM8SGsDM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tg+1cYFzUxDKqqD3S/22V0/NlTgk2sV4V0Ij3YZ8sR3AGWWdKu30MNJUq5pf5fHmTeiJJ82LN6lRL65Lr3bYJjXwLxyN1cZCc8Hf/F4lxxvL0V7XtygivyG8+y7/RTpuTRy9kZwPaaDCrVqP7GWPmqdTaafG5WFpOWosncgWpIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqfV2Qed; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712174653; x=1743710653;
  h=date:from:to:cc:subject:message-id;
  bh=wF7U7x9K9Z/wKx4iZTup87SVdrn838ErxQrQM8SGsDM=;
  b=hqfV2Qedqm618iD3QAHkVn0iJd8JL4e48N/XfZ1EASDF+/McVB4UulA1
   V9OtymBxp0rgxpbrPMiPauC2QI4d2RQag/9lqHzHkH1sqBdwljciJ9+zo
   sQrtY5kFQdH0AQm45uJQy5ETWc4+bBNntK6/PCMU5J4IT4Cqf5JwaNCmY
   3tPgvd+oRxJlJvndQ96s+O51rHYCOp0Gt2wVLK4HKUz10YPBmmIyP8WKj
   KOOziB/2x/xIJppBTus2esf5n4Afg0Fl4AStbWq/bglR11hxWb+clncqA
   yDuV6bFQyJyV+sGeOAQOlunR4psSdCkzLktgHIQqTx2QEFVdp/3POIXpe
   g==;
X-CSE-ConnectionGUID: wwbTJGQaQ2+s7B8PkfaOcg==
X-CSE-MsgGUID: +O+CCptkTsaHxtrY7r5vVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18163994"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18163994"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:04:12 -0700
X-CSE-ConnectionGUID: 4IjEd5wxR9iSmDxE7G15pQ==
X-CSE-MsgGUID: c3k93EGmRIC5/mx1/4zr7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18658665"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 03 Apr 2024 13:04:12 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rs6q9-0000Bq-1A;
	Wed, 03 Apr 2024 20:04:09 +0000
Date: Thu, 04 Apr 2024 04:03:20 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 9794563d4d053b1b46a0cc91901f0a11d8678c19
Message-ID: <202404040419.IZPdWBy8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 9794563d4d053b1b46a0cc91901f0a11d8678c19  perf/x86/amd: Don't reject non-sampling events with configured LBR

elapsed time: 731m

configs tested: 47
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
x86_64       buildonly-randconfig-001-20240404   gcc  
x86_64       buildonly-randconfig-002-20240404   gcc  
x86_64       buildonly-randconfig-003-20240404   gcc  
x86_64       buildonly-randconfig-004-20240404   clang
x86_64       buildonly-randconfig-005-20240404   clang
x86_64       buildonly-randconfig-006-20240404   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240404   clang
x86_64                randconfig-002-20240404   gcc  
x86_64                randconfig-003-20240404   clang
x86_64                randconfig-004-20240404   gcc  
x86_64                randconfig-005-20240404   gcc  
x86_64                randconfig-006-20240404   gcc  
x86_64                randconfig-011-20240404   clang
x86_64                randconfig-012-20240404   clang
x86_64                randconfig-013-20240404   clang
x86_64                randconfig-014-20240404   clang
x86_64                randconfig-015-20240404   gcc  
x86_64                randconfig-016-20240404   gcc  
x86_64                randconfig-071-20240404   gcc  
x86_64                randconfig-072-20240404   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

