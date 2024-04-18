Return-Path: <linux-kernel+bounces-150836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D078AA56E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A210E1C2163C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2CF199EA8;
	Thu, 18 Apr 2024 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kz/WvXvc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52A4168B06
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713478991; cv=none; b=HL3iUnIEuR9KOUJZWLoxfYY7BPPoBlJ+KTHQXcNJxz9Bm5VvWRel2lgTxcGTfQjUqdJGOLTMoNNAL+dy/S4pqMBHsXFBht3aGVoLvq7KJYAkyO1t/e3a2Ymf/+QZtko00GY01I/IBG1IM+JseG3OL2JmEDmcXPUqXr96xbZ8Ikc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713478991; c=relaxed/simple;
	bh=rME2M1BW0HkXH+YOIcsB1IRnX5Subk1RiBAgHobBrEc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vBvcVNn31H/JOfMWrll4vK0ffza1Wbx28KYl0sRDjq77vXS6cUMnNs/mpPXIi8JfotbOhBtRzPqOyhwqVGJBjEOCgX9M0TFDLq0XdsNtxTT6lXb7Ha7I8JOzbwNxkD90TNhrx2aTiRpEK5iNdgf4HgaTBTkdMfDw3x3PgvaEw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kz/WvXvc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713478990; x=1745014990;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rME2M1BW0HkXH+YOIcsB1IRnX5Subk1RiBAgHobBrEc=;
  b=kz/WvXvceSTmiDUQxmdLESGXnLhuFD5U9opzl2mf2hUmKTjRvIteHa+n
   MwMAf2o/M3I6079dJ/v0cb+flFV0f8EHrLBQVD5dZi6WOzickeA70KQvF
   ogGxjbKhtI3rj1OH0Xljv5X7G0itpLHi2OjxSsuEiRqBODCPMwvjjAYLq
   /VNxFG93SR1iUGpK32kedMhK1VPtkHykq0Z7tBu9mlWpV/fhpmAOshKVl
   Lxlyhcblxn0oIdLd8S5El8s3vWV0j7fCLk09XCBNZ35uKzriK61Dv2OoE
   lS1ZPm475g4eCHcZ0X7yCdK/zgLI8cOIQzFrDBhtvtLsuFxTayuyl/DTA
   w==;
X-CSE-ConnectionGUID: mXvmTCIqRfGBed+gRPa07g==
X-CSE-MsgGUID: rbTAZCM8Q2muxsPIV/DLwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12003810"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="12003810"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 15:23:09 -0700
X-CSE-ConnectionGUID: MK9xO/JDR3ehOh2obXR5uA==
X-CSE-MsgGUID: dnHSfm8vTDOTRoc9YREVwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="60562017"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 18 Apr 2024 15:23:07 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxa9p-0009I2-0A;
	Thu, 18 Apr 2024 22:23:05 +0000
Date: Fri, 19 Apr 2024 06:22:46 +0800
From: kernel test robot <lkp@intel.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data23' from
 `kernel/ptrace.o' being placed in section `.bss..Lubsan_data23'
Message-ID: <202404190642.z54cLsGE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2668e3ae2ef36d5e7c52f818ad7d90822c037de4
commit: 5284984a4fbacb0883bfebe905902cdda2891a07 bug: Fix no-return-statement warning with !CONFIG_BUG
date:   8 days ago
config: powerpc-randconfig-r033-20211126 (https://download.01.org/0day-ci/archive/20240419/202404190642.z54cLsGE-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240419/202404190642.z54cLsGE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404190642.z54cLsGE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data23' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data23'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data18' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data18'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data23' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data23'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data18' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data18'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data23' from `kernel/ptrace.o' being placed in section `.bss..Lubsan_data23'
   powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data18' from `drivers/cxl/core/port.o' being placed in section `.bss..Lubsan_data18'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

