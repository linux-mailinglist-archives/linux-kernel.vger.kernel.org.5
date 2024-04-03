Return-Path: <linux-kernel+bounces-129138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0558965A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D9C283A6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C355C29;
	Wed,  3 Apr 2024 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRLOn+N0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FE5478B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128260; cv=none; b=q2xYaq3nu+FH2gUTDyOq41xqww5wBQs7JnX9RsMY97nacPLmoQ+cTELjE1ydLDKRvJbzQjsaJxpMxqS4ZvRadPA9A2Q9JL3xHHvVFnGQpHB4xT4nJx9ymLxFGVgJnIu9HCWDo1EiqBeyH33oIaEPNuQL2BcNCicJvv0VE4msVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128260; c=relaxed/simple;
	bh=np/AiF/9vL6rQ3Q8mpDgxD1vsHgaz45fDfoGbRUWh9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FPiapxWducJyRghxHcNmkAHssJCactv997DboLcr+PJc+1b3E36nRbjItXsJHb7ioJu6yVwzzC8Ud8wLD5dye+T0LfnyWUiGsNdJqLaqJ25MVGaayV/yfsVQ0KySfcLIOaU8FYMa2/7CmER5XhtpamPv3t4hje2+SjoOLlGSzb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRLOn+N0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712128258; x=1743664258;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=np/AiF/9vL6rQ3Q8mpDgxD1vsHgaz45fDfoGbRUWh9c=;
  b=DRLOn+N0f0A/3k389BoVFI9fDRzpaTme6li4joyeIwus+dL/7z9TE56a
   y9mUZjFRt1e//nRR6P5BK0wjbJr9GkcROKwSYEizFgJE0kQRwUbWF0AeF
   Jzw4U2qRAq+8aSvp+svfqCt9rwFPTnO/mPfpOUfe1yS18NjCz20kHaItc
   aI4XMlb5KXCGyjyKoeR87VxztfuCxAsllQRxLw/GJn4q5P7UC88BjJCub
   qcjmE9VqMXZJCnzfoJlexZNGUKv3lUiTtv+dxZ6a1EoP2q0TijpIbjWm4
   q2qdo3vPl1n1wirbozbaM67JgEuBZu6cDNHMfo2qGVgrnAH3en2+3DSAf
   A==;
X-CSE-ConnectionGUID: a9igDPAeRuq1rKUe0WPSmg==
X-CSE-MsgGUID: 0u+d3sv+TraszEuwq3ZCNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7563077"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7563077"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 00:10:56 -0700
X-CSE-ConnectionGUID: m3ZlSvliR1is06pagRpBhQ==
X-CSE-MsgGUID: Tvo0eGZhQCqsgqx3qQPKHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22972223"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 03 Apr 2024 00:10:55 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rrulo-0001y9-2a;
	Wed, 03 Apr 2024 07:10:52 +0000
Date: Wed, 3 Apr 2024 15:10:50 +0800
From: kernel test robot <lkp@intel.com>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: arch/xtensa/include/asm/irqflags.h:61:(.xiptext+0x6fc): dangerous
 relocation: windowed longcall crosses 1GB boundary; return may fail:
 remove_wait_queue
Message-ID: <202404031510.2si9iKSh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e92c1e6cd876754b64d1998ec0a01800ed954a6
commit: fbaa6a181a4b1886cbf4214abdf9a2df68471510 sched/core: Remove ifdeffery for saved_state
date:   7 months ago
config: xtensa-randconfig-r005-20220823 (https://download.01.org/0day-ci/archive/20240403/202404031510.2si9iKSh-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240403/202404031510.2si9iKSh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404031510.2si9iKSh-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/chips/cfi_cmdset_0002.c:2379:(.text+0x677f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_qry_mode_on
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `cfi_amdstd_panic_write':
   include/linux/mtd/map.h:360:(.text+0x6894): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_qry_mode_off
   drivers/mtd/chips/cfi_cmdset_0002.o:(.xiptext+0xa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.o:(.xiptext+0x1f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   drivers/mtd/chips/cfi_cmdset_0002.o:(.xiptext+0x2c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o:(.xiptext+0x36): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_buffer_reset':
   drivers/mtd/chips/cfi_cmdset_0002.c:1997:(.xiptext+0x44): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1997:(.xiptext+0x5b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2006:(.xiptext+0x64): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2006:(.xiptext+0x6e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2006:(.xiptext+0x7a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2006:(.xiptext+0x8e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2006:(.xiptext+0x96): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2008:(.xiptext+0xa0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2008:(.xiptext+0xaa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2008:(.xiptext+0xbf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:2008:(.xiptext+0xc5): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   drivers/mtd/chips/cfi_cmdset_0002.c:2010:(.xiptext+0xf2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:2014:(.xiptext+0x107): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   drivers/mtd/chips/cfi_cmdset_0002.c:2014:(.xiptext+0x110): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2014:(.xiptext+0x11f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2014:(.xiptext+0x136): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:2014:(.xiptext+0x147): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:2014:(.xiptext+0x157): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_enable':
   drivers/mtd/chips/cfi_cmdset_0002.c:1031:(.xiptext+0x166): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1031:(.xiptext+0x177): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1032:(.xiptext+0x18a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1034:(.xiptext+0x197): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1034:(.xiptext+0x1a4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1034:(.xiptext+0x1b5): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: trace_hardirqs_on
   drivers/mtd/chips/cfi_cmdset_0002.c:1034:(.xiptext+0x1be): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x296): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x2bb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x2c4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x2d3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x2e4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x31a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x32e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x340): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x353): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x367): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x376): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x388): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x397): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x3bf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x3cf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x3fb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x40a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x417): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x422): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1041:(.xiptext+0x42f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   drivers/mtd/chips/cfi_cmdset_0002.c:1058:(.xiptext+0x43e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1058:(.xiptext+0x457): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1058:(.xiptext+0x466): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1059:(.xiptext+0x47a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1061:(.xiptext+0x487): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1061:(.xiptext+0x493): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1067:(.xiptext+0x4a3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1067:(.xiptext+0x4b4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1067:(.xiptext+0x4c6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1067:(.xiptext+0x4d7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1067:(.xiptext+0x4e6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1067:(.xiptext+0x4f4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1067:(.xiptext+0x503): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write1
   drivers/mtd/chips/cfi_cmdset_0002.c:1067:(.xiptext+0x51a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1080:(.xiptext+0x52b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1080:(.xiptext+0x53e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1080:(.xiptext+0x54d): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: trace_hardirqs_on
   drivers/mtd/chips/cfi_cmdset_0002.c:1082:(.xiptext+0x55f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1067:(.xiptext+0x56e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __might_resched
   drivers/mtd/chips/cfi_cmdset_0002.c:1067:(.xiptext+0x574): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __cond_resched
   drivers/mtd/chips/cfi_cmdset_0002.c:1067:(.xiptext+0x57e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1135:(.xiptext+0x586): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1084:(.xiptext+0x5aa): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1084:(.xiptext+0x5b7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1091:(.xiptext+0x5c6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1084:(.xiptext+0x5d3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1094:(.xiptext+0x603): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write_range
   drivers/mtd/chips/cfi_cmdset_0002.c:1094:(.xiptext+0x61b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1094:(.xiptext+0x626): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1094:(.xiptext+0x632): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1098:(.xiptext+0x647): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:1098:(.xiptext+0x650): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1098:(.xiptext+0x662): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1098:(.xiptext+0x676): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:1098:(.xiptext+0x67f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1098:(.xiptext+0x68f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1100:(.xiptext+0x6a3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: ftrace_likely_update
   drivers/mtd/chips/cfi_cmdset_0002.c:1101:(.xiptext+0x6ab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1101:(.xiptext+0x6ba): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1102:(.xiptext+0x6ca): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1102:(.xiptext+0x6d4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_volatile_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1102:(.xiptext+0x6e3): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: add_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.c:1103:(.xiptext+0x6eb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1103:(.xiptext+0x6f1): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: schedule
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
>> arch/xtensa/include/asm/irqflags.h:61:(.xiptext+0x6fc): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: remove_wait_queue
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   drivers/mtd/chips/cfi_cmdset_0002.c:1106:(.xiptext+0x706): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_lock_nested
   drivers/mtd/chips/cfi_cmdset_0002.c:1108:(.xiptext+0x70e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1117:(.xiptext+0x72f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   arch/xtensa/include/asm/irqflags.h:47:(.xiptext+0x73e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   drivers/mtd/chips/cfi_cmdset_0002.c:1127:(.xiptext+0x74a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: trace_hardirqs_off
   drivers/mtd/chips/cfi_cmdset_0002.c:1098:(.xiptext+0x75b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1098:(.xiptext+0x76a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   arch/xtensa/include/asm/thread_info.h:97:(.xiptext+0x78e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0xde0)
   arch/xtensa/include/asm/thread_info.h:97:(.xiptext+0x796): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   drivers/mtd/chips/cfi_cmdset_0002.c:1118:(.xiptext+0x7ab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1118:(.xiptext+0x7c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1118:(.xiptext+0x7cf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x7e7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x7f4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x804): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x81e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x82b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   arch/xtensa/include/asm/current.h:24:(.xiptext+0x857): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `xip_udelay':
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x864): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x86e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   drivers/mtd/chips/cfi_cmdset_0002.c:1119:(.xiptext+0x87f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __stack_chk_fail
   drivers/mtd/chips/cfi_cmdset_0002.c:1117:(.xiptext+0x8c6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1127:(.xiptext+0x8de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   drivers/mtd/chips/cfi_cmdset_0002.c:1127:(.xiptext+0x8f2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1127:(.xiptext+0x900): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1127:(.xiptext+0x90e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1127:(.xiptext+0x91b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1081:(.xiptext+0x92e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1130:(.xiptext+0x938): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1132:(.xiptext+0x946): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1133:(.xiptext+0x95b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1134:(.xiptext+0x964): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1135:(.xiptext+0x96e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1135:(.xiptext+0x97a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1135:(.xiptext+0x98e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1135:(.xiptext+0x996): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1135:(.xiptext+0x9a0): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1143:(.xiptext+0x9ac): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1144:(.xiptext+0x9c2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1144:(.xiptext+0x9ca): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1144:(.xiptext+0x9d4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1145:(.xiptext+0x9de): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1145:(.xiptext+0x9f2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1144:(.xiptext+0x9fb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1144:(.xiptext+0xa0e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xa22): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xa2f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xa3b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xa5a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xa67): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xa73): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xa80): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xa8f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xa9c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xab7): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xac4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xad2): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: (.text+0x2800)
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xadb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: mutex_unlock
   drivers/mtd/chips/cfi_cmdset_0002.c:1146:(.xiptext+0xae1): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_exit
   drivers/mtd/chips/cfi_cmdset_0002.o: in function `do_write_oneword_done':
   drivers/mtd/chips/cfi_cmdset_0002.c:1739:(.xiptext+0xb3e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: _mcount
   drivers/mtd/chips/cfi_cmdset_0002.c:1293:(.xiptext+0xb53): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_func_entry
   drivers/mtd/chips/cfi_cmdset_0002.c:1293:(.xiptext+0xb5c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1295:(.xiptext+0xb68): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1295:(.xiptext+0xb76): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_cmdset_0002.c:1295:(.xiptext+0xb8a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read1
   drivers/mtd/chips/cfi_cmdset_0002.c:1297:(.xiptext+0xb9e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1297:(.xiptext+0xbab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1297:(.xiptext+0xbbf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_build_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1297:(.xiptext+0xbca): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1299:(.xiptext+0xbd4): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1299:(.xiptext+0xbdf): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1299:(.xiptext+0xbf6): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: cfi_send_gen_cmd
   drivers/mtd/chips/cfi_cmdset_0002.c:1299:(.xiptext+0xbff): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1301:(.xiptext+0xc22): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1301:(.xiptext+0xc2f): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1304:(.xiptext+0xc3b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1739:(.xiptext+0xc4e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1304:(.xiptext+0xc6a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1304:(.xiptext+0xc7b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1304:(.xiptext+0xc8c): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1304:(.xiptext+0xc9e): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1304:(.xiptext+0xcab): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1743:(.xiptext+0xcbe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1743:(.xiptext+0xccb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1743:(.xiptext+0xcde): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1743:(.xiptext+0xceb): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1743:(.xiptext+0xcfe): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1744:(.xiptext+0xd0b): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1746:(.xiptext+0xd17): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1747:(.xiptext+0xd27): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4
   drivers/mtd/chips/cfi_cmdset_0002.c:1747:(.xiptext+0xd38): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_write4
   drivers/mtd/chips/cfi_cmdset_0002.c:1747:(.xiptext+0xd4a): dangerous relocation: windowed longcall crosses 1GB boundary; return may fail: __tsan_read4


vim +61 arch/xtensa/include/asm/irqflags.h

df9ee29270c11d David Howells 2010-10-07  57  
df9ee29270c11d David Howells 2010-10-07  58  static inline void arch_local_irq_enable(void)
df9ee29270c11d David Howells 2010-10-07  59  {
df9ee29270c11d David Howells 2010-10-07  60  	unsigned long flags;
df9ee29270c11d David Howells 2010-10-07 @61  	asm volatile("rsil %0, 0" : "=a" (flags) :: "memory");
df9ee29270c11d David Howells 2010-10-07  62  }
df9ee29270c11d David Howells 2010-10-07  63  

:::::: The code at line 61 was first introduced by commit
:::::: df9ee29270c11dba7d0fe0b83ce47a4d8e8d2101 Fix IRQ flag handling naming

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

