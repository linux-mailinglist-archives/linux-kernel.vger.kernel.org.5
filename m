Return-Path: <linux-kernel+bounces-134654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 123C389B47D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 00:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FE11C20CA4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 22:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C95444C81;
	Sun,  7 Apr 2024 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NScO18w9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC944C6C
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712528037; cv=none; b=tqhqjoDA9/es0mGqtKHBqHEy6YgUNoMRZtQSrmxywIzrzXNaWrCLIaAAQ8A79oJsA2lt2wyrgdHhi9jegHN4w+ZeIW0Ad8M8MHYKC3lsYd9APec5R7WqlgyzohQi4Gx3VCPEc6CIpxmZ/EdGqf0LdwQ1gDzMVfUdzaTftU9IulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712528037; c=relaxed/simple;
	bh=x/Rc5Mhf/RvF563oKNk4AXSBhOdW8dPV/uNLlIalkUs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gjbb3O5Xyp1kwnLBQe+r49hay8DXQG3ZG5gsVbD17J0ZrJPxZ3k9cl6DhvIX9EPNyBxCtdx920UYDtGi0QMV24pOH2s+HqQod7YY8Oe8iJXfFtxm38FUI4Pb0/Afh5p9qrNItONDevWq2mUZTG4GXSJyhnIikPlUU24h+l1FgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NScO18w9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712528034; x=1744064034;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x/Rc5Mhf/RvF563oKNk4AXSBhOdW8dPV/uNLlIalkUs=;
  b=NScO18w9BMyfwrOzP9Wf2JKfSwSQ4NsBXCC18L+MYI6/HpjqB2LjThGq
   ZoXLHfr2GwCdqB8MAk4Y2R2xKWiYwvP6Sbkv2luqbbLzeftmp1xEzEJLn
   PgQh9+nhpky2vQ08JU8iTBRv3LBCjKOyBF9tBQGAgFd6fWM6mf6MA2WFe
   FvxkMtXEEXaKAiDT69+2c8+KzyV4o9/jRKND61NfPB85TDFPPhstXJ2nO
   ar10VaKPReioo+y6AbTE4uHrX44t+fCPfxG2Gta+kD3/jKluiCfLCWZ/C
   kOod/9l9+o4pSljROrBSSDxX837UUHWR10pea5nKVh2YlXpVWZGxf/D6F
   w==;
X-CSE-ConnectionGUID: 6bGhFFYlTuC4L42oVZTc5g==
X-CSE-MsgGUID: QBeU+n7tQAC2lHPbXTy2Tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7651428"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="7651428"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 15:13:53 -0700
X-CSE-ConnectionGUID: UdeQr+1YQiq4oO4IVExypw==
X-CSE-MsgGUID: jQtx7fMaS/27fLnsIc8Ckg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="57156621"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 07 Apr 2024 15:13:52 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtalq-0004cs-0Z;
	Sun, 07 Apr 2024 22:13:50 +0000
Date: Mon, 8 Apr 2024 06:13:29 +0800
From: kernel test robot <lkp@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: vmlinux.o: warning: objtool: ovl_copy_up_tmpfile() falls through to
 next function MR_BuildRaidContext.cold()
Message-ID: <202404080619.ZMsN3kSk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fec50db7033ea478773b159e0e2efb135270e3b7
commit: c63e56a4a6523fcb1358e1878607d77a40b534bb ovl: do not open/llseek lower file with upper sb_writers held
date:   5 months ago
config: x86_64-buildonly-randconfig-r006-20211105 (https://download.01.org/0day-ci/archive/20240408/202404080619.ZMsN3kSk-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240408/202404080619.ZMsN3kSk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404080619.ZMsN3kSk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: ni_read_frame() falls through to next function ovl_copy_up_tmpfile.cold()
>> vmlinux.o: warning: objtool: ovl_copy_up_tmpfile() falls through to next function MR_BuildRaidContext.cold()
   vmlinux.o: warning: objtool: kvm_spurious_fault+0x1d: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret+0x99: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_debug+0x40: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_nmi+0xd2: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: poke_int3_handler+0x56: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: native_sched_clock+0x84: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mce_check_crashing_cpu+0xd: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_machine_check+0x68: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_machine_check+0x79: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: local_clock_noinstr+0x7f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_enter+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_nmi_exit+0x3f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x3f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x3a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_kernel_exit_state+0x27: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_kernel_enter_state+0x25: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_kernel_enter.constprop.0+0x21: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_kernel_exit.constprop.0+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_idle_enter+0x30: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: ct_nmi_enter+0x24: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: mwait_idle+0x2a: call to ftrace_likely_update() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

